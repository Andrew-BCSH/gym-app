import Quagga from 'quagga';

document.addEventListener('DOMContentLoaded', () => {
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
