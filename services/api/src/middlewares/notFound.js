export function notFoundHandler(req, res, _next) {
  res.status(404).json({
    error: {
      message: `Ruta no encontrada: ${req.method} ${req.originalUrl}`,
      statusCode: 404
    }
  });
}
