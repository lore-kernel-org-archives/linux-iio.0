Return-Path: <van.freenix@gmail.com>
From: Peng Fan <van.freenix@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org
Cc: linux-kernel@vger.kernel.org,
	van.freenix@gmail.com,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tapasweni Pathak <tapaswenipathak@gmail.com>
Subject: [PATCH] staging: iio: adc: lpc32xx: use correct reutrn value
Date: Sun, 30 Aug 2015 16:12:57 +0800
Message-Id: <1440922377-16938-1-git-send-email-van.freenix@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

To lpc32xx_adc driver, when platform_get_resource or
platform_get_irq failed, we should use -ENXIO as a
return value, but not -EBUSY.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tapasweni Pathak <tapaswenipathak@gmail.com>
---
 drivers/staging/iio/adc/lpc32xx_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 5331c44..bcf4ebb 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -137,7 +137,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
-		return -EBUSY;
+		return -ENXIO;
 	}
 
 	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
@@ -162,7 +162,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(&pdev->dev, "failed getting interrupt resource\n");
-		return -EINVAL;
+		return -ENXIO;
 	}
 
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
-- 
1.8.4
