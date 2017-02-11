Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57828 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbdBKMec (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 07:34:32 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] iio: pulsedlight-lidar-lite-v2: Set parent device
Date: Sat, 11 Feb 2017 13:34:20 +0100
Message-Id: <1486816461-28618-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1486816461-28618-1-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize the parent of the IIO device to the device that registered it.
This makes sure that the IIO device appears the right level in the device
hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 20c16a0..36c1ddc 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -278,6 +278,7 @@ static int lidar_probe(struct i2c_client *client,
 	indio_dev->name = LIDAR_DRV_NAME;
 	indio_dev->channels = lidar_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
+	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	i2c_set_clientdata(client, indio_dev);
-- 
2.1.4

