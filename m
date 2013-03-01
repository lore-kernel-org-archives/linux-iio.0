Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59556 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3CAPVx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 10:21:53 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Ge Gao <ggao@invensense.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iio/imu: inv_mpu6050 depends on IIO_BUFFER
Date: Fri,  1 Mar 2013 07:21:26 -0800
Message-Id: <1362151286-7338-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix:

drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c: In function ‘inv_mpu6050_read_fifo’:
drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:176:3: error: implicit declaration of
function ‘iio_push_to_buffers’ [-Werror=implicit-function-declaration]

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/imu/inv_mpu6050/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index b5cfa3a..361b232 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -5,6 +5,7 @@
 config INV_MPU6050_IIO
 	tristate "Invensense MPU6050 devices"
 	depends on I2C && SYSFS
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  This driver supports the Invensense MPU6050 devices.
-- 
1.7.9.7

