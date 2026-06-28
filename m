Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1E372B41
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782625003; cv=none; b=e5ukHZkeSyh0rWdsz13hZuIlho/n1hevwUMcBrhiRoJBt6UDc5WY+OMm+ZR7Ks3cOUJWFDnkUA4m9LgTLFYcVmnvyZnitvT09NeUVNVGD10l8jFs+YgLQw87RNmFXUfRNm2+a+GO2YusVOeUH3AEUA9hd3s4kRknz7S+FwOv/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782625003; c=relaxed/simple;
	bh=Xnj/XsTIL7fjOLpLmlwEZgV6DZM8ZpynZ+/v2UmLG+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAhQliHYSaeO0fXd0Y01MTZGk+vIv5Q0euWMlq5wIsvPTkZPn1StgZP9HNYPe9Bj5/qNLbOYyExaE57IBKCdwBmnIvNS97RxShyltJpCvBB4cyguFxgBJ5Ng1vBZvFMU/3oYwSspd+BvgBigwaOhNlLKmxc0UxQ2taxmSC2MaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U549VrK6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U549VrK6"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bd95de6865so153217e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782625001; x=1783229801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5NIcR+OfdBHgHCGvbpDNWLP7tX9AfIqtGlJXtBOHCY=;
        b=U549VrK61iid4gj1p0komW/G7YvP6LhE94NTqNDJUYb8Rc7/Tmc7YjfGKG0cPYAsKL
         KZRr7iijgHAOjXC2xRzS7oYSvalocYhRtSYKMVmesWzcWbEd20igdf0ofdEYwyJ3ckup
         xbN0mCyVOM7E9zQy21VewAl4bmlY4TScyO2rl14Qhl91OQKx9Pg44bGujAsp14klW//y
         W6/j7vzH+TjXzGNONZjHIr82My5B3rt2T6nuRaHGX0bb7tTkZragAsTtwIbjB1MpIVMn
         oGb/jS2ikckbTZhdXO2ljPFS4SMVBfvCo1x2H4dF+PTI8ZYg2VV963p5TCGoZLrujY7i
         h1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782625001; x=1783229801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n5NIcR+OfdBHgHCGvbpDNWLP7tX9AfIqtGlJXtBOHCY=;
        b=B+jc75yVTQ27QsFPh3QqUWAa/f43l85y8FTOjqPp9eT8tj+8un8nbO2lTSZ8jsX0VO
         LLdu91A4c+Tfm6Rj6cNwS4uiHHsTLOINZ4I7WKZSgl7chGgh+Af+lPgYK2Z+vq12xM4Q
         336XFXTKcPlEXLY+gmRWynt13SCM8Ilts4mDY5VHoidpdzaZwWo9GJqLgiupMQbmMx7l
         Xp037FrPa+jigLe7K7BR+flv63X1E6Uoq6FV9hKLvRvMjkUW+SwaaUf0XRLIV3Nrj7mu
         iGGZLqWcxbupSNCbUSEUUGoBpL7eXgtp+QceNKUkA6QDqHQrWCJ5fd6NwDCH6d7362VE
         2ZkA==
X-Forwarded-Encrypted: i=1; AHgh+Rpm/cyHScLOo0qELGcfRy520Hcj2gevj5zfbGKbKII3ASLwQPUpq9QB58jRAybo3Xj/lx3GA1LrHRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8VOKnLomFy1NMtJh+fbUKibyYIGmHgOgezFql5dfaxohNO2n
	YKvmdupKNeekZd5vLhn0RtszNuN36bZnItcorwA10szePGg5JuKOEvne
X-Gm-Gg: AfdE7ckin5ASyD8eJ7rjjoX9D05OmI+JV+BKollDaDjgPctU4Q++/hTuSDfcqhKzL31
	kQnGB3OhK0lHoqH1OkoNzJ6IPMSC06MXLs+jfLSYxEHzjVBU6bvT+dDk1bfm3CRTdxJCSRMkxn9
	KELNP/r8oGSuEjAlq92KoJ843leZ03++598vX9vw9UhbEPxvUK1RcRGayHgc89iJSS5DABZctDM
	maQYytQKe7E5eSJzjNbxJU7O8jCmlyCyFKFbCM+4t+DNt/a2L0kQpA/7qrWfkd33phtPBS3hiHL
	9R57HWwtV9nTBoIRgT9a7zmooI3ohfZJlHVmvBCX7tSpad0rwKLEfT+hgLcmIg5VWIoRmQchm6b
	Ad1avSFXT8bIsUGQmdymlhGrO1f97ZhZLbfxkafsM1H9LKAQKTFlblhD6bfglCJVk6Uk0tPKrG2
	MOP2WXk12WpnpxDhuQ
X-Received: by 2002:a05:6122:45a8:b0:5a0:afff:78a6 with SMTP id 71dfb90a1353d-5bd69e059abmr5137307e0c.14.1782625000704;
        Sat, 27 Jun 2026 22:36:40 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bda2dd64c3sm229003e0c.1.2026.06.27.22.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:36:40 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 28 Jun 2026 00:36:08 -0500
Subject: [PATCH v2 7/7] iio: adc: Add ti-ads1263-adc2 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ads126x-v2-7-4b1b231325ba@gmail.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
In-Reply-To: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20434; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Xnj/XsTIL7fjOLpLmlwEZgV6DZM8ZpynZ+/v2UmLG+I=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkOm24sDxC661gavE2wc/Pn4nf/dIW/ThW/4Cr2PGmlS
 LqGaLpYRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExkqjYjQ5f3xJ7Il5fnn546
 25nR7deRT7mOhV+dr3EnCvMs3XvytxrD/4D5V0olFx99vLmO2atVdMmDJ10Xn8Xo9mzZoTl9rfr
 KnWwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The TI ADS1263 embeds a second 24-bit delta-sigma ADC (ADC2) with its
own input mux, reference, gain and sample-rate selection.

Model ADC2 as a separate IIO device on the auxiliary bus: the ti-ads1262
SPI driver instantiates the auxiliary device and exports a small set of
TI_ADS1262-namespaced helpers for the conversion and register accesses
that must go through the shared bus. ADC2 channels are derived from the
parent's configured channels.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                       |   2 +
 drivers/iio/adc/Kconfig           |  14 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/ti-ads1262.c      | 168 ++++++++++++++++-
 drivers/iio/adc/ti-ads1262.h      |  39 ++++
 drivers/iio/adc/ti-ads1263-adc2.c | 379 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 602 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d868b25f2c65bcd9..342c661f079bcf39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26929,6 +26929,8 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
 F:	drivers/iio/adc/ti-ads1262.c
+F:	drivers/iio/adc/ti-ads1262.h
+F:	drivers/iio/adc/ti-ads1263-adc2.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6051092c20b96731..ab2e8e45f3b442d6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1817,6 +1817,7 @@ config TI_ADS1262
 	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select AUXILIARY_BUS
 	help
 	  If you say yes here you get support for Texas Instruments ADS1262 and
 	  ADS1263 ADC chips.
@@ -1824,6 +1825,19 @@ config TI_ADS1262
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
index 4b1f89a2317a35f7..4215f56f525349a5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1262) += ti-ads1262.o
+obj-$(CONFIG_TI_ADS1263_ADC2) += ti-ads1263-adc2.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS131M02) += ti-ads131m02.o
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 53bc70e0c35a59da..e3acc2eb9042c40a 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -14,10 +14,10 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/compiler_attributes.h>
-#include <linux/compiler_types.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/math.h>
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -42,6 +43,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include "ti-ads1262.h"
+
 #define ADS1262_OPCODE_NOP			0x00
 #define ADS1262_OPCODE_RESET			0x06
 #define ADS1262_OPCODE_START1			0x08
@@ -144,6 +147,8 @@
 #define ADS1262_MAX_CHANNEL_COUNT		16
 #define ADS1262_XFER_BUFFER_SZ			11
 
+static DEFINE_IDA(ads1262_ida);
+
 enum {
 	ADS1262_DELAY_NO_DELAY,
 	ADS1262_DELAY_8700_NS,
@@ -1039,6 +1044,161 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+int ads1263_adc2_channel_get_scale(struct ads1263_adc2_ctx *ctx, u8 realbits,
+				   u8 gain, u8 ref_source, int *val, int *val2)
+{
+	return ads1262_calculate_scale(ctx->chip, realbits, gain, ref_source, ref_source,
+				       val, val2);
+}
+EXPORT_SYMBOL_NS_GPL(ads1263_adc2_channel_get_scale, "TI_ADS1262");
+
+int ads1263_adc2_channel_enable(struct ads1263_adc2_ctx *ctx,
+				const struct ads1263_adc2_channel *chan)
+{
+	struct ads1262 *st = ctx->chip;
+	u8 val;
+	int ret;
+
+	guard(mutex)(&ctx->chan_lock);
+
+	val = FIELD_PREP(ADS1262_ADC2CFG_GAIN2_MASK, chan->gain) |
+	      FIELD_PREP(ADS1262_ADC2CFG_REF2_MASK, chan->reference) |
+	      FIELD_PREP(ADS1262_ADC2CFG_DR2_MASK, chan->data_rate);
+	ret = regmap_update_bits(st->regmap, ADS1262_ADC2CFG_REG,
+				 ADS1262_ADC2CFG_GAIN2_MASK |
+				 ADS1262_ADC2CFG_REF2_MASK |
+				 ADS1262_ADC2CFG_DR2_MASK, val);
+
+	val = FIELD_PREP(ADS1262_ADC2MUX_MUXP2_MASK, chan->input[0]) |
+	      FIELD_PREP(ADS1262_ADC2MUX_MUXN2_MASK, chan->input[1]);
+	return regmap_update_bits(st->regmap, ADS1262_ADC2MUX_REG,
+				  ADS1262_ADC2MUX_MUXP2_MASK |
+				  ADS1262_ADC2MUX_MUXN2_MASK, val);
+}
+EXPORT_SYMBOL_NS_GPL(ads1263_adc2_channel_enable, "TI_ADS1262");
+
+int ads1263_adc2_start(struct ads1263_adc2_ctx *ctx)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_cmd(st, ADS1262_OPCODE_START2);
+}
+EXPORT_SYMBOL_NS_GPL(ads1263_adc2_start, "TI_ADS1262");
+
+int ads1263_adc2_stop(struct ads1263_adc2_ctx *ctx)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_cmd(st, ADS1262_OPCODE_STOP2);
+}
+EXPORT_SYMBOL_NS_GPL(ads1263_adc2_stop, "TI_ADS1262");
+
+int ads1263_adc2_read(struct ads1263_adc2_ctx *ctx, __be32 *val)
+{
+	struct ads1262 *st = ctx->chip;
+
+	return ads1262_dev_read_by_cmd(st, ADS1262_OPCODE_RDATA2, val);
+}
+EXPORT_SYMBOL_NS_GPL(ads1263_adc2_read, "TI_ADS1262");
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
+	struct device_node *node = adev->dev.of_node;
+
+	of_node_put(node);
+	mutex_destroy(&ctx->chan_lock);
+	kfree(ctx->channels);
+	ida_free(&ads1262_ida, adev->id);
+	kfree(ctx);
+}
+
+static int ads1262_aux_device_setup(struct ads1262 *st)
+{
+	struct device *parent = &st->spi->dev;
+	struct ads1263_adc2_channel *chans;
+	struct ads1262_channel *chan_data;
+	struct auxiliary_device *adev;
+	struct ads1263_adc2_ctx *ctx;
+	struct device_link *link;
+	int id, ret;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
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
+		chan_data = &st->channels[i];
+		chans[i].input[0] = chan_data->input[0];
+		chans[i].input[1] = chan_data->input[1];
+		chans[i].reference = chan_data->reference[2];
+	}
+
+	ctx->chip = st;
+	ctx->num_channels = st->num_channels;
+	ctx->channels = chans;
+	mutex_init(&ctx->chan_lock);
+
+	adev = &ctx->adev;
+	adev->name = "ads1263_adc2";
+	adev->id = id;
+	adev->dev.release = ads1262_aux_device_release;
+	adev->dev.parent = parent;
+	device_set_of_node_from_dev(&adev->dev, parent);
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		goto out_free_res;
+
+	link = device_link_add(&adev->dev, parent, DL_FLAG_AUTOPROBE_CONSUMER);
+	if (!link) {
+		auxiliary_device_uninit(adev);
+		return dev_err_probe(parent, -ENXIO,
+				     "Failed to add link to auxiliary device\n");
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, ads1262_aux_device_destroy, adev);
+
+out_free_res:
+	of_node_put(adev->dev.of_node);
+	mutex_destroy(&ctx->chan_lock);
+	kfree(chans);
+out_free_id:
+	ida_free(&ads1262_ida, id);
+out_free_adc2:
+	kfree(ctx);
+
+	return ret;
+}
+
 static int ads1262_get_filter_type(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan)
 {
@@ -1627,6 +1787,12 @@ static int ads1262_spi_probe(struct spi_device *spi)
 			return ret;
 	}
 
+	if (info->has_aux_adc) {
+		ret = ads1262_aux_device_setup(st);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/adc/ti-ads1262.h b/drivers/iio/adc/ti-ads1262.h
new file mode 100644
index 0000000000000000..7a94ffd1fa983f9f
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
+	u8 gain;
+	u8 reference;
+	u8 data_rate;
+	u8 input[2];
+};
+
+struct ads1263_adc2_ctx {
+	struct auxiliary_device adev;
+	struct ads1262 *chip;
+
+	/* Protects channel state */
+	struct mutex chan_lock;
+	struct ads1263_adc2_channel *channels;
+	unsigned int num_channels;
+};
+
+int ads1263_adc2_channel_get_scale(struct ads1263_adc2_ctx *ctx, u8 realbits,
+				   u8 gain, u8 ref_source, int *val, int *val2);
+int ads1263_adc2_channel_enable(struct ads1263_adc2_ctx *ctx,
+				const struct ads1263_adc2_channel *chan);
+int ads1263_adc2_start(struct ads1263_adc2_ctx *ctx);
+int ads1263_adc2_stop(struct ads1263_adc2_ctx *ctx);
+int ads1263_adc2_read(struct ads1263_adc2_ctx *ctx, __be32 *val);
+
+#endif
diff --git a/drivers/iio/adc/ti-ads1263-adc2.c b/drivers/iio/adc/ti-ads1263-adc2.c
new file mode 100644
index 0000000000000000..385531d96de11269
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1263-adc2.c
@@ -0,0 +1,379 @@
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
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
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
+static int ads1263_adc2_channel_read(struct iio_dev *indio_dev,
+				     struct ads1263_adc2_channel *chan_data,
+				     __be32 *val)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = ads1263_adc2_channel_enable(ctx, chan_data);
+	if (ret)
+		return ret;
+
+	ret = ads1263_adc2_start(ctx);
+	if (ret)
+		return ret;
+
+	ret = ads1263_adc2_stop(ctx);
+	if (ret)
+		return ret;
+
+	fsleep(ads1263_adc2_latency_us[chan_data->data_rate]);
+
+	return ads1263_adc2_read(ctx, val);
+}
+
+static int ads1263_adc2_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+	struct ads1263_adc2_channel *chan_data = &ctx->channels[chan->scan_index];
+	u8 realbits = chan->scan_type.realbits;
+	__be32 raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads1263_adc2_channel_read(indio_dev, chan_data, &raw);
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(get_unaligned_be24(&raw), realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&ctx->chan_lock);
+
+		ret = ads1263_adc2_channel_get_scale(ctx, realbits, chan_data->gain,
+						     chan_data->reference, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		guard(mutex)(&ctx->chan_lock);
+
+		*val = ads1263_adc2_gain_avail[chan_data->gain];
+
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&ctx->chan_lock);
+
+		*val = ads1263_adc2_data_rate_avail[chan_data->data_rate];
+
+		return IIO_VAL_INT;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1263_adc2_read_avail(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   const int **vals, int *type,
+				   int *length, long mask)
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
+	struct ads1263_adc2_channel *chan_data = &ctx->channels[chan->scan_index];
+	unsigned int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		for (i = 0; i < ARRAY_SIZE(ads1263_adc2_gain_avail); i++) {
+			if (val == ads1263_adc2_gain_avail[i])
+				break;
+		}
+		if (i == ARRAY_SIZE(ads1263_adc2_gain_avail))
+			return -EINVAL;
+
+		guard(mutex)(&ctx->chan_lock);
+		chan_data->gain = i;
+
+		break;
+	}
+
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		for (i = 0; i < ARRAY_SIZE(ads1263_adc2_data_rate_avail); i++) {
+			if (val == ads1263_adc2_data_rate_avail[i])
+				break;
+		}
+		if (i == ARRAY_SIZE(ads1263_adc2_data_rate_avail))
+			return -EINVAL;
+
+		guard(mutex)(&ctx->chan_lock);
+		chan_data->data_rate = i;
+
+		break;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
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
+	unsigned long i;
+	int ret;
+
+	i = find_first_bit(indio_dev->active_scan_mask,
+			   iio_get_masklength(indio_dev));
+	ret = ads1263_adc2_channel_enable(ctx, &ctx->channels[i]);
+	if (ret)
+		return ret;
+
+	return ads1263_adc2_start(ctx);
+}
+
+static int ads1263_adc2_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1263_adc2 *st = iio_priv(indio_dev);
+	struct ads1263_adc2_ctx *ctx = st->ctx;
+
+	ads1263_adc2_stop(ctx);
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
+	ret = ads1263_adc2_read(ctx, &scan.conv);
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
+	struct ads1263_adc2_channel *chan_data;
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
+		chan_data = &ctx->channels[i];
+		chns[i] = (struct iio_chan_spec) {
+			.type = IIO_VOLTAGE,
+			.channel = chan_data->input[0],
+			.channel2 = chan_data->input[1],
+			.scan_index = i,
+			.scan_type = {
+				.format = IIO_SCAN_FORMAT_SIGNED_INT,
+				.realbits = 24,
+				.storagebits = 32,
+				.shift = 8,
+				.endianness = IIO_BE,
+			},
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					      BIT(IIO_CHAN_INFO_SCALE) |
+					      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.indexed = true,
+			.differential = true,
+		};
+	}
+
+	chns[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
+
+	indio_dev->num_channels = ctx->num_channels + 1;
+	indio_dev->channels = chns;
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
+	indio_dev->name = "ads1263_adc2";
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
+	{ .name = "ti_ads1262.ads1263_adc2" },
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
+MODULE_IMPORT_NS("TI_ADS1262");
+MODULE_DESCRIPTION("Texas Instruments ADS1263 auxiliary ADC (ADC2) driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

-- 
2.54.0

