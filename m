Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36879 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdE2PwL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/38] iio: triggers: Use macros to avoid boilerplate assignment of owner.
Date: Mon, 29 May 2017 16:51:18 +0100
Message-Id: <20170529155154.22580-3-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This trig_ops.owner assignment occurs in all trigger drivers and
can be simply automated using a macro as has been done in many
other places in the kernel.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-trigger.c | 18 ++++++++++++------
 include/linux/iio/trigger.h        | 19 +++++++++++++------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 067e58863592..6863ed5a61da 100644
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
@@ -662,9 +665,10 @@ static void devm_iio_trigger_unreg(struct device *dev, void *res)
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
@@ -677,7 +681,9 @@ static void devm_iio_trigger_unreg(struct device *dev, void *res)
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
@@ -687,7 +693,7 @@ int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
 		return -ENOMEM;
 
 	*ptr = trig_info;
-	ret = iio_trigger_register(trig_info);
+	ret = __iio_trigger_register(trig_info, this_mod);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
@@ -695,7 +701,7 @@ int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(devm_iio_trigger_register);
+EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
 
 /**
  * devm_iio_trigger_unregister - Resource-managed iio_trigger_unregister()
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index ea08302f2d7b..2e1800ad265b 100644
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
+	__iio_trigger_register(trig_info, THIS_MODULE)
+int __iio_trigger_register(struct iio_trigger *trig_info,
+			   struct module *this_mod);
+
+#define devm_iio_trigger_register(dev, trig_info) \
+	__devm_iio_trigger_register(dev, trig_info, THIS_MODULE)
+int __devm_iio_trigger_register(struct device *dev,
+				struct iio_trigger *trig_info,
+				struct module *this_mod);
 
 /**
  * iio_trigger_unregister() - unregister a trigger from the core
-- 
2.13.0

