class Award

    attr_accessor :name, :expires_in, :quality

    @@expired = 0
    @@decrement_day = -1
    @@blue_first = {name: "Blue First", min_value:0, max_value:50, quality_inc:1, quality_dec:1, zero_quality:0}
    @@blue_distinction_plus = {name: "Blue Distinction Plus"}
    @@blue_compare = {name: "Blue Compare", min_value:0, max_value:50, eleven_days:11, six_days:6, value_inc:1}
    @@blue_star = {name: "Blue Star", min_value:0, max_value:50, quality_dec:-2, quality_dec_doubled:-4}
    @@normal = {min_value:0, max_value:50, quality_dec:-1, quality_dec_doubled:-2}

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality
    end
    
    def update
        case self.name
        when @@blue_first[:name] 
            update_blue_first 
        when @@blue_compare[:name] 
            update_blue_compare
        when @@blue_star[:name]
            update_blue_star
        when @@blue_distinction_plus[:name]
            self
        else
            update_normal_award
        end
        self.name == @@blue_distinction_plus[:name] ? nil : decrement_day
    end

    def update_blue_first
        change_quality(@@blue_first[:quality_inc])
        expiration_check
        clamp_quality(@@blue_first[:min_value], @@blue_first[:max_value])
    end

    def update_blue_compare
        expiration_check
        clamp_quality(@@blue_compare[:min_value], @@blue_compare[:max_value])
    end

    def update_blue_star
        expiration_check
        clamp_quality(@@blue_star[:min_value], @@blue_star[:max_value])
    end

    def update_normal_award
        expiration_check
        clamp_quality(@@normal[:min_value], @@normal[:max_value])
    end

    def expiration_check
        case self.name
        when @@blue_first[:name] || @@blue_star[:name]
            expires_in <= @@expired ? change_quality(@@blue_first[:quality_dec]) : change_quality((@@blue_first[:zero_quality]))
        when @@blue_compare[:name] 
            if expires_in > @@expired 
                change_quality(@@blue_compare[:value_inc])
                change_quality(@@blue_compare[:value_inc]) if expires_in < @@blue_compare[:eleven_days]
                change_quality(@@blue_compare[:value_inc]) if expires_in < @@blue_compare[:six_days]
            else
              self.quality = @@expired
            end
        when @@blue_distinction_plus
            nil
        else
            expires_in > @@expired ? change_quality(@@normal[:quality_dec]) : change_quality(@@normal[:quality_dec_doubled])
        end
    end

    private

    def decrement_day
        self.expires_in += @@decrement_day
    end

    def change_quality(value)
        self.quality += value
    end

    def clamp_quality(min_value, max_value)
        self.quality = quality.clamp(min_value, max_value)
    end
end

# class BlueFirst < Award
#     def update
#         change_quality(@@blue_first[:quality_inc])
#         expiration_check
#         clamp_quality(@@blue_first[:min_value], @@blue_first[:max_value])
#     end
# end

# class BlueCompare < Award
#     def update
#         expiration_check
#         clamp_quality(@@blue_compare[:min_value], @@blue_compare[:max_value])
#     end
# end

# class BlueStar< Award
    # def update
    #     expiration_check
    #     clamp_quality(@@blue_star[:min_value], @@blue_star[:max_value])
    # end
# end

# class NormalItem< Award
    # def update
    #     expiration_check
    #     clamp_quality(@@normal[:min_value], @@normal[:max_value])
    # end
# end