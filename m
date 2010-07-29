Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/6] staging:iio:ring_sw  remove unnecessary function stub.
Date: Thu, 29 Jul 2010 17:50:50 +0100
Message-Id: <1280422251-13572-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 7c27e2c..61f1ed6 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -220,8 +220,6 @@ void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time);
 void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
 
 #else /* CONFIG_IIO_RING_BUFFER*/
-static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
-{};
 struct iio_sw_ring_helper_state {
 	struct iio_dev			*indio_dev;
 };
-- 
1.7.1
