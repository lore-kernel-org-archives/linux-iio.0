Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 20/45] iio:orientation: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:02 +0100
Message-Id: <20170723162627.22534-21-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 1 -
 drivers/iio/orientation/hid-sensor-rotation.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index fd1b3696ee42..1e5451d1ff88 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -186,7 +186,6 @@ static int incl_3d_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info incl_3d_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &incl_3d_read_raw,
 	.write_raw = &incl_3d_write_raw,
 };
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 98fe0c5df380..a69db2002414 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -138,7 +138,6 @@ static int dev_rot_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info dev_rot_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw_multi = &dev_rot_read_raw,
 	.write_raw = &dev_rot_write_raw,
 };
-- 
2.13.3
