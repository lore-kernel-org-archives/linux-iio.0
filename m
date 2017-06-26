Return-Path: <SRS0=E+Nj=57=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org
Subject: [PATCH v3 2/4] iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
Date: Tue, 27 Jun 2017 00:53:44 +0200
Message-Id: <20170626225346.12019-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170626225346.12019-1-lorenzo.bianconi@st.com>
References: <20170626225346.12019-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree support for LIS3MDL and LSM303AGR magnetometer sensors

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index f3cb4dc05391..1ea64dd318aa 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -18,6 +18,28 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_magn.h"
 
+#ifdef CONFIG_OF
+/*
+ * For new single-chip sensors use <device_name> as compatible string.
+ * For old single-chip devices keep <device_name>-magn to maintain
+ * compatibility
+ */
+static const struct of_device_id st_magn_of_match[] = {
+	{
+		.compatible = "st,lis3mdl-magn",
+		.data = LIS3MDL_MAGN_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303agr-magn",
+		.data = LSM303AGR_MAGN_DEV_NAME,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, st_magn_of_match);
+#else
+#define st_magn_of_match	NULL
+#endif
+
 static int st_magn_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -30,6 +52,8 @@ static int st_magn_spi_probe(struct spi_device *spi)
 
 	mdata = iio_priv(indio_dev);
 
+	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
+				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
 	err = st_magn_common_probe(indio_dev);
@@ -57,6 +81,7 @@ MODULE_DEVICE_TABLE(spi, st_magn_id_table);
 static struct spi_driver st_magn_driver = {
 	.driver = {
 		.name = "st-magn-spi",
+		.of_match_table = of_match_ptr(st_magn_of_match),
 	},
 	.probe = st_magn_spi_probe,
 	.remove = st_magn_spi_remove,
-- 
2.13.1
