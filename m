Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55734 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755374AbdGWQ0p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:45 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 26/45] iio:triggers: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:08 +0100
Message-Id: <20170723162627.22534-27-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Note that stm32-timer-trigger has expanded rather beyond triggers
(to include encoder input counting for example) and hence has an
iio_info structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/trigger/iio-trig-hrtimer.c    | 1 -
 drivers/iio/trigger/iio-trig-interrupt.c  | 1 -
 drivers/iio/trigger/iio-trig-loop.c       | 1 -
 drivers/iio/trigger/iio-trig-sysfs.c      | 1 -
 drivers/iio/trigger/stm32-timer-trigger.c | 2 --
 5 files changed, 6 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index a1cad6cc2e0f..3ee92160053f 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -114,7 +114,6 @@ static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = iio_trig_hrtimer_set_state,
 };
 
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index e18f12b74610..171c4ed03543 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -29,7 +29,6 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 }
 
 static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static int iio_interrupt_trigger_probe(struct platform_device *pdev)
diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index dc6be28f96fe..b4b02dbd6e8a 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -74,7 +74,6 @@ static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
 
 static const struct iio_trigger_ops iio_loop_trigger_ops = {
 	.set_trigger_state = iio_loop_trigger_set_state,
-	.owner = THIS_MODULE,
 };
 
 static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 202e8b89caf2..3f0dc9a1a514 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -127,7 +127,6 @@ static const struct attribute_group *iio_sysfs_trigger_attr_groups[] = {
 };
 
 static const struct iio_trigger_ops iio_sysfs_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static int iio_sysfs_trigger_probe(int id)
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index d22bc56dd9fc..41462e495586 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -318,7 +318,6 @@ static const struct attribute_group *stm32_trigger_attr_groups[] = {
 };
 
 static const struct iio_trigger_ops timer_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
@@ -442,7 +441,6 @@ static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info stm32_trigger_info = {
-	.driver_module = THIS_MODULE,
 	.validate_trigger = stm32_counter_validate_trigger,
 	.read_raw = stm32_counter_read_raw,
 	.write_raw = stm32_counter_write_raw
-- 
2.13.3

