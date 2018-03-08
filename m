Return-Path: <SRS0=5UZ9=F6=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 8 Mar 2018 12:31:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Paolo Cretaro <paolocretaro@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: meson-saradc: unlock on error in
 meson_sar_adc_lock()
Message-ID: <20180308093153.GB16525@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The meson_sar_adc_lock() function is not supposed to hold the
"indio_dev->mlock" on the error path.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 29fa7736d80c..ede955d9b2a4 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -462,8 +462,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
-		if (timeout < 0)
+		if (timeout < 0) {
+			mutex_unlock(&indio_dev->mlock);
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
