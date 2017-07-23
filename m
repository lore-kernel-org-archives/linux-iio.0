Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/45] iio:frequency: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:25:55 +0100
Message-Id: <20170723162627.22534-14-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/ad9523.c  | 1 -
 drivers/iio/frequency/adf4350.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 99eba524f6dd..ddb6a334ae68 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -738,7 +738,6 @@ static const struct iio_info ad9523_info = {
 	.write_raw = &ad9523_write_raw,
 	.debugfs_reg_access = &ad9523_reg_access,
 	.attrs = &ad9523_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9523_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index d2d824b446f5..6d768431d90e 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -374,7 +374,6 @@ static const struct iio_chan_spec adf4350_chan = {
 
 static const struct iio_info adf4350_info = {
 	.debugfs_reg_access = &adf4350_reg_access,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_OF
-- 
2.13.3
