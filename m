Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3B3BD246
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003949; cv=none; b=pkOJ0PUWZrf6giHs2rgEJgSlWtIvkigdNzgbLMySs7gGLEJRTve/g58CSRsTblxJqQjzAzIpe+G2ZAB/RBbSZEVwm/3D1Iu23anSPvC/wpnZ2ByXUNCU/xhciM1dDqWhRB3jnGECOm3PC1DIUWSEdZUhssQHE22rCHAEiEO+Lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003949; c=relaxed/simple;
	bh=8RP8hjW4VDfZEU1tUxmC1/PLmC3fWj+fga4j8PVk7Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyuTcsafCQ3WCldy+M4lH5YV0mAtRFi51F9JwrhsM4ozTTJQJ3R7GUwMV7GQs1FatSWEID2ZqID0paUORpWSQRaugQLWN1TraLTFeAnfaLhIaHQN5vVG/TfT+lpkSUYBws+86zBu69+n5ymJkcyyK+Hd/QcjTlOwLz78wsnwF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNxaGxbk; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNxaGxbk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso68716a91.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003947; x=1791608747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAGPdvN8aJ75vNgjKZdgvlbx+tr64DtLC12gCxg6siU=;
        b=MNxaGxbki1Ijqc3WJzRmd/fELCZyIn1uvB/aWkzk941zXOP3z4+08ii0N2NRb0wf3Q
         4HJEDGjhObASpwsRI/tqs7be1S0Oy3/7VSKHkmyCwWs97+x+6IyC5BpgZvm1kj/vgLgp
         5SRtoDkxsT95P017DXkivtc3VHG4qYflwZpHEf3bXr4y6KNh+/txeSsvvhGr+Il8Hg+d
         FDeCTxf12Yhk5x4wbuDoyMGqDbmzH+G09PLpLmutdds1Rlc5iWyk68fK+6WT6k8hlVvA
         p1u73YWu1DMzKqB2KP4RhHyyWm0whai2zsAn/hpI++L7F3Tup1sjH5yVmXV4Fb1GZGCj
         Cubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003947; x=1791608747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAGPdvN8aJ75vNgjKZdgvlbx+tr64DtLC12gCxg6siU=;
        b=QxGTg98WwWv9GpHFHCjIyLcSKHuDGevrNbLM5lioQMVsVcjhpEns7tkC3Xpzv5GE8+
         ArVOrvIdjFGCanrfaXnmg4KLo2gE/BgckSjbqyuqW9UCBL822fgWlGSi7qSzmNCw+0yc
         jCk1MtQnL7tbspgjf5GOHk5I6T9RVDUWNhzj201Zcz0kJz+TI7GSsC35XP/ijpkDS2y9
         L4LqW7zdqmXPgTDlbelHSbYHEhcmQOY4dgeo92YqZ3UIrF3Zo3v77yS6kYOQZCTPyNnc
         07hJ/r1OOmTxgp2bcVT9qvMeKrrDNvto5qb2XDI99Ad/TfuWOVVvYj9DOd+Fey2ZW73e
         UR5A==
X-Forwarded-Encrypted: i=1; AKwUvByUgFEWxImFDZBG8i2rXEKek6Y1BlFMYCPBlVsmZY/iTYKPeZ3gkX96nkKfUVWepOLP02B21W2Op1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRkTWwDw1yvoyjnXAvfgoq8k/wkhGICC6UDuY1m01gsQxDCzMt
	BSZ2M8ty+UdRfK8YeXRwixE5Zl8tYglfgZf7ovA4iydg48crGhQJuZXM
X-Gm-Gg: AYBFou2CmXiFGERqSdUFbrxO/e8Vl22szNAZmCTUh5wZ35JprpWlDl+jfx5G2/Xp/SC
	7+NKnIsrQI9vbZ+FrnP7UCNLjl6xfjDKrKhcxZtFtmax4BZNKlADufrSyXsGRz7ofKbupH5WDLc
	SqBkJe7t4Nr/tT2XSuBdZvjMTFv8EWtjWFVyvEwtbnlD36YRKboMcu1qSyXbDLHHUEt4BsCfQ5p
	zS4t3GOe3spZv0bA5kea2n6SpxUlPgujtQnAUc2ZtAmC18Xl0JkGWR8EgVeGC64nWXCQQHOzAAC
	yW7kbfjRkHupXksG1oM6tifAxXzEiHwZMgDATzOC7dJPXt6C0zuXsm6eIhgZD0V2h8lwLUUUsrU
	ehqoGS0pBTFX5r0suDdXTtfOAZ7RG87ektWL1lDEmKBvN5HBZGG+/ypuSyBc/60/N3C0e57bqZN
	U69eq4Qy7pPVHBeEe+UQEfSYbYgaaz9K5gdcgxtUm7iq6jVUNod8f1vIy9rC7SnIPL4227V6rfp
	C/z3LUqWuEd7HrF83gXyw==
X-Received: by 2002:a17:90b:1808:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3a6ce9854e9mr3996215a91.63.1791003947330;
        Fri, 02 Oct 2026 22:05:47 -0700 (PDT)
Received: from l (ec2-13-230-214-216.ap-northeast-1.compute.amazonaws.com. [13.230.214.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a869esm1650442a91.2.2026.10.02.22.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:05:46 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>
Subject: [PATCH 2/2] iio: proximity: Add driver for Vishay VCNL36829
Date: Sat,  3 Oct 2026 13:04:53 +0800
Message-ID: <20261003050453.413700-3-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003050453.413700-1-lyf98405@gmail.com>
References: <20261003050453.413700-1-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

Add an IIO driver for the Vishay VCNL36829 proximity sensor with
integrated VCSEL, connected over I2C.

At probe the driver enables the vdd and vddio supplies, waits for the
sensor to power up, checks the device ID, configures the VCSEL current
and photodiodes, and turns the proximity engine on. The sensor is put
back into shutdown when the device is removed.

The following attributes are exposed:
  - in_proximity0_raw
  - in_proximity_integration_time
  - in_proximity_integration_time_available

The datasheet is available at:
https://www.vishay.com/docs/80580/vcnl36829um.pdf

Assisted-by: Claude:claude-opus-5-5 checkpatch dtschema
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
 MAINTAINERS                       |   1 +
 drivers/iio/proximity/Kconfig     |  11 ++
 drivers/iio/proximity/Makefile    |   1 +
 drivers/iio/proximity/vcnl36829.c | 278 ++++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+)
 create mode 100644 drivers/iio/proximity/vcnl36829.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e6ef84b49..5612b9371 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28758,6 +28758,7 @@ VISHAY VCNL36829 PROXIMITY SENSOR DRIVER
 M:	Liu Yufei <lyf98405@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
+F:	drivers/iio/proximity/vcnl36829.c
 
 VISHAY VEML3235 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index bb77fad2a..f3cec799d 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -233,6 +233,17 @@ config VCNL3020
 	  To compile this driver as a module, choose M here: the
 	  module will be called vcnl3020.
 
+config VCNL36829
+	tristate "Vishay VCNL36829 proximity sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VCNL36829
+	  proximity sensor with integrated VCSEL.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vcnl36829.
+
 config VL53L0X_I2C
 	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 4352833dd..8a65e42fb 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SX9360)		+= sx9360.o
 obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
+obj-$(CONFIG_VCNL36829)		+= vcnl36829.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
 obj-$(CONFIG_VL53L1X_I2C)	+= vl53l1x-i2c.o
 obj-$(CONFIG_AW96103)		+= aw96103.o
diff --git a/drivers/iio/proximity/vcnl36829.c b/drivers/iio/proximity/vcnl36829.c
new file mode 100644
index 000000000..c9958a594
--- /dev/null
+++ b/drivers/iio/proximity/vcnl36829.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Vishay VCNL36829 Proximity Sensor driver
+ *
+ * Copyright (C) 2026 Liu Yufei <lyf98405@gmail.com>
+ */
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/iio/iio.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
+
+#define VCNL36829_PS_CONF1 0x00
+#define VCNL36829_PS_ON_MSK BIT(0)
+#define VCNL36829_PS_SD_MSK BIT(8)
+
+#define VCNL36829_PS_CONF2 0x01
+#define VCNL36829_PS_IT_MSK GENMASK(11, 8)
+
+#define VCNL36829_PS_CONF3 0x02
+#define VCNL36829_PS_CURRENT_EN_MSK BIT(3)
+#define VCNL36829_PS_CURRENT_MSK GENMASK(2, 0)
+#define VCNL36829_PD1_EN_MSK BIT(8)
+#define VCNL36829_PD2_EN_MSK BIT(9)
+#define VCNL36829_PD3_EN_MSK BIT(10)
+
+#define VCNL36829_PS_CONF5 0x08
+
+/* VCNL36829 Read Only Registers */
+#define VCNL36829_DATA 0xF8
+#define VCNL36829_DEV_ID    0xFA
+
+#define VCNL36829_PS_CONF5_INIT 0x00A0
+#define VCNL36829_PS_CURRENT_18MA 0x7
+#define VCNL36829_PS_INT_TIME_25 0x1
+#define VCNL36829_DEV_ID_VAL 0x29
+
+static const int vcnl36829_it_range[] = {0, 25, 0, 25, 0, 375};
+
+struct vcnl36829_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config vcnl36829_regmap_config = {
+	.name = "vcnl36829_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VCNL36829_DEV_ID,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int vcnl36829_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	int ret;
+	unsigned int reg;
+	struct vcnl36829_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(regmap, chan->address, &reg);
+		if (ret) {
+			dev_err(dev, "Data read failed: %d\n", ret);
+			return ret;
+		}
+		*val = reg;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = regmap_read(regmap, VCNL36829_PS_CONF2, &reg);
+		if (ret) {
+			dev_err(dev, "Data read failed: %d\n", ret);
+			return ret;
+		}
+		/*
+		 * PS_IT=0 (12.5us) is intentionally not exposed; the driver
+		 * uses 25us as the minimum so the step stays a clean 25us.
+		 */
+		*val = 0;
+		*val2 = FIELD_GET(VCNL36829_PS_IT_MSK, reg) * 25;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl36829_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int val,
+			       int val2, long mask)
+{
+	struct vcnl36829_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		if (val2 >= 25 && val2 <= 375 && val2 % 25 == 0)
+			return regmap_update_bits(data->regmap,
+					VCNL36829_PS_CONF2,
+					VCNL36829_PS_IT_MSK,
+					FIELD_PREP(VCNL36829_PS_IT_MSK, val2 / 25));
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl36829_read_avail(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				const int **vals, int *type, int *length,
+				long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = 6;
+		*vals = vcnl36829_it_range;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vcnl36829_info = {
+	.read_raw = vcnl36829_read_raw,
+	.write_raw = vcnl36829_write_raw,
+	.read_avail = vcnl36829_read_avail,
+};
+
+static const struct iio_chan_spec vcnl36829_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.address = VCNL36829_DATA,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_INT_TIME),
+	}
+};
+
+static void vcnl36829_shutdown_action(void *data)
+{
+	struct vcnl36829_data *vcnl36829_data = data;
+
+	regmap_update_bits(vcnl36829_data->regmap,
+			   VCNL36829_PS_CONF1,
+			   VCNL36829_PS_ON_MSK | VCNL36829_PS_SD_MSK,
+			   FIELD_PREP(VCNL36829_PS_ON_MSK, 0) |
+			   FIELD_PREP(VCNL36829_PS_SD_MSK, 1));
+}
+
+static int vcnl36829_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct vcnl36829_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+
+	int ret;
+	unsigned int reg;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "I2C adapter doesn't support plain I2C\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &vcnl36829_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Regmap setup failed\n");
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	indio_dev->name = "vcnl36829";
+	indio_dev->info = &vcnl36829_info;
+	indio_dev->channels = vcnl36829_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vcnl36829_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd\n");
+
+	ret = devm_regulator_get_enable(dev, "vddio");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vddio\n");
+
+	fsleep(3000);
+
+	ret = regmap_read(regmap, VCNL36829_DEV_ID, &reg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read device ID\n");
+	if ((reg & 0xFF) != VCNL36829_DEV_ID_VAL)
+		return dev_err_probe(dev, -ENODEV,
+				     "Unknown device ID 0x%x\n", reg);
+
+	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF2,
+				 VCNL36829_PS_IT_MSK,
+				 FIELD_PREP(VCNL36829_PS_IT_MSK, VCNL36829_PS_INT_TIME_25));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not configure PS_IT\n");
+
+	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF3,
+				 VCNL36829_PS_CURRENT_EN_MSK |
+				 VCNL36829_PS_CURRENT_MSK |
+				 VCNL36829_PD1_EN_MSK |
+				 VCNL36829_PD2_EN_MSK |
+				 VCNL36829_PD3_EN_MSK,
+				 FIELD_PREP(VCNL36829_PS_CURRENT_EN_MSK, 1) |
+				 FIELD_PREP(VCNL36829_PS_CURRENT_MSK, VCNL36829_PS_CURRENT_18MA) |
+				 FIELD_PREP(VCNL36829_PD1_EN_MSK, 1) |
+				 FIELD_PREP(VCNL36829_PD2_EN_MSK, 1) |
+				 FIELD_PREP(VCNL36829_PD3_EN_MSK, 1));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not configure VCSEL/PD\n");
+
+	ret = regmap_write(regmap, VCNL36829_PS_CONF5, VCNL36829_PS_CONF5_INIT);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not set PS_CONF5\n");
+
+	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF1,
+				 VCNL36829_PS_ON_MSK | VCNL36829_PS_SD_MSK,
+				 FIELD_PREP(VCNL36829_PS_ON_MSK, 1) |
+				 FIELD_PREP(VCNL36829_PS_SD_MSK, 0));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not set initial config\n");
+
+	ret = devm_add_action_or_reset(dev, vcnl36829_shutdown_action, data);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id vcnl36829_id_table[] = {
+	{ .name = "vcnl36829" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vcnl36829_id_table);
+
+static const struct of_device_id vcnl36829_of_match[] = {
+	{ .compatible = "vishay,vcnl36829" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, vcnl36829_of_match);
+
+static struct i2c_driver vcnl36829_driver = {
+	.probe = vcnl36829_probe,
+	.id_table = vcnl36829_id_table,
+	.driver = {
+		.name = "vcnl36829",
+		.of_match_table = vcnl36829_of_match,
+	},
+};
+module_i2c_driver(vcnl36829_driver);
+
+MODULE_DESCRIPTION("Vishay VCNL36829 proximity sensor driver");
+MODULE_AUTHOR("Liu Yufei <lyf98405@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.53.0

