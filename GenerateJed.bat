set IST_INSTALL_PATH=C:\Xilinx\14.7\ISE_DS

set PATH=%IST_INSTALL_PATH%\ISE\bin\nt64;%PATH%

xst -intstyle ise -filter "D:/document/VHDL/xc_7segment/iseconfig/filter.filter" -ifn "D:/document/VHDL/xc_7segment/SP4_Octane.xst" -ofn "D:/document/VHDL/xc_7segment/SP4_Octane.syr" 
ngdbuild -filter "iseconfig/filter.filter" -intstyle ise -dd _ngo -uc src/SP4_Octane.ucf -p xc9572xl-VQ64-10 SP4_Octane.ngc SP4_Octane.ngd  
cpldfit -filter D:/document/VHDL/xc_7segment/iseconfig/filter.filter -intstyle ise -p xc9572xl-10-VQ64 -ofmt vhdl -optimize speed -htmlrpt -loc on -slew fast -init low -inputs 54 -pterms 25 -unused float -power std -terminate keeper SP4_Octane.ngd 
XSLTProcess -filter D:/document/VHDL/xc_7segment/iseconfig/filter.filter SP4_Octane_build.xml 
tsim -filter D:/document/VHDL/xc_7segment/iseconfig/filter.filter -intstyle ise SP4_Octane SP4_Octane.nga 
hprep6 -filter D:/document/VHDL/xc_7segment/iseconfig/filter.filter -s IEEE1149 -n SP4_Octane -i SP4_Octane 

