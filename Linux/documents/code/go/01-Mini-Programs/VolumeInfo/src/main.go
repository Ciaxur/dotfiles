package main

import (
	"os/exec"
	"regexp"
	"strconv"
	"strings"
	"time"

	. "./VolumeManip"
)

/**
 * Obtains Volume information and applied Performance
 *  data while obtaining data
 *
 * @param info - Volume Info Object Pointer that will be
 *  used to store volume information and keep track
 * @param pInfo - Performance Data used to efficiently
 *  obtain Volume Information
 */
func getInfo(info *VolumeInfo, pInfo *PerformanceData) {
	// HANDLE ERRORS
	cmdSuccess := false
	var out []byte
	var err error

	for cmdSuccess == false { // Retry till Success
		c := exec.Command("pacmd", "list-sinks", "2>", "/dev/null")
		out, err = c.Output()

		if err == nil {
			cmdSuccess = true
		} else {
			time.Sleep(2 * time.Second) // Retry in 2 Seconds
		}
	}

	// GET ACTIVE INDEX
	sOut := string(out)
	startI := strings.Index(sOut, "* index")            // Starting Index of "* index"
	endI := strings.Index(sOut[startI:], "\n")          // Index end of line from the active index
	arr := strings.Split(sOut[startI:startI+endI], " ") // Split Info into Array Form

	activeIndex, _ := strconv.Atoi(arr[len(arr)-1]) // Obtain Active Index

	// GET VOLUME INFO
	volI := strings.Index(sOut[startI:], "volume:") // Starting Index of Volume
	endI = strings.Index(sOut[startI+volI:], "\n")  // Index of End of Line from Volume
	// arr = strings.Split(sOut[startI+volI:startI+volI+endI], " ") // Split info into Array Form

	// using regex to find Percentage
	res := string(regexp.MustCompile(`[0-9]+%`).Find([]byte(sOut[startI+volI : startI+volI+endI])))
	volVal, _ := strconv.Atoi(res[:len(res)-1])

	// GET MUTED INFO
	mutedI := strings.Index(sOut[startI:], "muted")                  // Starting Index of "muted" property
	endI = strings.Index(sOut[startI+mutedI:], "\n")                 // End Index of line
	arr = strings.Split(sOut[startI+mutedI:startI+mutedI+endI], " ") // Split info into Array Form

	var mutedState bool
	if arr[1] == "yes" {
		mutedState = true
	}

	// GET BLUETOOTH STATE
	var bluetoothState bool
	if strings.Index(sOut[startI:], "bluetooth") != -1 { // Check if Bluetooth Found
		bluetoothState = true
	}

	// ASSIGN VALUES
	info.ActiveIndex = activeIndex
	info.VolumePerc = volVal
	info.MutedState = mutedState
	info.BluetoothState = bluetoothState

	// KEEP TRACK OF DATA FOR PERFORMANCE
	if pInfo.Active == true { // Keep track of Iterations on Performance
		pInfo.Iterations++
	}

	if pInfo.Iterations >= pInfo.MaxIterations && info.VolumePerc == pInfo.PrevVol { // No Change over time
		pInfo.Deactivate()
	} else if info.VolumePerc != pInfo.PrevVol || info.MutedState != pInfo.PrevMute { // Change in Volume!! Activate Performance
		pInfo.Activate()
	}

	// UPDATE DATA INFO
	pInfo.PrevVol = info.VolumePerc
	pInfo.PrevMute = info.MutedState
}

func main() {
	info := VolumeInfo{}
	perfInfo := NewPerformanceInfo(1*time.Second, 20*time.Millisecond, 40)

	for {
		getInfo(&info, &perfInfo)
		info.Printf()
		time.Sleep(perfInfo.Interval)
	}
}
