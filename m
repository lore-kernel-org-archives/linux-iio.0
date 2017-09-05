Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:52544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751386AbdIEMO7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:59 -0400
From: Dragos Bogdan <dragos.bogdan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 1/2] iio: ad_sigma_delta: Implement a dedicated reset function
Date: Tue, 5 Sep 2017 15:14:45 +0300
Message-ID: <20170905121445.26913-1-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since most of the SD ADCs have the option of reseting the serial
interface by sending a number of SCLKs with CS = 0 and DIN = 1,
a dedicated function that can do this is usefull.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 28 ++++++++++++++++++++++++++++
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c97233..22c4c17cd996 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -177,6 +177,34 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_GPL(ad_sd_read_reg);
 
+/**
+ * ad_sd_reset() - Reset the serial interface
+ *
+ * @sigma_delta: The sigma delta device
+ * @reset_length: Number of SCLKs with DIN = 1
+ *
+ * Returns 0 on success, an error code otherwise.
+ **/
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
+	unsigned int reset_length)
+{
+	uint8_t *buf;
+	unsigned int size;
+	int ret;
+
+	size = DIV_ROUND_UP(reset_length, 8);
+	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0xff, size);
+	ret = spi_write(sigma_delta->spi, buf, size);
+	kfree(buf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ad_sd_reset);
+
 static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5ba430cc9a87..1fc7abd28b0b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -111,6 +111,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int *val);
 
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
+	unsigned int reset_length);
+
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
 int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
-- 
2.11.0

