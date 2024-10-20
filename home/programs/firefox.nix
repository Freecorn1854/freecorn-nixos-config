{pkgs, config, outputs, ...}: let
  # FireFox colors
  themeCorn = ''
    :root {
      --tab-active-bg-color: #${outputs.look.colors.prime};
      --tab-hover-bg-color: #${outputs.look.colors.accent};
      --tab-inactive-bg-color: #${outputs.look.colors.dark};
      --tab-active-fg-fallback-color: #FFFFFF;
      --tab-inactive-fg-fallback-color: #${outputs.look.colors.text};
      --urlbar-focused-bg-color: #${outputs.look.colors.dark};
      --urlbar-not-focused-bg-color: #${outputs.look.colors.dark};
      --toolbar-bgcolor: #${outputs.look.colors.dark} !important;
  '';
  themeAlt = ''
    :root {
      --tab-active-bg-color: #${outputs.look.colors.dark};
      --tab-hover-bg-color: #${outputs.look.colors.accent};
      --tab-inactive-bg-color: #${outputs.look.colors.prime};
      --tab-active-fg-fallback-color: #${outputs.look.colors.text};
      --tab-inactive-fg-fallback-color: #FFFFFF;
      --urlbar-focused-bg-color: #${outputs.look.colors.prime};
      --urlbar-not-focused-bg-color: #${outputs.look.colors.prime};
      --toolbar-bgcolor: #${outputs.look.colors.prime} !important;
  '';
  quteFoxCSS = ''
      --tab-font: '${outputs.look.fonts.main}';
      --urlbar-font: '${outputs.look.fonts.main}';

      /* try increasing if you encounter problems */
      --urlbar-height-setting: 24px;
      --tab-min-height: 20px !important;

      /* I don't recommend you touch this */
      --arrowpanel-menuitem-padding: 2px !important;
      --arrowpanel-border-radius: 0px !important;
      --arrowpanel-menuitem-border-radius: 0px !important;
      --toolbarbutton-border-radius: 0px !important;
      --toolbarbutton-inner-padding: 0px 2px !important;
      --toolbar-field-focus-background-color: var(--urlbar-focused-bg-color) !important;
      --toolbar-field-background-color: var(--urlbar-not-focused-bg-color) !important;
      --toolbar-field-focus-border-color: transparent !important;
    }

    /* --- General debloat ------------------------------ */

    /* bottom left page loading status or url preview */
    #statuspanel { display: none !important; }

    /* remove radius from right-click popup */
    menupopup, panel { --panel-border-radius: 0px !important; }
    menu, menuitem, menucaption { border-radius: 0px !important; }

    /* no large buttons in right-click menu */
    menupopup > #context-navigation { display: none !important; }
    menupopup > #context-sep-navigation { display: none !important; }

    /* --- Debloat navbar ------------------------------- */

    #back-button { display: none; }
    #forward-button { display: none; }
    #reload-button { display: none; }
    #stop-button { display: none; }
    #home-button { display: none; }
    #library-button { display: none; }
    #fxa-toolbar-menu-button { display: none; }
    /* empty space before and after the url bar */
    #customizableui-special-spring1, #customizableui-special-spring2 { display: none; }

    /* --- Style navbar -------------------------------- */

    /* remove padding between toolbar buttons */
    toolbar .toolbarbutton-1 { padding: 0 0 !important; }

    #urlbar-container {
      --urlbar-container-height: var(--urlbar-height-setting) !important;
      margin-left: 0 !important;
      margin-right: 0 !important;
      padding-top: 0 !important;
      padding-bottom: 0 !important;
      font-family: var(--urlbar-font, 'monospace');
      font-size: 14px;
    }

    #urlbar {
      --urlbar-height: var(--urlbar-height-setting) !important;
      --urlbar-toolbar-height: var(--urlbar-height-setting) !important;
      min-height: var(--urlbar-height-setting) !important;
      border-color: var(--lwt-toolbar-field-border-color, hsla(240,5%,5%,.25)) !important;
    }

    #urlbar-input {
      margin-left: 0.8em !important;
      margin-right: 0.4em !important;
    }

    #navigator-toolbox {
      border: none !important;
    }

    /* keep pop-up menus from overlapping with navbar */
    #widget-overflow { margin: 0 !important; }
    #appmenu-popup { margin: 0 !important; }
    #customizationui-widget-panel { margin: 0 !important; }
    #unified-extensions-panel { margin: 0 !important; }

    /* --- Unified extensions button -------------------- */

    /* make extension icons smaller */
    #unified-extensions-view {
      --uei-icon-size: 18px;
    }

    /* hide bloat */
    .unified-extensions-item-message-deck,
    #unified-extensions-view > .panel-header,
    #unified-extensions-view > toolbarseparator,
    #unified-extensions-manage-extensions {
      display: none !important;
    }

    /* add 3px padding on the top and the bottom of the box */
    .panel-subview-body {
      padding: 3px 0px !important;
    }

    #unified-extensions-view .unified-extensions-item-menu-button {
      margin-inline-end: 0 !important;
    }

    #unified-extensions-view .toolbarbutton-icon {
      padding: 0 !important;
    }

    .unified-extensions-item-contents {
      line-height: 1 !important;
      white-space: nowrap !important;
    }

    /* --- Debloat URL bar ------------------------------- */

    #identity-box { display: none; }
    #pageActionButton { display: none; }
    #pocket-button { display: none; }
    #urlbar-zoom-button { display: none; }
    #tracking-protection-icon-container { display: none !important; }
    #reader-mode-button{ display: none !important; }
    #star-button { display: none; }
    #star-button-box:hover { background: inherit !important; }

    /* Go to arrow button at the end of the urlbar when searching */
    #urlbar-go-button { display: none; }

    /* remove container indicator from urlbar */
    #userContext-label, #userContext-indicator { display: none !important;}

    /* --- Style tab toolbar ---------------------------- */

    #titlebar {
      --proton-tab-block-margin: 0px !important;
      --tab-block-margin: 0px !important;
    }

    #TabsToolbar, .tabbrowser-tab {
      max-height: var(--tab-min-height) !important;
      font-size: 14px !important;
      outline: none !important;
    }

    /* Change color of normal tabs */
    tab:not([selected="true"]) {
      background-color: var(--tab-inactive-bg-color) !important;
      color: var(--identity-icon-color, var(--tab-inactive-fg-fallback-color)) !important;
    }

    tab {
      font-family: var(--tab-font, monospace);
      border: none !important;
    }

    /* safari style tab width */
    .tabbrowser-tab[fadein] {
      max-width: 100vw !important;
      border: none
    }

    /* Hide close button on tabs */
    #tabbrowser-tabs .tabbrowser-tab .tab-close-button { display: none !important; }

    .tabbrowser-tab {
      /* remove border between tabs */
      padding-inline: 0px !important;
      /* reduce fade effect of tab text */
      --tab-label-mask-size: 1em !important;
      /* fix pinned tab behaviour on overflow */
      overflow-clip-margin: 0px !important;
    }

    /* Tab: selected colors */
    #tabbrowser-tabs .tabbrowser-tab[selected] .tab-content {
      background: var(--tab-active-bg-color) !important;
      color: var(--identity-icon-color, var(--tab-active-fg-fallback-color)) !important;
    }

    /* Tab: hovered colors */
    #tabbrowser-tabs .tabbrowser-tab:hover:not([selected]) .tab-content {
      background: var(--tab-hover-bg-color) !important;
    }

    /* hide window controls */
    .titlebar-buttonbox-container { display: none; }

    /* remove titlebar spacers */
    .titlebar-spacer { display: none !important; }

    /* disable tab shadow */
    #tabbrowser-tabs:not([noshadowfortests]) .tab-background:is([selected], [multiselected]) {
      box-shadow: none !important;
    }

    /* remove dark space between pinned tab and first non-pinned tab */
    #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs]) >
    #tabbrowser-arrowscrollbox >
    .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) {
      margin-inline-start: 0px !important;
    }

    /* remove dropdown menu button which displays all tabs on overflow */
    #alltabs-button { display: none !important }

    /* fix displaying of pinned tabs on overflow */
    #tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container {
      height: var(--tab-min-height) !important;
    }

    /* remove overflow scroll buttons */
    #scrollbutton-up, #scrollbutton-down { display: none !important; }

    /* remove new tab button */
    #tabs-newtab-button {
      display: none !important;
    }

    /* --- Hide tab bar on single tab ------------------- */

    #tabbrowser-tabs .tabbrowser-tab:only-of-type,
    #tabbrowser-tabs .tabbrowser-tab:only-of-type + #tabbrowser-arrowscrollbox-periphery{
      display:none !important;
    }
    #tabbrowser-tabs, #tabbrowser-arrowscrollbox {min-height:0!important;}
    #alltabs-button {display:none !important;}

    /* --- Prevent tab folding -------------------------- */

    .tabbrowser-tab {
      min-width: initial !important;
    }
    .tab-content {
      overflow: hidden !important;
    }
  '';
in {
  # Enable Librewolf and extensions
  programs.firefox = let
    commonSearch = {
      force = true;
      default = "Google";
      engines = {
        "Google" = {
          urls = [
            {
              template = "https://www.google.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@g"];
        };
        "NixPKGs" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@pkgs"];
        };
      };
    };
    commonSettings = {
      "font.name.serif.x-western" = "${outputs.look.fonts.main}";
      "font.name.sans-serif.x-western" = "${outputs.look.fonts.main}";
      "font.name.monospace.x-western" = "${outputs.look.fonts.nerd}";
      "general.autoScroll" = true;
      "browser.compactmode.show" = true;
      "browser.uidensity" = 1;
      "browser.startup.page" = 3;
      "extensions.pocket.enabled" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "media.hardware-video-decoding.force-enabled" = true;
      "svg.context-properties.content.enabled" = true;
      "toolkit.tabbox.switchByScrolling" = true;
      "device.sensors.motion.enabled" = false;
      "extensions.autoDisableScopes" = 0;
      "gnomeTheme.hideSingleTab" = true;
      "browser.contentblocking.category" = "strict";
      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
      "network.cookie.sameSite.noneRequiresSecure" = true;
      "browser.helperApps.deleteTempFileOnExit" = true;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.globalprivacycontrol.functionality.enabled" = true;
      "webgl.disabled" = false;
    };
  in {
    enable = true;
    package = pkgs.firefox;
    profiles = {
      Freecorn = {
        id = 0;

        search = commonSearch;
        settings = commonSettings;
        userChrome = ''
          ${themeCorn}
          ${quteFoxCSS}
        '';
      };
      Alt = {
        id = 1;

        search = commonSearch;
        settings = commonSettings;
        userChrome = ''
          ${themeAlt}
          ${quteFoxCSS}
        '';
      };
      Misc = {
        id = 2;

        search = commonSearch;
        settings = commonSettings;
        containersForce = true;
        containers = {
          Google = {
            color = "green";
            icon = "fingerprint";
            id = 200;
          };
          Seneca = {
            color = "red";
            icon = "briefcase";
            id = 201;
          };
        };
      };
    };
  };

  # Fixes
  home.file = {
#    # Symlinks to Librewolf
#    ".librewolf".source = config.lib.file.mkOutOfStoreSymlink "/home/freecorn/.mozilla/firefox";
    
    # Gnome theme
    ".mozilla/firefox/Misc/chrome".source = "${fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v129.zip";
      sha256 = "14x0vp66i8b14q6c9n75sa88fcwy9jd9lik8sjnab2rnwlskvq9h";
    }}";
  };
}
