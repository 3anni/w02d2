require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, room_hash)
        @name = name
        @rooms = Hash.new()

        room_hash.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def room_exists?(room_name)
        @rooms.has_key?(room_name)
    end

    def check_in(person, room_name)
        if self.room_exists?(room_name)
            @rooms[room_name].add_occupant(person) ? (puts "check in successful") : (puts "sorry, room is full")
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @rooms.any? do |name, room|
            !room.full?
        end
    end

    def list_rooms
        @rooms.each do |name, room|
            puts name + room.available_space.to_s
        end
    end
end
