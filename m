Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9433688B
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782624994; cv=none; b=pQj5TzQ8AnasmYjiiNyIOwdSSaEsrsHz+vWUtarKAaiYxu2yfRlktCTXKDkZDJ3Z6kggyZasGXX/hQk2x6Q+4RnXL/lRAj9+sCRU4nDIhRBzsz7fBOu76Tq80loHAvkEXe2c2wgP5RM5K+6rR9LJ9SxgCKtV3tqodsanjn9CdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782624994; c=relaxed/simple;
	bh=qcMHf2m3AoiEkmgKkw6vk6eM4VC2Cj9fgH7FwWQDZ+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THZZib1vfP60Ahj3OUeNRgwQHgMnTxAR+pTeU3wH7z54Rcagx1Ow2tQsABifxfGs0WbzWnmHGLqnrkdzs6Eh3BL+S3c2FlOXaY+r0JJd5etakQCed+ngq9s+HVTlhseeAZwQT2vtWZzk/2FXpECtsJFELxvnaecA5aZOkofYGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8RrAwTE; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8RrAwTE"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bd788a7972so1252474e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782624991; x=1783229791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30HovlClexjlZ0u2r1aTstCdNyc8HPXDuiOvYMaPuHE=;
        b=S8RrAwTENPeAWKk9rR8Wm+kXfRdOOekwFrh5izRo/a7gbV269vY3TJ3tn+lubhovm/
         xikG2BBhxkjNJrjza9p3uLpOIgd+5V/SfDpwoUckUAwSNjxszXzlPEdJ75crP4AHFK4M
         GxdEYfySyFnOlz4zPVwpko4CoVl3szMNevEdxDRjaVWhYVR8A1pk/OKBTXeyNBx/5Rsv
         D544UzNGOHxJPj0USGyOHxfo6sHwYSUIaHE5QyO15A/BB/ocmItVwuQ5pn+9acpLddH2
         ZUUarQ7K25BbKviTUOv0EthnCvLEBjL23G7ms9snaVHCrOPa3dGatd6PtM5L/cnaHOIL
         9qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782624991; x=1783229791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30HovlClexjlZ0u2r1aTstCdNyc8HPXDuiOvYMaPuHE=;
        b=jcTSt827DpM0Ibl7axQIiCx9gnbr2HeLsRx0X84kVC8DAQ6TjEMFg0/zV1JCO1TING
         aspdxKpH9AYpfNUmXOUe2YUl2pEVC0Ocv8bbEGFARnWN9cAVx6G+F3Rq9cMVbN/q3xIx
         cv0Fc7qOEgZTSLUrI+nHnQvw4TC42hH4tRSNQLRmfzlEn+b9XPDiF1yLZR3MA+cVchSI
         kKcuYI6JxF2JJGAipfSG4x0D+2Vd8AwKtKB9bkEqj3zDvyZfVauINyiGDEmO8mEEHUCj
         5M/WaZGJSt3TsVwV3ya6DCkBjPuOeFpKk28/7rrZK3rgrI21TlRhbXvA7BQfyDWpepTT
         rVpg==
X-Forwarded-Encrypted: i=1; AHgh+RruD7jRp0An4EocQFEU8jm3/H9w3MQPAB2bihqC8BaEGE33p07oFDxRmZxj6673+TE5Sqz+8a/UwK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9E+qXnUBO6fS63vSVod1Sg6R6m+qEFELuWqqbiQY6PeU1f00
	vrWUGR6/VSOJA8im8Fw7q2LoKXmXIZvQ4PKb9xoXppHAFoMbSWpstMEd
X-Gm-Gg: AfdE7cnEsKdtnCY18LjVYyQi1GJs3Buf5CmTCue7QU7VVyoW81iTb6ccMPANH8EAsT5
	4v6xFJnCjGxlpGrOvRmuWXoslZg+L6610Pzslx8ejRrLatg3jw2UL1FYpdv+IWfbxWOJFaV0t1M
	lfeQSfPnMb+W2syKRR0UAUTxloLpcZjiFoxbfYH9PolkGRdn+oogQm8zyK4PCJ4tQ89vc0+k5Tc
	j73LTMd+N8nrTQg7XxXPcARcF5d0Ksol7G0ai9KSFvep6Cp20Y99SgR+YYyif4WHi7qB7LClkHT
	wqXnrCJm8Jw9wi+gtJyi7xNdgaPRnnN8jyHjN3LRWvwHgfejDfxtgIoza7uAGwj9t4sd9tTNPd9
	/YPO66Oi6cyty8inYSAGpbyWLknKsVrpqCM32K3rx070S91I2KSkSvgk8k3IuJ5WObGQe2k9p1t
	FjlJtFNaB8zgUrpd1g
X-Received: by 2002:a05:6122:d87:b0:577:51e4:ef20 with SMTP id 71dfb90a1353d-5bd69da6640mr5808658e0c.10.1782624990517;
        Sat, 27 Jun 2026 22:36:30 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bda2dd64c3sm229003e0c.1.2026.06.27.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:36:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 28 Jun 2026 00:36:03 -0500
Subject: [PATCH v2 2/7] iio: adc: Add ti-ads1262 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ads126x-v2-2-4b1b231325ba@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=36805; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=qcMHf2m3AoiEkmgKkw6vk6eM4VC2Cj9fgH7FwWQDZ+U=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkOm65LJNcvaDg97+m9llOfAi9/mlAguvzD8Q6bgvlL1
 n31P5e7oaOUhUGMi0FWTJGlPWHRt0dReW/9DoTeh5nDygQyhIGLUwAmcvEHwz9lE9OI2x+Lzljf
 mvrA/Nnf3YltLoV/7vNFbFBj0ZSaKcjO8E/VcIaboXWT5cNrWc9vyEeGnN12JLNYPPs9xy1L9zm
 bG/kB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add the ti-ads1262 driver with initial support for the primary ADC
(ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
and interoperability considerations were taken into account.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                  |    1 +
 drivers/iio/adc/Kconfig      |   13 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/ti-ads1262.c | 1206 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1221 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b83d294734b574d..d868b25f2c65bcd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26928,6 +26928,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+F:	drivers/iio/adc/ti-ads1262.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5845db2011fb5be1..6051092c20b96731 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1811,6 +1811,19 @@ config TI_ADS124S08
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads124s08.
 
+config TI_ADS1262
+	tristate "Texas Instruments ADS1262"
+	depends on SPI
+	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1262 and
+	  ADS1263 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1262.
+
 config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 72f4c6b33ca87b3f..4b1f89a2317a35f7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
+obj-$(CONFIG_TI_ADS1262) += ti-ads1262.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS131M02) += ti-ads131m02.o
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
new file mode 100644
index 0000000000000000..6103cf5a2d1624a9
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -0,0 +1,1206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Texas Instruments ADS1262 ADC driver
+ *
+ * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/align.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/compiler_attributes.h>
+#include <linux/compiler_types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/lockdep.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+#define ADS1262_OPCODE_NOP			0x00
+#define ADS1262_OPCODE_RESET			0x06
+#define ADS1262_OPCODE_START1			0x08
+#define ADS1262_OPCODE_STOP1			0x0A
+#define ADS1262_OPCODE_START2			0x0C
+#define ADS1262_OPCODE_STOP2			0x0E
+#define ADS1262_OPCODE_RDATA1			0x12
+#define ADS1262_OPCODE_RDATA2			0x14
+#define ADS1262_OPCODE_SYOCAL1			0x16
+#define ADS1262_OPCODE_SYGCAL1			0x17
+#define ADS1262_OPCODE_SFOCAL1			0x19
+#define ADS1262_OPCODE_SYOCAL2			0x1B
+#define ADS1262_OPCODE_SYGCAL2			0x1C
+#define ADS1262_OPCODE_SFOCAL2			0x1E
+#define ADS1262_OPCODE_RREG			0x20
+#define ADS1262_OPCODE_WREG			0x40
+
+#define ADS1262_ID_REG				0x00
+#define   ADS1262_DEV_ID_MASK			GENMASK(7, 5)
+#define   ADS1262_REV_ID_MASK			GENMASK(4, 0)
+
+#define ADS1262_POWER_REG			0x01
+#define   ADS1262_POWER_RESET_MASK		BIT(4)
+#define   ADS1262_POWER_VBIAS_MASK		BIT(1)
+#define   ADS1262_POWER_INTREF_MASK		BIT(0)
+
+#define ADS1262_INTERFACE_REG			0x02
+#define   ADS1262_INTERFACE_TIMEOUT_MASK	BIT(3)
+#define   ADS1262_INTERFACE_STATUS_MASK		BIT(2)
+#define   ADS1262_INTERFACE_CRC_MASK		GENMASK(1, 0)
+
+#define ADS1262_MODE0_REG			0x03
+#define   ADS1262_MODE0_REFREV_MASK		BIT(7)
+#define   ADS1262_MODE0_RUNMODE_MASK		BIT(6)
+#define   ADS1262_MODE0_IDAC_CHOP_MASK		BIT(5)
+#define   ADS1262_MODE0_INPUT_CHOP_MASK		BIT(4)
+#define   ADS1262_MODE0_DELAY_MASK		GENMASK(3, 0)
+
+#define ADS1262_MODE1_REG			0x04
+#define   ADS1262_MODE1_FILTER_MASK		GENMASK(7, 5)
+#define   ADS1262_MODE1_SBADC_MASK		BIT(4)
+#define   ADS1262_MODE1_SBPOL_MASK		BIT(3)
+#define   ADS1262_MODE1_SBMAG_MASK		GENMASK(2, 0)
+
+#define ADS1262_MODE2_REG			0x05
+#define   ADS1262_MODE2_BYPASS_MASK		BIT(7)
+#define   ADS1262_MODE2_GAIN_MASK		GENMASK(6, 4)
+#define   ADS1262_MODE2_DR_MASK			GENMASK(3, 0)
+
+#define ADS1262_INPMUX_REG			0x06
+#define   ADS1262_INPMUX_MUXP_MASK		GENMASK(7, 4)
+#define   ADS1262_INPMUX_MUXN_MASK		GENMASK(3, 0)
+
+#define ADS1262_OFCAL0_REG			0x07
+#define ADS1262_OFCAL1_REG			0x08
+#define ADS1262_OFCAL2_REG			0x09
+#define ADS1262_FSCAL0_REG			0x0A
+#define ADS1262_FSCAL1_REG			0x0B
+#define ADS1262_FSCAL2_REG			0x0C
+
+#define ADS1262_IDACMUX_REG			0x0D
+#define   ADS1262_IDACMUX_MUX2_MASK		GENMASK(7, 4)
+#define   ADS1262_IDACMUX_MUX1_MASK		GENMASK(3, 0)
+
+#define ADS1262_IDACMAG_REG			0x0E
+#define   ADS1262_IDACMAG_MAG2_MASK		GENMASK(7, 4)
+#define   ADS1262_IDACMAG_MAG1_MASK		GENMASK(3, 0)
+
+#define ADS1262_REFMUX_REG			0x0F
+#define   ADS1262_REFMUX_RMUXP_MASK		GENMASK(5, 3)
+#define   ADS1262_REFMUX_RMUXN_MASK		GENMASK(2, 0)
+
+#define ADS1262_TDACP_REG			0x10
+#define   ADS1262_TDACP_OUTP_MASK		BIT(7)
+#define   ADS1262_TDACP_MAGP_MASK		GENMASK(4, 0)
+
+#define ADS1262_TDACN_REG			0x11
+#define   ADS1262_TDACN_OUTN_MASK		BIT(7)
+#define   ADS1262_TDACN_MAGN_MASK		GENMASK(4, 0)
+
+#define ADS1262_GPIOCON_REG			0x12
+#define ADS1262_GPIODIR_REG			0x13
+#define ADS1262_GPIODAT_REG			0x14
+
+#define ADS1262_ADC2CFG_REG			0x15
+#define   ADS1262_ADC2CFG_DR2_MASK		GENMASK(7, 6)
+#define   ADS1262_ADC2CFG_REF2_MASK		GENMASK(5, 3)
+#define   ADS1262_ADC2CFG_GAIN2_MASK		GENMASK(2, 0)
+
+#define ADS1262_ADC2MUX_REG			0x16
+#define   ADS1262_ADC2MUX_MUXP2_MASK		GENMASK(7, 4)
+#define   ADS1262_ADC2MUX_MUXN2_MASK		GENMASK(3, 0)
+
+#define ADS1262_ADC2OFC0_REG			0x17
+#define ADS1262_ADC2OFC1_REG			0x18
+#define ADS1262_ADC2FSC0_REG			0x19
+#define ADS1262_ADC2FSC1_REG			0x1A
+#define ADS1262_REG_COUNT			0x1B
+
+#define ADS1262_MAX_CHANNEL_COUNT		16
+#define ADS1262_XFER_BUFFER_SZ			11
+
+enum {
+	ADS1262_RUNMODE_CONTINUOUS,
+	ADS1262_RUNMODE_PULSE,
+};
+
+enum {
+	ADS1262_DR_2_5_SPS,
+	ADS1262_DR_5_SPS,
+	ADS1262_DR_10_SPS,
+	ADS1262_DR_16_6_SPS,
+	ADS1262_DR_20_SPS,
+	ADS1262_DR_50_SPS,
+	ADS1262_DR_60_SPS,
+	ADS1262_DR_100_SPS,
+	ADS1262_DR_400_SPS,
+	ADS1262_DR_1200_SPS,
+	ADS1262_DR_2400_SPS,
+	ADS1262_DR_4800_SPS,
+	ADS1262_DR_7200_SPS,
+	ADS1262_DR_14400_SPS,
+	ADS1262_DR_19200_SPS,
+	ADS1262_DR_38400_SPS,
+};
+
+enum {
+	ADS1262_INPMUX_AIN0,
+	ADS1262_INPMUX_AIN1,
+	ADS1262_INPMUX_AIN2,
+	ADS1262_INPMUX_AIN3,
+	ADS1262_INPMUX_AIN4,
+	ADS1262_INPMUX_AIN5,
+	ADS1262_INPMUX_AIN6,
+	ADS1262_INPMUX_AIN7,
+	ADS1262_INPMUX_AIN8,
+	ADS1262_INPMUX_AIN9,
+	ADS1262_INPMUX_AINCOM,
+	ADS1262_INPMUX_TEMP,
+	ADS1262_INPMUX_AVDD,
+	ADS1262_INPMUX_DVDD,
+	ADS1262_INPMUX_TDAC,
+	ADS1262_INPMUX_FLOAT,
+	ADS1262_INPMUX_LAST
+};
+
+enum {
+	ADS1262_REFMUX_INTERNAL,
+	ADS1262_REFMUX_AIN0_AIN1,
+	ADS1262_REFMUX_AIN2_AIN3,
+	ADS1262_REFMUX_AIN4_AIN5,
+	ADS1262_REFMUX_AVDD_AVSS,
+	ADS1262_REFMUX_LAST
+};
+
+struct ads1262_chip_info {
+	const char *name;
+	bool has_aux_adc;
+};
+
+struct ads1262_channel {
+	u8 input[2];
+	u8 gain;
+	u8 data_rate;
+	u8 reference[3];
+	u8 pga_bypass:1;
+	u8 ref_reversal:1;
+	u8 input_chop:1;
+	u8 idac_chop:1;
+};
+
+struct ads1262 {
+	struct spi_device *spi;
+	const struct ads1262_chip_info *info;
+	struct regmap *regmap;
+	struct iio_dev *indio_dev;
+	struct gpio_desc *reset_gpiod;
+	struct gpio_desc *start_gpiod;
+
+	/* Protects channel state */
+	struct mutex chan_lock;
+	unsigned int num_channels;
+	struct ads1262_channel *channels;
+	struct completion drdy;
+
+	int refp_uV;
+	int refn_uV;
+	int avdd_uV;
+
+	/* Protects transfer buffers and concurrent SPI transfers */
+	struct mutex xfer_lock;
+
+	u8 tx[ADS1262_XFER_BUFFER_SZ] __aligned(IIO_DMA_MINALIGN);
+	u8 rx[ADS1262_XFER_BUFFER_SZ] __aligned(IIO_DMA_MINALIGN);
+};
+
+static const int ads1262_data_rate_avail[][2] = {
+	[ADS1262_DR_2_5_SPS]	= { 2,		500000 },
+	[ADS1262_DR_5_SPS]	= { 5,		0 },
+	[ADS1262_DR_10_SPS]	= { 10,		0 },
+	[ADS1262_DR_16_6_SPS]	= { 16,		666667 },
+	[ADS1262_DR_20_SPS]	= { 20,		0 },
+	[ADS1262_DR_50_SPS]	= { 50,		0 },
+	[ADS1262_DR_60_SPS]	= { 60,		0 },
+	[ADS1262_DR_100_SPS]	= { 100,	0 },
+	[ADS1262_DR_400_SPS]	= { 400,	0 },
+	[ADS1262_DR_1200_SPS]	= { 1200,	0 },
+	[ADS1262_DR_2400_SPS]	= { 2400,	0 },
+	[ADS1262_DR_4800_SPS]	= { 4800,	0 },
+	[ADS1262_DR_7200_SPS]	= { 7200,	0 },
+	[ADS1262_DR_14400_SPS]	= { 14400,	0 },
+	[ADS1262_DR_19200_SPS]	= { 19200,	0 },
+	[ADS1262_DR_38400_SPS]	= { 38400,	0 },
+};
+
+static const int ads1262_pga_gain_avail[] = {
+	1, 2, 4, 8, 16, 32
+};
+
+#define ads1262_find_one(_arr, _val)					\
+({									\
+	int _i;								\
+	for (_i = 0; _i < ARRAY_SIZE(_arr); _i++) {			\
+		if ((_val) == _arr[_i])					\
+			break;						\
+	}								\
+	if (_i == ARRAY_SIZE(_arr))					\
+		_i = -EINVAL;						\
+	_i;								\
+})
+
+#define ads1262_find_two(_arr, _val, _val2)				\
+({									\
+	int _i;								\
+	for (_i = 0; _i < ARRAY_SIZE(_arr); _i++) {			\
+		if ((_val) == _arr[_i][0] && (_val2) == _arr[_i][1])	\
+			break;						\
+	}								\
+	if (_i == ARRAY_SIZE(_arr))					\
+		_i = -EINVAL;						\
+	_i;								\
+})
+
+#define ads1262_find_string(_arr, _str)					\
+({									\
+	int _i;								\
+	for (_i = 0; _i < ARRAY_SIZE(_arr); _i++) {			\
+		if (!strcmp(_arr[_i], _str))				\
+			break;						\
+	}								\
+	if (_i == ARRAY_SIZE(_arr))					\
+		_i = -EINVAL;						\
+	_i;								\
+})
+
+static int ads1262_dev_cmd(struct ads1262 *st, u8 opcode)
+{
+	guard(mutex)(&st->xfer_lock);
+
+	return spi_write_then_read(st->spi, &opcode, sizeof(opcode), NULL, 0);
+}
+
+static int ads1262_dev_reset(struct ads1262 *st)
+{
+	int ret;
+
+	ret = ads1262_dev_cmd(st, ADS1262_OPCODE_RESET);
+	if (ret)
+		return ret;
+
+	/* RESET command timing requirement is 1.085 usecs (Table 9-32) */
+	fsleep(2);
+
+	return ret;
+}
+
+static int ads1262_dev_start(struct ads1262 *st)
+{
+	int ret;
+
+	if (st->start_gpiod)
+		ret = gpiod_set_value_cansleep(st->start_gpiod, 1);
+	else
+		ret = ads1262_dev_cmd(st, ADS1262_OPCODE_START1);
+
+	return ret;
+}
+
+static int ads1262_dev_stop(struct ads1262 *st)
+{
+	int ret;
+
+	if (st->start_gpiod)
+		ret = gpiod_set_value_cansleep(st->start_gpiod, 0);
+	else
+		ret = ads1262_dev_cmd(st, ADS1262_OPCODE_STOP1);
+
+	return ret;
+}
+
+static int ads1262_dev_start_one(struct ads1262 *st, u8 runmode)
+{
+	int ret;
+
+	ret = ads1262_dev_start(st);
+	if (ret)
+		return ret;
+
+	if (runmode == ADS1262_RUNMODE_CONTINUOUS)
+		return ads1262_dev_stop(st);
+
+	return 0;
+}
+
+static int ads1262_calculate_scale(struct ads1262 *st, u8 realbits, u8 gain,
+				   u8 pos_ref, u8 neg_ref, int *val, int *val2)
+{
+	u64 divd, divr, tmp, rem;
+	int pos_uV, neg_uV;
+
+	switch (pos_ref) {
+	case ADS1262_REFMUX_INTERNAL:
+		/* Internal voltage reference is 2.5 V */
+		pos_uV = 2500000;
+		break;
+	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
+		pos_uV = st->refp_uV;
+		break;
+	case ADS1262_REFMUX_AVDD_AVSS:
+		pos_uV = st->avdd_uV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (neg_ref) {
+	case ADS1262_REFMUX_INTERNAL:
+		neg_uV = 0;
+		break;
+	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
+		neg_uV = st->refn_uV == -ENODEV ? 0 : st->refn_uV;
+		break;
+	case ADS1262_REFMUX_AVDD_AVSS:
+		neg_uV = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (pos_uV < neg_uV)
+		divd = neg_uV - pos_uV;
+	else
+		divd = pos_uV - neg_uV;
+	divr = BIT_ULL(gain + realbits - 1) * 1000;
+	tmp = div64_u64(divd * NANO, divr);
+
+	*val = div64_u64_rem(tmp, NANO, &rem);
+	*val2 = rem;
+
+	return 0;
+}
+
+static int ads1262_channel_get_scale(struct ads1262 *st,
+				     struct iio_chan_spec const *chan, int *val,
+				     int *val2)
+{
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+
+	return ads1262_calculate_scale(st, chan->scan_type.realbits, chan_data->gain,
+				       chan_data->reference[0], chan_data->reference[1],
+				       val, val2);
+}
+
+static long ads1262_wait_for_conversion(struct ads1262 *st)
+{
+	/*
+	 * The first conversion latency is affected by the channel's data rate,
+	 * filter, the configurable conversion delay and whether chop mode
+	 * and/or IDAC rotation mode are enabled.
+	 *
+	 * The worst possible latency is calculated by taking the lowest data
+	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600 ms
+	 * (Table 9-13). Then add the slowest configurable conversion delay
+	 * (9 ms) and multiply by 4 to account for chop and IDAC rotation modes
+	 * (Equation 20).
+	 *
+	 * Final result is 4 * (1600 ms + 9 ms) = 6436.
+	 */
+	return wait_for_completion_interruptible_timeout(&st->drdy, msecs_to_jiffies(6436));
+}
+
+static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *val)
+{
+	guard(mutex)(&st->xfer_lock);
+
+	return spi_write_then_read(st->spi, &cmd, sizeof(cmd), val, sizeof(*val));
+}
+
+static int ads1262_channel_enable(struct ads1262 *st,
+				  struct ads1262_channel *chan)
+{
+	u8 mode0, mode2, inpmux, refmux;
+	int ret;
+
+	/* Avoid using guard() here to mitigate AB/BA deadlock warning */
+	mutex_lock(&st->chan_lock);
+	mode0 = FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
+		FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
+		FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
+	mode2 = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
+		FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain) |
+		FIELD_PREP(ADS1262_MODE2_BYPASS_MASK, chan->pga_bypass);
+	inpmux = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, chan->input[1]) |
+		 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, chan->input[0]);
+	refmux = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->reference[1]) |
+		 FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->reference[0]);
+	mutex_unlock(&st->chan_lock);
+
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				 ADS1262_MODE0_INPUT_CHOP_MASK |
+				 ADS1262_MODE0_IDAC_CHOP_MASK |
+				 ADS1262_MODE0_REFREV_MASK, mode0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
+				 ADS1262_MODE2_DR_MASK |
+				 ADS1262_MODE2_GAIN_MASK |
+				 ADS1262_MODE2_BYPASS_MASK, mode2);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
+				 ADS1262_INPMUX_MUXN_MASK |
+				 ADS1262_INPMUX_MUXP_MASK, inpmux);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
+				  ADS1262_REFMUX_RMUXN_MASK |
+				  ADS1262_REFMUX_RMUXP_MASK, refmux);
+}
+
+static int ads1262_set_runmode(struct ads1262 *st, u8 runmode)
+{
+	return regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				  ADS1262_MODE0_RUNMODE_MASK,
+				  FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, runmode));
+}
+
+static int ads1262_channel_read(struct ads1262 *st,
+				struct ads1262_channel *chan_data, __be32 *val)
+{
+	u8 runmode;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(st->indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	/*
+	 * When a channel has chop mode or IDAC rotation mode, the first
+	 * conversion is always withheld so the datasheet suggests using the
+	 * CONTINUOUS mode and briefly starting and stopping conversions to
+	 * achieve the same effect (Section 9.4.1.2).
+	 */
+	if (chan_data->input_chop || chan_data->idac_chop)
+		runmode = ADS1262_RUNMODE_CONTINUOUS;
+	else
+		runmode = ADS1262_RUNMODE_PULSE;
+
+	ret = ads1262_set_runmode(st, runmode);
+	if (ret)
+		return ret;
+
+	ret = ads1262_channel_enable(st, chan_data);
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->drdy);
+
+	ret = ads1262_dev_start_one(st, runmode);
+	if (ret)
+		return ret;
+
+	ads1262_wait_for_conversion(st);
+
+	return ads1262_dev_read_by_cmd(st, ADS1262_OPCODE_RDATA1, val);
+}
+
+static int ads1262_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+	u8 realbits = chan->scan_type.realbits;
+	__be32 raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads1262_channel_read(st, chan_data, &raw);
+		if (ret)
+			return ret;
+		*val = sign_extend32(be32_to_cpu(raw), realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&st->chan_lock);
+
+		ret = ads1262_channel_get_scale(st, chan, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = ads1262_pga_gain_avail[chan_data->gain];
+
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = ads1262_data_rate_avail[chan_data->data_rate][0];
+		*val2 = ads1262_data_rate_avail[chan_data->data_rate][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, const int **vals,
+			      int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = (const int *)ads1262_data_rate_avail;
+		*length = ARRAY_SIZE(ads1262_data_rate_avail) * 2;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*type = IIO_VAL_INT;
+		*vals = ads1262_pga_gain_avail;
+		*length = ARRAY_SIZE(ads1262_pga_gain_avail);
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data;
+	int i;
+
+	chan_data = &st->channels[chan->scan_index];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		i = ads1262_find_two(ads1262_data_rate_avail, val, val2);
+		if (i < 0)
+			return i;
+
+		guard(mutex)(&st->chan_lock);
+		chan_data->data_rate = i;
+
+		break;
+	}
+
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		i = ads1262_find_one(ads1262_pga_gain_avail, val);
+		if (i < 0)
+			return i;
+
+		guard(mutex)(&st->chan_lock);
+		chan_data->gain = i;
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
+static int ads1262_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				      unsigned int writeval, unsigned int *readval)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read_bypassed(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ads1262_iio_info = {
+	.read_raw = ads1262_read_raw,
+	.read_avail = ads1262_read_avail,
+	.write_raw = ads1262_write_raw,
+	.write_raw_get_fmt = ads1262_write_raw_get_fmt,
+	.debugfs_reg_access = ads1262_debugfs_reg_access,
+};
+
+static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
+{
+	struct ads1262 *st = dev_id;
+
+	complete(&st->drdy);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1262_alloc_channels(struct ads1262 *st,
+				  struct iio_chan_spec **channels)
+{
+	struct device *dev = &st->spi->dev;
+	struct ads1262_channel *chan_data;
+	struct iio_chan_spec *chans;
+	unsigned int i, num_channels;
+
+	/* Account for the timestamp channel */
+	num_channels = st->num_channels + 1;
+	chans = devm_kcalloc(dev, num_channels, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	for (i = 0; i < st->num_channels; i++) {
+		chan_data = &st->channels[i];
+		chans[i] = (struct iio_chan_spec) {
+			.type = IIO_VOLTAGE,
+			.channel = chan_data->input[0],
+			.channel2 = chan_data->input[1],
+			.scan_index = i,
+			.scan_type = {
+				.format = IIO_SCAN_FORMAT_SIGNED_INT,
+				.realbits = 32,
+				.storagebits = 32,
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
+	chans[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
+
+	*channels = chans;
+
+	return num_channels;
+}
+
+static int ads1262_dev_configure(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = ads1262_dev_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
+
+	ret = regmap_clear_bits(st->regmap, ADS1262_POWER_REG,
+				ADS1262_POWER_RESET_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(st->regmap, ADS1262_INTERFACE_REG,
+				ADS1262_INTERFACE_STATUS_MASK |
+				ADS1262_INTERFACE_CRC_MASK);
+	if (ret)
+		return ret;
+
+	if (device_property_present(dev, "ti,vbias")) {
+		ret = regmap_set_bits(st->regmap, ADS1262_POWER_REG,
+				      ADS1262_POWER_VBIAS_MASK);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct regmap_range ads1262_read_write_range[] = {
+	regmap_reg_range(ADS1262_ID_REG, ADS1262_ADC2FSC1_REG),
+};
+
+static const struct regmap_range ads1262_read_only_range[] = {
+	regmap_reg_range(ADS1262_ID_REG, ADS1262_ID_REG),
+};
+
+static const struct regmap_access_table ads1262_wr_table = {
+	.yes_ranges = ads1262_read_write_range,
+	.n_yes_ranges = ARRAY_SIZE(ads1262_read_write_range),
+	.no_ranges = ads1262_read_only_range,
+	.n_no_ranges = ARRAY_SIZE(ads1262_read_only_range),
+};
+
+static const struct regmap_access_table ads1262_rd_table = {
+	.yes_ranges = ads1262_read_write_range,
+	.n_yes_ranges = ARRAY_SIZE(ads1262_read_write_range),
+};
+
+static const struct reg_default ads1262_reg_defaults[] = {
+	{ ADS1262_POWER_REG,		0x11 },
+	{ ADS1262_INTERFACE_REG,	0x05 },
+	{ ADS1262_MODE0_REG,		0x00 },
+	{ ADS1262_MODE1_REG,		0x80 },
+	{ ADS1262_MODE2_REG,		0x04 },
+	{ ADS1262_INPMUX_REG,		0x01 },
+	{ ADS1262_OFCAL0_REG,		0x00 },
+	{ ADS1262_OFCAL1_REG,		0x00 },
+	{ ADS1262_OFCAL2_REG,		0x00 },
+	{ ADS1262_FSCAL0_REG,		0x00 },
+	{ ADS1262_FSCAL1_REG,		0x00 },
+	{ ADS1262_FSCAL2_REG,		0x40 },
+	{ ADS1262_IDACMUX_REG,		0xBB },
+	{ ADS1262_IDACMAG_REG,		0x00 },
+	{ ADS1262_REFMUX_REG,		0x00 },
+	{ ADS1262_TDACP_REG,		0x00 },
+	{ ADS1262_TDACN_REG,		0x00 },
+	{ ADS1262_GPIOCON_REG,		0x00 },
+	{ ADS1262_GPIODIR_REG,		0x00 },
+	{ ADS1262_GPIODAT_REG,		0x00 },
+	{ ADS1262_ADC2CFG_REG,		0x00 },
+	{ ADS1262_ADC2MUX_REG,		0x01 },
+	{ ADS1262_ADC2OFC0_REG,		0x00 },
+	{ ADS1262_ADC2OFC1_REG,		0x00 },
+	{ ADS1262_ADC2FSC0_REG,		0x00 },
+	{ ADS1262_ADC2FSC1_REG,		0x40 },
+};
+
+static const struct regmap_config ads1262_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.wr_table = &ads1262_wr_table,
+	.rd_table = &ads1262_rd_table,
+	.reg_defaults = ads1262_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ads1262_reg_defaults),
+	.max_register = ADS1262_ADC2FSC1_REG,
+	.read_flag_mask = ADS1262_OPCODE_RREG,
+	.write_flag_mask = ADS1262_OPCODE_WREG,
+	.can_sleep = true,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ads1262_regmap_read(void *context, const void *reg_buf,
+			       size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct ads1262 *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.rx_buf = st->rx,
+		.len = reg_size + 1 + val_size,
+	};
+	int ret;
+
+	guard(mutex)(&st->xfer_lock);
+
+	memset(st->tx, 0, reg_size + 1 + val_size);
+
+	memcpy(&st->tx[0], reg_buf, 1);
+	st->tx[1] = val_size - 1;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	memcpy(val_buf, &st->rx[2], val_size);
+
+	return 0;
+}
+
+static int ads1262_regmap_gather_write(void *context, const void *reg_buf,
+				       size_t reg_size, const void *val_buf,
+				       size_t val_size)
+{
+	struct ads1262 *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.rx_buf = st->rx,
+		.len = reg_size + 1 + val_size,
+	};
+
+	guard(mutex)(&st->xfer_lock);
+
+	memset(st->tx, 0, reg_size + 1 + val_size);
+
+	memcpy(&st->tx[0], reg_buf, 1);
+	st->tx[1] = val_size - 1;
+	memcpy(&st->tx[2], val_buf, val_size);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ads1262_regmap_write(void *context, const void *data, size_t count)
+{
+	return ads1262_regmap_gather_write(context, data, 1, data + 1,
+					   count - 1);
+}
+
+static const struct regmap_bus ads1262_regmap_bus = {
+	.read = ads1262_regmap_read,
+	.gather_write = ads1262_regmap_gather_write,
+	.write = ads1262_regmap_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+	/* The first two bytes of the buffer are reserved for the protocol */
+	.max_raw_read = ADS1262_XFER_BUFFER_SZ - 2,
+	.max_raw_write = ADS1262_XFER_BUFFER_SZ - 2,
+};
+
+static int ads1262_channel_sanity_check(struct ads1262 *st,
+					struct ads1262_channel *chan)
+{
+	struct device *dev = &st->spi->dev;
+	int pos_uV, neg_uV;
+
+	/* Positive reference */
+	switch (chan->reference[0]) {
+	case ADS1262_REFMUX_INTERNAL:
+		/* Internal voltage reference is 2.5 V */
+		pos_uV = 2500000;
+		break;
+	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
+		if (st->refp_uV == -ENODEV)
+			return dev_err_probe(dev, -ENODEV, "refp-supply not found\n");
+		pos_uV = st->refp_uV;
+		break;
+	case ADS1262_REFMUX_AVDD_AVSS:
+		pos_uV = st->avdd_uV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Negative reference */
+	switch (chan->reference[1]) {
+	case ADS1262_REFMUX_INTERNAL:
+		neg_uV = 0;
+		break;
+	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
+		neg_uV = st->refn_uV == -ENODEV ? 0 : st->refn_uV;
+		break;
+	case ADS1262_REFMUX_AVDD_AVSS:
+		neg_uV = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* If the positive reference is bellow the negative, reverse it */
+	if (pos_uV < neg_uV)
+		chan->ref_reversal = 1;
+
+	/* ADC2 reference */
+	switch (chan->reference[2]) {
+	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
+		if (st->refp_uV == -ENODEV)
+			return dev_err_probe(dev, -ENODEV, "refp-supply not found\n");
+		pos_uV = st->refp_uV;
+		neg_uV = st->refn_uV == -ENODEV ? 0 : st->refn_uV;
+
+		/* We can't reverse ADC2 reference */
+		if (pos_uV < neg_uV && st->info->has_aux_adc)
+			return dev_err_probe(dev, -EINVAL,
+					     "ADC2 doesn't support negative reference voltage\n");
+
+		break;
+	}
+
+	return 0;
+}
+
+static const char * const ads1262_ref_sources_positive[] = {
+	[ADS1262_REFMUX_INTERNAL] = "internal",
+	[ADS1262_REFMUX_AIN0_AIN1] = "ain0",
+	[ADS1262_REFMUX_AIN2_AIN3] = "ain2",
+	[ADS1262_REFMUX_AIN4_AIN5] = "ain4",
+	[ADS1262_REFMUX_AVDD_AVSS] = "avdd"
+};
+
+static const char * const ads1262_ref_sources_negative[] = {
+	[ADS1262_REFMUX_INTERNAL] = "internal",
+	[ADS1262_REFMUX_AIN0_AIN1] = "ain1",
+	[ADS1262_REFMUX_AIN2_AIN3] = "ain3",
+	[ADS1262_REFMUX_AIN4_AIN5] = "ain5",
+	[ADS1262_REFMUX_AVDD_AVSS] = "avss"
+};
+
+static const char * const ads1262_ref_sources_adc2[] = {
+	[ADS1262_REFMUX_INTERNAL] = "internal",
+	[ADS1262_REFMUX_AIN0_AIN1] = "ain0-ain1",
+	[ADS1262_REFMUX_AIN2_AIN3] = "ain2-ain3",
+	[ADS1262_REFMUX_AIN4_AIN5] = "ain4-ain5",
+	[ADS1262_REFMUX_AVDD_AVSS] = "avdd-avss"
+};
+
+static int ads1262_parse_channel_node(struct ads1262 *st,
+				      struct ads1262_channel *chan,
+				      struct fwnode_handle *node)
+{
+	struct device *dev = &st->spi->dev;
+	const char *ref_sources[3] = {};
+	u32 pins[2];
+	int ret;
+
+	/* Write non-zero default configuration values */
+	chan->data_rate = ADS1262_DR_20_SPS;
+
+	ret = fwnode_property_read_u32_array(node, "diff-channels", pins, ARRAY_SIZE(pins));
+	if (ret)
+		return dev_err_probe(dev, ret, "%s: Failed to read diff-channels\n",
+				     fwnode_get_name(node));
+	if (pins[0] >= ADS1262_INPMUX_LAST || pins[1] >= ADS1262_INPMUX_LAST)
+		return dev_err_probe(dev, -EINVAL, "%s: input channels not in range\n",
+				     fwnode_get_name(node));
+	chan->input[0] = pins[0];
+	chan->input[1] = pins[1];
+
+	if (fwnode_property_present(node, "reference-sources")) {
+		ret = fwnode_property_read_string_array(node, "reference-sources", ref_sources,
+							st->info->has_aux_adc ? 3 : 2);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: Failed to read reference-sources\n",
+					     fwnode_get_name(node));
+
+		ret = ads1262_find_string(ads1262_ref_sources_positive, ref_sources[0]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: Invalid positive reference\n",
+					     fwnode_get_name(node));
+		chan->reference[0] = ret;
+
+		ret = ads1262_find_string(ads1262_ref_sources_negative, ref_sources[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: Invalid negative reference\n",
+					     fwnode_get_name(node));
+		chan->reference[1] = ret;
+
+		if (st->info->has_aux_adc) {
+			ret = ads1262_find_string(ads1262_ref_sources_adc2, ref_sources[2]);
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "%s: Invalid ADC2 reference\n",
+						     fwnode_get_name(node));
+			chan->reference[2] = ret;
+		}
+	}
+
+	if (fwnode_property_present(node, "ti,pga-bypass"))
+		chan->pga_bypass = 1;
+
+	if (fwnode_property_present(node, "input-chopping"))
+		chan->input_chop = 1;
+
+	if (fwnode_property_present(node, "ti,idac-chopping"))
+		chan->idac_chop = 1;
+
+	return ads1262_channel_sanity_check(st, chan);
+}
+
+static int ads1262_parse_firmware(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct clk *clk;
+	u32 reg;
+	int ret;
+
+	/* Set the nominal clock frequency */
+	clk = devm_clk_get_optional_enabled_with_rate(dev, NULL, 7372800);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get external clock\n");
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get dvdd regulator\n");
+
+	st->avdd_uV = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (st->avdd_uV < 0)
+		return dev_err_probe(dev, st->avdd_uV, "Failed to get avdd regulator\n");
+
+	st->refp_uV = devm_regulator_get_enable_read_voltage(dev, "refp");
+	if (st->refp_uV < 0 && st->refp_uV != -ENODEV)
+		return dev_err_probe(dev, st->refp_uV, "Failed to get refp regulator\n");
+
+	st->refn_uV = devm_regulator_get_enable_read_voltage(dev, "refn");
+	if (st->refn_uV < 0 && st->refn_uV != -ENODEV)
+		return dev_err_probe(dev, st->refn_uV, "Failed to get refn regulator\n");
+
+	st->start_gpiod = devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LOW);
+	if (IS_ERR(st->start_gpiod))
+		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
+				     "Failed to get start GPIO\n");
+
+	st->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpiod))
+		return dev_err_probe(dev, PTR_ERR(st->reset_gpiod),
+				     "Failed to get reset GPIO\n");
+
+	st->num_channels = device_get_named_child_node_count(dev, "channel");
+	if (!st->num_channels)
+		return dev_err_probe(dev, -ENXIO,
+				     "No 'channel' nodes configured\n");
+	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
+		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
+
+	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
+				    GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
+	device_for_each_named_child_node_scoped(dev, node, "channel") {
+		ret = fwnode_property_read_u32(node, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: Failed to read channel reg\n",
+					     fwnode_get_name(node));
+		if (reg >= st->num_channels)
+			return dev_err_probe(dev, -EINVAL, "%s: reg out of range\n",
+					     fwnode_get_name(node));
+
+		ret = ads1262_parse_channel_node(st, &st->channels[reg], node);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ads1262_spi_probe(struct spi_device *spi)
+{
+	const struct ads1262_chip_info *info;
+	struct iio_chan_spec *channels;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ads1262 *st;
+	int num_channels;
+	int ret;
+
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->indio_dev = indio_dev;
+	st->info = info;
+	init_completion(&st->drdy);
+	dev_set_drvdata(dev, st);
+
+	ret = devm_mutex_init(dev, &st->chan_lock);
+	if (ret)
+		return ret;
+	ret = devm_mutex_init(dev, &st->xfer_lock);
+	if (ret)
+		return ret;
+
+	ret = ads1262_parse_firmware(st);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, &ads1262_regmap_bus, st,
+				      &ads1262_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ads1262_dev_configure(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure device\n");
+
+	num_channels = ads1262_alloc_channels(st, &channels);
+	if (num_channels < 0)
+		return num_channels;
+	indio_dev->name = info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads1262_iio_info;
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+
+	if (spi->irq > 0) {
+		ret = devm_request_irq(dev, spi->irq, ads1262_irq_handler,
+				       IRQF_NO_THREAD, info->name, st);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct ads1262_chip_info ads1262_chip_info = {
+	.name = "ads1262",
+	.has_aux_adc = false,
+};
+
+static const struct ads1262_chip_info ads1263_chip_info = {
+	.name = "ads1263",
+	.has_aux_adc = true,
+};
+
+static const struct of_device_id ads1262_of_match[] = {
+	{ .compatible = "ti,ads1263", .data = &ads1263_chip_info },
+	{ .compatible = "ti,ads1262", .data = &ads1262_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1262_of_match);
+
+static const struct spi_device_id ads1262_spi_match[] = {
+	{ .name = "ads1263", .driver_data = (kernel_ulong_t)&ads1263_chip_info },
+	{ .name = "ads1262", .driver_data = (kernel_ulong_t)&ads1262_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1262_spi_match);
+
+static struct spi_driver ads1262_spi_driver = {
+	.driver = {
+		.name = "ads1262",
+		.of_match_table = ads1262_of_match,
+	},
+	.probe = ads1262_spi_probe,
+	.id_table = ads1262_spi_match,
+};
+module_spi_driver(ads1262_spi_driver);
+
+MODULE_DESCRIPTION("Texas Instruments ADS1262 ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

-- 
2.54.0

