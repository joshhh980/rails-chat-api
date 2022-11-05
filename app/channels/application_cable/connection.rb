module ApplicationCable  
  class Connection < ActionCable::Connection::Base    
    identified_by :current_user

    def connect      
      self.current_user = find_verified_user    
    end     

    def params
      request.query_parameters
    end

    private      
      def find_verified_user
        uid = params[:uid]
        token = params[:token]
        client_id = params[:client]

        user = User.find_by_uid(uid)

        if user && user.valid_token?(token, client_id)          
          user        
        else          
          reject_unauthorized_connection        
        end      
      end  
  end
end