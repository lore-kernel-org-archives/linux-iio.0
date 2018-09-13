Return-Path: <SRS0=9z2R=L3=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
	<lars@metafoo.de>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH] staging:iio:ad7606: fix voltage scales
Date: Thu, 13 Sep 2018 10:39:20 +0300
Message-ID: <20180913073920.16089-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes commit 17be2a2905a6ec9aa27cd59521495e2f490d2af0 ("staging: iio:
ad7606: replace range/range_available with corresponding scale").

The AD7606 devices don't have a 2.5V voltage range, they have 5V & 10V
voltage range, which is selectable via the `gpio_range` descriptor.

The scales also seem to have been miscomputed, because when they were
applied to the raw values, the results differ from the expected values.
After checking the ADC transfer function in the datasheet, these were
re-computed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index c5fe3003075b..8f0eebf7316d 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -26,9 +26,11 @@
 
 #include "ad7606.h"
 
-/* Scales are computed as 2.5/2**16 and 5/2**16 respectively */
+/* Scales are computed as 5000/2**16 and 10000/2**16 respectively,
+ * so that when applied to the raw values they provide mV values
+ */
 static const unsigned int scale_avail[2][2] = {
-	{0, 38147}, {0, 76294}
+	{0, 152588}, {0, 305176}
 };
 
 static int ad7606_reset(struct ad7606_state *st)
-- 
2.17.1
