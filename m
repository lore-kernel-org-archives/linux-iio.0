Return-Path: <SRS0=yIYx=6C=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 6/6] staging: iio: tsl2x7x: use usleep_range() instead of mdelay()
Date: Thu, 29 Jun 2017 13:03:52 -0400
Message-Id: <20170629170352.11264-7-masneyb@onstation.org>
In-Reply-To: <20170629170352.11264-1-masneyb@onstation.org>
References: <20170629170352.11264-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This driver in some cases can busy wait for upwards of 15ms. Since the
kernel at this point is not running in atomic context, and is running in
process context, we can safely use usleep_range() instead. This patch
changes the two occurrences of mdelay() to usleep_range().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 6a5d58c..8195faa 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -687,7 +687,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		}
 	}
 
-	mdelay(3);	/* Power-on settling time */
+	/* Power-on settling time */
+	usleep_range(3000, 3500);
 
 	/*
 	 * NOW enable the ADC
@@ -854,7 +855,7 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 
 	/*gather the samples*/
 	for (i = 0; i < chip->tsl2x7x_settings.prox_max_samples_cal; i++) {
-		mdelay(15);
+		usleep_range(15000, 17500);
 		tsl2x7x_get_prox(indio_dev);
 		prox_history[i] = chip->prox_data;
 		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
-- 
2.9.4
