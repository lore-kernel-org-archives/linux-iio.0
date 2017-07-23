Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 40/45] iio:adc:max9611: Drop explicit setting of the i2c module owner.
Date: Sun, 23 Jul 2017 17:26:22 +0100
Message-Id: <20170723162627.22534-41-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

This has been handled by the i2c core for some time.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max9611.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 9edfbabf4e4d..0538ff8c4ac1 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -572,7 +572,6 @@ static int max9611_probe(struct i2c_client *client,
 static struct i2c_driver max9611_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
-		   .owner = THIS_MODULE,
 		   .of_match_table = max9611_of_table,
 	},
 	.probe = max9611_probe,
-- 
2.13.3
