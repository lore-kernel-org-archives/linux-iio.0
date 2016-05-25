Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33637 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbcEYHkh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 03:40:37 -0400
Received: by mail-lf0-f41.google.com with SMTP id e131so14696869lfb.0
        for <linux-iio@vger.kernel.org>; Wed, 25 May 2016 00:40:36 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] iio: light: bh1780: assign a static name
Date: Wed, 25 May 2016 09:40:27 +0200
Message-Id: <1464162027-24612-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
References: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using the struct i2c_device->id field for naming the light sensor
is a bad idea: when booting from the pure device tree this is NULL
and that causes the device not to have the "name" property in
sysfs and that in turn confuses the "lsiio" command to stop listing
devices.

So instead of using the device .id, use the hard string "bh1780",
which works just fine.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/bh1780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 5fd432df2c8f..b54dcba05a82 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -187,7 +187,7 @@ static int bh1780_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &bh1780_info;
-	indio_dev->name = id->name;
+	indio_dev->name = "bh1780";
 	indio_dev->channels = bh1780_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bh1780_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.4.11

