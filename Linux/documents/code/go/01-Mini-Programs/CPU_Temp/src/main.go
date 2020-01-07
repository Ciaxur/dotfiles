package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"
)

// Simple CPU Temperature Information Strucutre
type TempInfo struct {
	packageTemp float64
	coreTemps   []float64
}

/**
 * Print all Temperature Information
 */
func (tInfo *TempInfo) print() {
	fmt.Printf("Package Temp [%.2f]\n", tInfo.packageTemp)
	for i := 0; i < len(tInfo.coreTemps); i++ {
		fmt.Printf("Core%d [%.2f]\n", i, tInfo.coreTemps[i])
	}
}

/**
 * Handle Error by Panicing
 */
func handleError(e error) {
	if e != nil {
		panic(e)
	}
}

/**
 * Parses Output into Object
 */
func parseOutput(output []byte, tInfo *TempInfo) {
	strOut := string(output)

	// GET PACKAGE SECTION
	index := strings.Index(strOut, "Package")
	endIndex := index + (strings.Index(strOut[index:], "Core"))
	pkgSection := strOut[index:endIndex]

	// // PACKAGE TEMP
	index += strings.Index(pkgSection, "input")
	endIndex = index + (strings.Index(strOut[index:], "\n"))
	tempArr := strings.Split(strOut[index:endIndex], " ")[1]
	val, e := strconv.ParseFloat(tempArr, 64)
	handleError(e)
	tInfo.packageTemp = val

	// // GET CORE TEMP SECTION
	foundAllCores := false
	var coreSection string
	tInfo.coreTemps = make([]float64, 0, 10) // Allocate 10 Spots

	for !foundAllCores {
		// GET SECTION
		index = endIndex + strings.Index(strOut[endIndex:], "Core")
		endIndex = index + strings.Index(strOut[index+1:], "Core")

		// VERIFY FOUND
		if endIndex > index {
			coreSection = strOut[index:endIndex] // Still More
		} else {
			coreSection = strOut[index:] // Found Last Core
			foundAllCores = true
		}

		// PARSE TEMP
		i1 := strings.Index(coreSection, "input")
		i2 := i1 + strings.Index(coreSection[i1:], "\n")
		temp, err := strconv.ParseFloat(strings.Split(coreSection[i1:i2], " ")[1], 64)
		handleError(err)

		// STORE TEMP
		tInfo.coreTemps = append(tInfo.coreTemps, temp)
	}
}

func main() {
	tempEmojis := []string{"", "", "", "", ""}
	var tempInfo TempInfo

	for {
		// RUN COMMAND TO GET INFO
		cmd := exec.Command("sensors", "-u")
		out, err := cmd.Output()

		if err != nil {
			fmt.Println("Command Error:", err.Error())
			os.Exit(1)
		}

		// PARSE DATA FROM INFO
		parseOutput(out, &tempInfo)

		// CHOOSE APPROPRIATE EMOJI
		tempStatusE := tempEmojis[0] // Temp < 40C
		switch val := tempInfo.packageTemp; {
		case val > 40 && val < 65:
			tempStatusE = tempEmojis[1]
		case val < 70:
			tempStatusE = tempEmojis[2]
		case val <= 90:
			tempStatusE = tempEmojis[3]
		case val > 90:
			tempStatusE = tempEmojis[4]
		}

		fmt.Printf("%s %%{F#FF}%.1f°C\n", tempStatusE, tempInfo.packageTemp)
		time.Sleep(5 * time.Second)

		// tempInfo.print()
		// println()
	}
}
