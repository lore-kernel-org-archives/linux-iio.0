Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44149E5D2;
	Thu, 10 Sep 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061871; cv=none; b=a7auZDFHHSrq3KvW/aVRz96pxdMlk/aau/Ia4eiwU8R9KcI/cVOpGWzwvX0C4o8G9GjKQHql+vBxqGvnGBeIfHWbQfKC6it+H/iuLa5EzPd7bodNzKe6+mSEtXO++QyolvY/n3bBMKSr5GVOu8jQ7qdj0WYgqzlvKgu9es1rgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061871; c=relaxed/simple;
	bh=k7hK/1dYtWhMnTCnXN/3OikHsOG+8e/Lb2mH0MNTet8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=U2C8Lew7mG90hx42HHWAnShHZW261uGuqyBOPen6v8CWl5+k0oMYc2uqGyceiIHy+K1Z9vS1Fn9rXQpGvBnhz4vt7Yp88AS1NC3a2xIaFzByRG4Ob8uKAJuTr6VUKsm4Nxwv7j3tH45OkXTYKhz2TqC009GxqjyP0FBHj/5ywi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P27x4pxb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P27x4pxb"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7CXo3263705;
	Thu, 10 Sep 2026 13:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5zMks
	cKfzeerxjAwePJad9dtriLAdh/FB0EtEVEMEPs=; b=P27x4pxbMXsQTtzyJyEwz
	beUVK0646rAsM9dTwiDoJNT/gmgS8hAzdaIwx/uoSRWJe5wK/fydBhzuoZRhLKbS
	CBCjgZMNalYV7IK1kidY4VsjTrtm9FXjvGhJZBbY/vbGVbmDfvLFQRuUvAy3WW4E
	CuXIBFOKZWeaUA4V9l9e6nAUgG1Mfz/9nF66nGz4Hi8EajX2gpDJVnSEEXhx0teJ
	fU9tcL1gNvExqtjcEw6IyEY5Vc6qZkBHA9Gqh2OcXK3Vw3gSsjINyOCMiI68+mWa
	QdUNLK67Xj/n2UrpV04wEn3HleYbbZuVWLuxXdTfDNspQbNHEvgISDfWnzx7aMAx
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcd0vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbDlp038785
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:13 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSb018832;
	Thu, 10 Sep 2026 13:37:07 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:23 +0200
Subject: [PATCH v7 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-5-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=31858;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=k7hK/1dYtWhMnTCnXN/3OikHsOG+8e/Lb2mH0MNTet8=;
 b=dOwhMYEWeebrstPqyHD/NIYzvwX/XrdpG8eSJ5kM/360SqiZt1YdlPMeKQkugRh3YT9R4rHqi
 biDL1+PWsTQCSGKhy0mrxrYR/OuadpQUlgVBseN7HBlv12oJrcdwK90
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZFqFShd c=1 sm=1 tr=0 ts=6aa2eacb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=xaEP9h1eQhWwnVAwg-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0ARX6PNWRfA7qRIEBH_QK2raUy4dy_c9
X-Proofpoint-ORIG-GUID: 0ARX6PNWRfA7qRIEBH_QK2raUy4dy_c9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX6JZqqetfV2/9
 TZVveQ9Mce36tABJfl30q0FrFZVvOpMkNqSEuMx8k6mRhkTXfvMpRSphYbTAy4wuWofgMVmLb4a
 Zb/Yk4qRdFiZdpnQnlAIrySz/bfAymWziYUcKlU2rwl9UTTGtc0tH0FyKncW7br5qj5erMen51A
 MWY4X1Jgi0F+lXYbnh+kq6hhKif5x87S/XKhfA7yz5XrnuQK+7c0QGzDdRynXH3TDgt/+gyt3Q/
 C57ThuiO0sx+xIac3PtO8TkpXNPIUtWldSVaMTVFNQ6w9c5vAWXCh11qDVwVTgvxxgn4sierm/w
 xOcGDCvM8jJclntA6DWZ8VdgE/SSaKvZMxFkh1f9XGJGh+KIkMBMhkHHeQwTECgwvVq9tNwODmj
 HF2vnvhB780avYkxDCgKxJF3TbW1gl9cH5A2nREmT+3b1buWsWQMyQ84ezKiF5ngOvj189h09w8
 DasU3ipwu85oRPflPZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX4Ugor2qFdcRQ
 0EZlJ+vplXmfHxRoRbn4odBkfMK/CyAXeWLvwcf65sP7+07ynUMNtyddEZp4F1JMyqZFEskzoTc
 FcwJVHOUn4epKQ92hWx2lmnnFWhB02mumESqy48KO9WD6TDC8W60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
Configure supplies, clock and reset, use a custom regmap bus for the SPI
protocol, and parse the enabled channels and input buffer settings from
devicetree.

Connect the converter to an IIO backend for buffered capture with CRC,
provide a fixed safe wideband sampling configuration and add runtime
power management.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   14 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad7768.c | 1033 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1049 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f05e7f4d364a..de91903b0b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,6 +1663,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+F:	drivers/iio/adc/ad7768.c
 
 ANALOG DEVICES INC AD7780 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..5164608fa418 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -431,6 +431,20 @@ config AD7766
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
index dcec0abb03b7..c84f1a5eeac0 100644
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
index 000000000000..3cb58c2554a3
--- /dev/null
+++ b/drivers/iio/adc/ad7768.c
@@ -0,0 +1,1033 @@
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
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
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
+#define     AD7768_INTERFACE_CFG_DCLK_DIV_8		0x0
+#define     AD7768_INTERFACE_CFG_DCLK_DIV_4		0x1
+#define     AD7768_INTERFACE_CFG_DCLK_DIV_2		0x2
+#define     AD7768_INTERFACE_CFG_DCLK_DIV_1		0x3
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
+#define   AD7768_PREBUF_POS_EN(ch)			BIT((ch) * 2 + 0)
+#define   AD7768_PREBUF_NEG_EN(ch)			BIT((ch) * 2 + 1)
+
+#define AD7768_REG_REFP_BUF				0x13
+#define AD7768_REG_REFN_BUF				0x14
+
+#define AD7768_REG_OFFSET_BASE				0x1E
+#define AD7768_REG_GAIN_BASE				0x36
+#define AD7768_REG_PHASE_BASE				0x4E
+#define AD7768_REG_OFFSET(ch)	(AD7768_REG_OFFSET_BASE + 3 * (ch))
+#define AD7768_REG_GAIN(ch)	(AD7768_REG_GAIN_BASE + 3 * (ch))
+#define AD7768_REG_PHASE(ch)	(AD7768_REG_PHASE_BASE + (ch))
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
+	const struct regmap_config *regmap_config;
+	const unsigned int *available_datalines;
+	unsigned int num_datalines;
+	unsigned int num_channels;
+	const u8 *chan_map;
+	u8 prebuf_split;
+};
+
+struct ad7768_state {
+	struct regmap *regmap;
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
+	unsigned int split = st->chip_info->prebuf_split;
+
+	return field_get(GENMASK(2 * split - 1, split), val);
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
+static int ad7768_regmap_write(void *spi, const void *data, size_t count)
+{
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
+	case AD7768_REG_OFFSET(0) ... AD7768_REG_OFFSET(1) + 2:
+	case AD7768_REG_OFFSET(4) ... AD7768_REG_OFFSET(5) + 2:
+	case AD7768_REG_GAIN(0) ... AD7768_REG_GAIN(1) + 2:
+	case AD7768_REG_GAIN(4) ... AD7768_REG_GAIN(5) + 2:
+	case AD7768_REG_PHASE(0) ... AD7768_REG_PHASE(1):
+	case AD7768_REG_PHASE(4) ... AD7768_REG_PHASE(5):
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
+	/*
+	 * Regmap bulk transfers use one starting address, while each register
+	 * access requires a separate 16-bit SPI frame and reads use an off-frame
+	 * response. Split bulk transfers into individual register accesses.
+	 */
+	.use_single_read = true,
+	.use_single_write = true,
+	.readable_reg = ad7768_readable_reg,
+};
+
+static const struct regmap_config ad7768_4_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD7768_REG_CHOP_CTRL,
+	/*
+	 * Regmap bulk transfers use one starting address, while each register
+	 * access requires a separate 16-bit SPI frame and reads use an off-frame
+	 * response. Split bulk transfers into individual register accesses.
+	 */
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
+		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
+				 channel_mask, standby_mask);
+	if (ret)
+		return ret;
+
+	for (unsigned int ch = 0; ch < st->chip_info->num_channels; ch++) {
+		if (test_bit(ch, scan_mask))
+			ret = iio_backend_chan_enable(st->back, ch);
+		else
+			ret = iio_backend_chan_disable(st->back, ch);
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
+static int ad7768_read_scale(struct ad7768_state *st,
+			     const struct iio_chan_spec *chan,
+			     int *val, int *val2)
+{
+	unsigned int vref_idx;
+
+	vref_idx = chan->channel >= st->chip_info->num_channels / 2;
+	*val = 2 * st->vref_uV[vref_idx] / (MICRO / MILLI);
+	*val2 = chan->scan_type.realbits;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static int ad7768_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad7768_read_scale(st, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
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
+	for (unsigned int ch = 0; ch < indio_dev->num_channels; ch++) {
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
+				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND) |
+		      FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
+				 AD7768_CH_MODE_DEC_RATE_64);
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
+	/*
+	 * DCLK(min) is ODR * channels per DOUTx * 32. With fast mode
+	 * (fMOD = MCLK / 4) and x64 decimation, this gives:
+	 * MCLK / DCLK = 8 * data lines / channels.
+	 */
+	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
+	switch (dclk_div) {
+	case 1:
+		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_1;
+		break;
+	case 2:
+		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_2;
+		break;
+	case 4:
+		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_4;
+		break;
+	case 8:
+		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
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
+	unsigned long standby_mask;
+	unsigned int len;
+	int chan_idx = 0;
+	int ret;
+
+	num_channels = device_get_named_child_node_count(dev, "channel");
+
+	if (num_channels == 0)
+		return dev_err_probe(dev, -ENOENT, "No channel specified\n");
+
+	if (num_channels > st->chip_info->num_channels)
+		return dev_err_probe(dev, -ENOSPC, "Invalid number of channels\n");
+
+	chan = devm_kcalloc(dev, num_channels, sizeof(*chan), GFP_KERNEL);
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
+		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
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
+			return dev_err_probe(dev, -ECHRNG,
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
+	if (device_property_present(dev, "adi,data-lines-number")) {
+		ret = device_property_read_u32(dev, "adi,data-lines-number",
+					       &st->datalines);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Invalid adi,data-lines-number property\n");
+	} else {
+		st->datalines = available_datalines[len - 1];
+	}
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
+static int ad7768_enter_sleep(struct ad7768_state *st)
+{
+	return regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
+			       AD7768_SLEEP_MODE_MSK);
+}
+
+static void ad7768_power_off(void *data)
+{
+	struct ad7768_state *st = data;
+	struct device *dev;
+	int ret;
+
+	dev = regmap_get_device(st->regmap);
+
+	ret = ad7768_enter_sleep(st);
+	if (ret)
+		dev_err(dev, "Failed to put device to sleep\n");
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
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(dev, -ENODATA, "Failed to get match data\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "avss");
+	if (ret == -ENODEV) {
+		/* AVSS may be tied directly to ground instead of a regulator. */
+	} else if (ret) {
+		return dev_err_probe(dev, ret,
+				     "Failed to enable AVSS supply\n");
+	}
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
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad7768_vref_supply_names); i++) {
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
+	switch (st->clock_source) {
+	case AD7768_CLOCK_SOURCE_MCLK:
+	case AD7768_CLOCK_SOURCE_XTAL:
+		st->mclk = devm_clk_get_enabled(dev, clock_name);
+		break;
+	case AD7768_CLOCK_SOURCE_LVDS:
+		st->mclk = devm_clk_get(dev, clock_name);
+		break;
+	}
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
+	switch (st->clock_source) {
+	case AD7768_CLOCK_SOURCE_MCLK:
+		break;
+	case AD7768_CLOCK_SOURCE_XTAL:
+		ret = ad7768_configure_xtal_clock(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure crystal clock\n");
+		break;
+	case AD7768_CLOCK_SOURCE_LVDS:
+		ret = ad7768_enable_lvds_clock(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable LVDS clock\n");
+		break;
+	}
+
+	ret = devm_add_action_or_reset(dev, ad7768_power_off, st);
+	if (ret)
+		return ret;
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
+	return ad7768_enter_sleep(st);
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

