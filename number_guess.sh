#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

GUESS() {
    echo "Enter your username:"
    read username
    # 检查这个username是否已经存在
    USERNAME_EXISTS=$($PSQL "SELECT COUNT(*) FROM users WHERE username='$username'")
    if [[ $USERNAME_EXISTS -gt 0 ]]; then
        # 如果存在就使用他作为用户名,并打印欢迎信息
        GAME_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=(SELECT user_id FROM users WHERE username='$username')")
        BEST_GAME=$($PSQL "SELECT guess_number, MIN(rounds) AS best_game FROM games WHERE user_id=(SELECT user_id FROM users WHERE username='$username') GROUP BY guess_number")
        echo "Welcome back, $username! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
    else
        # 如果不存在，就创建这个用户
        $PSQL "INSERT INTO users (username) VALUES ('$username')"
        # 查询打印是否成功,如果不成功,则告知创建失败,退出游戏
        INSERT_USERNAME_RESULT=$($PSQL "SELECT COUNT(*) FROM users WHERE username='$username'")
        if [[ $INSERT_USERNAME_RESULT -eq 0 ]]; then
            echo "Sorry, we couldn't create your account. Please try again later."
            exit 1
        # 如果成功,则打印欢迎信息
        else
            echo "Welcome, $username! It looks like this is your first time here."

        fi
    fi

    # 获取 user_id
    USERID=$($PSQL "SELECT user_id FROM users WHERE username='$username'" | xargs)

    # 生成一个随机数字
    GUESS_NUMBER=$((RANDOM % 1000 + 1))

    # 插入新游戏记录，不直接获取 game_id
    $PSQL "INSERT INTO games (guess_number, user_id) VALUES ($GUESS_NUMBER, $USERID)"

    # 通过 user_id 获取最新的 game_id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE user_id=$USERID ORDER BY game_id DESC LIMIT 1" | xargs)

    # 提示用户猜数字，并读取数字
    echo "Guess the secret number between 1 and 1000:"
    read guess

    # 开始一个无线循环,直到用户猜对
    while true; do
        # 检测用户输入是否为整数
        while [[ ! $guess =~ ^[0-9]+$ ]]; do
            echo "That is not an integer, guess again:"
            read guess
        done

        # 如果是整数,则进入后续判断
        # 如果用户输入的数字小于随机数字,则提示用户猜小了,并把猜测轮次+1
        if [[ $guess -lt $GUESS_NUMBER ]]; then
            echo "It's lower than that, guess again:"
            $PSQL "UPDATE games SET rounds = rounds + 1 WHERE user_id=$USERID AND game_id=$GAME_ID"
            read guess
        # 如果用户输入的数字大于随机数字,则提示用户猜大了,并把猜测轮次+1
        elif [[ $guess -gt $GUESS_NUMBER ]]; then
            echo "It's higher than that, guess again:"
            $PSQL "UPDATE games SET rounds = rounds + 1 WHERE user_id=$USERID AND game_id=$GAME_ID"
            read guess
        # 如果用户输入的数字等于随机数字,则打印恭喜信息,设置对局已经结束,并退出游戏
        else
            ROUNDS=$($PSQL "SELECT rounds FROM games WHERE user_id=$USERID AND game_id=$GAME_ID")
            echo "You guessed it in $ROUNDS tries. The secret number was $GUESS_NUMBER. Nice job!"
            $PSQL "UPDATE games SET finished = true WHERE user_id=$USERID AND game_id=$GAME_ID"
            exit 0
        fi
    done
}

GUESS

#2
#3
#4