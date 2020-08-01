class  Character
  attr_reader :offense, :defense
  attr_accessor :name, :hp

  # **キーワード引数をハッシュでのみ受け取る
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end

class Brave < Character

  # 会心の一撃時使用する定数
  SPECIAL_ATTACK_CONSTANT =1.5

  # モンスターへの攻撃
  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster,attack_type: attack_type)
    cause_damage(target: monster,damage: damage)
    
    
    puts "#{monster.name}の残りHPは#{monster.hp}"
  end

  private
  # 会心の一撃判定
  def decision_attack_type
    attack_num = rand(4)
    
    # ４分の１の確率で会心の一撃
    if attack_num == 0
      puts "会心の一撃"
      "special_attack"
    else 
      puts "通常攻撃"
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
    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end



class Monster < Character

  POWER_UP_LATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # オーバーライドしてるメソッド呼び出し
    super(
    name: params[:name]
    hp: params[:hp]
    offense: params[:offense]
    defense: params[:defense]
    )

    @transform_monster_flag = false
    @transform_trigger =  params[:hp] * CALC_HALF_HP
  end
  
  # 勇者への攻撃
  def attack(brave)
    
    # 変身分岐判定
    if @hp < @transform_trigger && @transform_monster_flag == false
    @transform_monster_flag = true
      transform
    end
    
    puts "#{@name}の攻撃"
    
    damage = calculate_damage(brave)
    cause_damage(target: brave,damage: damage)

    puts "#{brave.name}の残りHPは#{brave.hp}"
  end
  
  
  private
  
  # HPにダメージを反映
  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]

    target.hp -= damage

    # ターゲットのHPがマイナスになるなら０を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"    
  end
  
  # ダメージ計算
  def calculate_damage(target)
    damage = @offense - target.defense    
  end

  # 変身メソッド
  def transform
    transform_name = "ドラゴン"

    puts <<~EOS
    #{@name}は怒っている
    #{@name}は#{transform_name}に変身した
    EOS

    @offense *= POWER_UP_LATE
    @name = transform_name
  end
end

# クラスをインスタンス化
brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name:"スライム", hp:250, offense:200, defense:100)

# ループ処理
loop do
  brave.attack(monster)
  break if monster.hp <= 0

  monster.attack(brave)
  break if brave.hp <= 0
end

# 勇者のHPの応じて判定
battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) *3
  puts "#{brave.name}は戦いに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}は戦いに負けた"
  puts "#{brave.name}は目の前が真っ白になった"
end
