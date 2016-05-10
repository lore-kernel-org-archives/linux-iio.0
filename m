Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34666 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcEJJA3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2016 05:00:29 -0400
Received: by mail-lf0-f52.google.com with SMTP id m64so7200287lfd.1
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2016 02:00:28 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <cdleonard@gmail.com>
Subject: [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger
Date: Tue, 10 May 2016 11:00:13 +0200
Message-Id: <1462870813-24700-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Leonard Crestez observed the following phenomenon: when using
hard interrupt triggers (the DRDY line coming out of an ST
sensor) sometimes a new value would arrive while reading the
previous value, due to latencies in the system.

As the interrupts from the ST sensors are a pulse, intended
to be read by an edge-triggered interrupt line (such as a
GPIO) one edge (transition from low-to-high or high-to-low)
will be missed while processing the current values.

If this happens, the state machine that triggers interrupts on
the DRDY line will lock waiting for the current value to be
read out and not fire any more interrupts. That means that
when we exit the interrupt handler, even though new values are
available from the sensor, no new interrupt will be triggered.

To counter this, do two things:

- Remove IRQF_ONESHOT so that the interrupt line is not
  masked while running the thread part of the interrupt.
  This way we will never miss an interrupt.

- Introduce a loop that polls the data ready
  registers repeatedly until no new samples are available,
  then exits the interrupt handler. This way we know no new
  values are available when the interrupt handler exits and
  new interrupts will be triggered when data arrives.
  Take some extra care to update the timestamp for the poll
  function if this happens. The timestamp will not be 100%
  perfect, but it will at least be closer to the actual
  events.

Usually the extra poll loop will handle the new samples,
but once in a blue moon, we get a new IRQ while exiting
the loop, before returning from the thread IRQ bottom half
with IRQ_HANDLED. On these rare occasions, the removal of
IRQF_ONESHOT means the interrupt will immediately fire
again.

Tested successfully on the LIS331DL by setting sampling
frequency to 400Hz and stressing the system: extra reads in
the threaded interrupt handler occurs.

Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Crestez Dan Leonard <cdleonard@gmail.com>
Reported-by: Crestez Dan Leonard <cdleonard@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Add a loop counter to the threaded value poll function: let's
  just loop here for at maximum 10 loops before we exit and
  let the thread re-trigger if more interrupts arrived.
ChangeLog v4->v5:
- Remove the IRQF_ONESHOT flag from the interrupt: this makes
  it possible to trigger the top half of the interrupt even
  though the bottom half is processing an earlier interrupt.
  This makes it possible to gracefully handle interrupts that
  come in during sensor reading.
- Add better descriptive comments.
ChangeLog v3->v4:
- Include this patch with the threaded interrupt fix patch.
  Adapte the same patch numbering system.

If this works I suggest it be applied to mainline as a fix on
top of the threading patch version 3, so we handle this annoying
lockup bug.
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  7 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 79 +++++++++++++++-------
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index f1693dbebb8a..f6873919f188 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -59,7 +59,12 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	s64 timestamp;
 
-	/* If we do timetamping here, do it before reading the values */
+	/*
+	 * If we do timetamping here, do it before reading the values, because
+	 * once we've read the values, new interrupts can occur (when using
+	 * the hardware trigger) and the hw_timestamp may get updated.
+	 * By storing it in a local variable first, we are safe.
+	 */
 	if (sdata->hw_irq_trigger)
 		timestamp = sdata->hw_timestamp;
 	else
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 98bd5b3b868f..3e260d6ecda8 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -18,6 +18,42 @@
 #include "st_sensors_core.h"
 
 /**
+ * st_sensors_new_samples_available() - check if more samples came in
+ * returns:
+ * 0 - no new samples available
+ * 1 - new samples available
+ * negative - error or unknown
+ */
+static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
+					    struct st_sensor_data *sdata)
+{
+	u8 status;
+	int ret;
+
+	/* How would I know if I can't check it? */
+	if (!sdata->sensor_settings->drdy_irq.addr_stat_drdy)
+		return -EINVAL;
+
+	/* No scan mask, no interrupt */
+	if (!indio_dev->active_scan_mask)
+		return 0;
+
+	ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+			sdata->sensor_settings->drdy_irq.addr_stat_drdy,
+			&status);
+	if (ret < 0) {
+		dev_err(sdata->dev,
+			"error checking samples available\n");
+		return ret;
+	}
+
+	if (status & (u8)indio_dev->active_scan_mask[0])
+		return 1;
+
+	return 0;
+}
+
+/**
  * st_sensors_irq_handler() - top half of the IRQ-based triggers
  * @irq: irq number
  * @p: private handler data
@@ -43,36 +79,30 @@ irqreturn_t st_sensors_irq_thread(int irq, void *p)
 	struct iio_trigger *trig = p;
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	int ret;
+	/* Loop for new values maximum 10 times */
+	int loops = 10;
 
 	/*
 	 * If this trigger is backed by a hardware interrupt and we have a
-	 * status register, check if this IRQ came from us
+	 * status register, check if this IRQ came from us. Notice that
+	 * we will process also if st_sensors_new_samples_available()
+	 * returns negative: if we can't check status, then poll
+	 * unconditionally.
 	 */
-	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
-		u8 status;
-
-		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
-			   &status);
-		if (ret < 0) {
-			dev_err(sdata->dev, "could not read channel status\n");
-			goto out_poll;
-		}
+	if (st_sensors_new_samples_available(indio_dev, sdata)) {
+		iio_trigger_poll_chained(p);
+	} else {
+		dev_dbg(sdata->dev, "spurious IRQ\n");
+		return IRQ_NONE;
+	}
 
-		/*
-		 * If this was not caused by any channels on this sensor,
-		 * return IRQ_NONE
-		 */
-		if (!indio_dev->active_scan_mask)
-			return IRQ_NONE;
-		if (!(status & (u8)indio_dev->active_scan_mask[0]))
-			return IRQ_NONE;
+	/* If new samples arrived while processing the IRQ, poll again. */
+	while (loops-- && st_sensors_new_samples_available(indio_dev, sdata)) {
+		dev_dbg(sdata->dev, "more samples came in during polling\n");
+		sdata->hw_timestamp = iio_get_time_ns();
+		iio_trigger_poll_chained(p);
 	}
 
-out_poll:
-	/* It's our IRQ: proceed to handle the register polling */
-	iio_trigger_poll_chained(p);
 	return IRQ_HANDLED;
 }
 
@@ -136,9 +166,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
 		irq_trig |= IRQF_SHARED;
 
-	/* Let's create an interrupt thread masking the hard IRQ here */
-	irq_trig |= IRQF_ONESHOT;
-
 	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
 			st_sensors_irq_handler,
 			st_sensors_irq_thread,
-- 
2.4.11

