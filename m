Return-Path: <SRS0=bJn/=6T=gmail.com=festevam@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] iio: adc: ad7766: Remove unneeded gpiod NULL check
Date: Sun, 16 Jul 2017 18:26:03 -0300
Message-Id: <1500240363-16396-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/iio/adc/ad7766.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 75cca42..ce45037 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -103,8 +103,7 @@ static int ad7766_preenable(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	if (ad7766->pd_gpio)
-		gpiod_set_value(ad7766->pd_gpio, 0);
+	gpiod_set_value(ad7766->pd_gpio, 0);
 
 	return 0;
 }
@@ -113,8 +112,7 @@ static int ad7766_postdisable(struct iio_dev *indio_dev)
 {
 	struct ad7766 *ad7766 = iio_priv(indio_dev);
 
-	if (ad7766->pd_gpio)
-		gpiod_set_value(ad7766->pd_gpio, 1);
+	gpiod_set_value(ad7766->pd_gpio, 1);
 
 	/*
 	 * The PD pin is synchronous to the clock, so give it some time to
-- 
2.7.4
