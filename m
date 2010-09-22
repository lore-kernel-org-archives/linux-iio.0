Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 8/8] staging:iio:adis16350 add support for the adis16367
Date: Wed, 22 Sep 2010 12:47:53 +0100
Message-Id: <1285156073-6327-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
References: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/Kconfig          |    6 +++---
 drivers/staging/iio/imu/adis16350.h      |    1 +
 drivers/staging/iio/imu/adis16350_core.c |   23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 9853fb3..b3ca516 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -4,14 +4,14 @@
 comment "Inertial measurement units"
 
 config ADIS16350
-	tristate "Analog Devices ADIS16350/00/54/55/60/62/64/65 IMU SPI driver"
+	tristate "Analog Devices ADIS16350/00/54/55/60/62/64/65/67 IMU SPI driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	select IIO_SW_RING if IIO_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16350,
-	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16400 and
-	  adis16405 high precision tri-axis inertial sensor.
+	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16367,
+	  adis16400 and  adis16405 high precision tri-axis inertial sensor.
 
 if ADIS16350
 config ADIS16350_EVENT
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index 20afe7e..96b2700 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -108,6 +108,7 @@ enum adis16350_chip_variants {
 	adis16300,
 	adis16350,
 	adis16360,
+	adis16367,
 	adis16400,
 };
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 9c6a2ea..0e5ccdc 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -795,6 +795,28 @@ static struct adis16350_chip_info adis16350_variants[] = {
 		.scan_el_group = &adis16350_scan_el_group,
 #endif
 	},
+	[adis16367] = {
+		.attribute_group = &adis16350_attribute_group,
+		.burst_available = 1,
+		.gyro_scale = "0.003490658503",
+		.accel_scale = "0.032688800644",
+		.burst_length = 22,
+		.all_mask =
+		BIT(ADIS16350_SCAN_IN_SUPPLY) |
+		BIT(ADIS16350_SCAN_GYRO_X) |
+		BIT(ADIS16350_SCAN_GYRO_Y) |
+		BIT(ADIS16350_SCAN_GYRO_Z) |
+		BIT(ADIS16350_SCAN_ACCEL_X) |
+		BIT(ADIS16350_SCAN_ACCEL_Y) |
+		BIT(ADIS16350_SCAN_ACCEL_Z) |
+		BIT(ADIS16350_SCAN_TEMP_X) |
+		BIT(ADIS16350_SCAN_TEMP_Y) |
+		BIT(ADIS16350_SCAN_TEMP_Z) |
+		BIT(ADIS16350_SCAN_IN0),
+#ifdef CONFIG_IIO_RING_BUFFER
+		.scan_el_group = &adis16350_scan_el_group,
+#endif
+	},
 	[adis16400] = {
 		.attribute_group = &adis16400_attribute_group,
 		.burst_available = 1,
@@ -960,6 +982,7 @@ static const struct spi_device_id adis16350_id[] = {
 	{"adis16362", adis16360},
 	{"adis16364", adis16360},
 	{"adis16365", adis16360},
+	{"adis16367", adis16367},
 	{"adis16400", adis16400},
 	{"adis16405", adis16400},
 	{}
-- 
1.7.2.2
