Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/45] iio:chemical: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:50 +0100
Message-Id: <20170723162627.22534-9-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/ams-iaq-core.c    | 1 -
 drivers/iio/chemical/atlas-ph-sensor.c | 2 --
 drivers/iio/chemical/ccs811.c          | 1 -
 drivers/iio/chemical/vz89x.c           | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index c948ad2ee9ad..d9e5950ad24a 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -141,7 +141,6 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ams_iaqcore_info = {
 	.read_raw	= ams_iaqcore_read_raw,
-	.driver_module	= THIS_MODULE,
 };
 
 static int ams_iaqcore_probe(struct i2c_client *client,
diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index ef761a508630..8c4e05580091 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -344,7 +344,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
@@ -499,7 +498,6 @@ static int atlas_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info atlas_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = atlas_read_raw,
 	.write_raw = atlas_write_raw,
 };
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 8dbb5eddeb1f..5b6ab71e8451 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -250,7 +250,6 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ccs811_info = {
 	.read_raw = ccs811_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ccs811_probe(struct i2c_client *client,
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index f75eea6822f2..9c9095ba4227 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -326,7 +326,6 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info vz89x_info = {
 	.attrs		= &vz89x_attrs_group,
 	.read_raw	= vz89x_read_raw,
-	.driver_module	= THIS_MODULE,
 };
 
 static const struct vz89x_chip_data vz89x_chips[] = {
-- 
2.13.3
