export function errorHandler(err, _req, res, _next) {
  const statusCode = err.statusCode || err.status || 500;
  const isProduction = process.env.NODE_ENV === 'production';

  const response = {
    error: {
      message: err.message || 'Error interno del servidor',
      statusCode
    }
  };

  if (!isProduction && err.stack) {
    response.error.stack = err.stack;
  }

  res.status(statusCode).json(response);
}
