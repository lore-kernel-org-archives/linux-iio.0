Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <jic23@kernel.org>, <corbet@lwn.net>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/3] iio: core: Add devm_ APIs for iio_channel_{get,release}_all
Date: Wed, 6 Apr 2016 16:01:07 +0530
Message-ID: <1459938668-9180-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Some of kernel driver uses the IIO framework to get the sensor
value via ADC or IIO HW driver. The client driver get iio channel
by iio_channel_get_all() and release it by calling
iio_channel_release_all().

Add resource managed version (devm_*) of these APIs so that if client
calls the devm_iio_channel_get_all() then it need not to release it
explicitly, it can be done by managed device framework when driver
get un-binded.

This reduces the code in error path and also need of .remove callback in
some cases.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/iio/inkern.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 18e623f..8c1abfe 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -489,6 +489,42 @@ void iio_channel_release_all(struct iio_channel *channels)
 }
 EXPORT_SYMBOL_GPL(iio_channel_release_all);
 
+static void devm_iio_channel_free_all(struct device *dev, void *res)
+{
+	struct iio_channel *channels = *(struct iio_channel **)res;
+
+	iio_channel_release_all(channels);
+}
+
+struct iio_channel *devm_iio_channel_get_all(struct device *dev)
+{
+	struct iio_channel **ptr, *channels;
+
+	ptr = devres_alloc(devm_iio_channel_free_all, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	channels = iio_channel_get_all(dev);
+	if (IS_ERR(channels)) {
+		devres_free(ptr);
+		return channels;
+	}
+
+	*ptr = channels;
+	devres_add(dev, ptr);
+
+	return channels;
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
+
+void devm_iio_channel_release_all(struct device *dev,
+				  struct iio_channel *channels)
+{
+	WARN_ON(devres_release(dev, devm_iio_channel_free_all,
+			       devm_iio_channel_match, channels));
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_release_all);
+
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	enum iio_chan_info_enum info)
 {
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e1e033d..3d672f7 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -92,6 +92,32 @@ struct iio_channel *iio_channel_get_all(struct device *dev);
  */
 void iio_channel_release_all(struct iio_channel *chan);
 
+/**
+ * devm_iio_channel_get_all() - Resource managed version of
+ *				iio_channel_get_all().
+ * @dev: Pointer to consumer device.
+ *
+ * Returns a pointer to negative errno if it is not able to get the iio channel
+ * otherwise returns an array of iio_channel structures terminated with one with
+ * null iio_dev pointer.
+ *
+ * This function is used by fairly generic consumers to get all the
+ * channels registered as having this consumer.
+ *
+ * The allocated iio channels are automatically released when the device is
+ * unbounded.
+ */
+struct iio_channel *devm_iio_channel_get_all(struct device *dev);
+
+/**
+ * devm_iio_channel_release_all() - Resource managed version of
+ *				    iio_channel_release_all().
+ * @dev:		Pointer to consumer device for which resource
+ *			is allocared.
+ * @chan:		Array channel to be released.
+ */
+void devm_iio_channel_release_all(struct device *dev, struct iio_channel *chan);
+
 struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
-- 
2.1.4
