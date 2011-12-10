Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56671 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1LJPjs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2011 10:39:48 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] staging:iio: iio_trigger contains defunct owner field. Remove it.
Date: Sat, 10 Dec 2011 15:39:48 +0000
Message-Id: <1323531588-23293-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1323531588-23293-1-git-send-email-jic23@kernel.org>
References: <1323531588-23293-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This field moved into the trigger_ops structure a while back, but somehow
never quite got cleared up.  This clears the last few drivers to set it
(nothing uses it) and gets rid of it entirely.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7192.c                   |    1 -
 drivers/staging/iio/adc/ad7793.c                   |    1 -
 drivers/staging/iio/trigger.h                      |    2 --
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    1 -
 4 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 6114601..dfeb4ba 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -637,7 +637,6 @@ static int ad7192_probe_trigger(struct iio_dev *indio_dev)
 	disable_irq_nosync(st->spi->irq);
 	st->irq_dis = true;
 	st->trig->dev.parent = &st->spi->dev;
-	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = indio_dev;
 
 	ret = iio_trigger_register(st->trig);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index f33feee..1d4ffbb 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -504,7 +504,6 @@ static int ad7793_probe_trigger(struct iio_dev *indio_dev)
 	disable_irq_nosync(st->spi->irq);
 	st->irq_dis = true;
 	st->trig->dev.parent = &st->spi->dev;
-	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = indio_dev;
 
 	ret = iio_trigger_register(st->trig);
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 5cc42a6..1cfca23 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -46,7 +46,6 @@ struct iio_trigger_ops {
  * @private_data:	[DRIVER] device specific data
  * @list:		[INTERN] used in maintenance of global trigger list
  * @alloc_list:		[DRIVER] used for driver specific trigger list
- * @owner:		[DRIVER] used to monitor usage count of the trigger.
  * @use_count:		use count for the trigger
  * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
  * @subirq_base:	[INTERN] base number for irqs provided by trigger.
@@ -63,7 +62,6 @@ struct iio_trigger {
 	void				*private_data;
 	struct list_head		list;
 	struct list_head		alloc_list;
-	struct module			*owner;
 	int use_count;
 
 	struct irq_chip			subirq_chip;
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index d35d085..bd7416b 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -125,7 +125,6 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 			goto error_put_trigger_and_remove_from_list;
 		}
 		trig->private_data = trig_info;
-		trig->owner = THIS_MODULE;
 		trig->ops = &iio_prtc_trigger_ops;
 		/* RTC access */
 		trig_info->rtc
-- 
1.7.7.4

