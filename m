Return-Path: <SRS0=kG2y=N3=poczta.fm=sst@kernel.org>
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: potentiometer: mcp4131: use of_device_get_match_data()
Date: Fri, 16 Nov 2018 10:47:21 +0100
Message-Id: <20181116094722.1070-2-sst@poczta.fm>
In-Reply-To: <20181116094722.1070-1-sst@poczta.fm>
References: <20181116094722.1070-1-sst@poczta.fm>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Try to get the device's data using OF API. In case of failure, fallback
to the spi_get_device_id() method.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/mcp4131.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index b3e30db246cc..55f526a59215 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -42,6 +42,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #define MCP4131_WRITE		(0x00 << 2)
@@ -254,7 +255,9 @@ static int mcp4131_probe(struct spi_device *spi)
 	data = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 	data->spi = spi;
-	data->cfg = &mcp4131_cfg[devid];
+	data->cfg = of_device_get_match_data(&spi->dev);
+	if (!data->cfg)
+		data->cfg = &mcp4131_cfg[devid];
 
 	mutex_init(&data->lock);
 
@@ -273,7 +276,6 @@ static int mcp4131_probe(struct spi_device *spi)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mcp4131_dt_ids[] = {
 	{ .compatible = "microchip,mcp4131-502",
 		.data = &mcp4131_cfg[MCP413x_502] },
@@ -406,7 +408,6 @@ static const struct of_device_id mcp4131_dt_ids[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, mcp4131_dt_ids);
-#endif /* CONFIG_OF */
 
 static const struct spi_device_id mcp4131_id[] = {
 	{ "mcp4131-502", MCP413x_502 },
-- 
2.19.1
