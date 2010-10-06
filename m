Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: drivers@analog.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: max1363: prevent buffer overflow
Date: Wed, 6 Oct 2010 16:15:37 +0200
Message-ID: <1286374537-16612-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

ring->access.read_last() reads the entire datum from
the ring including padding and time stamp.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/max1363_ring.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 1d6ce54..896a367 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -38,9 +38,8 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	numvals = hweight_long(st->current_mode->modemask);
 
-	ring_data = kmalloc(numvals*2, GFP_KERNEL);
+	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
-- 
1.6.0.2
