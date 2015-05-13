Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1122 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934089AbbEMOE7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 10:04:59 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] iio: __iio_update_buffers: Split enable and disable path into helper functions
Date: Wed, 13 May 2015 16:04:49 +0200
Message-Id: <1431525891-19285-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-1-git-send-email-lars@metafoo.de>
References: <1431525891-19285-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

__iio_update_buffers is already a rather large function with many different
error paths and it is going to get even larger. This patch factors out the
device enable and device disable paths into separate helper functions.

The patch also re-implements iio_disable_all_buffers() using the new
iio_disable_buffers() function removing a fair bit of redundant code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 174 +++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 68e2669..dd04e35 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -539,29 +539,6 @@ static void iio_buffer_deactivate(struct iio_buffer *buffer)
 	iio_buffer_put(buffer);
 }
 
-void iio_disable_all_buffers(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer, *_buffer;
-
-	if (list_empty(&indio_dev->buffer_list))
-		return;
-
-	if (indio_dev->setup_ops->predisable)
-		indio_dev->setup_ops->predisable(indio_dev);
-
-	list_for_each_entry_safe(buffer, _buffer,
-			&indio_dev->buffer_list, buffer_list)
-		iio_buffer_deactivate(buffer);
-
-	if (indio_dev->setup_ops->postdisable)
-		indio_dev->setup_ops->postdisable(indio_dev);
-
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
-
-	if (indio_dev->available_scan_masks == NULL)
-		kfree(indio_dev->active_scan_mask);
-}
-
 static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer)
 {
@@ -684,62 +661,40 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int __iio_update_buffers(struct iio_dev *indio_dev,
-		       struct iio_buffer *insert_buffer,
-		       struct iio_buffer *remove_buffer)
+static int iio_disable_buffers(struct iio_dev *indio_dev)
 {
 	int ret;
-	const unsigned long *old_mask;
-	struct iio_device_config new_config;
 
-	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
-		&new_config);
-	if (ret)
-		return ret;
+	/* Wind down existing buffers - iff there are any */
+	if (list_empty(&indio_dev->buffer_list))
+		return 0;
 
-	if (insert_buffer) {
-		ret = iio_buffer_request_update(indio_dev, insert_buffer);
+	if (indio_dev->setup_ops->predisable) {
+		ret = indio_dev->setup_ops->predisable(indio_dev);
 		if (ret)
-			goto err_free_config;
+			return ret;
 	}
 
-	/* Wind down existing buffers - iff there are any */
-	if (!list_empty(&indio_dev->buffer_list)) {
-		if (indio_dev->setup_ops->predisable) {
-			ret = indio_dev->setup_ops->predisable(indio_dev);
-			if (ret)
-				goto err_free_config;
-		}
-
-		if (indio_dev->setup_ops->postdisable) {
-			ret = indio_dev->setup_ops->postdisable(indio_dev);
-			if (ret)
-				goto err_free_config;
-		}
-
-		indio_dev->currentmode = INDIO_DIRECT_MODE;
+	if (indio_dev->setup_ops->postdisable) {
+		ret = indio_dev->setup_ops->postdisable(indio_dev);
+		if (ret)
+			return ret;
 	}
-	/* Keep a copy of current setup to allow roll back */
-	old_mask = indio_dev->active_scan_mask;
-	if (!indio_dev->available_scan_masks)
-		indio_dev->active_scan_mask = NULL;
 
-	if (remove_buffer)
-		iio_buffer_deactivate(remove_buffer);
-	if (insert_buffer)
-		iio_buffer_activate(indio_dev, insert_buffer);
+	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
-	/* If no buffers in list, we are done */
-	if (list_empty(&indio_dev->buffer_list)) {
-		indio_dev->currentmode = INDIO_DIRECT_MODE;
-		iio_free_scan_mask(indio_dev, old_mask);
-		return 0;
-	}
+	return 0;
+}
 
-	indio_dev->currentmode = new_config.mode;
-	indio_dev->active_scan_mask = new_config.scan_mask;
-	indio_dev->scan_timestamp = new_config.scan_timestamp;
-	indio_dev->scan_bytes = new_config.scan_bytes;
+static int iio_enable_buffers(struct iio_dev *indio_dev,
+	struct iio_device_config *config)
+{
+	int ret;
+
+	indio_dev->currentmode = config->mode;
+	indio_dev->active_scan_mask = config->scan_mask;
+	indio_dev->scan_timestamp = config->scan_timestamp;
+	indio_dev->scan_bytes = config->scan_bytes;
 
 	iio_update_demux(indio_dev);
 
@@ -749,7 +704,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: buffer preenable failed (%d)\n", ret);
-			goto error_remove_inserted;
+			goto err_undo_config;
 		}
 	}
 
@@ -761,7 +716,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 			dev_dbg(&indio_dev->dev,
 				"Buffer not started: update scan mode failed (%d)\n",
 				ret);
-			goto error_run_postdisable;
+			goto err_run_postdisable;
 		}
 	}
 
@@ -770,24 +725,72 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: postenable failed (%d)\n", ret);
-			goto error_run_postdisable;
+			goto err_run_postdisable;
 		}
 	}
 
-	iio_free_scan_mask(indio_dev, old_mask);
-
 	return 0;
 
-error_run_postdisable:
+err_run_postdisable:
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
-error_remove_inserted:
+err_undo_config:
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
-	if (insert_buffer)
-		iio_buffer_deactivate(insert_buffer);
-	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
-	indio_dev->active_scan_mask = old_mask;
+	indio_dev->active_scan_mask = NULL;
+
 	return ret;
+}
+
+static int __iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer)
+{
+	int ret;
+	const unsigned long *old_mask;
+	struct iio_device_config new_config;
+
+	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
+		&new_config);
+	if (ret)
+		return ret;
+
+	if (insert_buffer) {
+		ret = iio_buffer_request_update(indio_dev, insert_buffer);
+		if (ret)
+			goto err_free_config;
+	}
+
+	/* Keep a copy of current setup to allow roll back */
+	old_mask = indio_dev->active_scan_mask;
+	indio_dev->active_scan_mask = NULL;
+
+	ret = iio_disable_buffers(indio_dev);
+	if (ret) {
+		iio_free_scan_mask(indio_dev, old_mask);
+		goto err_free_config;
+	}
+
+	if (remove_buffer)
+		iio_buffer_deactivate(remove_buffer);
+	if (insert_buffer)
+		iio_buffer_activate(indio_dev, insert_buffer);
+
+	/* If no buffers in list, we are done */
+	if (list_empty(&indio_dev->buffer_list)) {
+		iio_free_scan_mask(indio_dev, old_mask);
+		return 0;
+	}
+
+	ret = iio_enable_buffers(indio_dev, &new_config);
+	if (ret) {
+		if (insert_buffer)
+			iio_buffer_deactivate(insert_buffer);
+		indio_dev->active_scan_mask = old_mask;
+		goto err_free_config;
+	}
+
+	iio_free_scan_mask(indio_dev, old_mask);
+	return 0;
 
 err_free_config:
 	iio_free_scan_mask(indio_dev, new_config.scan_mask);
@@ -832,6 +835,19 @@ out_unlock:
 }
 EXPORT_SYMBOL_GPL(iio_update_buffers);
 
+void iio_disable_all_buffers(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer, *_buffer;
+
+	iio_disable_buffers(indio_dev);
+	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
+	indio_dev->active_scan_mask = NULL;
+
+	list_for_each_entry_safe(buffer, _buffer,
+			&indio_dev->buffer_list, buffer_list)
+		iio_buffer_deactivate(buffer);
+}
+
 static ssize_t iio_buffer_store_enable(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf,
-- 
1.8.0

