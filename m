Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:46002 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbcCYWqU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:20 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 8/8] iio: imu: Fix inv_mpu6050 dependencies
Date: Fri, 25 Mar 2016 23:40:55 +0100
Message-Id: <1458945655-5027-8-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have io memory.
Instead of selecting I2C_MUX (and bypassing the HAS_IOMEM dependency)
depend directly on it.

Fixes the following kconfig warning:
warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
And this build error:
ERROR: "devm_ioremap_resource" [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
ERROR: "of_address_to_resource" [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/imu/inv_mpu6050/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index a7f557a..847455a 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -9,9 +9,8 @@ config INV_MPU6050_IIO
 
 config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices (I2C)"
-	depends on I2C
+	depends on I2C_MUX
 	select INV_MPU6050_IIO
-	select I2C_MUX
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050 devices.
-- 
1.8.4.5

