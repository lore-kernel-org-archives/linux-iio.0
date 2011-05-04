Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 24/99] staging:iio:adc:ad7314 remove unmatched unregister of event line.
Date: Wed,  4 May 2011 12:57:56 +0100
Message-Id: <1304510351-10922-25-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
