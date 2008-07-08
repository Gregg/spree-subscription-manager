# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SubscriptionManagerExtension < Spree::Extension
  version "0.1"
  description "This extension will allow you to ask new users if they want to subscribe to a mailing list."
  url "http://github.com/Gregg/spree_subscription_manager"

  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :mailing_lists
    end
  end

  def activate

    # Add a partial to get mailing list fields rendered on the user form
    UsersController.class_eval do
      before_filter :add_mailing_list_fields
      def add_mailing_list_fields
        @extension_partials << 'mailing_lists'
      end
    end
    
    # Add a link to the mailing list administration page on the configuration page
    Admin::ConfigurationsController.class_eval do
      before_filter :add_mailing_list_links, :only => :index

      def add_mailing_list_links
        @extension_links << {:link => admin_mailing_lists_path, :link_text => t('Mailing Lists'), :description => "Add Mailing Lists your users can opt-in to."}
      end

    end
    
    # Add mailing list functionality to the user model
    User.class_eval do
      has_many :subscriptions
      has_many :mailing_lists, :through => :subscriptions
      attr_accessible :mailing_list
      
      # Use this to subscribe the user from the main form.
      def mailing_list= (val)
        self.subscriptions.each {|sub| sub.destroy }
        self.mailing_lists = []
        val.keys.each do |key|
          self.mailing_lists.push MailingList.find(key.to_i) unless key.to_i == 0
        end
      end
    end
  end
  
  def deactivate
    # admin.tabs.remove "Subscription Manager"
  end
  
end