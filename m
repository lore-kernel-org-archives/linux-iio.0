Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 48/70] staging:iio:ad7606 conversion to irq_chip based polling.
Date: Sun, 17 Apr 2011 20:06:21 +0100
Message-Id: <1303067203-4894-49-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I'm far from sure what the best way to handle this particular
part is, so have (I think) done the absolute minimum to change
it to the new interface.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606_ring.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index b32cb0d..ace376d 100644
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
@@ -245,10 +248,19 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
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
+		kasprintf(GFP_KERNEL, "adis16203_consumer%d", indio_dev->id);
+	if (indio_dev->pollfunc->name == NULL) {
+		ret = -ENOMEM;
+		goto error_free_poll_func;
+	}
 	/* Ring buffer functions - here trigger setup related */
 
 	indio_dev->ring->preenable = &ad7606_ring_preenable;
@@ -262,6 +274,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_RING_TRIGGERED;
 	return 0;
+error_free_poll_func:
+	kfree(indio_dev->pollfunc);
 error_deallocate_sw_rb:
 	iio_sw_rb_free(indio_dev->ring);
 error_ret:
@@ -275,6 +289,7 @@ void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4
