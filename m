Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<fengguang.wu@intel.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: staging: ad7298_ring: Fix maybe-uninitialized warning
Date: Mon, 16 Jul 2012 10:42:05 +0200
Message-ID: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

drivers/staging/iio/adc/ad7298_ring.c:97:37: warning: 'time_ns' may
be used uninitialized in this function [-Wmaybe-uninitialized]

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7298_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index fd1d855..506016f 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -76,7 +76,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
 	struct iio_buffer *ring = indio_dev->buffer;
-	s64 time_ns;
+	s64 time_ns = 0;
 	__u16 buf[16];
 	int b_sent, i;
 
-- 
1.7.0.4
