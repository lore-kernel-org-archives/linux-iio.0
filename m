Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48417 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbaFLFrC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 01:47:02 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Remove timestamp argument from iio_trigger_poll() and iio_trigger_poll_chained()
Date: Thu, 12 Jun 2014 07:46:53 +0200
Message-Id: <1402552013-9666-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

argument has been ignored; adjust drivers accordingly

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad_sigma_delta.c                    | 2 +-
 drivers/iio/adc/at91_adc.c                          | 2 +-
 drivers/iio/adc/xilinx-xadc-core.c                  | 2 +-
 drivers/iio/industrialio-trigger.c                  | 8 ++++----
 drivers/iio/light/gp2ap020a00f.c                    | 2 +-
 drivers/iio/proximity/as3935.c                      | 2 +-
 drivers/iio/trigger/iio-trig-hrtimer.c              | 2 +-
 drivers/iio/trigger/iio-trig-interrupt.c            | 3 +--
 drivers/iio/trigger/iio-trig-sysfs.c                | 2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c          | 2 +-
 drivers/staging/iio/adc/mxs-lradc.c                 | 2 +-
 drivers/staging/iio/meter/ade7758_trigger.c         | 2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 2 +-
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 3 +--
 include/linux/iio/trigger.h                         | 5 ++---
 15 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9a4e0e3..c55b81f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -410,7 +410,7 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	complete(&sigma_delta->completion);
 	disable_irq_nosync(irq);
 	sigma_delta->irq_dis = true;
-	iio_trigger_poll(sigma_delta->trig, iio_get_time_ns());
+	iio_trigger_poll(sigma_delta->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 89777ed..b959201 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -149,7 +149,7 @@ void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
 
 	if (iio_buffer_enabled(idev)) {
 		disable_irq_nosync(irq);
-		iio_trigger_poll(idev->trig, iio_get_time_ns());
+		iio_trigger_poll(idev->trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done = true;
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ab52be2..fd2745c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -486,7 +486,7 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 		return IRQ_NONE;
 
 	if ((status & XADC_AXI_INT_EOS) && xadc->trigger)
-		iio_trigger_poll(xadc->trigger, 0);
+		iio_trigger_poll(xadc->trigger);
 
 	if (status & XADC_AXI_INT_ALARM_MASK) {
 		/*
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 3383b02..d31098e 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -114,7 +114,7 @@ static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 	return trig;
 }
 
-void iio_trigger_poll(struct iio_trigger *trig, s64 time)
+void iio_trigger_poll(struct iio_trigger *trig)
 {
 	int i;
 
@@ -133,12 +133,12 @@ EXPORT_SYMBOL(iio_trigger_poll);
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private)
 {
-	iio_trigger_poll(private, iio_get_time_ns());
+	iio_trigger_poll(private);
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
 
-void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
+void iio_trigger_poll_chained(struct iio_trigger *trig)
 {
 	int i;
 
@@ -161,7 +161,7 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 		trig->ops->try_reenable)
 		if (trig->ops->try_reenable(trig))
 			/* Missed an interrupt so launch new poll now */
-			iio_trigger_poll(trig, 0);
+			iio_trigger_poll(trig);
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 04bdb85..221ed16 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -827,7 +827,7 @@ static void gp2ap020a00f_iio_trigger_work(struct irq_work *work)
 	struct gp2ap020a00f_data *data =
 		container_of(work, struct gp2ap020a00f_data, work);
 
-	iio_trigger_poll(data->trig, 0);
+	iio_trigger_poll(data->trig);
 }
 
 static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index bf677bf..5e780ef 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -232,7 +232,7 @@ static void as3935_event_work(struct work_struct *work)
 
 	switch (val) {
 	case AS3935_EVENT_INT:
-		iio_trigger_poll(st->trig, iio_get_time_ns());
+		iio_trigger_poll(st->trig);
 		break;
 	case AS3935_NOISE_INT:
 		dev_warn(&st->spi->dev, "noise level is too high");
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index c75fecc..fc0e6dc 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -164,7 +164,7 @@ static enum hrtimer_restart iio_hrtimer_trigger_func(struct hrtimer *timer)
 		struct iio_hrtimer_trigger_data, timer);
 
 	hrtimer_forward_now(timer, trig_data->period);
-	iio_trigger_poll(trig_data->trig, iio_get_time_ns());
+	iio_trigger_poll(trig_data->trig);
 
 	return HRTIMER_RESTART;
 }
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 02577ec..7a149a7 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -24,8 +24,7 @@ struct iio_interrupt_trigger_info {
 
 static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 {
-	/* Timestamp not currently provided */
-	iio_trigger_poll(private, 0);
+	iio_trigger_poll(private);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 5b21489..b6346472 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -95,7 +95,7 @@ static void iio_sysfs_trigger_work(struct irq_work *work)
 	struct iio_sysfs_trig *trig = container_of(work, struct iio_sysfs_trig,
 							work);
 
-	iio_trigger_poll(trig->trig, 0);
+	iio_trigger_poll(trig->trig);
 }
 
 static ssize_t iio_sysfs_trigger_poll(struct device *dev,
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 79cefe0..bf33fde 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -31,7 +31,7 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	if (st->trigger_on) {
-		iio_trigger_poll(st->trig, iio_get_time_ns());
+		iio_trigger_poll(st->trig);
 		return IRQ_HANDLED;
 	} else
 		return IRQ_WAKE_THREAD;
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index dae8d1a..d861999 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1166,7 +1166,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 		mxs_lradc_handle_touch(lradc);
 
 	if (iio_buffer_enabled(iio))
-		iio_trigger_poll(iio->trig, iio_get_time_ns());
+		iio_trigger_poll(iio->trig);
 	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
 		complete(&lradc->completion);
 
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 7a94ddd..ea01b8f 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -21,7 +21,7 @@
 static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
 {
 	disable_irq_nosync(irq);
-	iio_trigger_poll(private, iio_get_time_ns());
+	iio_trigger_poll(private);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 26e1ca0..16f1a06 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -154,7 +154,7 @@ static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
 	struct bfin_tmr_state *st = devid;
 
 	clear_gptimer_intr(st->t->id);
-	iio_trigger_poll(st->trig, 0);
+	iio_trigger_poll(st->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index b5108a1..b1aeb88 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -106,8 +106,7 @@ static const struct attribute_group *iio_trig_prtc_attr_groups[] = {
 
 static void iio_prtc_trigger_poll(void *private_data)
 {
-	/* Timestamp is not provided currently */
-	iio_trigger_poll(private_data, 0);
+	iio_trigger_poll(private_data);
 }
 
 static const struct iio_trigger_ops iio_prtc_trigger_ops = {
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 369cf2c..4b79ffe 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -129,12 +129,11 @@ void iio_trigger_unregister(struct iio_trigger *trig_info);
 /**
  * iio_trigger_poll() - called on a trigger occurring
  * @trig:	trigger which occurred
- * @time:	timestamp when trigger occurred
  *
  * Typically called in relevant hardware interrupt handler.
  **/
-void iio_trigger_poll(struct iio_trigger *trig, s64 time);
-void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time);
+void iio_trigger_poll(struct iio_trigger *trig);
+void iio_trigger_poll_chained(struct iio_trigger *trig);
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
-- 
1.9.1

