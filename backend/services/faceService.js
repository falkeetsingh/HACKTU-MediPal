const FormData = require('form-data');

const FACE_SERVICE_URL ='https://g8c4hvbd-8000.inc1.devtunnels.ms';
let fetchImpl;

const ensureFetch = async () => {
  if (fetchImpl) {
    return fetchImpl;
  }
  const { default: fetchFn } = await import('node-fetch');
  fetchImpl = fetchFn;
  return fetchImpl;
};

const callFaceApi = async (endpoint, formData) => {
  const fetch = await ensureFetch();

  const response = await fetch(`${FACE_SERVICE_URL}${endpoint}`, {
    method: 'POST',
    body: formData,
    headers: formData.getHeaders()
  });

  if (!response.ok) {
    const errorBody = await response.json().catch(() => ({}));
    const detail = errorBody.detail || errorBody.message || 'Face service request failed';
    throw new Error(detail);
  }

  return response.json();
};

const registerFace = async (userId, imageBuffer) => {
  const form = new FormData();
  form.append('user_id', userId);
  form.append('image', imageBuffer, {
    filename: `${userId}.jpg`,
    contentType: 'image/jpeg'
  });

  return callFaceApi('/api/face/register', form);
};

const verifyFace = async (userId, imageBuffer) => {
  const form = new FormData();
  form.append('user_id', userId);
  form.append('image', imageBuffer, {
    filename: `${userId}.jpg`,
    contentType: 'image/jpeg'
  });

  return callFaceApi('/api/face/verify', form);
};

module.exports = {
  registerFace,
  verifyFace
};
