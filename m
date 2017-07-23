Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 32/45] staging:iio:ad5933: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:14 +0100
Message-Id: <20170723162627.22534-33-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3d539eeb0e26..2b28fb9c0048 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -575,7 +575,6 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5933_info = {
 	.read_raw = ad5933_read_raw,
 	.attrs = &ad5933_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
-- 
2.13.3
