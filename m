Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5113911BC
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587626; cv=none; b=EFxOleizjP19hini5rnoS5vUf2twgLyp5EWm0PdmuAoN4nVac1ml0MpkKc3s1wlWTvD/muPxyIhgT4SF4q+1K3hnuVQZO02Qo6M8M/5213KDqzVkKvkmNpk6WWdj755CqYXCwTThqIWeW06KidYyksP2FCNMCBM9sWh78cl1+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587626; c=relaxed/simple;
	bh=nGqfVfYY2JCx+J45dYpHwoCQ+9dmAeE/pq7K+3ZJTxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYfhgOci5myNm79v1IhRCrIbmG81qjbX/k2MW/SCe78w0CCr9/9dPwWpRwLOrzenW+bJeqafr3zPBlM9DR7yPOeykPOizt95ASrV2OPKefcHnrucBgGx8AHrvoZkHPC6jdHuOaArHhDSUXC3D+0DNf966nCJ+HBrakpa5E6B8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqr7Gcwi; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqr7Gcwi"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fa10f35caso1833268d50.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788587617; x=1789192417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWT6vuIxFa0VbXgYOu6wk8NN4gVaUEvy04ZeQCq6AbQ=;
        b=eqr7Gcwih8awoF27LpAALD8xSnr5HRB/biq65JpI37/oZ0J6Pnw23O+ccyN3x3C0ri
         XWbcQXrNa9gwNhnpfK/DG03YT35QnqNoV4L/OAmOw2jB5f6OibzyzUPne2PKZWHIR5ms
         5pVN8brQoxt0L4gX0O2jHuV8AIZG/xi1CFrnesm/IHc74njQE0sgY36AeZ/wjJaYf4Iv
         xpOXHveuKFX4aPXZZ3FT4BvZbmuCcdxaqcS9G215QskSiXHeAiRouwUS2L+TkSs/hiFD
         SnnM4MAfbGTOqP4Z9q0koJhxU+QJpCHs5pQwsuQdgl7E+vBlBz/gkwI+bjHGtI26pb2j
         JfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788587617; x=1789192417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kWT6vuIxFa0VbXgYOu6wk8NN4gVaUEvy04ZeQCq6AbQ=;
        b=hH23ojStpK/bWJHNYPvvYRp3GvnuIUxBzOn+djWGUZ4w5yIskUKLJ+bhBcZK7EklV6
         ZD20jtkc8ny1Ipp7AlkyVAkE34c6lYU4obo0rR3YYuLC5VScHXdJghrl+buvHJMfuF8I
         /OfuiY8Er9kTM2yqYMb6N13Dwb6X7TRCypBv97KE04dO4ZX24UNgkXAJL4qVKPA9/mlf
         unXf1ETg5acS3LACcJ41+HTWjjA/9IRZfoarOEmoXCXz/r+WbI6Cq0reurpXADVIFowG
         A/D07KDw6yVjhzyyqf/fg6aSe7yWOj+AGzwoMmJwyAq9iUpo6dG7spdk+vzBqWbzGkEg
         w07Q==
X-Forwarded-Encrypted: i=1; AKwUvBwsm4Gp5Hok1x37A4ikjgJIhI5zUAZ059inngFHkTkneYHbEZTsUhulzod5WohnRF1OadusIxhGxsA=@vger.kernel.org
X-Gm-Message-State: AFuF++nVreoO/RFNRnGecldbVX5mjiHsJNs2+axYVGdZ3ULRrB6gMF0J
	HiaNCSEHsLE/NJXBWAmfUSr7ZNVrrK8TOQvjsjoDI3WDPZso7QtKHatA
X-Gm-Gg: AYBFou1XrpJs090msgITVldG+t/FXTluJo8xhMQPlqepHofrQ5mzhhTNfPS57Em4A+8
	5gsEvOPBiF+4hwlTQSZwRlGUoL1O4qOuhNkQLVmomfl192yVughu59V+unuxgq6uYSUzNaFChEx
	fizOLZ//e9Du4bohodB+WdwVI4qAlgq2SQj3UkcuCVDEG8COCWy9RRXbkSHOnX0Cf/6dQxG1cO4
	/aVpeZvzHCX0OP6woIHQcB6cpmMNurjFbFFxQhZd5dmnur0f52uBpFj/qLSVJp5iXdNLOer40l8
	ogXjxYLkeOq4HAufD2Q7RnmsRkc+K+nVUaxO0ppuwHaQtZihzIBOsl04i9zzIwVo6bVxffFDlS1
	KZjaLWz90CXfKGbYzS+SVnZ81ZLMSPAE7OovkCS9yPEwvsy9p/4YnwIgYPVE2cqkBX52nyBz69r
	VhZqFSMzhOsU+mw+fZ8eTTFgiY3HjOghsry5Ti0CAX23I=
X-Received: by 2002:a53:b981:0:b0:66f:c1bc:402c with SMTP id 956f58d0204a3-66fc1bc45f9mr1260180d50.89.1788587616841;
        Fri, 04 Sep 2026 22:53:36 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4914af4sm3889675d50.13.2026.09.04.22.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 22:53:36 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor driver
Date: Fri,  4 Sep 2026 22:53:26 -0700
Message-ID: <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788586814.git.marcus.yu.56@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a driver for the AMS AS7343 14-channel multi-spectral
sensor with I2C interface.

The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
via the IIO sysfs interface. Each channel's raw data is provided as a
16-bit little-endian unsigned integer.

Basic power management (suspend/resume) is supported. More complex
features such as interrupt support and configurable gain/integration
time will be added in future patches.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 MAINTAINERS                |   7 +
 drivers/iio/light/Kconfig  |  11 ++
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/as7343.c | 309 +++++++++++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/iio/light/as7343.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa5322d9f7..236102b3c28e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1430,6 +1430,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS AS7343 DRIVER
+M:	Chang Yu <marcus.yu.56@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
+F:	drivers/iio/light/as7343.c
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ef36824f312f..edbeeba9d873 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -149,6 +149,17 @@ config AS73211
 	 This driver can also be built as a module.  If so, the module
 	 will be called as73211.
 
+config AS7343
+	tristate "AMS AS7343 14-Channel Multi-Spectral Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say Y here to build support for the AMS AS7343 14-channel
+	 multi-spectral sensor.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called as7343.
+
 config BH1745
 	tristate "ROHM BH1745 colour sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 64e354c49ed8..5d0d33802519 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_APDS9999)		+= apds9999.o
 obj-$(CONFIG_AS73211)		+= as73211.o
+obj-$(CONFIG_AS7343)		+= as7343.o
 obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
 obj-$(CONFIG_BH1780)		+= bh1780.o
diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
new file mode 100644
index 000000000000..b620dd308380
--- /dev/null
+++ b/drivers/iio/light/as7343.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for AMS AS7343 14-channel multi-spectral sensor.
+ * (7-bit I2C slave address 0x39)
+ *
+ * Based on the work of:
+ *   Christian Eggers <ceggers@arri.de> (AS73211 driver)
+ *
+ * Copyright (c) 2026 Chang Yu <marcus.yu.56@gmail.com>
+ *
+ * Datasheets:
+ *   https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
+ *
+ * TODO:
+ *   - Support for configurable gain and integration time
+ *   - Interrupt support
+ *   - Add support for reading the VIS channel
+ *   - Flicker detection
+ */
+
+#include "linux/array_size.h"
+#include "linux/regmap.h"
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/stringify.h>
+
+#define AS7343_DRV_NAME "as7343"
+#define AS7343_DEVICE_ID 0x81
+
+/* AS7343 registers */
+#define AS7343_REG_ID 0x5a
+#define AS7343_REG_ENABLE 0x80
+#define AS7343_REG_ATIME 0x81
+#define AS7343_REG_CFG0 0xbf
+#define AS7343_REG_CFG1 0xc6
+#define AS7343_REG_CFG20 0xd6
+#define AS7343_REG_CONTROL 0xfa
+#define AS7343_REG_ASTATUS 0x94
+/* AS7343 data registers */
+#define AS7343_REG_DATA_FZ 0x95
+#define AS7343_REG_DATA_FY 0x97
+#define AS7343_REG_DATA_FXL 0x99
+#define AS7343_REG_DATA_NIR 0x9b
+#define AS7343_REG_DATA_F2 0xa1
+#define AS7343_REG_DATA_F3 0xa3
+#define AS7343_REG_DATA_F4 0xa5
+#define AS7343_REG_DATA_F6 0xa7
+#define AS7343_REG_DATA_F1 0xad
+#define AS7343_REG_DATA_F7 0xaf
+#define AS7343_REG_DATA_F8 0xb1
+#define AS7343_REG_DATA_F5 0xb3
+#define AS7343_REG_MAX 0xff
+
+/* AS7343 register bit masks */
+#define AS7343_ENABLE_PON BIT(0)
+#define AS7343_ENABLE_SP_EN BIT(1)
+#define AS7343_CFG0_REG_BANK BIT(4)
+#define AS7343_CFG20_AUTO_SMUX GENMASK(6, 5)
+#define AS7343_CONTROL_SW_RESET BIT(3)
+#define AS7343_CFG1_AGAIN GENMASK(4, 0)
+
+/* AS7343 settings */
+#define AS7343_INT_TIME 29 /* (29 + 1) * 2.87ms = 83.4ms */
+#define AS7343_GAIN 7 /* 64x gain */
+#define AS7343_AUTO_CHANNEL_READOUT 3 /* Automatic all-channel readout */
+
+/* AS7343 scan indices */
+#define AS7343_SCAN_INDEX_F1 0
+#define AS7343_SCAN_INDEX_F2 1
+#define AS7343_SCAN_INDEX_FZ 2
+#define AS7343_SCAN_INDEX_F3 3
+#define AS7343_SCAN_INDEX_F4 4
+#define AS7343_SCAN_INDEX_FY 5
+#define AS7343_SCAN_INDEX_F5 6
+#define AS7343_SCAN_INDEX_FXL 7
+#define AS7343_SCAN_INDEX_F6 8
+#define AS7343_SCAN_INDEX_F7 9
+#define AS7343_SCAN_INDEX_F8 10
+#define AS7343_SCAN_INDEX_NIR 11
+#define AS7343_SCAN_INDEX_TS 12
+
+#define AS7343_SCAN_MASK_ALL                                      \
+	(BIT(AS7343_SCAN_INDEX_F1) | BIT(AS7343_SCAN_INDEX_F2) |  \
+	 BIT(AS7343_SCAN_INDEX_FZ) | BIT(AS7343_SCAN_INDEX_F3) |  \
+	 BIT(AS7343_SCAN_INDEX_F4) | BIT(AS7343_SCAN_INDEX_FY) |  \
+	 BIT(AS7343_SCAN_INDEX_F5) | BIT(AS7343_SCAN_INDEX_FXL) | \
+	 BIT(AS7343_SCAN_INDEX_F6) | BIT(AS7343_SCAN_INDEX_F7) |  \
+	 BIT(AS7343_SCAN_INDEX_F8) | BIT(AS7343_SCAN_INDEX_NIR))
+
+static const unsigned long as7343_scan_masks[] = { AS7343_SCAN_MASK_ALL, 0 };
+
+#define AS7343_CHAN(_chan) \
+	{ \
+	.type = IIO_INTENSITY, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.address = AS7343_REG_DATA_##_chan, \
+	.extend_name = __stringify(_chan), \
+	.scan_index = AS7343_SCAN_INDEX_##_chan, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_LE, \
+	}, \
+}
+
+static const struct iio_chan_spec as7343_channels[] = {
+	AS7343_CHAN(F1),
+	AS7343_CHAN(F2),
+	AS7343_CHAN(FZ),
+	AS7343_CHAN(F3),
+	AS7343_CHAN(F4),
+	AS7343_CHAN(FY),
+	AS7343_CHAN(F5),
+	AS7343_CHAN(FXL),
+	AS7343_CHAN(F6),
+	AS7343_CHAN(F7),
+	AS7343_CHAN(F8),
+	AS7343_CHAN(NIR),
+	IIO_CHAN_SOFT_TIMESTAMP(AS7343_SCAN_INDEX_TS),
+};
+
+/**
+ * struct as7343_data - Instance data for one AS7343
+ * @client: I2C client.
+ * @regmap: Register map.
+ */
+struct as7343_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static int as7343_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct as7343_data *data = iio_priv(indio_dev);
+	unsigned int low, high;
+	unsigned int unused;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		/* Reading ASTATUS latches all data registers to this read.
+		 * We don't care about the returned saturation/gain status for
+		 * now.
+		 */
+		ret = regmap_read(data->regmap, AS7343_REG_ASTATUS, &unused);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(data->regmap, chan->address, &low);
+		if (ret < 0)
+			return ret;
+		ret = regmap_read(data->regmap, chan->address + 1, &high);
+		if (ret < 0)
+			return ret;
+		*val = (high << 8) | low;
+		return IIO_VAL_INT;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info as7343_info = {
+	.read_raw = as7343_read_raw,
+};
+
+static const struct regmap_config as7343_regmap_config = {
+	.name = "as7343",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AS7343_REG_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int as7343_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct as7343_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	indio_dev->name = AS7343_DRV_NAME;
+	indio_dev->info = &as7343_info;
+	indio_dev->channels = as7343_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = as7343_scan_masks;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret < 0)
+		return ret;
+	/* Power on */
+	ret = regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
+			      AS7343_ENABLE_PON);
+	if (ret < 0)
+		return ret;
+
+	/* Need to set REG_BANK to 1 before we can access ID */
+	ret = regmap_set_bits(data->regmap, AS7343_REG_CFG0,
+			      AS7343_CFG0_REG_BANK);
+	if (ret < 0)
+		return ret;
+	/* Check device ID */
+	ret = regmap_read(data->regmap, AS7343_REG_ID, &val);
+	if (val != AS7343_DEVICE_ID)
+		return -ENODEV;
+	/* Unset REG_BANK */
+	ret = regmap_clear_bits(data->regmap, AS7343_REG_CFG0,
+				AS7343_CFG0_REG_BANK);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the SMUX to readout all channels */
+	ret = regmap_update_bits(data->regmap, AS7343_REG_CFG20,
+				 AS7343_CFG20_AUTO_SMUX,
+				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
+					    AS7343_AUTO_CHANNEL_READOUT));
+	if (ret < 0)
+		return ret;
+
+	/* Set 83.4ms integration time and x64 gain for now */
+	ret = regmap_write(data->regmap, AS7343_REG_ATIME, AS7343_INT_TIME);
+	if (ret < 0)
+		return ret;
+	ret = regmap_update_bits(data->regmap, AS7343_REG_CFG1,
+				 AS7343_CFG1_AGAIN,
+				 FIELD_PREP(AS7343_CFG1_AGAIN, AS7343_GAIN));
+	if (ret < 0)
+		return ret;
+
+	/* Start measurements */
+	ret = regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
+			      AS7343_ENABLE_SP_EN);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int as7343_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct as7343_data *data = iio_priv(indio_dev);
+
+	return regmap_clear_bits(data->regmap, AS7343_REG_ENABLE,
+				 AS7343_ENABLE_SP_EN);
+}
+
+static int as7343_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct as7343_data *data = iio_priv(indio_dev);
+
+	return regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
+			       AS7343_ENABLE_SP_EN);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume);
+
+static const struct of_device_id as7343_of_match[] = {
+	{ .compatible = "ams,as7343" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, as7343_of_match);
+
+static const struct i2c_device_id as7343_id[] = {
+	{ .name = "as7343" },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, as7343_id);
+
+static struct i2c_driver as7343_driver = {
+	.driver = {
+		.name           = AS7343_DRV_NAME,
+		.of_match_table = as7343_of_match,
+		.pm             = pm_sleep_ptr(&as7343_pm_ops),
+	},
+	.probe      = as7343_probe,
+	.id_table   = as7343_id,
+};
+module_i2c_driver(as7343_driver);
+
+MODULE_AUTHOR("Chang Yu <marcus.yu.56@gmail.com>");
+MODULE_DESCRIPTION("AS7343 14 Channel Multi-Spectral Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

