import Typed from 'typed.js';

const graduallyType = () => {
  const typed = new Typed("#banner-message", {strings: ["Join the community and start sharing now!"], typeSpeed: 60, loop: true, showCursor: false,});
};

export { graduallyType };
