

Template.graph.rendered = ->
  
  graph = d3.select('#graph')
  
  data = {}
  data.nodes = []
  data.links = []

  data.nodes.push _id: 0, name: 'Germinadora', facebook_id: 'Germinadora', group: 3
  data.links.push source: 0, target: 3, value: 20
  data.links.push source: 0, target: 6, value: 20
  data.links.push source: 0, target: 9, value: 20
  data.links.push source: 0, target: 10, value: 20
  data.links.push source: 0, target: 11, value: 20
  data.links.push source: 0, target: 12, value: 20

  data.nodes.push _id: 1, name: 'Juan', facebook_id: 'jbernab', group: 1
  data.nodes.push _id: 2, name: 'Leo', facebook_id: 'leonardo.grijo', group: 1
  data.nodes.push _id: 13, name: 'Barbara', facebook_id: 'barbara.bernabo.7', group: 1
  data.links.push source: 1, target: 0, value: 10
  data.links.push source: 2, target: 0, value: 10
  data.links.push source: 13, target: 0, value: 10

  data.nodes.push _id: 3, name: 'Eyso', facebook_id: 'appstoreoptimization', group: 2
  data.nodes.push _id: 4, name: 'Ludmilla', facebook_id: 'ludmilla.veloso', group: 1
  data.nodes.push _id: 5, name: 'Rômulo', facebook_id: 'romuloggomes', group: 1
  data.nodes.push _id: 14, name: 'Pedro', facebook_id: 'pedrolmarins', group: 1
  data.nodes.push _id: 15, name: 'Guilherme', facebook_id: 'guilherme.brito.16718979', group: 1
  data.links.push source: 4, target: 3, value: 10
  data.links.push source: 5, target: 3, value: 10
  data.links.push source: 14, target: 3, value: 10
  data.links.push source: 15, target: 3, value: 10

  data.nodes.push _id: 6, name: 'Blumpa', facebook_id: 'blumpasimplesassim', group: 2
  data.nodes.push _id: 7, name: 'Edu', facebook_id: 'dudugiglio', group: 1
  data.nodes.push _id: 8, name: 'Ibrahim', facebook_id: 'ibrahimcesar', group: 1
  data.links.push source: 7, target: 6, value: 10
  data.links.push source: 8, target: 6, value: 10

  data.nodes.push _id: 9, name: 'Liga', facebook_id: null, group: 2
  data.nodes.push _id: 16, name: 'William', facebook_id: "willian.eloybento", group: 1
  data.links.push source: 16, target: 9, value: 10
  
  data.nodes.push _id: 10, name: 'SmartMod', facebook_id: "228192594017351", group: 2
  data.nodes.push _id: 17, name: 'Rafael', facebook_id: "rafael.marteleto", group: 1
  data.nodes.push _id: 18, name: 'Luiz', facebook_id: "luiz.sales1", group: 1
  data.nodes.push _id: 19, name: 'Ronaldo', facebook_id: "ronaldo.braghittoni", group: 1
  data.links.push source: 17, target: 10, value:10
  data.links.push source: 18, target: 10, value:10
  data.links.push source: 19, target: 10, value:10
  
  data.nodes.push _id: 11, name: 'CanDo', facebook_id: null, group: 2
  data.nodes.push _id: 20, name: 'Bruno', facebook_id: "brunochronnos", group: 1
  data.nodes.push _id: 21, name: 'Vicente', facebook_id: "avlis64", group: 1
  data.links.push source: 20, target: 11, value:10
  data.links.push source: 21, target: 11, value:10

  data.nodes.push _id: 12, name: 'Tiibu', facebook_id: "Tiibu.gps", group: 2
  data.nodes.push _id: 22, name: 'Glauco', facebook_id: "glauco.maschio", group: 1
  data.nodes.push _id: 23, name: 'Carina', facebook_id: "carina.beraldo", group: 1
  data.nodes.push _id: 24, name: 'Tom', facebook_id: "pixelefant", group: 1
  data.links.push source: 22, target: 12, value:10
  data.links.push source: 23, target: 12, value:10
  data.links.push source: 24, target: 12, value:10
  
  data.nodes.push _id: 25, name: 'Hugo', facebook_id: "hugo.oliveira.39", group: 1
  data.nodes.push _id: 26, name: 'Antoine', facebook_id: "barrault.antoine", group: 1
  data.nodes.push _id: 27, name: 'Renato', facebook_id: "renato.pavone.3", group:1
  
  # Trasnform links into direct objects references instead of _ids
  hash_lookup = []
  data.nodes.forEach (d, i) ->
    hash_lookup[d._id] = d
    
  data.links.forEach (d, i) ->
    d.source = hash_lookup[d.source]
    d.target = hash_lookup[d.target]
  
  color = d3.scale.category20()
  
  g = $('#graph')
  force = d3.layout.force()
    .size([g.width(), g.height()])
    .linkDistance(120)
    .charge(-5000)
    .gravity(0.9)
    
  force.nodes(data.nodes)
      .links(data.links)
      .start();
      
  force.on "tick", () ->
    links.attr("x1", (d) -> d.source.x)
         .attr("y1", (d) -> d.source.y)
         .attr("x2", (d) -> d.target.x)
         .attr("y2", (d) -> d.target.y)

    nodes.attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")" )
  
  links = graph.append("g").attr("id", "links").selectAll(".link")
    .data(data.links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", (d) -> Math.sqrt(d.value) )
  
  nodes = graph.append("g").attr("id", "nodes").selectAll('.node')
  	.data(data.nodes, (d) -> d._id )
  	
  graph.append("defs").selectAll("pattern")
  	.data(data.nodes)
  	.enter().append("pattern")
  	  .attr('patternUnits', "userSpaceOnUse")
  	  .attr("height", "100%")
  	  .attr("width", "100%")
  	  .attr("x", (d) -> -(10 + d.group*10))
  	  .attr("y", (d) -> -(10 + d.group*10))
  	  .attr("id", (d) -> "avatar_" + d._id)
  	  .append("image")
  	    .attr("x", 0)
  	    .attr("y", 0)
  	    .attr("height", (d) -> 20 + d.group*20)
  	    .attr("width", (d) -> 20 + d.group*20)
  	    .attr("xlink:href", (d) -> if d.facebook_id then "http://graph.facebook.com/#{d.facebook_id}/picture" else "")
  
  nodes.enter().append('g')
  	.attr("class", "node")
  	.call(force.drag)
  	.on 'click', (d) ->
  	  if d.facebook_id?
  	    window.open('http://www.facebook.com/'+ d.facebook_id,'_blank')
  	
  nodes.append("circle")
    .attr("r", (d) -> 10 + d.group*10)
    .attr("class", "node")
    .style("fill", (d) -> if d.facebook_id then "url(#avatar_#{d._id})" else "#555")
    .style("stroke", (d) -> color(d.group))

  nodes.append("text")
    .text( (d) -> d.name )
    .attr("dx", (d) -> "-" + d.name.length/4 + "em")
    .attr("dy", "2.5em")

