module MessageDialog
  
  # 攻撃時のメッセージ
  def attack_message(**params)
    attack_type = params[:attack_type]
    # 攻撃実行側のクラスのnameパラメータを使用して攻撃メッセージを表示
    puts "#{@name}の攻撃"
    puts "必殺攻撃" if attack_type == "special_attack"
  end

  # ダメージを受けたときのメッセージ
  def damage_message(**params)
    target = params[:target]
    damage = params[:damage]

    puts <<~EOS
    #{target.name}は#{damage}のダメージを受けた
    #{target.name}の残りHPは#{target.hp}だ
    EOS
  end

  # バトルが終了したときのメッセージ
  def end_message(result)
    if result[:brave_win_flag]
      puts <<~EOS
        勇者は勝った
        #{result[:exp]}の経験値と#{result[:gold]}ゴールドを手に入れた
      EOS
    else
      puts <<~EOS
        勇者は負けた
        目の前が真っ暗になった
      EOS
    end
  end

  def transform_message(**params)
    origin_name = params[:origin_name]
    transform_name = params[:transform_name]

    puts <<~EOS
      #{origin_name}は怒った
      #{origin_name}は#{transform_name}に変身した
    EOS
  end
end