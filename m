Return-Path: <bvandre@gmail.com>
From: Brian Vandre <bvandre@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org
Cc: Brian Vandre <bvandre@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Staging: iio: adc: fix line over 80 characters
Date: Mon, 20 Oct 2014 21:48:49 -0500
Message-Id: <ae23d2ee684d28139b8d0dc86b988d9ef84e7c3a.1413858979.git.bvandre@gmail.com>
In-Reply-To: <cover.1413858979.git.bvandre@gmail.com>
References: <cover.1413858979.git.bvandre@gmail.com>
In-Reply-To: <cover.1413858979.git.bvandre@gmail.com>
References: <cover.1413858979.git.bvandre@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes the checkpatch.pl warning:
WARNING: line over 80 characters

Signed-off-by: Brian Vandre <bvandre@gmail.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 7d4b068..62449a6 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -514,7 +514,8 @@ static void mxs_lradc_setup_ts_pressure(struct mxs_lradc *lradc, unsigned ch1,
 	 * SoC's delay unit and start the conversion later
 	 * and automatically.
 	 */
-	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
+	mxs_lradc_reg_wrt(lradc,
+		LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
 		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit#3 */
 		LRADC_DELAY_KICK |
 		LRADC_DELAY_DELAY(lradc->settling_delay), LRADC_DELAY(2));
-- 
1.9.1
