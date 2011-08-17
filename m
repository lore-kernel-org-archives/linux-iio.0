Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54951 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1HQIeO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 04:34:14 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/6] staging:iio:add adaptive event types and missing extract_type macro.
Date: Wed, 17 Aug 2011 09:42:14 +0100
Message-Id: <1313570537-26971-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm not entirely sure this is the right way to go. Suggestions of other
options welcome!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    4 +++-
 drivers/staging/iio/sysfs.h             |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e1e6f07..a14f8fb 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -705,7 +705,9 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
-	[IIO_EV_TYPE_ROC] = "roc"
+	[IIO_EV_TYPE_ROC] = "roc",
+	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
+	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 };
 
 static const char * const iio_ev_dir_text[] = {
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index dcb413d..78f1a2a 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -118,6 +118,8 @@ enum iio_event_type {
 	IIO_EV_TYPE_THRESH,
 	IIO_EV_TYPE_MAG,
 	IIO_EV_TYPE_ROC,
+	IIO_EV_TYPE_THRESH_ADAPTIVE,
+	IIO_EV_TYPE_MAG_ADAPTIVE,
 };
 
 enum iio_event_direction {
@@ -142,6 +144,7 @@ enum iio_event_direction {
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
 	IIO_EVENT_CODE(channelclass, 0, direction, type, number, 0, 0)
 
+#define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
 #define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
 
 /* Event code number extraction depends on which type of event we have.
-- 
1.7.3.4

