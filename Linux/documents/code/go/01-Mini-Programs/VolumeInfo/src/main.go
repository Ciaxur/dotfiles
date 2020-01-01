package main

import (
	"fmt"
	"os/exec"
	"regexp"
	"strconv"
	"strings"
	"time"
)

// GLOBAL INTERVAL FOR PERFORMANCE
type PerformanceData struct {
	slowInterval  time.Duration // Slow Interval Speed (De-activated)
	fastInterval  time.Duration // Fast Interval Speed (Activated)
	interval      time.Duration // Current Interval Speed
	active        bool          // Active State
	iterations    int           // Number of Iterations
	maxIterations int           // Maximum number of Fast Interval Iterations
	prevVol       int           // Previous Volume Value (Check for Change)
	prevMute      bool          // Previous Mute State (Check for Change)
}

func (p *PerformanceData) activate() {
	p.active = true             // Activate Speed!
	p.iterations = 0            // Reset Iteractions
	p.interval = p.fastInterval // Set Fast Intervals
}

func (p *PerformanceData) deactivate() {
	p.active = false            // Deactivate Active Perfomance
	p.iterations = 0            // Reset Iteration Counter
	p.interval = p.slowInterval // Restore Interval Check Speed
}

type VolumeInfo struct {
	activeIndex    int
	volumePerc     int
	mutedState     bool
	bluetoothState bool
}

// Outputs Data as Stored
func (v *VolumeInfo) print() {
	// DEBUG: Output Info
	fmt.Printf("Active Index: %d\n", v.activeIndex)
	fmt.Printf("Volume: %d%%\n", v.volumePerc)
	fmt.Printf("Muted: %v\n", v.mutedState)
	fmt.Printf("Bluetooth? %v\n", v.bluetoothState)
}

// Formates Data and Outputs them
func (v *VolumeInfo) printf() {
	// SETUP EMOJI VARIABLES
	BLUE_I := ""  // Bluetooth Emoji
	MUTED_I := "" // Muted Emoji
	VOL0_I := ""  // Low Volume
	VOL1_I := ""  // Medium Volume
	VOL2_I := ""  // High Volume
	VOL_I := ""    // Active Volume Emoji

	// FIGURE OUT WHICH EMOJIS TO USE
	if v.mutedState == true { // Muted
		fmt.Printf("%%{F#EC7063}%v\n", MUTED_I) // Output right away
		return
	} else if v.bluetoothState == true { // Bluteooth
		VOL_I = BLUE_I
	} else if v.volumePerc > 60 { // Volume 60+
		VOL_I = VOL2_I
	} else if v.volumePerc > 35 { // Volume 35+
		VOL_I = VOL1_I
	} else { // Volume <35
		VOL_I = VOL0_I
	}

	// OUTPUT FORMATTED OUTPUT
	fmt.Printf("%v %%{F#CCC}%d%%\n", VOL_I, v.volumePerc)
}

func getInfo(info *VolumeInfo, pInfo *PerformanceData) {
	c := exec.Command("pacmd", "list-sinks", "2>", "/dev/null")
	out, err := c.Output()

	if err != nil {
		panic(err)
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
	info.activeIndex = activeIndex
	info.volumePerc = volVal
	info.mutedState = mutedState
	info.bluetoothState = bluetoothState

	// KEEP TRACK OF DATA FOR PERFORMANCE
	if pInfo.active == true { // Keep track of Iterations on Performance
		pInfo.iterations++
	}

	if pInfo.iterations >= pInfo.maxIterations && info.volumePerc == pInfo.prevVol { // No Change over time
		pInfo.deactivate()
	} else if info.volumePerc != pInfo.prevVol || info.mutedState != pInfo.prevMute { // Change in Volume!! Activate Performance
		pInfo.activate()
	}

	// UPDATE DATA INFO
	pInfo.prevVol = info.volumePerc
	pInfo.prevMute = info.mutedState
}

/**
 * Creates a New Performance Strucure Object
 * @param dInterval - Default De-activated Interval Speed
 * @param pInterval - Activated Interval Speed
 * @param maxIter - Maximum Iterations while Active
 */
func newPerformanceInfo(dInterval, pInterval time.Duration, maxIter int) PerformanceData {
	p := PerformanceData{
		interval:      dInterval,
		fastInterval:  pInterval,
		slowInterval:  dInterval,
		maxIterations: maxIter,
		iterations:    0,
	}

	return p
}

func main() {
	info := VolumeInfo{}
	perfInfo := newPerformanceInfo(1*time.Second, 20*time.Millisecond, 40)

	for {
		getInfo(&info, &perfInfo)
		info.printf()
		time.Sleep(perfInfo.interval)
	}
}
