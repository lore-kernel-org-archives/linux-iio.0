Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53922 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186Ab1ERNkE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 024/111] staging:iio:adc:ad7314 remove unmatched unregister of event line.
Date: Wed, 18 May 2011 14:41:14 +0100
Message-Id: <1305726161-5606-25-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7314.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index dffbec1..bc34e29 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -6,16 +6,11 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
-#include <linux/rtc.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -262,8 +257,6 @@ static int __devexit ad7314_remove(struct spi_device *spi_dev)
 	struct iio_dev *indio_dev = chip->indio_dev;
 
 	dev_set_drvdata(&spi_dev->dev, NULL);
-	if (spi_dev->irq)
-		iio_unregister_interrupt_line(indio_dev, 0);
 	iio_device_unregister(indio_dev);
 	iio_free_device(chip->indio_dev);
 	kfree(chip);
-- 
1.7.3.4

