Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 38/38] iio: drop iio_info.driver_module and iio_trigger_ops.owner.
Date: Mon, 29 May 2017 16:51:54 +0100
Message-Id: <20170529155154.22580-39-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalents are now assigned automatically in the relevant
registration calls and so are not needed in these operations
structures.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/iio.h     | 3 ---
 include/linux/iio/trigger.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f65391067089..02c2a78ada5a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -363,8 +363,6 @@ struct iio_dev;
 
 /**
  * struct iio_info - constant information about device
- * @driver_module:	module structure used to ensure correct
- *			ownership of chrdevs etc
  * @event_attrs:	event control attributes
  * @attrs:		general purpose device attributes
  * @read_raw:		function to request a value from the device.
@@ -419,7 +417,6 @@ struct iio_dev;
  *			were flushed and there was an error.
  **/
 struct iio_info {
-	struct module			*driver_module;
 	const struct attribute_group	*event_attrs;
 	const struct attribute_group	*attrs;
 
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 2e1800ad265b..ff2b7c7a9652 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -34,7 +34,6 @@ struct iio_trigger;
  * instances of a given device.
  **/
 struct iio_trigger_ops {
-	struct module *owner;
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
 	int (*validate_device)(struct iio_trigger *trig,
-- 
2.13.0
