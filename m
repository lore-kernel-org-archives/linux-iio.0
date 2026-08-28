Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56153326939;
	Fri, 28 Aug 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931087; cv=none; b=TWZELV8fT7eIzS+CiqmIHApms0BmBn2sKZ6YqCuCP25Tssw5gHphqGbMSmCbKiDmciAu/gnEJ9pvuFMFP0Q6WzAuEzrsEckxh3jSU2Eshg+XPGtohdkq8phF0+XfxsdXlwwDdwZlDXdRvj41laQZkXZ2U9tE3G6QHkNxe0OGjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931087; c=relaxed/simple;
	bh=mZNshZ2DF3Cq/clesktt8V0NLsjiEp7ta73E0bmPx4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qSp7cgck6mZwvlZ0Vn2Adz5wQLygy5zT0Q6GoQqt1GIedYbf/AjOzl0/7Msw1puMOrPSayUFaQmT2C7zZYOD+qEXxZsRK3+c9eQe7fTY/8eLnSfWM7BZnkbtpIJMHkiQTF1p8BRla0eCSQRRd1Fr6svi/2+0Uf+oJaJkDeYUzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fj2uCTNz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fj2uCTNz"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWBtN2263104;
	Fri, 28 Aug 2026 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=843iR
	cQVnnOZ1HzUXooDp2n0f3xcdvcd0+SdtNLP/MI=; b=fj2uCTNzq0e+sjvg7TGiD
	n65x4iSz6wZIhOUrZpvHaFE93ftOhgkkrLDDhOAsVXmcXpLp5eGdIYSPMenBRDz4
	ghFLHGLJA2xbCy75sruR8QOgRQsaklaLkJ38k37L+cn+GQqdbwu+Wjfqu0AxlS5B
	gtLmG0HAyMIPFoXz5Oh5TmOX1diizxU2Vvx/NpVH/+Cg7ddt7f98PUnELNJyz5v4
	ntUov1cDMfN0t4SwHOZ15XzOIJCGnH9XV3Q5+4I9SHJjavQIY9M8sNFOcWU4sqdS
	AgUWqwApElCC39n7qWbxI/hgZ6cu5ebCogyafKRIdY9idenfKkhqxIBNwTCdX5OA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gajxhyd41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVCwX012997
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:11 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3k031424;
	Fri, 28 Aug 2026 11:31:05 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:28 +0200
Subject: [PATCH v5 05/20] iio: adc: Add AD7768 and AD7768-4 core support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-5-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=30375;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=mZNshZ2DF3Cq/clesktt8V0NLsjiEp7ta73E0bmPx4k=;
 b=UWC5DsbzgRjxaWgFoH03kvbidvIm75nn9zmCt9weBDhXv/izR9iJ2kFpvvza07KTdMnr9liXj
 G7um9JEgQ82A6w8zMy3+IGMGsz7eBhr1GSOT8Op1Y/RDVMt5Csdmt/H
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXwbZiKbKzdhsh
 XyAP0dtWu9+OejVzAeuSRHqeR0v8ATfCTtZmTuwLs7evixpyv+G29c5juYu0d1uUBw5W/SVEiWe
 pnMfXd7IAyQTLMz1LzrBPKWXf5SruYw7SvDbV3lw2hhlaule4wmM
X-Proofpoint-ORIG-GUID: jtx71MvLs1XTKVgBkWull2nWEZ0vFvZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXxN+tVO78R2w2
 qu89QMdXnIiISnVXQOyefF4WgzfsHNKZgLqf8C+yLhDyHbGd2x13zadDRil+2HATeiQirE+mmvU
 tSGd4MM4+HZELGiVrxZfs19iDXSya/uWfCfR9Vyht3Az32VqLT1x82uP5Plnw5uBjAAOzJPYI2b
 X+OGfeb1OW9ZVpOyBuGTgyB01bRf1Pj7hPIwvBYDVgHJDyy6jYA1dhvYrq0iYUuZK+4wvrMBOy0
 yW1XXdsnlNS5I9GE8KxUKYDtXRI/6N9PdyqZ3Cc+ALKuTi/QzpM65ksX4AUsnFxpmDs00TeAGyH
 G8le/v09vhlBoBmZolM2UWI4ZP51i90E5id2SaUbi09IKn2WtGYeZqh1j/5ugA8aEFWGkbiGJwS
 w8NUwX0PpHpo+7I+D9QL0GweM3gPAv9NfaEiuCOUog7v3EGq/MB7dw6UaJwCtetLPpSMjw585y4
 QvY4MbfuKuY46D8PZLg==
X-Proofpoint-GUID: jtx71MvLs1XTKVgBkWull2nWEZ0vFvZQ
X-Authority-Analysis: v=2.4 cv=Oqt/DS/t c=1 sm=1 tr=0 ts=6a91a9c2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=-XxakrEtRxtUKgC0F-AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
Configure supplies, clock and reset, use a custom regmap bus for the SPI
protocol, and parse the enabled channels and input buffer settings from
devicetree.

Connect the converter to an IIO backend for buffered capture with CRC,
provide a fixed safe wideband sampling configuration and add runtime
power management.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  14 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7768.c | 974 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 990 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d667a0411f28..dc94e7803a7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+F:	drivers/iio/adc/ad7768.c
 
 ANALOG DEVICES INC AD7780 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d1b198cb8a80..48bb108382b5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -429,6 +429,20 @@ config AD7766
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7766.
 
+config AD7768
+	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
+	depends on SPI
+	depends on REGULATOR || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_BACKEND
+	select REGMAP
+	help
+	  Say yes here to build support for Analog Devices AD7768 and AD7768-4
+	  SPI analog to digital converters.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7768.
+
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0f90b75577ff..3e896c8aa7c3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7625) += ad7625.o
 obj-$(CONFIG_AD7766) += ad7766.o
+obj-$(CONFIG_AD7768) += ad7768.o
 obj-$(CONFIG_AD7768_1) += ad7768-1.o
 obj-$(CONFIG_AD7779) += ad7779.o
 obj-$(CONFIG_AD7780) += ad7780.o
diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
new file mode 100644
index 000000000000..cb84bb344aef
--- /dev/null
+++ b/drivers/iio/adc/ad7768.c
@@ -0,0 +1,974 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7768 ADC driver
+ *
+ * Copyright 2018-2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define AD7768_REG_CH_STANDBY				0x00
+
+#define AD7768_REG_CH_MODE(x)				(0x01 + (x))
+#define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
+#define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
+#define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
+#define     AD7768_CH_MODE_DEC_RATE_64			0x1
+
+#define AD7768_REG_CH_MODE_SEL				0x03
+
+#define AD7768_REG_POWER_MODE				0x04
+#define   AD7768_SLEEP_MODE_MSK				BIT(7)
+#define   AD7768_POWER_MODE_POWER_MODE_MSK		GENMASK(5, 4)
+#define     AD7768_POWER_MODE_POWER_MODE_FAST		0x3
+#define   AD7768_POWER_MODE_LVDS_ENABLE			BIT(3)
+#define   AD7768_POWER_MODE_MCLK_DIV_MSK		GENMASK(1, 0)
+
+#define AD7768_REG_DATA_CONTROL				0x06
+#define   AD7768_DATA_CONTROL_SPI_RESET_1		0x03
+#define   AD7768_DATA_CONTROL_SPI_RESET_2		0x02
+#define   AD7768_DATA_CONTROL_SPI_SYNC			BIT(7)
+
+#define AD7768_REG_INTERFACE_CFG			0x07
+#define   AD7768_INTERFACE_CFG_CRC_SELECT_MSK		GENMASK(3, 2)
+#define     AD7768_INTERFACE_CFG_CRC_SELECT_4		0x1
+#define   AD7768_INTERFACE_CFG_DCLK_DIV_MSK		GENMASK(1, 0)
+#define     AD7768_INTERFACE_CFG_DCLK_DIV(x)		(4 - ffs(x))
+
+#define AD7768_REG_REV_ID				0x0A
+#define   AD7768_REV_ID_VAL				0x06
+
+#define AD7768_REG_GPIO_CONTROL				0x0E
+#define   AD7768_GPIO_UGPIO_ENABLE			BIT(7)
+#define   AD7768_GPIO4_OUTPUT_ENABLE			BIT(4)
+
+#define AD7768_REG_GPIO_WRITE				0x0F
+
+#define AD7768_REG_PRECHARGE_BUF1			0x11
+#define AD7768_REG_PRECHARGE_BUF2			0x12
+#define   AD7768_PREBUF_POS_EN(ch)			BIT((ch) * 2)
+#define   AD7768_PREBUF_NEG_EN(ch)			BIT(((ch) * 2) + 1)
+
+#define AD7768_REG_REFP_BUF				0x13
+#define AD7768_REG_REFN_BUF				0x14
+
+#define AD7768_REG_OFFSET_BASE				0x1E
+#define AD7768_REG_GAIN_BASE				0x36
+#define AD7768_REG_PHASE_BASE				0x4E
+#define AD7768_REG_OFFSET(ch) \
+	(AD7768_REG_OFFSET_BASE + (3 * (ch)))
+#define AD7768_REG_GAIN(ch) \
+	(AD7768_REG_GAIN_BASE + (3 * (ch)))
+#define AD7768_REG_PHASE(ch) \
+	((AD7768_REG_PHASE_BASE + (ch)))
+#define __AD7768_4_REG_MAP(ch) \
+	((ch) < 2 ? (ch) : ((ch) + 2))
+#define AD7768_4_REG_OFFSET(ch) \
+	(AD7768_REG_OFFSET_BASE + (3 * __AD7768_4_REG_MAP(ch)))
+#define AD7768_4_REG_GAIN(ch) \
+	(AD7768_REG_GAIN_BASE + (3 * __AD7768_4_REG_MAP(ch)))
+#define AD7768_4_REG_PHASE(ch) \
+	(AD7768_REG_PHASE_BASE + __AD7768_4_REG_MAP(ch))
+
+#define AD7768_REG_DIAGNOSTIC_RX			0x56
+
+#define AD7768_REG_CHOP_CTRL				0x59
+
+#define AD7768_SPI_READ_CMD				BIT(15)
+#define AD7768_SPI_REG_MASK				GENMASK(14, 8)
+#define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
+
+#define AD7768_MAX_CHANNEL				8
+
+enum ad7768_clock_source {
+	AD7768_CLOCK_SOURCE_MCLK,
+	AD7768_CLOCK_SOURCE_XTAL,
+	AD7768_CLOCK_SOURCE_LVDS,
+};
+
+struct ad7768_precharge_config {
+	bool prebufp_en;
+	bool prebufn_en;
+	bool refbufp;
+	bool refbufn;
+};
+
+struct ad7768_chip_info {
+	const char *name;
+	unsigned int num_channels;
+	const struct regmap_config *regmap_config;
+	const unsigned int *available_datalines;
+	unsigned int num_datalines;
+	const u8 *chan_map;
+	u8 prebuf_split;
+};
+
+struct ad7768_state {
+	struct regmap *regmap;
+	/* Protects device register access and configuration. */
+	struct mutex lock;
+	struct clk *mclk;
+	unsigned int datalines;
+	enum ad7768_clock_source clock_source;
+	const struct ad7768_chip_info *chip_info;
+	struct iio_backend *back;
+	unsigned int vref_uV[2];
+
+	__be16 d16 __aligned(IIO_DMA_MINALIGN);
+};
+
+static const unsigned int ad7768_available_datalines[] = {
+	1, 2, 8,
+};
+
+static const unsigned int ad7768_4_available_datalines[] = {
+	1, 4,
+};
+
+static const u8 ad7768_chan_map[] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+};
+
+static const u8 ad7768_4_chan_map[] = {
+	0, 1, 4, 5,
+};
+
+static const char * const ad7768_supply_names[] = {
+	"avdd2", "iovdd",
+};
+
+static const char * const ad7768_vref_supply_names[][2] = {
+	{ "ref1p", "ref1n" },
+	{ "ref2p", "ref2n" },
+};
+
+static const char * const ad7768_clock_names[] = {
+	[AD7768_CLOCK_SOURCE_MCLK] = "mclk",
+	[AD7768_CLOCK_SOURCE_XTAL] = "xtal",
+	[AD7768_CLOCK_SOURCE_LVDS] = "lvds",
+};
+
+static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
+{
+	return BIT(st->chip_info->chan_map[ch]);
+}
+
+static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
+{
+	return GENMASK(st->chip_info->num_channels - 1, 0);
+}
+
+static u8 ad7768_precharge_buf1_mask(const struct ad7768_state *st, u16 val)
+{
+	return val & GENMASK(st->chip_info->prebuf_split - 1, 0);
+}
+
+static u8 ad7768_precharge_buf2_mask(const struct ad7768_state *st, u16 val)
+{
+	return (val >> st->chip_info->prebuf_split) &
+	       GENMASK(st->chip_info->prebuf_split - 1, 0);
+}
+
+static int ad7768_regmap_read(void *context, const void *reg_buf,
+			      size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct ad7768_state *st = spi_get_drvdata(context);
+	struct spi_device *spi = context;
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d16,
+			.len = sizeof(st->d16),
+			.cs_change = 1,
+		}, {
+			/*
+			 * Register responses are delayed by one CS frame. While
+			 * receiving the response to this read, the device also
+			 * decodes another command on SDI. Repeat the read
+			 * command to avoid sending an unspecified dummy
+			 * command.
+			 */
+			.tx_buf = &st->d16,
+			.rx_buf = &st->d16,
+			.len = sizeof(st->d16),
+		},
+	};
+	u8 *data_val = val_buf;
+	unsigned int reg;
+	int ret;
+
+	reg = *(const u8 *)reg_buf;
+
+	st->d16 = be16_replace_bits(cpu_to_be16(AD7768_SPI_READ_CMD), reg,
+				    AD7768_SPI_REG_MASK);
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret)
+		return ret;
+
+	*data_val = be16_get_bits(st->d16, AD7768_SPI_DATA_MASK);
+
+	return 0;
+}
+
+static int ad7768_regmap_write(void *context, const void *data, size_t count)
+{
+	struct spi_device *spi = context;
+
+	return spi_write(spi, data, count);
+}
+
+static const struct regmap_bus ad7768_regmap_bus = {
+	.read = ad7768_regmap_read,
+	.write = ad7768_regmap_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static bool ad7768_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AD7768_REG_CH_STANDBY ... AD7768_REG_REV_ID:
+	case AD7768_REG_GPIO_CONTROL ... AD7768_REG_REFN_BUF:
+	case AD7768_REG_OFFSET(0) ... AD7768_REG_OFFSET(7) + 2:
+	case AD7768_REG_GAIN(0) ... AD7768_REG_GAIN(7) + 2:
+	case AD7768_REG_PHASE(0) ... AD7768_REG_PHASE(7):
+	case AD7768_REG_DIAGNOSTIC_RX ... AD7768_REG_CHOP_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ad7768_4_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AD7768_REG_CH_STANDBY ... AD7768_REG_REV_ID:
+	case AD7768_REG_GPIO_CONTROL ... AD7768_REG_REFN_BUF:
+	case AD7768_4_REG_OFFSET(0) ... AD7768_4_REG_OFFSET(1) + 2:
+	case AD7768_4_REG_OFFSET(2) ... AD7768_4_REG_OFFSET(3) + 2:
+	case AD7768_4_REG_GAIN(0) ... AD7768_4_REG_GAIN(1) + 2:
+	case AD7768_4_REG_GAIN(2) ... AD7768_4_REG_GAIN(3) + 2:
+	case AD7768_4_REG_PHASE(0) ... AD7768_4_REG_PHASE(1):
+	case AD7768_4_REG_PHASE(2) ... AD7768_4_REG_PHASE(3):
+	case AD7768_REG_DIAGNOSTIC_RX ... AD7768_REG_CHOP_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ad7768_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD7768_REG_CHOP_CTRL,
+	.use_single_read = true,
+	.use_single_write = true,
+	.readable_reg = ad7768_readable_reg,
+};
+
+static const struct regmap_config ad7768_4_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD7768_REG_CHOP_CTRL,
+	.use_single_read = true,
+	.use_single_write = true,
+	.readable_reg = ad7768_4_readable_reg,
+};
+
+static int ad7768_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad7768_sync(struct ad7768_state *st)
+{
+	int ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_DATA_CONTROL,
+				AD7768_DATA_CONTROL_SPI_SYNC);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AD7768_REG_DATA_CONTROL,
+			       AD7768_DATA_CONTROL_SPI_SYNC);
+}
+
+static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned long channel_mask;
+	unsigned long standby_mask;
+	int ret;
+
+	channel_mask = ad7768_all_standby_mask(st);
+	standby_mask = channel_mask & ~*scan_mask;
+
+	/*
+	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
+	 * AD7768-4 to remain active.
+	 */
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
+		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
+				 channel_mask, standby_mask);
+	if (ret)
+		return ret;
+
+	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct ad7768_chip_info ad7768_chip_info = {
+	.name = "ad7768",
+	.num_channels = 8,
+	.regmap_config = &ad7768_regmap_config,
+	.available_datalines = ad7768_available_datalines,
+	.num_datalines = ARRAY_SIZE(ad7768_available_datalines),
+	.chan_map = ad7768_chan_map,
+	.prebuf_split = 8,
+};
+
+static const struct ad7768_chip_info ad7768_4_chip_info = {
+	.name = "ad7768-4",
+	.num_channels = 4,
+	.regmap_config = &ad7768_4_regmap_config,
+	.available_datalines = ad7768_4_available_datalines,
+	.num_datalines = ARRAY_SIZE(ad7768_4_available_datalines),
+	.chan_map = ad7768_4_chan_map,
+	.prebuf_split = 4,
+};
+
+static int ad7768_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return pm_runtime_resume_and_get(regmap_get_device(st->regmap));
+}
+
+static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
+	.preenable = ad7768_buffer_preenable,
+	.postdisable = ad7768_buffer_postdisable,
+};
+
+static int ad7768_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int vref_idx;
+
+	if (info != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	vref_idx = chan->channel >= st->chip_info->num_channels / 2;
+	*val = 2 * st->vref_uV[vref_idx] / 1000;
+	*val2 = chan->scan_type.realbits;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static const struct iio_info ad7768_info = {
+	.debugfs_reg_access = ad7768_reg_access,
+	.read_raw = ad7768_read_raw,
+	.update_scan_mode = ad7768_update_scan_mode,
+};
+
+static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
+					      struct ad7768_precharge_config *precharge_cfg)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	u8 prebuf1_val, prebuf2_val;
+	u16 prebuf_mask = 0;
+	u8 refbufp_val = 0;
+	u8 refbufn_val = 0;
+	int ret;
+
+	for (u8 ch = 0; ch < indio_dev->num_channels; ch++) {
+		u8 channel = indio_dev->channels[ch].channel;
+
+		if (precharge_cfg[channel].prebufp_en)
+			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
+
+		if (precharge_cfg[channel].prebufn_en)
+			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
+
+		if (precharge_cfg[channel].refbufp)
+			refbufp_val |= ad7768_channel_mask(st, channel);
+
+		if (precharge_cfg[channel].refbufn)
+			refbufn_val |= ad7768_channel_mask(st, channel);
+	}
+
+	prebuf1_val = ad7768_precharge_buf1_mask(st, ~prebuf_mask);
+	prebuf2_val = ad7768_precharge_buf2_mask(st, ~prebuf_mask);
+
+	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF1, prebuf1_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF2, prebuf2_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_REFP_BUF, refbufp_val);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
+}
+
+static int ad7768_configure_capture(struct ad7768_state *st)
+{
+	unsigned int dclk_div_reg;
+	unsigned int mode_config;
+	unsigned int dclk_div;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_POWER_MODE_MSK |
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
+					    AD7768_POWER_MODE_POWER_MODE_FAST) |
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
+					    AD7768_POWER_MODE_POWER_MODE_FAST));
+	if (ret)
+		return ret;
+
+	/*
+	 * Start with the wideband filter and a decimation rate of 64. This
+	 * supports every valid data-line configuration at the maximum MCLK.
+	 */
+	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
+				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
+	mode_config |= FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
+				  AD7768_CH_MODE_DEC_RATE_64);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
+				 AD7768_CH_MODE_FILTER_TYPE_MSK |
+				 AD7768_CH_MODE_DEC_RATE_MSK,
+				 mode_config);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
+	if (ret)
+		return ret;
+
+	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
+	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+					    dclk_div_reg));
+	if (ret)
+		return ret;
+
+	return ad7768_sync(st);
+}
+
+static int ad7768_parse_config(struct iio_dev *indio_dev,
+			       struct device *dev)
+{
+	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
+	struct ad7768_state *st = iio_priv(indio_dev);
+	const unsigned int *available_datalines;
+	bool datalines_valid = false;
+	struct iio_chan_spec *chan;
+	unsigned int num_channels;
+	unsigned int standby_mask;
+	unsigned int len;
+	int chan_idx = 0;
+	int ret;
+
+	num_channels = 0;
+	device_for_each_named_child_node_scoped(dev, child, "channel")
+		num_channels++;
+
+	if (!num_channels || num_channels > st->chip_info->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid number of channels\n");
+
+	chan = devm_kcalloc(indio_dev->dev.parent, num_channels,
+			    sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	indio_dev->channels = chan;
+	indio_dev->num_channels = num_channels;
+
+	standby_mask = ad7768_all_standby_mask(st);
+
+	/*
+	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
+	 * AD7768-4 to remain active.
+	 */
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
+		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
+
+	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY, standby_mask);
+	if (ret)
+		return ret;
+
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		u32 channel;
+
+		ret = fwnode_property_read_u32(child, "reg", &channel);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to parse reg of %pfwP\n",
+					     child);
+
+		if (channel >= st->chip_info->num_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid channel %u in firmware\n",
+					     channel);
+
+		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
+					BIT(channel));
+		if (ret)
+			return ret;
+
+		precharge_cfg[channel].prebufp_en =
+			fwnode_property_read_bool(child,
+						  "adi,prechargebuf-pos-enable");
+		precharge_cfg[channel].prebufn_en =
+			fwnode_property_read_bool(child,
+						  "adi,prechargebuf-neg-enable");
+		precharge_cfg[channel].refbufp =
+			fwnode_property_read_bool(child,
+						  "adi,refbuf-pos-enable");
+		precharge_cfg[channel].refbufn =
+			fwnode_property_read_bool(child,
+						  "adi,refbuf-neg-enable");
+
+		chan[chan_idx] = (struct iio_chan_spec) {
+			.type = IIO_VOLTAGE,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
+			.indexed = 1,
+			.channel = channel,
+			.scan_index = channel,
+			.scan_type = {
+				.sign = 's',
+				.realbits = 24,
+				.storagebits = 32,
+			},
+		};
+		chan_idx++;
+	}
+
+	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
+	if (ret)
+		return ret;
+
+	available_datalines = st->chip_info->available_datalines;
+	len = st->chip_info->num_datalines;
+	st->datalines = available_datalines[len - 1];
+	ret = device_property_read_u32(dev, "adi,data-lines-number",
+				       &st->datalines);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "Invalid %s property\n",
+				     "adi,data-lines-number");
+
+	for (unsigned int i = 0; i < len; i++) {
+		if (available_datalines[i] == st->datalines) {
+			datalines_valid = true;
+			break;
+		}
+	}
+
+	if (!datalines_valid)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid data-lines-number %d for %s\n",
+				     st->datalines, st->chip_info->name);
+
+	return ad7768_configure_capture(st);
+}
+
+static int ad7768_reset(struct ad7768_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct reset_control *reset_ctrl;
+	unsigned long reset_low_us;
+	unsigned long mclk;
+	int ret;
+
+	reset_ctrl = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset_ctrl))
+		return PTR_ERR(reset_ctrl);
+
+	if (reset_ctrl) {
+		mclk = clk_get_rate(st->mclk);
+		if (!mclk)
+			return -EINVAL;
+
+		/*
+		 * Minimum RESET low pulse width: 2 x tMCLK
+		 * (datasheet Table 1).
+		 */
+		reset_low_us = DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC, mclk);
+
+		ret = reset_control_assert(reset_ctrl);
+		if (ret)
+			return ret;
+
+		fsleep(max(1UL, reset_low_us));
+
+		ret = reset_control_deassert(reset_ctrl);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
+				   AD7768_DATA_CONTROL_SPI_RESET_1);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
+				   AD7768_DATA_CONTROL_SPI_RESET_2);
+		if (ret)
+			return ret;
+	}
+
+	/* ADC start-up time after reset: 1.66 ms max (datasheet Table 1) */
+	fsleep(1660);
+
+	return 0;
+}
+
+static void ad7768_disable_clk(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int ad7768_configure_xtal_clock(struct ad7768_state *st)
+{
+	int ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+			       AD7768_GPIO_UGPIO_ENABLE |
+			       AD7768_GPIO4_OUTPUT_ENABLE);
+}
+
+static int ad7768_enable_lvds_clock(struct ad7768_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+			      AD7768_GPIO_UGPIO_ENABLE |
+			      AD7768_GPIO4_OUTPUT_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
+			      AD7768_POWER_MODE_LVDS_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7768_disable_clk, st->mclk);
+}
+
+static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
+{
+	const char * const *supply = ad7768_vref_supply_names[index];
+	int refp_uV;
+	int refn_uV;
+
+	refp_uV = devm_regulator_get_enable_read_voltage(dev, supply[0]);
+	if (refp_uV < 0)
+		return dev_err_probe(dev, refp_uV,
+				     "Failed to get %s supply voltage\n", supply[0]);
+
+	refn_uV = devm_regulator_get_enable_read_voltage(dev, supply[1]);
+	if (refn_uV == -ENODEV)
+		refn_uV = 0;
+	else if (refn_uV < 0)
+		return dev_err_probe(dev, refn_uV,
+				     "Failed to get %s supply voltage\n", supply[1]);
+
+	if (refp_uV <= refn_uV)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid reference %u voltage\n", index + 1);
+
+	return refp_uV - refn_uV;
+}
+
+static int ad7768_probe(struct spi_device *spi)
+{
+	unsigned int spi_readback, rev_id;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad7768_state *st;
+	const char *clock_name;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, st);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to get match data\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "avss");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable AVSS supply\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd1");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable AVDD1 supply\n");
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad7768_supply_names),
+					     ad7768_supply_names);
+	if (ret)
+		return ret;
+
+	for (unsigned int i = 0;
+	     i < ARRAY_SIZE(ad7768_vref_supply_names); i++) {
+		ret = ad7768_get_enable_vref(dev, i);
+		if (ret < 0)
+			return ret;
+
+		st->vref_uV[i] = ret;
+	}
+
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad7768_clock_names,
+						    ARRAY_SIZE(ad7768_clock_names));
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Invalid clock source\n");
+
+	st->clock_source = ret;
+	clock_name = ad7768_clock_names[st->clock_source];
+
+	/*
+	 * The device must start on its internal clock. Keep the LVDS clock
+	 * disabled until GPIO4 is driven low and the LVDS input is enabled in
+	 * the power mode register.
+	 */
+	if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS)
+		st->mclk = devm_clk_get(dev, clock_name);
+	else
+		st->mclk = devm_clk_get_enabled(dev, clock_name);
+
+	if (IS_ERR(st->mclk))
+		return dev_err_probe(dev, PTR_ERR(st->mclk),
+				     "Failed to get master clock\n");
+
+	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
+				      st->chip_info->regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ad7768_reset(st);
+	if (ret)
+		return ret;
+
+	/* Discard the reset response with a dummy SPI register read. */
+	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
+	if (ret)
+		return ret;
+
+	if (rev_id != AD7768_REV_ID_VAL)
+		dev_info(dev, "Unexpected revision ID 0x%02x\n", rev_id);
+
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL) {
+		ret = ad7768_configure_xtal_clock(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure crystal clock\n");
+	} else if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS) {
+		ret = ad7768_enable_lvds_clock(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable LVDS clock\n");
+	}
+
+	ret = ad7768_parse_config(indio_dev, dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Hardware supports CRC every 4 or 16 samples; the backend supports only
+	 * 4-sample CRC.
+	 */
+	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
+				 FIELD_PREP(AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
+					    AD7768_INTERFACE_CFG_CRC_SELECT_4));
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7768_info;
+	indio_dev->setup_ops = &ad7768_buffer_ops;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_num_lanes_set(st->back, st->datalines);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_crc_enable(st->back);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 2000);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad7768_runtime_suspend(struct device *dev)
+{
+	struct ad7768_state *st = dev_get_drvdata(dev);
+
+	return regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
+			       AD7768_SLEEP_MODE_MSK);
+}
+
+static int ad7768_runtime_resume(struct device *dev)
+{
+	struct ad7768_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_POWER_MODE,
+				AD7768_SLEEP_MODE_MSK);
+	if (ret)
+		return ret;
+
+	/*
+	 * The datasheet does not specify a wake-up time. Allow 20 ms for the
+	 * ADC and digital clocks to restart.
+	 */
+	fsleep(20 * USEC_PER_MSEC);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
+				 ad7768_runtime_resume, NULL);
+
+static const struct of_device_id ad7768_of_match[] = {
+	{ .compatible = "adi,ad7768", .data = &ad7768_chip_info },
+	{ .compatible = "adi,ad7768-4", .data = &ad7768_4_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7768_of_match);
+
+static const struct spi_device_id ad7768_spi_id[] = {
+	{ "ad7768", (kernel_ulong_t)&ad7768_chip_info },
+	{ "ad7768-4", (kernel_ulong_t)&ad7768_4_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7768_spi_id);
+
+static struct spi_driver ad7768_driver = {
+	.probe = ad7768_probe,
+	.driver = {
+		.name = "ad7768",
+		.of_match_table = ad7768_of_match,
+		.pm = pm_ptr(&ad7768_pm_ops),
+	},
+	.id_table = ad7768_spi_id,
+};
+module_spi_driver(ad7768_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7768 ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");

-- 
2.43.0

