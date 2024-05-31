import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="add-bookings"
export default class extends Controller {
  set_total_price() {
    // calcul du differentiel de jour
    const dates = document.getElementById("dates")._flatpickr.selectedDates;
    const endDate = dates[1];
    const startDate = dates[0];


    const diffTime = endDate - startDate;
    const total_days = Math.floor(diffTime / (1000 * 60 * 60 * 24)) + 1;

    // calcul du prix total en fonction des jours
    const dayPrice = parseInt(document.getElementById('day-price').value, 10);

    let totalPrice = dayPrice * total_days;

    if (totalPrice) {
      document.getElementById(
        'total-price-display'
      ).innerText = `${totalPrice} €`;
    } else {
      document.getElementById('total-price-display').innerText = '';
    }

    //? set total price for params[]
    document.getElementById('total-price').value = totalPrice;
  }

  check_dates() {
    const dates =
      document.getElementById("dates")._flatpickr.selectedDates;
    const endDate = dates[1]
    const startDate = dates[0];

    const aircraftEndDate = new Date(
      document.getElementById('aircraft-end').value
    );
    const aircraftStartDate = new Date(
      document.getElementById('aircraft-start').value
    );

    if (
      startDate < aircraftStartDate ||
      endDate > aircraftEndDate ||
      startDate > aircraftEndDate ||
      endDate < aircraftStartDate
    ) {
      document.getElementById('submit').style.display = 'none';
      document.getElementById('alert').style.display = 'block';
    } else {
      document.getElementById('submit').style.display = 'block';
      document.getElementById('alert').style.display = 'none';
    }
  }
}
