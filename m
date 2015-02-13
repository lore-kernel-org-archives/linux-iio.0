Return-Path: <andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] IIO: si7020: Allocate correct amount of memory in devm_iio_device_alloc
Date: Thu, 12 Feb 2015 23:58:41 -0800
Message-Id: <1423814321-15606-1-git-send-email-andrew.smirnov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Since only a pointer to struct i2c_client is stored in a private area
of IIO device created by the driver there's no need to allocate
sizeof(struct i2c_client) worth of storage.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/iio/humidity/si7020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 69e49f5..fa3b809 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -126,7 +126,7 @@ static int si7020_probe(struct i2c_client *client,
 	/* Wait the maximum power-up time after software reset. */
 	msleep(15);

-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*client));
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;

--
2.1.0
