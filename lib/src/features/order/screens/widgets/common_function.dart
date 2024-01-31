String formatTotalPrice(double grandTotal) {

  if (grandTotal < 1000) {
    return grandTotal.toStringAsFixed(0); // Format without decimal places
  } else if (grandTotal < 10000) {
    return '${(grandTotal / 1000).toStringAsFixed(1)}k'; // Format with one decimal place and 'k'
  } else if (grandTotal < 100000) {
    return '${(grandTotal / 1000).toStringAsFixed(0)}k'; // Format without decimal places and 'k'
  } else {
    return '${(grandTotal / 1000).toStringAsFixed(1)}k'; // Format with one decimal place and 'k'
  }
}