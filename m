Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60025 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757157AbcJSRHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:21 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/13] staging:iio:ad7606: Move set_drvdata() into common code
Date: Wed, 19 Oct 2016 19:07:03 +0200
Message-Id: <1476896828-10544-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Both the platform_device and SPI driver call set_drvdata() at the end of
their probe function. Move this into the common probe() function to reduce
duplicated code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c | 2 ++
 drivers/staging/iio/adc/ad7606_par.c  | 2 --
 drivers/staging/iio/adc/ad7606_spi.c  | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 4ce103a..13d8090 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -517,6 +517,8 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		goto error_unregister_ring;
 
+	dev_set_drvdata(dev, indio_dev);
+
 	return indio_dev;
 error_unregister_ring:
 	ad7606_ring_cleanup(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 0a23cd9..c273993 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -77,8 +77,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	if (IS_ERR(indio_dev))
 		return PTR_ERR(indio_dev);
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index f69db59..9abbc15 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -52,8 +52,6 @@ static int ad7606_spi_probe(struct spi_device *spi)
 	if (IS_ERR(indio_dev))
 		return PTR_ERR(indio_dev);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	return 0;
 }
 
-- 
2.1.4

