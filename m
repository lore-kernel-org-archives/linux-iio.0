Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3462355F54
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659842; cv=none; b=c2wpZSsc/j/PIHiBp7r9a4Za7aJ0+s7WqnaVlBwfUXiSGNscfvKYzUBk18Ibl0abmpW1o+ujUjeThstFy45NVswOnt48uAuXEkWMY1WshoEMlj6vfy0ce5Qd8B02LqhLBmiG1e9oiIr21/vjA40YxIwyPZoI/5NbqtkoUpE0hDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659842; c=relaxed/simple;
	bh=W+vTjMB8ZqeShYBXH8+HGW2b+lA91I6DU1DEReTM9N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGoVNua4vvmveeyCSDqjy+kz5sU0Tz86f96aDnJwiq3g4Y3o1gJckdIrwZjsoPLBL3XgaI/h62Aw/y1ZkdxpSytsvJvE95+7BI9zy2d70Cmbp1Wl6vMW9KGNy4q6ZMiiBuDWqoMzBv/o16tJITQCP94/y/MqIex4d7hT5NbruUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r74cjUyl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r74cjUyl"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso11308422a12.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659839; x=1779264639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NndOjGOmUvKwYyFy2avs2IDqIAamrk8YwuCSr6BHap0=;
        b=r74cjUylKO52feAGovDHR4CXoKqRSsQJyzQgEad3hIzEmQfF2K1H9LWW8R09qEbEnK
         nvU+xY0V0GpSDd1vfiug1R6USUS/k97YJ+NcPNhdZs8zc9HrRv7YAzz1wCiVVsXkvYDd
         LhHS6PEPeqP63cA5CR/7EAO07Ci9miAsHt8/Wpmtl2ritRaMnkh/aUTt1Rzy59G4xJoB
         RYbpPq1+FdQblt6aYJ2EuZG4YFW1Sv7fZPFTaB6SdNc6VwXMC3kT6qjKpAlE5ODPusR5
         FsxGPwAkxLe85F+B+wqUyIEh4ota3/zl4mxe+6gin0Sk3VeX8Y+icvl3akGrB8iQF34P
         Pa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659839; x=1779264639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NndOjGOmUvKwYyFy2avs2IDqIAamrk8YwuCSr6BHap0=;
        b=kfrNvomLPF4osME53/8n3tA1IzgUQ0rWA6RJXKFc6WH9fObg3U9ZDIouey/IfumQsn
         miwSxcfSoHVoLewzQ8R5p9jAmEdX+iKsciQzNaA/G9q/73Jm3wTjgzFW1R97dldAFZUz
         UJkbcYj9zogT/TUqYQaQ/l+y0ILW5BR5NqO0ZLx8rCw9qcmDq2C6E2gkcSHvBQLpP2MU
         JnBX7yiBy+8vZnaKEwlkg7/WxGum84HcnYKxf6x6ru49BykYV1hGQTZ5y3zYJCwcNC/M
         5y9J0XS6gFkFxoxfoCR+EdxlEYXabBBP7T73rekA7DE7HyElFyQf4BdRI387SlRwc0Ti
         GWcg==
X-Gm-Message-State: AOJu0Yx7/77UpJoRVI8ISiaKrTNwsFVX6YNugIhEItWEe0+6nij78slb
	5BIxTZyp0VjGmL2T+R7jGESIH5r7tL6qxXslZYCgUSd+w4psUmQ8N4iMaF9exGv9
X-Gm-Gg: Acq92OEL8qICn4GyZ9ahgUUqHdgvZ/pBx48YqJJlQvAFSJxG0h5aDKFZZ61kOr2BcWH
	29t8z5gYC3yv1ADNfYh5XnqYsPFKnLsXHVTwcVm4r3dQqDS3TUcOKim7nJiQ8TolepjNq435Ds0
	MSQUPDSeDRP7dH1tNVMGAcE8rYFUtcXy0Hs5xlUj9CxyyuREmPF26pbrP4trXN8C/O2SSV9hXfM
	xzuctt/QhzjrNEGVNbItqvqCVEgwU+nsXfxLSKuZbc6/mCdT5j1CElZhDwzAbIjcVlp6SRQ6NOW
	Sopvu70DHKt4eFgWb2h7xR4dtA059x+gfE2bqUEY2tJzcBrKLm+L9BMTOnfoetj70K6aK3aANqZ
	F/m/YgFdkGtluWIw06okfN32+f3+VM3wxukocvCymMdTPTcZ4ATBVpium2+wpD0KB4cGXcBNFQ4
	svkQj1gG1TVNQNbnUfraXfQTLTHmI=
X-Received: by 2002:a05:6402:1215:b0:678:f81a:76a1 with SMTP id 4fb4d7f45d1cf-68255909d52mr850789a12.10.1778659838770;
        Wed, 13 May 2026 01:10:38 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3ba35sm5945545a12.2.2026.05.13.01.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:10:37 -0700 (PDT)
Date: Wed, 13 May 2026 10:10:35 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778659152.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778659152.git.azpijr@gmail.com>

Add IIO driver for Broadcom APDS9999 ambient light sensor.

The APDS9999 is a digital proximity and RGB sensor with ALS
capability. This driver implements the ALS/Lux functionality using
the green channel, which uses optical coating technology to
approximate the human eye spectral response.

Proximity (PS) and RGB color features are not yet implemented.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/light/Kconfig    |  10 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/apds9999.c | 344 +++++++++++++++++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 drivers/iio/light/apds9999.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64c8cf2601e8..cdb703f37f06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4307,6 +4307,7 @@ M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
+F:	drivers/iio/light/apds9999.c

 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..c7256ffb972d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -119,6 +119,16 @@ config APDS9960
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9960

+config APDS9999
+	tristate "APDS9999 ambient light sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build support for the Broadcom APDS9999
+	  ambient light sensor (ALS/Lux).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called apds9999.
+
 config AS73211
 	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0048e0d5ca8..39e62dfc10c7 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_APDS9160)		+= apds9160.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
+obj-$(CONFIG_APDS9999)		+= apds9999.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
new file mode 100644
index 000000000000..577b93f61d31
--- /dev/null
+++ b/drivers/iio/light/apds9999.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for Broadcom APDS9999 Lux Light Sensor
+ *
+ * Copyright (C) 2026
+ * Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>
+ *
+ * TODO: proximity and color sensor
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/unaligned.h>
+
+#define APDS9999_REG_MAIN_CTRL		0x00
+#define   APDS9999_MAIN_CTRL_LS_EN	BIT(1)
+#define APDS9999_REG_LS_MEAS_RATE	0x04
+#define   APDS9999_LS_RES_MASK		GENMASK(6, 4)
+#define   APDS9999_LS_RATE_MASK	GENMASK(2, 0)
+#define APDS9999_REG_LS_GAIN		0x05
+#define APDS9999_REG_PART_ID		0x06
+#define APDS9999_REG_MAIN_STATUS	0x07
+#define   APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
+#define APDS9999_REG_LS_DATA_IR_0	0x0A
+#define APDS9999_REG_LS_DATA_GREEN_0	0x0D
+#define APDS9999_REG_LS_DATA_BLUE_0	0x10
+#define APDS9999_REG_LS_DATA_RED_0	0x13
+
+#define APDS9999_PART_ID		0xC2
+
+enum apds9999_gain {
+	APDS9999_GAIN_1X = 0,
+	APDS9999_GAIN_3X = 1,
+	APDS9999_GAIN_6X = 2,
+	APDS9999_GAIN_9X = 3,
+	APDS9999_GAIN_18X = 4,
+};
+
+static const int apds9999_gains[] = {
+	[APDS9999_GAIN_1X]  = 1,
+	[APDS9999_GAIN_3X]  = 3,
+	[APDS9999_GAIN_6X]  = 6,
+	[APDS9999_GAIN_9X]  = 9,
+	[APDS9999_GAIN_18X] = 18,
+};
+
+enum apds9999_resolution {
+	APDS9999_RES_20BIT = 0,	/* 400 ms */
+	APDS9999_RES_19BIT = 1,	/* 200 ms */
+	APDS9999_RES_18BIT = 2,	/* 100 ms (default) */
+	APDS9999_RES_17BIT = 3,	/*  50 ms */
+	APDS9999_RES_16BIT = 4,	/*  25 ms */
+	APDS9999_RES_13BIT = 5,	/*  3.125 ms */
+	APDS9999_RES_NUM
+};
+
+static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
+	[APDS9999_RES_20BIT] = 400000,
+	[APDS9999_RES_19BIT] = 200000,
+	[APDS9999_RES_18BIT] = 100000,
+	[APDS9999_RES_17BIT] =  50000,
+	[APDS9999_RES_16BIT] =  25000,
+	[APDS9999_RES_13BIT] =   3125,
+};
+
+enum apds9999_rate {
+	APDS9999_RATE_25_MS = 0,
+	APDS9999_RATE_50_MS = 1,
+	APDS9999_RATE_100_MS = 2,
+	APDS9999_RATE_200_MS = 3,
+	APDS9999_RATE_500_MS = 4,
+	APDS9999_RATE_1000_MS = 5,
+	APDS9999_RATE_2000_MS = 6,
+};
+
+struct apds9999_data {
+	struct i2c_client *client;
+	/* lock: protects als_gain_idx, als_res, als_rate */
+	struct mutex lock;
+	int als_gain_idx;
+	int als_res;
+	int als_rate;
+};
+
+static void apds9999_standby(void *client)
+{
+	i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL, 0);
+}
+
+static int apds9999_init(struct apds9999_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct i2c_client *client = data->client;
+	u8 reg;
+	int ret;
+
+	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->lock);
+
+	reg = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
+	      FIELD_PREP(APDS9999_LS_RATE_MASK, APDS9999_RATE_100_MS);
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, reg);
+	if (ret)
+		return ret;
+	data->als_res = APDS9999_RES_18BIT;
+	data->als_rate = APDS9999_RATE_100_MS;
+
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
+					APDS9999_GAIN_3X);
+	if (ret)
+		return ret;
+	data->als_gain_idx = APDS9999_GAIN_3X;
+
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
+					APDS9999_MAIN_CTRL_LS_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int apds9999_read_channel(struct apds9999_data *data, u8 reg, u32 *counts)
+{
+	struct i2c_client *client = data->client;
+	u8 buf[3];
+	int ret, tries;
+
+	guard(mutex)(&data->lock);
+
+	/*
+	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
+	 * plus margin.  Each try sleeps 20 ms.
+	 */
+	tries = max(2, (apds9999_itimes_us[data->als_res] * 2) / 20000);
+
+	while (tries--) {
+		ret = i2c_smbus_read_byte_data(client,
+						APDS9999_REG_MAIN_STATUS);
+		if (ret < 0)
+			return ret;
+		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
+			break;
+		fsleep(20000);
+	}
+
+	if (tries < 0)
+		return -ETIMEDOUT;
+
+	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
+
+	*counts = get_unaligned_le24(buf) & GENMASK(19, 0);
+	return 0;
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
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = apds9999_read_channel(data,
+						    APDS9999_REG_LS_DATA_GREEN_0,
+						    &counts);
+			break;
+		case IIO_INTENSITY:
+			ret = apds9999_read_channel(data, chan->address,
+						    &counts);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (ret)
+			return ret;
+		*val = (int)counts;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
+		 *
+		 * The constant 54 is derived from the datasheet table:
+		 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
+		 *   -> C = 0.180 * 3 * 100 = 54
+		 *
+		 * Expressed as IIO_VAL_INT_PLUS_NANO.
+		 */
+		gain = apds9999_gains[data->als_gain_idx];
+		itime_us = apds9999_itimes_us[data->als_res];
+
+		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
+		scale_nano = div_u64(54000000000000ULL, (u32)(gain * itime_us));
+		*val = (int)(scale_nano / NSEC_PER_SEC);
+		*val2 = (int)(scale_nano % NSEC_PER_SEC);
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
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_RED,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_RED_0,
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_GREEN,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_GREEN_0,
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BLUE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_BLUE_0,
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_IR_0,
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
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
+	if (part_id < 0)
+		return dev_err_probe(dev, part_id,
+				     "failed to read PART_ID\n");
+	if (part_id != APDS9999_PART_ID)
+		dev_info(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
+			 part_id, APDS9999_PART_ID);
+
+	ret = apds9999_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to initialize device\n");
+
+	indio_dev->name = "apds9999";
+	indio_dev->info = &apds9999_info;
+	indio_dev->channels = apds9999_channels;
+	indio_dev->num_channels = ARRAY_SIZE(apds9999_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id apds9999_id[] = {
+	{ "apds9999" },
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
+	.id_table = apds9999_id,
+};
+module_i2c_driver(apds9999_driver);
+
+MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
+MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
+MODULE_LICENSE("GPL");
