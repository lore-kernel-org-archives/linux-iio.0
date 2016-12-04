Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47164 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbcLDCUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 16/19] staging: iio: isl29028: remove unnecessary error logging in isl29028_chip_init_and_power_on()
Date: Sat,  3 Dec 2016 21:19:40 -0500
Message-Id: <1480817983-32359-17-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
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
index a45d57c..3f01ad1 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -548,10 +548,8 @@ static int isl29028_probe(struct i2c_client *client,
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
2.7.4

