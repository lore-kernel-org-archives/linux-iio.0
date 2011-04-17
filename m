Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35507 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab1DQTFC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2011 15:05:02 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 19/70] staging:iio:adc:ad7152 remove unregister of interrupt line.
Date: Sun, 17 Apr 2011 20:05:52 +0100
Message-Id: <1303067203-4894-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

a) This interface is going away
b) There is no matching register call so looks like a cut and paste
error

Trivial sparse warning fix.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 163c307..46a0b67 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -72,7 +72,8 @@ struct ad7152_conversion_mode {
 	u8 reg_cfg;
 };
 
-struct ad7152_conversion_mode ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
+static struct ad7152_conversion_mode
+ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
 	{ "idle", 0 },
 	{ "continuous-conversion", 1 },
 	{ "single-conversion", 2 },
@@ -567,8 +568,6 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 	struct ad7152_chip_info *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = chip->indio_dev;
 
-	if (client->irq && gpio_is_valid(irq_to_gpio(client->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
 	iio_device_unregister(indio_dev);
 	kfree(chip);
 
-- 
1.7.3.4

