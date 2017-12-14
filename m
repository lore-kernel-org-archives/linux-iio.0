Return-Path: <SRS0=13zJ=DK=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH v9 03/13] IIO: hw_consumer: add devm_iio_hw_consumer_alloc
Date: Thu, 14 Dec 2017 09:57:55 +0100
Message-ID: <1513241885-32079-4-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1513241885-32079-1-git-send-email-arnaud.pouliquen@st.com>
References: <1513241885-32079-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add devm_iio_hw_consumer_alloc function that calls iio_hw_consumer_free
when the device is unbound from the bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 66 +++++++++++++++++++++++++++
 include/linux/iio/hw-consumer.h               |  2 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 993ecdc..9516569 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -137,6 +137,72 @@ void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
 }
 EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
 
+static void devm_iio_hw_consumer_release(struct device *dev, void *res)
+{
+	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
+}
+
+static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
+{
+	struct iio_hw_consumer **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+	return *r == data;
+}
+
+/**
+ * devm_iio_hw_consumer_alloc - Resource-managed iio_hw_consumer_alloc()
+ * @dev: Pointer to consumer device.
+ *
+ * Managed iio_hw_consumer_alloc. iio_hw_consumer allocated with this function
+ * is automatically freed on driver detach.
+ *
+ * If an iio_hw_consumer allocated with this function needs to be freed
+ * separately, devm_iio_hw_consumer_free() must be used.
+ *
+ * returns pointer to allocated iio_hw_consumer on success, NULL on failure.
+ */
+struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
+{
+	struct iio_hw_consumer **ptr, *iio_hwc;
+
+	ptr = devres_alloc(devm_iio_hw_consumer_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	iio_hwc = iio_hw_consumer_alloc(dev);
+	if (IS_ERR(iio_hwc)) {
+		devres_free(ptr);
+	} else {
+		*ptr = iio_hwc;
+		devres_add(dev, ptr);
+	}
+
+	return iio_hwc;
+}
+EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_alloc);
+
+/**
+ * devm_iio_hw_consumer_free - Resource-managed iio_hw_consumer_free()
+ * @dev: Pointer to consumer device.
+ * @hwc: iio_hw_consumer to free.
+ *
+ * Free iio_hw_consumer allocated with devm_iio_hw_consumer_alloc().
+ */
+void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_iio_hw_consumer_release,
+			    devm_iio_hw_consumer_match, hwc);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_free);
+
 /**
  * iio_hw_consumer_enable() - Enable IIO hardware consumer
  * @hwc: iio_hw_consumer to enable.
diff --git a/include/linux/iio/hw-consumer.h b/include/linux/iio/hw-consumer.h
index db8c00b..44d48bb 100644
--- a/include/linux/iio/hw-consumer.h
+++ b/include/linux/iio/hw-consumer.h
@@ -13,6 +13,8 @@ struct iio_hw_consumer;
 
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
 void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
+struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev);
+void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc);
 int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
 void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
 
-- 
2.7.4
