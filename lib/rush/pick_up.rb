module Rush
  class PickUp
    attr_accessor :location, :contact, :special_instructions, :signature_required

    def initialize(opts)
      opts.each do |key, value|
        send("#{key}=", value)
      end
    end

    def to_json
      return {location:  location,
       'contact'=> contact,
       'special_instructions'=> special_instructions,
       'signature_required' => signature_required}
    end
  end
end
