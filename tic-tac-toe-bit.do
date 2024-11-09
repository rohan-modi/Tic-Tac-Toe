vlib work

vlog testTacToe.v

vsim TicTacToe

log {/*}

add wave {/*}


force {squareEntered} 0
force {userSquare} 0000

run 10ns

force {userSquare} 0000

run 10ns

force {userSquare} 0010
run 10ns
force {squareEntered} 1
run 10ns
force {squareEntered} 0
run 10ns

force {userSquare} 0100
run 10ns
force {squareEntered} 1
run 10ns
force {squareEntered} 0
run 10ns

force {userSquare} 0101
run 10ns
force {squareEntered} 1
run 10ns
force {squareEntered} 0
run 10ns

run 25ns

