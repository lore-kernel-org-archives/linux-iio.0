Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] iio: adc: mxs-lradc: fix warning when buidling on avr32
Date: Mon, 17 Mar 2014 17:43:11 +0100
Message-Id: <1395074591-21637-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes:
drivers/staging/iio/adc/mxs-lradc.c: In function 'mxs_lradc_probe':
drivers/staging/iio/adc/mxs-lradc.c:1558: warning: comparison of distinct pointer types lacks a cast
drivers/staging/iio/adc/mxs-lradc.c:1558: warning: right shift count >= width of type
drivers/staging/iio/adc/mxs-lradc.c:1558: warning: passing argument 1 of '__div64_32' from incompatible pointer type

When building on avr32.

Reported-by: fengguang.wu@intel.com

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 514844efac75..53b3f963a7e3 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1527,7 +1527,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	struct resource *iores;
 	int ret = 0, touch_ret;
 	int i, s;
-	unsigned int scale_uv;
+	uint64_t scale_uv;
 
 	/* Allocate the IIO device. */
 	iio = devm_iio_device_alloc(dev, sizeof(*lradc));
-- 
1.8.3.2
