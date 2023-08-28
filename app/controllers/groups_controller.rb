class GroupsController < ApplicationController
    
    
    def index
        @groups = Group.all
    end
    
    def new
        
    end
    
    def edit
       @group = Group.find(params[:id]) 
    end
    
    def show
       @group = Group.find(params[:id]) 
    end
    
    def update
       group = Group.find(params[:id])
       group.update(group_params.merge(:owner_id => current_user.id))
       redirect_to groups_path 
    end
    
    def create
        Group.create(group_params.merge(:owner_id => current_user.id))
        redirect_to groups_path
    end
    
    def join
        GroupUser.create(:user_id=>current_user.id,:group_id=>params[:id])
        redirect_to groups_path
    end
    
    def out_group
       group=GroupUser.find_by(:user_id=>current_user.id,:group_id=>params[:id])
       group.delete()
       redirect_to groups_path
    end
    
    def notice_an_event
        @group = Group.find(params[:id])
    end
    
    def send_email
        @group = Group.find(params[:id])
        
    end
    
    private
    
    def group_params
        params.require(:group).permit(:name,:introduction,:group_image)  
    end
end
