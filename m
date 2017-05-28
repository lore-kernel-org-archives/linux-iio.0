Return-Path: <SRS0=Behn=5C=gmail.com=paolocretaro@kernel.org>
From: Paolo Cretaro <paolocretaro@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Cretaro <paolocretaro@gmail.com>
Subject: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for pointer
Date: Sun, 28 May 2017 13:24:38 +0200
Message-Id: <20170528112438.10427-1-paolocretaro@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix sparse warning: Using plain integer as NULL pointer

Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 81cd39a57fe3..fb3f67a9ae1f 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
 		if (!meson_sar_adc_get_fifo_count(indio_dev))
 			break;
 
-		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
+		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
 	}
 }
 
-- 
2.13.0
