              var g = new Bluff.Line('graph', "1000x600");
      g.theme_37signals();
      g.tooltips = true;
      g.title_font_size = "24px"
      g.legend_font_size = "12px"
      g.marker_font_size = "10px"

        g.title = 'Stats: LOC & LOT';
        g.data('LOC', [0]);
g.data('LOT', [0]);
        g.labels = {"0":"1/27"};
        g.draw();
