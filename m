Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F173EF0AF
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182628; cv=none; b=CuslwrQmrP7iEjnUyT/Jj7cf0aK14j1RvSJTMRL/bNh7Zq1rOitY3fXZumUaZUo8ilcZwyyB8XUmaFuY+lEh05e/FoNiNRfHfK/cMuFfONyxJWBb2GSj+wf2me4k3Fx5Q1Uq4O0ZTHMuXY1VwgMj1m0Z5JUBaMt9yRagJzOetfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182628; c=relaxed/simple;
	bh=LsE9gMg/ZjoZSqMOTjDQZ6clVe+C++edHHzp4Rk9fzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jF2E0//crXyaTYHcjpIS2zsLGFGbQ+oJ0m5ugAwXcrkRnQckREJu9gd1bE/eDr68SmBVuR4jwWlIj2yetGoNBEmR4a4D7mLi47eSpMpfpIWmPSfoMMdZEwB99aRFqVt7jleLtE1WZRfkq+xw/aqg7kOqswDxJ6Nsd9R04QwdB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djmKps9C; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djmKps9C"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso492513466b.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182624; x=1779787424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MrhsM+b7G8Ye5IB+UasesDNl7Xq7uYpN+pGD3IYiwM=;
        b=djmKps9CdiPS5UWIMt40MQkiwdiI69x1z0txGOt/SvlTYYZ4hVcORqZVQrLsvvxcSp
         MMaprG477DoKI4pe7GQbES0/9QAL5DCSVl8Bq2SXXbyOKEWVMMASRYSOF7SYJpmOKfYR
         Y0BFW7gmq9vl68jaOl2fu89eM8JpkYZup+R9GQUthfIRjFV6iE5D7TkBBmcDHcESuf2I
         /TZkAJEPNebI0ZMxMa/xQDtgoAgQK7N7caGi0zOyPPo6e1GeEfl0rEikoiFVmIJ83SD5
         BB5ulq+qtcxltM/4AyM+8azlco3oUsW8llfP3QAsOeVziuAZUHTlzX6hnqIABMuw7Ux8
         +cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182624; x=1779787424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MrhsM+b7G8Ye5IB+UasesDNl7Xq7uYpN+pGD3IYiwM=;
        b=GM6aU+HA8K6lMc/9o9M2TPc8ndx4nudMxxsf9wrOZpEs0KEg1fWHjDyRGhpxT6HQUq
         jRcssYP91BdVKJ2qO7849rmNMjdZmyZ0J8MNpI7lunQceQSYznRGV6rXZQAjU846tBfh
         K/hjHUGjuMIEhLn9nXpG3hB8ZfjlNDzM11lbaNVgUNO7UsJYlX7MX4MZkfTvarRqmn7u
         FMjiTgKZICwtZhseOAd4OZ5fA0Sgvd+kvlVCy+R5OI9EWKw0/wb9WX7P0BuaLt6L4xtH
         cy1jK5naRgd1359iki5sVHoLfo6G4heInCCTQGnHmdF+79Jy1HYsH0FLhunGDDfImt1d
         EgPQ==
X-Gm-Message-State: AOJu0YzOZKZXU+fNdTYhs8HfSENhVOmc7qxMom2vzOxZz2seiqjdyDhd
	BDH8NxVLU2kdtUp+YERmPOn6661oR3VLaGuLMr8BekFZ90rzdY4H3qUqhPbYUKMOgBI=
X-Gm-Gg: Acq92OGgEe2qWYYfYOdisoP7FJW7gZvNnPKypbsMjltfvIB2PcPR9sZNI5mXEuQ8r6G
	6Jhu+G8LTD8qN+R2tO03lvwsjBUg6ELNkE9NfG3svUm9VpF8xzGi/3FNK3lehNuAAijmtYQ3pJg
	kEjhU6ljEz2TzHO9eG+Z3GL8cjW5DqhzbmUbuwe329rV/md7suUwn2ybp1aynaGqBBHg4aVKVBw
	HJs0yCw4+Hsk9L4eLmg86Ow8Wne/q9GP7Fu5TxgVn+DAuzy0TfKC3ZbcxS8R0j1/utec6GgZIUX
	gMoYjzFD/uKb/4Cw6knCI5D+/7RYtV6F2UBkezO4RdYa5hdGMPjuWDTGrjUpBMYxEyTmHLiVbgG
	Gx9t5U9dGmeFjivJdyt1gUe2TsnGZ7BbQEV5dnx3dNiy3PnvmtS6ypjpL7dpwCwHy5NE790lYOn
	ubUuJNY4bRipeA2VODP+fT80j7Jj8NaxE264DU2w==
X-Received: by 2002:a17:907:7295:b0:bce:259:3d64 with SMTP id a640c23a62f3a-bd51795b057mr997127466b.37.1779182623822;
        Tue, 19 May 2026 02:23:43 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm6330325a12.11.2026.05.19.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:23:42 -0700 (PDT)
Date: Tue, 19 May 2026 11:23:40 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [PATCH v3 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <deb5c310f2b9780329f6210b9c2af498b8e1c42a.1779181370.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1779181370.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779181370.git.azpijr@gmail.com>

Add IIO driver for Broadcom APDS9999 ambient light sensor.

The APDS9999 is a digital proximity and RGB sensor with ALS
capability. The driver implements the ALS/Lux functionality
using the green channel, which uses optical coating technology
to approximate the human eye spectral response.

Raw IIO_INTENSITY channels are exposed for red, green, blue,
and IR so userspace can compute its own weighted lux.
Proximity (PS) and calibrated RGB color sensing are not yet
implemented.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/light/Kconfig    |  10 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/apds9999.c | 337 +++++++++++++++++++++++++++++++++++
 4 files changed, 349 insertions(+)
 create mode 100644 drivers/iio/light/apds9999.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d8d4e2eab6e..d36ab614aa53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5005,6 +5005,7 @@ M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
+F:	drivers/iio/light/apds9999.c

 BROADCOM ASP 2.0 ETHERNET DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
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
index 000000000000..938e43b39ad5
--- /dev/null
+++ b/drivers/iio/light/apds9999.c
@@ -0,0 +1,337 @@
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
+#include <linux/units.h>
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
+#define APDS9999_GAIN_1X		0
+#define APDS9999_GAIN_3X		1
+#define APDS9999_GAIN_6X		2
+#define APDS9999_GAIN_9X		3
+#define APDS9999_GAIN_18X		4
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
+	APDS9999_RES_20BIT = 0,
+	APDS9999_RES_19BIT = 1,
+	APDS9999_RES_18BIT = 2,
+	APDS9999_RES_17BIT = 3,
+	APDS9999_RES_16BIT = 4,
+	APDS9999_RES_13BIT = 5,
+	APDS9999_RES_NUM
+};
+
+static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
+	[APDS9999_RES_20BIT] = 400 * USEC_PER_MSEC,
+	[APDS9999_RES_19BIT] = 200 * USEC_PER_MSEC,
+	[APDS9999_RES_18BIT] = 100 * USEC_PER_MSEC,
+	[APDS9999_RES_17BIT] =  50 * USEC_PER_MSEC,
+	[APDS9999_RES_16BIT] =  25 * USEC_PER_MSEC,
+	[APDS9999_RES_13BIT] =   3125,
+};
+
+#define APDS9999_RATE_25_MS		0
+#define APDS9999_RATE_50_MS		1
+#define APDS9999_RATE_100_MS		2
+#define APDS9999_RATE_200_MS		3
+#define APDS9999_RATE_500_MS		4
+#define APDS9999_RATE_1000_MS		5
+#define APDS9999_RATE_2000_MS		6
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
+/*
+ * Apply power-on defaults: 18-bit / 100 ms resolution and rate,
+ * 3x gain. These match the datasheet reset values.
+ */
+static int apds9999_init(struct apds9999_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct i2c_client *client = data->client;
+	u8 regval;
+	int ret;
+
+	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->lock);
+
+	regval = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
+		 FIELD_PREP(APDS9999_LS_RATE_MASK, APDS9999_RATE_100_MS);
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE,
+					regval);
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
+	return i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
+					 APDS9999_MAIN_CTRL_LS_EN);
+}
+
+static int apds9999_read_channel(struct apds9999_data *data, u8 reg,
+				 u32 *counts)
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
+					       APDS9999_REG_MAIN_STATUS);
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
+		ret = apds9999_read_channel(data, chan->address, &counts);
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
+static const struct iio_info apds9999_info = {
+	.read_raw = apds9999_read_raw,
+};
+
+/*
+ * The green channel uses optical coating to approximate the human eye
+ * spectral response.  IIO_INTENSITY channels provide raw ADC data for
+ * red, green, blue, and IR so userspace can compute weighted lux.
+ */
+static const struct iio_chan_spec apds9999_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_GREEN_0,
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
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = APDS9999_REG_LS_DATA_IR_0,
+	},
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
+	{ .name = "apds9999" },
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

