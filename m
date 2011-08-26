Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/12] staging:iio:naming in the EV_BIT macro fix.
Date: Fri, 26 Aug 2011 11:16:32 +0100
Message-Id: <1314353795-7437-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Should always have been IIO_EV_DIR_MAX as that's what it actually controls.
Also reduced the number to 4 as not yet seen a case needing more and this
is not userspace visible anyway.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   20 ++++++++++----------
 drivers/staging/iio/sysfs.h             |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index c4985cb..8c054c0 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -791,27 +791,27 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 
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
 					     chan,
@@ -827,8 +827,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			goto error_ret;
 		attrcount++;
 		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
-				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
-				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
+				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
+				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
 		if (postfix == NULL) {
 			ret = -ENOMEM;
 			goto error_ret;
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index dcb413d..9224f30 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -131,9 +131,9 @@ enum iio_event_direction {
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
