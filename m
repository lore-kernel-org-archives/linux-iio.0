Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/16] staging:iio:events move buffer codes so they do not clash with new scheme
Date: Mon,  4 Oct 2010 16:57:57 +0100
Message-Id: <1286207885-26689-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

We could blugeon these more into the scheme I guess, but does it make sense
to do so?

Also remove all remain vestiges of old scheme.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 116dacf..5da6ca6 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -289,13 +289,9 @@ struct iio_const_attr {
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
 	IIO_EVENT_CODE(channelclass, 0, number, 0, type, direction)
 
-#define IIO_EVENT_CODE_DATA_RDY		100
-#define IIO_EVENT_CODE_RING_BASE	200
-#define IIO_EVENT_CODE_ACCEL_BASE	300
-#define IIO_EVENT_CODE_GYRO_BASE	400
-#define IIO_EVENT_CODE_MISC_BASE	600
 
-#define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
+#define IIO_BUFFER_EVENT_CODE(code)		\
+	(IIO_EV_CLASS_BUFFER | (code << 8))
 
 /**
  * IIO_EVENT_ATTR_RING_50_FULL - ring buffer event to indicate 50% full
@@ -327,8 +323,8 @@ struct iio_const_attr {
 #define IIO_EVENT_ATTR_RING_75_FULL_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(ring_75_full, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_RING_50_FULL	IIO_EVENT_CODE_RING_BASE
-#define IIO_EVENT_CODE_RING_75_FULL	(IIO_EVENT_CODE_RING_BASE + 1)
-#define IIO_EVENT_CODE_RING_100_FULL	(IIO_EVENT_CODE_RING_BASE + 2)
+#define IIO_EVENT_CODE_RING_50_FULL	IIO_BUFFER_EVENT_CODE(0)
+#define IIO_EVENT_CODE_RING_75_FULL	IIO_BUFFER_EVENT_CODE(1)
+#define IIO_EVENT_CODE_RING_100_FULL	IIO_BUFFER_EVENT_CODE(2)
 
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
1.7.2.2
