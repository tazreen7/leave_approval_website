class SessionsController < ApplicationController
    def new
        
        # render new.html.erb... the login page
      end
    
      def create
        # Look up User in db by the email address submitted to the login form and
        # convert to lowercase to match email in db in case they had caps lock on:
        user = User.find_by(email: params[:login][:email].downcase)
       # @posts = Post.find(:all)
        
        # Verify user exists in db and run has_secure_password's .authenticate() 
        # method to see if the password submitted on the login form was correct: 
        if user && user.authenticate(params[:login][:password]) 
          # Save the user.id in that user's session cookie:
          session[:user_id] = params[:login][:email]
           redirect_to '/userinfos/userinfo'
        else
          # if email or password incorrect, re-render login page:
          flash.now.alert = "Incorrect email or password, try again."
          render :new
        end
      end
    
      
      def destroy
        # delete the saved user_id key/value from the cookie:
        session.delete(:user_id)
        redirect_to login_path, notice: "Logged out!"
      end
      
      def index
       User.find_by(email:session[:user_id])
      end
   
end
