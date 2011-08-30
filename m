Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42966 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab1H3LdL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 07:33:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/14] staging:iio: struct iio_dev formatting cleanup and documentation fixes.
Date: Tue, 30 Aug 2011 12:41:12 +0100
Message-Id: <1314704479-15956-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 1c24d13..36a826e 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -265,8 +265,10 @@ struct iio_info {
  * @channels:		[DRIVER] channel specification structure table
  * @num_channels:	[DRIVER] number of chanels specified in @channels.
  * @channel_attr_list:	[INTERN] keep track of automatically created channel
- *			attributes.
+ *			attributes
  * @name:		[DRIVER] name of the device.
+ * @info:		[DRIVER] callbacks and constant info from driver
+ * @chrdev:		[INTERN] associated character device
  **/
 struct iio_dev {
 	int				id;
@@ -284,13 +286,13 @@ struct iio_dev {
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
-	struct iio_chan_spec const *channels;
-	int num_channels;
+	struct iio_chan_spec const	*channels;
+	int				num_channels;
 
-	struct list_head channel_attr_list;
-	const char *name;
-	const struct iio_info *info;
-	struct cdev				chrdev;
+	struct list_head		channel_attr_list;
+	const char			*name;
+	const struct iio_info		*info;
+	struct cdev			chrdev;
 };
 
 /**
@@ -308,11 +310,10 @@ void iio_device_unregister(struct iio_dev *dev_info);
 /**
  * iio_push_event() - try to add event to the list for userspace reading
  * @dev_info:		IIO device structure
- * @ev_line:		Which event line (hardware interrupt)
  * @ev_code:		What event
  * @timestamp:		When the event occurred
  **/
-int iio_push_event(struct iio_dev *dev_info, int ev_code,  s64 timestamp);
+int iio_push_event(struct iio_dev *dev_info, int ev_code, s64 timestamp);
 
 extern struct bus_type iio_bus_type;
 
-- 
1.7.3.4

