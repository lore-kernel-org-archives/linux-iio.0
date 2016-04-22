Return-Path: <sdliyong@gmail.com>
From: Yong Li <sdliyong@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	k.kozlowski@samsung.com,
	mranostay@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sdliyong@gmail.com
Subject: [PATCH] iio: tmp006: Set correct iio name
Date: Fri, 22 Apr 2016 11:43:04 +0800
Message-Id: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

When load the driver using the below command:
echo tmp006 0x40 > /sys/bus/i2c/devices/i2c-0/new_device

In sysfs, the i2c name is tmp006, however the iio name is 0-0040,
they are inconsistent. With this patch,
the iio name will be the same as the i2c device name

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 18c9b43..17c8413 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -221,7 +221,7 @@ static int tmp006_probe(struct i2c_client *client,
 	data->client = client;
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->name = dev_name(&client->dev);
+	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tmp006_info;
 
-- 
2.5.0
