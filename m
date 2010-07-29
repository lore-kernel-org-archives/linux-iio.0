Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio: iio_sw_ring_helper_state - add dummy case for no buffer builds.
Date: Thu, 29 Jul 2010 17:50:46 +0100
Message-Id: <1280422251-13572-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 0194e7f..7c27e2c 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -222,5 +222,8 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
 #else /* CONFIG_IIO_RING_BUFFER*/
 static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
 {};
+struct iio_sw_ring_helper_state {
+	struct iio_dev			*indio_dev;
+};
 #endif /* !CONFIG_IIO_RING_BUFFER */
 #endif /* _IIO_RING_SW_H_ */
-- 
1.7.1
