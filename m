Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 43/45] iio:potentiometer:max5487: Drop explicit setting of module owner
Date: Sun, 23 Jul 2017 17:26:25 +0100
Message-Id: <20170723162627.22534-44-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The SPI core has handled this for some time.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiometer/max5487.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index ec1a91a0a391..5042d3e09b12 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -146,7 +146,6 @@ MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
 static struct spi_driver max5487_driver = {
 	.driver = {
 		.name = "max5487",
-		.owner = THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(max5487_acpi_match),
 	},
 	.id_table = max5487_id,
-- 
2.13.3
