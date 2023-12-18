
import QrScanner from 'qr-scanner';

document.addEventListener('DOMContentLoaded', () => {
  setTimeout(() => {
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
  }, 300);

});
