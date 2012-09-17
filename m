Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:trigger:bfintmr: Only enable timer when necessary
Date: Mon, 17 Sep 2012 14:26:46 +0200
Message-Id: <1347884808-26833-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1347884808-26833-1-git-send-email-lars@metafoo.de>
References: <1347884808-26833-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

This patch hooks up the set_trigger_state callback for the blackfin timer
trigger driver and only enables the timer when a trigger consumer requests it to
be enabled. There really is no reason to keep the timer running and generate
interrupts if nobody is listening to them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |   27 ++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 2772ea2..d9d3dc9 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -57,12 +57,28 @@ struct bfin_tmr_state {
 	int irq;
 };
 
+static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
+{
+	struct bfin_tmr_state *st = trig->private_data;
+
+	if (get_gptimer_period(st->t->id) == 0)
+		return -EINVAL;
+
+	if (state)
+		enable_gptimers(st->t->bit);
+	else
+		disable_gptimers(st->t->bit);
+
+	return 0;
+}
+
 static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = trig->private_data;
 	long val;
+	bool enabled;
 	int ret;
 
 	ret = strict_strtoul(buf, 10, &val);
@@ -74,7 +90,10 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 		goto error_ret;
 	}
 
-	disable_gptimers(st->t->bit);
+	enabled = get_enabled_gptimers() & st->t->bit;
+
+	if (enabled)
+		disable_gptimers(st->t->bit);
 
 	if (!val)
 		goto error_ret;
@@ -87,7 +106,9 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 
 	set_gptimer_period(st->t->id, val);
 	set_gptimer_pwidth(st->t->id, 1);
-	enable_gptimers(st->t->bit);
+
+	if (enabled)
+		enable_gptimers(st->t->bit);
 
 error_ret:
 	return ret ? ret : count;
@@ -127,7 +148,6 @@ static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
 	NULL
 };
 
-
 static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
 {
 	struct bfin_tmr_state *st = devid;
@@ -151,6 +171,7 @@ static int iio_bfin_tmr_get_number(int irq)
 
 static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
 	.owner = THIS_MODULE,
+	.set_trigger_state = iio_bfin_tmr_set_state,
 };
 
 static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
-- 
1.7.10.4
