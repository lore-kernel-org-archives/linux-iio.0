Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33650 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbcEGKZy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2016 06:25:54 -0400
Received: by mail-lf0-f43.google.com with SMTP id y84so156444076lfc.0
        for <linux-iio@vger.kernel.org>; Sat, 07 May 2016 03:25:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <cdleonard@gmail.com>
Subject: [PATCH 1/2 v4] iio: st_sensors: switch to a threaded interrupt
Date: Sat,  7 May 2016 12:25:43 +0200
Message-Id: <1462616744-9671-1-git-send-email-linus.walleij@linaro.org>
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

In order to get the same precision in timestamps as
previously, where samples would be timestamped in the
poll function pf->timestamp when calling
iio_trigger_generic_data_rdy_poll() we introduce a
local timestamp in the sensor data, set it in the top half
(fastpath) of the interrupt handler and provide that to the
core when calling iio_push_to_buffers_with_timestamp().

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
ChangeLog v3->v4:
- v3 would not timestamp properly when using a HRTimer to read
  values from the sensors. This is now fixed.
- Add a flag to the sensor data indicating whether the hardware
  interrupt trigger is in use. If this is the case, we use that
  timestamp. If the hardware trigger is not in use, we just let
  the poll function read the current time before proceeding to
  grab the values from the sensor.
- Move interrupt top/bottom halves to st_sensors_trigger.c so the
  interrupt code is kept together and easier to understand in
  context.
ChangeLog v2->v3:
- v2 was a total disaster, as iio_trigger_generic_data_rdy_poll()
  would just call the old bottom half and return IRQ_HANDLED.
  handle the timestamp locally in the sensor data and restore
  the usage of the local interrupt thread.
- I think it works now.
ChangeLog v1->v2:
- v1 was missing timestamps since nothing ever stamped them.
  Restore the timestamps by simply using
  iio_trigger_generic_data_rdy_poll()
  as the top half of the threaded interrupt handler.

Crestez: please test this and check if it solves your
usecase too.
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c  | 25 +++-----
 drivers/iio/common/st_sensors/st_sensors_core.c    |  4 ++
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 68 +++++++++++++++++++++-
 include/linux/iio/common/st_sensors.h              |  5 ++
 4 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index c55898543a47..f1693dbebb8a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -57,31 +57,20 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	s64 timestamp;
 
-	/* If we have a status register, check if this IRQ came from us */
-	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
-		u8 status;
-
-		len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
-			   &status);
-		if (len < 0)
-			dev_err(sdata->dev, "could not read channel status\n");
-
-		/*
-		 * If this was not caused by any channels on this sensor,
-		 * return IRQ_NONE
-		 */
-		if (!(status & (u8)indio_dev->active_scan_mask[0]))
-			return IRQ_NONE;
-	}
+	/* If we do timetamping here, do it before reading the values */
+	if (sdata->hw_irq_trigger)
+		timestamp = sdata->hw_timestamp;
+	else
+		timestamp = iio_get_time_ns();
 
 	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
 	if (len < 0)
 		goto st_sensors_get_buffer_element_error;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
-		pf->timestamp);
+					   timestamp);
 
 st_sensors_get_buffer_element_error:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dffe00692169..eff423d64ecd 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -429,6 +429,10 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 					sdata->sensor_settings->drdy_irq.addr,
 					drdy_mask, (int)enable);
 
+	/* Flag to the poll function that the hardware trigger is in use */
+	if (!err)
+		sdata->hw_irq_trigger = enable;
+
 st_accel_set_dataready_irq_error:
 	return err;
 }
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index da72279fcf99..c18e8221b6fa 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -17,6 +17,65 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_sensors_core.h"
 
+/**
+ * st_sensors_irq_handler() - top half of the IRQ-based triggers
+ * @irq: irq number
+ * @p: private handler data
+ */
+irqreturn_t st_sensors_irq_handler(int irq, void *p)
+{
+	struct iio_trigger *trig = p;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	/* Get the time stamp as close in time as possible */
+	sdata->hw_timestamp = iio_get_time_ns();
+	return IRQ_WAKE_THREAD;
+}
+
+/**
+ * st_sensors_irq_thread() - bottom half of the IRQ-based triggers
+ * @irq: irq number
+ * @p: private handler data
+ */
+irqreturn_t st_sensors_irq_thread(int irq, void *p)
+{
+	struct iio_trigger *trig = p;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * If this trigger is backed by a hardware interrupt and we have a
+	 * status register, check if this IRQ came from us
+	 */
+	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
+		u8 status;
+
+		ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
+			   &status);
+		if (ret < 0) {
+			dev_err(sdata->dev, "could not read channel status\n");
+			goto out_poll;
+		}
+
+		/*
+		 * If this was not caused by any channels on this sensor,
+		 * return IRQ_NONE
+		 */
+		if (!indio_dev->active_scan_mask)
+			return IRQ_NONE;
+		if (!(status & (u8)indio_dev->active_scan_mask[0]))
+			return IRQ_NONE;
+	}
+
+out_poll:
+	/* It's our IRQ: proceed to handle the register polling */
+	iio_trigger_poll_chained(p);
+	return IRQ_HANDLED;
+}
+
 int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops)
 {
@@ -77,9 +136,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
 		irq_trig |= IRQF_SHARED;
 
-	err = request_threaded_irq(irq,
-			iio_trigger_generic_data_rdy_poll,
-			NULL,
+	/* Let's create an interrupt thread masking the hard IRQ here */
+	irq_trig |= IRQF_ONESHOT;
+
+	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
+			st_sensors_irq_handler,
+			st_sensors_irq_thread,
 			irq_trig,
 			sdata->trig->name,
 			sdata->trig);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index d029ffac0d69..9bd1ec5c9c85 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -223,6 +223,8 @@ struct st_sensor_settings {
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
  * @tf: Transfer function structure used by I/O operations.
  * @tb: Transfer buffers and mutex used by I/O operations.
+ * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
+ * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
  */
 struct st_sensor_data {
 	struct device *dev;
@@ -247,6 +249,9 @@ struct st_sensor_data {
 
 	const struct st_sensor_transfer_function *tf;
 	struct st_sensor_transfer_buffer tb;
+
+	bool hw_irq_trigger;
+	s64 hw_timestamp;
 };
 
 #ifdef CONFIG_IIO_BUFFER
-- 
2.4.11

