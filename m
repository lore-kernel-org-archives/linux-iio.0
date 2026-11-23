Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446466;
	b=EZK9yCZfAedXOQQdvjU8D80MnI0k4R1RlvGeJvawSMIxQyMa7Tcp8fF3nxckGxn7u1mR
	 OMR4HjxaZn8YnSpT0RdPzWcASbqpZpkqfrLsU4m7EQsVgcPOo2/nTYvDYRzeyRzUVYQOl
	 +G9k3hHqjiEcv3h0xa1Pz+Wve/BdfT2IHdFMM8Pz4huhP2QKWlnQkxzW9ZyI4Te/eSvQw
	 D+XYsYVQr+zGcUYDMCqE935R2LLM/0LhiIlKWL6RoMfLuKE04BeF2k5EMWHK61FDwey4f
	 rEJmCm0OgoEAQVGPZiHCuJZFAaXonzuUNRQUl0OWft8MnQEAgvLdoUZL83u2BK798kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4K5M6eIEHJCEe+j2qdGOKPIFDzNJEjCy8IZr0uebMwE=;
	b=qMrS21tXSc01nakMMuYvD4m9ZVBbzGyDjbVPASU7mkLx5vHOUMx4P0gs8kC0Rnl7XfeA
	 cg5x4du2Qlp6b3coE6kINcBfViPuV7XR7pZwF1uwgiypyNBisws+xfpLfTxK5X4wV41qy
	 tlqtiSUhO1YxzWLd6+R0/RlJ7zkMg6qv05M78iHypMuwZnYcH1OOmB7BpZLIi/v9OOBrK
	 2uDr0EpsMWAqWS93zAd2dYhh4lC/36f4KoxforULtjRWCxdZPN7Pm+OaQHrup8I48SoV+
	 tqRLPrHu/9hfMpyRzsi+Su5rBYvE4fxtg3aNq69LRYYm1Pnpo8f30veTfSnoFfxINzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQXONmWc;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E328606A335
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E328606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQXONmWc
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8c60e0d39so4361747a12.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446464; x=1796051264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4K5M6eIEHJCEe+j2qdGOKPIFDzNJEjCy8IZr0uebMwE=;
        b=mQXONmWck/zYv4xAHnqQ4dFbY13/2oKuosJUYa7yen4DH68IKVPm0W/xzWIt6++SJn
         4+e6wPxyqkGV2Gk8FvdviYcIZ0TUK7Mf+ptSyjNckvDICr5gj8xC2uDNd9qUUW0KeiLX
         Pzi8VTCxHfwlioFnPYGrUHSvI5RLhPOL7vd4pK/jEG2t/IpDMa9s046fZfGJOWGBD55j
         bcvbow9dNkeKySSBCyU1/ViIii1AKi5dpq46KQMAWubtljnQr36lt7bIhPWzTzc4+jyO
         gDRJolT6GJkGxa0rjX7M0wiXxWiZ9uO19gdQrYQZWYQu64Kt1uhWuy0n3Zi4Hto1uuvK
         8yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446464; x=1796051264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4K5M6eIEHJCEe+j2qdGOKPIFDzNJEjCy8IZr0uebMwE=;
        b=YOFh4wXEXK0cFo3fM3Bw/FbTniPSaDV96l4yGlySsmKl5BE5yXQFQ3r8RZutNBoR3O
         cn8ndaZyOFG5i91m6hF4ynO1PgXci2sp+wVSsS6FKC0x57Xx/zF/d8CIKJSWKEKwvLHb
         eKJ+5ze5U6cLiYAZavEtG8aUey60VKVMFyCQFTgvPGbWwVhqvbn7tFeucOHzQlrKruI0
         A07n7dTMr+no3l4INqCSudZuTSh/BM3f0WfbSpA0H9+TOH9HDG8xLKY575+s0T6y0Xa9
         RS31GrX4W/kJlWjFp97eJjdCRCnQJyTIseJrtBMkML5mQ80DBu3J8pLB/7fARbnl4noA
         jaVw==
X-Forwarded-Encrypted: i=1; AL+hErF0kDt4vMqsEjvdS0KACgSCyXfDHcXyzm1jenLKp2Nd7fkxM0oDskMlOvafAIr7urbZ7lc0dlT3DF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xjK5GkR0M4dvp5dWWpyAwvcAd1mxT9GOk3GSsuwxfi1eMkEeK
	5gL2xCu2olgGH6mnhrg9Etcfcf6FMGBksAEwu5mgCrOI9aRdwJsMurKY
X-Gm-Gg: AZFdTZeHl2AkuNZjinHK+xxcw5tpDV0lvNoVHf74nYZ4gAZHOM1uYbGfJ1Ns4MyEYGV
	b1trvfiQfnoZsIa7NAu47nIzg7pUdnbQiTWUVOFiUaqUGrl2PJV696IUdD9B2QhXEY6Fsepyur3
	TJmyxRprMa10oWSdwX20SYp/JrDSfm/Xm4K8o7niEm+kJlZRXYWGHJNiWBOY70dDTcEf5SEq1hL
	4QVeRaDS/vaPNgFd6g7ceEIX++YhQrcDBxcwiNDju6WEfFMCzr23in0uE986CVnftshn0I8kWKc
	hN1pY/TIHFWTqRBkvKn/v37CyL0zmvKAwC698BhfDJyBqaXujlg7S5gS4xJHMhsI0laRV4vfXgX
	dk7+pxYUZJiZmJUeTsk2mDyB7n4ah0G9nzsqCzoeur7Ezfhq2FNYBC5KM0DZxiBwZECs+rNvWr1
	Hio2bgKQalvSLtEJ7j95Gmf4bccr1b2h+0lpEcjngu9ADRdHq9MD5uMrstqCFq61oN3hhcyBGuZ
	EUe0/raPBWPYF4+QU91Nz0RxpLZRbwKDH1tqTcX5zhVrsJBmWjV/obnxHTDy9zbZo/gZZtnub4d
	Ezc3e7IokT5w2wT3I98/j9RP2vASUW+QPqPf22gyEaRid7rMNUI6PBGze0D3b6t38KPWTQx6u21
	PewLmV8Ei7Q==
X-Received: by 2002:a05:6402:51a:b0:6b7:c9d3:f3d with SMTP id 4fb4d7f45d1cf-6ba37d606c8mr7093734a12.15.1795446463532;
        Mon, 23 Nov 2026 07:07:43 -0800 (PST)
Received: from xeon ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm5446279a12.25.2026.11.23.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:07:42 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v3 3/4] iio: adc: Add support for MAX8907 ADC cell
Date: Mon, 23 Nov 2026 17:07:24 +0200
Message-ID: <20261123150725.212836-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123150725.212836-1-clamor95@gmail.com>
References: <20261123150725.212836-1-clamor95@gmail.com>
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

The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channels
with information about different parts of the power system, including the
battery, charger/plug, jack and thermal readings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/max8907-adc.c | 181 ++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/iio/adc/max8907-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab5..a5d0f8727af70 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1194,6 +1194,16 @@ config MAX77541_ADC
 	  To compile this driver as a module, choose M here:
 	  the module will be called max77541-adc.
 
+config MAX8907_ADC
+	tristate "Maxim MAX8907 ADC driver"
+	depends on MFD_MAX8907
+	help
+	  Say yes here to build support for 8 channel 12-bit ADC
+	  interface found in the Maxim MAX8907 PMIC.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called max8907-adc.
+
 config MAX9611
 	tristate "Maxim max9611/max9612 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 769965295dccb..af89115978316 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX40080) += max40080.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
+obj-$(CONFIG_MAX8907_ADC) += max8907-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max8907-adc.c b/drivers/iio/adc/max8907-adc.c
new file mode 100644
index 0000000000000..895b313a6e01f
--- /dev/null
+++ b/drivers/iio/adc/max8907-adc.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bits.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/mfd/max8907.h>
+
+#define MAX8907_ADC_SCHED_AUTOSCH_ENABLE	BIT(1)
+#define MAX8907_ADC_SCHED_AUTOSCH_TIME		BIT(0)
+
+#define MAX8907_TO_REG(n)			((n) & 0xff)
+#define MAX8907_TO_MEASURE(n)			(((n) >> 8) & 0xff)
+
+enum {
+	TDIE = 0,
+	THM = 1,
+	ISNS = 2,
+	VMBATT = 3,
+	VBBATT = 4,
+	VCHG = 5,
+	AUX2 = 6,
+	AUX1 = 7,
+};
+
+static const u32 max8907_default_ref[] = {
+	[TDIE] = 4096,
+	[THM] = 4096,
+	[ISNS] = 4096,
+	[VMBATT] = 8192,
+	[VBBATT] = 8192,
+	[VCHG] = 8192,
+	[AUX2] = 2500,
+	[AUX1] = 4096,
+};
+
+#define MAX8907_CHAN(_type, _idname, _datasheet_name) {		\
+	.type = (_type),					\
+	.address = MAX8907_REG_##_idname##_MSB |		\
+		   MAX8907_REG_##_idname##_MEASURE << 8,	\
+	.indexed = 1,						\
+	.channel = (_idname),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_idname),				\
+	.scan_type = {						\
+		.format = IIO_SCAN_FORMAT_UNSIGNED_INT,		\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.datasheet_name = (_datasheet_name),			\
+}
+
+static const struct iio_chan_spec max8907_adc_channels[] = {
+	MAX8907_CHAN(IIO_VOLTAGE, TDIE,   "tdiode"),
+	MAX8907_CHAN(IIO_VOLTAGE, THM,    "thermistor"),
+	MAX8907_CHAN(IIO_CURRENT, ISNS,   "isense"),
+	MAX8907_CHAN(IIO_VOLTAGE, VMBATT, "vmbatt"),
+	MAX8907_CHAN(IIO_VOLTAGE, VBBATT, "vbbatt"),
+	MAX8907_CHAN(IIO_VOLTAGE, VCHG,   "vcharge"),
+	MAX8907_CHAN(IIO_VOLTAGE, AUX2,   "aux2"),
+	MAX8907_CHAN(IIO_VOLTAGE, AUX1,   "aux1"),
+};
+
+static int max8907_adc_read(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct regmap **regmap = iio_priv(indio_dev);
+	__be16 data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_write(*regmap, MAX8907_TO_MEASURE(chan->address), 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_bulk_read(*regmap, MAX8907_TO_REG(chan->address), &data, sizeof(data));
+		if (ret)
+			return ret;
+
+		*val = be16_to_cpu(data) >> 4;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = max8907_default_ref[chan->channel];
+		*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max8907_adc_info = {
+	.read_raw = &max8907_adc_read,
+};
+
+static int max8907_adc_init(struct regmap *regmap)
+{
+	u32 value;
+	int ret;
+
+	/* Enable internal voltage reference. Exact purpose of bits is not known. */
+	ret = regmap_update_bits(regmap, MAX8907_REG_TSC_CNFG1, GENMASK(1, 0), BIT(1));
+	if (ret)
+		return ret;
+
+	/* Check for internal reference IRQ */
+	ret = regmap_read_poll_timeout(regmap, MAX8907_REG_TSC_STA_INT, value,
+				       !(value & MAX8907_MASK_NREF_OK), 10, 1000);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(regmap, MAX8907_REG_ADC_SCHED,
+				  MAX8907_ADC_SCHED_AUTOSCH_ENABLE |
+				  MAX8907_ADC_SCHED_AUTOSCH_TIME,
+				  MAX8907_ADC_SCHED_AUTOSCH_ENABLE);
+}
+
+static int max8907_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct max8907 *max8907 = dev_get_drvdata(dev->parent);
+	struct iio_dev *indio_dev;
+	struct regmap **regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*regmap));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = iio_priv(indio_dev);
+
+	*regmap = max8907->regmap_adc;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max8907_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max8907_adc_channels);
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &max8907_adc_info;
+
+	/*
+	 * The ADC does not require a dedicated node; hence, the PMIC is set as
+	 * the iio_dev parent to enable the use of the PMIC node phandle in the
+	 * Device Tree bindings.
+	 */
+	iio_device_set_parent(indio_dev, dev->parent);
+
+	ret = regmap_set_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
+			      MAX8907_MASK_INT_REF_EN);
+	if (ret)
+		return ret;
+
+	ret = max8907_adc_init(max8907->regmap_adc);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver max8907_adc_driver = {
+	.driver.name = "max8907-adc",
+	.probe = max8907_adc_probe,
+};
+module_platform_driver(max8907_adc_driver);
+
+MODULE_ALIAS("platform:max8907-adc");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX8907 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

