Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 39/45] iio: drop iio_info.driver_module and iio_trigger_ops.owner.
Date: Sun, 23 Jul 2017 17:26:21 +0100
Message-Id: <20170723162627.22534-40-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalents are now assigned automatically in the relevant
registration calls and so are not needed in these operations
structures.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio.h     | 3 ---
 include/linux/iio/trigger.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 97a014300947..486ffbb1a926 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -369,8 +369,6 @@ struct iio_dev;
 
 /**
  * struct iio_info - constant information about device
- * @driver_module:	module structure used to ensure correct
- *			ownership of chrdevs etc
  * @event_attrs:	event control attributes
  * @attrs:		general purpose device attributes
  * @read_raw:		function to request a value from the device.
@@ -425,7 +423,6 @@ struct iio_dev;
  *			were flushed and there was an error.
  **/
 struct iio_info {
-	struct module			*driver_module;
 	const struct attribute_group	*event_attrs;
 	const struct attribute_group	*attrs;
 
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 999793212b40..1afe349af1fa 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -23,7 +23,6 @@ struct iio_trigger;
 
 /**
  * struct iio_trigger_ops - operations structure for an iio_trigger.
- * @owner:		used to monitor usage count of the trigger.
  * @set_trigger_state:	switch on/off the trigger on demand
  * @try_reenable:	function to reenable the trigger when the
  *			use count is zero (may be NULL)
@@ -34,7 +33,5 @@ struct iio_trigger;
  * instances of a given device.
  **/
\ struct iio_trigger_ops {
-	struct module *owner;
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
 	int (*validate_device)(struct iio_trigger *trig,
-- 
2.13.3
