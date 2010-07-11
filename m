Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/12] staging:iio:imu allow adis16300 and adis16400 to build without ring buffer support.
Date: Sun, 11 Jul 2010 16:39:13 +0100
Message-Id: <1278862759-19028-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/imu/Kconfig |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 48a712e..31a6233 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -6,9 +6,8 @@ comment "Inertial measurement units"
 config ADIS16300
 	tristate "Analog Devices ADIS16300 IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING
-	select IIO_RING_BUFFER
-	select IIO_TRIGGER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300 four degrees
 	  of freedom inertial sensor.
@@ -25,9 +24,8 @@ config ADIS16350
 config ADIS16400
 	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING
-	select IIO_RING_BUFFER
-	select IIO_TRIGGER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16400/5 triaxial
 	  inertial sensor with Magnetometer.
-- 
1.7.0.4
