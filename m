Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9D348C70
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416362; cv=none; b=S6jRV5iBVn8Zu/6mLNvn8fEQ3KJVCbrJAWtyHvA7QsI9/WH+Whs7DeYsLAy3Mlzgqdmn1JlYiOS++2GZIMSBofWZZSQw0nDoZEc1oM93H9mYi9vbcdwseU0+MIta07FWg7L8oluOUaM2FHneJ6F9AaUeUtvOYciZHc6YVKt7TQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416362; c=relaxed/simple;
	bh=f3WOfaCsiSdcBgUSB+PdQ7v8ScPebFBDtn+vzR4wI+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfS917CM3GSZC2wdODGNwIqeIToifl3CMm5GID5iy5AHbZB0Oxx0gg5f23MRkZXc/URPb1vrtMyY0NrD82hsIifyU4CGorQUeRsnAWkMpaJOTid08CLgRfKCXQLI0gNXVa3qWMrp+Kd6NU0Dje9Z6aOvUwVnAdCeQqhex5wXS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYVMsTZC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVMsTZC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so25969345ad.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786416351; x=1787021151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcHZXKYEl5buDnF5eCEZqTUNRWzf9SOm45D0Aau+YBI=;
        b=XYVMsTZCRfMzAcPSYYcPbgQcP6QYyPnp9PbVpyJ88VcQUV1hYggaXJaFwnyx/RWpl+
         C9FoWKwHjYD0UcXEbzrRWL1PeYIf5IhH7fCEMTXqrYYbEkGHlQcWrHS+jVfGaf7UDqHs
         LgBvu1YshfBndpVfWlo8XZoE2WK1mQ3qsn7R9i27jEXDJdqRWcBVgTo5CfFZjXWd/Kmq
         iN3Wc2XxcMy/WNfGshLK7bd5iBX86hL9ZJrv6hbCXer0PcGgjRruuMk8gNocCQ/r+J/u
         2Ud5lvxqyxYG1gXgFpsdveVVlPr0p/y1O2bFa4WFHA1nnTqJZAFJMDpsLf5tnemaKOv9
         VxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786416351; x=1787021151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcHZXKYEl5buDnF5eCEZqTUNRWzf9SOm45D0Aau+YBI=;
        b=mGMLutkeOLoEond6GiBnSbPMrzGM7Xzrxshke+HEGrrgnwALnK8zTE3TZtOHEcwi6I
         Ehh3NSGMz8l3l86O4RItHApaGCzTrDIvbCXiuGS5Mtrtcc+vgN2J4MxRXJKPqZdS9XTN
         pQ9ivGgjb0rHOUx8+fxhhYu3B0xM0HhVQQ3QCFMmh9U5AxOneV18VAug+pBP1y+8Qk8Q
         DcnT9LtT1SIJZ0i1J+0RJzRo3cxNtJ7ma6//PWHtDhR7454XBm2U4UgLoY3n4vEXVVda
         lHmujHcuaHuYoiQXjEMbCE+ZtniGMS+4Bt3iUenRgZsJhPDYWlUJ5eYOsS5hlRXlfxcA
         Qasg==
X-Gm-Message-State: AOJu0YxMhvCfBfN776jamN7vNsZQsN9cUUxHu9w0Hkyx79c+rCrCsJew
	MSVNeLJKRtSzBP/WIeIeC2rOYTt7Ls12ukM8hJ3gqo4kcm6R1gDe1cKb
X-Gm-Gg: AR+sD10w+EZDghQSgh3cXAAH1R1fA9jlujTtu0YEb1WzJ0meViD4VfERvNuL2S5p+nc
	WzXwnRsu4K8+aQ9sevM2Th7zLosWUp5onr23nbs3b5p/d41vLa4xmy4Ll7XaJT9tj/ewPmKhDAg
	CyRGVEyeHsLCJqXy4emkxlQhPNw4NoO7Z1ZxKqsxdxRdETUSutJvLGxM8Vt8O/bpEEJ5SbdczTn
	RYfEt9NZ01av5e7iBNdGthbtYJuI6hfINw43DSIxsX1LFnW3yltBnOpBuxOpjIcDhQMXQQ77yqO
	Pilzn7+THGcrvUzCtDeomc0iWxRY6cwDAhpGDLdIm8GlhMwbzsu5xHjAmjmoSQzANUDn9GjKIp5
	22pWYZ24Ud0ztorEnpc6LGG4IptDuRVI5YxCvQGJ0KlAeQf+1sPHyEQpidpwAOtCvibUB5JlH/0
	ziFgIw/vkRnhikFn94GbM1w6HBeOaBgZEXk3BuBUnLQdXY/VGFpaIGNBpeeilj5CJBgeBNmCbVg
	JYIohKMmsIi24wvq0Z7VzLp7NXp
X-Received: by 2002:a17:902:ef46:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d3178c5461mr2928135ad.11.1786416351035;
        Mon, 10 Aug 2026 19:45:51 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d31623091dsm470185ad.77.2026.08.10.19.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:45:50 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 11 Aug 2026 10:48:38 +0800
Subject: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
In-Reply-To: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14590;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=f3WOfaCsiSdcBgUSB+PdQ7v8ScPebFBDtn+vzR4wI+M=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqeo2JP4Ok03DWiy5q1IAvUpOcipc05qorkmB7V
 D0PaBAaPDqJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCanqNiQAKCRClg0K3CVbE
 gV9AB/9pqP5R/onmJ0gxbzGUrM4sfeaLo3UhJbP18At7cdmtRVmTIt/z6l0L0zRWKLc2gEPIl7e
 oLQqrJV/Z/IykfmsiIHaW427M48lbhLwGRJ6C8NGMxAgP/lTE3wUaOJjQVHLL4af+1avcTi5zJX
 wCEnLxIccoVi8+j8RtPZc+/YU+bjWfZS/iY7xsL8mZbGt4AJUn2K4QzHmLlaj3kltoMP5gqzAQk
 AK1zDrBKviJh6Zfy4LdzE+UZpkzvEPbeqYw00ueEUqKAwNCbU8vAAwsPc2D/a77IxnkAyTPf/PW
 Ew97kmf8HCDSNJP6mPqrXJV0ZZNWVfpdqKSPjWZumNIO6T6v
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
- Reference voltage scaling via the regulator subsystem (refp-supply),
  falling back to the internal 2.048V reference if not specified.
  refn-supply is not yet supported.
- Hardware reset fallback using GPIO.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 MAINTAINERS                    |   1 +
 drivers/iio/adc/Kconfig        |  10 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c04.c | 425 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 437 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 417d74b6d6cc..f51fbda9d4b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26992,6 +26992,7 @@ M:	Kyle Hsieh <kylehsieh1995@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
+F:	drivers/iio/adc/ti-ads112c04.c
 
 TI ADS112C14 ADC DRIVER
 M:	David Lechner <dlechner@baylibre.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 990e7b3e7212..0ee50828f9e4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1817,6 +1817,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS112C04
+    tristate "Texas Instruments ADS112C04 ADC"
+    depends on I2C
+    help
+      If you say yes here you get support for Texas Instruments
+      ADS112C04 (16-bit) I2C analog to digital converters.
+
+      This driver can also be built as a module. If so, the module will be
+      called ti-ads112c04.
+
 config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..d8acf2831fd2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C04) += ti-ads112c04.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112c04.c
new file mode 100644
index 000000000000..3a775da2ae23
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c04.c
@@ -0,0 +1,425 @@
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
+#include <linux/string.h>
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
+	int vref_mV;
+	u8 config0;
+	u8 config1;
+	bool has_refp;
+};
+
+static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
+{
+	return i2c_smbus_write_byte(client, cmd);
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
+	return i2c_smbus_write_byte_data(client, ADS112C04_CMD_WREG(reg), val);
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
+
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
+	ret = i2c_smbus_read_word_swapped(st->client, ADS112C04_CMD_RDATA);
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(ret, 15);
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
+	new_config0 = st->config0;
+	FIELD_MODIFY(ADS112C04_CONFIG0_MUX, &new_config0, chan->address);
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
+	ret = ads112c04_read_data(st, val);
+	if (st->client->irq > 0)
+		enable_irq(st->client->irq);
+
+	return ret;
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
+	disable_irq_nosync(irq);
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ads112c04_info = {
+	.read_raw = ads112c04_read_raw,
+};
+
+static int ads112c04_parse_channels(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct ads112c04_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	u32 num_channels, pair[2];
+	int ret, i = 0;
+
+	num_channels = device_get_named_child_node_count(dev, "channel");
+	if (!num_channels)
+		return dev_err_probe(dev, -EINVAL, "no channel subnodes found\n");
+
+	if (num_channels > 12)
+		return dev_err_probe(dev, -EINVAL,
+				     "num of channel nodes exceeds 12\n");
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		struct iio_chan_spec *spec = &channels[i];
+
+		if (fwnode_property_present(child, "excitation-channels"))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+					     "excitation-channels is not supported yet\n");
+
+		if (fwnode_property_present(child, "reference-sources")) {
+			const char *ref;
+
+			ret = fwnode_property_read_string(child, "reference-sources", &ref);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read reference-sources\n");
+
+			if ((!strcmp(ref, "external") && !st->has_refp) ||
+			    (!strcmp(ref, "internal") && st->has_refp))
+				return dev_err_probe(dev, -EINVAL,
+						     "reference-sources does not match refp-supply\n");
+		}
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
+
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = i;
+
+	return 0;
+}
+
+#define ADS112C04_VREF_INTERNAL_MV	2048
+
+static int ads112c04_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct ads112c04_state *st;
+	struct gpio_desc *reset_gpio;
+	int ret;
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
+	st->has_refp = device_property_present(dev, "refp-supply");
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
+	if (device_property_present(dev, "refp-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to get refp voltage\n");
+
+		st->vref_mV = ret / (MICRO / MILLI);
+		st->config1 = 0x02;
+	} else {
+		st->vref_mV = ADS112C04_VREF_INTERNAL_MV;
+		st->config1 = 0x00;
+	}
+
+	/* Power-On Reset (POR) delay */
+	fsleep(50 * USEC_PER_MSEC);
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

