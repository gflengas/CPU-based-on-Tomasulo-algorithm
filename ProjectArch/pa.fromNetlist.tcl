
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ProjectArch -dir "C:/Xilinx/ProjectArch/planAhead_run_2" -part xc3s100ecp132-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Xilinx/ProjectArch/TopModule.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Xilinx/ProjectArch} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "TopModule.ucf" [current_fileset -constrset]
add_files [list {TopModule.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
