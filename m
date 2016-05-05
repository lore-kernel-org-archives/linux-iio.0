Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10165 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756403AbcEEIP1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 May 2016 04:15:27 -0400
From: Yong Li <sdliyong@gmail.com>
To: sdliyong@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mranostay@gmail.com,
	fengguang.wu@intel.com, sst@poczta.fm, dan.carpenter@oracle.comn,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light apds9960: Add the missing dev.parent
Date: Thu,  5 May 2016 16:10:49 +0800
Message-Id: <1462435849-23364-1-git-send-email-sdliyong@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Without this, the iio:deviceX is missing in the /sys/bus/i2c/devices/0-0039

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/iio/light/apds9960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 35928fb..f47cc0a 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1010,6 +1010,7 @@ static int apds9960_probe(struct i2c_client *client,
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
+	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &apds9960_info;
 	indio_dev->name = APDS9960_DRV_NAME;
 	indio_dev->channels = apds9960_channels;
-- 
2.5.0

