Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/45] iio:humidity: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:58 +0100
Message-Id: <20170723162627.22534-17-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/am2315.c              | 1 -
 drivers/iio/humidity/dht11.c               | 1 -
 drivers/iio/humidity/hdc100x.c             | 1 -
 drivers/iio/humidity/hid-sensor-humidity.c | 1 -
 drivers/iio/humidity/hts221_buffer.c       | 1 -
 drivers/iio/humidity/hts221_core.c         | 1 -
 drivers/iio/humidity/htu21.c               | 1 -
 drivers/iio/humidity/si7005.c              | 1 -
 drivers/iio/humidity/si7020.c              | 1 -
 9 files changed, 9 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index ff96b6d0fdae..7d8669dc6547 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -215,7 +215,6 @@ static int am2315_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info am2315_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= am2315_read_raw,
 };
 
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 2a22ad920333..df6bab40d6fa 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -284,7 +284,6 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 }
 
 static const struct iio_info dht11_iio_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= dht11_read_raw,
 };
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 7851bd90ef64..d8438310b6d4 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -357,7 +357,6 @@ static const struct iio_info hdc100x_info = {
 	.read_raw = hdc100x_read_raw,
 	.write_raw = hdc100x_write_raw,
 	.attrs = &hdc100x_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int hdc100x_probe(struct i2c_client *client,
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 6e09c1acfe51..beab6d6fd6e1 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -125,7 +125,6 @@ static int humidity_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info humidity_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &humidity_read_raw,
 	.write_raw = &humidity_write_raw,
 };
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index ad5222295b2c..dbec5c535e64 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -37,7 +37,6 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops hts221_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = hts221_trig_set_state,
 };
 
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 25fcb9993998..26a12bcd384c 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -587,7 +587,6 @@ static const struct attribute_group hts221_attribute_group = {
 };
 
 static const struct iio_info hts221_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &hts221_attribute_group,
 	.read_raw = hts221_read_raw,
 	.write_raw = hts221_write_raw,
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 2c4b9be85a05..f5a2701ba6dd 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -175,7 +175,6 @@ static const struct iio_info htu21_info = {
 	.read_raw = htu21_read_raw,
 	.write_raw = htu21_write_raw,
 	.attrs = &htu21_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int htu21_probe(struct i2c_client *client,
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index 6297766e93d0..1fd19f035a5d 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -124,7 +124,6 @@ static const struct iio_chan_spec si7005_channels[] = {
 
 static const struct iio_info si7005_info = {
 	.read_raw = si7005_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int si7005_probe(struct i2c_client *client,
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 345a7656c5ef..1b2ec8df1a72 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -108,7 +108,6 @@ static const struct iio_chan_spec si7020_channels[] = {
 
 static const struct iio_info si7020_info = {
 	.read_raw = si7020_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int si7020_probe(struct i2c_client *client,
-- 
2.13.3
