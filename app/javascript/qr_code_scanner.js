import Quagga from 'quagga';

document.addEventListener('DOMContentLoaded', () => {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    console.error('Camera access not supported in this browser.');
    return;
  }

  Quagga.init({
    inputStream: {
      name: 'Live',
      type: 'LiveStream',
      target: document.querySelector('#video'), // The video element
      constraints: {
        facingMode: 'environment', // or 'user' for the front camera
      },
    },
    decoder: {
      readers: ['code_128_reader'], // Customize the barcode readers as needed
    },
  }, (err) => {
    if (err) {
      console.error('Quagga initialization error:', err);
      return;
    }

    Quagga.start();

    // Add an onProcessed handler to receive processed results
    Quagga.onProcessed((result) => {
      // You can perform additional actions with processed results here
    });

    // Add an onDetected handler to receive detected results
    Quagga.onDetected((result) => {
      alert(`QR Code detected: ${result.codeResult.code}`);
      Quagga.stop();
    });
  });
});
