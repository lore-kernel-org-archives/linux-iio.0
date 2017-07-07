Return-Path: <SRS0=5eqf=6K=embeddedor.com=garsilva@kernel.org>
Date: Fri, 7 Jul 2017 01:46:30 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] iio: adc: meson-saradc: add NULL check on of_match_device()
 return value
Message-ID: <20170707064630.GA21945@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iio/adc/meson_saradc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 83da50e..07dbcc3 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -915,6 +915,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	init_completion(&priv->done);
 
 	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	priv->data = match->data;
 
 	indio_dev->name = priv->data->name;
-- 
2.5.0
