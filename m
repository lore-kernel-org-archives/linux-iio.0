Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/11] iio/adc: (lp8788) Provide OF node information to iio device
Date: Thu, 31 Jan 2013 13:43:01 -0800
Message-Id: <1359668588-13678-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/adc/lp8788_adc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 72955e4..e5293d0 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -208,6 +208,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 	adc->lp = lp;
 	platform_set_drvdata(pdev, indio_dev);
 
+	indio_dev->dev.of_node = pdev->dev.of_node;
 	ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
 	if (ret)
 		goto err_iio_map;
-- 
1.7.9.7
