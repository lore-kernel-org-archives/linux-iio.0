Return-Path: <SRS0=E+Nj=57=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org
Subject: [PATCH v3 1/4] iio: accel: st_accel_spi: add OF capability to st_accel_spi
Date: Tue, 27 Jun 2017 00:53:43 +0200
Message-Id: <20170626225346.12019-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170626225346.12019-1-lorenzo.bianconi@st.com>
References: <20170626225346.12019-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree support for LIS3DH, LSM330D, LSM330DL, LSM330DLC,
LIS331DLH, LSM330, LSM303AGR, LIS2DH12, LIS3L02DQ, LNG2DM accel sensors.
Fix LIS302DL support defining of_device_id data field in st_accel_of_match
table

Fixes: 762227721fe6 (iio: accel: st_accel: handle deprecated bindings)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_spi.c | 69 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index d13742edee0e..6b2eafa45cbb 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -18,6 +18,65 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_accel.h"
 
+#ifdef CONFIG_OF
+/*
+ * For new single-chip sensors use <device_name> as compatible string.
+ * For old single-chip devices keep <device_name>-accel to maintain
+ * compatibility
+ */
+static const struct of_device_id st_accel_of_match[] = {
+	{
+		/* An older compatible */
+		.compatible = "st,lis302dl-spi",
+		.data = LIS3LV02DL_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis3dh-accel",
+		.data = LIS3DH_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330d-accel",
+		.data = LSM330D_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dl-accel",
+		.data = LSM330DL_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dlc-accel",
+		.data = LSM330DLC_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis331dlh-accel",
+		.data = LIS331DLH_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330-accel",
+		.data = LSM330_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303agr-accel",
+		.data = LSM303AGR_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis2dh12-accel",
+		.data = LIS2DH12_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis3l02dq",
+		.data = LIS3L02DQ_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lng2dm-accel",
+		.data = LNG2DM_ACCEL_DEV_NAME,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, st_accel_of_match);
+#else
+#define st_accel_of_match	NULL
+#endif
+
 static int st_accel_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -30,6 +89,8 @@ static int st_accel_spi_probe(struct spi_device *spi)
 
 	adata = iio_priv(indio_dev);
 
+	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
+				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, adata);
 
 	err = st_accel_common_probe(indio_dev);
@@ -61,14 +122,6 @@ static const struct spi_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 
-#ifdef CONFIG_OF
-static const struct of_device_id st_accel_of_match[] = {
-	{ .compatible = "st,lis302dl-spi" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, st_accel_of_match);
-#endif
-
 static struct spi_driver st_accel_driver = {
 	.driver = {
 		.name = "st-accel-spi",
-- 
2.13.1
