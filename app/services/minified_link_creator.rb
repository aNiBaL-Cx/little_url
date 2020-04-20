class MinifiedLinkCreator
  include Interactor

  def call

    context.minified_link = MinifiedLink.new(context.params)
    context.minified_link.original_url = context.minified_link.full_url unless context.minified_link.original_url.blank?

      ActiveRecord::Base.transaction do
        begin

          if context.minified_link.save!
            context.minified_link.update_column(:url_key, HashingService.instance.encode(context.minified_link.id))
          else
            context.errors = context.minified_link.errors
            context.fail!(message: 'Error saving MinifiedLink')
          end

        rescue Exception => e

          Rails.logger.error("SQL error in #{__method__}")
          ActiveRecord::Base.connection.execute 'ROLLBACK'

          Rails.logger.error("#{Time.now } EXCEPTION IN MinifiedLinkCreator #{e.message}")
          context.fail!(message: 'Error Saving')
        end
      end
  end
end
