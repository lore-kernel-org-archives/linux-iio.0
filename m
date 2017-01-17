Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49098 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbdAQJZX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 09/15] staging: iio: isl29028: remove unnecessary error logging in isl29028_chip_init_and_power_on()
Date: Tue, 17 Jan 2017 04:24:56 -0500
Message-Id: <20170117092502.6951-10-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the call to isl29028_chip_init_and_power_on() in isl29028_probe()
fails, then isl29028_probe() will log an error message. All of the
error paths in that call path already have error logging in place. This
patch removes the unnecessary logging.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index cffecf9..be1fc4a 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -528,10 +528,8 @@ static int isl29028_probe(struct i2c_client *client,
 	}
 
 	ret = isl29028_chip_init_and_power_on(chip);
-	if (ret < 0) {
-		dev_err(&client->dev, "chip initialization failed: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	indio_dev->info = &isl29028_info;
 	indio_dev->channels = isl29028_channels;
-- 
2.9.3

