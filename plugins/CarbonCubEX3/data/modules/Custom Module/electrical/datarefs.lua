-- project datarefs
-- fuses
cc_fuse_ext = createGlobalPropertyf("cc_ex3/electrical/fuse_ext", 1.0)
cc_fuse_ems = createGlobalPropertyf("cc_ex3/electrical/fuse_ems", 1.0)
cc_fuse_start = createGlobalPropertyf("cc_ex3/electrical/fuse_start", 1.0)
cc_fuse_field = createGlobalPropertyf("cc_ex3/electrical/fuse_field", 1.0)
cc_fuse_alt = createGlobalPropertyf("cc_ex3/electrical/fuse_alt", 1.0)
cc_fuse_xpdr = createGlobalPropertyf("cc_ex3/electrical/fuse_xpdr", 1.0)
cc_fuse_gps = createGlobalPropertyf("cc_ex3/electrical/fuse_gps", 1.0)
cc_fuse_com = createGlobalPropertyf("cc_ex3/electrical/fuse_com", 1.0)
cc_fuse_backup = createGlobalPropertyf("cc_ex3/electrical/fuse_backup", 1.0)
cc_fuse_start2 = createGlobalPropertyf("cc_ex3/electrical/fuse_start2", 1.0)
cc_fuse_stall = createGlobalPropertyf("cc_ex3/electrical/fuse_stall", 1.0)
cc_fuse_trim = createGlobalPropertyf("cc_ex3/electrical/fuse_trim", 1.0)
cc_fuse_landing = createGlobalPropertyf("cc_ex3/electrical/fuse_landing", 1.0)

-- switches
cc_sw_trim_priority = createGlobalPropertyi("cc_ex3/switches/trim_priority", 1)

-- sim datarefs
stallwarning = globalProperty("sim/cockpit2/annunciators/stall_warning")
