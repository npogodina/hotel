module Hotel
  class ReservationDesk
    attr_reader :room_num, :rooms, :reservations

    def initialize(room_num: 20)
      @room_num = room_num
      @rooms = make_rooms
      @reservations = [] 
      #TODO: not needed?
    end

    def find_room_by_id(id)
      rooms.find {|room| room.id == id}
    end

    def find_reservations(room_id: , start_date: , end_date: )
      room = rooms.find { |room| room.id == room_id}
      return nil if room == nil

      date_range = DateRange.new(start_date: start_date, end_date: end_date)
      
      reservations = room.reservations.select { |reservation| 
        reservation.date_range.overlap? (date_range)
      }
    end

    # def find_reservations(room_id: nil , start_date: nil, end_date: nil)
    #   room = rooms.find { |room| room.id == room_id}
    #   return nil if room == nil

    #   return room.reservations if (start_date == nil && end_date == nil)

    #   if end_date == nil
    #     start_date = Date.parse(start_date)
    #     reservations = room.reservations.select { |reservation| 
    #       start_date < reservation.end_date
    #     }
    #   elsif start_date == nil
    #     end_date = Date.parse(end_date)
    #     reservations = room.reservations.select { |reservation| 
    #       end_date > reservation.start_date 
    #     }
    #   else
    #     start_date = Date.parse(start_date)
    #     end_date = Date.parse(end_date)
    #     # date_range = (start_date..end_date)
    #     reservations = room.reservations.select { |reservation| 
    #       start_date < reservation.end_date && end_date > reservation.start_date 
    #     }
    #   end
    #   return reservations
      
    #   #TODO: add date_range class and refactor
    # end

    def new_reservation(room_id: , start_date: , end_date: )
      raise ArgumentError.new("Invalid room ID.") unless rooms.find {|room| room.id == room_id}
      Reservation.new(room_id: room_id, start_date: start_date, end_date: end_date)
    end

    def add_reservation(new_reservation)
      room = find_room_by_id(new_reservation.room_id)
      room.reservations << new_reservation
    end

    private
    def make_rooms
      rooms = []
      room_num.times do |i|
        rooms << Room.new(i+1)
      end
      return rooms
    end

  end
end