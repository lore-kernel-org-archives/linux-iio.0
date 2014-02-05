Return-Path: <slm@iis.fraunhofer.de>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk
Cc: Ge Gao <ggao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: imu: mpu6050: Move config entry into IMU menu
Date: Wed,  5 Feb 2014 11:34:33 +0100
Message-Id: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/iio/imu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 663e88a..2b0e451 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -25,6 +25,8 @@ config ADIS16480
 	  Say yes here to build support for Analog Devices ADIS16375, ADIS16480,
 	  ADIS16485, ADIS16488 inertial sensors.
 
+source "drivers/iio/imu/inv_mpu6050/Kconfig"
+
 endmenu
 
 config IIO_ADIS_LIB
@@ -38,5 +40,3 @@ config IIO_ADIS_LIB_BUFFER
 	help
 	  A set of buffer helper functions for the Analog Devices ADIS* device
 	  family.
-
-source "drivers/iio/imu/inv_mpu6050/Kconfig"
-- 
1.8.3.2
