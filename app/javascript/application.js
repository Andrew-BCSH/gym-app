// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"
// back button

import QrScanner from 'qr-scanner';

if (window.location.pathname === '/qr_code_scanner') {
  navigator.mediaDevices
    .getUserMedia({ video: { facingMode: "environment", width: 720, height: 720 }, audio: false }) // Request the rear camera and microphone
    .then((stream) => {

      console.log({ stream });
      const videoElement = document.querySelector('#camera1');
      videoElement.srcObject = stream;
      videoElement.play();

      console.log(videoElement);

      const qrScanner = new QrScanner(
        videoElement,
        (result) => {
          window.location.href = result.data;
        },
        {
          highlightScanRegion: true,
          highlightCodeOutline: true,
          returnDetailedScanResult: true,
        }
      );

      qrScanner.start();
    })
    .catch((error) => {
      console.error('Error! accessing rear camera and microphone:', error);
    });

}
