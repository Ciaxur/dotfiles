package VolumeManip

import "time"

// Performance Data
type PerformanceData struct {
	SlowInterval  time.Duration // Slow Interval Speed (De-activated)
	FastInterval  time.Duration // Fast Interval Speed (Activated)
	Interval      time.Duration // Current Interval Speed
	Active        bool          // Active State
	Iterations    int           // Number of Iterations
	MaxIterations int           // Maximum number of Fast Interval Iterations
	PrevVol       int           // Previous Volume Value (Check for Change)
	PrevMute      bool          // Previous Mute State (Check for Change)
}

/**
 * Performance Data Method used to activate
 *   high speed intervals for obtaining volume
 *   information more frequently
 */
func (p *PerformanceData) Activate() {
	p.Active = true             // Activate Speed!
	p.Iterations = 0            // Reset Iteractions
	p.Interval = p.FastInterval // Set Fast Intervals
}

/**
 * Performance Data Method used to de-activate
 *   high speed intervals for less frequient data
 *   reads and calculations
 */
func (p *PerformanceData) Deactivate() {
	p.Active = false            // Deactivate Active Perfomance
	p.Iterations = 0            // Reset Iteration Counter
	p.Interval = p.SlowInterval // Restore Interval Check Speed
}

/**
 * Creates a New Performance Strucure Object
 * @param dInterval - Default De-activated Interval Speed
 * @param pInterval - Activated Interval Speed
 * @param maxIter - Maximum Iterations while Active
 */
func NewPerformanceInfo(dInterval, pInterval time.Duration, maxIter int) PerformanceData {
	p := PerformanceData{
		Interval:      dInterval,
		FastInterval:  pInterval,
		SlowInterval:  dInterval,
		MaxIterations: maxIter,
		Iterations:    0,
	}

	return p
}
