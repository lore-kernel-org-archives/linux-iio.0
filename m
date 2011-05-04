Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 48/99] staging:iio:ad7606 conversion to irq_chip based polling.
Date: Wed,  4 May 2011 12:58:20 +0100
Message-Id: <1304510351-10922-49-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I'm far from sure what the best way to handle this particular
part is, so have (I think) done the absolute minimum to change
it to the new interface.

V2: Trivial constification of device name.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7606.h      |    2 +-
 drivers/staging/iio/adc/ad7606_core.c |    1 +
 drivers/staging/iio/adc/ad7606_ring.c |   28 ++++++++++++++++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 338bade..b8563bf 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -50,7 +50,7 @@ struct ad7606_platform_data {
  */
 
 struct ad7606_chip_info {
-	char				name[10];
+	const char 			*name;
 	u8				bits;
 	char				sign;
 	u16				int_vref_mv;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 7ef9a6f..27090b9 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -458,6 +458,7 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->indio_dev->name = st->chip_info->name;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index b32cb0d..43caced 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -157,16 +157,19 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 }
 
 /**
- * ad7606_poll_func_th() th of trigger launched polling to ring buffer
+ * ad7606_trigger_handler_th() th of trigger launched polling to ring buffer
  *
  **/
-static void ad7606_poll_func_th(struct iio_dev *indio_dev, s64 time)
+static irqreturn_t ad7606_trigger_handler_th(int irq, void *p)
 {
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->private_data;
 	struct ad7606_state *st = indio_dev->dev_data;
 	gpio_set_value(st->pdata->gpio_convst, 1);
 
-	return;
+	return IRQ_HANDLED;
 }
+
 /**
  * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
  * @work_s:	the work struct through which this was scheduled
@@ -245,10 +248,20 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7606_poll_func_th);
-	if (ret)
+	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
-
+	}
+	indio_dev->pollfunc->private_data = indio_dev;
+	indio_dev->pollfunc->h = &ad7606_trigger_handler_th;
+	indio_dev->pollfunc->name =
+		kasprintf(GFP_KERNEL, "%s_consumer%d", indio_dev->name,
+			  indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->preenable = &ad7606_ring_preenable;
@@ -262,6 +275,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -275,6 +290,7 @@ void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
