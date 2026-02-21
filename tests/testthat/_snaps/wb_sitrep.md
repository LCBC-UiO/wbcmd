# wb_sitrep() / reports when wb not available

    Code
      result <- wb_sitrep()
    Message
      
      -- Connectome Workbench situation report ---------------------------------------
      
      -- Settings --
      
      x wb_command path: not set
      i Verbose: TRUE
      
      -- System --
      
      i Platform: "x86_64-pc-linux-gnu"
      i OS: "Ubuntu 22.04"
      i R: "4.4.0"
      
      -- Diagnostics --
      
      x wb_command not found
      
      -- Recommendations --
      
      ! Install Connectome Workbench from <https://www.humanconnectome.org/software/connectome-workbench>
      i Set the path with `set_wb_path()` or the `WB_PATH` environment variable.

# wb_sitrep() / reports when wb is available

    Code
      result <- wb_sitrep()
    Message
      
      -- Connectome Workbench situation report ---------------------------------------
      
      -- Settings --
      
      v wb_command path: '/fake/wb_command'
      i Source: "test"
      i Verbose: TRUE
      
      -- System --
      
      i Platform: "x86_64-pc-linux-gnu"
      i OS: "Ubuntu 22.04"
      i R: "4.4.0"
      
      -- Diagnostics --
      
      v wb_command found
      i Version: "1.5.0"
      
      -- Recommendations --
      
      v Everything looks good!

# wb_sitrep() / returns diagnostic information invisibly

    Code
      result <- wb_sitrep()
    Message
      
      -- Connectome Workbench situation report ---------------------------------------
      
      -- Settings --
      
      x wb_command path: not set
      i Verbose: TRUE
      
      -- System --
      
      i Platform: "x86_64-pc-linux-gnu"
      i OS: "Ubuntu 22.04"
      i R: "4.4.0"
      
      -- Diagnostics --
      
      x wb_command not found
      
      -- Recommendations --
      
      ! Install Connectome Workbench from <https://www.humanconnectome.org/software/connectome-workbench>
      i Set the path with `set_wb_path()` or the `WB_PATH` environment variable.

