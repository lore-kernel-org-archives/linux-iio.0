Return-Path: <SRS0=QH+w=EF=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "IIO: hw_consumer: add devm_iio_hw_consumer_alloc" to the asoc tree
In-Reply-To: <1511881557-28596-4-git-send-email-arnaud.pouliquen@st.com>
Message-Id: <E1eZEK1-00052Q-HS@debutante>
Date: Wed, 10 Jan 2018 11:13:29 +0000
List-ID: <linux-iio@vger.kernel.org>

The patch

   IIO: hw_consumer: add devm_iio_hw_consumer_alloc

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b688c18d30060e8a840d8af72790339c72acdac4 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Wed, 10 Jan 2018 11:13:05 +0100
Subject: [PATCH] IIO: hw_consumer: add devm_iio_hw_consumer_alloc

Add devm_iio_hw_consumer_alloc function that calls iio_hw_consumer_free
when the device is unbound from the bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 66 +++++++++++++++++++++++++++
 include/linux/iio/hw-consumer.h               |  2 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 993ecdcdab64..95165697d8ae 100644
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
index db8c00b9c7a5..44d48bb1d39f 100644
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
2.15.1
