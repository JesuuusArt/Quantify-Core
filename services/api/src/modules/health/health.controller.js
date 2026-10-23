const startTime = Date.now();

export function getHealth(_req, res) {
  const uptimeSeconds = Math.floor((Date.now() - startTime) / 1000);

  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: uptimeSeconds,
    service: 'quantify-api',
    version: '1.0.0'
  });
}
