{pkgs, outputs, ...}: {
  # Install Neovim and plugins
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Vim theme
      vim-airline
      vim-airline-themes

      # Internal clipboard
      vim-vsnip
      cmp-vsnip

      # Autocomplete manager
      lspkind-nvim

      # Autocomplete plugins
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp

      # Hex color visualizer and color theme
      nvim-colorizer-lua
      vim-monokai-pro

      # Discord
      vimsence

    ];
    extraConfig = ''
      lua <<EOF
      -- Set up nvim-cmp
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for '/' and '?'
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
      EOF

      colorscheme monokai_pro
      let g:airline_theme='onedark'
      let g:airline#extensions#tabline#enabled = 1
      hi Normal guibg=none ctermbg=235
      hi EndOfBuffer guibg=none ctermbg=235
      hi LineNr guibg=none ctermbg=none
      lua require'colorizer'.setup()

      set nu rnu
      set termguicolors
      set mouse=a

      set undofile
      set undodir=$HOME/.local/share/nvim/undo
      set undolevels=100
      set undoreload=10000

      nmap <C-x> :bnext<CR>
      nmap <C-z> :bprev<CR>
      nmap <C-w> :bd<CR>

      let g:vimsence_small_text = 'NeoVim'
      let g:vimsence_small_image = 'neovim'
    '';
  };
}
