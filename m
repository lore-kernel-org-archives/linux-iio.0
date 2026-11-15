Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733899;
	b=p73SE9Dkas229QQb2ldk3X0U3aldmmJqHVQf1OMXQ7DWkhmNyVqRFVf/mUOR9sGcLayj
	 JG3ZtSaljF0m4e4/SjDliF73hNIfyYAV1cjgVaS4ohShfRKLefDzSQsZzw+P284H/wmtH
	 DeKKRpTi4oAjdBcw3qWt7/7ODyCUos7///8u2TbvHvHzfaX2fH47nAtyH101aQDKAoPiB
	 GF7281e9prptZBheBv4cgfBd5kC93VX+gli+YZ3HSMVEYtGIt/4WAZ3ZRX1eOimEoEmku
	 5G3BsqoIExXXOczvO4QYEWAUGBxzVSkn2C5TC8uK7Qt4h6rmK23GVjf2ol0EpJXCqww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WyMaoHtuEWoWCmY1vWOmpMj4la6Mpw4MJRQkO0gisb4=;
	b=o6sJ8thlasBpx/JrCVXCSe71QC+e5mAlJYz/Ftj42/+H4KwmBWRtq8EvM5t8E1M8e8Ev
	 WXl45nJKxVTp43jvbDv/+wobmzxtwtR6/LKDZnA9DQP+nh6966S1glK9aA0ZsQSadngPP
	 CUmb/hLLmcqZGsoazyQ2JpEnV0Bd/UJEPqSmQzSrPJ2oLwulbWR35/E1+Nn+WdpMRE+m1
	 vmDza0Gevb73hdnCQyViiMHkicSpwtzRnGrvXFeRA+EQgOJseiPVoWhyUFHT09ahuuGYK
	 FSt26OZwFvOBFx8n3My3odDQUSUIeQa49Mzvv2571lnUg0Abx6kbQPEchHaBXMNdU0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHTpmVAm;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB499606A31E
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB499606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHTpmVAm
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c468bd799ecso371973666b.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794733896; x=1795338696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyMaoHtuEWoWCmY1vWOmpMj4la6Mpw4MJRQkO0gisb4=;
        b=tHTpmVAmuXfO6xhACr2ooRjFyAE/c3XHioSsoHEEY70qgft9KyR6+jvRKcUi9spInK
         bSAskAVmr4C8q1qzC0ju6lUW1Y/pOb3TjPNWwcEazWhK/p0JkzvEHaA+yWPX/fOFDxoq
         cMs3+tHM9APPJObX9pMx0LwqBIJ1S9W/rnZGqnh9FL3H6MkktME8QoI/g4HCjBYBcSjh
         4q7TcGbGUKmWZYj9FwBboNtASOa2X8ii2bJIAkVWQ2Q5AI1KgDYYENf4Da/pCjqE/v9C
         mixIvyoKdRq5uTC/TFciZDsNZZax4Z2oi6afJADXWxaHIC73NZV02ksn3+V+lOMToI9B
         QBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794733896; x=1795338696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WyMaoHtuEWoWCmY1vWOmpMj4la6Mpw4MJRQkO0gisb4=;
        b=G1gZVx15Gs/8cZdaXJWju8hPM0sUgWg9Q/xgvJXAD49Oicmgjser2dmnLxgtDEZC8q
         E7L3h1QzkhRDQJJUB26iOHXg4QfUQxYPXaC6OZFaR8/YQjlETcvCTi00ilo9Nla1SLSM
         KB+52doYsSKjeql2grKhUs75VkNRIfAphcup90e8WIB0wOio40C/vZhGkrOayCCR8Q8H
         +kD9JTjToSji6Kpj/tCIWiCNd30Ti4LV4cxQA5OfUSMNF7HQhkfy4H4qVmtpAIYpZLkv
         pEkgqQ1hJPc+0Q5lQU9ytqa78NPHdZ5IOkjC7hbEd+EQSByujpuRtiTQTRG9XJVt/uC1
         Qn5w==
X-Forwarded-Encrypted: i=1; AL+hErErG0CeHPEClovrrJmj3yMsZ8cXXKUS2L9tV9eeEexMQjSeklzAL1SnXCb8EK9HEZDMv7nALi+Gt94=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EL21dXm0FOMpdS0C27BwbC734Gz1Co+aLjHnWM2gLzoTZmF7i
	bIMOP3ffMyMTlG08v0gqsVf4rAO21m79v4fcXeoKrwZztv9Hqm2+wSj8
X-Gm-Gg: AYBFou0g5xt0ZktrAvx8goN0O4vOus5kofz0+y6kfFRXJqaW1wUkHe5fM7HwIotDmYe
	elbW61EddrOg8m0T7RWEN/cfRqbgWtYBf07/hqldO/nGJIUpoIGvJv164yKIvQsEQqU4Va0kOsk
	bxVdtj8p40ZDB3jic6/U+4Xc2LdYfCLO+SBYdh80LvybP0Jl2/j6GH8htKnNhqKymkLbs4azEKg
	9qXh7WTKSHBvUUhOfVHLcAkBmtOvvFAuoThRKLLUJPDP/lhheZRQHFwQHKFmA2mNLU2Oig3rC1v
	pKZCPj+cI2JwZ01lej9jKJX10a4zu9tF7Ut3KyWAa+rDzBdzDPJBHReyuJwYvVI3GKxS8Blu+x2
	vbwkoNJakDMJd7vQ3dDxuARgohPuvv0sGe3dEsd5V+ZLGw6E0hw3jsMFddX7x2GQWSgtWRuj06V
	K5Y1icklnzAg/kd8K3eZnCu5ze87fwIBM/g4Fk5bLLrOfMUcyAZDknKj+5BF1qc9FTpkDdUiTSU
	Qxkq9V0HvRjdknPNtgqOnfI/iaTuhD1NorMqA39InxBIvTeJEH1eOwDK35Bvr/AU+1DtDyxmq7Z
	h35Bbs7coqZYVKVadjiihD1/yQrMzIjaIlUb7CeLd9LnE39YdngRUxa6wPADpK5qPw95QqLrJrJ
	eBsL6aJ7y7G3fHu/MmfSFTr2A/iccHnM=
X-Received: by 2002:a17:906:c14d:b0:c50:5cd7:2901 with SMTP id a640c23a62f3a-c509640bfa8mr557945766b.23.1794733896267;
        Sun, 15 Nov 2026 01:11:36 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm289392366b.32.2026.11.15.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:11:34 -0800 (PST)
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
Subject: [PATCH v2 3/4] iio: adc: Add support for MAX8907 ADC cell
Date: Sun, 15 Nov 2026 11:11:19 +0200
Message-ID: <20261115091120.108684-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115091120.108684-1-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
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
 drivers/iio/adc/max8907-adc.c | 169 ++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/iio/adc/max8907-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f8456c8039883..4d5bd8f93fb8c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1176,6 +1176,16 @@ config MAX77541_ADC
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
index d7bb4815df61c..8e6755315aa35 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX40080) += max40080.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
+obj-$(CONFIG_MAX8907_ADC) += max8907-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max8907-adc.c b/drivers/iio/adc/max8907-adc.c
new file mode 100644
index 0000000000000..1776032efc913
--- /dev/null
+++ b/drivers/iio/adc/max8907-adc.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mfd/max8907.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define MAX8907_ADC_SCHED_AUTOSCH_ENABLE	BIT(1)
+#define MAX8907_ADC_SCHED_AUTOSCH_TIME		BIT(0)
+
+#define MAX8907_TO_REG(n)			((n) & 0xff)
+#define MAX8907_TO_MEASURE(n)			(((n) >> 8) & 0xff)
+
+enum {
+	TDIE, THM, ISNS, VMBATT, VBBATT, VCHG, AUX2, AUX1
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
+	[AUX1] 4096,
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
+				       !(value & MAX8907_MASK_NREF_OK), 0, 1000);
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
+MODULE_DESCRIPTION("MAX8907 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

