// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// back button
import QrScanner from "qr-scanner";

console.log({ QrScanner });
window.QrScanner = QrScanner;
