class RelationshipsController < ApplicationController
    def create
        Relationship.create(:follower_id=>current_user.id,:followed_id=>params[:id])
        redirect_back fallback_location: root_path
    end
    def destroy
        relation = Relationship.where(:follower_id=>current_user.id,:followed_id=>params[:id]).first
        relation.delete()
        redirect_back fallback_location: root_path
    end
end
