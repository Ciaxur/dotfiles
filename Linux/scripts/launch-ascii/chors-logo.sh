#!/bin/sh
# CHORS: Central Home Official Records


function drawEfti() {
  printf "*      ooo           ***           xxx           ((_           >X<       *\n"
  printf "*     (o o)         (o o)         (o o)         (o o)         (o o)      *\n"
  printf "* ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo- *\n"
}
function drawLine() {
  for ((i=0; i<74; i++)); do
    printf '*'
  done
  printf '\n'
}
function drawLogo() {
  printf "*      ___           ___           ___           ___           ___       * \n"
  printf "*     /\  \         /\__\         /\  \         /\  \         /\  \      * \n"
  printf "*    /::\  \       /:/  /        /::\  \       /::\  \       /::\  \     * \n"
  printf "*   /:/\:\  \     /:/__/        /:/\:\  \     /:/\:\  \     /:/\ \  \    * \n"
  printf "*  /:/  \:\  \   /::\  \ ___   /:/  \:\  \   /::\~\:\  \   _\:\~\ \  \   * \n"
  printf "* /:/__/ \:\__\ /:/\:\  /\__\ /:/__/ \:\__\ /:/\:\ \:\__\ /\ \:\ \ \__\  * \n"
  printf "* \:\  \  \/__/ \/__\:\/:/  / \:\  \ /:/  / \/_|::\/:/  / \:\ \:\ \/__/  * \n"
  printf "*  \:\  \            \::/  /   \:\  /:/  /     |:|::/  /   \:\ \:\__\    * \n"
  printf "*   \:\  \           /:/  /     \:\/:/  /      |:|\/__/     \:\/:/  /    * \n"
  printf "*    \:\__\         /:/  /       \::/  /       |:|  |        \::/  /     * \n"
  printf "*     \/__/         \/__/         \/__/         \|__|         \/__/      * \n"
}


drawLine
drawEfti
drawLine
drawLogo
drawLine
