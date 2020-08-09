require './character'

class Monster < Character

  POWER_UP_LATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # オーバーライドしてるメソッド呼び出し
    super(
    name: params[:name],
    hp: params[:hp],
    offense: params[:offense],
    defense: params[:defense],
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
        
    damage = calculate_damage(brave)
    cause_damage(target: brave,damage: damage)

    # attack_messageの呼び出し
    attack_message
    damage_message(target: brave, damage: damage)
    
    # puts "#{brave.name}の残りHPは#{brave.hp}"
  end
  
  
  private
  
  # HPにダメージを反映
  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]

    target.hp -= damage

    # ターゲットのHPがマイナスになるなら０を代入
    target.hp = 0 if target.hp < 0

    # puts "#{target.name}は#{damage}のダメージを受けた"    
  end
  
  # ダメージ計算
  def calculate_damage(target)
    damage = @offense - target.defense    
  end

  # 変身メソッド
  def transform
    transform_name = "ドラゴン"

    transform_message(origin_name:@name,transform_name:transform_name)

    @offense *= POWER_UP_LATE
    @name = transform_name
  end
end
