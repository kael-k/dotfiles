return {
	"3rd/image.nvim",
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				download_remote_images = true,
			},
		},
	},
	event = "VeryLazy",
	config = function(_, opts)
		local image_previews = require("image")
		image_previews.setup(opts)
		image_previews.enable()
	end,
	keys = {
		{
			"<leader>pi",
			function()
				local image_previews = require("image")
				if image_previews.is_enabled() then
					image_previews.disable()
				else
					image_previews.enable()
				end
			end,
			desc = "Toggle markdown preview",
		},
	},
}
