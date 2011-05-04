Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/99] staging:iio:dac:ad5504 move from old to new event handling.
Date: Wed,  4 May 2011 12:57:46 +0100
Message-Id: <1304510351-10922-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Untested, but fairly trivial change here.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5504.c |   53 +++++++++++--------------------------
 drivers/staging/iio/dac/ad5504.h |    4 ---
 2 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 28ace30..5534c41 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -261,35 +261,18 @@ static struct attribute_group ad5504_ev_attribute_group = {
 	.attrs = ad5504_ev_attributes,
 };
 
-static void ad5504_interrupt_bh(struct work_struct *work_s)
+static irqreturn_t ad5504_event_handler(int irq, void *private)
 {
-	struct ad5504_state *st = container_of(work_s,
-		struct ad5504_state, work_alarm);
-
-	iio_push_event(st->indio_dev, 0,
-			IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP,
-			0,
-			IIO_EV_TYPE_THRESH,
-			IIO_EV_DIR_RISING),
-			st->last_timestamp);
-
-	enable_irq(st->spi->irq);
-}
-
-static int ad5504_interrupt(struct iio_dev *dev_info,
-		int index,
-		s64 timestamp,
-		int no_test)
-{
-	struct ad5504_state *st = dev_info->dev_data;
-
-	st->last_timestamp = timestamp;
-	schedule_work(&st->work_alarm);
-	return 0;
+	iio_push_event(private, 0,
+		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP,
+					    0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_RISING),
+		       iio_get_time_ns());
+
+	return IRQ_HANDLED;
 }
 
-IIO_EVENT_SH(ad5504, &ad5504_interrupt);
-
 static int __devinit ad5504_probe(struct spi_device *spi)
 {
 	struct ad5504_platform_data *pdata = spi->dev.platform_data;
@@ -342,18 +325,14 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 		goto error_free_dev;
 
 	if (spi->irq) {
-		INIT_WORK(&st->work_alarm, ad5504_interrupt_bh);
-
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_FALLING,
-				spi_get_device_id(st->spi)->name);
+		ret = request_threaded_irq(spi->irq,
+					   NULL,
+					   &ad5504_event_handler,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   spi_get_device_id(st->spi)->name,
+					   st->indio_dev);
 		if (ret)
 			goto error_unreg_iio_device;
-
-		iio_add_event_to_list(&iio_event_ad5504,
-				&st->indio_dev->interrupts[0]->ev_list);
 	}
 
 	return 0;
@@ -379,7 +358,7 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 	struct ad5504_state *st = spi_get_drvdata(spi);
 
 	if (spi->irq)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
+		free_irq(spi->irq, st->indio_dev);
 
 	iio_device_unregister(st->indio_dev);
 
diff --git a/drivers/staging/iio/dac/ad5504.h b/drivers/staging/iio/dac/ad5504.h
index d2fac63..13ef353 100644
--- a/drivers/staging/iio/dac/ad5504.h
+++ b/drivers/staging/iio/dac/ad5504.h
@@ -45,8 +45,6 @@ struct ad5504_platform_data {
  * @us:			spi_device
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
- * @work_alarm:		bh work structure for event handling
- * @last_timestamp:	timestamp of last event interrupt
  * @pwr_down_mask	power down mask
  * @pwr_down_mode	current power down mode
  */
@@ -56,8 +54,6 @@ struct ad5504_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
 	unsigned short			vref_mv;
-	struct work_struct		work_alarm;
-	s64				last_timestamp;
 	unsigned			pwr_down_mask;
 	unsigned			pwr_down_mode;
 };
-- 
1.7.3.4
