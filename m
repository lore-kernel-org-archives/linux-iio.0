Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/45] iio: triggers: Use macros to avoid boilerplate assignment of owner.
Date: Sun, 23 Jul 2017 17:25:44 +0100
Message-Id: <20170723162627.22534-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

This trig_ops.owner assignment occurs in all trigger drivers and
can be simply automated using a macro as has been done in many
other places in the kernel.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-trigger.c | 18 ++++++++++++------
 include/linux/iio/trigger.h        | 19 +++++++++++++------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 9596fedacedb..faf00202915a 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -66,10 +66,13 @@ ATTRIBUTE_GROUPS(iio_trig_dev);
 
 static struct iio_trigger *__iio_trigger_find_by_name(const char *name);
 
-int iio_trigger_register(struct iio_trigger *trig_info)
+int __iio_trigger_register(struct iio_trigger *trig_info,
+			   struct module *this_mod)
 {
 	int ret;
 
+	trig_info->owner = this_mod;
+
 	/* trig_info->ops is required for the module member */
 	if (!trig_info->ops)
 		return -EINVAL;
@@ -105,7 +108,7 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 	return ret;
 }
-EXPORT_SYMBOL(iio_trigger_register);
+EXPORT_SYMBOL(__iio_trigger_register);
 
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
@@ -663,9 +666,10 @@ static void devm_iio_trigger_unreg(struct device *dev, void *res)
 }
 
 /**
- * devm_iio_trigger_register - Resource-managed iio_trigger_register()
+ * __devm_iio_trigger_register - Resource-managed iio_trigger_register()
  * @dev:	device this trigger was allocated for
  * @trig_info:	trigger to register
+ * @this_mod:   module registering the trigger
  *
  * Managed iio_trigger_register().  The IIO trigger registered with this
  * function is automatically unregistered on driver detach. This function
@@ -678,7 +682,9 @@ static void devm_iio_trigger_unreg(struct device *dev, void *res)
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
-int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
+int __devm_iio_trigger_register(struct device *dev,
+				struct iio_trigger *trig_info,
+				struct module *this_mod)
 {
 	struct iio_trigger **ptr;
 	int ret;
@@ -688,7 +694,7 @@ int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
 		return -ENOMEM;
 
 	*ptr = trig_info;
-	ret = iio_trigger_register(trig_info);
+	ret = __iio_trigger_register(trig_info, this_mod);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
@@ -696,7 +702,7 @@ int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(devm_iio_trigger_register);
+EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
 
 /**
  * devm_iio_trigger_unregister - Resource-managed iio_trigger_unregister()
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index ea08302f2d7b..999793212b40 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -62,6 +62,7 @@ struct iio_trigger_ops {
  **/
 struct iio_trigger {
 	const struct iio_trigger_ops	*ops;
+	struct module			*owner;
 	int				id;
 	const char			*name;
 	struct device			dev;
@@ -87,14 +88,14 @@ static inline struct iio_trigger *to_iio_trigger(struct device *d)
 
 static inline void iio_trigger_put(struct iio_trigger *trig)
 {
-	module_put(trig->ops->owner);
+	module_put(trig->owner);
 	put_device(&trig->dev);
 }
 
 static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig)
 {
 	get_device(&trig->dev);
-	__module_get(trig->ops->owner);
+	__module_get(trig->owner);
 
 	return trig;
 }
@@ -127,10 +128,16 @@ static inline void *iio_trigger_get_drvdata(struct iio_trigger *trig)
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
-int iio_trigger_register(struct iio_trigger *trig_info);
-
-int devm_iio_trigger_register(struct device *dev,
-			      struct iio_trigger *trig_info);
+#define iio_trigger_register(trig_info) \
+	__iio_trigger_register((trig_info), THIS_MODULE)
+int __iio_trigger_register(struct iio_trigger *trig_info,
+			   struct module *this_mod);
+
+#define devm_iio_trigger_register(dev, trig_info) \
+	__devm_iio_trigger_register((dev), (trig_info), THIS_MODULE)
+int __devm_iio_trigger_register(struct device *dev,
+				struct iio_trigger *trig_info,
+				struct module *this_mod);
 
 /**
  * iio_trigger_unregister() - unregister a trigger from the core
-- 
2.13.3
