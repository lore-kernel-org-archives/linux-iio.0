Return-Path: <SRS0=5lPY=5J=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	paolocretaro@gmail.com
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] iio: adc: meson-saradc: fix potential crash in meson_sar_adc_clear_fifo
Date: Sun,  4 Jun 2017 15:28:23 +0200
Message-Id: <20170604132823.21928-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

meson_sar_adc_clear_fifo passes a 0 as value-pointer to regmap_read().
In case of the meson-saradc driver this ends up in regmap_mmio_read(),
where the value-pointer is de-referenced unconditionally to assign the
value which was read.
Fix this by passing an actual pointer, even though all we want to do is
to discard the value.

As a side-effect this fixes a sparse warning ("Using plain integer as
NULL pointer") as reported by Paolo Cretaro.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Reported-by: Paolo Cretaro <paolocretaro@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 81cd39a57fe3..83da50ed73ab 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -475,13 +475,13 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
 static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int count;
+	unsigned int count, tmp;
 
 	for (count = 0; count < MESON_SAR_ADC_MAX_FIFO_SIZE; count++) {
 		if (!meson_sar_adc_get_fifo_count(indio_dev))
 			break;
 
-		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
+		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &tmp);
 	}
 }
 
-- 
2.13.0
