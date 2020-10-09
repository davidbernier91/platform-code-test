class Award
    attr_accessor :name, :expires_in, :quality

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality
    end

    def decrement_day(value=1)
        @expires_in -= value
    end

    def change_quality(value)
        @quality += value
    end

    def update_blue_first(value_change=1, minimum_value=0,  maximun_value=50)
        change_quality(value_change)
        @expires_in <= 0 ? change_quality(value_change) : @quality
        @quality = @quality.clamp(minimum_value, maximun_value)
    end

    def update_blue_compare(value_change=1, minimum_value=0, maximun_value=50)
        if @expires_in > 0 
            change_quality(value_change)
            if @expires_in < 11
                change_quality(value_change)
            end
            if @expires_in < 6
                change_quality(value_change)
            end
        else
          @quality = 0
        end
        @quality = @quality.clamp(minimum_value, maximun_value)
    end

    def update_blue_star(minimum_value=0, maximun_value=50)
        @expires_in > 0 ? change_quality(-2) : change_quality(-4)
        @quality = @quality.clamp(minimum_value, maximun_value)
    end

    def update_normal_award(minimum_value=0, maximun_value=50)
        @expires_in > 0 ? change_quality(-1) : change_quality(-2)
        @quality = @quality.clamp(minimum_value, maximun_value)
    end

    def update_blue_distinction_plus
        self
    end
end