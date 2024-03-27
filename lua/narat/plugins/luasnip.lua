return {
  "saadparwaiz1/cmp_luasnip",
  config = function()
    local ls = require "luasnip"
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    vim.keymap.set("i", "<C-j>", function()
      ls.jump(1)
    end)
    vim.keymap.set("s", "<C-j>", function()
      ls.jump(1)
    end)
    vim.keymap.set("i", "<C-k>", function()
      ls.jump(-1)
    end)
    vim.keymap.set("s", "<C-k>", function()
      ls.jump(-1)
    end)

    ls.add_snippets("python", {
      s("sn_step", {
        t { "with pytest.xray.step(step=" },
        i(1),
        t { "):  # " },
        i(2),
        t { "", "" },
        t { "    " },
        i(3),
      }),
      s("sn_import_helper", {
        t { "import uitestsuite.cruisem.helpers.helpers as helper" },
        t { "", "import uitestsuite.cruisem.helpers.helpers_home as hh" },
        t { "", "import uitestsuite.cruisem.helpers.helpers_gui_testing as guit" },
        t { "", "import uitestsuite.cruisem.tools.stress_test_editors as ss" },
      }),
      s("sn_select", {
        t { "am.category.elemtree.select('" },
        i(1),
        t { "')" },
      }),

      s("sn_activate", {
        t { "am.activate_pane('" },
        i(1),
        t { "')" },
      }),

      s("sn_switch_to_category", {
        t { "am.switch_to_category('" },
        i(1),
        t { "')" },
      }),

      s("sn_get", {
        t { "am.home.elements.detail" },
        i(1),
      }),
      s("sn_test", {
        t { "import pytest" },
        t { "", "from uitest.script import app_manip as am" },
        t { "", "from uitestsuite.cruisem.helpers import helpers as helper" },
        t { "", "" },
        t { "", "def test_CMTEST_" },
        i(1),
        t { "(am):" },
        t { "", "    with pytest.xray.step(step=1):  # 1" },
        t { "", "        pass" },
      }),
      s("snbr", {
        t { "breakpoint()" },
        t { "", "print('breakpoint')" },
      }),
      s("sn_results_table", {
        t { "am.activate_ribbon_action('=Page')" },
        t { "", "am.results.dataview.add_chart_to_page('Table')" },
        t { "", "am.results.databrows.case.select('" },
        i(1),
        t { "')" },
        t { "", "am.results.databrows.data.select('" },
        i(2),
        t { "')" },
        t { "", "am.results.databrows.flat.select('" },
        i(3),
        t { "')" },
        t { "", "am.results.databrows.flat.activate_menu('Open selection in/view/Table 1')" },
      }),
    })
    ls.add_snippets("markdown", {

      s("r2", {
        t { "| " },
        i(1),
        t { " | " },
        i(2),
        t { " |" },
      }),

      s("r3", {
        t { "| " },
        i(1),
        t { " | " },
        i(2),
        t { " | " },
        i(3),
        t { " |" },
      }),
    })
  end,
}
