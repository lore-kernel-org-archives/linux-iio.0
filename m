Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 27/45] staging:iio:accel: drop assignment of iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:09 +0100
Message-Id: <20170723162627.22534-28-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16201.c | 1 -
 drivers/staging/iio/accel/adis16203.c | 1 -
 drivers/staging/iio/accel/adis16209.c | 1 -
 drivers/staging/iio/accel/adis16240.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index fbc240663621..2ebd27536216 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -284,7 +284,6 @@ static const struct iio_info adis16201_info = {
 	.read_raw = adis16201_read_raw,
 	.write_raw = adis16201_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const adis16201_status_error_msgs[] = {
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 4e3fa7592d3f..b3e4571340ab 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -232,7 +232,6 @@ static const struct iio_info adis16203_info = {
 	.read_raw = adis16203_read_raw,
 	.write_raw = adis16203_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const adis16203_status_error_msgs[] = {
diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8485c024e3f5..7fcef9a2590a 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -285,7 +285,6 @@ static const struct iio_info adis16209_info = {
 	.read_raw = adis16209_read_raw,
 	.write_raw = adis16209_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const adis16209_status_error_msgs[] = {
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 109cd94b5ac3..fff6d99089cc 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -361,7 +361,6 @@ static const struct iio_info adis16240_info = {
 	.read_raw = adis16240_read_raw,
 	.write_raw = adis16240_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const adis16240_status_error_msgs[] = {
-- 
2.13.3
