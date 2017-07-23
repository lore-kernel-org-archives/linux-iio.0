Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 31/45] staging:iio:gyro:adis16060 drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:13 +0100
Message-Id: <20170723162627.22534-32-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/gyro/adis16060_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 967524583d8a..4e7630caf7d3 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -103,7 +103,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info adis16060_info = {
 	.read_raw = adis16060_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec adis16060_channels[] = {
-- 
2.13.3
