Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/45] iio:trigger: Remove necessity to have a trig->ops structure.
Date: Sun, 23 Jul 2017 17:25:45 +0100
Message-Id: <20170723162627.22534-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

There are a few cases where none of the callbacks are supplied and the
ops structure purely existed to provide the driver module.

Given that is done differently now, we don't need to have a trig_ops structure.
Allow for it not being there required a few additional sanity checks when
trying check if particular callbacks are set.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-trigger.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index faf00202915a..ce66699c7fcc 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -73,10 +73,6 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 
 	trig_info->owner = this_mod;
 
-	/* trig_info->ops is required for the module member */
-	if (!trig_info->ops)
-		return -EINVAL;
-
 	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
 	if (trig_info->id < 0)
 		return trig_info->id;
@@ -209,7 +205,8 @@ EXPORT_SYMBOL(iio_trigger_poll_chained);
 
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
-	if (atomic_dec_and_test(&trig->use_count) && trig->ops->try_reenable)
+	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
+	    trig->ops->try_reenable)
 		if (trig->ops->try_reenable(trig))
 			/* Missed an interrupt so launch new poll now */
 			iio_trigger_poll(trig);
@@ -268,7 +265,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 		goto out_put_irq;
 
 	/* Enable trigger in driver */
-	if (trig->ops->set_trigger_state && notinuse) {
+	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
 		if (ret < 0)
 			goto out_free_irq;
@@ -301,7 +298,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 		= (bitmap_weight(trig->pool,
 				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
 		   == 1);
-	if (trig->ops->set_trigger_state && no_other_users) {
+	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
 		ret = trig->ops->set_trigger_state(trig, false);
 		if (ret)
 			return ret;
@@ -431,7 +428,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 			goto out_trigger_put;
 	}
 
-	if (trig && trig->ops->validate_device) {
+	if (trig && trig->ops && trig->ops->validate_device) {
 		ret = trig->ops->validate_device(trig, indio_dev);
 		if (ret)
 			goto out_trigger_put;
-- 
2.13.3
