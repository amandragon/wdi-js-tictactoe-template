$ ->

  status_indicators = $("#teams li") 
  tiles = [] 
  players = [ 
    {
      name: "Ernie"
      marker: "X"
      img_url: "img/ernie.jpg"
      indicator: $(status_indicators[0])
    }
    {
      name: "Bert"
      marker: "O"
      img_url: "img/bert.jpg"
      indicator: $(status_indicators[1])
    }
  ]
  
  
  current_player = undefined # player data
  turns = 0 # elapsed turns

  win_combos = [
    [
      0
      1
      2
    ],
    [
      3
      4
      5
    ],
    [
      6
      7
      8
    ],
    [
      0
      3
      6
    ]
    [
      1
      4
      7
    ]
    [
      2
      5
      8
    ]
    [
      0
      4
      8
    ]
    [
      2
      4
      6
    ]
  ]
initialize = ->
  _(9).times (i) ->
    tiles.push $("<div/>").attr(
      id: "tile" + i
      class: "tile"
    ).on("click", handle_click).appendTo(board)
    return

  current_player = _.first(players)
  player_indicators = _.map(players, (player) ->
    player.indicator
  )
  _.each player_indicators, (indicator, i) ->
    indicator = $(indicator)
    player = players[i]
    $(".team", indicator).html player.marker
    $(".player", indicator).html player.name
    $("img", indicator).attr "src", player.img_url
    indicator.addClass "current"  if player is current_player
    return

  game.fadeIn()
  return

is_active = (tile) ->
  tile.hasClass "active"

activate_tile = (tile) ->
  tile.html current_player.marker
  tile.addClass "active"
  tile.data "player", current_player
  turns++
  return

  
toggle_player = ->
  current_player = players[get_current_player_index()]
  status_indicators.removeClass "current"
  current_player.indicator.addClass "current"
  return

  get_current_player_index = ->
  turns % 2

get_board_data = ->
  current_player_board_data = []
  _.each tiles, (tile, i) ->
    current_player_board_data.push i  if tile.data("player") is current_player
    return
  current_player_board_data

  
is_win = ->
  board_data = get_board_data()
  match_found = false
  _.each win_combos, (combo) ->
    if _.intersection(combo, board_data).length is combo.length
      show_combo combo
      match_found = true
    return
  match_found

  
is_tie = ->
  turns is tiles.length

  
handle_win = ->
  _.each tiles, (tile) ->
    tile.off "click"
    return

  update_results
    img_src: current_player.img_url
    img_alt: current_player.name
    message: "Congratulations, <span id=\"winner\">" + current_player.name + "</span>!"

  return

  
handle_tie = ->
  update_results
    img_src: "img/rubberduckie.jpg"
    img_alt: "Rubber Duckie"
    message: "Tie Game!"

  return

  update_results = (args) ->
  results = $("#results")
  winner_el = $("h1", results)
  image_el = $(".image", results)
  button = $("button", results)
  image = $("<img/>")
  overlay = $("#overlay")
  image.attr
    src: args.img_src
    alt: args.img_alt

  image_el.html image
  winner_el.html args.message
  button.on "click", new_game
  hide_indicators()
  setTimeout (->
    overlay.fadeIn 500
    results.fadeIn 500
    return
  ), 1000
  return

hide_indicators = ->
  status_indicators.animate
    opacity: 0
  , 2000
  return

show_combo = (combo) ->
  _.each combo, (tile_index) ->
    tiles[tile_index].addClass "combo"
    return

  return

  
  new_game = ->

    window.location.href = window.location.href
    return

  
  initialize()
  return
