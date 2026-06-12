Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454E3DA5D0
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304433; cv=none; b=lQb5i69zUR5aOTV5ge5h5ggg559ZWB1cWszGrNA1m0K3udnnJiwq3nB+Ks0UoD/4ONM4hzl0u26mPgBqxl3mT9nkYj8GuO+RSolhJ+LjrxFdMFtlXLwgwJmGwmCtasr1ulW0Zz7w7HhHZrVVxJrhNQjYs//Kt6+2pS8greJSe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304433; c=relaxed/simple;
	bh=NHmxEW1VAOQTaADVOi1H5PcUtnYuYgJqH2KdvWzEtTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uN6JXhgar9U+bAXGPr/kN+vSrjX4VTvvsiouv4N1AyDSrGuO3lMYnZFe5+hKkCS/qraR94W6OlbJNZz2Cg0PRyvpJ7M9knt25We2cUrqm8ZeH6IoBQHYdJME3yKA1LK2prIjQSUo6wyz2w05lpoqq4rFRMRDhLNVo6aTZz8SJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkRoXugi; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkRoXugi"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59eb57ed4cbso622573e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781304430; x=1781909230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hAztssjgIXYC6uTNfU+QUwyMd8gmFgP4iwbOtxi2p0=;
        b=DkRoXugi9JXZXDkgkY8zgVIOGdG4R0tWDGSsc7Nivgd/YiK2HZqj/C9Y000kX7gTdg
         mFBlKO9fYv1I8K0WWHHP/l1e7c92i0rDZ2FLM2H7npQIkPnSY44KrcfUd9GxQvHgF29U
         KZBD0z1FcXifVd55LicWrkU+3M3xkyzOdp9pNSVQqbVEQGh0/iLvUOstoSYKDPLMSe9w
         aADmSrEJBkQlH+MNC3sdfjPPXo0lq+PmpaQaD8e3A2ugOb0W8i/Ndk/8Ezwv7m3z2G1p
         l+w3+jTNdN7Omo199YLfYlSbwYOCWIUE79LGCoqcxZvMxPMDLnYgt0I+OcpQ2kIkrx2N
         hf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304430; x=1781909230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hAztssjgIXYC6uTNfU+QUwyMd8gmFgP4iwbOtxi2p0=;
        b=gEiX9fdSkWwIzGG1C5GDcI550W72tShuKFS275b24hdm0ttqf6kMx6OdgDJz8vxJMV
         buFdw8iIvJJk5477GJwDiAS+gr/NL1lmGWZx2ArTIQTLXFyUPHADksxsLcETJ/1i65EL
         405J20ZdJScM8CRWPNBFhahoWWEbmNHzsIW2pYxWauB29ssvqwWZaW9rTRGXhh2qfODe
         5DDzhdRkejLhltXascWMUdsMDBpqh+oX6US7f+bL5PGB1mxWJZxFoC/EmEHaJ1MRnwof
         bxvS1yYaEh6hG+WtzYtga8bIqJUZ5iSa7AizNsq5NL9DLjNZcQp1o2QES4WXim4so296
         u8Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8bLW/JMZAnvdfWJxxzroEUyFJmE+T6Yn7QNDDWU0IBG8/Tk3zfe5lzKzB7W7PHdstXUfS0OxeSsHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+NT+4akEbOTPOYnamQYEINT0hUn79rxsZPQA0+K564MzkygT
	E/U3/m5AI5BOJHS5U6eW9akdyGXnv2JFLTVDix4jJSANs+yRJVfyNKKX
X-Gm-Gg: Acq92OHajJM1Lj8Gvff2a8kPYRP3QwrZ6Rde2a20nUvM9884uLxZqJuds1rKkYLyyxx
	ktSM9OmzYG4mXpsFqxw4ewVCJmw8xO9ovKpTUuLXfw1OGjSGUU82zHCXISR0fylOPacmQw2K2xP
	Sl5vlD3AP/8a1nwZRW0gHD75/mokXUqAX/LYmcpfSAHOAYv1IOdkdBXc4uWWuqkzhI1b6mR58QE
	kyLGyuM1KjmXTdjgmxWKgidS2VTJHaNWqX3ymEY335xYbMYnP8gOrme8USms4mLIut7unVfjUHL
	rajwSH+UVKpmKglLVYdHVm0iJ3rCzoBoiUfgGTxnDSKAYM3blnMm9Qrl0ayGyDpVBpOIK9+2EbQ
	alVydusJEGFtRO+smo/hAAxnMvRzrpIcCULoFrnYrY6u16P/KmGMF1MQBp8wv3iY86PMD4o0w3E
	3ALiBANV+EGNJDZ71OYykV4Q==
X-Received: by 2002:a05:6122:4001:b0:59e:f988:51a with SMTP id 71dfb90a1353d-5bb6bfa37c7mr3249779e0c.1.1781304430047;
        Fri, 12 Jun 2026 15:47:10 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691fd8adsm4244553e0c.13.2026.06.12.15.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:47:09 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 12 Jun 2026 17:46:23 -0500
Subject: [PATCH 5/5] iio: adc: Add ti-ads1263-adc2 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ads126x-v1-5-894c788d03ed@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
In-Reply-To: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21254; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=NHmxEW1VAOQTaADVOi1H5PcUtnYuYgJqH2KdvWzEtTA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFk6PUn3b/HbqbG2MxWZzXd45lvhe6lQKsJRh/nRrnsTj
 hxefVeoo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACbyI5jhv9fNDQaSkhPkyxZu
 emdYLee2pKjiQbSOo9NV35zuuT9k9RkZ/udUMtQ0fHBlu3TuSqTc89l5Ina+W3+wsJhd9l70LIm
 ZFwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The TI ADS1263 includes an auxiliary, 24-bit, delta-sigma ADC (ADC2).
ADC2 operation is independent of ADC1, with independent selections of
input channel, reference voltage, sample rate, and channel gain

Add support for this ADC as an independent IIO device, through the
auxiliary bus API.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                       |   2 +
 drivers/iio/adc/Kconfig           |  13 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/ti-ads1262.c      | 147 ++++++++++++
 drivers/iio/adc/ti-ads1262.h      |  39 ++++
 drivers/iio/adc/ti-ads1263-adc2.c | 470 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 672 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b874add5c924..53ef8fdb5cc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26675,6 +26675,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1263-adc2.yaml
 F:	drivers/iio/adc/ti-ads1262.c
+F:	drivers/iio/adc/ti-ads1262.h
+F:	drivers/iio/adc/ti-ads1263-adc2.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b6c35d0c88ed..bb3a3f7742de 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1809,6 +1809,19 @@ config TI_ADS1262
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1262.
 
+config TI_ADS1263_ADC2
+	tristate "Texas Instruments ADS1263 auxiliary ADC (ADC2) driver"
+	depends on TI_ADS1262
+	select AUXILIARY_BUS
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1263
+	  auxiliary ADC (ADC2).
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1263-adc2.
+
 config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index e0653820081e..9120c9392176 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1262) += ti-ads1262.o
+obj-$(CONFIG_TI_ADS1263_ADC2) += ti-ads1263-adc2.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS131M02) += ti-ads131m02.o
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index b33505e7fdc7..1a4b2f934d43 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -14,10 +14,12 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/compiler_attributes.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/math.h>
@@ -42,6 +44,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include "ti-ads1262.h"
+
 /* Commands */
 #define ADS1262_OPCODE_NOP			0x00
 #define ADS1262_OPCODE_RESET			0x06
@@ -221,6 +225,8 @@
 #define ADS1262_CALIB_WORD_MAX		((int)(GENMASK(22, 0)))
 #define ADS1262_CALIB_WORD_MIN		(-ADS1262_CALIB_WORD_MAX - 1)
 
+static DEFINE_IDA(ads1262_ida);
+
 struct ads1262_channel {
 	/* MODE0 */
 	u8 conv_delay:4;
@@ -1123,6 +1129,143 @@ static irqreturn_t ads1262_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ads1263_adc2_enable(struct ads1263_adc2_ctx *ctx,
+			       const struct ads1263_adc2_channel *chan)
+{
+	struct ads1262 *st = ctx->chip;
+
+	/*
+	 * The ads1263_adc2_channel struct can be written directly to the chip's
+	 * configuration registers (ADC2CFG, ADC2MUX) in a single transfer, so
+	 * it's necessary to assert it's size (2 bytes).
+	 */
+	static_assert(sizeof(*chan) == 2);
+
+	guard(mutex)(&ctx->chan_lock);
+
+	return regmap_bulk_write(st->regmap, ADS1262_ADC2CFG_REG, chan,
+				 sizeof(*chan));
+}
+
+static int ads1263_adc2_start(struct ads1263_adc2_ctx *ctx)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_cmd(st, ADS1262_OPCODE_START2);
+}
+
+static int ads1263_adc2_stop(struct ads1263_adc2_ctx *ctx)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_cmd(st, ADS1262_OPCODE_STOP2);
+}
+
+static int ads1263_adc2_read(struct ads1263_adc2_ctx *ctx, __be32 *val)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_read_data_command(st, ADS1262_OPCODE_RDATA2, val);
+}
+
+static void ads1262_aux_device_destroy(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void ads1262_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct ads1263_adc2_ctx *ctx =
+		container_of(adev, struct ads1263_adc2_ctx, adev);
+	struct fwnode_handle *node = adev->dev.fwnode;
+
+	mutex_destroy(&ctx->chan_lock);
+	kfree(ctx->channels);
+	ida_free(&ads1262_ida, adev->id);
+	kfree(ctx);
+	fwnode_handle_put(node);
+}
+
+static int ads1262_aux_device_setup(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct ads1263_adc2_channel *chans;
+	struct auxiliary_device *adev;
+	struct ads1263_adc2_ctx *ctx;
+	struct fwnode_handle *node;
+	int id, ret;
+
+	node = device_get_named_child_node(dev, "adc");
+	if (!node)
+		return 0;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx) {
+		ret = -ENOMEM;
+		goto out_node_put;
+	}
+
+	id = ida_alloc(&ads1262_ida, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto out_free_adc2;
+	}
+
+	chans = kcalloc(st->num_channels, sizeof(*chans), GFP_KERNEL);
+	if (!chans) {
+		ret = -ENOMEM;
+		goto out_free_id;
+	}
+
+	for (unsigned int i = 0; i < st->num_channels; i++) {
+		chans[i].negative_input = st->channels[i].negative_input;
+		chans[i].positive_input = st->channels[i].positive_input;
+	}
+
+	ctx->chip = st;
+	ctx->num_channels = st->num_channels;
+	ctx->channels = chans;
+	ctx->enable = ads1263_adc2_enable;
+	ctx->start = ads1263_adc2_start;
+	ctx->stop = ads1263_adc2_stop;
+	ctx->read = ads1263_adc2_read;
+	mutex_init(&ctx->chan_lock);
+
+	adev = &ctx->adev;
+	adev->name = "ads1263_adc2";
+	adev->id = id;
+	adev->dev.release = ads1262_aux_device_release;
+	adev->dev.parent = dev;
+	device_set_node(&adev->dev, no_free_ptr(node));
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		goto out_free_channels;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, ads1262_aux_device_destroy, adev);
+
+out_free_channels:
+	kfree(chans);
+out_free_id:
+	ida_free(&ads1262_ida, id);
+out_free_adc2:
+	kfree(ctx);
+out_node_put:
+	fwnode_handle_put(node);
+
+	return ret;
+}
+
 static int ads1262_gpiochip_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct ads1262 *st = gpiochip_get_data(gc);
@@ -1967,6 +2110,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_aux_device_setup(st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/adc/ti-ads1262.h b/drivers/iio/adc/ti-ads1262.h
new file mode 100644
index 000000000000..98697d771da3
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1262.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Texas Instruments ADS1262 ADC driver
+ *
+ * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#ifndef _ADS1262_H_
+#define _ADS1262_H_
+
+#include <linux/auxiliary_bus.h>
+#include <linux/types.h>
+
+struct ads1263_adc2_channel {
+	/* ADC2CFG */
+	u8 gain:3;
+	u8 refmux:3;
+	u8 data_rate:2;
+
+	/* ADC2MUX */
+	u8 negative_input:4;
+	u8 positive_input:4;
+};
+
+struct ads1263_adc2_ctx {
+	struct auxiliary_device adev;
+	struct ads1262 *chip;
+	/* Protects channel state */
+	struct mutex chan_lock;
+	struct ads1263_adc2_channel *channels;
+	unsigned int num_channels;
+	int (*enable)(struct ads1263_adc2_ctx *ctx,
+		      const struct ads1263_adc2_channel *chan);
+	int (*start)(struct ads1263_adc2_ctx *ctx);
+	int (*stop)(struct ads1263_adc2_ctx *ctx);
+	int (*read)(struct ads1263_adc2_ctx *ctx, __be32 *val);
+};
+
+#endif
diff --git a/drivers/iio/adc/ti-ads1263-adc2.c b/drivers/iio/adc/ti-ads1263-adc2.c
new file mode 100644
index 000000000000..d21f08bbd9ee
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1263-adc2.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Texas Instruments ADS1263 auxiliary ADC (ADC2) driver
+ *
+ * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/align.h>
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "ti-ads1262.h"
+
+/* ADC2CFG REF2 constants */
+#define ADS1263_ADC2_REF2_INTER			0
+#define ADS1263_ADC2_REF2_COUNT			5
+
+struct ads1263_adc2 {
+	struct iio_dev *indio_dev;
+	struct ads1263_adc2_ctx *ctx;
+	u32 vref_uV;
+	u32 refmux;
+};
+
+static const int ads1263_adc2_gain_avail[] = {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+static const int ads1263_adc2_data_rate_avail[] = {
+	10, 100, 400, 800
+};
+
+static const unsigned long ads1263_adc2_latency_us[] = {
+	121000, 31200, 8710, 4970
+};
+
+static const struct iio_chan_spec ads1263_adc2_iio_voltage_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = true,
+	.scan_type = {
+		.format = IIO_SCAN_FORMAT_SIGNED_INT,
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+					     BIT(IIO_CHAN_INFO_SAMP_FREQ),
+};
+
+static int ads1263_adc2_channel_hot_reload(struct ads1263_adc2 *st,
+					   const struct iio_chan_spec *chan)
+{
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	unsigned long i;
+	int ret;
+
+	/* Hot reloading is only required on buffer mode */
+	if (!iio_device_try_claim_buffer_mode(st->indio_dev))
+		return 0;
+
+	i = find_first_bit(st->indio_dev->active_scan_mask,
+			   iio_get_masklength(st->indio_dev));
+	if (i != chan->scan_index) {
+		iio_device_release_direct(st->indio_dev);
+		return 0;
+	}
+
+	ret = ctx->enable(ctx, &ctx->channels[chan->scan_index]);
+
+	iio_device_release_buffer_mode(st->indio_dev);
+
+	return ret;
+}
+
+static int ads1263_adc2_channel_read(struct iio_dev *indio_dev,
+				     struct ads1263_adc2_channel *chan_data,
+				     __be32 *val)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct device *dev = &ctx->adev.dev;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev->parent, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = ctx->enable(ctx, chan_data);
+	if (ret)
+		return ret;
+
+	ret = ctx->start(ctx);
+	if (ret)
+		return ret;
+
+	ret = ctx->stop(ctx);
+	if (ret)
+		return ret;
+
+	fsleep(ads1263_adc2_latency_us[chan_data->data_rate]);
+
+	return ctx->read(ctx, val);
+}
+
+static int ads1263_adc2_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct ads1263_adc2_channel *chan_data;
+	u8 realbits;
+	__be32 raw;
+	u32 cnv;
+	int ret;
+
+	chan_data = &st->ctx->channels[chan->scan_index];
+	realbits = chan->scan_type.realbits;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads1263_adc2_channel_read(indio_dev, chan_data, &raw);
+		if (ret)
+			return ret;
+
+		cnv = be32_to_cpu(raw);
+		cnv >>= chan->scan_type.shift;
+		*val = sign_extend32(cnv, realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		u64 divd, divr, tmp, rem;
+
+		mutex_lock(&ctx->chan_lock);
+		divd = st->vref_uV;
+		divr = BIT_ULL(chan_data->gain + realbits - 1) * 1000;
+		mutex_unlock(&ctx->chan_lock);
+
+		tmp = div64_u64(divd * 1000000000ULL, divr);
+		*val = div64_u64_rem(tmp, 1000000000ULL, &rem);
+		*val2 = rem;
+
+		return IIO_VAL_INT_PLUS_NANO;
+
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&ctx->chan_lock);
+		*val = ads1263_adc2_gain_avail[chan_data->gain];
+		mutex_unlock(&ctx->chan_lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&ctx->chan_lock);
+		*val = ads1263_adc2_data_rate_avail[chan_data->data_rate];
+		mutex_unlock(&ctx->chan_lock);
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1263_adc2_read_avail(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, const int **vals,
+			int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*type = IIO_VAL_INT;
+		*vals = ads1263_adc2_gain_avail;
+		*length = ARRAY_SIZE(ads1263_adc2_gain_avail);
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1263_adc2_data_rate_avail;
+		*length = ARRAY_SIZE(ads1263_adc2_data_rate_avail);
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1263_adc2_write_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int val, int val2, long mask)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct ads1263_adc2_channel *chan_data;
+	unsigned int i;
+
+	chan_data = &ctx->channels[chan->scan_index];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		for (i = 0; i < ARRAY_SIZE(ads1263_adc2_gain_avail); i++) {
+			if (val == ads1263_adc2_gain_avail[i])
+				break;
+		}
+		if (i == ARRAY_SIZE(ads1263_adc2_gain_avail))
+			return -EINVAL;
+
+		mutex_lock(&ctx->chan_lock);
+		chan_data->gain = i;
+		mutex_unlock(&ctx->chan_lock);
+
+		return 0;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(ads1263_adc2_data_rate_avail); i++) {
+			if (val == ads1263_adc2_data_rate_avail[i])
+				break;
+		}
+		if (i == ARRAY_SIZE(ads1263_adc2_data_rate_avail))
+			return -EINVAL;
+
+		mutex_lock(&ctx->chan_lock);
+		chan_data->data_rate = i;
+		mutex_unlock(&ctx->chan_lock);
+
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ads1263_adc2_channel_hot_reload(st, chan);
+}
+
+static int ads1263_adc2_write_raw_get_fmt(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static const struct iio_info ads1263_adc2_iio_info = {
+	.read_raw = ads1263_adc2_read_raw,
+	.read_avail = ads1263_adc2_read_avail,
+	.write_raw = ads1263_adc2_write_raw,
+	.write_raw_get_fmt = ads1263_adc2_write_raw_get_fmt,
+};
+
+static int ads1263_adc2_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct device *dev = &ctx->adev.dev;
+	unsigned long i;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev->parent);
+	if (ret)
+		return ret;
+
+	i = find_first_bit(indio_dev->active_scan_mask,
+			   iio_get_masklength(indio_dev));
+	ret = ctx->enable(ctx, &ctx->channels[i]);
+	if (ret)
+		goto out_runtime_autosuspend;
+
+	ret = ctx->start(ctx);
+	if (ret)
+		goto out_runtime_autosuspend;
+
+	return 0;
+
+out_runtime_autosuspend:
+	pm_runtime_put_autosuspend(dev->parent);
+
+	return ret;
+}
+
+static int ads1263_adc2_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct device *dev = &ctx->adev.dev;
+
+	ctx->stop(ctx);
+	pm_runtime_put_autosuspend(dev->parent);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ads1263_adc2_buffer_ops = {
+	.preenable = ads1263_adc2_buffer_preenable,
+	.postdisable = ads1263_adc2_buffer_postdisable,
+	.validate_scan_mask = iio_validate_scan_mask_onehot,
+};
+
+static irqreturn_t ads1263_adc2_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct {
+		__be32 conv;
+		aligned_s64 ts;
+	} scan = {};
+	int ret;
+
+	ret = ctx->read(ctx, &scan.conv);
+	if (ret)
+		goto out_notify_done;
+
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
+
+out_notify_done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1263_adc2_channels_setup(struct iio_dev *indio_dev)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct device *dev = &st->ctx->adev.dev;
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct iio_chan_spec *chns;
+	unsigned int i;
+
+	/* Account for the timestamp channel */
+	chns = devm_kcalloc(dev, ctx->num_channels + 1, sizeof(*chns),
+			    GFP_KERNEL);
+	if (!chns)
+		return -ENOMEM;
+
+	for (i = 0; i < ctx->num_channels; i++) {
+		guard(mutex)(&ctx->chan_lock);
+
+		ctx->channels[i].refmux = st->refmux;
+
+		chns[i] = ads1263_adc2_iio_voltage_template;
+		chns[i].scan_index = i;
+		chns[i].channel = ctx->channels[i].positive_input;
+		chns[i].channel2 = ctx->channels[i].negative_input;
+		chns[i].differential = true;
+	}
+
+	chns[i] = (struct iio_chan_spec)
+		IIO_CHAN_SOFT_TIMESTAMP(ctx->num_channels - 1);
+	chns[i].scan_index = i;
+
+	indio_dev->num_channels = ctx->num_channels + 1;
+	indio_dev->channels = chns;
+
+	return 0;
+}
+
+static int ads1263_adc2_regulator_setup(struct ads1263_adc2 *st)
+{
+	struct device *dev = &st->ctx->adev.dev;
+	const char *reg_id, *propname;
+	u32 refmux = 0;
+	int ret;
+
+	propname = "ti,refmux";
+	ret = device_property_read_u32(dev, propname, &refmux);
+	if (refmux >= ADS1263_ADC2_REF2_COUNT)
+		return dev_err_probe(dev, ret, "%s out of range\n", propname);
+	st->refmux = refmux;
+
+	if (refmux == ADS1263_ADC2_REF2_INTER) {
+		/* The internal voltage reference is 2.5 V */
+		st->vref_uV = 2500000;
+		return 0;
+	}
+
+	reg_id = "vref";
+	ret = devm_regulator_get_enable_read_voltage(dev, reg_id);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get regulator %s\n",
+				     reg_id);
+	st->vref_uV = ret;
+
+	return 0;
+}
+
+static int ads1263_adc2_probe(struct auxiliary_device *auxdev,
+			      const struct auxiliary_device_id *id)
+{
+	struct ads1263_adc2_ctx *ctx =
+		container_of(auxdev, struct ads1263_adc2_ctx, adev);
+	struct device *dev = &auxdev->dev;
+	struct iio_dev *indio_dev;
+	struct ads1263_adc2 *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->ctx = ctx;
+	st->indio_dev = indio_dev;
+
+	ret = ads1263_adc2_regulator_setup(st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = (char *)id->driver_data;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads1263_adc2_iio_info;
+	ret = ads1263_adc2_channels_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads1263_adc2_trigger_handler,
+					      &ads1263_adc2_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct auxiliary_device_id ads1263_adc2_auxiliary_match[] = {
+	{ .name = "ti_ads1262.ads1263_adc2",
+	  .driver_data = (kernel_ulong_t)"ads1263_adc2" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, ads1263_adc2_auxiliary_match);
+
+static struct auxiliary_driver ads1263_adc2_driver = {
+	.name = "ads1263_adc2",
+	.probe = ads1263_adc2_probe,
+	.id_table = ads1263_adc2_auxiliary_match,
+};
+module_auxiliary_driver(ads1263_adc2_driver);
+
+MODULE_DESCRIPTION("Texas Instruments ADS1263 auxiliary ADC (ADC2) driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

-- 
2.54.0

