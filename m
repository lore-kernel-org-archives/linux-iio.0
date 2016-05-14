Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35761 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbcENRmR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:42:17 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: triggers: Make trigger ops structure explicitly non optional.
Date: Sat, 14 May 2016 18:42:08 +0100
Message-Id: <1463247728-31491-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This structure has not been optional for a long time (if ever) but the
code implies that it is.  As we then use it later in a fashion that would
crash if it was infact NULL, gcc may well have optimized all these tests
out anyway.  However, it's inconsistent so fix it up by removing unnecessary
checkes.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-trigger.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ae2806aafb72..672911293987 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -68,6 +68,10 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
 
+	/* trig_info->ops is required for the module member */
+	if (!trig_info->ops)
+		return -EINVAL;
+
 	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
 	if (trig_info->id < 0)
 		return trig_info->id;
@@ -164,8 +168,7 @@ EXPORT_SYMBOL(iio_trigger_poll_chained);
 
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
-	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
-		trig->ops->try_reenable)
+	if (atomic_dec_and_test(&trig->use_count) && trig->ops->try_reenable)
 		if (trig->ops->try_reenable(trig))
 			/* Missed an interrupt so launch new poll now */
 			iio_trigger_poll(trig);
@@ -219,7 +222,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 		return ret;
 	}
 
-	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
+	if (trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
 		if (ret < 0)
 			module_put(pf->indio_dev->info->driver_module);
@@ -236,7 +239,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 		= (bitmap_weight(trig->pool,
 				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
 		   == 1);
-	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
+	if (trig->ops->set_trigger_state && no_other_users) {
 		ret = trig->ops->set_trigger_state(trig, false);
 		if (ret)
 			return ret;
@@ -358,7 +361,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 			return ret;
 	}
 
-	if (trig && trig->ops && trig->ops->validate_device) {
+	if (trig && trig->ops->validate_device) {
 		ret = trig->ops->validate_device(trig, indio_dev);
 		if (ret)
 			return ret;
-- 
2.8.2

