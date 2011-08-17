Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54947 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab1HQIeO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 04:34:14 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio:naming in the EV_BIT macro fix.
Date: Wed, 17 Aug 2011 09:42:15 +0100
Message-Id: <1313570537-26971-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Should always have been IIO_EV_DIR_MAX as that's what it actually controls.
Also reduced the number to 4 as not yet seen a case needing more and this
is not userspace visible anyway.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   20 ++++++++++----------
 drivers/staging/iio/sysfs.h             |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index a14f8fb..5c81034 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -799,27 +799,27 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 
 	for_each_set_bit(i, &chan->event_mask, sizeof(chan->event_mask)*8) {
 		postfix = kasprintf(GFP_KERNEL, "%s_%s_en",
-				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
-				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
+				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
+				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
 		if (postfix == NULL) {
 			ret = -ENOMEM;
 			goto error_ret;
 		}
 		if (chan->modified)
 			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
-						  i/IIO_EV_TYPE_MAX,
-						  i%IIO_EV_TYPE_MAX);
+						  i/IIO_EV_DIR_MAX,
+						  i%IIO_EV_DIR_MAX);
 		else if (chan->type == IIO_VOLTAGE_DIFF)
 			mask = IIO_MOD_EVENT_CODE(chan->type,
 						  chan->channel,
 						  chan->channel2,
-						  i/IIO_EV_TYPE_MAX,
-						  i%IIO_EV_TYPE_MAX);
+						  i/IIO_EV_DIR_MAX,
+						  i%IIO_EV_DIR_MAX);
 		else
 			mask = IIO_UNMOD_EVENT_CODE(chan->type,
 						    chan->channel,
-						    i/IIO_EV_TYPE_MAX,
-						    i%IIO_EV_TYPE_MAX);
+						    i/IIO_EV_DIR_MAX,
+						    i%IIO_EV_DIR_MAX);
 
 		ret = __iio_add_chan_devattr(postfix,
 					     "events",
@@ -836,8 +836,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			goto error_ret;
 
 		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
-				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
-				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
+				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
+				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
 		if (postfix == NULL) {
 			ret = -ENOMEM;
 			goto error_ret;
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 78f1a2a..3388b8c 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -133,9 +133,9 @@ enum iio_event_direction {
 	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
 	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
 
-#define IIO_EV_TYPE_MAX 8
+#define IIO_EV_DIR_MAX 4
 #define IIO_EV_BIT(type, direction)			\
-	(1 << (type*IIO_EV_TYPE_MAX + direction))
+	(1 << (type*IIO_EV_DIR_MAX + direction))
 
 #define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
 			   type, direction)				\
-- 
1.7.3.4

