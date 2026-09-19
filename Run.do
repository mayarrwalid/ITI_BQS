vlib work
vlog Controller.v Edge_Detector.v ROM.v UP_DOWN_Counter.v TOP_BQS.v SS_Decoder.v Verification_tb.v
vsim -voptargs=+acc work.Verification_tb
add wave *
run -all
#quit -sim