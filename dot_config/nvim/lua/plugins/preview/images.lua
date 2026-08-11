local opts = {
	backend = "kitty",
	integrations = {
		markdown = {
			enabled = true,
			download_remote_images = false,
		},
	},
}

return {
	"3rd/image.nvim",
	opts = opts,
	event = "VeryLazy",
	config = function(_, o)
		local images = require("image")
		images.setup(o)
		images.enable()
	end,
	keys = {
		{
			"<leader>pi",
			function()
				local images = require("image")
				if images.is_enabled() then
					images.disable()
				else
					images.enable()
				end
			end,
			desc = "Toggle image preview",
		},
		{
			"<leader>pI",
			function()
				local md = opts.integrations.markdown
				md.download_remote_images = not md.download_remote_images
				require("image").setup(opts)
				vim.notify("Remote images: " .. (md.download_remote_images and "on" or "off"))
			end,
			desc = "Toggle remote image download",
		},
	},
}
