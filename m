Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/22] iio: Introduce iio_device_{set,get}_drvdata()
Date: Fri, 10 Aug 2012 18:36:29 +0200
Message-Id: <1344616596-8026-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Introduce two new helper functions to attach a arbitrary pointer to a IIO
device. This is useful to get access to external non-global data from within a
IIO device callbacks where only the IIO device is available.

Internally these functions use dev_{set,get}_drvdata() on the struct device
embedded in the IIO device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/iio.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index be82936..b18e74e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -516,6 +516,31 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
 	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
 }
 
+
+/**
+ * iio_device_set_drvdata() - Set device driver data
+ * @indio_dev: IIO device structure
+ * @data: Driver specific data
+ *
+ * Allows to attach an arbitrary pointer to an IIO device, which can later be
+ * retrieved by iio_device_get_drvdata().
+ */
+static inline void iio_device_set_drvdata(struct iio_dev *indio_dev, void *data)
+{
+	dev_set_drvdata(&indio_dev->dev, data);
+}
+
+/**
+ * iio_device_get_drvdata() - Get device driver data
+ * @indio_dev: IIO device structure
+ *
+ * Returns the data previously set with iio_device_set_drvdata()
+ */
+static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
+{
+	return dev_get_drvdata(&indio_dev->dev);
+}
+
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
-- 
1.7.10.4
