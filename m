Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946063B6C06
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161539; cv=none; b=c9t3Ym2dRzZhXsvYAp3+T8wMcvHVteDmrRHHn8W5ZFlEhM1PVlrDWzJQ6SbiTsHDU6YTijk6MPIpkup5aUdKugim2qXHD0d8T5Kz4hopDSrEDwWSWvqfB+w+5XTT+otANOKlYfqD47L00QexgYVRtRDTsRQol7DKdPB+EV1HDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161539; c=relaxed/simple;
	bh=CvrGOCn7U7uZ0sRlrVy9tzLAGI+QOjo835DiJl1KiWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mK41iAgKpFkd7QdAqjeMorCoL2KS72i8GcalyhuvL5Gq5gDzhQe7S2POCsATcjAQawr2Aw9f6jFWS7/MpYHvADdpq2AiRajauO5JdopoOHcCyshQLTYZYEMBverPFbM2GAADxs/HeF2A7mPmAZ4UnNjrCpSMNejWWwWyjEseIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAHa85k+; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHa85k+"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfaa014978so88701e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161534; x=1786766334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAlBmg+SAGiE1EmSqmWetavoPb4EdPoSaiq6YE9hmhM=;
        b=EAHa85k+9+cVf8rQPJZQ8AHNHd6dF8AFbVhYvk/oAJ8F8UijhvaOHBifIcE3Jddt9p
         nd7s4ZraQLfdZae/xSJkU7/Pj/NjWoTbEPN6W/YhFCaP3hjR9TvU5i3aXU4TmyMkCv3f
         QbAduev6VgN8vtehGzv7YZI526K32CYBXaRv/Rr6WHIRFaPblJu2u5gQCnvXrfCF44fn
         swy6l9vSvkEIvGKBeK9QIlkn+Xx8GftOi80krUUJJsRWh2RcznUIis4slyz5r2E7BDdj
         4cBWXIqrbtnrdfDdzhhdNCxbZIOyyik0llV1mtsO5qZOxnSdNnZdCCCT7MiyVEGUhXmD
         XGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161534; x=1786766334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAlBmg+SAGiE1EmSqmWetavoPb4EdPoSaiq6YE9hmhM=;
        b=p8tt2p7+aPCMggONh4zQfQJj18WvDnv+EL7uwsPBsEVqmewscb5GbbpnJRUAgSyE9P
         yATmw+fTPN1qLae3J4hxXUXNkDK6y1xKDNpL1pMe6e9XvsXoy6FRb2Qmj0voK5nlsh4W
         YHR3su02aHB6DQNNZJrZp0u68lV8pbrmzYCZq1GdOyaPsoYPX0DgQ++SV1B+oJmNdSwg
         Ptj6a+pVafvhFiv/syMe7EPjJ4Fjyj142Dr7iCvGK9WkuznsK6pbRiXPSGiq7i0DbViv
         /U+IjME7pA+5LGx0qgVi+SIio/oidVJCP5A0cjaF1NEEoSh6sn9PyJECh5MJb+XJk7Tg
         DIvg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/cA0cU8PvJD/KL5+iZDpdPE/UqL6geO0NuhwrUBKgQmh89A/rX5gqgvJrU8jJ6izeXHOmVrUV+YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SRppn7wAF7E7O2XQXCza2F4k6veH03eCba+0iCMHUu87WUgE
	dgUFsJ9jDQ1sUgE3VarH7lFUBEdMvtEMxi2d2NEVcLa9D6aSapWsYy8h
X-Gm-Gg: AR+sD11Q6y9FBT8LhNLezMksA1pQPqSPSxlORUEedCxKa6nOPHPzjVky50FoK42yoAq
	clOiHSXTh18kA9H1U1KebsvyR4cKUrnn9eJv+3X8OSa8cRQJeFRL5QC+Gsauqz9JcuJoaXAUku9
	+nisHjtfnK84RcdVJ9T9g4fVzUFZV0iY2yJGeRlbi/sginKihjCC2c8vwKAYFyykZ6H9qy7n8O0
	9uR860/WNSg2FtPm9W4syds5m/1h4Pb5pwqqB3blJT+mRteQWhBJU/fW8pkJ0YLrWMiLxiAwmGY
	/dHANTILx+2aW0wn04UFA5I31sN56Vg4ZI9gHdywlbWhkPy5ai4DVzTb8TH2tt7ij6SasmvFsws
	l1GvJZ0DetGEl14uRdex445y0PgqDsHWsBeR7AtP2kFDpmrGPvalvSNc/LR3kjVs+M1gBc6I4Ps
	5zp80XMVSM/NX9w3w/RI61pNoaWNMkvKWdEKHKDVwa8fioHy4uZWF+dG5Y8Bh84abPcwAKQA==
X-Received: by 2002:a05:6122:2492:b0:5c1:781:7122 with SMTP id 71dfb90a1353d-5c3d907e08amr3054689e0c.3.1786161534377;
        Fri, 07 Aug 2026 20:58:54 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:58:54 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:24 -0500
Subject: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-2-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=26029; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=CvrGOCn7U7uZ0sRlrVy9tzLAGI+QOjo835DiJl1KiWQ=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllK8vjbotJ1wqcvGzxZ6GtT8ixytx4wX4n75LwA63S8
 /awntPoKGVhEONikBVTZGlPWPTtUVTeW78Dofdh5rAygQxh4OIUgIlE9zL8U3rsIL6d9Y7OCV62
 NiWOw2Uds+I7iyL0M84tY6z43P3jFyPDdJeMeLsDSdqFH84pCXbUa3S0tupahXD2PYkvL752N5M
 NAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add the ti-ads1262 driver with initial support for the primary ADC
(ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
and interoperability considerations were taken into account.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  11 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1262.c | 847 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 860 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9248979b801..3ee4a2f80733 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27006,6 +27006,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+F:	drivers/iio/adc/ti-ads1262.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 990e7b3e7212..dbf76427912b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1841,6 +1841,17 @@ config TI_ADS124S08
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads124s08.
 
+config TI_ADS1262
+	tristate "Texas Instruments ADS1262"
+	depends on SPI
+	select REGMAP
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
index dcec0abb03b7..f85b89859fe9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -157,6 +157,7 @@ obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
+obj-$(CONFIG_TI_ADS1262) += ti-ads1262.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS131M02) += ti-ads131m02.o
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
new file mode 100644
index 000000000000..d78e5e3ae13e
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -0,0 +1,847 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Texas Instruments ADS1262 ADC driver
+ *
+ * Copyright (C) 2026 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/compiler_attributes.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/lockdep.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
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
+#define     ADS1262_IDACMUX_NO_CONN		0xB
+
+#define ADS1262_IDACMAG_REG			0x0E
+
+#define ADS1262_REFMUX_REG			0x0F
+#define ADS1262_TDACP_REG			0x10
+#define ADS1262_TDACN_REG			0x11
+#define ADS1262_GPIOCON_REG			0x12
+#define ADS1262_GPIODIR_REG			0x13
+#define ADS1262_GPIODAT_REG			0x14
+#define ADS1262_ADC2CFG_REG			0x15
+
+#define ADS1262_ADC2MUX_REG			0x16
+#define   ADS1262_ADC2MUX_MUXP2_MASK		GENMASK(7, 4)
+#define   ADS1262_ADC2MUX_MUXN2_MASK		GENMASK(3, 0)
+
+#define ADS1262_ADC2OFC0_REG			0x17
+#define ADS1262_ADC2OFC1_REG			0x18
+#define ADS1262_ADC2FSC0_REG			0x19
+#define ADS1262_ADC2FSC1_REG			0x1A
+
+#define ADS1262_REG_COUNT			0x1B
+
+#define ADS1262_MAX_CHANNEL_COUNT		16
+#define ADS1262_MAX_REGMAP_WRITE		8
+#define ADS1262_ADC1_RESOLUTION			32
+
+enum {
+	ADS1262_RUNMODE_CONTINUOUS,
+	ADS1262_RUNMODE_PULSE,
+};
+
+enum {
+	ADS1262_FILTER_SINC1,
+	ADS1262_FILTER_SINC2,
+	ADS1262_FILTER_SINC3,
+	ADS1262_FILTER_SINC4,
+	ADS1262_FILTER_FIR,
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
+};
+
+struct ads1262_chip_info {
+	const char *name;
+};
+
+struct ads1262 {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpiod;
+	struct gpio_desc *start_gpiod;
+	unsigned long clk_rate;
+
+	/* Protects channel state */
+	struct mutex chan_lock;
+	unsigned int num_channels;
+	struct completion drdy;
+
+	/* Protects transfer buffers and concurrent SPI transfers */
+	struct mutex xfer_lock;
+};
+
+static int ads1262_dev_cmd(struct ads1262 *st, u8 opcode)
+{
+	guard(mutex)(&st->xfer_lock);
+
+	return spi_write_then_read(st->spi, &opcode, sizeof(opcode), NULL, 0);
+}
+
+static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *val)
+{
+	guard(mutex)(&st->xfer_lock);
+
+	return spi_write_then_read(st->spi, &cmd, sizeof(cmd), val, sizeof(*val));
+}
+
+static int ads1262_dev_reset(struct ads1262 *st)
+{
+	int ret;
+
+	if (st->reset_gpiod) {
+		ret = gpiod_set_value_cansleep(st->reset_gpiod, 1);
+		if (ret)
+			return ret;
+
+		/*
+		 * The RESET pulse timing requirement is 4 clock cycles, at the
+		 * minimum clock rate this is 4 microseconds.
+		 */
+		fsleep(4);
+
+		ret = gpiod_set_value_cansleep(st->reset_gpiod, 0);
+		if (ret)
+			return ret;
+
+		/*
+		 * The RESET timing requirement is 8 clock cycles, at the
+		 * minimum clock rate this is 8 microseconds
+		 */
+		fsleep(8);
+	} else {
+		ret = ads1262_dev_cmd(st, ADS1262_OPCODE_RESET);
+		if (ret)
+			return ret;
+
+		/*
+		 * The RESET timing requirement is 8 clock cycles, at the
+		 * minimum clock rate this is 8 microseconds
+		 */
+		fsleep(8);
+	}
+
+	return 0;
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
+static int ads1262_dev_start_one(struct ads1262 *st)
+{
+	int ret;
+
+	ret = ads1262_dev_start(st);
+	if (ret)
+		return ret;
+
+	if (st->start_gpiod) {
+		/*
+		 * The START pulse timing requirement is 4 clock cycles, at the
+		 * minimum clock rate this is 4 microseconds.
+		 */
+		fsleep(4);
+		return ads1262_dev_stop(st);
+	}
+
+	return 0;
+}
+
+static int ads1262_wait_for_conversion(struct ads1262 *st)
+{
+	u64 max_lat_ms;
+	long ret;
+
+	/*
+	 * The first conversion latency is affected by the channel's data rate,
+	 * filter, the configurable conversion delay and whether chop mode
+	 * and/or IDAC rotation mode are enabled.
+	 *
+	 * The worst possible latency is calculated by taking the lowest data
+	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600 ms
+	 * (Table 9-13). Then we scale it by the actual clock rate and multiply
+	 * by 4 to account for chop and IDAC rotation modes (Equation 20).
+	 */
+	max_lat_ms = 4 * div_u64(mul_u32_u32(1600, 7372800), st->clk_rate);
+
+	ret = wait_for_completion_interruptible_timeout(&st->drdy,
+							msecs_to_jiffies(max_lat_ms));
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ads1262_channel_enable(struct ads1262 *st,
+				  const struct iio_chan_spec *spec)
+{
+	u8 val;
+
+	guard(mutex)(&st->xfer_lock);
+	guard(mutex)(&st->chan_lock);
+
+	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
+	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
+	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
+				 ADS1262_INPMUX_MUXN_MASK |
+				 ADS1262_INPMUX_MUXP_MASK, val);
+}
+
+static int ads1262_set_runmode(struct ads1262 *st, u8 runmode)
+{
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				  ADS1262_MODE0_RUNMODE_MASK,
+				  FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, runmode));
+}
+
+static int ads1262_channel_read(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *spec, __be32 *val)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_PULSE);
+	if (ret)
+		return ret;
+
+	ret = ads1262_channel_enable(st, spec);
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->drdy);
+
+	ret = ads1262_dev_start_one(st);
+	if (ret)
+		return ret;
+
+	ret = ads1262_wait_for_conversion(st);
+	if (ret)
+		return ret;
+
+	return ads1262_dev_read_by_cmd(st, ADS1262_OPCODE_RDATA1, val);
+}
+
+static int ads1262_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	__be32 raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads1262_channel_read(indio_dev, chan, &raw);
+		if (ret)
+			return ret;
+		*val = sign_extend32(be32_to_cpu(raw), ADS1262_ADC1_RESOLUTION - 1);
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				      unsigned int writeval, unsigned int *readval)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	if (readval)
+		return regmap_read_bypassed(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ads1262_iio_info = {
+	.read_raw = ads1262_read_raw,
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
+static int ads1262_dev_configure(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = ads1262_dev_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to reset device\n");
+
+	guard(mutex)(&st->xfer_lock);
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
+	return 0;
+}
+
+static bool ads1262_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS1262_ID_REG ... ADS1262_ADC2FSC1_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ads1262_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS1262_POWER_REG ... ADS1262_ADC2FSC1_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ads1262_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADS1262_POWER_REG:
+	case ADS1262_OFCAL0_REG ... ADS1262_FSCAL2_REG:
+	case ADS1262_GPIODAT_REG:
+	case ADS1262_ADC2OFC0_REG ... ADS1262_ADC2FSC1_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default ads1262_reg_defaults[] = {
+	{ ADS1262_INTERFACE_REG,
+	  FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
+	  FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true) },
+	{ ADS1262_MODE0_REG,		0x00 },
+	{ ADS1262_MODE1_REG,
+	  FIELD_PREP_CONST(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR) },
+	{ ADS1262_MODE2_REG,
+	  FIELD_PREP_CONST(ADS1262_MODE2_DR_MASK, ADS1262_DR_20_SPS) },
+	{ ADS1262_INPMUX_REG,
+	  FIELD_PREP_CONST(ADS1262_INPMUX_MUXN_MASK, ADS1262_INPMUX_AIN1) },
+	{ ADS1262_IDACMUX_REG,
+	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX2_MASK, ADS1262_IDACMUX_NO_CONN) |
+	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX1_MASK, ADS1262_IDACMUX_NO_CONN) },
+	{ ADS1262_IDACMAG_REG,		0x00 },
+	{ ADS1262_REFMUX_REG,		0x00 },
+	{ ADS1262_TDACP_REG,		0x00 },
+	{ ADS1262_TDACN_REG,		0x00 },
+	{ ADS1262_GPIOCON_REG,		0x00 },
+	{ ADS1262_GPIODIR_REG,		0x00 },
+	{ ADS1262_ADC2CFG_REG,		0x00 },
+	{ ADS1262_ADC2MUX_REG,
+	  FIELD_PREP_CONST(ADS1262_ADC2MUX_MUXN2_MASK, ADS1262_INPMUX_AIN1) },
+};
+
+static const struct regmap_config ads1262_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = ads1262_writeable_reg,
+	.readable_reg = ads1262_readable_reg,
+	.volatile_reg = ads1262_volatile_reg,
+	.reg_defaults = ads1262_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ads1262_reg_defaults),
+	.max_register = ADS1262_ADC2FSC1_REG,
+	.can_sleep = true,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ads1262_regmap_read(void *context, const void *reg_buf,
+			       size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct ads1262 *st = context;
+	u8 tx[2];
+
+	lockdep_assert_held(&st->xfer_lock);
+
+	/*
+	 * The register read operation uses a two byte command header followed
+	 * by the register data:
+	 *
+	 *	byte 0:   RREG opcode | register address
+	 *	byte 1:   number of registers to transfer, minus one
+	 *	byte 2..: register data
+	 */
+	memcpy(tx, reg_buf, 1);
+	tx[0] |= ADS1262_OPCODE_RREG;
+	tx[1] = val_size - 1;
+
+	return spi_write_then_read(st->spi, tx, sizeof(tx), val_buf, val_size);
+}
+
+static int ads1262_regmap_gather_write(void *context, const void *reg_buf,
+				       size_t reg_size, const void *val_buf,
+				       size_t val_size)
+{
+	struct ads1262 *st = context;
+	u8 tx[ADS1262_MAX_REGMAP_WRITE + 2];
+
+	lockdep_assert_held(&st->xfer_lock);
+
+	/*
+	 * The register write operation uses a two byte command header followed
+	 * by the register data:
+	 *
+	 *	byte 0:   WREG opcode | register address
+	 *	byte 1:   number of registers to transfer, minus one
+	 *	byte 2..: register data
+	 */
+	memcpy(tx, reg_buf, 1);
+	tx[0] |= ADS1262_OPCODE_WREG;
+	tx[1] = val_size - 1;
+	memcpy(&tx[2], val_buf, val_size);
+
+	return spi_write_then_read(st->spi, tx, 2 + val_size, NULL, 0);
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
+	.max_raw_write = ADS1262_MAX_REGMAP_WRITE,
+};
+
+static int ads1262_gpio_setup(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->start_gpiod = devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LOW);
+	if (IS_ERR(st->start_gpiod))
+		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
+				     "failed to get start GPIO\n");
+
+	st->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpiod))
+		return dev_err_probe(dev, PTR_ERR(st->reset_gpiod),
+				     "failed to get reset GPIO\n");
+
+	/*
+	 * The power transition timing requirement is 65536 clock cycles, at the
+	 * minimum clock frequency this is 65536 microseconds.
+	 */
+	fsleep(65536);
+
+	return 0;
+}
+
+static int ads1262_parse_channel_node(struct ads1262 *st,
+				      struct iio_chan_spec *spec,
+				      struct fwnode_handle *node)
+{
+	struct device *dev = &st->spi->dev;
+	u32 pins[2];
+	int ret;
+
+	if (fwnode_property_present(node, "single-channel")) {
+		ret = fwnode_property_read_u32(node, "single-channel", &pins[0]);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: failed to read single-channel\n",
+					     fwnode_get_name(node));
+
+		pins[1] = ADS1262_INPMUX_AINCOM;
+		fwnode_property_read_u32(node, "common-mode-channel", &pins[1]);
+	} else if (fwnode_property_present(node, "diff-channels")) {
+		ret = fwnode_property_read_u32_array(node, "diff-channels", pins,
+						     ARRAY_SIZE(pins));
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: failed to read diff-channels\n",
+					     fwnode_get_name(node));
+
+		if (pins[0] <= ADS1262_INPMUX_AINCOM || pins[1] <= ADS1262_INPMUX_AINCOM)
+			spec->differential = true;
+	} else {
+		return dev_err_probe(dev, -ENXIO,
+				     "%s: one of single-channel or diff-channels is required\n",
+				     fwnode_get_name(node));
+	}
+
+	if (pins[0] >= ADS1262_INPMUX_FLOAT || pins[1] >= ADS1262_INPMUX_FLOAT)
+		return dev_err_probe(dev, -EINVAL, "%s: input channels not in range\n",
+				     fwnode_get_name(node));
+
+	if ((pins[0] >= ADS1262_INPMUX_TEMP ||
+	     pins[1] >= ADS1262_INPMUX_TEMP) && pins[0] != pins[1])
+		return dev_err_probe(dev, -EINVAL,
+				     "%s: monitor channels must be selected symmetrically\n",
+				     fwnode_get_name(node));
+
+	spec->channel = pins[0];
+	spec->channel2 = pins[1];
+
+	return 0;
+}
+
+static int ads1262_parse_channels(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct iio_chan_spec *specs;
+	unsigned long used_regs = 0;
+	int num_specs;
+	u32 reg;
+	int ret;
+
+	st->num_channels = device_get_named_child_node_count(dev, "channel");
+	if (!st->num_channels)
+		return dev_err_probe(dev, -ENXIO, "no 'channel' nodes configured\n");
+	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
+		return dev_err_probe(dev, -EINVAL, "too many channels\n");
+
+	/* Account for the timestamp channel */
+	num_specs = st->num_channels + 1;
+	specs = devm_kcalloc(dev, num_specs, sizeof(*specs), GFP_KERNEL);
+	if (!specs)
+		return -ENOMEM;
+
+	device_for_each_named_child_node_scoped(dev, node, "channel") {
+		ret = fwnode_property_read_u32(node, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: failed to read channel reg\n",
+					     fwnode_get_name(node));
+		if (reg >= st->num_channels)
+			return dev_err_probe(dev, -EINVAL, "%s: reg out of range\n",
+					     fwnode_get_name(node));
+
+		static_assert(ADS1262_MAX_CHANNEL_COUNT < BITS_PER_LONG);
+		if (__test_and_set_bit(reg, &used_regs))
+			return dev_err_probe(dev, -EINVAL, "%s: duplicated channel reg\n",
+					     fwnode_get_name(node));
+
+		specs[reg].scan_index = reg;
+		specs[reg].scan_type = (struct iio_scan_type) {
+			.format = IIO_SCAN_FORMAT_SIGNED_INT,
+			.realbits = ADS1262_ADC1_RESOLUTION,
+			.storagebits = 32,
+			.endianness = IIO_BE,
+		};
+
+		ret = ads1262_parse_channel_node(st, &specs[reg], node);
+		if (ret)
+			return ret;
+
+		if (specs[reg].channel == ADS1262_INPMUX_TEMP)
+			specs[reg].type = IIO_TEMP;
+		else
+			specs[reg].type = IIO_VOLTAGE;
+
+		if (specs[reg].channel != ADS1262_INPMUX_TEMP)
+			specs[reg].indexed = true;
+
+		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	}
+
+	specs[num_specs - 1] = IIO_CHAN_SOFT_TIMESTAMP(num_specs - 1);
+
+	indio_dev->channels = specs;
+	indio_dev->num_channels = num_specs;
+
+	return 0;
+}
+
+static int ads1262_supply_setup(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "avss");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get avss regulator\n");
+
+	return 0;
+}
+
+static int ads1262_spi_probe(struct spi_device *spi)
+{
+	const struct ads1262_chip_info *info;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ads1262 *st;
+	unsigned long rate;
+	struct clk *clk;
+	int irq;
+	int ret;
+
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	indio_dev->name = info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ads1262_iio_info;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	init_completion(&st->drdy);
+
+	ret = devm_mutex_init(dev, &st->chan_lock);
+	if (ret)
+		return ret;
+	ret = devm_mutex_init(dev, &st->xfer_lock);
+	if (ret)
+		return ret;
+
+	ret = ads1262_parse_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get external clock\n");
+
+	rate = clk_get_rate(clk);
+	if (clk && !rate)
+		return dev_err_probe(dev, -ENXIO, "failed to get clock rate\n");
+	st->clk_rate = rate ? rate : 7372800;
+
+	ret = ads1262_supply_setup(st);
+	if (ret)
+		return ret;
+
+	ret = ads1262_gpio_setup(st);
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
+		return dev_err_probe(dev, ret, "failed to configure device\n");
+
+	/*
+	 * REVISIT: This chip has software polling capabilities, which could be
+	 * used to stop depending on the 'drdy' IRQ.
+	 *
+	 * Additionally, the MISO pin also can be used as a DRDY IRQ, in which
+	 * case the interrupt would be named 'dout-drdy', but requires a lot of
+	 * timing and synchronization considerations to be reliable.
+	 */
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
+	if (irq < 0)
+		return dev_err_probe(dev, irq,
+				     "the 'drdy' IRQ is currently required for operation\n");
+
+	ret = devm_request_irq(dev, irq, ads1262_irq_handler, IRQF_NO_THREAD,
+			       info->name, st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct ads1262_chip_info ads1262_chip_info = {
+	.name = "ads1262",
+};
+
+static const struct of_device_id ads1262_of_match[] = {
+	{ .compatible = "ti,ads1262", .data = &ads1262_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1262_of_match);
+
+static const struct spi_device_id ads1262_spi_match[] = {
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
2.55.0

