Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: imu: adis16400: Avoid null pointer dereference
Date: Fri, 26 Aug 2011 10:43:20 +0200
Message-ID: <1314348200-11112-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Not sure if this is a proper fix. However it should do the trick.
ring->scan_maks is allocated in iio_ring_buffer_register() which called
after adis16400_configure_ring. So the time this pointer dereference takes
place scan_mask is uninitialized.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/imu/adis16400_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 1a47d07..f6d50be 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -191,7 +191,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
 	/* Set default scan mode - assumes single long is big enough */
-	*ring->scan_mask = st->variant->default_scan_mask;
+	ring->scan_mask = &st->variant->default_scan_mask;
 	ring->scan_count = hweight_long(st->variant->default_scan_mask);
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-- 
1.7.0.4
