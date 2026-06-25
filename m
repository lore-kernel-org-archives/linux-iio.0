Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E5376A11
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424576; cv=none; b=osdRDrwbxilq224SbimT+WUovIc6eyGUaqO4Coh/8jiDOZi171gcd0Refu4JbLl+1q745Mntl9psRzXOqreL+gp3SkcAXb+SK4NbSNZPKumhnmkM/ElM7NRE/vYBftHnFg1l6+6Rr+/qsEPaHbjrmb4o64hDRkO4DmDz6O6XYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424576; c=relaxed/simple;
	bh=sbpE1AKlxtUMIgjvdBRYD060yhosNnkT5QouCTcN8H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yp1SMB3vOFCIsaNF6yBgCiucq/5dkTD2W7ItOhRMPMcALCccE2fsRLA0tFLeWlsK/lwF2sCveeoamIRS1mvzXSOCpzL0DgXNqjWuhx5LjPJHj1UF9QzCq+pJ2569upaRUC1uKC/ZOoVa2NIltTwHstWV75AKj6IMcCVZuvaN8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WFbXxwaz; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WFbXxwaz"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69ed219d3ecso296243eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424572; x=1783029372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gDZh72BwXRqR8ZGehq07YNErjv18QxVZZp29nCJ6Hk=;
        b=WFbXxwazGIgAHJoscTVkogAh3Cvav7fZBSLC+Wn99xedNaiyLR8R0zYrebM24u8/nj
         keIUzAz0V+CBJPj9Anj2G7BVxpKJUGDH2zPoeIyMVdoTi0tOBxnhqE/A9oOc8xozZRjR
         p//JBkpJKMkHD8y+iRLJ90z8GNEbmr+cuRQCIUxs+J1EQ2PPx7N/tDkK8xpEL/YIXl71
         FrCAhqYOV8/coSYbMjIlEQdMnJTGLRcHbwQ69G6DdRmZNMqd4xH+6TOB9i6RCwdFriH8
         qHVvkNKQayOFtb60TwIGlR9m4GgX3+QqXHWocBHZ/XIZXmEyhwdjoU/4+Y5VMwaqMmmG
         ym5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424572; x=1783029372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6gDZh72BwXRqR8ZGehq07YNErjv18QxVZZp29nCJ6Hk=;
        b=sCqJ0GPG9CgLNwio+C82B660UIXkoq9jqDqCchDnQmKw/gGJpZRZhgFj5sRM+wH1MD
         L0zte1eqsekf2LakT2jygbe33kuG6QKzd1Y2mHKyStAOtDZJaGdmd+5O+DLLiHdOI4BT
         qyq73FztgQxqM0Kcx4caJ8apzYheBmvJiUN+7idEl3YrlbVx/5ebiod/O8alpVBvfYyQ
         tQSVyVArba5zyQXjWQ5c4aXVtxRqC/281oqqfAkN07Mlq18WZZQeliABQwbf/9AK/2vU
         2lVDoy5fqmvpCvO0DO/Gqjj3vpKxC6t60Q4u3RTtUFbCrABIs0TFkA5zDjxtWzAwz1rc
         7x6w==
X-Forwarded-Encrypted: i=1; AFNElJ8Zh1kfj2/KX4kSG61fx8vu/fN3SLgCpeRdFBdIvvNX3rSgAawR1POavjA4ML5BKz9kMHJHEFPzJgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaHHAYQvUENaCDWH8aUD8JynnIPVsIhtJrr8HmCtOCvfZ5M+K
	8JX1tCBCMbeBmj+8268TeCo/mljVjnRG9iZ3hKemwIcSJMZf0tbnqqkGFnVP2MOWT+g=
X-Gm-Gg: AfdE7ckyUgXA+OWoMO2n/zGfKLwRZ2A5/DzVy2bhLHgxAHuL8XxSt/oY6KWLYBMruxI
	UKw4oJi0t8yZthsB+bwUcE0CnBpFXJGNHyVmVBMP3RakQyqEFa43+K5RYWndJEkSZmXGXDaiO3w
	PeTpWL9Qou6RjWBXtZJWpVepC+qBybQojYFv35xqXF9wMboKDrlt7a10JwTqY3ejZ4ooetiOgez
	zNGZ9hem3P9JIi4ALVie01zDfF00f6SQw0R8tdcS6oTF5ltFJkie7ay9H7F6OE7xPnmCj7RDhHi
	Z00O1bAFazPSeze7ScRxa2tiKuMQu2mut2WfyJiCZvcpKnATeF1r1Otb5/cCQGCeonf6jnTL4Ph
	jl1i0NFqqcC7+y/FnZwFt5/MB+IbrXWCPlZ1AC2lCkDfxPhn5Mu4nz6MV3mIHKN6/rW4zc2hBvm
	at0nXDecVCUETnbk4w4Q==
X-Received: by 2002:a05:6820:f029:b0:6a1:21f6:bfa6 with SMTP id 006d021491bc7-6a1351fe5e4mr3652377eaf.29.1782424572461;
        Thu, 25 Jun 2026 14:56:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:12 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:08 -0500
Subject: [PATCH v2 6/8] iio: adc: add ti-ads112c14 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-6-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=20919;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=sbpE1AKlxtUMIgjvdBRYD060yhosNnkT5QouCTcN8H0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPjvBzirBgov1IjYbyiu+Muy86gtMnRH6BTq
 I6lMO+cEDCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2j4wAKCRDCzCAB/wGP
 wHm4B/9oanzUeKpebReL78VMcMBg5XUE8vYaQVkyhbewSbkoka3dN1QVcOg22EBmuvYp9uGzCDz
 fisKDHJ7ycezYs0zIickTR/ccQDGp1b7KNccCiMLUnX1f28+n9nZOQ7t+3dyd+gN7BzRm4IRQWH
 In8zy2WpkRKW9wLmwRnHRpPUwjqA9R9a4ZcNTpKc/39gQXWTyE6yYjg5mpk4/0jk2KO1RPlZ523
 zKm5rf0vCZN1RtCGCH3VZma4hNX0+Mhvl++09Yk0Sybkd5hwif4Uloe0I/ckL3qIrpUiCHplIXD
 941T5qN59A3Ieo+fq+g2z6f4KK6yrLbhLmCHzxU50qrEgXAT
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

v2 changes:
* Add some indent to register field macro defines.
* Drop ads112c14_internal_ref_uV array (use macros instead).
* Don't keep pointer to i2c client.
* Consistently check channel < 100 instead of >= 100 sometimes.
* Check return of i2c_get_match_data().
* Fix bug on checking -EREMOTEIO.
* Don't use &client->dev when we already have dev local variable.
* Make some changes to reduce diff in later patches.
---
 MAINTAINERS                    |   1 +
 drivers/iio/adc/Kconfig        |  12 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads112c14.c | 547 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 561 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ac9f44c7096..92746892f6b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26940,6 +26940,7 @@ M:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+F:	drivers/iio/adc/ti-ads112c14.c
 
 TI ADS1018 ADC DRIVER
 M:	Kurt Borja <kuurtb@gmail.com>
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
index 000000000000..c61d47244732
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -0,0 +1,547 @@
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
+#define ADS112C14_DELAY_RESET_US 500
+
+#define ADS112C14_CMD_RDATA	0x00
+#define ADS112C14_CMD_RREG	0x40
+#define ADS112C14_CMD_WREG	0x80
+
+#define ADS112C14_REG_DEVICE_ID				0x00
+#define   ADS112C14_DEVICE_ID_BITS			GENMASK(3, 0)
+
+#define ADS112C14_REG_REVISION_ID			0x01
+
+#define ADS112C14_REG_STATUS_MSB			0x02
+#define   ADS112C14_STATUS_MSB_RESETN			BIT(7)
+#define   ADS112C14_STATUS_MSB_AVDD_UVN			BIT(6)
+#define   ADS112C14_STATUS_MSB_REF_UVN			BIT(5)
+#define   ADS112C14_STATUS_MSB_REG_MAP_CRC_FAULTN	BIT(3)
+#define   ADS112C14_STATUS_MSB_MEM_FAULTN		BIT(2)
+#define   ADS112C14_STATUS_MSB_REG_WRITE_FAULTN		BIT(1)
+#define   ADS112C14_STATUS_MSB_DRDY			BIT(0)
+
+#define ADS112C14_REG_STATUS_LSB			0x03
+#define   ADS112C14_STATUS_LSB_CONV_COUNT		GENMASK(7, 4)
+#define   ADS112C14_STATUS_LSB_GPIO3_DAT_IN		BIT(3)
+#define   ADS112C14_STATUS_LSB_GPIO2_DAT_IN		BIT(2)
+#define   ADS112C14_STATUS_LSB_GPIO1_DAT_IN		BIT(1)
+#define   ADS112C14_STATUS_LSB_GPIO0_DAT_IN		BIT(0)
+
+#define ADS112C14_REG_CONVERSION_CTRL			0x04
+#define   ADS112C14_CONVERSION_CTRL_RESET		GENMASK(7, 2)
+#define   ADS112C14_CONVERSION_CTRL_START		BIT(1)
+#define   ADS112C14_CONVERSION_CTRL_STOP		BIT(0)
+
+#define ADS112C14_REG_DEVICE_CFG			0x05
+#define   ADS112C14_DEVICE_CFG_PWDN			BIT(7)
+#define   ADS112C14_DEVICE_CFG_STBY_MODE		BIT(6)
+#define   ADS112C14_DEVICE_CFG_BOCS			GENMASK(5, 4)
+#define   ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
+#define   ADS112C14_DEVICE_CFG_CONV_MODE		BIT(2)
+#define   ADS112C14_DEVICE_CFG_SPEED_MODE		GENMASK(1, 0)
+
+#define ADS112C14_REG_DATA_RATE_CFG			0x06
+#define   ADS112C14_DATA_RATE_CFG_DELAY			GENMASK(7, 4)
+#define   ADS112C14_DATA_RATE_CFG_GC_EN			BIT(3)
+#define   ADS112C14_DATA_RATE_CFG_FLTR_OSR		GENMASK(2, 0)
+
+#define ADS112C14_REG_MUX_CFG				0x07
+#define   ADS112C14_MUX_CFG_AINP			GENMASK(7, 4)
+#define   ADS112C14_MUX_CFG_AINN			GENMASK(3, 0)
+
+#define ADS112C14_REG_GAIN_CFG				0x08
+#define   ADS112C14_GAIN_CFG_SPARE			BIT(7)
+#define   ADS112C14_GAIN_CFG_SYS_MON			GENMASK(6, 4)
+#define   ADS112C14_GAIN_CFG_GAIN			GENMASK(3, 0)
+
+#define ADS112C14_REG_REFERENCE_CFG			0x09
+#define   ADS112C14_REFERENCE_CFG_REF_UV_EN		BIT(7)
+#define   ADS112C14_REFERENCE_CFG_REFP_BUF_EN		BIT(5)
+#define   ADS112C14_REFERENCE_CFG_REFN_BUF_EN		BIT(4)
+#define   ADS112C14_REFERENCE_CFG_REF_VAL		BIT(2)
+#define     ADS112C14_REFERENCE_CFG_REF_VAL_1_25V	  0
+#define     ADS112C14_REFERENCE_CFG_REF_VAL_2_5V	  1
+#define   ADS112C14_REFERENCE_CFG_REF_SEL		GENMASK(1, 0)
+
+#define ADS112C14_REG_DIGITAL_CFG			0x0A
+#define   ADS112C14_DIGITAL_CFG_REG_MAP_CRC_EN		BIT(6)
+#define   ADS112C14_DIGITAL_CFG_I2C_CRC_EN		BIT(5)
+#define   ADS112C14_DIGITAL_CFG_STATUS_EN		BIT(4)
+#define   ADS112C14_DIGITAL_CFG_FAULT_PIN_BEHAVIOR	BIT(3)
+#define   ADS112C14_DIGITAL_CFG_CODING			BIT(1)
+
+#define ADS112C14_REG_GPIO_CFG				0x0B
+#define   ADS112C14_GPIO_CFG_GPIO3_CFG			GENMASK(7, 6)
+#define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
+#define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
+#define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+
+#define ADS112C14_REG_GPIO_DATA_OUTPUT			0x0C
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC		BIT(7)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO1_DAT_OUT	BIT(1)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO0_DAT_OUT	BIT(0)
+
+#define ADS112C14_REG_IDAC_MAG_CFG			0x0D
+#define   ADS112C14_IDAC_MAG_CFG_I2MAG			GENMASK(7, 4)
+#define   ADS112C14_IDAC_MAG_CFG_I1MAG			GENMASK(3, 0)
+
+#define ADS112C14_REG_IDAC_MUX_CFG			0x0E
+#define   ADS112C14_IDAC_MUX_CFG_IUNIT			BIT(7)
+#define   ADS112C14_IDAC_MUX_CFG_I2MUX			GENMASK(6, 4)
+#define   ADS112C14_IDAC_MUX_CFG_I1MUX			GENMASK(2, 0)
+
+#define ADS112C14_REG_REG_MAP_CRC			0x0F
+
+#define ADS112C14_INT_REF0_mV				1250
+#define ADS112C14_INT_REF1_mV				2500
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
+	{ ADS112C14_REG_DEVICE_CFG, 0 },
+	{ ADS112C14_REG_DATA_RATE_CFG, 0 },
+	{ ADS112C14_REG_MUX_CFG, 0 },
+	{ ADS112C14_REG_GAIN_CFG, FIELD_PREP_CONST(ADS112C14_GAIN_CFG_GAIN, 1) },
+	{ ADS112C14_REG_REFERENCE_CFG, 0 },
+	{ ADS112C14_REG_DIGITAL_CFG, 0 },
+	{ ADS112C14_REG_GPIO_CFG, 0 },
+	{ ADS112C14_REG_GPIO_DATA_OUTPUT, 0 },
+	{ ADS112C14_REG_IDAC_MAG_CFG, 0 },
+	{ ADS112C14_REG_IDAC_MUX_CFG, FIELD_PREP_CONST(ADS112C14_IDAC_MUX_CFG_I2MUX, 1) },
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
+	struct regmap *regmap;
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
+	/*
+	 * REVISIT: if we implement regulator support for the REFOUT pin, we
+	 * might need to make this voltage match what is required by that. In
+	 * that case, we could also adjust GAIN so that we still get the same
+	 * range.
+	 */
+	/*
+	 * NB: SYS_MON channels ignore REF_SEL except for the shorted input
+	 * channel, so we set it here to internal reference to be consistent.
+	 * If we ever need to make a measurement of shorted input with other
+	 * reference source, we could add additional channels for that.
+	 */
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_REFERENCE_CFG,
+				 ADS112C14_REFERENCE_CFG_REF_VAL |
+				 ADS112C14_REFERENCE_CFG_REF_SEL,
+				 FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL,
+					    ADS112C14_REFERENCE_CFG_REF_VAL_2_5V) |
+				 FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_SEL,
+					    ADS112C14_REFERENCE_CFG_REF_SEL_INTERNAL));
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
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	u32 reg_val;
+	int ret;
+
+	if (chan->channel < 100) {
+		/* Not implemented yet. */
+		return -EINVAL;
+	} else {
+		ret = ads112c14_prepare_sys_mon_channel(data, chan);
+		if (ret)
+			return ret;
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
+				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
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
+	vref_uV = ADS112C14_INT_REF1_mV * (MICRO / MILLI);
+
+	if (chan->channel < 100) {
+		/* Not implemented yet. */
+		return -EINVAL;
+	} else {
+		/* All SYS_MON channels are using signed coding. */
+		fsr_bits = data->chip_info->resolution_bits - 1;
+	}
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
+		/*
+		 * Die temperature [°C] = 25°C + (Measured voltage – TS_Offset) / TS_TC
+		 * TS_TC (typical) = 405 uV/°C
+		 * TS_Offset (typical) = 119.5 mV
+		 */
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
+		label_source = "Internal short (internal reference source)";
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
+	if (!info)
+		return dev_err_probe(dev, -EINVAL, "missing match data\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->chip_info = info;
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd");
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
+	 * I2C ACK at the end of the message. The device still gets reset so it
+	 * is safe to ignore this error.
+	 */
+	if (ret == -EREMOTEIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	fsleep(ADS112C14_DELAY_RESET_US);
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
+	return devm_iio_device_register(dev, indio_dev);
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

