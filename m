Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB9489861;
	Thu, 13 Aug 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629510; cv=none; b=pEj+ckH6uY0jcbYUvyip2wzEvRNxSZ17XFNzo4KKWGS4xKVfPBZHY6IXvQJ4YNbJr4Sv1ADtieOHfyOfDlTUgKNgITJhKJ5YV/moFvCOtx6hEX2lQulEPNys3LNiQ+/R0GhNekaQvrUiErFVUtnE+8nC/J14DGubiYe0I4BLbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629510; c=relaxed/simple;
	bh=oEmSGeSrbNCBZZXeCuSPWvIF2sVljJpjdDE7pwsZgWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DiQsicGL0f5u1KBFADmVqKwPfWA9jObWqPURtf9xSQ4vXS+YQTC5V+QJUWBVDG1PATeI925G7y/VKyaOHzVr432rK3BLNsgVdNoHvVbg19/4cDFlIaYl4+6uTnmtw73PndGdCL/a9haVybxyFDw54oNzr9Hr8U8/LBXwzRLqbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BpPmYHr3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BpPmYHr3"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCa7xo2129063;
	Thu, 13 Aug 2026 09:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9+hFX
	d4DsxheWxMCY2zoI6o7bFqwS7pZ/JW/lwY44uc=; b=BpPmYHr3oAGMYPGpIFpRz
	9Ff2psGWBkRRU4zzYeNcKImIIwYnlgCv77IG7EPWm4hExAiUIjmVdbPmRwrorhGq
	1fzFnjvruxxDITzlNoqZxkTLaBsd6RMSgYMOTKvxc8CDUBhGR7A9kx382G3piqj0
	clGYZ2U5xt4/NZTB9j6L3pEZ1Go1/43X/v4zGxuwdogDCijL1FIagH+1NrOM8Zuv
	JMoz5JCd3h3y7vEf6Kj+3HZtk3NqbufNo6ugRUvlgnD1vVQimX2kT3guTuDab+Ca
	uGSGlXYiNp+pJjIxJZxcq3Xs/lHaJvED83AoQ23HnexOqTRdeDaKyt52egPB78r8
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e2wgcdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDwHGF024678
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:17 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwf006802;
	Thu, 13 Aug 2026 09:58:10 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:06 +0200
Subject: [PATCH v3 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-13-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=5503;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=oEmSGeSrbNCBZZXeCuSPWvIF2sVljJpjdDE7pwsZgWA=;
 b=ylV8XBrf++uv1m9ZbGWRf18zCweJvWZPp+4p4u3t7MKer/A9alO4+4FxjTiu2WZI2drmfhPSO
 yzKsh15cC4MA2USmN91KB22AYDDqPvgZ4spkQeLl32bmR1IejHF8ddD
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX0XqvLMctxbtz
 q9I7nkECtYz13hlg3Xaxh8SE7s3tiSaA1JYmQBsLPa7JywC3MuQ7iOD92FgQcB8PrOCUBqkewZt
 FMZw+q3Lqq2jcT6QEoIXeJLcchS+nHbgeyh0sJhr73MFWaeyTAHU
X-Proofpoint-GUID: 5_Jr1i0zX66DcuZ_Jr6fivIPsQV9251H
X-Authority-Analysis: v=2.4 cv=UJzt2ify c=1 sm=1 tr=0 ts=6a7dcd7a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=DyYY1DdFIiypQHwlAEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXyzbOjOwmoviD
 fjN3nkvS6w8fvyOOiobkYly8gjti2ymLJOMfvOqx+5GkcQkSLRHqwIX1GRL5a9qHEe4VCEeWRl0
 bMFIoFXNUrqAdSzqOSSFzXITRsFAdON0+Ud/CdacbIEylOpz3reK0Hb7T3yLgnda6As68uoQFDT
 Y32oGhF1VfhxK0E0ZZOUPqsDpGMsMA1fzVGoGrjLNtFNEDh1444APp78yCfsCna1cg9KN6mAY+H
 MYwi7jpiX1qhYSnRk+59dx6/qeC6Yd7dPkgxcpGGk/wHdC540cNAFN5jY+p20nCRFfAkItY8uXE
 VBdLEHu5rZz0fBs3RXNMkuMBXH32/1okfmzpzGRBNaORajfuo1EbwaU5uHsF8ya3xG0Fd8wMvmV
 kkV9vqSQ8Ghd6/PNDls0OMZTBMe/wSclg+N9hc2CDZVCZpHlGmg6zgz3qRj2pEN7hGxgxMjkMuR
 eRI1CL9T/rd0PABClkg==
X-Proofpoint-ORIG-GUID: 5_Jr1i0zX66DcuZ_Jr6fivIPsQV9251H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

The AD7768 provides five GPIOs controlled through registers shared
with the parent IIO device. Register an auxiliary gpio-regmap driver
and use the parent device for runtime PM.

The device has separate input-state and output-latch registers. Add a
reg_mask_xlate() callback that checks the line direction and reads the
programmed output latch for output lines while retaining input-state
reads for input lines.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS                |   1 +
 drivers/gpio/Kconfig       |  12 +++++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-ad7768.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc94e7803a7c..3de7ebcc4ee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+F:	drivers/gpio/gpio-ad7768.c
 F:	drivers/iio/adc/ad7768.c
 
 ANALOG DEVICES INC AD7780 DRIVER
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 28cf6d2e83c2..85cb0c82a823 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1796,6 +1796,18 @@ endmenu
 menu "Auxiliary Bus GPIO drivers"
 	depends on AUXILIARY_BUS
 
+config GPIO_AD7768
+	tristate "Analog Devices AD7768 GPIO support"
+	depends on AD7768
+	depends on GPIOLIB
+	select GPIO_REGMAP
+	help
+	  Say yes here to expose the AD7768 utility pins as GPIOs when the
+	  device tree node is marked as a GPIO controller.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gpio-ad7768.
+
 config GPIO_LTC4283
 	tristate "Analog Devices LTC4283 GPIO support"
 	depends on SENSORS_LTC4283
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4d0e900402fc..d2921963efc7 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GPIO_104_IDI_48)		+= gpio-104-idi-48.o
 obj-$(CONFIG_GPIO_104_IDIO_16)		+= gpio-104-idio-16.o
 obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
+obj-$(CONFIG_GPIO_AD7768)		+= gpio-ad7768.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5585)		+= gpio-adp5585.o
diff --git a/drivers/gpio/gpio-ad7768.c b/drivers/gpio/gpio-ad7768.c
new file mode 100644
index 000000000000..2dad00fac711
--- /dev/null
+++ b/drivers/gpio/gpio-ad7768.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7768 GPIO auxiliary driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define AD7768_REG_GPIO_CONTROL		0x0E
+#define AD7768_REG_GPIO_WRITE		0x0F
+#define AD7768_REG_GPIO_READ		0x10
+
+#define AD7768_GPIO_UGPIO_ENABLE	BIT(7)
+
+#define AD7768_NUM_GPIOS		5
+
+static int ad7768_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
+				      unsigned int base, unsigned int offset,
+				      unsigned int *reg, unsigned int *mask)
+{
+	struct regmap *regmap = gpio_regmap_get_drvdata(gpio);
+	int ret;
+
+	*reg = base;
+	*mask = BIT(offset);
+
+	if (base != AD7768_REG_GPIO_READ)
+		return 0;
+
+	/*
+	 * AD7768 has separate input-state and output-latch registers. For an
+	 * output line, report the programmed value from the output latch;
+	 * input lines continue to use the input-state register.
+	 */
+	ret = regmap_test_bits(regmap, AD7768_REG_GPIO_CONTROL, *mask);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		*reg = AD7768_REG_GPIO_WRITE;
+
+	return 0;
+}
+
+static int ad7768_gpio_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct gpio_regmap_config config = {
+		.parent = dev,
+		.label = dev_name(dev->parent),
+		.ngpio = AD7768_NUM_GPIOS,
+		.reg_dat_base = AD7768_REG_GPIO_READ,
+		.reg_set_base = AD7768_REG_GPIO_WRITE,
+		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
+		.pm_dev = dev->parent,
+		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
+	};
+	struct gpio_regmap *gpio;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->parent, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, AD7768_REG_GPIO_CONTROL,
+			      AD7768_GPIO_UGPIO_ENABLE);
+	if (ret)
+		return ret;
+
+	config.regmap = regmap;
+	config.drvdata = regmap;
+	gpio = devm_gpio_regmap_register(dev, &config);
+
+	return PTR_ERR_OR_ZERO(gpio);
+}
+
+static const struct auxiliary_device_id ad7768_gpio_ids[] = {
+	{ .name = "ad7768.gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, ad7768_gpio_ids);
+
+static struct auxiliary_driver ad7768_gpio_driver = {
+	.probe = ad7768_gpio_probe,
+	.id_table = ad7768_gpio_ids,
+};
+module_auxiliary_driver(ad7768_gpio_driver);
+
+MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7768 GPIO auxiliary driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

