Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 84/99] staging:iio:lis3l02dq remerge the two interrupt handlers.
Date: Wed,  4 May 2011 12:58:56 +0100
Message-Id: <1304510351-10922-85-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Does add a small burden to both handlers, but the gain is somewhat
simpler code.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |    5 +++
 drivers/staging/iio/accel/lis3l02dq_core.c |   52 ++++++++++++---------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   30 ++++++++++------
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index a910f2d..3f1d7c6 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -162,6 +162,7 @@ struct lis3l02dq_state {
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
+	bool				trigger_on;
 };
 
 #define lis3l02dq_h_to_s(_h)				\
@@ -202,7 +203,11 @@ void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
 #define lis3l02dq_alloc_buf iio_kfifo_allocate
 #define lis3l02dq_register_buf_funcs iio_kfifo_register_funcs
 #endif
+irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
+#define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
+
 #else /* CONFIG_IIO_RING_BUFFER */
+#define lis3l02dq_th lis3l02dq_noring
 
 static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 {
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 8793ee4..42261b5 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -35,6 +35,13 @@
  * It's in the likely to be added comment at the top of spi.h.
  * This means that use cannot be made of spi_write etc.
  */
+/* direct copy of the irq_default_primary_handler */
+#ifndef CONFIG_IIO_RING_BUFFER
+static irqreturn_t lis3l02dq_noring(int irq, void *private)
+{
+	return IRQ_WAKE_THREAD;
+}
+#endif
 
 /**
  * lis3l02dq_spi_read_reg_8() - read single byte from a single register
@@ -557,19 +564,13 @@ static ssize_t lis3l02dq_read_event_config(struct iio_dev *indio_dev,
 
 int lis3l02dq_disable_all_events(struct iio_dev *indio_dev)
 {
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	int ret;
 	u8 control, val;
-	bool irqtofree;
 
 	ret = lis3l02dq_spi_read_reg_8(indio_dev,
 				       LIS3L02DQ_REG_CTRL_2_ADDR,
 				       &control);
 
-	irqtofree = !!(control & LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT);
-
 	control &= ~LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT;
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
@@ -590,9 +591,6 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_ret;
 
-	if (irqtofree)
-		free_irq(st->us->irq, indio_dev);
-
 	ret = control;
 error_ret:
 	return ret;
@@ -602,9 +600,6 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 					int event_code,
 					int state)
 {
-	struct iio_sw_ring_helper_state *h
-		= iio_dev_get_devdata(indio_dev);
-	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 	int ret = 0;
 	u8 val, control;
 	u8 currentlyset;
@@ -636,18 +631,6 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 	}
 
 	if (changed) {
-		if (!(control & LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT)) {
-			ret = request_threaded_irq(st->us->irq,
-						   NULL,
-						   &lis3l02dq_event_handler,
-						   IRQF_TRIGGER_RISING |
-						   IRQF_ONESHOT,
-						   "lis3l02dq_event",
-						   indio_dev);
-			if (ret)
-				goto error_ret;
-		}
-
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 						&val);
@@ -661,10 +644,6 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 					       &control);
 		if (ret)
 			goto error_ret;
-
-		/* remove interrupt handler if nothing is still on */
-		if (!(val & 0x3f))
-			free_irq(st->us->irq, indio_dev);
 	}
 
 error_ret:
@@ -748,9 +727,18 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
+		ret = request_threaded_irq(st->us->irq,
+					   &lis3l02dq_th,
+					   &lis3l02dq_event_handler,
+					   IRQF_TRIGGER_RISING,
+					   "lis3l02dq",
+					   st->help.indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
+
+		ret = lis3l02dq_probe_trigger(st->help.indio_dev);
+		if (ret)
+			goto error_free_interrupt;
 	}
 
 	/* Get the device into a sane initial state */
@@ -762,6 +750,9 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 error_remove_trigger:
 	if (st->help.indio_dev->modes & INDIO_RING_TRIGGERED)
 		lis3l02dq_remove_trigger(st->help.indio_dev);
+error_free_interrupt:
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		free_irq(st->us->irq, st->help.indio_dev);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(st->help.indio_dev->ring);
 error_unreg_ring_funcs:
@@ -823,6 +814,9 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		free_irq(st->us->irq, indio_dev);
+
 	lis3l02dq_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev->ring);
 	lis3l02dq_unconfigure_ring(indio_dev);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index d261bd6..83f2bbe 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -27,6 +27,22 @@ static inline u16 combine_8_to_16(u8 lower, u8 upper)
 }
 
 /**
+ * lis3l02dq_data_rdy_trig_poll() the event handler for the data rdy trig
+ **/
+irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct iio_sw_ring_helper_state *h =  iio_dev_get_devdata(indio_dev);
+	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
+
+	if (st->trigger_on) {
+		iio_trigger_poll(st->trig, iio_get_time_ns());
+		return IRQ_HANDLED;
+	} else
+		return IRQ_WAKE_THREAD;
+}
+
+/**
  * lis3l02dq_read_accel_from_ring() individual acceleration read from ring
  **/
 ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
@@ -191,8 +207,7 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 						&valold);
 		if (ret)
 			goto error_ret;
-
-		free_irq(st->us->irq, st->trig);
+		st->trigger_on = false;
 /* Enable requested */
 	} else if (state && !currentlyset) {
 		/* if not set, enable requested */
@@ -203,20 +218,13 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 
 		valold = ret |
 			LIS3L02DQ_REG_CTRL_2_ENABLE_DATA_READY_GENERATION;
-		ret = request_irq(st->us->irq,
-				  &iio_trigger_generic_data_rdy_poll,
-				  IRQF_TRIGGER_RISING, "lis3l02dq_datardy",
-				  st->trig);
-		if (ret)
-			goto error_ret;
 
+		st->trigger_on = true;
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_CTRL_2_ADDR,
 						&valold);
-		if (ret) {
-			free_irq(st->us->irq, st->trig);
+		if (ret)
 			goto error_ret;
-		}
 	}
 
 	return 0;
-- 
1.7.3.4
