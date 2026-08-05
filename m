Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9D3793AA
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908135; cv=none; b=Okl1lwx37x5k+/DwLuKfiTMRAyNRJLwpWZY/RlPLBsq9GHDiQgBuSDUfBz5sUaVCK93WRuMBpAhDKYuZ7BRKdpBoc/O0lzfcvHZqEC4dVh5JQ1D6iNzXElf5XwAIQP4VA84UPJapXNeHrT/0EwS2qQgOzg20nQ+eEs5PjNuNJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908135; c=relaxed/simple;
	bh=mh9Vc4GD7cjIRTzPZeqOurJ6XGAGOWFO88DhFXJJq1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAhau5TUuegGqE7DrXhw+wia8UgEmHZoBwvdV4ytihbaBl11sJq7wPuqdMgxmsAIUovkGcWfJI3X5EOap9n2QvPRYJMhe/Jwm/qT1aqwEOtx2wdoo18xdPjaB1gNy4qeWg1cssQ+mqvotdr1/CXqEOo1GiAmhZGa8lKVY+MQjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJIvmDQf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJIvmDQf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caea3f742bso9261345ad.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908133; x=1786512933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zu/v7gJ1LYt5IfuF9GnMxPtWyVEdaTkgDZLaiUaUYMI=;
        b=hJIvmDQfYjtjNGjMnKVHgUpb/lUbqlAndnUPF2ODBuY3JBF2HsSxozx+uiHF6FWQKZ
         gFylNAAIpUmEwK70o6SYX+zYN6lulLMxoG+xmLolgUtLfUDtrBZvQgtT49kBjYbqhkbt
         GLUhHuGLW1FZNib0S2CkDoce5Psx5VFdLrsIu+mWru3hBb0e5bWwUiONIhQcqTomierN
         +ISPxPj+enkuiCt0BlrIb+6JXdr9/SmaFwbElDl6r/e5UXfyyTlBy6+Ox+obV6dO7o7n
         fwh+jamIeZDzxoyPqMsq8iGt2kJ/+CjfDcG6y/RypmSS1rO9ls5s0UshRj9E6FSqvk9g
         T3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908133; x=1786512933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zu/v7gJ1LYt5IfuF9GnMxPtWyVEdaTkgDZLaiUaUYMI=;
        b=nKfefodU/vV4sSosUWZ4xhakvL8nWa0iN+TDwcFrChI9bSYk6ULw0YRd6dWPvQb0Ha
         VL3UCu0NuHE6ipRfzD3T+t1iRAy74AW1dm6yc56KKC8Sen4fGaZbtwPfkPCsXs9k3eCT
         myuiFRDr4zveqbNB5PXOITISlKBv+SyHEUZr15rHouJHPo8Bx/u5W+OGBmdH3Oecu5JF
         E5lrWHKUiZcJiLy/bl+dT9EETuM9292NkceaQ0iiObf2pGjJbkdWYGcWNnRza4huUS8O
         u+7W0as3SJLo8iIvm5bko3XXSWAO3rEph7H0cKOFFXgVsT7eUSOYX9tiPUO2GzaTYSJI
         jpIA==
X-Gm-Message-State: AOJu0YyrPSws0nuSq5iN61zXMxJa8fCFRUucL3Jb7CsSX6kSjzu9wEgj
	6ywvz5PKGcky3wcJgh/jqvaBZWeMP4GkqKF2TXzdzjzCgFQ8N6RMn0O4
X-Gm-Gg: AR+sD10x9F5Dc95/1UZSrNdeVoirJt9vCaxfMU6+zM1Xmhw+0+iSPWoKMWhHmLjVxGd
	8CCo1Ki7JhnxFHgFFK42cqrAW4AgNmOVEiX81O0bHk5OG2EywdKk3vvSNPGy+1v6Scn1HcMSLj3
	B1KLMSuHPYGVbFvewFFbODmrfLxBJXXE4Iz9PYTfcXIH4b+YxfjusdHTHpWxPU+KwAvjnoN6kHl
	Y398hbK3zNfUkSRze5Acc7HjzMURYkNbKhugXiKyAFa0K2cMiYxmXfNOMcxO3HB8DNjq+ucK2xC
	rdlACpjAl/Zag/YYRIZLc/NdCayWot2t8vE7b3SPemTY3xsNDPiImRv52Vl2uoONQwCPyWKmWcM
	PdYpHOA+vvRkno2ZDEVcH7AG5kpYbhtLK71oifkbGQp7m4nlEycWgP+YQH4RjRO0M6X79+ULG5Q
	SARyxTOWSYiixHGB2hDzU7xi/apcE/hZqznjYEh7+q3g0VwMViAjwypXrvb+hQsrfYOPx/RFdaf
	FgELbIE2AfxZao2cKaGhsJYzO+315kJ9chtkL4=
X-Received: by 2002:a17:903:384d:b0:2d0:3412:a3f0 with SMTP id d9443c01a7336-2d0ca962498mr46521685ad.19.1785908133352;
        Tue, 04 Aug 2026 22:35:33 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm14307245ad.64.2026.08.04.22.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:35:32 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 05 Aug 2026 13:38:21 +0800
Subject: [PATCH v3 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-ti-ads112c04-driver-v3-2-49f436829e01@gmail.com>
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
In-Reply-To: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13673;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=mh9Vc4GD7cjIRTzPZeqOurJ6XGAGOWFO88DhFXJJq1M=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqcsxN3hVT89cn0FB9dEsyFqPgVZAZmt7s63Rrc
 4ZL7YkLSBiJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCanLMTQAKCRClg0K3CVbE
 gXjHCACb+BnU4LZF5CbtwRiUAWS5iG8y0WBYZD2mHVTu7cZ8dvX8Nkn3uCJlq66+4bLBwr9nDhw
 AFpR94xoZfFdU5w11kGC29DMpHolcxGaSn+tYgCw6GkXOIpvcpn+qkr/yTMPS0G6UUW2w1SOAK9
 yHztD0Bfw6L24QNE6VcEPB2kJAOW+vWjfJcrqHHvg852vIVvU9l8BSb5dXLLp5m+YNSBlsUxMZb
 eHiuBWeElfHOc7EmQ1F0WIJYicrq910GfgcpyANUC9tGHM1nQ8zttDVcD0BVQpDR7EQtqBu7VPK
 Xt8iwK2Z2g2Z1/HO4ZLuVCP5ts5CbusI7FRarNAr33oOn1C8
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
delta-sigma ADCs.

The driver implements:
- Single-shot conversions using the IIO raw read interface.
- Dynamic parsing of single-ended and differential channels from
  device tree child nodes.
- Hardware interrupt support via the DRDY pin, falling back to
  software polling if no IRQ is provided.
- Scale calculation based on the internal 2.048V reference.
- Dynamic reference voltage scaling via the regulator subsystem
  (refp-supply/refn-supply), falling back to the internal 2.048V
  reference if not specified.
- Hardware reset fallback using GPIO.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/Kconfig        |  10 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c04.c | 423 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3755a81c1efd..402e841bc083 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1789,6 +1789,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS112C04
+	tristate "Texas Instruments ADS112C04 ADC"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments
+	  ADS112C04 (16-bit) I2C analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads112c04.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 707dd708912f..ebf9d4047a5a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C04)	+= ti-ads112c04.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
new file mode 100644
index 000000000000..64af866f615d
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c04.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Texas Instruments ADS112C04 16-bit I2C ADC driver
+ *
+ * Copyright (c) 2026 Kyle Hsieh <kylehsieh1995@gmail.com>
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads112c04.pdf
+ * Based on TI Reference Code and standard Linux IIO framework.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define ADS112C04_CMD_RESET         0x06
+#define ADS112C04_CMD_START_SYNC    0x08
+#define ADS112C04_CMD_POWERDOWN     0x02
+#define ADS112C04_CMD_RDATA         0x10
+#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
+#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
+
+#define ADS112C04_REG_CONFIG0       0x00
+#define ADS112C04_REG_CONFIG1       0x01
+#define ADS112C04_REG_CONFIG2       0x02
+#define ADS112C04_REG_CONFIG3       0x03
+
+#define ADS112C04_CONFIG0_MUX         GENMASK(7, 4)
+#define ADS112C04_CONFIG0_PGA_BYPASS  BIT(0)
+#define ADS112C04_CONFIG2_DRDY        BIT(7)
+
+struct ads112c04_state {
+	struct i2c_client *client;
+	/* Protects concurrent ADC reads and device configuration */
+	struct mutex lock;
+	struct completion completion;
+	struct regulator *vref_reg;
+	int vref_mV;
+	u8 config0;
+	u8 config1;
+};
+
+static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte(client, cmd);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, ADS112C04_CMD_RREG(reg));
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, ADS112C04_CMD_WREG(reg), val);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_wait_for_data(struct ads112c04_state *st)
+{
+	int ret, err;
+	u8 val;
+
+	if (st->client->irq > 0) {
+		/* Timeout is 100ms (slowest data rate is 20 SPS) */
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(100));
+		if (!ret)
+			return -ETIMEDOUT;
+		return 0;
+	}
+
+	err = read_poll_timeout(ads112c04_read_reg, ret,
+				(ret < 0 || (val & ADS112C04_CONFIG2_DRDY)),
+				1000, 100 * USEC_PER_MSEC, false,
+				st->client, ADS112C04_REG_CONFIG2, &val);
+
+	if (ret < 0)
+		return ret;
+
+	return err;
+}
+
+static int ads112c04_read_data(struct ads112c04_state *st, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(st->client, ADS112C04_CMD_RDATA);
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(be16_to_cpu(ret), 15);
+
+	return 0;
+}
+
+static int ads112c04_get_adc_result(struct ads112c04_state *st,
+				    struct iio_chan_spec const *chan,
+				    int *val)
+{
+	u8 new_config0;
+	int ret;
+
+	new_config0 = st->config0 & ~ADS112C04_CONFIG0_MUX;
+	new_config0 |= FIELD_PREP(ADS112C04_CONFIG0_MUX, chan->address);
+
+	if (st->config0 != new_config0) {
+		ret = ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, new_config0);
+		if (ret < 0)
+			return ret;
+		st->config0 = new_config0;
+	}
+
+	reinit_completion(&st->completion);
+
+	ret = ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC);
+	if (ret < 0)
+		return ret;
+
+	ret = ads112c04_wait_for_data(st);
+	if (ret < 0)
+		return ret;
+
+	return ads112c04_read_data(st, val);
+}
+
+static int ads112c04_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct ads112c04_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ads112c04_get_adc_result(st, chan, val);
+		mutex_unlock(&st->lock);
+
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mV;
+		*val2 = 15;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t ads112c04_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ads112c04_state *st = iio_priv(indio_dev);
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ads112c04_info = {
+	.read_raw = ads112c04_read_raw,
+};
+
+static void ads112c04_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ads112c04_parse_channels(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *channels;
+	u32 num_channels, pair[2];
+	int ret, i = 0;
+
+	num_channels = device_get_named_child_node_count(dev, "channel");
+	if (!num_channels)
+		return -EINVAL;
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		struct iio_chan_spec *spec = &channels[i];
+
+		if (fwnode_property_present(child, "excitation-channels") ||
+		    fwnode_property_present(child, "reference-sources"))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+					     "advanced channel properties are not supported yet\n");
+
+		spec->type = IIO_VOLTAGE;
+		spec->indexed = 1;
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
+
+		if (fwnode_property_present(child, "single-channel")) {
+			ret = fwnode_property_read_u32(child, "single-channel", &pair[0]);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read single-channel property\n");
+
+			if (pair[0] > 3)
+				return dev_err_probe(dev, -EINVAL,
+						     "single-channel must be 0-3\n");
+
+			spec->channel = pair[0];
+			spec->address = 0x08 + pair[0];
+		} else if (fwnode_property_present(child, "diff-channels")) {
+			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, 2);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read diff-channels property\n");
+
+			if (pair[0] > 3 || pair[1] > 3)
+				return dev_err_probe(dev, -EINVAL,
+						     "diff-channels must be 0-3\n");
+
+			spec->channel = pair[0];
+			spec->channel2 = pair[1];
+			spec->differential = 1;
+
+			if (pair[0] == 0 && pair[1] == 1)
+				spec->address = 0x00;
+			else if (pair[0] == 0 && pair[1] == 2)
+				spec->address = 0x01;
+			else if (pair[0] == 0 && pair[1] == 3)
+				spec->address = 0x02;
+			else if (pair[0] == 1 && pair[1] == 0)
+				spec->address = 0x03;
+			else if (pair[0] == 1 && pair[1] == 2)
+				spec->address = 0x04;
+			else if (pair[0] == 1 && pair[1] == 3)
+				spec->address = 0x05;
+			else if (pair[0] == 2 && pair[1] == 3)
+				spec->address = 0x06;
+			else if (pair[0] == 3 && pair[1] == 2)
+				spec->address = 0x07;
+			else
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid diff-channels combination\n");
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+					     "channel node must have single-channel or diff-channels\n");
+		}
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = i;
+
+	return 0;
+}
+
+static int ads112c04_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct ads112c04_state *st;
+	struct gpio_desc *reset_gpio;
+	int ret, refp_mV = 2048;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	init_completion(&st->completion);
+
+	indio_dev->name = "ads112c04";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads112c04_info;
+
+	/* Forward compatibility checks for unimplemented DT properties */
+	if (device_property_present(dev, "refn-supply") ||
+	    device_property_present(dev, "ti,refp-refn-resistor-ohms"))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "refn-supply and external resistors are not supported yet\n");
+
+	ret = ads112c04_parse_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
+
+	st->vref_reg = devm_regulator_get_optional(dev, "refp");
+	if (IS_ERR(st->vref_reg)) {
+		ret = PTR_ERR(st->vref_reg);
+		if (ret == -ENODEV)
+			st->config1 = 0x00;
+		else
+			return ret;
+
+	} else {
+		ret = regulator_enable(st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, ads112c04_regulator_disable,
+					       st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0)
+			return ret;
+
+		refp_mV = ret / (MICRO / MILLI);
+		st->config1 = 0x02;
+	}
+
+	st->vref_mV = refp_mV;
+
+	/* Power-On Reset (POR) delay */
+	fsleep(50000);
+
+	/* Requesting OUT_HIGH asserts the active-low reset pin immediately */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	if (reset_gpio) {
+		fsleep(1000);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
+		if (ret < 0)
+			return ret;
+	}
+
+	fsleep(1000);
+
+	/* Bypass PGA for now to allow full-scale single-ended measurements */
+	st->config0 = ADS112C04_CONFIG0_PGA_BYPASS;
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
+	if (ret)
+		return ret;
+
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
+	if (ret)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_irq(dev, client->irq,
+				       ads112c04_irq_handler,
+				       0,
+				       indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id ads112c04_id[] = {
+	{ .name = "ads112c04" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads112c04_id);
+
+static const struct of_device_id ads112c04_of_match[] = {
+	{ .compatible = "ti,ads112c04" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads112c04_of_match);
+
+static struct i2c_driver ads112c04_driver = {
+	.driver = {
+		.name = "ads112c04",
+		.of_match_table = ads112c04_of_match,
+	},
+	.probe = ads112c04_probe,
+	.id_table = ads112c04_id,
+};
+module_i2c_driver(ads112c04_driver);
+
+MODULE_AUTHOR("Kyle Hsieh <kylehsieh1995@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS112C04 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

