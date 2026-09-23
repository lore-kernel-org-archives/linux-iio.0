Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1265328AD
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190633; cv=none; b=uPEcG05Gp+hPiopz+m5yhC1cWB026II5xoIQuIrE9k48gosaAk4hT4OFFJC8DojNFjwmimpEvSUW42EvACOU1f3CIPVN7xEyaR8QOQw3DvRjALBeq1T5OH35cHaq84v62uuw6lPH6p39oNKMnB0kTVnuscRRbeq1ZRpvsRSdXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190633; c=relaxed/simple;
	bh=/HHu5mWoKQYJpp3qfSseBjpomgBAvf0wv5291K53EOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEUaKcFDRpQVvX9DQWHTmGoY/prkUeWZVmdJ9dNVRT2p/RWBOjDlYQTd3rgAxbbpiYisJ4F+xoy2c5U4IK+C0hdPPX+OZ5nuM/Gv8Hn5zX/24Jh7wHajV3iFzE/XdJQgFM4rAVIZtWJWmsGt5u7yOauDpPUXt5j1YPkofNFVlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pcz0xiZH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcz0xiZH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso10329245e9.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790190628; x=1790795428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvqBKY0BSaSooNswT1/1l8FfXVAsC8BPEJKgqk/8tBg=;
        b=pcz0xiZH0S0SHHRfbsxNKhCDrK7QC6oudmWqnzLlEJpY9qFK53cIj95/08iOC/jbtV
         nishzaM7zTYmf9VOhetL9UxisJ7LcCSvIv2nNnrrdhn81XIdONYtgTKmFbBZkgk8vs2l
         n0DMOzDLSLw1thblj6GJ/dwye4JXe+GDTUVJU+JrkYR9rL9MJkt3kPzeIJfEI8AnepSw
         HxnDlBw9uXjYW+Bopg3VZOy9/5wdU/dtMlDrqC8w1MmtwH1Ow3bufvzVEAy/p4FmOWvA
         c5TZAP3W2WmioUNCXZc6Q9o4bNK1++CcarmhGfNH4OcwJ+M47PCsCwIAQVCvi5enog+7
         fs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190628; x=1790795428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvqBKY0BSaSooNswT1/1l8FfXVAsC8BPEJKgqk/8tBg=;
        b=lgNpvKpSHGAKeN/1CD8rzQUMqsuWVwsO6DCewYTcS5oAlbzGIkTDI4TbNZSAZLy3V+
         sy0BuVG1s/UnJiAbwWXgvjt9ZjLRh9T+hNn00rUBt+OrBt3pB52WGJG55YpfvZF3PkoM
         NLT0sFhdC/Kxt3zQIwebl5g9N+XvGhU2hnBV4cKjRMVywXGWFv0OkK2iUMm82nzwP5Zf
         GMtG3w6mtM1cP2YdFBwEQMvoDqoc7MLtfp5qdMHLK5NBbiYH2wS8NNbIfe7xOiK1a+9m
         EFni+iuxycfY/MoAoqQ047sEI22zMAVY7SypwkvWdPcCGzmXcweCtK2MqaVBb3f0VjI0
         u4DQ==
X-Gm-Message-State: AFuF++mBeSNIoO5hdLV+ythxtPTMpR2S2ycHexSZbH1HXaLzIz2+hY3b
	EvXgmUJ12LKSMFkAS6aY02AavMWFvsR1GFAMZcVGPh9i4hOEcMIuLS5SxGSpAvnavio=
X-Gm-Gg: AYBFou2Zq2ocbJbD6RIw4JxslnkVGSkqLkFJjolVRX2x6MHccvaNysHr+txH5FIOCCd
	hvK2uORgrvw7ngcFDOdRdirOmhbZHT9/js4jXIYETcTwuqvdxC7jm3BezYgVqyjOaEKAnAp9CJz
	/r5x0DZBXYzlDYm41Hlgp4suyw4PX+1zq6BfkhNLhKkq7QbYZdUAaxud2WcFWBUbScM8ogcvZV4
	oo00XnHa0BDDf66V1O9KCiOsbjE69pJk3zcVu4cu283adnouQn25+Vch/q6JaycERtSZGQ1QZ5/
	fvIayVyJtDFW9fersCKyxhGV/AtBGp9hp0bfw/Xrkbe9Wk4706xIjz8STikBVo0nL6R9sqwhNxL
	D9dnI4JVWYqqzuHZWfDmXAHlAd3vI0P83c2ffPq4t04m2bRx5Ky8OGetXrygA4BTxWDHNxbyEUp
	6DGmkkd9a5AFS4/DiB+V7gFi7SLWz/R6cyMjtkD1N9R4SPLVW/m5KIY2Qca8R00Ra5zCCGHn5zI
	4TfjF4fY0haP4wdGE8=
X-Received: by 2002:a05:600c:8b22:b0:49f:bbab:aa10 with SMTP id 5b1f17b1804b1-49fe66f13f6mr2377015e9.20.1790190627940;
        Wed, 23 Sep 2026 12:10:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bae53dsm7291815e9.4.2026.09.23.12.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:10:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 23 Sep 2026 21:10:23 +0200
Subject: [PATCH 2/2] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-topic-sm8x50-iio-max34417-adc-v1-2-41d4ba1bfc41@linaro.org>
References: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
In-Reply-To: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12252;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/HHu5mWoKQYJpp3qfSseBjpomgBAvf0wv5291K53EOw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqtCQhfSrckBRpWJmulGU2gDWZ8oVIDpUDzMV2QYKX
 3OoOEU+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarQkIQAKCRB33NvayMhJ0cW8D/
 oDQ4Xc7atPecuMC1DtuPKwV7WljqRmPhxfUngg706jvpK0PBG1dccPcyuXUbYvZQFWDNSJ3uln32s8
 g79HZDMg37TRlnND6POUTCDCShswD66nLPc7a1Ong8u15Pqir5VI9YdUCBD6Qt8IJVTAQf5Y7wcQGt
 FHorqG/XdW4DYIp9eCAmEtWhCJcvG4Ln7XtkGc797TXoulCZuMfQvkKc+SMwPxdgGM0xsAsSINUf1V
 Gwyudnxv4bQ64EVQ5N1oHaLw9mSCjZbB3+t/d5UpGbahW/k3m8ueRmI30NQWOvuxZ9cT42I4NgaAxE
 IXZ25jEVO1kUQM2QSxFifcQbeaO+Pdp2KKmZvQz0ZXNVaK2YnP4GKRa6AhOvzYyvBgBfDryVhTeBXb
 /3+PzQ7VmFZLWUYU8nx0rC74EEr/NttWbni19tHTraHu0996SZL7tSQbhDKy4I8ZWuYK72sOI1wJ01
 45FJnsmKoY+CAPq+3xYrUITjj+Hc9mCWVLTl9YraYKq3se53LKIkbzQvc/xT6zptxGhWVWdBYfMhJG
 OWpeWQ2XI0/qzAOV084FpL1hubbk5XM6d+BRLGfd1gWdVb/MyDRa3UeSFNJ5yFgfrIaihuJwnLf6j/
 GdJyrMZR6kj4nHRg5vbcVWIgKoFj/Z+bX01jfYe3lqNuFGjgGunrXlBT0rRg==
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
 drivers/iio/adc/max34417.c | 356 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..4c559bafd1ce 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1116,6 +1116,17 @@ config MAX34408
 	  To compile this driver as a module, choose M here: the module will be
 	  called max34408.
 
+config MAX34417
+	tristate "Maxim max34417 ADC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build ADC support for Maxim max34417 Four-Channel High
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
index 000000000000..004401de6ce7
--- /dev/null
+++ b/drivers/iio/adc/max34417.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Maxim MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
+ *
+ * Datasheet: https://www.analog.com/en/products/max34417.html
+ *
+ * TODO: Slow Mode, Continuous Accumulate Mode, Park Feature, Bulk Update, Perr_Verr Correction
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
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
+ * struct max34417_data - max34417 specific data.
+ * @regmap:	device register map.
+ * @dev:	max34417 device.
+ * @lock:	lock for protecting access to device hardware registers, mostly
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
+	usleep_range(1000, 2000);
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
+				 const struct iio_chan_spec *chan, int *val, int *val2)
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
+	*val = FIELD_GET(GENMASK(31, 0), power);
+	*val2 = FIELD_GET(GENMASK(55, 32), power);
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
+		return -EINVAL;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		if (chan->type == IIO_POWER)
+			return max34417_read_power(max34417, chan, val, val2);
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
+		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
+	}
+
+	if (chan->type == IIO_POWER) {
+		if (input_label)
+			return sysfs_emit(label, "%s-power\n", input_label);
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
+static int max34417_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max34417_data *max34417;
+	struct fwnode_handle *node;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc;
+
+	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err_probe(dev, PTR_ERR(regmap),
+			      "regmap_init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	/* Get and enable regulators */
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
+	device_for_each_child_node(dev, node) {
+		unsigned int correction;
+		u32 rsense, index;
+
+		if (fwnode_property_read_u32(node, "reg", &index)) {
+			dev_err(dev, "missing reg property of %pfwP\n", node);
+			return -EINVAL;
+		} else if (index >= MAX34417_CHANNEL_COUNT) {
+			dev_err(dev, "invalid reg %d of %pfwP\n", index, node);
+			return -EINVAL;
+		}
+
+		fwnode_property_read_string(node, "label", &max34417->input_label[index]);
+		if (fwnode_property_read_u32(node, "maxim,rsense-val-micro-ohms", &rsense))
+			rsense = MAX34417_DEFAULT_RSENSE;
+
+		/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
+		correction = (100 * MILLI * MAX34417_PWR_CORRECTION_SCALE) / rsense;
+
+		max34417->input_correction[index] = correction;
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
+	if (rc) {
+		dev_err(max34417->dev, "Error (%d) writing control register\n", rc);
+		return rc;
+	}
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

