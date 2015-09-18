class Checkins
  def collect_checkins
    payload_business = { 'fields': 'checkins' }
    Business.select('business_id').find_in_batches(batch_size: 50) do |places|
      results = FB.batch do |batch_api|
        Retryable.retryable(
          tries: 10,
          on: Faraday::ConnectionFailed,
          sleep: ->(n) { 4**n }
        ) do
          places.each do |place|
            if Checkin.find_by_id(place.business_id).nil?
              batch_api.get_object(place['business_id'].to_s, payload_business)
            else
              next
          end
        end
      end
      results.each do |result|
        enter_into_checkin(result)
      end
    end
  end

  def enter_into_checkin(result)
    begin
      business_id = result['id']
      if result.key?('checkins')
        checkins = result['checkins']
      else
        checkins = NULL
      end
    rescue NoMethodError
      return
    end
    begin
      @checkin = Checkin.new(business_id: business_id, checkins: checkins)
      @checkin.save
    rescue ActiveRecord::RecordNotUnique
      print('Error Inserting to DB')
    end
  end
end
