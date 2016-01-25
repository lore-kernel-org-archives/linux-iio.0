Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45998 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbcAYWaU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2016 17:30:20 -0500
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net,
	Richard Weinberger <richard@nod.at>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 16/22] iio: imu: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:15 +0100
Message-Id: <1453760661-1444-17-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not every arch has io memory.
While the driver has correct dependencies the select statement
will bypass the HAS_IOMEM dependency.
So, unbreak the build by rendering it into a real dependency.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/imu/inv_mpu6050/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 48fbc0b..8f8d137 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -5,9 +5,9 @@
 config INV_MPU6050_IIO
 	tristate "Invensense MPU6050 devices"
 	depends on I2C && SYSFS
+	depends on I2C_MUX
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	select I2C_MUX
 	help
 	  This driver supports the Invensense MPU6050 devices.
 	  This driver can also support MPU6500 in MPU6050 compatibility mode
-- 
1.8.4.5

