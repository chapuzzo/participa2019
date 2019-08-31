
require_dependency Rails.root.join('app', 'models', 'verification', 'residence').to_s

class Verification::Residence

  validate :postal_code_in_ondara
  validate :residence_in_ondara

  def postal_code_in_ondara
    errors.add(:postal_code, I18n.t('verification.residence.new.error_not_allowed_postal_code')) unless valid_postal_code?
  end

  def residence_in_ondara
    return if errors.any?

    unless residency_valid?
      errors.add(:residence_in_ondara, false)
      store_failed_attempt
      Lock.increase_tries(user)
    end
  end

  private

    def valid_postal_code?
      postal_code =~ /^03760$/
    end

end
