Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/14] staging:iio:buffering drag some stray docs back to correct place.
Date: Tue, 30 Aug 2011 12:41:13 +0100
Message-Id: <1314704479-15956-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index a63a9cb..37ab4db 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -65,6 +65,13 @@ struct iio_ring_access_funcs {
 	int (*enable)(struct iio_ring_buffer *ring);
 };
 
+/**
+ * struct iio_ring_setup_ops - buffer setup related callbacks
+ * @preenable:		[DRIVER] function to run prior to marking ring enabled
+ * @postenable:		[DRIVER] function to run after marking ring enabled
+ * @predisable:		[DRIVER] function to run prior to marking ring disabled
+ * @postdisable:	[DRIVER] function to run after marking ring disabled
+ */
 struct iio_ring_setup_ops {
 	int				(*preenable)(struct iio_dev *);
 	int				(*postenable)(struct iio_dev *);
@@ -87,10 +94,6 @@ struct iio_ring_setup_ops {
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
  * @access:		[DRIVER] ring access functions associated with the
  *			implementation.
- * @preenable:		[DRIVER] function to run prior to marking ring enabled
- * @postenable:		[DRIVER] function to run after marking ring enabled
- * @predisable:		[DRIVER] function to run prior to marking ring disabled
- * @postdisable:	[DRIVER] function to run after marking ring disabled
  * @flags:		[INTERN] file ops related flags including busy flag.
  **/
 struct iio_ring_buffer {
-- 
1.7.3.4
