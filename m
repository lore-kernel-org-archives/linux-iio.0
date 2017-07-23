Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH 41/45] iio:adc:ti-ads8688: Drop manual setting of the driver owner field.
Date: Sun, 23 Jul 2017 17:26:23 +0100
Message-Id: <20170723162627.22534-42-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

This has been handled by the spi core for some time now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/adc/ti-ads8688.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index ff4756352ac1..079f133144b0 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -473,7 +473,6 @@ MODULE_DEVICE_TABLE(of, ads8688_of_match);
 static struct spi_driver ads8688_driver = {
 	.driver = {
 		.name	= "ads8688",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ads8688_probe,
 	.remove		= ads8688_remove,
-- 
2.13.3
