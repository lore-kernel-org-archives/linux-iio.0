Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77E3B71B6
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560877; cv=none; b=JlZaqmXd4w1xQkYu/qkHXvWoWgEnYb5NXH8H08zwtyY7xysGIdmXkCPDWSPom2geORRgKsSVmfc351uueczgm/dAnVtF62wGkqWSlsG1VXscZMNw+l7ZsHdbwwkvzJSSkw8ID4g3TzO2d8qp7ArnF2gYNpjzHfiSgR0mBQiye/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560877; c=relaxed/simple;
	bh=P2tZXHUdpItQbuoBDbkgwAEUscZ0cY5Yp2ywCW5ehzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiJGdBzscqtwdMpbihIc+B8xdKcg6iol9wxTX0GtTT0z5FVyK/Z8QcKrfCUPfzqTNP27fCNoMj/ZHtiFUfTjFAdXshgDt1MTPAuTp1UWzPaBcC2a/QYim7F7/Pao+a51/ge0anB+Hx+SBNHMhyfOYwTNOKIil6IB1s0GDw1MFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=itwSPkxg; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="itwSPkxg"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a0a38a013eso357834eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560874; x=1782165674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Opg7xXYaiylznqwbTSHs0BEUsRlEd240y0hWYTnX8iM=;
        b=itwSPkxgy11eqBYDvFRYPgMZFyDFiyCoUIoH8/FIPQcB+R6VP4NOwEi/fb60YbBLAE
         yZIMLQDGwF5UX0D89OSAeNzNi3t50NF0H+KrKd77Y4l8qKzqHaeCZm5lSzZzlTYTkXqF
         EmyUumcmzeTVktucjwb9256AKQVy1lHYXUPuBuy/QIJCtROp76OL1Rm1O5SYK/dA1NIx
         uiuUrTGyt0bIOJmrIdcRcTSjjEPXusAtY/JTFPhbATdapTI1m+sRNIbBZA1VvVgML22E
         MkdkhtDnHocJaxiUx1pkIYhXNxEzEQPaPWzqUYHNjsLCdKbT6hRDngGpR6lIjwO2b+HS
         65Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560874; x=1782165674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Opg7xXYaiylznqwbTSHs0BEUsRlEd240y0hWYTnX8iM=;
        b=eixcyY0tywXix2I+hxBUjLbbBTTgySqzGKD1+VykueqIQEBXcXsgj4jojV4FDmRLE4
         onkChJchYHhQFCP5AlZwjPNuoYfiv+5nT5wiFRGLsG1s12LnaSK+bzch4r5/yuWne3yL
         1rSf/NUakJfHXW5KxKxmkFB3U7Tq2v/r/XkwxSybJVHDogOtBUlJ5/q4LGsTYubStevu
         CX0RINU7E9jYAcYaulZ8aL42K1NWYbrxylsKW1yexTsPH+Yb91kKoft3t3WuQafbKdnv
         fThNkryXf/vPzZeeq120rYpIdMcRaeEM1INs+5nQG62/hvv17AT4/Jiq4uCEY/K+hIg+
         nfkA==
X-Forwarded-Encrypted: i=1; AFNElJ9guSre6tgs6rTl5PkLrJdpIDyAaMGAMJe2JOkwsaQfUwX4MlHKkPsIfEsq+2uFrbhwqA9QYSbQ3lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECob92CCng/eB38qKo/gGH7MPfx1AkyzLmGbwQwXY62j3S4SN
	sGSK68SqJ6lFMdh92dVK57Uj6PD+iFQOOzLEasjScXLkOq16W2j+VtrIYEXSGPUN1O3xbmw/Bbe
	zrJN6DVY=
X-Gm-Gg: Acq92OHONUwQ7770gqZa/ePZbjZZXf5AIzU5PjmeSw5zewyT/8rm18sh9tfcIwWbPzc
	nix4/maccm5iCGLxg6wA2QztTsIA52YzHuqUU0f+EQbAxikWttG3S9n4NJe/XX1bX8b0xnMLv17
	4hfr34NSmYQ3c/DcF5+w38ZFkIcXmjzuMHIgDDyZ9rsf9tjfoZ/akVTutpMpLudtdljxU/R2dKN
	A7Oi0xgwGqodpjin40GkYcHmtOrKcJWHXbzR2s3G12dRVs7k3iEPDqJF2d+P1YOvQF+cpJq58y7
	aJloKvZ7++G29UB948/HRbhAFNghJbybodqnhMQSzyn9yEXgjhPIQORNiqE56otcbzT/gomhTrY
	nv3LBOTliuysuozyEc9R7GXbuot4gKu11EZUidRhovVPiv6oYFo2c/3gB2HwyHkTbKf3OyqI2gi
	Mbbz8fn0pO7Pwgb+I7/JbO9f52vU7s
X-Received: by 2002:a05:6820:178b:b0:696:72e9:f92e with SMTP id 006d021491bc7-6a0a3eee9e5mr663020eaf.10.1781560873538;
        Mon, 15 Jun 2026 15:01:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd9221sm826145fac.15.2026.06.15.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:12 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 17:00:00 -0500
Subject: [PATCH 2/4] iio: adc: add ti-ads112c14 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260615-iio-adc-ti-ads122c14-v1-2-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=20017;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=P2tZXHUdpItQbuoBDbkgwAEUscZ0cY5Yp2ywCW5ehzs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqMHYSGKddM7StvXpILmSeVbdgwxKbF14vLZytU
 2i0WrT4u0CJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajB2EgAKCRDCzCAB/wGP
 wO2WB/4vDF6zJhhmtfOcNFN0TGWuKjlEkNcHcY2ZTclv5wIsL8fuz3E2+36XI3GyZZdLTK3O41s
 gxp9tSR2Mh7l1Ul1qplC8qLKaI5rvkcNON5ranGejIVxGY+I7yIEW9OUvP/zjro+jPCQ+SK+c29
 r3KWbHpRjThOewD/zJf8uJhNBkPbcW+2CeZKtlCmmfAGB4DmgUFK7FB2gZOQLIzsWJjjfqsk5HR
 WCxTCBRtqzk449m9jX75dL4oMQjn+iXj3KdBJ5S9+G5/1qECA492h1ARnfqBULAf1BRKBBmx2vj
 Raw6j1yIUPh1X5jzCUR33Na1JyyUJn38sJN4dwwLo3qbe032
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.

This first step is adding a very basic driver that only supports power
on/reset and reading the system monitor channels.

ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
logical order by address to keep the voltage channels together and in
case we find we need to add variants of this channel with different
voltage reference later.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

A few other notes for review that didn't seem worth putting in the
commit message:
* I intentionally did not use bulk regmap because later we may need to
  get the voltage of the avdd supply.
* I left some comments in the code where the code might look funny (e.g.
  to reduce future diff) or does not exactly match the datasheet, in
  which case later changes will address that.
---
 MAINTAINERS                    |   1 +
 drivers/iio/adc/Kconfig        |  12 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c14.c | 536 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 550 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce7c61b0c14..084146a0f01e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26916,6 +26916,7 @@ M:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+F:	drivers/iio/adc/ti-ads112c14.c
 F:	include/dt-bindings/iio/adc/ti,ads112c14.h
 
 TI ADS1018 ADC DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6fb0766ca27a..bfcaecc85f24 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1787,6 +1787,18 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS112C14
+	tristate "Texas Instruments ADS112C14/ADS122C14"
+	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS112C14,
+	  ADS122C14 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads112c14.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 707dd708912f..72f4c6b33ca8 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
new file mode 100644
index 000000000000..97097ae2a487
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for Texas Instruments ADS112C14 and similar ADCs.
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026 Baylibre Inc.
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads122c14.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/time64.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+/* Datasheet t_d(RST) - time to wait after reset before next I2C use. */
+#define ADS112C14_DELAY_RESET_us 500
+
+#define ADS112C14_CMD_RDATA	0x00
+#define ADS112C14_CMD_RREG	0x40
+#define ADS112C14_CMD_WREG	0x80
+
+#define ADS112C14_REG_DEVICE_ID				0x00
+#define ADS112C14_DEVICE_ID_BITS			GENMASK(3, 0)
+
+#define ADS112C14_REG_REVISION_ID			0x01
+
+#define ADS112C14_REG_STATUS_MSB			0x02
+#define ADS112C14_STATUS_MSB_RESETN			BIT(7)
+#define ADS112C14_STATUS_MSB_AVDD_UVN			BIT(6)
+#define ADS112C14_STATUS_MSB_REF_UVN			BIT(5)
+#define ADS112C14_STATUS_MSB_REG_MAP_CRC_FAULTN		BIT(3)
+#define ADS112C14_STATUS_MSB_MEM_FAULTN			BIT(2)
+#define ADS112C14_STATUS_MSB_REG_WRITE_FAULTN		BIT(1)
+#define ADS112C14_STATUS_MSB_DRDY			BIT(0)
+
+#define ADS112C14_REG_STATUS_LSB			0x03
+#define ADS112C14_STATUS_LSB_CONV_COUNT			GENMASK(7, 4)
+#define ADS112C14_STATUS_LSB_GPIO3_DAT_IN		BIT(3)
+#define ADS112C14_STATUS_LSB_GPIO2_DAT_IN		BIT(2)
+#define ADS112C14_STATUS_LSB_GPIO1_DAT_IN		BIT(1)
+#define ADS112C14_STATUS_LSB_GPIO0_DAT_IN		BIT(0)
+
+#define ADS112C14_REG_CONVERSION_CTRL			0x04
+#define ADS112C14_CONVERSION_CTRL_RESET			GENMASK(7, 2)
+#define ADS112C14_CONVERSION_CTRL_START			BIT(1)
+#define ADS112C14_CONVERSION_CTRL_STOP			BIT(0)
+
+#define ADS112C14_REG_DEVICE_CFG			0x05
+#define ADS112C14_DEVICE_CFG_PWDN			BIT(7)
+#define ADS112C14_DEVICE_CFG_STBY_MODE			BIT(6)
+#define ADS112C14_DEVICE_CFG_BOCS			GENMASK(5, 4)
+#define ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
+#define ADS112C14_DEVICE_CFG_CONV_MODE			BIT(2)
+#define ADS112C14_DEVICE_CFG_SPEED_MODE			GENMASK(1, 0)
+
+#define ADS112C14_REG_DATA_RATE_CFG			0x06
+#define ADS112C14_DATA_RATE_CFG_DELAY			GENMASK(7, 4)
+#define ADS112C14_DATA_RATE_CFG_GC_EN			BIT(3)
+#define ADS112C14_DATA_RATE_CFG_FLTR_OSR		GENMASK(2, 0)
+
+#define ADS112C14_REG_MUX_CFG				0x07
+#define ADS112C14_MUX_CFG_AINP				GENMASK(7, 4)
+#define ADS112C14_MUX_CFG_AINN				GENMASK(3, 0)
+
+#define ADS112C14_REG_GAIN_CFG				0x08
+#define ADS112C14_GAIN_CFG_SPARE			BIT(7)
+#define ADS112C14_GAIN_CFG_SYS_MON			GENMASK(6, 4)
+#define ADS112C14_GAIN_CFG_GAIN				GENMASK(3, 0)
+
+#define ADS112C14_REG_REFERENCE_CFG			0x09
+#define ADS112C14_REFERENCE_CFG_REF_UV_EN		BIT(7)
+#define ADS112C14_REFERENCE_CFG_REFP_BUF_EN		BIT(5)
+#define ADS112C14_REFERENCE_CFG_REFN_BUF_EN		BIT(4)
+#define ADS112C14_REFERENCE_CFG_REF_VAL			BIT(2)
+#define   ADS112C14_REFERENCE_CFG_REF_VAL_1_25V		  0
+#define   ADS112C14_REFERENCE_CFG_REF_VAL_2_5V		  1
+#define ADS112C14_REFERENCE_CFG_REF_SEL			GENMASK(1, 0)
+
+#define ADS112C14_REG_DIGITAL_CFG			0x0A
+#define ADS112C14_DIGITAL_CFG_REG_MAP_CRC_EN		BIT(6)
+#define ADS112C14_DIGITAL_CFG_I2C_CRC_EN		BIT(5)
+#define ADS112C14_DIGITAL_CFG_STATUS_EN			BIT(4)
+#define ADS112C14_DIGITAL_CFG_FAULT_PIN_BEHAVIOR	BIT(3)
+#define ADS112C14_DIGITAL_CFG_CODING			BIT(1)
+
+#define ADS112C14_REG_GPIO_CFG				0x0B
+#define ADS112C14_GPIO_CFG_GPIO3_CFG			GENMASK(7, 6)
+#define ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
+#define ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
+#define ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+
+#define ADS112C14_REG_GPIO_DATA_OUTPUT			0x0C
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC		BIT(7)
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO1_DAT_OUT	BIT(1)
+#define ADS112C14_GPIO_DATA_OUTPUT_GPIO0_DAT_OUT	BIT(0)
+
+#define ADS112C14_REG_IDAC_MAG_CFG			0x0D
+#define ADS112C14_IDAC_MAG_CFG_I2MAG			GENMASK(7, 4)
+#define ADS112C14_IDAC_MAG_CFG_I1MAG			GENMASK(3, 0)
+
+#define ADS112C14_REG_IDAC_MUX_CFG			0x0E
+#define ADS112C14_IDAC_MUX_CFG_IUNIT			BIT(7)
+#define ADS112C14_IDAC_MUX_CFG_I2MUX			GENMASK(6, 4)
+#define ADS112C14_IDAC_MUX_CFG_I1MUX			GENMASK(2, 0)
+
+#define ADS112C14_REG_REG_MAP_CRC			0x0F
+
+static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS112C14_REG_DEVICE_ID:
+	case ADS112C14_REG_REVISION_ID:
+	case ADS112C14_REG_STATUS_LSB:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool ads112c14_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS112C14_REG_STATUS_MSB:
+	case ADS112C14_REG_STATUS_LSB:
+	case ADS112C14_REG_CONVERSION_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default ads112c14_reg_defaults[] = {
+	{ ADS112C14_REG_DEVICE_CFG, 0x00 },
+	{ ADS112C14_REG_DATA_RATE_CFG, 0x00 },
+	{ ADS112C14_REG_MUX_CFG, 0x00 },
+	{ ADS112C14_REG_GAIN_CFG, 0x01 },
+	{ ADS112C14_REG_REFERENCE_CFG, 0x00 },
+	{ ADS112C14_REG_DIGITAL_CFG, 0x00 },
+	{ ADS112C14_REG_GPIO_CFG, 0x00 },
+	{ ADS112C14_REG_GPIO_DATA_OUTPUT, 0x00 },
+	{ ADS112C14_REG_IDAC_MAG_CFG, 0x00 },
+	{ ADS112C14_REG_IDAC_MUX_CFG, 0x10 },
+};
+
+static const struct regmap_config ads112c14_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = ADS112C14_CMD_RREG,
+	.write_flag_mask = ADS112C14_CMD_WREG,
+	.max_register = ADS112C14_REG_REG_MAP_CRC,
+	.writeable_reg = ads112c14_writeable_reg,
+	.volatile_reg = ads112c14_volatile_reg,
+	.reg_defaults = ads112c14_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ads112c14_reg_defaults),
+	.cache_type = REGCACHE_MAPLE,
+};
+
+struct ads112c14_chip_info {
+	const char *name;
+	u32 resolution_bits;
+};
+
+struct ads112c14_data {
+	const struct ads112c14_chip_info *chip_info;
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+/* Maps REF_VAL to microvolts. */
+static const u32 ads112c14_internal_ref_uV[] = {
+	[ADS112C14_REFERENCE_CFG_REF_VAL_1_25V] = 1.25 * MICRO,
+	[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V] = 2.5 * MICRO,
+};
+
+/* Fixed channels for system monitor measurements. */
+#define ADS112C14_SYS_MON_CHANNEL_TEMP		100
+#define ADS112C14_SYS_MON_CHANNEL_EXT_REF	101
+#define ADS112C14_SYS_MON_CHANNEL_AVDD		102
+#define ADS112C14_SYS_MON_CHANNEL_DVDD		103
+#define ADS112C14_SYS_MON_CHANNEL_SHORT		104
+
+static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = ADS112C14_SYS_MON_CHANNEL_TEMP,
+		.address = 2,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				    | BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = ADS112C14_SYS_MON_CHANNEL_EXT_REF,
+		.address = 3,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				    | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = ADS112C14_SYS_MON_CHANNEL_AVDD,
+		.address = 4,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				    | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = ADS112C14_SYS_MON_CHANNEL_DVDD,
+		.address = 5,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				    | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = ADS112C14_SYS_MON_CHANNEL_SHORT,
+		.channel2 = ADS112C14_SYS_MON_CHANNEL_SHORT,
+		.differential = 1,
+		.address = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				    | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
+					     const struct iio_chan_spec *chan)
+{
+	int ret;
+
+	/* TODO: GAIN is useful for shorted PGA inputs. */
+	/* All SYS_MON channels use GAIN of 1 to keep it simple. */
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
+				 ADS112C14_GAIN_CFG_SYS_MON |
+				 ADS112C14_GAIN_CFG_GAIN,
+				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, chan->address) |
+				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN, 1));
+	if (ret)
+		return ret;
+
+	/* All SYS_MON channels use signed data to keep it simple. */
+	ret = regmap_clear_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+				ADS112C14_DIGITAL_CFG_CODING);
+	if (ret)
+		return ret;
+
+	/* TODO: REF_SEL does matter for shorted PGA inputs. */
+	/*
+	 * REVISIT: if we implement regulator support for the REFOUT pin, we
+	 * might need to make this voltage match what is required by that. In
+	 * that case, we could also adjust GAIN so that we still get the same
+	 * range.
+	 */
+	/*
+	 * Setting REF_SEL for SYS_MON doesn't matter (always uses internal
+	 * reference), but we do need to set REF_VAL.
+	 */
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_REFERENCE_CFG,
+				 ADS112C14_REFERENCE_CFG_REF_VAL,
+				 FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL,
+					    ADS112C14_REFERENCE_CFG_REF_VAL_2_5V));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ads112c14_single_conversion(struct ads112c14_data *data,
+				       const struct iio_chan_spec *chan,
+				       u8 *buf)
+{
+	u32 reg_val;
+	int ret;
+
+	if (chan->channel >= 100) {
+		ret = ads112c14_prepare_sys_mon_channel(data, chan);
+		if (ret)
+			return ret;
+	} else {
+		/* Not implemented yet. */
+		return -EINVAL;
+	}
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap,
+				       ADS112C14_REG_STATUS_MSB, reg_val,
+				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
+				       1 * USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_read_i2c_block_data(data->client, ADS112C14_CMD_RDATA,
+					     BITS_TO_BYTES(data->chip_info->resolution_bits),
+					     buf);
+}
+
+static int ads112c14_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	u32 vref_uV, fsr_bits;
+
+	/* Selecting V_REF source is not implemented yet. */
+	vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
+
+	/* Currently, everything is using signed data. */
+	fsr_bits = data->chip_info->resolution_bits - 1;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		u8 buf[3];
+		int ret;
+
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ads112c14_single_conversion(data, chan, buf);
+		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		switch (data->chip_info->resolution_bits) {
+		case 16:
+			*val = get_unaligned_be16(buf);
+			break;
+		case 24:
+			*val = get_unaligned_be24(buf);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val = sign_extend32(*val, fsr_bits);
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			/* TS_TC (typical) = 405 uV/°C */
+			*val = MILLI * vref_uV / 405;
+			*val2 = fsr_bits;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		}
+
+		*val = vref_uV / (MICRO / MILLI);
+		/*
+		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
+		 * multiplied by 8 to account for internal attenuation of / 8.
+		 */
+		*val2 = fsr_bits - (chan->address >= 3 ? 3 : 0);
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		/* Only the temperature channel has an offset. */
+		if (chan->type != IIO_TEMP)
+			return -EINVAL;
+		/* Die temperature [°C] = 25°C + (Measured voltage – TS_Offset) / TS_TC */
+		/* TS_TC (typical) = 405 uV/°C */
+		/* TS_Offset (typical) = 119.5 mV */
+		*val = div_s64((s64)(25 * 405 - 119500) * BIT(fsr_bits), vref_uV);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_read_label(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, char *label)
+{
+	const char *label_source;
+
+	/* System monitor channels. */
+	switch (chan->channel) {
+	case ADS112C14_SYS_MON_CHANNEL_TEMP:
+		label_source = "Internal temperature sensor";
+		break;
+	case ADS112C14_SYS_MON_CHANNEL_EXT_REF:
+		label_source = "External reference";
+		break;
+	case ADS112C14_SYS_MON_CHANNEL_AVDD:
+		label_source = "AVDD";
+		break;
+	case ADS112C14_SYS_MON_CHANNEL_DVDD:
+		label_source = "DVDD";
+		break;
+	case ADS112C14_SYS_MON_CHANNEL_SHORT:
+		label_source = "Internal short";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sysfs_emit(label, "%s\n", label_source);
+}
+
+static const struct iio_info ads112c14_info = {
+	.read_raw = ads112c14_read_raw,
+	.read_label = ads112c14_read_label,
+};
+
+static int ads112c14_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct ads112c14_chip_info *info;
+	struct iio_dev *indio_dev;
+	struct ads112c14_data *data;
+	u32 reg_val;
+	int ret;
+
+	info = i2c_get_match_data(client);
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->chip_info = info;
+	data->client = client;
+
+	ret = devm_regulator_get_enable(&client->dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
+
+	ret = devm_regulator_get_enable(&client->dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+
+	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "failed to init regmap\n");
+
+	/* Write magic reset value (0x16) to ensure known state.*/
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   FIELD_PREP(ADS112C14_CONVERSION_CTRL_RESET, 0x16));
+	/*
+	 * The reset may cause an -EREMOTEIO error because of failing to get the
+	 * I2C ACK at the end of the message. The device still gets reset.
+	 */
+	if (ret != -EREMOTEIO)
+		return ret;
+
+	fsleep(ADS112C14_DELAY_RESET_us);
+
+	ret = regmap_read(data->regmap, ADS112C14_REG_STATUS_MSB, &reg_val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
+		return dev_err_probe(dev, -EIO, "reset failed\n");
+
+	/*
+	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
+	 * that happens on every reset.
+	 */
+	ret = regmap_write(data->regmap, ADS112C14_REG_STATUS_MSB,
+			   ADS112C14_STATUS_MSB_RESETN |
+			   ADS112C14_STATUS_MSB_AVDD_UVN);
+	if (ret)
+		return ret;
+
+	/* Place in single-shot conversion mode to make ready for raw read. */
+	ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+			      ADS112C14_DEVICE_CFG_CONV_MODE);
+	if (ret)
+		return ret;
+
+	indio_dev->name = info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads112c14_sys_mon_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
+	indio_dev->info = &ads112c14_info;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct ads112c14_chip_info ads112c14_chip_info = {
+	.name = "ads112c14",
+	.resolution_bits = 16,
+};
+
+static const struct ads112c14_chip_info ads122c14_chip_info = {
+	.name = "ads122c14",
+	.resolution_bits = 24,
+};
+
+static const struct of_device_id ads112c14_of_match[] = {
+	{ .compatible = "ti,ads112c14", .data = &ads112c14_chip_info },
+	{ .compatible = "ti,ads122c14", .data = &ads122c14_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads112c14_of_match);
+
+static const struct i2c_device_id ads112c14_id[] = {
+	{ .name = "ads112c14", .driver_data = (kernel_ulong_t)&ads112c14_chip_info },
+	{ .name = "ads122c14", .driver_data = (kernel_ulong_t)&ads122c14_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads112c14_id);
+
+static struct i2c_driver ads112c14_driver = {
+	.driver = {
+		.name = "ads112c14",
+		.of_match_table = ads112c14_of_match,
+	},
+	.probe = ads112c14_probe,
+	.id_table = ads112c14_id,
+};
+module_i2c_driver(ads112c14_driver);
+
+MODULE_AUTHOR("David Lechner (TI) <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("TI ADS112C14 I2C ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

