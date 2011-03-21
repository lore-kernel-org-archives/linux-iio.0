Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/6] IIO: IMU: ADIS16400: Make sure only enabled scan_elements are pushed into the ring
Date: Mon, 21 Mar 2011 16:44:38 +0100
Message-ID: <1300722280-10720-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
References: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
CC: stable <stable@kernel.org>
---
 drivers/staging/iio/imu/adis16400_ring.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index ac381ca..da28cb4 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -160,9 +160,10 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 			       work_trigger_to_ring);
 	struct iio_ring_buffer *ring = st->indio_dev->ring;

-	int i = 0;
+	int i = 0, j;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
+	unsigned long mask = ring->scan_mask;

 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
@@ -172,9 +173,12 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)

 	if (ring->scan_count)
 		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
+			for (; i < ring->scan_count; i++) {
+				j = __ffs(mask);
+				mask &= ~(1 << j);
 				data[i]	= be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+					(__be16 *)&(st->rx[j*2]));
+			}

 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
--
1.6.0.2
