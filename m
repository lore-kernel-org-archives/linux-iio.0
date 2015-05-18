Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1075 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752407AbbERLe5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 07:34:57 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/3] iio: __iio_update_buffers: Leave device in sane state on error
Date: Mon, 18 May 2015 13:34:49 +0200
Message-Id: <1431948889-24069-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1431948889-24069-1-git-send-email-lars@metafoo.de>
References: <1431948889-24069-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently when something goes wrong at some step when disabling the buffers
we immediately abort. This has the effect that the enable/disable calls are
no longer balanced. So make sure that even if one step in the disable
sequence fails the other steps are still executed.

The other issue is that when either enable or disable fails buffers that
were active at that time stay active while the device itself is disabled.
This leaves things in a inconsistent state and can cause unbalanced
enable/disable calls. Furthermore when enable fails we restore the old scan
mask, but still keeps things disabled.

Given that verification of the configuration was performed earlier and it
is valid at the point where we try to enable/disable the most likely reason
of failure is a communication failure with the device or maybe a
out-of-memory situation. There is not really a good recovery strategy in
such a case, so it makes sense to leave the device disabled, but we should
still leave it in a consistent state.

What the patch does if disable/enable fails is to deactivate all buffers
and make sure that the device will be in the same state as if all buffers
had been manually disabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 82 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b4d7dba..1129125 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -539,6 +539,15 @@ static void iio_buffer_deactivate(struct iio_buffer *buffer)
 	iio_buffer_put(buffer);
 }
 
+static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer, *_buffer;
+
+	list_for_each_entry_safe(buffer, _buffer,
+			&indio_dev->buffer_list, buffer_list)
+		iio_buffer_deactivate(buffer);
+}
+
 static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer)
 {
@@ -719,36 +728,46 @@ err_undo_config:
 
 static int iio_disable_buffers(struct iio_dev *indio_dev)
 {
-	int ret;
+	int ret = 0;
+	int ret2;
 
 	/* Wind down existing buffers - iff there are any */
 	if (list_empty(&indio_dev->buffer_list))
 		return 0;
 
+	/*
+	 * If things go wrong at some step in disable we still need to continue
+	 * to perform the other steps, otherwise we leave the device in a
+	 * inconsistent state. We return the error code for the first error we
+	 * encountered.
+	 */
+
 	if (indio_dev->setup_ops->predisable) {
-		ret = indio_dev->setup_ops->predisable(indio_dev);
-		if (ret)
-			return ret;
+		ret2 = indio_dev->setup_ops->predisable(indio_dev);
+		if (ret2 && !ret)
+			ret = ret2;
 	}
 
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
 	if (indio_dev->setup_ops->postdisable) {
-		ret = indio_dev->setup_ops->postdisable(indio_dev);
-		if (ret)
-			return ret;
+		ret2 = indio_dev->setup_ops->postdisable(indio_dev);
+		if (ret2 && !ret)
+			ret = ret2;
 	}
 
-	return 0;
+	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
+	indio_dev->active_scan_mask = NULL;
+
+	return ret;
 }
 
 static int __iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *insert_buffer,
 		       struct iio_buffer *remove_buffer)
 {
-	int ret;
-	const unsigned long *old_mask;
 	struct iio_device_config new_config;
+	int ret;
 
 	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
 		&new_config);
@@ -761,15 +780,9 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 			goto err_free_config;
 	}
 
-	/* Keep a copy of current setup to allow roll back */
-	old_mask = indio_dev->active_scan_mask;
-	indio_dev->active_scan_mask = NULL;
-
 	ret = iio_disable_buffers(indio_dev);
-	if (ret) {
-		iio_free_scan_mask(indio_dev, old_mask);
-		goto err_free_config;
-	}
+	if (ret)
+		goto err_deactivate_all;
 
 	if (remove_buffer)
 		iio_buffer_deactivate(remove_buffer);
@@ -777,22 +790,26 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		iio_buffer_activate(indio_dev, insert_buffer);
 
 	/* If no buffers in list, we are done */
-	if (list_empty(&indio_dev->buffer_list)) {
-		iio_free_scan_mask(indio_dev, old_mask);
+	if (list_empty(&indio_dev->buffer_list))
 		return 0;
-	}
 
 	ret = iio_enable_buffers(indio_dev, &new_config);
-	if (ret) {
-		if (insert_buffer)
-			iio_buffer_deactivate(insert_buffer);
-		indio_dev->active_scan_mask = old_mask;
-		goto err_free_config;
-	}
+	if (ret)
+		goto err_deactivate_all;
 
-	iio_free_scan_mask(indio_dev, old_mask);
 	return 0;
 
+err_deactivate_all:
+	/*
+	 * We've already verified that the config is valid earlier. If things go
+	 * wrong in either enable or disable the most likely reason is an IO
+	 * error from the device. In this case there is no good recovery
+	 * strategy. Just make sure to disable everything and leave the device
+	 * in a sane state.  With a bit of luck the device might come back to
+	 * life again later and userspace can try again.
+	 */
+	iio_buffer_deactivate_all(indio_dev);
+
 err_free_config:
 	iio_free_scan_mask(indio_dev, new_config.scan_mask);
 	return ret;
@@ -838,15 +855,8 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer, *_buffer;
-
 	iio_disable_buffers(indio_dev);
-	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
-	indio_dev->active_scan_mask = NULL;
-
-	list_for_each_entry_safe(buffer, _buffer,
-			&indio_dev->buffer_list, buffer_list)
-		iio_buffer_deactivate(buffer);
+	iio_buffer_deactivate_all(indio_dev);
 }
 
 static ssize_t iio_buffer_store_enable(struct device *dev,
-- 
1.8.0

