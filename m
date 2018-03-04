Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:52838 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeCDByy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 20:54:54 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 05/12] staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
Date: Sat,  3 Mar 2018 20:49:35 -0500
Message-Id: <20180304014942.18727-6-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver uses mutex_lock() and mutex_trylock() in several places.
Convert the mutex_trylock() to mutex_lock() for consistency with other
IIO light drivers in mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cf16dd206c0b..5c611250127f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -350,8 +350,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	u32 ch0lux = 0;
 	u32 ch1lux = 0;
 
-	if (mutex_trylock(&chip->als_mutex) == 0)
-		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
+	mutex_lock(&chip->als_mutex);
 
 	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
 		/* device is not enabled */
@@ -478,11 +477,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	u8 chdata[2];
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
-	if (mutex_trylock(&chip->prox_mutex) == 0) {
-		dev_err(&chip->client->dev,
-			"%s: Can't get prox mutex\n", __func__);
-		return -EBUSY;
-	}
+	mutex_lock(&chip->prox_mutex);
 
 	ret = tsl2x7x_read_status(chip);
 	if (ret < 0)
-- 
2.14.3

