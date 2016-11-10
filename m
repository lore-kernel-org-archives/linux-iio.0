Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50590 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753412AbcKJJ0R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:17 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 07/28] staging: iio: tsl2583: remove redundant write to the control register in taos_probe()
Date: Thu, 10 Nov 2016 04:25:43 -0500
Message-Id: <1478769964-7065-8-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

taos_probe() calls i2c_smbus_write_byte() to select the control
register, however there are no subsequent calls to
i2c_smbus_read_byte(). The write call is unnecessary and is removed by
this patch.

Verified that the driver still functions correctly using a TSL2581
hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5a32102..449506b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -788,14 +788,6 @@ static int taos_probe(struct i2c_client *clientp,
 		return -EINVAL;
 	}
 
-	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
-	if (ret < 0) {
-		dev_err(&clientp->dev,
-			"i2c_smbus_write_byte() to cmd reg failed in taos_probe(), err = %d\n",
-			ret);
-		return ret;
-	}
-
 	indio_dev->info = &tsl2583_info;
 	indio_dev->channels = tsl2583_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl2583_channels);
-- 
2.7.4

