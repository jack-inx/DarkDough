// d3.js bubbles implementation.
// Technologies: HTML, CSS, JavaScript, SVG, d3.js

// 2012-03-16
// Step 1. Lines (no-animated)

(function($) {
  $.fn.implementSvg = function() {
    var init = function() {
      var $containersForDrawing = $('div[class*=container].svg');

      $containersForDrawing.each(function() {
          var containerClass = $(this).attr('class').split(/\s+/)[0];
          var partialId = $(this).parent().attr('id');

        var r = 600,
            format = d3.format(",d"),
            fill = d3.scale.category10();

        // return a new layout pack with size equals to SVG size (width & height)
        var bubble = d3.layout.pack()
            .sort(null)
            .size([r, r]);

        // return SVG container => svg.bubble
        var vis = d3.select("#" + partialId + " ." + containerClass).append("svg")
            .attr("width", r)
            .attr("height", r)
            .attr("class", "bubble");

        // creating a nodes
        var json = $.parseJSON($(this).find('.json').text());

        var node = vis.selectAll("g.node")
            .data(bubble.nodes(classes(json))
            .filter(function(d) { return !d.children; }))
          .enter().append("g")
            .attr("class", "node")
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

        node.append("title")
            .text(function(d) { return d.className + ": " + format(d.value); });

        node.append("circle")
            .attr("r", function(d) { return d.r; })
            .style("fill", function(d) { return fill(d.packageName); });

        node.append("text")
            .attr("text-anchor", "middle")
            .attr("dy", "1.5em")
            .attr("font-size", function(d) { return Math.sqrt(d.r * .01) + "em"; })
            .text(function(d) { return d.className.substring(0, d.r / 3); });

        node.append("text")
            .attr("text-anchor", "middle")
            .attr("dy", ".1em")
            .attr("font-size", function(d) { return Math.sqrt(d.r * .12) + "em"; })
            .text(function(d) { return format(d.value); });

        // Returns a flattened hierarchy containing all leaf nodes under the root.
        function classes(root) {
          var classes = [];

          function recurse(name, node) {
            if (node.children) node.children.forEach(function(child) { recurse(node.name, child); });
            else classes.push({packageName: name, className: node.name, value: node.size});
          }

          recurse(null, root);
          return {children: classes};
        }

      });
    };

    return init.call(this);
  }
})(jQuery)