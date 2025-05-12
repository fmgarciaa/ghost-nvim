return {
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter", -- Mejora el rendimiento al cargarlo solo al insertar texto
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
