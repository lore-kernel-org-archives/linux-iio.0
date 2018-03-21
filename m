Return-Path: <SRS0=Ao9w=GL=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH 08/11] staging: iio: tsl2x7x: remove unused variables from tsl2x7x_get_lux()
Date: Wed, 21 Mar 2018 06:29:09 -0400
Message-Id: <20180321102912.5130-9-masneyb@onstation.org>
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

tsl2x7x_get_lux() has a ch0lux and ch1lux variables that are not used
so this patch removes them.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index c1e441857226..1e38e8449f9e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -344,8 +344,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	struct tsl2x7x_lux *p;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int i, ret;
-	u32 ch0lux = 0;
-	u32 ch1lux = 0;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -416,15 +414,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 				   tsl2x7x_als_gain[chip->settings.als_gain]);
 	}
 
-	/* note: lux is 31 bit max at this point */
-	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev,
-			"%s: ch1lux > ch0lux; returning last value\n",
-			__func__);
-		ret = chip->als_cur_info.lux;
-		goto out_unlock;
-	}
-
 	/* adjust for active time scale */
 	if (chip->als_time_scale == 0)
 		lux = 0;
-- 
2.14.3
