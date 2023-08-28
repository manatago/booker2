class MessagesController < ApplicationController
    
    def index
        if current_user.id != params[:speaker].to_i
           redirect_to root_path 
        end
        @messages = Message.where(:speaker=>params[:speaker],:target=>params[:target]).or(Message.where(:speaker=>params[:target],:target=>params[:speaker])).order("created_at desc")
    end
    
    def create
        if current_user.id != params[:speaker].to_i
           redirect_to root_path 
        end
        Message.create(message_params.merge({:speaker_id=>params[:speaker].to_i,:target_id=>params[:target].to_i}))
        redirect_back fallback_location: root_path
    end
    
    private
    def message_params
        params.require(:message).permit(:message)   
    end
    
    
end
