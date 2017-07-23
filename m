Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/45] iio: Use macro magic to avoid manual assign of driver_module
Date: Sun, 23 Jul 2017 17:25:43 +0100
Message-Id: <20170723162627.22534-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

Starting point in boiler plate reduction similar to that done for
many similar cases elsewhere in the kernel.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c    | 35 +++++++++--------------------------
 drivers/iio/industrialio-trigger.c |  6 +++---
 include/linux/iio/iio.h            | 31 +++++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 17ec4cee51dc..7a5aa127c52e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1660,14 +1660,11 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
-/**
- * iio_device_register() - register a device with the IIO subsystem
- * @indio_dev:		Device structure filled by the device driver
- **/
-int iio_device_register(struct iio_dev *indio_dev)
+int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
 
+	indio_dev->driver_module = this_mod;
 	/* If the calling driver did not initialize of_node, do it here */
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
@@ -1713,7 +1710,8 @@ int iio_device_register(struct iio_dev *indio_dev)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
 	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
-	indio_dev->chrdev.owner = indio_dev->info->driver_module;
+
+	indio_dev->chrdev.owner = this_mod;
 
 	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
 	if (ret < 0)
@@ -1731,7 +1729,7 @@ int iio_device_register(struct iio_dev *indio_dev)
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
 }
-EXPORT_SYMBOL(iio_device_register);
+EXPORT_SYMBOL(__iio_device_register);
 
 /**
  * iio_device_unregister() - unregister a device from the IIO subsystem
@@ -1763,23 +1761,8 @@ static void devm_iio_device_unreg(struct device *dev, void *res)
 	iio_device_unregister(*(struct iio_dev **)res);
 }
 
-/**
- * devm_iio_device_register - Resource-managed iio_device_register()
- * @dev:	Device to allocate iio_dev for
- * @indio_dev:	Device structure filled by the device driver
- *
- * Managed iio_device_register.  The IIO device registered with this
- * function is automatically unregistered on driver detach. This function
- * calls iio_device_register() internally. Refer to that function for more
- * information.
- *
- * If an iio_dev registered with this function needs to be unregistered
- * separately, devm_iio_device_unregister() must be used.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
+int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
+			       struct module *this_mod)
 {
 	struct iio_dev **ptr;
 	int ret;
@@ -1789,7 +1772,7 @@ int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	*ptr = indio_dev;
-	ret = iio_device_register(indio_dev);
+	ret = __iio_device_register(indio_dev, this_mod);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
@@ -1797,7 +1780,7 @@ int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(devm_iio_device_register);
+EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
 /**
  * devm_iio_device_unregister - Resource-managed iio_device_unregister()
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 4061fed93f1f..9596fedacedb 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -250,7 +250,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 
 	/* Prevent the module from being removed whilst attached to a trigger */
-	__module_get(pf->indio_dev->info->driver_module);
+	__module_get(pf->indio_dev->driver_module);
 
 	/* Get irq number */
 	pf->irq = iio_trigger_get_irq(trig);
@@ -286,7 +286,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 out_put_irq:
 	iio_trigger_put_irq(trig, pf->irq);
 out_put_module:
-	module_put(pf->indio_dev->info->driver_module);
+	module_put(pf->indio_dev->driver_module);
 	return ret;
 }
 
@@ -307,7 +307,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 		trig->attached_own_device = false;
 	iio_trigger_put_irq(trig, pf->irq);
 	free_irq(pf->irq, pf);
-	module_put(pf->indio_dev->info->driver_module);
+	module_put(pf->indio_dev->driver_module);
 
 	return ret;
 }
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d68bec297a45..97a014300947 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -518,6 +518,7 @@ struct iio_buffer_setup_ops {
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
+ * @driver_module:	[INTERN] used to make it harder to undercut users
  * @modes:		[DRIVER] operating modes supported by device
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
@@ -558,6 +559,7 @@ struct iio_buffer_setup_ops {
  */
 struct iio_dev {
 	int				id;
+	struct module			*driver_module;
 
 	int				modes;
 	int				currentmode;
@@ -604,9 +606,34 @@ struct iio_dev {
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
-int iio_device_register(struct iio_dev *indio_dev);
+/**
+ * iio_device_register() - register a device with the IIO subsystem
+ * @indio_dev:		Device structure filled by the device driver
+ **/
+#define iio_device_register(iio_dev) \
+	__iio_device_register((iio_dev), THIS_MODULE)
+int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod);
 void iio_device_unregister(struct iio_dev *indio_dev);
-int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
+/**
+ * devm_iio_device_register - Resource-managed iio_device_register()
+ * @dev:	Device to allocate iio_dev for
+ * @indio_dev:	Device structure filled by the device driver
+ *
+ * Managed iio_device_register.  The IIO device registered with this
+ * function is automatically unregistered on driver detach. This function
+ * calls iio_device_register() internally. Refer to that function for more
+ * information.
+ *
+ * If an iio_dev registered with this function needs to be unregistered
+ * separately, devm_iio_device_unregister() must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+#define devm_iio_device_register(dev, indio_dev) \
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
+int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
+			       struct module *this_mod);
 void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
-- 
2.13.3
