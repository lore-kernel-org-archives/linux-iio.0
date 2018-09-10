Return-Path: <SRS0=DSge=LY=metafoo.de=lars@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio:ad7606: Remove incorrect kernel doc annotation
Date: Mon, 10 Sep 2018 18:16:38 +0200
Message-Id: <20180910161639.13591-1-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ad7606_chip_info struct has no field called lock. Remove the kernel
documentation annotation for it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 9716ee9d94a7..fb56f479e2f1 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -14,7 +14,6 @@
  * @name:		identification string for chip
  * @channels:		channel specification
  * @num_channels:	number of channels
- * @lock		protect sensor state
  */
 
 struct ad7606_chip_info {
-- 
2.11.0
