class QuotationMailer < ApplicationMailer
	default from: 'dggirosyremesas@gmail.com'

	def new_quotation(quotation)
		@quotation = quotation
		attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/logo.png"))
		if @quotation.user.type_person == 'normal'
			mail(to: @quotation.user.email, subject: 'Nueva Cotización')
		else
			mail(to: @quotation.gmail_user, subject: 'Nueva Cotización')
		end
				
	end

	def new_quotation_worker(quotation, worker)
		@quotation = quotation
		@worker = worker
		attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/logo.png"))
		mail(to: @worker.email, subject: 'Nueva Cotización')
	end

	def end_quotation(quotation)
		@quotation = quotation
		attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/logo.png"))
		if @quotation.user.type_person == 'normal'
			mail(to: @quotation.user.email, subject: 'Cotización Pagada')
		else
			mail(to: @quotation.gmail_user, subject: 'Cotización Pagada')
		end		
	end

	def end_quotation_worker(quotation, worker)
		@quotation = quotation
		@worker = worker
		attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/logo.png"))
		mail(to: @worker.email, subject: 'Cotización Pagada')
	end
end


