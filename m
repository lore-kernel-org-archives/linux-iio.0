Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57517 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab1EDL4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:51 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 19/99] staging:iio:adc:ad7152 remove unregister of interrupt line.
Date: Wed,  4 May 2011 12:57:51 +0100
Message-Id: <1304510351-10922-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

a) This interface is going away
b) There is no matching register call so looks like a cut and paste
error

Trivial sparse warning fix.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 163c307..25715f0 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -7,15 +7,11 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/i2c.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -72,7 +68,8 @@ struct ad7152_conversion_mode {
 	u8 reg_cfg;
 };
 
-struct ad7152_conversion_mode ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
+static struct ad7152_conversion_mode
+ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
 	{ "idle", 0 },
 	{ "continuous-conversion", 1 },
 	{ "single-conversion", 2 },
@@ -567,8 +564,6 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 	struct ad7152_chip_info *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = chip->indio_dev;
 
-	if (client->irq && gpio_is_valid(irq_to_gpio(client->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
 	iio_device_unregister(indio_dev);
 	kfree(chip);
 
-- 
1.7.3.4

