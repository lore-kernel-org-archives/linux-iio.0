Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:56270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbcHHLFg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Aug 2016 07:05:36 -0400
From: Vignesh R <vigneshr@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lee Jones <lee.jones@linaro.org>,
	"Andrew F . Davis" <afd@ti.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] iio: adc: ti_am335x_adc: Increase timeout value waiting for ADC sample
Date: Mon, 8 Aug 2016 16:35:01 +0530
Message-ID: <20160808110501.29586-3-vigneshr@ti.com>
In-Reply-To: <20160808110501.29586-1-vigneshr@ti.com>
References: <20160808110501.29586-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that open delay and sample delay for each channel is configurable
via DT, the default IDLE_TIMEOUT value is not enough as this is
calculated based on hardcoded macros. This results in driver returning
EBUSY sometimes. Fix this by increasing the timeout
value based on maximum value possible to open delay and sample delays
for each channel.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c      | 2 +-
 include/linux/mfd/ti_am335x_tscadc.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index bed9977a1863..c3cfacca2541 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -381,7 +381,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
 
-	timeout = jiffies + usecs_to_jiffies
+	timeout = jiffies + msecs_to_jiffies
 				(IDLE_TIMEOUT * adc_dev->channels);
 	/* Wait for Fifo threshold interrupt */
 	while (1) {
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 2567a87872b0..7f55b8b41032 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -138,16 +138,16 @@
 /*
  * time in us for processing a single channel, calculated as follows:
  *
- * num cycles = open delay + (sample delay + conv time) * averaging
+ * max num cycles = open delay + (sample delay + conv time) * averaging
  *
- * num cycles: 152 + (1 + 13) * 16 = 376
+ * max num cycles: 262143 + (255 + 13) * 16 = 266431
  *
  * clock frequency: 26MHz / 8 = 3.25MHz
  * clock period: 1 / 3.25MHz = 308ns
  *
- * processing time: 376 * 308ns = 116us
+ * max processing time: 266431 * 308ns = 83ms(approx)
  */
-#define IDLE_TIMEOUT 116 /* microsec */
+#define IDLE_TIMEOUT 83 /* milliseconds */
 
 #define TSCADC_CELLS		2
 
-- 
2.9.2

