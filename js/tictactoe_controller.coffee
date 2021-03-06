game = game or {}

game.ticTacToeApp = angular.module 'ticTacToeApp', []

game.ticTacToeApp.controller 'gameController', [ "$scope",
  ($scope) ->

    $scope.board = [
                position: 0
                clicked: false
                img_url: null
              ,
                position: 1
                clicked: false
                img_url: null
              ,
                position: 2
                clicked: false
                img_url: null
              ,
                position: 3
                clicked: false
                img_url: null
              ,
                position: 4
                clicked: false
                img_url: null
              ,
                position: 5
                clicked: false
                img_url: null
              ,
                position: 6
                clicked: false
                img_url: null
              ,
                position: 7
                clicked: false
                img_url: null
              ,
                position: 8
                clicked: false
                img_url: null
    ]

    $scope.tries = 0
    $scope.endGame =               
                show: false
                message: ""
                url: ""

    $scope.players = [             
              name: "Ernie"
              marker: "X"
              img_url: "img/ernie.jpg"
              indicator: "current"
              tilesSelected: []
            ,
              name: "Bert"
              marker: "O"
              img_url: "img/bert.jpg"
              indicator: null
              tilesSelected: []
    ]

    $scope.winCombos = [       
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]

    $scope.currentPlayer = $scope.players[0]
    $scope.turns = 0 # elapsed turns

    $scope.changeCurrentPlayer = ->                 # Switches current player
      $scope.currentPlayer.indicator = null

      if $scope.currentPlayer == $scope.players[0]
        $scope.currentPlayer = $scope.players[1]
      else
        $scope.currentPlayer = $scope.players[0]

      $scope.currentPlayer.indicator = "current"
      return

    $scope.isWin = (tiles)->
      for combo in $scope.winCombos
        if tiles.indexOf(combo[0]) >= 0 and tiles.indexOf(combo[1]) >= 0 and tiles.indexOf(combo[2]) >= 0
          return true
      return false
      
    $scope.isTie = ->
      if $scope.tries is tiles.length
        return true
      return false

    $scope.newGame = ->
      window.location.href = window.location.href
      return
      
    $scope.handleClick = (tile) ->                   # core code
      if not tile.clicked
        $scope.tries += 1
        tile.img_url = $scope.currentPlayer.img_url
        tile.clicked = true
        $scope.currentPlayer.tilesSelected.push tile.position

        if $scope.isWin($scope.currentPlayer.tilesSelected)
          $scope.endGame.show = true
          $scope.endGame.message = $scope.currentPlayer.name + " is the winner!"
          $scope.endGame.url = $scope.currentPlayer.img_url
        else if $scope.isTie()
          $scope.endGame.show = true
          $scope.endGame.message = "Tied Game!"

        $scope.changeCurrentPlayer()

    $scope.computerPlay = ->
      # 1) take the middle if it's open
      # 2) take the corner (that's not next to the middle)
      # 3) go for win
      # 4) prevent loss
      # 5) take corner
      # 6) take side


    return

]