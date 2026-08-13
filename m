Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F047DFB0;
	Thu, 13 Aug 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629496; cv=none; b=O/CGa9+426KMhdMGDJiPAcEIqgE7oCpJsiPqyAvVuyIcVvJdisIwc6AaANe0fed5db8MHAXp1WeNHifrVsXdPppoD68j7W55oOfqwWhZ3xDiH9pXJqnO7uPI4p9p4XkxBY4Ez8AW0zpeSuLCZEpEFsMjmaEWsOIz25VGF++HKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629496; c=relaxed/simple;
	bh=E5B2OaIBLDeI1RSWlHUeJNyFB/GOxWKzHckv5Bvjuhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mQxFdMAQMrKMMjejIrhwC7S7OE34baXsu5KBxldHCUwelQ6Gpn8YGs3HGp1zjgfL+BbUEECqVS/BkVIO/srO48J4PCO8hvsY+pixdWMtuoVwuxFPzlKRjh5tZJMzzuegQVse8EZgS70Nw8p0oJWODdobqx/Fs2n0BNlokUoGqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uhxZFIGK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uhxZFIGK"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCXQvQ1492149;
	Thu, 13 Aug 2026 09:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AaD+Q
	+vrXQYUOva/L3ikcAB4dSA8mP5I/NLMB+yZKQk=; b=uhxZFIGKQ6ochYJzINBbS
	fvVnMIs+HszTTTYsLh3Wpq93QeQri4vump35/r99B0a6anPle49rr/qzB+xyyxqh
	COeTw8dUP37iN8A1L9bi+Qkc3qLEV22dqBgslF7lsd6yUYmfSoXPbE+ydebpefLb
	+gzzghlfQqvHFy2kwUman3R17pZ6wRioh5yqZEtgEni+N/ENImeFOENgUGYrfBYd
	FP5E4oP9sR2g2HLklE5M4YGeRe6LJbs8bp6rim7Z8QOGE3XjcGGHdcFh0a7khyKN
	/GaP50GdKxYTPFq3ghuJIhGOTnsMQs0vTsvRr/3Gw7Hz3NuQR1CiczzzwcL5y/U+
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1n8dv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:57:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvuYZ024636
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:57:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:56 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwX006802;
	Thu, 13 Aug 2026 09:57:49 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:58 +0200
Subject: [PATCH v3 05/14] iio: adc: Add AD7768 and AD7768-4 core support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-5-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=25915;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=E5B2OaIBLDeI1RSWlHUeJNyFB/GOxWKzHckv5Bvjuhk=;
 b=7GQPJcwD5+2wpqoix53iTmg55WIavuAytCvOkD3sXWeRomSQqwTVspENnWu5pPG1MDQDVL8rS
 pmJOb6r3hM3ARE+8loaIXkjThvrdAsxPxV6gxLV1lsrUXmtFhpH/p66
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX2p6okhKA46av
 sBgXRQevIAHdogUWg0PO2RyehCdQUknooMUkUPR1jMu5yYxclTXghrSe3hEKaf+wzcKgmljv7a6
 65BEK3qW5AJeVbk6LNueyNr29lbNELcxn5mftfYi6r3PRMijhcxOmJSqKluL1KP3B6ZSrhfABSL
 6MWv9JqIn1D4+3gcEhLPywYHLUN6y+Bi74918covbx6GWCWvVjOVyun/yR3Txl0qdKHGOVzJW25
 8Jdpr85BI470K+WcFgCaU/f692j9rbgtckokEYhPDzemlZnG784B0rpEgy75LyAveN+QOLlZQyX
 i6K6gwI3zjkRimjmgWek7WeLB3DQax1zi8CX8pzp2p0eFd12vSRtoKTUMiljopWOFzZynpwuM1i
 HV3KO4LEduLLivmYu5ugV0Q5yKjta6wEDC0Fua4stsIXGFVZWFqI/YUZGac65sOWf7BeRxpu/Ze
 YSQKP35vU6XCwEQclxw==
X-Proofpoint-ORIG-GUID: 9cWfEvRK8LmA9ZjZ6AeM03dLqIw9q7dj
X-Proofpoint-GUID: 9cWfEvRK8LmA9ZjZ6AeM03dLqIw9q7dj
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7dcd65 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=pSgA_9LbZru-KsQaZlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX+pXbJqlYguQF
 UleJ+DmSJGK0OGkZIXK761WBOnAXhdfWWtljUwPgxU0SHv5pmfXcrRZ114mpab45rGIh8buLWG/
 m5ikBP0vVa8XfPHXUiEVyjCOKDc/Z6VqiQXuwjbCKZ2EevKfPcXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

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
 drivers/iio/adc/Kconfig  |  15 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7768.c | 813 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 830 insertions(+)

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
index d1b198cb8a80..d621d859e1d6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -429,6 +429,21 @@ config AD7766
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7766.
 
+config AD7768
+	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
+	depends on SPI
+	depends on REGULATOR || COMPILE_TEST
+	select AUXILIARY_BUS
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
index 000000000000..9b908ce0a1c3
--- /dev/null
+++ b/drivers/iio/adc/ad7768.c
@@ -0,0 +1,813 @@
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
+#include <linux/cleanup.h>
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
+#include <linux/types.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define AD7768_REG_GPIO_CONTROL		0x0E
+
+/* AD7768 registers definition */
+#define AD7768_REG_CH_STANDBY			0x00
+#define AD7768_REG_CH_MODE(x)			(0x01 + (x))
+#define AD7768_REG_CH_MODE_SEL			0x03
+#define AD7768_REG_POWER_MODE			0x04
+#define AD7768_REG_GENERAL_CONFIG		0x05
+#define AD7768_REG_DATA_CONTROL			0x06
+#define AD7768_REG_INTERFACE_CFG		0x07
+#define AD7768_REG_REV_ID			0x0A
+#define AD7768_REG_PRECHARGE_BUF1		0x11
+#define AD7768_REG_PRECHARGE_BUF2		0x12
+#define AD7768_REG_REFP_BUF			0x13
+#define AD7768_REG_REFN_BUF			0x14
+#define AD7768_REG_OFFSET_BASE			0x1E
+#define AD7768_REG_GAIN_BASE			0x36
+#define AD7768_REG_PHASE_BASE			0x4E
+#define AD7768_REG_OFFSET(ch)			((AD7768_REG_OFFSET_BASE + (3 * (ch))))
+#define AD7768_REG_GAIN(ch)			((AD7768_REG_GAIN_BASE + (3 * (ch))))
+#define AD7768_REG_PHASE(ch)			((AD7768_REG_PHASE_BASE + (ch)))
+#define __AD7768_4_REG_MAP(ch)		((ch) < 2 ? (ch) : ((ch) + 2))
+#define AD7768_4_REG_OFFSET(ch) \
+	(AD7768_REG_OFFSET_BASE + (3 * __AD7768_4_REG_MAP(ch)))
+#define AD7768_4_REG_GAIN(ch) \
+	(AD7768_REG_GAIN_BASE + (3 * __AD7768_4_REG_MAP(ch)))
+#define AD7768_4_REG_PHASE(ch)		(AD7768_REG_PHASE_BASE + __AD7768_4_REG_MAP(ch))
+#define AD7768_REG_DIAGNOSTIC_RX		0x56
+#define AD7768_REG_CHOP_CTRL			0x59
+
+/* AD7768_REG_CH_MODE */
+#define   AD7768_CH_MODE_FILTER_TYPE_MSK	BIT(3)
+#define   AD7768_CH_MODE_FILTER_TYPE_MODE(x)	(((x) & 0x1) << 3)
+#define   AD7768_CH_MODE_DEC_RATE_MSK		GENMASK(2, 0)
+#define   AD7768_CH_MODE_DEC_RATE_MODE(x)	(((x) & 0x7) << 0)
+
+/* AD7768_REG_POWER_MODE */
+#define   AD7768_SLEEP_MODE_MSK			BIT(7)
+#define   AD7768_POWER_MODE_POWER_MODE_MSK	GENMASK(5, 4)
+#define   AD7768_POWER_MODE_POWER_MODE(x)	(((x) & 0x3) << 4)
+#define   AD7768_POWER_MODE_MCLK_DIV_MSK	GENMASK(1, 0)
+
+/* AD7768_REG_DATA_CONTROL */
+#define   AD7768_DATA_CONTROL_SPI_RESET_1	0x03
+#define   AD7768_DATA_CONTROL_SPI_RESET_2	0x02
+#define   AD7768_DATA_CONTROL_SPI_SYNC_MSK	BIT(7)
+
+/* AD7768_REG_INTERFACE_CFG */
+#define   AD7768_INTERFACE_CFG_DCLK_DIV_MSK	GENMASK(1, 0)
+#define   AD7768_INTERFACE_CFG_DCLK_DIV_MODE(x)	(4 - ffs(x))
+#define   AD7768_MAX_DCLK_DIV			8
+
+#define   AD7768_INTERFACE_CFG_CRC_SELECT_MSK	GENMASK(3, 2)
+/* Hardware supports CRC every 4 or 16 samples; backend supports 4-sample only */
+#define   AD7768_INTERFACE_CFG_CRC_SELECT	FIELD_PREP(GENMASK(3, 2), 0x01)
+
+/* AD7768_REG_GENERAL_CONFIG */
+/* AD7768_REG_PRECHARGE_BUF1 and 2*/
+#define   AD7768_PREBUF_POS_EN(ch)	BIT((ch) * 2)
+#define   AD7768_PREBUF_NEG_EN(ch)	BIT(((ch) * 2) + 1)
+
+#define   AD7768_SPI_READ_CMD			BIT(15)
+#define   AD7768_SPI_REG_MASK			GENMASK(14, 8)
+#define   AD7768_SPI_DATA_MASK			GENMASK(7, 0)
+#define   AD7768_SAMPLE_SIZE				32
+#define   AD7768_MAX_CHANNEL  8
+#define   AD7768_REV_ID_VAL			0x06
+
+enum ad7768_power_modes {
+	AD7768_LOW_POWER_MODE,
+	AD7768_MEDIAN_MODE,
+	AD7768_FAST_MODE,
+	AD7768_NUM_POWER_MODES
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
+	struct mutex lock; /* Protects device register access and configuration */
+	struct clk *mclk;
+	unsigned int datalines;
+	const struct ad7768_chip_info *chip_info;
+	struct iio_backend *back;
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
+	"avss", "avdd2", "iovdd", "ref1", "ref2",
+};
+
+static u8 ad7768_map_power_mode_to_regval(u8 x)
+{
+	return x ? (x + 1) : 0;
+}
+
+static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
+{
+	return BIT(st->chip_info->chan_map[ch]);
+}
+
+static u8 ad7768_all_channels_mask(const struct ad7768_state *st)
+{
+	u8 mask = 0;
+
+	for (unsigned int ch = 0; ch < st->chip_info->num_channels; ch++)
+		mask |= ad7768_channel_mask(st, ch);
+
+	return mask;
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
+	struct spi_device *spi = context;
+	struct ad7768_state *st = spi_get_drvdata(spi);
+	u8 *data_val = val_buf;
+	unsigned int reg;
+	int ret;
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d16,
+			.len = 2,
+			.cs_change = 1,
+		}, {
+			/*
+			 * The second transfer clocks out the readback data, so
+			 * we must provide dummy TX bytes while receiving the
+			 * response. The device ignores MOSI in this phase, so
+			 * reuse st->d16 for both TX and RX.
+			 */
+			.tx_buf = &st->d16,
+			.rx_buf = &st->d16,
+			.len = 2,
+		},
+	};
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
+		return true;
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
+		return true;
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
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
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
+	ret = regmap_update_bits(st->regmap, AD7768_REG_DATA_CONTROL,
+				 AD7768_DATA_CONTROL_SPI_SYNC_MSK, 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_DATA_CONTROL,
+				  AD7768_DATA_CONTROL_SPI_SYNC_MSK,
+				  FIELD_PREP(AD7768_DATA_CONTROL_SPI_SYNC_MSK, 1));
+}
+
+static int ad7768_configure_capture(struct ad7768_state *st)
+{
+	unsigned int dclk_div;
+	unsigned int regval;
+	int ret;
+
+	regval = ad7768_map_power_mode_to_regval(AD7768_FAST_MODE);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_POWER_MODE_MSK |
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 AD7768_POWER_MODE_POWER_MODE(regval) |
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK, regval));
+	if (ret)
+		return ret;
+
+	/*
+	 * Start with the wideband filter and a decimation rate of 64. This
+	 * supports every valid data-line configuration at the maximum MCLK.
+	 */
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
+				 AD7768_CH_MODE_FILTER_TYPE_MSK |
+				 AD7768_CH_MODE_DEC_RATE_MSK,
+				 AD7768_CH_MODE_FILTER_TYPE_MODE(0) |
+				 AD7768_CH_MODE_DEC_RATE_MODE(1));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
+	if (ret)
+		return ret;
+
+	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
+	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				 AD7768_INTERFACE_CFG_DCLK_DIV_MODE(dclk_div));
+	if (ret)
+		return ret;
+
+	return ad7768_sync(st);
+}
+
+static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int channel_mask;
+	unsigned int standby_mask;
+	unsigned int c;
+	int ret;
+
+	channel_mask = ad7768_all_channels_mask(st);
+	standby_mask = channel_mask;
+	for (c = 0; c < st->chip_info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			standby_mask &= ~ad7768_channel_mask(st, c);
+	}
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
+				 channel_mask, standby_mask);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < st->chip_info->num_channels; c++) {
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
+static const struct iio_info ad7768_info = {
+	.debugfs_reg_access = ad7768_reg_access,
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
+	u8 ch;
+
+	for (ch = 0; ch < indio_dev->num_channels; ch++) {
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
+static int ad7768_parse_config(struct iio_dev *indio_dev,
+			       struct device *dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	const unsigned int *available_datalines;
+	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
+	struct iio_chan_spec *chan;
+	unsigned int num_channels;
+	unsigned int channel;
+	unsigned int i, len;
+	int chan_idx = 0;
+	int ret;
+
+	num_channels = 0;
+	device_for_each_child_node_scoped(dev, child) {
+		if (!fwnode_property_present(child, "reg"))
+			continue;
+
+		num_channels++;
+	}
+
+	if (!num_channels || num_channels > st->chip_info->num_channels)
+		return dev_err_probe(dev, -EINVAL, "Invalid number of channels\n");
+
+	chan = devm_kcalloc(indio_dev->dev.parent, num_channels,
+			    sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	indio_dev->channels = chan;
+	indio_dev->num_channels = num_channels;
+
+	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY,
+			   ad7768_all_channels_mask(st));
+	if (ret)
+		return ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		if (!fwnode_property_present(child, "reg"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &channel);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to parse reg property of %pfwP\n",
+					     child);
+
+		if (channel >= st->chip_info->num_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid channel number %d from firmware\n",
+					     channel);
+
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
+					 ad7768_channel_mask(st, channel), 0);
+		if (ret)
+			return ret;
+
+		if (fwnode_property_read_bool(child, "adi,prechargebuf-pos-enable"))
+			precharge_cfg[channel].prebufp_en = true;
+
+		if (fwnode_property_read_bool(child, "adi,prechargebuf-neg-enable"))
+			precharge_cfg[channel].prebufn_en = true;
+
+		if (fwnode_property_read_bool(child, "adi,refbuf-pos-enable"))
+			precharge_cfg[channel].refbufp = true;
+
+		if (fwnode_property_read_bool(child, "adi,refbuf-neg-enable"))
+			precharge_cfg[channel].refbufn = true;
+
+		chan[chan_idx] = (struct iio_chan_spec) {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.address = channel,
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
+	st->datalines = st->chip_info->available_datalines[st->chip_info->num_datalines - 1];
+	ret = device_property_read_u32(dev, "adi,data-lines-number",
+				       &st->datalines);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "Invalid \"adi,data-lines-number\" property\n");
+
+	available_datalines = st->chip_info->available_datalines;
+	len = st->chip_info->num_datalines;
+
+	for (i = 0; i < len; i++) {
+		if (available_datalines[i] == st->datalines)
+			break;
+	}
+
+	if (i == len)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid data-lines-number %d for %s\n",
+				     st->datalines, st->chip_info->name);
+
+	return ad7768_configure_capture(st);
+}
+
+static int ad7768_reset(struct ad7768_state *st)
+{
+	struct reset_control *reset_ctrl;
+	unsigned long reset_low_us;
+	unsigned long mclk;
+	int ret;
+
+	reset_ctrl = devm_reset_control_get_optional_exclusive(regmap_get_device(st->regmap),
+							       NULL);
+	if (IS_ERR(reset_ctrl))
+		return PTR_ERR(reset_ctrl);
+
+	if (reset_ctrl) {
+		mclk = clk_get_rate(st->mclk);
+		if (!mclk)
+			return -EINVAL;
+
+		/* Minimum RESET low pulse width: 2 x tMCLK (datasheet Table 1). */
+		reset_low_us = DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC, mclk);
+
+		ret = reset_control_assert(reset_ctrl);
+		if (ret)
+			return ret;
+
+		fsleep(max_t(unsigned long, 1, reset_low_us));
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
+	fsleep(2000);
+
+	return 0;
+}
+
+static int ad7768_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	unsigned int spi_readback, rev_id;
+	struct iio_dev *indio_dev;
+	struct ad7768_state *st;
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
+
+	ret = devm_regulator_get_enable(dev, "avdd1");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable AVDD1 supply\n");
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad7768_supply_names),
+					     ad7768_supply_names);
+	if (ret)
+		return ret;
+
+	st->mclk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
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
+	/* Dummy SPI register read to discard the Reset response from the chip */
+	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
+	if (ret)
+		return ret;
+
+	if (rev_id != AD7768_REV_ID_VAL)
+		dev_warn(dev, "Unexpected revision ID 0x%02x\n", rev_id);
+
+	ret = ad7768_parse_config(indio_dev, dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
+				 AD7768_INTERFACE_CFG_CRC_SELECT);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7768_info;
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
+	indio_dev->setup_ops = &ad7768_buffer_ops;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = pm_request_autosuspend(dev);
+	if (ret < 0 && ret != -EAGAIN)
+		return dev_err_probe(dev, ret,
+				     "Failed to request initial autosuspend\n");
+
+	return 0;
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
+	/* Empirically determined delay to re-enable ADC and digital clocks.*/
+	fsleep(20000);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
+	ad7768_runtime_resume, NULL);
+
+static const struct of_device_id ad7768_of_match[]  = {
+	{ .compatible = "adi,ad7768", .data = &ad7768_chip_info },
+	{ .compatible = "adi,ad7768-4", .data = &ad7768_4_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7768_of_match);
+
+static const struct spi_device_id ad7768_spi_id[] = {
+	{"ad7768", (kernel_ulong_t)&ad7768_chip_info},
+	{"ad7768-4", (kernel_ulong_t)&ad7768_4_chip_info},
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

