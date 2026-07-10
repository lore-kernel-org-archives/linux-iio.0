Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8A409E01
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723929; cv=none; b=L2Y+xyTxKnmkpLqnb7kHqbKCgxM9AaJQXdmy+rAOBLaFAgpf6wc1/J8BbgEEkoiTp6npjnWIYikuma/yweom9jI/T5C0DfI5vHxSNlFDjg/KBnRfizNYPiFREYuGyimZJGP2X/1sqNRDhOJscR+oO/dU10PE7a2YZA+Kf2s+C1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723929; c=relaxed/simple;
	bh=68IgNbDZF+ki2sgwG+rQ8vz/JDjddR1+ELM9L/Ar04w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SekVBaWb08CHmq7Tvm0eThoUmgyWNTl47Iq0iogT0yDdD4K08PLEIjou6FjiiMQzFsQeabbINqVJxh1W+IKG3CiIfuStEEBVm9MU7E3vv+aeJWvknS0n1ZPCKPJJ+yAFRsq8HgRZ3WjItJE8yOeOf/v84F/bRQvJnuUoZDDCcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GqYybi3M; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GqYybi3M"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb63dbd229so1039069a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723920; x=1784328720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KL0H0X1C9AYOdHfG302HxDOJWsU9ia+Te2ni4S59j+Y=;
        b=GqYybi3MpxIJkCp7s21YkcGM7nkcXL51hcV4VuQFQ0n7MtEBB/NACkWjHeANKvncS4
         KiQepp5ixVN74qyQwYsiJbR1T9PIfvVbmji9y8865+KUv/HfUNeyKsUSx56Eo5b4+P9V
         YWoXNBWXGwBPON6l+x0w50vbf3U5vCCKdK1ccK2FUgI74cDk7uivvkJYoeprZaXtaadj
         iK8HjdPKaiCTN7XAF7UmHsRtPmzQVi3mehSJx4BQnzxk/mcDIm+JwyXwfsQd+Szid7i7
         B8G+vZKf7xV6LXJjKAvTTtDc7TN47UlTgjeU/hVUEyMZhR9A2XYbouUU9rixeVuXou9z
         QAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723920; x=1784328720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KL0H0X1C9AYOdHfG302HxDOJWsU9ia+Te2ni4S59j+Y=;
        b=arXiEPdXpeqfqgmLvIqHPMu/7hEsgCVS3p1Hfyd+jTyAAFu32D/JcFSJxmDzAhfVDx
         SN6re9vtFnmPuiBocYKnaTnH72O9NDy5dxZONr/dRU0eRoTfrVUd9ATfdbiWApLZTmyI
         /3wsILMCCequhJvimIpuMApLyoOeYJPIr/2Cr99gFnobuQC6yWDUjow3ZhoCoqojrnX5
         XcFnyIXcJRxHAwql8BIT14NMrkuHAFz2rszCwj2gdoKlspaopCJ9q94sjE03jdV01K5v
         1BT9VTEWsfFRI15gidZQjZPYPsx6ZAHwxy7kEJRCa034Lni8lniq/MVHXD47ZVwnm6A4
         tYuQ==
X-Forwarded-Encrypted: i=1; AFNElJ898RhsB/nNlOEF/YzyvvU35TxXr5mkEZ7bRlxyPy7Lg6UCNjyQSksF7j83AzPhDWtDGDC9hVnvWnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpX/Fr0I3LX8dJAzFOuDtpN0O/wrMKB4XOiTdL8R6VcryymRAo
	PozxRAhc24rjFOAE6ECY3OyiQyhETddEpJB/KIcHcbimCB3Q2eWkQ8Y6nb8XO6PqJZA=
X-Gm-Gg: AfdE7ck/UE2oQ7UyCMdy52RvfwAqNluvJ7U+1iu+o+iE729WR4koyrGy82S8we2xBfV
	abPrKcr74rbiPUjw2W3K39OlDuR0i0WPBswIqkQdmSXmSagrV3DFgqscbAd++Q0ypoUlOOqleod
	CW/dPQcZX5B95FtHVTYsIHaPP25SrioNaVtlZSGGxVd0goflyP9ZxYlLM6P9FJ7BmzbDPQDtwaE
	OCTIqbAAAh95DfqtBIXLdFmglOVDeZpv3a9+84ryMviTz7XmaPY3MC2BbgOx/tLTDujYAtoe/0J
	vnh2tAZ97W/36dCB7zRIOR/WOBvEoEGt7CYjYlkWQJX77AbH/10VbVxmdU1NKOKMPevEA/sKRnC
	8Paj7Zf+OpT5B/jkp+XJ2cdWxD2XwESnJ82EILl5ZMhOMAuOcVojRB3EmVIgW12HbNk+Xhar8ss
	dfi3JrfAmS42qb5rVb1Bafm3PYMtU=
X-Received: by 2002:a05:6830:4997:b0:7e9:dabf:fba0 with SMTP id 46e09a7af769-7ec0a06cb78mr468885a34.15.1783723919616;
        Fri, 10 Jul 2026 15:51:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:59 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:39 -0500
Subject: [PATCH v3 6/8] iio: adc: add ti-ads112c14 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21747;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=68IgNbDZF+ki2sgwG+rQ8vz/JDjddR1+ELM9L/Ar04w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdsGnuCEog6VKHjwKp4EJo2LkeQlc8lM3Jad
 1zwzg0kw1GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3bAAKCRDCzCAB/wGP
 wIELB/9gFtREtpgSdkuCHKtB5ARaXDmCxDK3rWcNYnZKkPt2H9X0tiKC+PI66QFv8Qgh52QeIdn
 SoaLEJ8Cl9HG1B5B1jhNmhY6W0h7AbA574UtR9DhI0CMn/NEzWnG6lZsfe8guivKBJzgE+ZCfec
 dk0PU2X05baDW53wWDiQse372+yrSAGyrSuNAIBrfH4l42tr/zt4cyN6dR8ftsmoribPon8UG/f
 mcyM3CTYF72vrsev1uXU7k6RQzVrYvvFqhNZbGGaIDxnFnDO22PD435AyMUZ+QJ+ffc2X5HfPWJ
 nRoQKG3BVxh+YRDIuGjfDfM6DucV8uLN9q7B6ge+mTh4FWGC
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

v3 changes:
* Reordered some things to reudce future diffs.
* Fixed missing space in comment.
* Added device ID check.
* Added ADS112C14_SYS_MON_CHANNEL_BASE macro.
* Drop linux/mod_devicetable.h import.

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
 drivers/iio/adc/ti-ads112c14.c | 566 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 580 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e114e0c9c5f..7077ed7c9efe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26963,6 +26963,7 @@ M:	David Lechner <dlechner@baylibre.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
+F:	drivers/iio/adc/ti-ads112c14.c
 
 TI ADS1018 ADC DRIVER
 M:	Kurt Borja <kuurtb@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d1b198cb8a80..642c42b1fae7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1798,6 +1798,18 @@ config TI_ADS1119
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
index 0f90b75577ff..3778c7b0b8b5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
new file mode 100644
index 000000000000..4d2e7d37be82
--- /dev/null
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -0,0 +1,566 @@
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
+#define     ADS112C14_REFERENCE_CFG_REF_SEL_INTERNAL	  0
+#define     ADS112C14_REFERENCE_CFG_REF_SEL_EXTERNAL	  1
+#define     ADS112C14_REFERENCE_CFG_REF_SEL_AVDD	  2
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
+struct ads112c14_chip_info {
+	const char *name;
+	u8 device_id;
+	u32 resolution_bits;
+};
+
+/* Fixed channels for system monitor measurements. */
+
+#define ADS112C14_SYS_MON_CHANNEL_BASE 100
+
+enum {
+	ADS112C14_SYS_MON_CHANNEL_TEMP = ADS112C14_SYS_MON_CHANNEL_BASE,
+	ADS112C14_SYS_MON_CHANNEL_EXT_REF,
+	ADS112C14_SYS_MON_CHANNEL_AVDD,
+	ADS112C14_SYS_MON_CHANNEL_DVDD,
+	ADS112C14_SYS_MON_CHANNEL_SHORT,
+};
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
+struct ads112c14_data {
+	const struct ads112c14_chip_info *chip_info;
+	struct regmap *regmap;
+};
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
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
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
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
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
+	/* Write magic reset value (0x16) to ensure known state. */
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
+	ret = regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val) != info->device_id)
+		dev_info(dev, "device ID mismatch, expected 0xX%X, got 0x%lX\n",
+			 info->device_id,
+			 FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val));
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
+	.device_id = 0xE,
+	.resolution_bits = 16,
+};
+
+static const struct ads112c14_chip_info ads122c14_chip_info = {
+	.name = "ads122c14",
+	.device_id = 0xF,
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

