Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio:ring_sw  Fix pointer arithmetic for 64bit arches by using phys_addr_t
Date: Thu, 29 Jul 2010 17:50:51 +0100
Message-Id: <1280422251-13572-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 9b3598e..e2f01c6 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -478,7 +478,7 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
-		*(s64 *)(((u32)data + len
+		*(s64 *)(((phys_addr_t)data + len
 				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
 			= st->last_timestamp;
 	  st->indio_dev->ring->access.store_to(st->indio_dev->ring,
-- 
1.7.1
