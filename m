Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57261 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3J2LlU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:20 -0400
Received: by mail-pa0-f44.google.com with SMTP id fb1so8672443pad.17
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:20 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 02/33] iio: core: Move kernel doc to the right location
Date: Tue, 29 Oct 2013 17:09:25 +0530
Message-Id: <1383046796-329-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Documentation related to function should be placed above
its implementation. Move it accordingly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c    |   42 +++++++++++++++++++
 drivers/iio/industrialio-event.c   |    6 +++
 drivers/iio/industrialio-trigger.c |   24 +++++++++++
 include/linux/iio/iio.h            |   80 ------------------------------------
 4 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1c280b5..2fe88c1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -107,6 +107,11 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_INT_TIME] = "integration_time",
 };
 
+/**
+ * iio_find_channel_from_si() - get channel from its scan index
+ * @indio_dev:		device
+ * @si:			scan index to match
+ */
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
 {
@@ -922,6 +927,10 @@ struct device_type iio_device_type = {
 	.release = iio_dev_release,
 };
 
+/**
+ * iio_device_alloc() - allocate an iio_dev from a driver
+ * @sizeof_priv:	Space to allocate for private structure.
+ **/
 struct iio_dev *iio_device_alloc(int sizeof_priv)
 {
 	struct iio_dev *dev;
@@ -962,6 +971,10 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 }
 EXPORT_SYMBOL(iio_device_alloc);
 
+/**
+ * iio_device_free() - free an iio_dev from a driver
+ * @dev:		the iio_dev associated with the device
+ **/
 void iio_device_free(struct iio_dev *dev)
 {
 	if (dev)
@@ -984,6 +997,20 @@ static int devm_iio_device_match(struct device *dev, void *res, void *data)
 	return *r == data;
 }
 
+/**
+ * devm_iio_device_alloc - Resource-managed iio_device_alloc()
+ * @dev:		Device to allocate iio_dev for
+ * @sizeof_priv:	Space to allocate for private structure.
+ *
+ * Managed iio_device_alloc. iio_dev allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * If an iio_dev allocated with this function needs to be freed separately,
+ * devm_iio_device_free() must be used.
+ *
+ * RETURNS:
+ * Pointer to allocated iio_dev on success, NULL on failure.
+ */
 struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 {
 	struct iio_dev **ptr, *iio_dev;
@@ -1006,6 +1033,13 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
 
+/**
+ * devm_iio_device_free - Resource-managed iio_device_free()
+ * @dev:		Device this iio_dev belongs to
+ * @iio_dev:		the iio_dev associated with the device
+ *
+ * Free iio_dev allocated with devm_iio_device_alloc().
+ */
 void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)
 {
 	int rc;
@@ -1080,6 +1114,10 @@ static const struct file_operations iio_buffer_fileops = {
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
+/**
+ * iio_device_register() - register a device with the IIO subsystem
+ * @indio_dev:		Device structure filled by the device driver
+ **/
 int iio_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -1141,6 +1179,10 @@ error_ret:
 }
 EXPORT_SYMBOL(iio_device_register);
 
+/**
+ * iio_device_unregister() - unregister a device from the IIO subsystem
+ * @indio_dev:		Device structure representing the device.
+ **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	mutex_lock(&indio_dev->info_exist_lock);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index dac15b9..32b2c2d 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -42,6 +42,12 @@ struct iio_event_interface {
 	struct attribute_group	group;
 };
 
+/**
+ * iio_push_event() - try to add event to the list for userspace reading
+ * @indio_dev:		IIO device structure
+ * @ev_code:		What event
+ * @timestamp:		When the event occurred
+ **/
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index bf5e70a..8bd092b 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -506,6 +506,23 @@ static int devm_iio_trigger_match(struct device *dev, void *res, void *data)
 	return *r == data;
 }
 
+/**
+ * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
+ * @dev:		Device to allocate iio_trigger for
+ * @fmt:		trigger name format. If it includes format
+ *			specifiers, the additional arguments following
+ *			format are formatted and inserted in the resulting
+ *			string replacing their respective specifiers.
+ *
+ * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * If an iio_trigger allocated with this function needs to be freed separately,
+ * devm_iio_trigger_free() must be used.
+ *
+ * RETURNS:
+ * Pointer to allocated iio_trigger on success, NULL on failure.
+ */
 struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 						const char *fmt, ...)
 {
@@ -532,6 +549,13 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
 
+/**
+ * devm_iio_trigger_free - Resource-managed iio_trigger_free()
+ * @dev:		Device this iio_dev belongs to
+ * @iio_trig:		the iio_trigger associated with the device
+ *
+ * Free iio_trigger allocated with devm_iio_trigger_alloc().
+ */
 void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig)
 {
 	int rc;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a8cabda..5b125fd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -490,35 +490,12 @@ struct iio_dev {
 #endif
 };
 
-/**
- * iio_find_channel_from_si() - get channel from its scan index
- * @indio_dev:		device
- * @si:			scan index to match
- */
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
-
-/**
- * iio_device_register() - register a device with the IIO subsystem
- * @indio_dev:		Device structure filled by the device driver
- **/
 int iio_device_register(struct iio_dev *indio_dev);
-
-/**
- * iio_device_unregister() - unregister a device from the IIO subsystem
- * @indio_dev:		Device structure representing the device.
- **/
 void iio_device_unregister(struct iio_dev *indio_dev);
-
 int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
 void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
-
-/**
- * iio_push_event() - try to add event to the list for userspace reading
- * @indio_dev:		IIO device structure
- * @ev_code:		What event
- * @timestamp:		When the event occurred
- **/
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 
 extern struct bus_type iio_bus_type;
@@ -582,10 +559,6 @@ static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
 
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
-/**
- * iio_device_alloc() - allocate an iio_dev from a driver
- * @sizeof_priv: 	Space to allocate for private structure.
- **/
 struct iio_dev *iio_device_alloc(int sizeof_priv);
 
 static inline void *iio_priv(const struct iio_dev *indio_dev)
@@ -599,64 +572,11 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
 				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
 }
 
-/**
- * iio_device_free() - free an iio_dev from a driver
- * @indio_dev: 		the iio_dev associated with the device
- **/
 void iio_device_free(struct iio_dev *indio_dev);
-
-/**
- * devm_iio_device_alloc - Resource-managed iio_device_alloc()
- * @dev: 		Device to allocate iio_dev for
- * @sizeof_priv: 	Space to allocate for private structure.
- *
- * Managed iio_device_alloc.  iio_dev allocated with this function is
- * automatically freed on driver detach.
- *
- * If an iio_dev allocated with this function needs to be freed separately,
- * devm_iio_device_free() must be used.
- *
- * RETURNS:
- * Pointer to allocated iio_dev on success, NULL on failure.
- */
 struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
-
-/**
- * devm_iio_device_free - Resource-managed iio_device_free()
- * @dev:		Device this iio_dev belongs to
- * @indio_dev: 		the iio_dev associated with the device
- *
- * Free iio_dev allocated with devm_iio_device_alloc().
- */
 void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
-
-/**
- * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
- * @dev:		Device to allocate iio_trigger for
- * @fmt:		trigger name format. If it includes format
- *			specifiers, the additional arguments following
- *			format are formatted and inserted in the resulting
- *			string replacing their respective specifiers.
- *
- * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
- * automatically freed on driver detach.
- *
- * If an iio_trigger allocated with this function needs to be freed separately,
- * devm_iio_trigger_free() must be used.
- *
- * RETURNS:
- * Pointer to allocated iio_trigger on success, NULL on failure.
- */
 struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 						const char *fmt, ...);
-
-/**
- * devm_iio_trigger_free - Resource-managed iio_trigger_free()
- * @dev:		Device this iio_dev belongs to
- * @iio_trig:		the iio_trigger associated with the device
- *
- * Free iio_trigger allocated with devm_iio_trigger_alloc().
- */
 void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);
 
 /**
-- 
1.7.9.5

