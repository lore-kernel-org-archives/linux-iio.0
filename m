Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 42/45] iio:potentiometer:max5481 drop explicit setting of the owner module.
Date: Sun, 23 Jul 2017 17:26:24 +0100
Message-Id: <20170723162627.22534-43-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

This has been handled by the spi core for some time.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiometer/max5481.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 2f9102544d57..ffe2761333a2 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -206,7 +206,6 @@ MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
 static struct spi_driver max5481_driver = {
 	.driver = {
 		.name  = "max5481",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(max5481_match),
 		.acpi_match_table = ACPI_PTR(max5481_acpi_match),
 	},
-- 
2.13.3
