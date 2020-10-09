require './award.rb'

def update_quality(awards)
  awards.each do |award|  
    case award.name
      when 'Blue First'
        award.update_blue_first
        award.decrement_day
      when 'Blue Compare'
        award.update_blue_compare
        award.decrement_day
      when 'Blue Distinction Plus'
        award.update_blue_distinction_plus
      when 'Blue Star'
        award.decrement_day
      else 
        award.update_normal_award
        award.decrement_day
    end
  end
end