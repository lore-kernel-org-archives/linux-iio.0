Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1116 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934142AbbEMOE6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 10:04:58 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] iio: __iio_update_buffers: Update mode before preenable/after postdisable
Date: Wed, 13 May 2015 16:04:47 +0200
Message-Id: <1431525891-19285-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-1-git-send-email-lars@metafoo.de>
References: <1431525891-19285-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is clear that we transition to INDIO_DIRECT_MODE when disabling the
buffer(s) and it is also clear that we transition from INDIO_DIRECT_MODE
when enabling the buffer(s). So leaving the currentmode field
INDIO_DIRECT_MODE until after the preenable() callback and updating it to
INDIO_DIRECT_MODE before the postdisable() callback doesn't add additional
value. On the other hand some drivers will need to perform different
actions depending on which mode the device is going to operate in/was
operating in.

Moving the update of currentmode before preenable() and after postdisable()
enables us to have drivers which perform mode dependent actions in those
callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 21ed316..8ecba2f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -553,10 +553,11 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 			&indio_dev->buffer_list, buffer_list)
 		iio_buffer_deactivate(buffer);
 
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
 
+	indio_dev->currentmode = INDIO_DIRECT_MODE;
+
 	if (indio_dev->available_scan_masks == NULL)
 		kfree(indio_dev->active_scan_mask);
 }
@@ -625,12 +626,14 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 		}
-		indio_dev->currentmode = INDIO_DIRECT_MODE;
+
 		if (indio_dev->setup_ops->postdisable) {
 			ret = indio_dev->setup_ops->postdisable(indio_dev);
 			if (ret)
 				return ret;
 		}
+
+		indio_dev->currentmode = INDIO_DIRECT_MODE;
 	}
 	/* Keep a copy of current setup to allow roll back */
 	old_mask = indio_dev->active_scan_mask;
@@ -688,6 +691,21 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		indio_dev->active_scan_mask = compound_mask;
 	}
 
+	/* Definitely possible for devices to support both of these. */
+	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
+		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
+	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
+		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
+	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
+		indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
+	} else { /* Should never be reached */
+		/* Can only occur on first buffer */
+		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+			dev_dbg(&indio_dev->dev, "Buffer not started: no trigger\n");
+		ret = -EINVAL;
+		goto error_remove_inserted;
+	}
+
 	iio_update_demux(indio_dev);
 
 	/* Wind up again */
@@ -714,30 +732,13 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 			goto error_run_postdisable;
 		}
 	}
-	/* Definitely possible for devices to support both of these. */
-	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
-		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
-	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
-		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
-	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
-		indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
-	} else { /* Should never be reached */
-		/* Can only occur on first buffer */
-		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
-			dev_dbg(&indio_dev->dev, "Buffer not started: no trigger\n");
-		ret = -EINVAL;
-		goto error_run_postdisable;
-	}
 
 	if (indio_dev->setup_ops->postenable) {
 		ret = indio_dev->setup_ops->postenable(indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: postenable failed (%d)\n", ret);
-			indio_dev->currentmode = INDIO_DIRECT_MODE;
-			if (indio_dev->setup_ops->postdisable)
-				indio_dev->setup_ops->postdisable(indio_dev);
-			goto error_disable_all_buffers;
+			goto error_run_postdisable;
 		}
 	}
 
@@ -745,12 +746,11 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 
 	return success;
 
-error_disable_all_buffers:
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
 error_run_postdisable:
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
 error_remove_inserted:
+	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	if (insert_buffer)
 		iio_buffer_deactivate(insert_buffer);
 	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
-- 
1.8.0

