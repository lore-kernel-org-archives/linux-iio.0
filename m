Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDB33F5A7
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466601; cv=none; b=arpKr3PedNV12Y7SKuAW9mvzCaxr68ic82m8jZoRGtPHoUuFuWmoXPfz//6Mo6rYEKkkswINNFRRHNeij0piY145o9pvgac5GY7mDxFVYZrTEnbPYNeBgiJBuZC71OFwxRBkYQeMAzyZZz6V9Wyb3DhOIkxrmxhqrOywedmH8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466601; c=relaxed/simple;
	bh=72YhNjSfveEgLSSO71fBClBC57U1DzRAHNDGo2ZzdJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6A3WfYCnup9Lbq8lcC2qBGTrsPTJy3CQ0t7OVKgARYz2cn4zs2gAzk883B//NDvGDlZVH+0seRYc7zndcl1DLeOACDaCNtZL8nnQsWDaKrn8AdtmlSdyT4awcNXy0Y5hss33Pet+ziIUvVv+JMXBfjXNKJYCCPnKVL5q5QQqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMJYILhq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMJYILhq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceae1ed204so5567075ad.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785466599; x=1786071399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/63KPYMCzI5mwidnz0A1a9s7JZY8pc8fFTfB0H3yfM=;
        b=sMJYILhqYcCcPUJu8d87R/dP+ssfm2Se1VOhY5Tz4dzENiB2flM2n7/nPkuwyeG2EX
         83tDkxN6gzAexhCPpRfP2bqu3mpfUDYdMXjgB41HnAIhGchIJWabGDlUSyyHXlTciLCM
         aOaufu6KWMWd3//6u0EuTjzWaVpR4gjDwFMYDs8TauCYVDEZSYLsr8B+DV9S07MEEjTu
         xosC54xax4R++tBOK0sT+ugtl7/4rFHM2woGCG2DpMpWnRg+FYOsPRWTcDIa/U25RVXa
         r+BGbGSZT5hJsjmRVs93CL7mXDsDeM7/JFflxe5d0g/NWYPswO/gKLWF5ltmy4nbD0nc
         +5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785466599; x=1786071399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/63KPYMCzI5mwidnz0A1a9s7JZY8pc8fFTfB0H3yfM=;
        b=E5Yhk88cSr8eEzduCMJsmoJNVEEtPumbpx43jgFOzt+IU+lgAn3Ya4SMDFr2v2Vod+
         N+DPlalJ6z+7EGL1CNMs7QZJUpGkkbOLvifCkzzatcmf1zovb/27z4Mw8OggUai0dJQm
         C0WtliTX/Pkl/RxDqLZueRw0HOaYi84Vk6sbb08MNNp3d4oUNffNITrcLHTxWZkS1YgG
         I+hhRABhqq2C1rkCGmcnTW+5DdHTdXZ5MwIgkkTtrevu6M0lsZ9fefeFdDHKev3LcGMY
         35/S4CbRLT0pAnDzaykXNwsOrd103lFx/66vlqdqEWXAe1W5IgjVP49EMQFqWhLGv5/y
         Uhmw==
X-Gm-Message-State: AOJu0Ywgp+l0kEJGmexsmAPadkmD4BrpI2rT0VrMVln5GQqX+HhovIuM
	guuzRiAqUYev2YUoKJiwPLEV69/I84CvEW3dGJawxboT1VitwCs6YCd9
X-Gm-Gg: AR+sD11uXNecmnohXChoYdS4PuyET3IVSFZ9SVrJ3kb39lpQbBhPcZ1SL5dbow75ekz
	PsOowqhPkjbNtgTTWZUW7VpnwtZ/AZQrU0EXgCkE+JD/DHUekFf23XHk7ZtJLYw+R+zTbUMx/2o
	Pk4Tptfmmey5xkgxPswwkayLC1Hxu/lmMXfl/HipeD5yAdehKl1VjQ4YPcEB/9OmLcip4/ukowK
	LOgw54vLvE2glS/f4LzGPUNTNGPmLWbUc9CMyKGADbit6qcym8A+8QJPbM4fYzKm0GTQm+YNTS5
	Wl9k/Hemh3BlimGCODglEnMCyZ4esAyY3VY/dkijbX+dkRp/qbiOYWfUSmsWupebZdKyxLBP1qr
	8NiTzecOZyw/+fnmgytsyzuHYZRmX8Xa1+39Q+khVCCB8RBxpKLvJx0RpXWy7SKMh/NQg5cMKyg
	UP44/K5ItVpc+EFSa3uWay7AkYhZsMQcLJZIjBErXFbFAnNiwi7/ZRGP7HfJ83hFuwLJvAGIDZX
	39Gy1uVhoAPbLbnDNxftA6IXs/z
X-Received: by 2002:a17:902:f70c:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2d046d6ba8bmr4615135ad.6.1785466598814;
        Thu, 30 Jul 2026 19:56:38 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0478d9da2sm753915ad.7.2026.07.30.19.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:56:37 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 31 Jul 2026 10:58:25 +0800
Subject: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
In-Reply-To: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12217;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=72YhNjSfveEgLSSO71fBClBC57U1DzRAHNDGo2ZzdJA=;
 b=owGbwMvMwMW4tNlpO2fYkUbG02pJDFk5/MHHYiN2VfLf7/gtXxGnKc0e2LA4sU0idqvZhxP7n
 guccxDoZDRmYWDkYpAVU2Q5KXesN+V5xE/DYyumwwxiZQKZwsDFKQATSc5l/6eU6ui7buu5n3sm
 erAaMP+68cG//XV1bKRB/ecjKvYFX3LO3Z7KPUfO97OSw/SAqS6bqwS8in9y5E5NT9M90/1gnVa
 zkM3EU/JlXQvux+unL/94Ud7FWfmTZOhFI1fVPW5ZFZdfH/ZoWBxTsKV+/awj/Zzt8s52T20Npd
 ak/225mSr8Z2/FCm2ph2dfryg092xkXXRKX4hree/31X2FBXeLV18PYE1b8rXmY/mlgmkVdjkMN
 tsvqBR/3uV/eUKm6ZkDjP8DTRK/yx3z3Cc820kmVEW1boVRmNwBhZNZsz/tC/Of/K3Mv8z13lT5
 fe43OmcuWGQYaNRWvN6q4HjcEjdzI6MEzeTXAZoegtLuAA==
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
 drivers/iio/adc/Kconfig        |  10 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c04.c | 378 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)

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
index 000000000000..28d3be81934f
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c04.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Texas Instruments ADS112C04 16-bit I2C ADC driver
+ * Based on TI Reference Code and standard Linux IIO framework.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/property.h>
+#include <linux/gpio/consumer.h>
+
+/* ADS112C04 Commands */
+#define ADS112C04_CMD_RESET         0x06
+#define ADS112C04_CMD_START_SYNC    0x08
+#define ADS112C04_CMD_POWERDOWN     0x02
+#define ADS112C04_CMD_RDATA         0x10
+#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
+#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
+
+/* Registers */
+#define ADS112C04_REG_CONFIG0       0x00
+#define ADS112C04_REG_CONFIG1       0x01
+#define ADS112C04_REG_CONFIG2       0x02
+#define ADS112C04_REG_CONFIG3       0x03
+
+#define ADS112C04_DRDY_MASK         BIT(7)
+#define ADS112C04_MUX_MASK          GENMASK(7, 4)
+
+struct ads112c04_state {
+	struct i2c_client *client;
+	/* Protects concurrent ADC reads and device configuration */
+	struct mutex lock;
+	struct completion completion;
+	struct regulator *vref_reg;
+	int vref_mv;
+	u8 config0;
+	u8 config1;
+};
+
+static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
+{
+	int ret = i2c_master_send(client, &cmd, 1);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	u8 cmd = ADS112C04_CMD_RREG(reg);
+	int ret;
+
+	ret = i2c_master_send(client, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(client, val, 1);
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	u8 buf[2] = { ADS112C04_CMD_WREG(reg), val };
+	int ret;
+
+	ret = i2c_master_send(client, buf, 2);
+	return ret < 0 ? ret : 0;
+}
+
+static int ads112c04_wait_for_data(struct ads112c04_state *st)
+{
+	int ret;
+	u8 val;
+
+	if (st->client->irq > 0) {
+		ret = wait_for_completion_timeout(&st->completion, msecs_to_jiffies(1000));
+		if (!ret)
+			return -ETIMEDOUT;
+		return 0;
+	}
+
+	return read_poll_timeout(ads112c04_read_reg, ret,
+				 (ret < 0 || (val & ADS112C04_DRDY_MASK)),
+				 1000, 1000000, false,
+				 st->client, ADS112C04_REG_CONFIG2, &val);
+}
+
+static int ads112c04_read_data(struct ads112c04_state *st, int *val)
+{
+	u8 cmd = ADS112C04_CMD_RDATA;
+	__be16 buf;
+	int ret;
+
+	ret = i2c_master_send(st->client, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(st->client, (u8 *)&buf, 2);
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(be16_to_cpu(buf), 15);
+	return 0;
+}
+
+static int ads112c04_get_adc_result(struct ads112c04_state *st,
+				    struct iio_chan_spec const *chan,
+				    int *val)
+{
+	int ret;
+	u8 mux, new_config0;
+
+	mux = FIELD_PREP(ADS112C04_MUX_MASK, chan->address);
+	new_config0 = (st->config0 & 0x0F) | mux;
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
+		*val = st->vref_mv;
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
+	u32 num_channels, i = 0, pair[2];
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
+		spec->type = IIO_VOLTAGE;
+		spec->indexed = 1;
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
+		spec->scan_index = i;
+
+		if (fwnode_property_present(child, "single-channel")) {
+			fwnode_property_read_u32(child, "single-channel", &pair[0]);
+			spec->channel = pair[0];
+			spec->differential = 0;
+			spec->address = 0x08 + pair[0];
+		} else if (fwnode_property_present(child, "diff-channels")) {
+			fwnode_property_read_u32_array(child, "diff-channels", pair, 2);
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
+				return -EINVAL;
+		} else {
+			return -EINVAL;
+		}
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+
+	return 0;
+}
+
+static int ads112c04_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads112c04_state *st;
+	struct gpio_desc *reset_gpio;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+
+	ret = devm_mutex_init(&client->dev, &st->lock);
+	if (ret)
+		return ret;
+
+	init_completion(&st->completion);
+
+	indio_dev->name = "ads112c04";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads112c04_info;
+
+	ret = ads112c04_parse_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(&client->dev, "avdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "failed to get avdd regulator\n");
+
+	ret = devm_regulator_get_enable(&client->dev, "dvdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "failed to get dvdd regulator\n");
+
+	st->vref_reg = devm_regulator_get_optional(&client->dev, "refp");
+	if (IS_ERR(st->vref_reg)) {
+		ret = PTR_ERR(st->vref_reg);
+		if (ret == -ENODEV) {
+			st->vref_mv = 2048;
+			st->config1 = 0x00;
+		} else {
+			return ret;
+		}
+	} else {
+		ret = regulator_enable(st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&client->dev, ads112c04_regulator_disable,
+					       st->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0)
+			return ret;
+
+		st->vref_mv = ret / 1000;
+		st->config1 = 0x02;
+	}
+
+	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	if (reset_gpio) {
+		gpiod_set_value_cansleep(reset_gpio, 1);
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
+	st->config0 = 0x01;
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
+	if (ret)
+		return ret;
+
+	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
+	if (ret)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_irq(&client->dev, client->irq,
+				       ads112c04_irq_handler,
+				       0,
+				       indio_dev->name, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "Failed to request DRDY IRQ\n");
+			return ret;
+		}
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ads112c04_id[] = {
+	{ .name = "ads112c04", .driver_data = 0 },
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

