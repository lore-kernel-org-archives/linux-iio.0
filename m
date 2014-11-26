Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] staging:iio:ad5933: Don't enable channels by default
Date: Wed, 26 Nov 2014 18:55:07 +0100
Message-Id: <1417024517-7564-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-1-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The convention for IIO devices is that all channels are disabled by default.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b6bd609..aa6a368 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -757,10 +757,6 @@ static int ad5933_probe(struct i2c_client *client,
 	if (ret)
 		goto error_unreg_ring;
 
-	/* enable both REAL and IMAG channels by default */
-	iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
-	iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
-
 	ret = ad5933_setup(st);
 	if (ret)
 		goto error_uninitialize_ring;
-- 
1.8.0
