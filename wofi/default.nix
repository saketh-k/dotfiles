{config, pkgs, lib, ...}:
# Wofi configuration
{
  programs = {
    wofi = {
      enable = true;
      settings = ''
        color-window = #00000000
        color-normal = #ffffffff
        color-active = #ff555555
        color-active2 = #ff555555
        color-urgent = #ff555555
        color-urgent2 = #ff555555
        color-input = #ff555555
        
        # padding
        padding = 5
        
        # font
        font = "JetBrains Mono Medium 10"
        
        # lines
        lines = 10
        
        #
        key_expand=Tabcolor-window = "#00000000"
        '';
      style = ''
        /* Wofi CSS with Windows 95-inspired theme */
        
        /* General Window */
        #window {
            background-color: #c0c0c0; /* Classic Windows 95 gray */
            border: 2px solid #ffffff; /* Top-left bevel */
            border-left-color: #808080; /* Shadow for the left side */
            border-top-color: #808080; /* Shadow for the top */
            border-radius: 0; /* Sharp edges for retro style */
            padding: 8px;
            color: #000000; /* Black text */
            font-family: "MS Sans Serif", Arial, sans-serif; /* Classic Windows font */
            font-size: 12px;
        }
        
        /* Outer container */
        #outer-box {
            background-color: #c0c0c0;
            border: 2px solid #808080; /* Shadow bevel */
            border-right-color: #ffffff; /* Highlight for the right side */
            border-bottom-color: #ffffff; /* Highlight for the bottom */
            padding: 5px;
        }
        
        /* Search bar */
        #input {
            background-color: #ffffff; /* White input field */
            color: #000000; /* Black text */
            border: 2px solid #808080; /* Shadow bevel */
            border-right-color: #ffffff; /* Highlight for the right */
            border-bottom-color: #ffffff; /* Highlight for the bottom */
            padding: 4px;
            font-family: "MS Sans Serif", Arial, sans-serif;
            font-size: 12px;
        }
        
        /* Scroll container */
        #scroll {
            background-color: #c0c0c0;
            padding: 4px;
        }
        
        /* Entry items */
        #entry {
            background-color: #ffffff; /* White for entries */
            color: #000000; /* Black text */
            border: 2px solid #808080; /* Shadow bevel */
            border-right-color: #ffffff; /* Highlight for the right */
            border-bottom-color: #ffffff; /* Highlight for the bottom */
            margin: 4px 0;
            padding: 6px;
            font-family: "MS Sans Serif", Arial, sans-serif;
            font-size: 12px;
        }
        
        #entry:hover {
            background-color: #e0e0e0; /* Slightly darker gray on hover */
        }
        
        /* Selected entry */
        #entry:selected {
            background-color: #000080; /* Windows 95 blue highlight */
            color: #ffffff; /* White text for contrast */
        }
        
        /* Text within entries */
        #text {
            font-family: "MS Sans Serif", Arial, sans-serif;
            font-size: 12px;
        }
        
        /* Unselected entries */
        #unselected {
            opacity: 1;
        }
        
        /* Selected entries */
        #selected {
            opacity: 1;
        }
        
        /* Images in entries (image mode) */
        #img {
            border-radius: 0; /* Sharp edges */
            margin-right: 8px;
        }
        
        /* Inner box (entry container) */
        #inner-box {
            padding: 4px;
            border: 2px solid #808080; /* Shadow bevel */
            border-right-color: #ffffff; /* Highlight for the right */
            border-bottom-color: #ffffff; /* Highlight for the bottom */
        }
        
        /* Expander box (for entries with multiple actions) */
        #expander-box {
            background-color: #c0c0c0;
            border: 2px solid #808080; /* Shadow bevel */
            border-right-color: #ffffff; /* Highlight for the right */
            border-bottom-color: #ffffff; /* Highlight for the bottom */
            padding: 4px;
            margin-top: 4px;
        }
        
        /* Entry animations */
        @keyframes expand {
            from {
                opacity: 0;
                transform: scaleY(0.8);
            }
            to {
                opacity: 1;
                transform: scaleY(1);
            }
        '';
    };
  };
}
