Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0B3C3434
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494493; cv=none; b=oh3GJvqsT1CcSdBNamC41WL50+cQeWi55fXcL/+K7SEsfAHXUB3zB+w+i4Z1kS6c0Fr0+PEt2G9fifS3bvwsHB7UoLP3thzgAhZkTDcPo8rixd8QhbephZVDpSJ1vLOUZryd2uIM80MFr2c1wsTRfOKjmk5qm4OJREAcXlj6BqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494493; c=relaxed/simple;
	bh=Ub1t+VdA5UrOeIWzskQ9XocwZdW1qmuQSJH1hnxV9qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJBeLmvFuRyQ8KQi0ue7ay7EACMmfiWmuIYLxH/k5se96h3XrwYhi+zPZNXs4xuh38vC1xkbuYLwgGKav+39rVkPDZeW+z7N5GZ90Kt6nYOp60WyLqMiIGzBm5e3GmkgLE/44pL+eN4heYR1mt4RbDzCYx+0O3L4iI5qCoNE9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXMJ4iM8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXMJ4iM8"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so6665451a12.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494489; x=1779099289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QE/HWQx0nNtczoc8aNuLbKNkZ6sRPtBd05lyxKoAI1M=;
        b=TXMJ4iM8A47mOM2lW6y//rXPkVo3FOGW2/M6ZLefaZ311caX8kKfL04TQtJ+AEosww
         zqoOKWBW8bFcu7uaHS3F/eYw8+l3D5l6Y9ZKaXjHxRkLz3Ibcg/l2VDqoN/1/1zuW64L
         vWUnz3gfSDFP2UfMBrEIwIKcp8/1Ico0s62ShXmJZD+CgFsJfSfsYXAKxGTGF+7DaeXN
         0INvNIhiXjqttwFZDPUhOfhmXS4cHKR7+3fFuadczLnO78gLD2/MHBGCfqq9m0ePhXDn
         TjsP0KEXW+3gMXw3jPV9D1mEYslhsIai+xH6E/cl7lMEmyYzcqYYkFMxbre/f+Bu9BIx
         buKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494489; x=1779099289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE/HWQx0nNtczoc8aNuLbKNkZ6sRPtBd05lyxKoAI1M=;
        b=AuuAsxlQ5p4OEnq+fMesImsIu9G+3yD+DUnsq+f80ddlSi1jeG3tEkCddwuJntZvdP
         oKKOb+3KyM6/jsLBTcKpZviIje99zhTQhnG5xU2cwCtovwebbam7FsKDtuHTCLHK2MTs
         /M8ceJvyL9Ezq9bgt15MaPvvdnqklt9L6aRL3lUE9L1aHFjCGoH/GkupIxv8hGb/BrdO
         XgzBL/4bUDTHM5yajETaZDkXG/EUEMH0xKmx0cvCSYL3oTY/eDs1NHardPNlW2kaQbG8
         9tFyxX8e/R6xgZ7jSGSReddOSlDGt7Z8Unyt1zmjOOxH0we6a/Yclaa66tpjSBMOKmL4
         6TMA==
X-Gm-Message-State: AOJu0Yw4u7/7Fgoc0qu+8fiSqUMaDSjvf38UxkZqum65LzKH22/fKq8f
	aM2piiYpN6oYA/B0cEqI4xWLJj7hNJ1+zgojMRPXlQYg8VxZbFWX7Lkop0QKupXY
X-Gm-Gg: Acq92OF5pYe7zEgfjYhs6I22PdZS3T5Qh5qZJSrmd6o5HzOVy9H79ObGsvP/qLeo1MI
	vZS7x4k9jXKIkJRfhqttjMvteWyie+Nt+vWXHC5GJ0d0wY000C3CB399HlWbLkgJCePSJ1hUsLP
	pj+dw6jWQ3vwN1v/fLgzZ/Ly5w532BStIxNV1WtWa9OVQnXN0MgggndDnFkLorPJEx+XomDigUD
	8S5s3VIxgMoXnc4bPebX/3hyXPupB+Apejw2v/lCs8PCfokRLztIBkbrj7eueElDP+RVLJSXwZM
	oFAMA8S0Tzo/zEDT5i58rX1YCInQwDXjDN8ApUjrV3NbD5ndZRMrSvb6pt+xOoZ17gpNu3f0j71
	ujw6i/VWFeacsh0iPMAN5GLrwMMjO8kxF4X1kMgZPViivJ7IB0feAOHokbdWH9vInfFnfqiC5nq
	pcoT/T4UlS8+aw4JjsDqr9hA13GBM=
X-Received: by 2002:a17:907:9806:b0:bb8:e150:d353 with SMTP id a640c23a62f3a-bc56ae29502mr1241105366b.4.1778494488265;
        Mon, 11 May 2026 03:14:48 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcaec604eeasm463809166b.19.2026.05.11.03.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:14:47 -0700 (PDT)
Date: Mon, 11 May 2026 12:14:47 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC 2/4] iio: light: add support for APDS9999 sensor
Message-ID: <b272d93898a67baf7b4b8d02ba0061321906db6e.1778491503.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778491503.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1778491503.git.azpijr@gmail.com>

Add IIO driver for Broadcom APDS9999 ambient light sensor.

The APDS9999 is a digital proximity and RGB sensor with ALS
capability. This driver implements the ALS/Lux functionality using the
green channel.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 drivers/iio/light/apds9999.c | 325 +++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 drivers/iio/light/apds9999.c

diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
new file mode 100644
index 000000000000..cf44c3003415
--- /dev/null
+++ b/drivers/iio/light/apds9999.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for Broadcom APDS9999 Lux Light Sensor
+ *
+ * Uses the green channel (ALS) which approximates human eye spectral
+ * response for ambient light sensing (lux). RGB and proximity (PS)
+ * functionality not yet implemented.
+ *
+ * Copyright (C) 2026
+ * Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>
+ *
+ * TODO: proximity and color sensor
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+/* Registers */
+#define APDS9999_REG_MAIN_CTRL		0x00
+#define APDS9999_REG_LS_MEAS_RATE	0x04
+#define APDS9999_REG_LS_GAIN		0x05
+#define APDS9999_REG_PART_ID		0x06
+#define APDS9999_REG_MAIN_STATUS	0x07
+#define APDS9999_REG_LS_DATA_GREEN_0	0x0D
+
+#define APDS9999_PART_ID		0xC2
+
+/* MAIN_CTRL */
+#define APDS9999_MAIN_CTRL_LS_EN	BIT(1)
+
+/* MAIN_STATUS */
+#define APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
+
+/* LS_MEAS_RATE */
+#define APDS9999_LS_RES_SHIFT		4
+
+/*
+ * ALS gain options (register value -> factor)
+ */
+static const int apds9999_gains[] = {
+	1, 3, 6, 9, 18,
+};
+
+/*
+ * ALS resolution / integration time
+ * Resolution bits [6:4] set both the ADC bit-width and the
+ * integration time used in the lux conversion formula
+ * Value: integration time in microseconds
+ */
+enum apds9999_resolution {
+	APDS9999_RES_20BIT,	/* 400 ms */
+	APDS9999_RES_19BIT,	/* 200 ms */
+	APDS9999_RES_18BIT,	/* 100 ms (default) */
+	APDS9999_RES_17BIT,	/*  50 ms */
+	APDS9999_RES_16BIT,	/*  25 ms */
+	APDS9999_RES_13BIT,	/*  3.125 ms */
+	APDS9999_RES_NUM,
+};
+
+static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
+	[APDS9999_RES_20BIT] =   400000,
+	[APDS9999_RES_19BIT] =   200000,
+	[APDS9999_RES_18BIT] =   100000,
+	[APDS9999_RES_17BIT] =    50000,
+	[APDS9999_RES_16BIT] =    25000,
+	[APDS9999_RES_13BIT] =     3125,
+};
+
+#define APDS9999_DEFAULT_RES		APDS9999_RES_18BIT
+#define APDS9999_DEFAULT_GAIN_IDX	1	/* 3x */
+#define APDS9999_DEFAULT_RATE		2	/* 100 ms */
+
+struct apds9999_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	int als_gain_idx;	/* index into apds9999_gains[] */
+	int als_res;		/* index into apds9999_itimes_us[] */
+	int als_rate;		/* LS_MEAS_RATE[2:0] register value */
+};
+
+/*
+ * Hardware init, write default register values and enable ALS
+ */
+static int apds9999_init(struct apds9999_data *data)
+{
+	struct i2c_client *client = data->client;
+	u8 reg;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	reg = (APDS9999_DEFAULT_RES << APDS9999_LS_RES_SHIFT) |
+	      APDS9999_DEFAULT_RATE;
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
+					APDS9999_DEFAULT_GAIN_IDX);
+	if (ret < 0)
+		goto out;
+
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
+					APDS9999_MAIN_CTRL_LS_EN);
+	if (ret < 0)
+		goto out;
+
+	data->als_gain_idx = APDS9999_DEFAULT_GAIN_IDX;
+	data->als_res = APDS9999_DEFAULT_RES;
+	data->als_rate = APDS9999_DEFAULT_RATE;
+
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+/*
+ * Read the 3-byte green-channel ADC value from 0x0D..0x0F
+ * Waits for LS_DATA_STATUS to be asserted (up to ~2x integration time)
+ */
+static int apds9999_als_read(struct apds9999_data *data, u32 *counts)
+{
+	struct i2c_client *client = data->client;
+	u8 buf[3];
+	int ret, tries;
+
+	mutex_lock(&data->lock);
+
+	/*
+	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
+	 * plus margin.  Each try sleeps 20 ms
+	 */
+	tries = (apds9999_itimes_us[data->als_res] * 2) / 20000;
+	if (tries < 2)
+		tries = 2;
+
+	while (tries--) {
+		ret = i2c_smbus_read_byte_data(client,
+						APDS9999_REG_MAIN_STATUS);
+		if (ret < 0)
+			goto out;
+		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
+			break;
+		msleep(20);
+	}
+
+	if (tries < 0) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	/* Block-read all 3 bytes of LS_DATA_GREEN */
+	ret = i2c_smbus_read_i2c_block_data(client,
+					     APDS9999_REG_LS_DATA_GREEN_0,
+					     3, buf);
+	if (ret < 0)
+		goto out;
+	if (ret != 3) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*counts = buf[0] | ((u32)buf[1] << 8) | ((u32)(buf[2] & 0x0F) << 16);
+	ret = 0;
+
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int apds9999_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct apds9999_data *data = iio_priv(indio_dev);
+	int gain, itime_us;
+	u64 scale_nano;
+	u32 counts;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = apds9999_als_read(data, &counts);
+		if (ret < 0)
+			return ret;
+		*val = (int)counts;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
+		 *
+		 * The constant 54 is derived from the datasheet table:
+		 *   at gain = 3x, itime = 100 ms → 0.180 lux/count
+		 *   → C = 0.180 * 3 * 100 = 54
+		 *
+		 * Expressed as IIO_VAL_INT_PLUS_NANO.
+		 * Uses itime_us directly to avoid truncation for
+		 * sub-millisecond integration times (e.g. 3.125 ms).
+		 */
+		gain = apds9999_gains[data->als_gain_idx];
+		itime_us = apds9999_itimes_us[data->als_res];
+
+		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
+		scale_nano = div_u64(54000000000000ULL,
+				     (u32)(gain * itime_us));
+		*val = (int)(scale_nano / 1000000000);
+		*val2 = (int)(scale_nano % 1000000000);
+		return IIO_VAL_INT_PLUS_NANO;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = apds9999_itimes_us[data->als_res];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec apds9999_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+};
+
+static const struct iio_info apds9999_info = {
+	.read_raw = apds9999_read_raw,
+};
+
+static int apds9999_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct apds9999_data *data;
+	struct iio_dev *indio_dev;
+	int ret, part_id;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
+	if (part_id < 0) {
+		dev_err(dev, "failed to read PART_ID: %d\n", part_id);
+		return part_id;
+	}
+	if (part_id != APDS9999_PART_ID) {
+		dev_err(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
+			part_id, APDS9999_PART_ID);
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "APDS-9999 detected, PART_ID=0x%02x\n", part_id);
+
+	ret = apds9999_init(data);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	indio_dev->name = "apds9999";
+	indio_dev->info = &apds9999_info;
+	indio_dev->channels = apds9999_channels;
+	indio_dev->num_channels = ARRAY_SIZE(apds9999_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to register IIO device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Disable the light sensor on driver removal
+ */
+static void apds9999_remove(struct i2c_client *client)
+{
+	/* Set MAIN_CTRL to 0 → LS_EN cleared, sensor enters standby */
+	i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL, 0);
+}
+
+static const struct i2c_device_id apds9999_id[] = {
+	{ "apds9999", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, apds9999_id);
+
+static const struct of_device_id apds9999_of_match[] = {
+	{ .compatible = "brcm,apds9999" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apds9999_of_match);
+
+static struct i2c_driver apds9999_driver = {
+	.driver = {
+		.name = "apds9999",
+		.of_match_table = apds9999_of_match,
+	},
+	.probe = apds9999_probe,
+	.remove = apds9999_remove,
+	.id_table = apds9999_id,
+};
+
+module_i2c_driver(apds9999_driver);
+
+MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
+MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
+MODULE_LICENSE("GPL");
