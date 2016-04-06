Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <jic23@kernel.org>, <corbet@lwn.net>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 1/3] iio: core: Add devm_ APIs for iio_channel_{get,release}
Date: Wed, 6 Apr 2016 16:01:06 +0530
Message-ID: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Some of kernel driver uses the IIO framework to get the sensor
value via ADC or IIO HW driver. The client driver get iio channel
by iio_channel_get() and release it by calling iio_channel_release().

Add resource managed version (devm_*) of these APIs so that if client
calls the devm_iio_channel_get() then it need not to release it explicitly,
it can be done by managed device framework when driver get un-binded.

This reduces the code in error path and also need of .remove callback in
some cases.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/iio/inkern.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 27 +++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 734a004..18e623f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -356,6 +356,54 @@ void iio_channel_release(struct iio_channel *channel)
 }
 EXPORT_SYMBOL_GPL(iio_channel_release);
 
+static void devm_iio_channel_free(struct device *dev, void *res)
+{
+	struct iio_channel *channel = *(struct iio_channel **)res;
+
+	iio_channel_release(channel);
+}
+
+static int devm_iio_channel_match(struct device *dev, void *res, void *data)
+{
+	struct iio_channel **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+
+	return *r == data;
+}
+
+struct iio_channel *devm_iio_channel_get(struct device *dev,
+					 const char *channel_name)
+{
+	struct iio_channel **ptr, *channel;
+
+	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	channel = iio_channel_get(dev, channel_name);
+	if (IS_ERR(channel)) {
+		devres_free(ptr);
+		return channel;
+	}
+
+	*ptr = channel;
+	devres_add(dev, ptr);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_get);
+
+void devm_iio_channel_release(struct device *dev, struct iio_channel *channel)
+{
+	WARN_ON(devres_release(dev, devm_iio_channel_free,
+			       devm_iio_channel_match, channel));
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_release);
+
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
 	const char *name;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index fad5867..e1e033d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -49,6 +49,33 @@ struct iio_channel *iio_channel_get(struct device *dev,
 void iio_channel_release(struct iio_channel *chan);
 
 /**
+ * devm_iio_channel_get() - Resource managed version of iio_channel_get().
+ * @dev:		Pointer to consumer device. Device name must match
+ *			the name of the device as provided in the iio_map
+ *			with which the desired provider to consumer mapping
+ *			was registered.
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ *
+ * Returns a pointer to negative errno if it is not able to get the iio channel
+ * otherwise returns valid pointer for iio channel.
+ *
+ * The allocated iio channel is automatically released when the device is
+ * unbound.
+ */
+struct iio_channel *devm_iio_channel_get(struct device *dev,
+					 const char *consumer_channel);
+/**
+ * devm_iio_channel_release() - Resource managed version of
+ *				iio_channel_release().
+ * @dev:		Pointer to consumer device for which resource
+ *			is allocared.
+ * @chan:		The channel to be released.
+ */
+void devm_iio_channel_release(struct device *dev, struct iio_channel *chan);
+
+/**
  * iio_channel_get_all() - get all channels associated with a client
  * @dev:		Pointer to consumer device.
  *
-- 
2.1.4
