Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE83BE62B
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900235; cv=none; b=VXYpgpAupQ6GH44pvcidyDy+nLzjGe3P2uVOITOqVKAmr+Yhj5aTlZl7kk1pCNgF5nJIX+EOblx0z0tRF+YSPIG4/iHwlpXYutvFSoLYVn36Rrx41fBseRyyZ2+Evmna5SQU5A/2aUz+KSGWvaHDU6bCPNNxcRXBYXmxlDxdYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900235; c=relaxed/simple;
	bh=nAOnaPo1D/s0Wg4nrM0jl1YCtIHSdUgz5Y0jINktQcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbUBORqDlXoBqqRNCShoEDFWm54TLZq6kyp2Cb09/qlEMKBnQ60ckhcb5dnsY/cJArVo/+JeDqx/s8+JGJLtaYbvbLRdRBghvnPQ66+IQsY0SwYhmbk6uc7Ir6OE/PQYMzzhdIqkx6y4A/YiurFTQjau3vIwGWiI3k+IvJok9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sde0zW5t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sde0zW5t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48fde648a71so79352135e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779900231; x=1780505031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmocUo0OiaSb6HNIKUeKNR/uaYR4F722jq0d21+Jqac=;
        b=Sde0zW5tIQQ+KRAv0YjMsdVIidZ0HptKytzvBd+bOKroZL280h6q30ZBNXxVJqqHzW
         UHgFjk8AkYDFQgsAW0LKsaEbl5uO6hxu+eWfpz9Wm+7/axOg9PAgpOcdL1/b+MKwzO4q
         fraaUm1q0ACZZ6cCIFFk1qRBA1T2J6hfzkkPsB1000/ulp2AkXg9YUbEMXwd0BAubDs6
         l0Yfz8CY/WTYAsz/7Q/hOpSWjuvWZMVBY9UUgMoYHScR00dJuuKjUcXPwsiU2QWPLutU
         efleU9PDpnH8ex0bvLDxr45ukj8VHTj8sW/K/7BjQAYGaQU5dkZVfbw8Xlm+177O6zvo
         zs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900231; x=1780505031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmocUo0OiaSb6HNIKUeKNR/uaYR4F722jq0d21+Jqac=;
        b=Wr0z23zY3r9ypJ84Wl9wYHackp7bGzjPo37agEpdltHIF2iQdpsbN1DGUyryyt0oEb
         tekHTxgOaVCEv5XrRWuQzbIESqTHy0mWv/5ARveRhuZZv8D94byzDTojTIflDetV2fM4
         QhPhpjn9fD9TConER8/ItnUmRPagxNgNS35SrCuUUrn2R5Mjcaq7gi/HW7VOTknUYxsL
         DhwJFdf9Nz0ng8vQKOGqfyoYNlRhXOho0YaeTkT/cBqODds808M5mL44/WcNXHLCDjXp
         oiojrpHyOs0O7kmwYRSxTBcoHHE39LDWD6JU0s+m/wWX6VxF2n35xZmSuNHw/AC00T51
         s5iA==
X-Gm-Message-State: AOJu0Yz64HVD5/8ygAfGjmUtCFiOGlWu/UeRasJi6JJfv59Txcegf98b
	CrgA7FTJaZywQBov5rmVU69m0PyJEzksVqezHYg5b27DtlotTfciJPvUHBnXYBa5
X-Gm-Gg: Acq92OEO14xL8uZHV4CQRlV3wADnuCM36dohGA48kE4t26S3ka9pr29atS/lIkCSmt9
	/pKUfe6eM9rmbA0edFRcsYTF76quMBa5TI7Ck/OOxtWXTYMJabJLsBX1lWep18HM5lOALXbgyc8
	4htZjDO2sJCMFF/41JvXo4kR1bTvM5AlhAtUtMnvsV4rx0T862vT/A1AnGFzsug8BNPXRAairkX
	NdAxEowxND9lrfDTbdkoOvKz/4QlzY7Fp17Cj/9aPTlcOpIc5X8FHZOEF7cAwxhvhXFJOCQ45/5
	5e+/NGmjeE1rHz4q1+y2SC/qSeYYkB897GUnILP7zdEG5hBbd7oWfHepQdIL7/VuVa+zPDKZ2Lq
	tFa7uXNqJZ9bSot/YFEcE9OtSWzCNAXf4D9uGwdvnDyQhQ8UYhZFeYURRN/oOU5f+ekTImlQexb
	ut7NTT+A4nBzEYZwsCsRUDPrM7pNkA/pJrcEQr7YMPhXaBIMKhDH6+FWQJm/SgBAuMuO0=
X-Received: by 2002:a05:600c:860b:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-4907df7925bmr73726865e9.8.1779900231285;
        Wed, 27 May 2026 09:43:51 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:f829:aa3:9ba8:c8c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm436435435e9.2.2026.05.27.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:43:50 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 1/4] iio: adc: add ti-ads1110
Date: Wed, 27 May 2026 18:43:09 +0200
Message-ID: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new IIO ADC driver for the TI ADS1110. The driver supports the device's
internal reference/voltage regulator and enables the high 240 SPS conversion
rate, exposing the ADC input through the IIO framework.

Tested on: Raspberry pi 3b+ with 7.0 stable kernel

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1110.c | 468 +++++++++++++++++++++++++++++++++++
 1 file changed, 468 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1110.c

diff --git a/drivers/iio/adc/ti-ads1110.c b/drivers/iio/adc/ti-ads1110.c
new file mode 100644
index 000000000000..ed8c16f7411d
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1110.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADS1110 - Texas Instruments Analog-to-Digital Converter
+ *
+ * Copyright (c) 2023, Topic Embedded Products
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/ads1110
+ * IIO driver for ADS1110
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/fwnode.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/* The ADS1100 has a single byte config register */
+
+/* Conversion in progress bit */
+#define ADS1110_CFG_ST_BSY	BIT(7)
+/* Single conversion bit */
+#define ADS1110_CFG_SC		BIT(4)
+/* Data rate */
+#define ADS1110_DR_MASK		GENMASK(3, 2)
+/* Gain */
+#define ADS1110_PGA_MASK	GENMASK(1, 0)
+
+#define ADS1110_REFERENCE_VOLTAGE_MV	2048
+
+#define ADS1110_CONTINUOUS	0
+#define	ADS1110_SINGLESHOT	ADS1110_CFG_SC
+
+#define ADS1110_SLEEP_DELAY_MS	2000
+
+static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
+static const int ads1110_data_rate_bits[] = { 12, 14, 15, 16 };
+
+struct ads1110_data {
+	struct i2c_client *client;
+	struct regulator *reg_vdd;
+	struct mutex lock;
+	int scale_avail[2 * 4]; /* 4 gain settings */
+	u8 config;
+};
+
+static const struct iio_chan_spec ads1110_channel = {
+	.type = IIO_VOLTAGE,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all =
+	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_shared_by_all_available =
+	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		      .sign = 's',
+		      .realbits = 16,
+		      .storagebits = 16,
+		      .endianness = IIO_CPU,
+		       },
+	.datasheet_name = "AIN",
+};
+
+static int ads1110_set_config_bits(struct ads1110_data *data, u8 mask, u8 value)
+{
+	int ret;
+	u8 config = (data->config & ~mask) | (value & mask);
+
+	if (data->config == config)
+		return 0;	/* Already done */
+
+	dev_dbg(&data->client->dev, "Updating config register: 0x%02x -> 0x%02x\n",
+		 data->config, config);
+	ret = i2c_master_send(data->client, &config, 1);
+	if (ret < 0)
+		return ret;
+
+	data->config = config;
+
+	return 0;
+};
+
+static int ads1110_data_bits(struct ads1110_data *data)
+{
+	return ads1110_data_rate_bits[FIELD_GET(ADS1110_DR_MASK, data->config)];
+}
+
+static int ads1110_get_adc_result(struct ads1110_data *data, int chan, int *val)
+{
+	int ret;
+	__be16 buffer;
+	s16 value;
+
+	if (chan != 0)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	/* Value is always 16-bit 2's complement */
+	value = be16_to_cpu(buffer);
+
+	/* Shift result to compensate for bit resolution vs. sample rate */
+	value <<= 16 - ads1110_data_bits(data);
+
+	*val = sign_extend32(value, 15);
+
+	return 0;
+}
+
+static int ads1110_set_scale(struct ads1110_data *data, int val, int val2)
+{
+	int microvolts;
+	int gain;
+	int ret;
+
+	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
+	if (val)
+		return -EINVAL;
+
+	if (!val2)
+		return -EINVAL;
+
+	microvolts = ADS1110_REFERENCE_VOLTAGE_MV * 1000;
+	/*
+	 * val2 is in 'micro' units, n = val2 / 1000000
+	 * result must be millivolts, d = microvolts / 1000
+	 * the full-scale value is d/n, corresponds to 2^15,
+	 * hence the gain = (d / n) >> 15, factoring out the 1000 and moving the
+	 * bitshift so everything fits in 32-bits yields this formula.
+	 */
+	gain = DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
+	if (gain < BIT(0) || gain > BIT(3))
+		return -EINVAL;
+
+	dev_dbg(&data->client->dev, "Setting gain to %d", ffs(gain) - 1);
+
+	ret = ads1110_set_config_bits(data, ADS1110_PGA_MASK, ffs(gain) - 1);
+
+	return ret;
+}
+
+static int ads1110_set_data_rate(struct ads1110_data *data, int chan, int rate)
+{
+	unsigned int i;
+	unsigned int size;
+
+	size = ARRAY_SIZE(ads1110_data_rate);
+	for (i = 0; i < size; i++) {
+		if (ads1110_data_rate[i] == rate)
+			return ads1110_set_config_bits(data, ADS1110_DR_MASK,
+						       FIELD_PREP(ADS1110_DR_MASK, i));
+	}
+
+	return -EINVAL;
+}
+
+static int ads1110_pga_gain_to_field_value(int gain)
+{
+	if (!is_power_of_2(gain) || gain > 8)
+		return -EINVAL;
+
+	return ffs(gain) - 1;
+}
+
+static void ads1110_calc_scale_avail(struct ads1110_data *data)
+{
+	int millivolts = ADS1110_REFERENCE_VOLTAGE_MV;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
+		data->scale_avail[i * 2 + 0] = millivolts;
+		data->scale_avail[i * 2 + 1] = 15 + i;
+	}
+}
+
+static int ads1110_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1110_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1110_data_rate;
+		*length = ARRAY_SIZE(ads1110_data_rate);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*vals = data->scale_avail;
+		*length = ARRAY_SIZE(data->scale_avail);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1110_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ads1110_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ads1110_get_adc_result(data, chan->address, val);
+		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* full-scale is the supply voltage in millivolts */
+		*val = ADS1110_REFERENCE_VOLTAGE_MV;
+		*val2 = 15 + FIELD_GET(ADS1110_PGA_MASK, data->config);
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ads1110_data_rate[FIELD_GET(ADS1110_DR_MASK,
+						   data->config)];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1110_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1110_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return ads1110_set_scale(data, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ads1110_set_data_rate(data, chan->address, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ads1110_info = {
+	.read_avail = ads1110_read_avail,
+	.read_raw = ads1110_read_raw,
+	.write_raw = ads1110_write_raw,
+};
+
+static int ads1110_setup(struct ads1110_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	/* Setup continuous sampling mode at 15sps */
+	buffer[0] = ADS1110_DR_MASK | ADS1110_CONTINUOUS;
+	ret = i2c_master_send(data->client, buffer, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	/* Config register returned in third byte, strip away the busy status */
+	data->config = buffer[2] & ~ADS1110_CFG_ST_BSY;
+
+	return 0;
+}
+
+static int ads1110_parse_dt(struct ads1110_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	int gain;
+	int rate;
+	int ret;
+
+	if (!fwnode)
+		return 0;
+
+	ret = fwnode_property_read_u32(fwnode, "ti,gain", &gain);
+	if (!ret) {
+		ret = ads1110_pga_gain_to_field_value(gain);
+		if (ret < 0) {
+			dev_warn(dev, "Invalid ti,gain %d, using default gain\n", gain);
+		} else {
+			ret = ads1110_set_config_bits(data, ADS1110_PGA_MASK,
+					FIELD_PREP(ADS1110_PGA_MASK, ret));
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		dev_warn(dev, "No ti,gain device tree configuration found; using default gain\n");
+	}
+
+	ret = fwnode_property_read_u32(fwnode, "ti,data-rate", &rate);
+	if (!ret) {
+		ret = ads1110_set_data_rate(data, 0, rate);
+		if (ret < 0)
+			dev_warn(dev, "Invalid ti,data-rate %d, using default data rate\n", rate);
+	} else {
+		dev_warn(dev, "No ti,data-rate device tree configuration found; using default data rate\n");
+	}
+
+	return 0;
+}
+
+static void ads1110_disable_continuous(void *data)
+{
+	ads1110_set_config_bits(data, ADS1110_CFG_SC, ADS1110_SINGLESHOT);
+}
+
+static int ads1110_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads1110_data *data;
+	struct device *dev = &client->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, data);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = "ads1110";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &ads1110_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ads1110_info;
+
+	data->reg_vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->reg_vdd))
+		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+				     "Failed to get vdd regulator\n");
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable vdd regulator\n");
+	ret = ads1110_setup(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to communicate with device\n");
+
+	ret = ads1110_parse_dt(data);
+
+	ret = devm_add_action_or_reset(dev, ads1110_disable_continuous, data);
+	if (ret)
+		return ret;
+
+	ads1110_calc_scale_avail(data);
+
+	pm_runtime_set_autosuspend_delay(dev, ADS1110_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
+
+	return 0;
+}
+
+static int ads1110_runtime_suspend(struct device *dev)
+{
+	struct ads1110_data *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Suspending device\n");
+
+	ads1110_set_config_bits(data, ADS1110_CFG_SC, ADS1110_SINGLESHOT);
+	regulator_disable(data->reg_vdd);
+
+	return 0;
+}
+
+static int ads1110_runtime_resume(struct device *dev)
+{
+	struct ads1110_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "Resuming device\n");
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to enable Vdd\n");
+		return ret;
+	}
+
+	/*
+	 * We'll always change the mode bit in the config register, so there is
+	 * no need here to "force" a write to the config register. If the device
+	 * has been power-cycled, we'll re-write its config register now.
+	 */
+	return ads1110_set_config_bits(data, ADS1110_CFG_SC,
+				       ADS1110_CONTINUOUS);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1110_pm_ops,
+				 ads1110_runtime_suspend,
+				 ads1110_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id ads1110_id[] = {
+	{ "ads1110" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, ads1110_id);
+
+static const struct of_device_id ads1110_of_match[] = {
+	{.compatible = "ti,ads1110" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ads1110_of_match);
+
+static struct i2c_driver ads1110_driver = {
+	.driver = {
+		   .name = "ads1110",
+		   .of_match_table = ads1110_of_match,
+		   .pm = pm_ptr(&ads1110_pm_ops),
+	},
+	.probe = ads1110_probe,
+	.id_table = ads1110_id,
+};
+
+module_i2c_driver(ads1110_driver);
+
+MODULE_AUTHOR("Jakub Szczudlo <jakubszczudlo40@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS1110 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.47.3

