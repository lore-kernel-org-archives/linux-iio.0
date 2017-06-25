Return-Path: <SRS0=3Myq=56=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 3/4] iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
Date: Sun, 25 Jun 2017 17:24:12 +0200
Message-Id: <20170625152413.22325-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170625152413.22325-1-lorenzo.bianconi@st.com>
References: <20170625152413.22325-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree support for L3G4200D, LSM330D, LSM330DL, LSM330DLC,
L3GD20, L3GD20H, L3G4IS, LSM330, LSM9DS0 gyroscope sensors

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/gyro/st_gyro_spi.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index fa14d8f2170d..0b52ed577dc2 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -18,6 +18,56 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_gyro.h"
 
+#ifdef CONFIG_OF
+/*
+ * For new single-chip sensors use <device_name> as compatible string.
+ * For old single-chip devices keep <device_name>-gyro to maintain
+ * compatibility
+ */
+static const struct of_device_id st_gyro_of_match[] = {
+	{
+		.compatible = "st,l3g4200d-gyro",
+		.data = L3G4200D_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330d-gyro",
+		.data = LSM330D_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dl-gyro",
+		.data = LSM330DL_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dlc-gyro",
+		.data = LSM330DLC_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,l3gd20-gyro",
+		.data = L3GD20_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,l3gd20h-gyro",
+		.data = L3GD20H_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,l3g4is-gyro",
+		.data = L3G4IS_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330-gyro",
+		.data = LSM330_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm9ds0-gyro",
+		.data = LSM9DS0_GYRO_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_gyro_of_match);
+#else
+#define st_gyro_of_match	NULL
+#endif
+
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -30,6 +80,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	gdata = iio_priv(indio_dev);
 
+	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
+				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
 	err = st_gyro_common_probe(indio_dev);
@@ -63,6 +115,7 @@ MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 static struct spi_driver st_gyro_driver = {
 	.driver = {
 		.name = "st-gyro-spi",
+		.of_match_table = of_match_ptr(st_gyro_of_match),
 	},
 	.probe = st_gyro_spi_probe,
 	.remove = st_gyro_spi_remove,
-- 
2.13.1
