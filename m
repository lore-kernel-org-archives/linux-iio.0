Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 30/45] staging:iio:frequency: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:12 +0100
Message-Id: <20170723162627.22534-31-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c | 1 -
 drivers/staging/iio/frequency/ad9834.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6da46ede7ee0..c73eff1f8d73 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -290,7 +290,6 @@ static const struct attribute_group ad9832_attribute_group = {
 
 static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9832_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 995acdd7c942..4c6d4043903e 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -381,12 +381,10 @@ static const struct attribute_group ad9833_attribute_group = {
 
 static const struct iio_info ad9834_info = {
 	.attrs = &ad9834_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad9833_info = {
 	.attrs = &ad9833_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9834_probe(struct spi_device *spi)
-- 
2.13.3
