import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="add-bookings"
export default class extends Controller {
  set_total_price(event) {
    event.preventDefault();

    // calcul du differentiel de jour
    const startDate =
      document.getElementById('booking_start_date')._flatpickr.selectedDates[0];
    const endDate =
      document.getElementById('booking_end_date')._flatpickr.selectedDates[0];
    const diffTime = Math.abs(endDate - startDate);
    const total_days = Math.floor(diffTime / (1000 * 60 * 60 * 24));

    // calcul du prix total en fonction des jours
    const dayPrice = parseInt(document.getElementById('day-price').value, 10);
    let totalPrice;
    if (endDate || startDate) {
      totalPrice = dayPrice * total_days;
    }

    if (totalPrice) {
      document.getElementById(
        'total-price-display'
      ).innerText = `${totalPrice} €`;
    } else {
      document.getElementById();
    }

    //? set total price for params[]
    document.getElementById('total-price').value = totalPrice;
  }
}
