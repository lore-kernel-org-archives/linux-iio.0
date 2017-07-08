Return-Path: <SRS0=khi1=6L=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com
Subject: [PATCH 2/3] iio: accel: st_accel_spi: add support to H3LIS331DL, LIS331DL, LIS3LV02DL
Date: Sat,  8 Jul 2017 13:00:17 +0200
Message-Id: <20170708110018.12772-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170708110018.12772-1-lorenzo.bianconi@st.com>
References: <20170708110018.12772-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_spi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 6b2eafa45cbb..7a2a0384b42d 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -31,6 +31,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.data = LIS3LV02DL_ACCEL_DEV_NAME,
 	},
 	{
+		.compatible = "st,lis3lv02dl-accel",
+		.data = LIS3LV02DL_ACCEL_DEV_NAME,
+	},
+	{
 		.compatible = "st,lis3dh-accel",
 		.data = LIS3DH_ACCEL_DEV_NAME,
 	},
@@ -70,6 +74,14 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lng2dm-accel",
 		.data = LNG2DM_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,h3lis331dl-accel",
+		.data = H3LIS331DL_DRIVER_NAME,
+	},
+	{
+		.compatible = "st,lis331dl-accel",
+		.data = LIS331DL_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -118,6 +130,9 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS2DH12_ACCEL_DEV_NAME },
 	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{ LNG2DM_ACCEL_DEV_NAME },
+	{ H3LIS331DL_DRIVER_NAME },
+	{ LIS331DL_ACCEL_DEV_NAME },
+	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.13.1
