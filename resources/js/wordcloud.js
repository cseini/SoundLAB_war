function WordCloud(options) {
var margin = {top: 0, right: 0, bottom: 0, left: 0},
w = 650 - margin.left - margin.right,
h = 350 - margin.top - margin.bottom;

// create the svg
var svg = d3.select(options.container).append("svg")
.attr('height', h + margin.top + margin.bottom)
.attr('width', w + margin.left + margin.right)

// set the ranges for the scales
var xScale = d3.scaleLinear().range([10, 60]);

var focus = svg.append('g')
.attr("transform", "translate(" + [650, 350] + ")")

var colorMap = [ '#f68657','#f6b352', "#dc3912", "#ff9900", "#109618", "#3b3eac", "#0099c6", "#dd4477", "#66aa00", "#b82e2e", "#316395", "#994499", "#22aa99", "#aaaa11", "#6633cc"];

// seeded random number generator
var arng = new alea('hello.');

var data;

startHash(options.data);
function startHash(d) {
data = d;

var word_entries = d3.entries(data['count']);
xScale.domain(d3.extent(word_entries, function(d) {return d.value;}));

makeCloud();

function makeCloud() {
d3.layout.cloud().size([w, h])
.timeInterval(20)
.words(word_entries)
.fontSize(function(d) { return xScale(+d.value); })
.text(function(d) { return d.key; })
.font("Impact")
.random(arng)
.on("end", function(output) {
// sometimes the word cloud can't fit all the words- then redraw
// https://github.com/jasondavies/d3-cloud/issues/36
if (word_entries.length !== output.length) {
makeCloud();
return undefined;
} else { draw(output); }
})
.start();
}

d3.layout.cloud().stop();

}
//.rotate(function() { return ~~(Math.random() * 1) * 90; })
function draw(words) {
focus.selectAll("text")
.data(words)
.enter().append("text")
.style("font-size", function(d) { return (xScale(d.value)*0.65) + "px"; })
.style("font-family", "Impact")
.style("fill", function(d, i) { return colorMap[~~(arng() *15)]; })
.attr("text-anchor", "middle")
.attr("transform", function(d) {	
return "translate(" + [d.x-300, d.y-170] + ")rotate(" + d.rotate *1 + ")";
})
.text(function(d) { return d.key; })
.style('cursor','pointer')
.on('mouseover', handleMouseOver)
.on('mouseout', handleMouseOut);
}

function handleMouseOver(d) {
var group = focus.append('g')
.attr('id', 'story-titles');
var base = d.y - d.size;

group.selectAll('text')
.data(data['sample_title'][d.key])
.enter().append('text')
.attr('x', d.x-300)
.attr('y', function(title, i) {
return (base - i*14)-170;
})
.attr('text-anchor', 'middle')
.text(function(title) { return title; });

var bbox = group.node().getBBox();
var bboxPadding = 5;

// place a white background to see text more clearly
var rect = group.insert('rect', ':first-child')
.attr('x', bbox.x)
.attr('y', bbox.y)
.attr('width', bbox.width + bboxPadding)
.attr('height', bbox.height + bboxPadding)
.attr('rx', 10)
.attr('ry', 10)
.attr('class', 'label-background-strong');
}

function handleMouseOut(d) {
d3.select('#story-titles').remove();
}
}
