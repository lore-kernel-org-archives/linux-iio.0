Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-219.synserver.de ([212.40.185.219]:1173 "EHLO
	smtp-out-217.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752438Ab2KTNhA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2012 08:37:00 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] iio:imu:adis: Add debugfs register access support
Date: Tue, 20 Nov 2012 14:36:45 +0100
Message-Id: <1353418611-17614-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Provide a IIO debugfs register access function for the ADIS library. This
function can be used by induvidual drivers to allow raw register access via
debugfs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis.c       | 23 +++++++++++++++++++++++
 include/linux/iio/imu/adis.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 8259b77..28d4df2 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -135,6 +135,29 @@ error_ret:
 }
 EXPORT_SYMBOL_GPL(adis_read_reg_16);
 
+#ifdef CONFIG_DEBUG_FS
+
+int adis_debugfs_reg_access(struct iio_dev *indio_dev,
+	unsigned int reg, unsigned int writeval, unsigned int *readval)
+{
+	struct adis *adis = iio_device_get_drvdata(indio_dev);
+
+	if (readval) {
+		uint16_t val16;
+		int ret;
+
+		ret = adis_read_reg_16(adis, reg, &val16);
+		*readval = val16;
+
+		return ret;
+	} else {
+		return adis_write_reg_16(adis, reg, writeval);
+	}
+}
+EXPORT_SYMBOL(adis_debugfs_reg_access);
+
+#endif
+
 /**
  * adis_enable_irq() - Enable or disable data ready IRQ
  * @adis: The adis device
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 8c3304d..fce7bc3 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -183,4 +183,15 @@ static inline void adis_remove_trigger(struct adis *adis)
 
 #endif /* CONFIG_IIO_BUFFER */
 
+#ifdef CONFIG_DEBUG_FS
+
+int adis_debugfs_reg_access(struct iio_dev *indio_dev,
+	unsigned int reg, unsigned int writeval, unsigned int *readval);
+
+#else
+
+#define adis_debugfs_reg_access NULL
+
+#endif
+
 #endif
-- 
1.8.0

