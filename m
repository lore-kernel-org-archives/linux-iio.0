Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: fengguang.wu@intel.com,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:adc:ad7298 Mark the rx and tx buffers as big endian.
Date: Sun, 18 Nov 2012 13:47:00 +0000
Message-Id: <1353246420-13723-1-git-send-email-jic23@kernel.org>
In-Reply-To: <50A8E5DF.7000607@kernel.org>
References: <50A8E5DF.7000607@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Sparse shows that these two buffers should be __be16
rather than unsigned short when one enables endian
checks.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: fengguang.wu@intel.com
---
 drivers/iio/adc/ad7298.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 441a9a2..2691ad9 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -54,8 +54,8 @@ struct ad7298_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	unsigned short			rx_buf[12] ____cacheline_aligned;
-	unsigned short			tx_buf[2];
+	__be16			rx_buf[12] ____cacheline_aligned;
+	__be16			tx_buf[2];
 };
 
 #define AD7298_V_CHAN(index)						\
-- 
1.8.0
