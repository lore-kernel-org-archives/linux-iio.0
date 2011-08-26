Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/12] staging:iio:add adaptive event types and missing extract_type macro.
Date: Fri, 26 Aug 2011 11:16:34 +0100
Message-Id: <1314353795-7437-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I'm not entirely sure this is the right way to go. Suggestions of other
options welcome!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    4 +++-
 drivers/staging/iio/sysfs.h             |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 44a5be5..83e55b1 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -700,7 +700,9 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
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
index 9224f30..3388b8c 100644
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
