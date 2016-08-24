Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:54550 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755714AbcHXOzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 10:55:55 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        "Ludovic Tancerel" <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Marek Vasut" <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 1/3] iio:trigger: add resource managed (un)register
Date: Wed, 24 Aug 2016 16:58:46 +0200
Message-ID: <92b4e01cb7e6f135cc179bfc34277c02bc11a059.1472050374.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1472050374.git.gregor.boirie@parrot.com>
References: <cover.1472050374.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add resource managed devm_iio_trigger_register() and
devm_iio_triger_unregister() to automatically clean up registered triggers
allocated by IIO drivers, thus leading to simplified IIO drivers code.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 Documentation/driver-model/devres.txt |  2 ++
 drivers/iio/industrialio-trigger.c    | 59 +++++++++++++++++++++++++++++++++++
 include/linux/iio/trigger.h           |  6 ++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index c63eea0..09e8649 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -268,6 +268,8 @@ IIO
   devm_iio_kfifo_free()
   devm_iio_trigger_alloc()
   devm_iio_trigger_free()
+  devm_iio_trigger_register()
+  devm_iio_trigger_unregister()
   devm_iio_channel_get()
   devm_iio_channel_release()
   devm_iio_channel_get_all()
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 7ad82fd..8ea2dc1 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -622,6 +622,65 @@ void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig)
 }
 EXPORT_SYMBOL_GPL(devm_iio_trigger_free);
 
+static void devm_iio_trigger_unreg(struct device *dev, void *res)
+{
+	iio_trigger_unregister(*(struct iio_trigger **)res);
+}
+
+/**
+ * devm_iio_trigger_register - Resource-managed iio_trigger_register()
+ * @dev:	device this trigger was allocated for
+ * @trig_info:	trigger to register
+ *
+ * Managed iio_trigger_register().  The IIO trigger registered with this
+ * function is automatically unregistered on driver detach. This function
+ * calls iio_trigger_register() internally. Refer to that function for more
+ * information.
+ *
+ * If an iio_trigger registered with this function needs to be unregistered
+ * separately, devm_iio_trigger_unregister() must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_trigger_register(struct device *dev, struct iio_trigger *trig_info)
+{
+	struct iio_trigger **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_iio_trigger_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	*ptr = trig_info;
+	ret = iio_trigger_register(trig_info);
+	if (!ret)
+		devres_add(dev, ptr);
+	else
+		devres_free(ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_iio_trigger_register);
+
+/**
+ * devm_iio_trigger_unregister - Resource-managed iio_trigger_unregister()
+ * @dev:	device this iio_trigger belongs to
+ * @trig_info:	the trigger associated with the device
+ *
+ * Unregister trigger registered with devm_iio_trigger_register().
+ */
+void devm_iio_trigger_unregister(struct device *dev,
+				 struct iio_trigger *trig_info)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_iio_trigger_unreg, devm_iio_trigger_match,
+			    trig_info);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_iio_trigger_unregister);
+
 void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	indio_dev->groups[indio_dev->groupcounter++] =
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 1c9e028..623d183 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -125,12 +125,18 @@ static inline void *iio_trigger_get_drvdata(struct iio_trigger *trig)
  **/
 int iio_trigger_register(struct iio_trigger *trig_info);
 
+int devm_iio_trigger_register(struct device *dev,
+			      struct iio_trigger *trig_info);
+
 /**
  * iio_trigger_unregister() - unregister a trigger from the core
  * @trig_info:	trigger to be unregistered
  **/
 void iio_trigger_unregister(struct iio_trigger *trig_info);
 
+void devm_iio_trigger_unregister(struct device *dev,
+				 struct iio_trigger *trig_info);
+
 /**
  * iio_trigger_poll() - called on a trigger occurring
  * @trig:	trigger which occurred
-- 
2.1.4

