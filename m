Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582968;
	b=W+ag6/tFMqZjU9Q6c7jetiBCraZ7TuAnEy8iyKfhvhN4IINxjwoSHRGJ3dM9CrlMUCeP
	 fJDv5lsFXNbaXQmD0wY0xfFAqNdsv3mBHrqz524Q0DUekLkhdN810wY5MjDGopDzQi6yq
	 67on5z+K86czY6fm1tzggmhjxQ2JyGjqNkdUujgFgXhWwh35SaJm8+ZU328/RoVZPhYeA
	 XFkmCFUuTE0oHESGTyuKXsiqPqojMbnfFf+vrPDDd7PUw07znHxaBTFNDvFQIqo/HpNuU
	 rBSUxGdPR0gmHQpHzervuoYuvh/HRivxDbDRcFoAoFxc213ioLraMhTjy8HzSAO2kng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582968;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Hq/oQ7mfSNCx3gIoGKwvF7PijQI8Ne7S6qe/HXs3G74=;
	b=o3blmmuklg5kVuJGqfrrfd2Sy88Gr/N2XA5AXaOslsUK0EM36VHWdgvomSynrcaxsYv/
	 lvT91z5TLN/0MRW7Q2IwuhsRPzwvU2lbRGboa0i/YGCeIvZ0cu5RRI/vi0koYwWC6+3m6
	 klOZkJJgAgW/EEk4Tyu9kaAhEiO+jRIeaC/NZAK8H7QzA3pt0iPxSh3kG1TBrwuzPYSCl
	 bG4aJFg7+cdsRop0hnuPrnPnwbbtf1hjaiBGpyyts9Sq+aanK3TeNtl7Mpw3gUR2I0ey0
	 Zmp0dusgwgMLsy3McrqWO3K6TSigJJC5zmec53PL51IjeeURAAp5KLOWTFokL2WFabg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Opcuct87;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34675606A88A
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 15:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34675606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Opcuct87
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EBBB94E415A7;
	Fri, 13 Nov 2026 15:16:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0F7460015;
	Fri, 13 Nov 2026 15:16:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACF6D11BC0545;
	Fri, 13 Nov 2026 16:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794582964; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Hq/oQ7mfSNCx3gIoGKwvF7PijQI8Ne7S6qe/HXs3G74=;
	b=Opcuct87A8mzdY5qCqIjTfVGX+jeeZ4vXPB61NhJX0qLhfutdatmyCspBXxp24xtlEFP/C
	Ac3UdHolvZFVqTtF+vPZBikHKCxcqtNhT5s/WevP0TebcDT4f2naDV1d7KjWjuzTWg/J8o
	TgqIMrAX38Fy5niH31Ky6DbkOBe767b+fJEXTYRK1Au4ljy4nG6OTgB9GbxLD2hTrrz+1h
	eq0xe1xSigBd+ezRG+XZ/kKCb3YtjNlz+ibojgXtNsPHkh9/GDFM5P5aDbfTJDaK1mTNna
	ifP1caGosuWhCFiOLy2ZLBKrfzBFhmKSl6wlQP6fTEh0LuKkOrknfEU1Qt18Qg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	Joshua Crofts <crofts@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments TLA2528 adc
Date: Fri, 13 Nov 2026 16:15:42 +0100
Message-ID: <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
channels, that can also be configured as 16-bit averaging channels.

This is a very simple driver, allowing reading raw values for each
channel. GPIO mode isn't supported for now, as well as buffered mode and
the 16-bit averaging mode.

Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  12 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-tla2528.c | 218 +++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 drivers/iio/adc/ti-tla2528.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cf3fc9bb74d..59e960d7e547 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27762,6 +27762,7 @@ TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
+F:	drivers/iio/adc/ti-tla2528.c
 
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
 M:	Puranjay Mohan <puranjay@kernel.org>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..8633267d6056 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -2016,6 +2016,18 @@ config TI_LMP92064
 	  This driver can also be built as a module. If so, the module will be called
 	  ti-lmp92064.
 
+config TI_TLA2528
+	tristate "Texas Instruments TLA2528 ADC driver"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_ADC_HELPER
+	help
+	  Say yes here to build support for Texas Instruments TLA2528
+	  12-Bit 8-Channel ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ti-tla2528.
+
 config TI_TLC4541
 	tristate "Texas Instruments TLC4541 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21dbd37..b98cded4d0c7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
+obj-$(CONFIG_TI_TLA2528) += ti-tla2528.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
 obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
new file mode 100644
index 000000000000..c02b04e19785
--- /dev/null
+++ b/drivers/iio/adc/ti-tla2528.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Texas Instruments TLA2528 ADC
+ *
+ * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
+ * Copyright (C) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Datasheet: https://www.ti.com/lit/gpn/tla2528
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/adc-helpers.h>
+#include <linux/iio/iio.h>
+
+#define TLA2528_OP_WRITE_REG		0x08
+#define TLA2528_OP_READ_REG		0x10
+
+#define TLA2528_GENERAL_CFG_ADR		0x01
+#define TLA2528_GENERAL_CFG_RST		BIT(0)
+#define TLA2528_CHANNEL_SEL_ADR		0x11
+#define TLA2528_CHANNEL_SEL_MANUAL_CHID	GENMASK(3, 0)
+#define TLA2528_AUTO_SEQ_CH_SEL_ADR	0x12
+
+#define TLA2528_NUM_CHANNELS		8
+
+struct tla2528 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	int vref_mV;
+
+	/* Protects manual channel selection */
+	struct mutex lock;
+};
+
+static bool tla2528_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == TLA2528_GENERAL_CFG_ADR;
+}
+
+static const struct regmap_config tla2528_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = TLA2528_OP_READ_REG,
+	.write_flag_mask = TLA2528_OP_WRITE_REG,
+	.max_register = TLA2528_AUTO_SEQ_CH_SEL_ADR,
+	.volatile_reg = tla2528_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
+{
+	__be16 data;
+	int ret;
+
+	guard(mutex)(&tla2528->lock);
+
+	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
+				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
+	if (ret)
+		return ret;
+
+	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(data))
+		return -EIO;
+
+	*val = be16_to_cpu(data) >> 4;
+
+	return 0;
+}
+
+static int tla2528_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct tla2528 *tla2528 = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = tla2528_read(tla2528, chan->channel, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = tla2528->vref_mV;
+		*val2 = 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+#define TLA2528_CHAN(chan) {					\
+	.type = IIO_VOLTAGE,					\
+	.channel = (chan),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.indexed = 1,						\
+}
+
+static const struct iio_chan_spec tla2528_chan_template = TLA2528_CHAN(0);
+
+static const struct iio_info tla2528_info = {
+	.read_raw = tla2528_read_raw,
+};
+
+static int tla2528_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_chan_spec *channels;
+	struct iio_dev *indio_dev;
+	struct tla2528 *tla2528;
+	int ret;
+
+	/*
+	 * We're reading the data with raw i2c reads, without passing an
+	 * address like we would for smbus-style accesses.
+	 */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	if (i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "adapter does not support clock stretching\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*tla2528));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	tla2528 = iio_priv(indio_dev);
+	tla2528->client = client;
+
+	tla2528->regmap = devm_regmap_init_i2c(client, &tla2528_regmap_config);
+	if (IS_ERR(tla2528->regmap))
+		return PTR_ERR(tla2528->regmap);
+
+	ret = devm_mutex_init(dev, &tla2528->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (ret < 0)
+		return ret;
+
+	tla2528->vref_mV = ret / (MICRO / MILLI);
+
+	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &tla2528_chan_template,
+						    TLA2528_NUM_CHANNELS - 1,
+						    &channels);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get ADC channels\n");
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = ret;
+
+	indio_dev->name = "tla2528";
+	indio_dev->info = &tla2528_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = regmap_write(tla2528->regmap, TLA2528_GENERAL_CFG_ADR,
+			   TLA2528_GENERAL_CFG_RST);
+	if (ret)
+		return ret;
+
+	fsleep(5 * USEC_PER_MSEC);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id tla2528_id[] = {
+	{ .name = "tla2528" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tla2528_id);
+
+static const struct of_device_id tla2528_of_match[] = {
+	{ .compatible = "ti,tla2528" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tla2528_of_match);
+
+static struct i2c_driver tla2528_driver = {
+	.driver = {
+		.name = "tla2528",
+		.of_match_table = tla2528_of_match,
+	},
+	.probe = tla2528_probe,
+	.id_table = tla2528_id,
+};
+module_i2c_driver(tla2528_driver);
+
+MODULE_AUTHOR("Maxime Chevallier <maxime.chevallier@bootlin.com>");
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("Texas Instruments TLA2528 ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
-- 
2.56.0

