export const SITE = {
  name: 'Your Business',
  shortName: 'yourbrand',
  domain: 'example.com',
  url: 'https://example.com',
  email: 'hello@example.com',
  whatsappNumber: '94700000000',
};

export const WHATSAPP_URL = `https://wa.me/${SITE.whatsappNumber}?text=${encodeURIComponent(
  "Hi, I'd like to know more."
)}`;
