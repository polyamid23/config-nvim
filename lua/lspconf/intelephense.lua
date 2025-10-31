 local my_config = require('lspconf')
 
 vim.lsp.config('intelephense', {
   cmd = { 'intelephense', '--stdio' },
   filetypes = { 'php' },
   root_dir = function(fname)
     return vim.loop.cwd()
   end,
   on_attach = my_config.on_attach,
   capabilities = my_config.capabilities,
   settings = {
     intelephense = {
       files = {
         maxSize = 1000000,
       },
       environment = {
         includePaths = {
           "/home/serii/Sites/wordpress",
           "/home/serii/Sites/advanced-custom-fields-pro",
           "/home/serii/Sites/woocommerce"
         }
       }
     }
   }
 })