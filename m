Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:59931 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494AbcFCMw1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Jun 2016 08:52:27 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 3609820B76
	for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2016 14:52:22 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 3/3] iio: mma8452: update Freescale company information
Date: Fri,  3 Jun 2016 14:51:52 +0200
Message-Id: <1464958312-2720-3-git-send-email-martink@posteo.de>
In-Reply-To: <1464958312-2720-1-git-send-email-martink@posteo.de>
References: <1464958312-2720-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

NXP took over Freescale, so add NXP to the driver descriptions

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/accel/Kconfig   | 4 ++--
 drivers/iio/accel/mma8452.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 3132587..89d7820 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -157,12 +157,12 @@ config MMA7660
 	  will be called mma7660.
 
 config MMA8452
-	tristate "Freescale MMA8452Q and similar Accelerometers Driver"
+	tristate "Freescale / NXP MMA8452Q and similar Accelerometers Driver"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for the following Freescale 3-axis
+	  Say yes here to build support for the following Freescale / NXP 3-axis
 	  accelerometers: MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC,
 	  FXLS8471Q.
 
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 4be2a18..799fe64 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1,5 +1,5 @@
 /*
- * mma8452.c - Support for following Freescale 3-axis accelerometers:
+ * mma8452.c - Support for following Freescale / NXP 3-axis accelerometers:
  *
  * device name	digital output	7-bit I2C slave address (pin selectable)
  * ---------------------------------------------------------------------
@@ -108,7 +108,7 @@ struct mma8452_data {
 };
 
 /**
- * struct mma_chip_info - chip specific data for Freescale's accelerometers
+ * struct mma_chip_info - chip specific data
  * @chip_id:			WHO_AM_I register's value
  * @channels:			struct iio_chan_spec matching the device's
  *				capabilities
@@ -1693,5 +1693,5 @@ static struct i2c_driver mma8452_driver = {
 module_i2c_driver(mma8452_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
-MODULE_DESCRIPTION("Freescale MMA8452 accelerometer driver");
+MODULE_DESCRIPTION("Freescale / NXP MMA8452 accelerometer driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4

