Return-Path: <SRS0=oUj+=BT=gmail.com=clabbe.montjoie@kernel.org>
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	pmeerw@pmeerw.net,
	quentin.schulz@free-electrons.com
Cc: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] iio: adc: sun4i-gpadc: use of_device_get_match_data
Date: Fri, 20 Oct 2017 07:37:29 +0200
Message-Id: <20171020053729.23248-1-clabbe.montjoie@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The usage of of_device_get_match_data reduce the code size a bit.
Furthermore, it prevents an improbable dereference when
of_match_device() return NULL.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c4e70f1cad79..04d7147e0110 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -501,17 +501,15 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 				struct iio_dev *indio_dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-	const struct of_device_id *of_dev;
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
 
-	of_dev = of_match_device(sun4i_gpadc_of_id, &pdev->dev);
-	if (!of_dev)
+	info->data = of_device_get_match_data(&pdev->dev);
+	if (!info->data)
 		return -ENODEV;
 
 	info->no_irq = true;
-	info->data = (struct gpadc_data *)of_dev->data;
 	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
 	indio_dev->channels = sun8i_a33_gpadc_channels;
 
-- 
2.13.6
