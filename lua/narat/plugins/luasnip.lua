return {
	"saadparwaiz1/cmp_luasnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		local keymap = require("narat.core.utils").keymap

		keymap({ "i", "s" }, "<C-J>", function()
			ls.jump(1)
		end, { silent = true })
		keymap({ "i", "s" }, "<C-K>", function()
			ls.jump(-1)
		end, { silent = true })

		keymap({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		ls.add_snippets("python", {
			s("!step", {
				t({ "with pytest.xray.step(step=" }),
				i(1),
				t({ "):  # " }),
				i(2),
				t({ "", "" }),
				t({ "    " }),
				i(3),
			}),
			s("!helper", {
				t({ "import uitestsuite.cruisem.helpers.helpers as helper" }),
				t({ "", "import uitestsuite.cruisem.helpers.helpers_home as hh" }),
				t({ "", "import uitestsuite.cruisem.helpers.helpers_gui_testing as guit" }),
				t({ "", "import uitestsuite.cruisem.tools.stress_test_editors as ss" }),
			}),

			s("!select", {
				t({ 'am.category.elemtree.select("' }),
				i(1),
				t({ '")' }),
			}),

			s("!activate", {
				t({ 'am.activate_pane("' }),
				i(1),
				t({ '")' }),
			}),

			s("!switch_to_category", {
				t({ 'am.switch_to_category("' }),
				i(1),
				t({ '")' }),
			}),

			s("!get", {
				t({ "am.category.elemtree.detail" }),
				i(1),
			}),
			s("!am", {
				t({ "from uitest.script import app_manip as am" }),
			}),
			s("!test", {
				t({ "import pytest" }),
				t({ "", "from uitest.script import app_manip as am" }),
				t({ "", "from uitestsuite.cruisem.helpers import helpers as helper" }),
				t({ "", "" }),
				t({ "", "def test_CMTEST_" }),
				i(1),
				t({ "(am):" }),
				t({ "", "    with pytest.xray.step(step=1):  # 1" }),
				t({ "", "        pass" }),
			}),
			s("!br", {
				t({ "breakpoint()" }),
				t({ "", 'print("breakpoint")' }),
			}),
		})
		ls.add_snippets("markdown", {
			s("!todo", {
				t({ "- [ ] " }),
				i(1),
			}),

			s("r2", {
				t({ "| " }),
				i(1),
				t({ " | " }),
				i(2),
				t({ " |" }),
			}),
			s("r3", {
				t({ "| " }),
				i(1),
				t({ " | " }),
				i(2),
				t({ " | " }),
				i(3),
				t({ " |" }),
			}),
		})
	end,
}
