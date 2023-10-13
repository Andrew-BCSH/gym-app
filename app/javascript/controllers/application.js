import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

//= require qr-code-scanner

import 'qr-code-scanner';

import Quagga from 'quagga';


document.addEventListener('DOMContentLoaded', () => {
  Quagga.init({
    inputStream: {
      type: 'LiveStream',
      constraints: {
        width: 640,
        height: 480,
        facingMode: 'environment',
      },
    },
    locator: {
      patchSize: 'medium',
      halfSample: true,
    },
    numOfWorkers: 2,
    decoder: {
      readers: ['code_128_reader'],
    },
  }, (err) => {
    if (err) {
      console.error(err);
      return;
    }
    Quagga.start();
  });

  Quagga.onDetected((result) => {
    alert(`QR Code detected: ${result.codeResult.code}`);
    Quagga.stop();
  });
});
