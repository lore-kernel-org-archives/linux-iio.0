Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: drivers@analog.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: max1363: remove unused variable
Date: Wed, 6 Oct 2010 17:49:02 +0200
Message-ID: <1286380142-8881-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/max1363_ring.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 896a367..5532f3e 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -31,7 +31,6 @@
 int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 {
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
-	unsigned long numvals;
 	int count = 0, ret;
 	u8 *ring_data;
 	if (!(st->current_mode->modemask & mask)) {
-- 
1.6.0.2
