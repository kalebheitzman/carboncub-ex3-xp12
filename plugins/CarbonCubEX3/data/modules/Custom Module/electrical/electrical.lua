include("datarefs.lua")
include("commands.lua")

function draw()

    -- stall warning
    cc_fuse_stall_ref = get(cc_fuse_stall)
    stallwarning_ref = get(stallwarning)
    if cc_fuse_stall_ref == 0 then
        set(stallwarning, 0)
    end
end
