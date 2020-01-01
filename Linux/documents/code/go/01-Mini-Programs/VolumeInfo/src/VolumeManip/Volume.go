package VolumeManip

import "fmt"

// Volume Information Structure
type VolumeInfo struct {
	ActiveIndex    int
	VolumePerc     int
	MutedState     bool
	BluetoothState bool
}

/**
 * Volume Info Method used to output all
 *   member variable information
 */
func (v *VolumeInfo) Print() {
	fmt.Printf("Active Index: %d\n", v.ActiveIndex)
	fmt.Printf("Volume: %d%%\n", v.VolumePerc)
	fmt.Printf("Muted: %v\n", v.MutedState)
	fmt.Printf("Bluetooth? %v\n", v.BluetoothState)
}

/**
 * Volume Info Method used to output data
 *   in a formatted structure
 */
func (v *VolumeInfo) Printf() {
	// SETUP EMOJI VARIABLES
	BLUE_I := ""  // Bluetooth Emoji
	MUTED_I := "" // Muted Emoji
	VOL0_I := ""  // Low Volume
	VOL1_I := ""  // Medium Volume
	VOL2_I := ""  // High Volume
	VOL_I := ""    // Active Volume Emoji

	// FIGURE OUT WHICH EMOJIS TO USE
	if v.MutedState == true { // Muted
		fmt.Printf("%%{F#EC7063}%v\n", MUTED_I) // Output right away
		return
	} else if v.BluetoothState == true { // Bluteooth
		VOL_I = BLUE_I
	} else if v.VolumePerc > 60 { // Volume 60+
		VOL_I = VOL2_I
	} else if v.VolumePerc > 35 { // Volume 35+
		VOL_I = VOL1_I
	} else { // Volume <35
		VOL_I = VOL0_I
	}

	// OUTPUT FORMATTED OUTPUT
	fmt.Printf("%v %%{F#CCC}%d%%\n", VOL_I, v.VolumePerc)
}
