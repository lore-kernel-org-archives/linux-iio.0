Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35528 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEFIwt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2016 04:52:49 -0400
Received: by mail-lf0-f48.google.com with SMTP id j8so123716783lfd.2
        for <linux-iio@vger.kernel.org>; Fri, 06 May 2016 01:52:48 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <cdleonard@gmail.com>
Subject: [PATCH v2] iio: st_sensors: switch to a threaded interrupt
Date: Fri,  6 May 2016 10:52:43 +0200
Message-Id: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

commit 98ad8b41f58dff6b30713d7f09ae3834b8df7ded
("iio: st_sensors: verify interrupt event to status") caused
a regression when reading ST sensors from a HRTimer trigger
rather than the intrinsic interrupts: the HRTimer may
trigger faster than the sensor provides new values, and
as the check against new values available as a cause of
the interrupt trigger was done in the poll function,
this would bail out of the HRTimer interrupt with
IRQ_NONE.

So clearly we need to only check the new values available
from the proper interrupt handler and not from the poll
function, which should rather just read the raw values
from the registers, put them into the buffer and be happy.

To achieve this: switch the ST Sensors over to using a true
threaded interrupt handler.

In the interrupt thread, check if new values are available,
else yield to the (potential) next device on the same
interrupt line to check the registers. If the interrupt
was ours, proceed to poll the values.

Instead of relying on iio_trigger_generic_data_rdy_poll() as
a top half to wake up the thread that polls the sensor for
new data, have the thread call iio_trigger_poll_chained()
after determining that is is the proper source of the
interrupt. This is modelled on drivers/iio/accel/mma8452.c
which is already using a properly threaded interrupt handler.

Additionally: if the active scanmask is not set for the
sensor no IRQs should be enabled and we need to bail out
with IRQ_NONE. This can happen if spurious IRQs fire when
installing the threaded interrupt handler.

Tested with hard interrupt triggers on LIS331DL, then also
tested with hrtimers on the same sensor by creating a 75Hz
HRTimer and using it to poll the sensor.

Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Crestez Dan Leonard <cdleonard@gmail.com>
Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
Fixes: 97865fe41322 ("iio: st_sensors: verify interrupt event to status")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- v1 was missing timestamps since nothing ever stamped them.
  Restore the timestamps by simply using
  iio_trigger_generic_data_rdy_poll()
  as the top half of the threaded interrupt handler.

Crestez: please test this and check if it solves your
usecase too.
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c  | 39 ++++++++++++++++++----
 drivers/iio/common/st_sensors/st_sensors_core.h    |  1 +
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  7 ++--
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index c55898543a47..aed0fcb80a64 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -51,31 +51,56 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 }
 EXPORT_SYMBOL(st_sensors_get_buffer_element);
 
-irqreturn_t st_sensors_trigger_handler(int irq, void *p)
+/**
+ * st_sensors_irq_thread() - bottom half of the IRQ-based triggers
+ * @irq: irq number
+ * @p: private handler data
+ */
+irqreturn_t st_sensors_irq_thread(int irq, void *p)
 {
-	int len;
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_trigger *trig = p;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int ret;
 
-	/* If we have a status register, check if this IRQ came from us */
+	/*
+	 * If this trigger is backed by a hardware interrupt and we have a
+	 * status register, check if this IRQ came from us
+	 */
 	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
 		u8 status;
 
-		len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
 			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
 			   &status);
-		if (len < 0)
+		if (ret < 0) {
 			dev_err(sdata->dev, "could not read channel status\n");
+			goto out_poll;
+		}
 
 		/*
 		 * If this was not caused by any channels on this sensor,
 		 * return IRQ_NONE
 		 */
+		if (!indio_dev->active_scan_mask)
+			return IRQ_NONE;
 		if (!(status & (u8)indio_dev->active_scan_mask[0]))
 			return IRQ_NONE;
 	}
 
+out_poll:
+	/* It's our IRQ: proceed to handle the register polling */
+	iio_trigger_poll_chained(p);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t st_sensors_trigger_handler(int irq, void *p)
+{
+	int len;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
 	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
 	if (len < 0)
 		goto st_sensors_get_buffer_element_error;
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.h b/drivers/iio/common/st_sensors/st_sensors_core.h
index cd88098ff6f1..79b42e01446e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.h
+++ b/drivers/iio/common/st_sensors/st_sensors_core.h
@@ -5,4 +5,5 @@
 #define __ST_SENSORS_CORE_H
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data);
+irqreturn_t st_sensors_irq_thread(int irq, void *p);
 #endif
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index da72279fcf99..cf72b3619bd6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -77,9 +77,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
 		irq_trig |= IRQF_SHARED;
 
-	err = request_threaded_irq(irq,
+	/* Let's create an interrupt thread masking the hard IRQ here */
+	irq_trig |= IRQF_ONESHOT;
+
+	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
 			iio_trigger_generic_data_rdy_poll,
-			NULL,
+			st_sensors_irq_thread,
 			irq_trig,
 			sdata->trig->name,
 			sdata->trig);
-- 
2.4.11

