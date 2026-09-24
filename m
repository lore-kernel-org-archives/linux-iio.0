Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D22484253
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255670; cv=none; b=NAt7bASowKRZ8Z54mxBifuoUOJja7atrMEmgaukPZpTJu4xc4Yk35lMirj7zXSE/lG+kA/fF6cDvE+ubd1GaRRXNp+d8JHKJ/Vp5pbiD6LCVMpB3S5Ug8uboZrUfb43LLgPEViE5VfItfchI+pHO0/k3tHErLQqhrGVYOWOjnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255670; c=relaxed/simple;
	bh=izwMR3ZSSoN4ZSQVTggab57AsxrWfcldyy7oNu6CnOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rs6/zDpuQVx5a1wod4kHl47mQrKx1I3Sw9pthEVVyUPMsQjgoC/wfV+28MPh/CuoySz5+NZAa8qgyHdxrmcXxr6PTw5rhYNc5graFBY6SlLZgoQPtLR/uKUY87NvWzh/WfCfQ4kS0wP8xpxKxJzBaVmuV9gu0iLUpsJTOUE2F8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8Voef6L; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8Voef6L"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so23315275e9.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790255666; x=1790860466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvQi8AKRdnj33GdUwLVwweM1MXYYXw+zpxk0xs1IUYw=;
        b=f8Voef6L57JX2P0uU3zlZN7pzji1nZ1ql1b0OBf+zNQQ+A5t7J0mvkukWZiJ84ITOT
         0aUYSKmRovlXP6C1LRcSjbfkfk39wJyQSailksyv+ifZKz0tJin10G5y9QV95krj7gTI
         9zEAwjQrV850Cv45M5dJlN2xVHdKkmfb5Ax8k8749oyphIcgqzYtSNEjMzLlvfwU9ngN
         59EVzawtmaMOcUN45AwQLSeFwZPpTMd0MN4PdyUoyMSvpe0S3R6yvomNjNzsDMbQ9eCW
         kjn+IgXd3j8Ln5RBe0X2/OYdUtTQ2kVj1DK+mfguXskATrTsOtQpPLVv9rvOo7XtNtLD
         0HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255666; x=1790860466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvQi8AKRdnj33GdUwLVwweM1MXYYXw+zpxk0xs1IUYw=;
        b=JHZujdJ0TVjvnJNajQGJ4TJ38sTzWUBgbO0mhV4QD9CjuesI0JyUdPLxkc+ImJo3Z1
         BRJZpwnQx8+rNq7FVlrTvlDp8yLHmyw8hCR0zUiogFxpDtmLStpAnabK98iC/Ms/vg5+
         wdXv0rjKyuKPrLL19UM7eZ6PxjDR7f5DPhvnxIQSTnNCjZfVN0ESqTjiDQyzlPFfDEew
         XKs7uOhnwhsBOEWbZl0PqvbnCd0L/DxRnlJMjdhSAITrqYz/i0bMj5aCxk6AiGTtFQLz
         SauzfvW/PaUonZvsI4mTrKEWOcmn8z9E+5e2xJFGqppD9RyFKNzcbGjShfOzPimUIACP
         Y/nA==
X-Gm-Message-State: AFuF++mu36LfqWUMAnPruQJsbAv9LLPpYAbzNjn7e7XGF0v6HYqvB+zD
	u2ncJTtHKxNORXh4elcx5TU89CeUBBlpvbaEOSjC91uUmWBXCrm8A/RlYjJsqBeN2Tg=
X-Gm-Gg: AYBFou1FCn/QBtHqnVTUq2Ickbva/nnXWYzRjFU/s4IHTRHRdb7DdP+8M85NliVYQbt
	4FTvzH6e7sJXGQYnHlqUS168VdLmCzIwEdLA/zcol361rZOsuqCxerVHpvEuzUtUNTcMCTXXdix
	n2R4uyUftuFmUgmAdd4ac5+GvwEn5CyxbgAgSO5Z/mce5KhoAnnRnc+wXWi5nTUhj4kT+E6Bz6R
	YxzHeojKonCYEDajk/v0NgS/44dj+D5Z7A2WGUsNwaeG8AGPCijft6Y8zyrjJl3PvBSgsRAxK5c
	6s/fVfx2ciOidOLJHQjEe2rArt82QHFZJK9PIG69ZWaoMQiNcmz/RHk8De3KmbB5kq1IrNp8mQw
	BTCOdDbjMigQea6bYh8p/oD+ShDfPTw+gsvdxDy3kq5l249YuK5nyF6Cl/PvQYs0U7L0Tq08Cas
	JYqT0CBlRZcFDjHB07cDooZVyay5iSLIR8tVDVBsiFi+5fBIBIArHXffnjLHyMua7cdhPHKHdK5
	8O68c21GeNdqZyjer8=
X-Received: by 2002:a05:600c:34c6:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49fe66f4dc9mr48828895e9.29.1790255665467;
        Thu, 24 Sep 2026 06:14:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm111837945e9.3.2026.09.24.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:14:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 24 Sep 2026 15:14:16 +0200
Subject: [PATCH v2 2/2] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12797;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=izwMR3ZSSoN4ZSQVTggab57AsxrWfcldyy7oNu6CnOs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqtSIsCKJsS57Q3LShhsThW3oQi6eMwEPkQalcVb9I
 3appLR+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarUiLAAKCRB33NvayMhJ0YZWD/
 9YyXHD8P9EfyQ72sJNhQm+lFNBUnpR4lLKLoCiQlutqdzVrMfki6DDRAnBFEEw9n7O9ynMujrXIhF7
 4IS50YCecGAIC/EDDKVp9JGMmST+0ihyLR+QyA7v8muHa+m8Z/XEF3nFjKrnEqhg/1bGyJjrTtSzSS
 KcNK032Tnd8a+Ws5JPXPniCtiO2dQMB9giZfpp6eKug/bblfMkfDFE3tNHj2b29LcM05UTFZVYzapS
 fG+HPIfQ70HbOHbkrFnSUB+KXU73Lq6WjClf1fuzNZx1J0O/0jZXMI3Jhkrg3z6VVz6kTMJ3y5jgdu
 1vmiA3IMfOBhONlZjxq4ThDgNINqXTVQWWscVlI5i2f/vHT5H013S91WucU38SLK+fAUvl6EtN604Q
 ej8iffGeltnkVZfoofAULSPT1eOHujYbczdGPQxg15Cey7+JCbXUE3RXvSdVYX2HSGoYWA79P8KfLT
 X7L1QGhEV3aiRgZyUGC6L42h5cEVcB6Dd1F+jPcHE8ZX0vhuQR21RlL8wEldMBbe3YlBcChtaln/Eh
 nORUdJMnsPqKl6IW3/7tThMd6RyKvVNyOUHC+JGWGhO8sl7ciwcc5HKJ3yjDPQS4ugCydIwaPF5T0p
 OLduQHvETavHX2I+iNozpJQPI2ERmG/GvBiHniIq0ulf+YtOBWwSGxC5EQIA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to
determine power consumption of portable systems. The driver support
getting the channels voltage and accumulated average power over an
I2C/SMBUS serial interface.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/iio/adc/Kconfig    |  11 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max34417.c | 374 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 386 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..15360c78d3e5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1116,6 +1116,17 @@ config MAX34408
 	  To compile this driver as a module, choose M here: the module will be
 	  called max34408.
 
+config MAX34417
+	tristate "Maxim MAX34417 ADC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build ADC support for Maxim MAX34417 Four-Channel High
+	  Dynamic Range Power Accumulator.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max34417.
+
 config MAX77541_ADC
 	tristate "Analog Devices MAX77541 ADC driver"
 	depends on MFD_MAX77541
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..c667e7ecbc53 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
+obj-$(CONFIG_MAX34417) += max34417.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
new file mode 100644
index 000000000000..98d961c5ecee
--- /dev/null
+++ b/drivers/iio/adc/max34417.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Maxim MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
+ *
+ * Datasheet: https://www.analog.com/en/products/max34417.html
+ *
+ * TODO: Slow Mode, Continuous Accumulate Mode, Park Feature, Bulk Update, Perr_Verr Correction
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#define MAX34417_UPDATE_REG		0x0
+#define MAX34417_CONTROL_REG		0x1
+#define MAX34417_ACC_COUNT_REG		0x2
+
+#define MAX34417_PWR_ACC_1_REG		0x3
+#define MAX34417_PWR_ACC_2_REG		0x4
+#define MAX34417_PWR_ACC_3_REG		0x5
+#define MAX34417_PWR_ACC_4_REG		0x6
+
+#define MAX34417_V_CH1_REG		0x7
+#define MAX34417_V_CH2_REG		0x8
+#define MAX34417_V_CH3_REG		0x9
+#define MAX34417_V_CH4_REG		0xa
+
+#define MAX34417_DID_REG		0xf
+
+#define MAX34417_BULK_POWER_READOUT_REG		0x10
+#define MAX34417_BULK_VOLTAGE_READOUT_REG	0x11
+
+#define MAX34417_BULK_UPDATE_ADDRESS	0x2c
+#define MAX34417_BULK_UPDATE_REG	0x0
+
+/* Bit masks for control register */
+#define MAX34417_CONTROL_OVF		BIT(0)
+#define MAX34417_CONTROL_SLOW		BIT(1)
+#define MAX34417_CONTROL_PARK0		BIT(2)
+#define MAX34417_CONTROL_PARK1		BIT(3)
+#define MAX34417_CONTROL_PARK_EN	BIT(4)
+#define MAX34417_CONTROL_SMM		BIT(5)
+#define MAX34417_CONTROL_CAM		BIT(6)
+#define MAX34417_CONTROL_MODE		BIT(7)
+
+#define MAX34417_DEFAULT_CMM_WIDE	(MAX34417_CONTROL_MODE | MAX34417_CONTROL_SMM)
+
+#define MAX34417_DEFAULT_RSENSE		1000
+
+#define MAX34417_PWR_CORRECTION_SCALE		24
+#define MAX34417_PWR_AVG_FULL_SCALE_BITS	30
+
+#define MAX34417_VOLTAGE_CORRECTION_SCALE	24
+#define MAX34417_VOLTAGE_FULL_SCALE_BITS	14
+
+#define MAX34417_CHANNEL_COUNT			4
+
+/**
+ * struct max34417_data - MAX34417 specific data.
+ * @regmap:	Device register map.
+ * @dev:	MAX34417 device.
+ * @lock:	Lock for protecting access to device hardware registers, mostly
+ *		for reading common accumulator count and control register.
+ * @input_correction:	Correction based on the Rsense value from channel nodes.
+ * @input_label:	Channel label from channel nodes.
+ */
+struct max34417_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	u32 input_correction[MAX34417_CHANNEL_COUNT];
+	const char *input_label[MAX34417_CHANNEL_COUNT];
+};
+
+static const struct regmap_config max34417_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34417_DID_REG,
+};
+
+#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
+	{							\
+		.type = IIO_VOLTAGE,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE), \
+		.channel = (_index),				\
+		.address = (_v_address),			\
+		.indexed = 1,					\
+	},							\
+	{							\
+		.type = IIO_POWER,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE), \
+		.channel = (_index),				\
+		.address = (_power_address),			\
+		.indexed = 1,					\
+	}
+
+static const struct iio_chan_spec max34417_channels[] = {
+	MAX34417_CHANNEL(0, MAX34417_V_CH1_REG, MAX34417_PWR_ACC_1_REG),
+	MAX34417_CHANNEL(1, MAX34417_V_CH2_REG, MAX34417_PWR_ACC_2_REG),
+	MAX34417_CHANNEL(2, MAX34417_V_CH3_REG, MAX34417_PWR_ACC_3_REG),
+	MAX34417_CHANNEL(3, MAX34417_V_CH4_REG, MAX34417_PWR_ACC_4_REG),
+};
+
+/* TODO Implement trigger to update accumulator once and get all channels at once */
+
+static int max34417_accumulator_update(struct max34417_data *max34417)
+{
+	int rc;
+
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+	if (rc) {
+		dev_err(max34417->dev, "Error (%d) writing update register\n", rc);
+		return rc;
+	}
+
+	/* Wait for accumulator update */
+	fsleep(1000);
+
+	return 0;
+}
+
+static int max34417_read_voltage(struct max34417_data *max34417,
+				 const struct iio_chan_spec *chan, int *val)
+{
+	uint16_t voltage;
+	uint8_t buf[3];
+	int rc;
+
+	guard(mutex)(&max34417->lock);
+
+	rc = max34417_accumulator_update(max34417);
+	if (rc)
+		return rc;
+
+	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 3);
+	if (rc)
+		return rc;
+
+	voltage = buf[2] | ((uint64_t)buf[1] << 8);
+	voltage >>= 2;
+
+	*val = voltage;
+
+	return IIO_VAL_INT;
+}
+
+static int max34417_read_power(struct max34417_data *max34417,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2)
+{
+	uint32_t acc_count;
+	uint64_t power;
+	uint8_t buf[8];
+	int rc;
+
+	guard(mutex)(&max34417->lock);
+
+	rc = max34417_accumulator_update(max34417);
+	if (rc)
+		return rc;
+
+	rc = regmap_noinc_read(max34417->regmap, MAX34417_ACC_COUNT_REG,
+			       &buf, 4);
+	if (rc)
+		return rc;
+
+	acc_count = buf[3] | ((uint64_t)buf[2] << 8) | ((uint64_t)buf[1] << 16);
+	if (!acc_count)
+		return -EIO;
+
+	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 8);
+	if (rc)
+		return rc;
+
+	power = buf[7];
+	power |= ((uint64_t)buf[6] << 8UL);
+	power |= ((uint64_t)buf[5] << 16UL);
+	power |= ((uint64_t)buf[4] << 24UL);
+	power |= ((uint64_t)buf[3] << 32UL);
+	power |= ((uint64_t)buf[2] << 40UL);
+	power |= ((uint64_t)buf[1] << 48UL);
+
+	power = div_u64(power, acc_count);
+
+	*val = FIELD_GET(GENMASK_ULL(31, 0), power);
+	*val2 = FIELD_GET(GENMASK_ULL(55, 32), power);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max34417_data *max34417 = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_VOLTAGE)
+			return max34417_read_voltage(max34417, chan, val);
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		if (chan->type == IIO_POWER)
+			return max34417_read_power(max34417, chan, val, val2);
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLTAGE) {
+			/* Scale to mA */
+			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
+			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		} else if (chan->type == IIO_POWER) {
+			/* Scale to mW */
+			*val = max34417->input_correction[chan->channel] * MILLI;
+			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		}
+
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max34417_read_label(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       char *label)
+{
+	struct max34417_data *max34417 = iio_priv(indio_dev);
+	const char *input_label = max34417->input_label[chan->channel];
+
+	if (chan->type == IIO_VOLTAGE) {
+		if (input_label)
+			return sysfs_emit(label, "%s-voltage\n", input_label);
+
+		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
+	}
+
+	if (chan->type == IIO_POWER) {
+		if (input_label)
+			return sysfs_emit(label, "%s-power\n", input_label);
+
+		return sysfs_emit(label, "channel%d-power\n", chan->channel);
+	}
+
+	return 0;
+}
+
+static const struct iio_info max34417_info = {
+	.read_raw	= max34417_read_raw,
+	.read_label	= max34417_read_label,
+};
+
+static unsigned int max34417_calc_input_correction(u32 rsense)
+{
+	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
+	return (100 * MILLI * MAX34417_PWR_CORRECTION_SCALE) / rsense;
+}
+
+static int max34417_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max34417_data *max34417;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc, i;
+
+	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	rc = devm_regulator_get_enable(dev, "vdd");
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
+
+	rc = devm_regulator_get_enable(dev, "vio");
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
+
+	max34417 = iio_priv(indio_dev);
+	max34417->regmap = regmap;
+	max34417->dev = dev;
+	mutex_init(&max34417->lock);
+
+	/* Set default input correction for all channels */
+	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
+		max34417->input_correction[i] =
+			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
+
+	device_for_each_child_node_scoped(dev, node) {
+		u32 rsense, index;
+
+		if (fwnode_property_read_u32(node, "reg", &index))
+			return dev_err_probe(dev, -EINVAL, "missing reg property of %pfwP\n",
+					     node);
+		else if (index >= MAX34417_CHANNEL_COUNT)
+			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
+					     index, node);
+
+		fwnode_property_read_string(node, "label", &max34417->input_label[index]);
+
+		rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms", &rsense);
+		if (!rc) {
+			if (!rsense || rsense < 1000 || rsense > 100000)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid shunt value %d of %pfwP\n",
+						     rsense, node);
+
+			max34417->input_correction[index] =
+				max34417_calc_input_correction(rsense);
+		}
+	}
+
+	indio_dev->channels = max34417_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
+	indio_dev->name = "max34417";
+	indio_dev->info = &max34417_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Set as default Manual Mode & Wide ADC */
+	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_DEFAULT_CMM_WIDE);
+	if (rc)
+		return dev_err_probe(max34417->dev, rc, "Error writing control register\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id max34417_of_match[] = {
+	{ .compatible = "maxim,max34417" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max34417_of_match);
+
+static const struct i2c_device_id max34417_id[] = {
+	{ .name = "max34417" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max34417_id);
+
+static struct i2c_driver max34417_driver = {
+	.driver = {
+		.name   = "max34417",
+		.of_match_table = max34417_of_match,
+	},
+	.probe = max34417_probe,
+	.id_table = max34417_id,
+};
+module_i2c_driver(max34417_driver);
+
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
+MODULE_DESCRIPTION("Maxim MAX34417 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

