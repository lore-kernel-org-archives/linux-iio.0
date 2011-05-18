Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 089/111] staging:iio:buffer - remove unused event code for buffer events.
Date: Wed, 18 May 2011 14:42:19 +0100
Message-Id: <1305726161-5606-90-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These events are no longer passed up to userspace.

ad7745 - was using these events to indicate directly dataready
events.  I'm not sure when it ever makes sense to push these
to userspace so for now I've taken them to event codes 0 and 1
until someone has time to make this driver do something more
standard. (they were arbitary before, they still are, be it
in a different way!)

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7745.c |    4 ++--
 drivers/staging/iio/iio.h        |    4 ----
 drivers/staging/iio/sysfs.h      |    1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index afa2648..98b510d 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -522,8 +522,8 @@ static const struct attribute_group ad774x_attribute_group = {
  * data ready events
  */
 
-#define IIO_EVENT_CODE_CAP_RDY     IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_VT_RDY      IIO_BUFFER_EVENT_CODE(1)
+#define IIO_EVENT_CODE_CAP_RDY     0
+#define IIO_EVENT_CODE_VT_RDY      1
 
 #define IIO_EVENT_ATTR_CAP_RDY_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(cap_rdy, _evlist, _show, _store, _mask)
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 1ad9480..4dc4ff0 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -28,10 +28,6 @@
 /* naughty temporary hack to match these against the event version
    - need to flattern these together */
 enum iio_chan_type {
-	/* Need this here for now to support buffer events
-	 * set to 0  to avoid changes to ring_generic.c */
-	IIO_BUFFER = 0,
-
 	/* real channel types */
 	IIO_IN,
 	IIO_CURRENT,
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 9b855f3..dd79b58 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -170,7 +170,6 @@ struct iio_const_attr {
 #define IIO_EV_CLASS_LIGHT		IIO_LIGHT
 #define IIO_EV_CLASS_PROXIMITY		IIO_PROXIMITY
 #define IIO_EV_CLASS_TEMP		IIO_TEMP
-#define IIO_EV_CLASS_BUFFER		IIO_BUFFER
 
 #define IIO_EV_MOD_X			IIO_MOD_X
 #define IIO_EV_MOD_Y			IIO_MOD_Y
-- 
1.7.3.4
