# ~/.npm_guard.sh
# ==========================================
# npm install -g 誤爆防止関数
# ==========================================
npm() {
  local is_install=false
  local is_global=false

  # 引数を一つずつチェック
  for arg in "$@"; do
    if [[ "$arg" == "install" || "$arg" == "i" ]]; then
      is_install=true
    elif [[ "$arg" == "-g" || "$arg" == "--global" ]]; then
      is_global=true
    fi
  done

  # 'install/i' と '-g/--global' が両方含まれていた場合ブロックする
  if [[ "$is_install" == true && "$is_global" == true ]]; then
    echo "🚫 警告: 'npm install -g' は禁止されています！"
    echo "💡 代わりに mise を使ってください:"
    echo "   mise use -g npm:<パッケージ名>"
    echo ""
    echo "※どうしても実行したい場合は 'command npm install -g ...' を使用してください。"
    return 1
  fi

  # 問題なければ通常の npm コマンドを実行
  command npm "$@"
}

