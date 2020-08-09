require './character'

class Brave < Character

  # 会心の一撃時使用する定数
  SPECIAL_ATTACK_CONSTANT =1.5

  # モンスターへの攻撃
  def attack(monster)
    # puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster,attack_type: attack_type)
    cause_damage(target: monster,damage: damage)
    
    # message_dialogのattack_message呼び出し require要らないの？
    attack_message(attack_type: attack_type)
    damage_message(target: monster, damage: damage)

    # puts "#{monster.name}の残りHPは#{monster.hp}"
  end

  private
  # 会心の一撃判定
  def decision_attack_type
    attack_num = rand(4)
    
    # ４分の１の確率で会心の一撃
    if attack_num == 0
      # puts "会心の一撃"
      "special_attack"
    else 
      # puts "通常攻撃"
      "normal_attack"
    end
  end
  
  # ダメージの計算
  def calculate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end
  
  # HPにダメージを反映
  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage
    target.hp = 0 if target.hp < 0
    # puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end
