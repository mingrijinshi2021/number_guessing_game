#!/bin/bash

# 连接数据库的命令
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# 提示输入用户名
echo "Enter your username:"
read username

# 在数据库中查找用户名
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$username'")

# 如果用户不存在
if [[ -z $USER_ID ]]; then
    # 插入新用户
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$username')")
    if [[ $INSERT_USER_RESULT == "INSERT 0 1" ]]; then
        echo "Welcome, $username! It looks like this is your first time here."
        # 获取新用户的 user_id
        USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$username'")
    else
        echo "An error occurred while creating your account. Please try again."
        exit 1
    fi
else
    # 获取用户的游戏统计信息
    GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")
    echo "Welcome back, $username! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# 生成1到1000之间的随机数
SECRET_NUMBER=$((RANDOM % 1000 + 1))
echo "Guess the secret number between 1 and 1000:"

# 初始化猜测次数
NUMBER_OF_GUESSES=0

# 开始猜数字
# 开始猜数字
# 开始猜数字
while true; do
    read GUESS

    # 检查输入是否为整数
    if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
        echo "That is not an integer, guess again:"
    elif [[ $GUESS -lt $SECRET_NUMBER ]]; then
        echo "It's lower than that, guess again:"
    elif [[ $GUESS -gt $SECRET_NUMBER ]]; then
        echo "It's higher than that, guess again:"
    else
        # **先加 1，确保最后一次猜测被计算**
        NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))

        echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

        # 将游戏结果插入数据库
        INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $NUMBER_OF_GUESSES)")
        if [[ $INSERT_GAME_RESULT != "INSERT 0 1" ]]; then
            echo "An error occurred while saving your game. Please try again."
        fi
        break
    fi

    # **只在循环最后加 1（错误猜测时）**
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
done
