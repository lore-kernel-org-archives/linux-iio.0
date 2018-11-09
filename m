Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:9728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeKJBWO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Nov 2018 20:22:14 -0500
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>
CC: <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v4 1/4] iio: ad_sigma_delta: Allow to provide custom data register address
Date: Fri, 9 Nov 2018 17:39:58 +0200
Message-ID: <1541777998-7518-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some newer devices from the Sigma-Delta ADC family do have their data
register at a different address than the current default address. Add a
parameter to the ad_sigma_delta_info struct which allows to override the
default address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added this commit.
Changes in v3:
	- Nothing changed.
Changes in v4:
	- Nothing changed.

 drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fc95107..ff5f2da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -278,6 +278,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int sample, raw_sample;
+	unsigned int data_reg;
 	int ret = 0;
 
 	if (iio_buffer_enabled(indio_dev))
@@ -305,7 +306,12 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto out;
 
-	ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_DATA,
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
+	ret = ad_sd_read_reg(sigma_delta, data_reg,
 		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
 		&raw_sample);
 
@@ -392,6 +398,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int reg_size;
+	unsigned int data_reg;
 	uint8_t data[16];
 	int ret;
 
@@ -401,18 +408,23 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 			indio_dev->channels[0].scan_type.shift;
 	reg_size = DIV_ROUND_UP(reg_size, 8);
 
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[0]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[1]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[1]);
 		break;
 	}
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1..7e84351 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -39,6 +39,8 @@ struct iio_dev;
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @data_reg: Address of the data register, if 0 the default address of 0x3 will
+ *   be used.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -47,6 +49,7 @@ struct ad_sigma_delta_info {
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int data_reg;
 };
 
 /**
-- 
2.7.4
