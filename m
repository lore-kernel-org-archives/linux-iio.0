Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBF30B53A;
	Thu, 27 Aug 2026 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816177; cv=none; b=nBSJ4kd1IzgcM3IkfUvIgnZH+EzasWudu/JVMTq0JC4Jn7Z7FHCSzRArZ0ae7BZSiDMxAQxi0z7vpsfLfjgs7VHcJVSrrsobp6JeS2ofcp7EU16HPd5WxyojO2OAS+Z+lBhgr+8ObZ/MtiGk/+tXOsWz3R6olVYnN2gcjrrIEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816177; c=relaxed/simple;
	bh=Fo5BZNzFiB6Ale/0A2X0dxmEHsmHenYJozCBtqiQa00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m4LhR6Y7wR2zcVPlObmGOo8Gbm3eBrOXAOEEU7qAH2jFhLvYoS1TczkbWVapEtwniwKL9y1005aY7Ln4BT5L2rGeP/ntr/AceAt1MfqNNEp24DlQnWYvgPOawwOTwWrLcH7OLiNuCy8EX7qBNSGTnsSzQHvXf9UNrKQJqdBXH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tZuodtgm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tZuodtgm"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6OnVw2107374;
	Thu, 27 Aug 2026 03:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8jyB0
	5kyn8n+hJ6XnA1w1THxEspwzyASJTxrREKCvd4=; b=tZuodtgm5LcLnxv+fkcNH
	J3A3flueCnIqSxymu0SZQYPrseLSYIt9hk2sseevgM5sxK+4aXRMbbCuDiY9aXxX
	Yo0teNjh3GSNB4v7x6Pj5IbzBc/RAUYA1rsdtPoW6Uut5KCxN2lblfSpTBbKWSKH
	vlGey4KbfzOhLmrdRFrFe5Zgl+dvuBi5lRv8fXVD4zw7EOujem561PBdKsY9+bpG
	mGOPwquDSFqYgJFSdOwj2OQfFUDvPWtvyqBGPMlQzxqsH2gW3MJ9GhcSpkWNc7Mu
	EuXiTpqn/WbPQMnK8bfhxYcWLxSiOAiymbbmUehqK6xvVme0fUqXY46kN3ABIABr
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gad8912f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 03:35:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67R7ZaRM015195
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Aug 2026 03:35:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 27 Aug 2026 03:35:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 27 Aug 2026 03:35:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 27 Aug 2026 03:35:36 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67R7Yroq011772;
	Thu, 27 Aug 2026 03:35:27 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 27 Aug 2026 09:34:48 +0200
Subject: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
In-Reply-To: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787816093; l=19255;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Fo5BZNzFiB6Ale/0A2X0dxmEHsmHenYJozCBtqiQa00=;
 b=C8zsEq+uLZb/1SgDykyOY0YXJ8MiR0cIQdYyaWOTUfcwq7RQJVxWiGkxY9GiJb8naX26az8b6
 eVLChQ4jIoQCHUlErZEBRpLO/KMsnsaq6OUe5S6affKKTHMXLSlZ5p0
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6a8fe8ca cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=RYKflIcWaOGVf2NWG3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kLL-hIuEfT_UTXG6ottIGuAN43174n55
X-Proofpoint-ORIG-GUID: kLL-hIuEfT_UTXG6ottIGuAN43174n55
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX8a4E89adIpCF
 GsHLaqz3u43v5NcyNqRKjD9pClmfptA8lYgJ6+4WMvGOv0kNoMX+c4Lh0bdmolHRr88HSRsLdSk
 +1arxGEzjCMxjgL89lq5vv50YQkTQ+8pgMjtEUIe+sE1PFV8bp1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX1FH85mcMpnRl
 uixedSI3lkTqRK8/p3X8HMvZpv3WdCHJFK3igsuaRr/OIQyMrn+KV6wdPJhx6JUVQ+SLkkifLwf
 0ySNUulo3gfIEjvxcMsPYpCBxhLUUnFvHCZ9fZK8125VXCNE+3hPhMcAJ6TeP6+QERSR9i1K0KR
 Fe+CjRDxqdGsNv927pUajxjgDj1HOOjV+3aEuVVWoEvL6yCRR5q3svXXDwGNXQV/dQ0r/lTtnG/
 LHaWXwOb0J45N3P9lvmuBSvDvK475/l1dblYKkB+XC9iq4NBCxjRUeKmLn8juCGArDJGxwbiSRU
 WRVB5M+AAQFPrlAkSGJ3MppIhb3602V6OdKx0oe7LpVDdX+gLX6qCtjoQCNNa7mJ/jkJEioluEo
 uaW9Evp1mP2fEVQg46l9lposxgyT6Wu/Mjol4jK6oYm4UCwvArszmgt4A3TiZlpUWHTC9X0401p
 BF7EKjd6iIdvi3bZHgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270061

Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
from Analog Devices.

The device communicates over SPI and supports per-channel output range
configuration. An optional external 4.096V reference can be used in
place of the internal reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  16 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5529r.c | 536 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 554 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 320e84765ce6..143714e27d51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
+F:	drivers/iio/dac/ad5529r.c
 
 ANALOG DEVICES INC AD5706R DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542..6a7109f42f2a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -134,6 +134,22 @@ config AD5449
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5449.
 
+config AD5529R
+	tristate "Analog Devices AD5529R High Voltage DAC driver"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5529R 16-Channel,
+	  12-Bit/16-Bit, 40V High Voltage Precision Digital to Analog Converter.
+
+	  The device features multiple output voltage ranges from -20V to +20V,
+	  built-in 4.096V voltage reference, and digital functions including
+	  toggle, dither, and ramp modes. Supports both 12-bit and 16-bit
+	  resolution variants.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5529r.
+
 config AD5592R_BASE
 	tristate
 
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 003431798498..f35e060b3643 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
 obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
 obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
 obj-$(CONFIG_AD5449) += ad5449.o
+obj-$(CONFIG_AD5529R) += ad5529r.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
new file mode 100644
index 000000000000..52601cbf28d5
--- /dev/null
+++ b/drivers/iio/dac/ad5529r.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD5529R Digital-to-Analog Converter Driver
+ * 16-Channel, 12/16-Bit, 40V High Voltage Precision DAC
+ *
+ * Copyright 2026 Analog Devices Inc.
+ * Author: Janani Sunil <janani.sunil@analog.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
+#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
+#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
+#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
+#define AD5529R_REG_DEVICE_CONFIG		0x02
+#define AD5529R_REG_CHIP_GRADE			0x06
+#define AD5529R_REG_SCRATCH_PAD			0x0A
+#define AD5529R_REG_SPI_REVISION		0x0B
+#define AD5529R_REG_VENDOR_H			0x0D
+#define AD5529R_REG_STREAM_MODE			0x0E
+#define AD5529R_REG_INTERFACE_STATUS_A		0x11
+#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
+#define AD5529R_REG_OUT_RANGE_BASE		0x3C
+#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
+#define AD5529R_REG_DAC_INPUT_A_BASE		0x148
+#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
+#define AD5529R_REG_DAC_DATA_READBACK_BASE	0x16A
+#define AD5529R_REG_TSENS_ALERT_FLAG		0x18C
+#define AD5529R_REG_TSENS_SHTD_FLAG		0x18E
+#define AD5529R_REG_FUNC_BUSY			0x1A0
+#define AD5529R_REG_REF_SEL			0x1A2
+#define   AD5529R_REF_SEL_INTERNAL_REF		BIT(0)
+#define AD5529R_REG_INIT_CRC_ERR_STAT		0x1A4
+#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
+
+#define AD5529R_MAX_REGISTER			0x232
+#define AD5529R_8BIT_REG_MAX			0x13
+#define AD5529R_MAX_CHANNELS			16
+#define AD5529R_SPI_READ_FLAG			0x80
+#define AD5529R_ADDR_SHIFT			12
+
+struct ad5529r_model_data {
+	const char *model_name;
+	unsigned int resolution;
+};
+
+#define AD5529R_DAC_CHANNEL(chan) ((struct iio_chan_spec) {		\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_OFFSET),		\
+})
+
+static const char * const ad5529r_supply_names[] = {
+	"vdd-io",
+	"vdd-5v",
+	"vdd-hv0",
+	"vdd-hv1",
+	"vdd-hv2",
+	"vdd-hv3",
+};
+
+static const char * const ad5529r_vss_supply_names[] = {
+	"vss-hv0",
+	"vss-hv1",
+	"vss-hv2",
+	"vss-hv3",
+};
+
+static const struct ad5529r_model_data ad5529r_16bit_model_data = {
+	.model_name = "ad5529r-16",
+	.resolution = 16,
+};
+
+static const struct ad5529r_model_data ad5529r_12bit_model_data = {
+	.model_name = "ad5529r-12",
+	.resolution = 12,
+};
+
+enum ad5529r_output_range {
+	AD5529R_RANGE_0V_5V,
+	AD5529R_RANGE_0V_10V,
+	AD5529R_RANGE_0V_20V,
+	AD5529R_RANGE_0V_40V,
+	AD5529R_RANGE_M5V_5V,
+	AD5529R_RANGE_M10V_10V,
+	AD5529R_RANGE_M15V_15V,
+	AD5529R_RANGE_M20V_20V,
+};
+
+static const s32 ad5529r_output_ranges_mV[8][2] = {
+	[AD5529R_RANGE_0V_5V] = { 0, 5000 },
+	[AD5529R_RANGE_0V_10V] = { 0, 10000 },
+	[AD5529R_RANGE_0V_20V] = { 0, 20000 },
+	[AD5529R_RANGE_0V_40V] = { 0, 40000 },
+	[AD5529R_RANGE_M5V_5V] = { -5000, 5000 },
+	[AD5529R_RANGE_M10V_10V] = { -10000, 10000 },
+	[AD5529R_RANGE_M15V_15V] = { -15000, 15000 },
+	[AD5529R_RANGE_M20V_20V] = { -20000, 20000 },
+};
+
+struct ad5529r_state {
+	const struct ad5529r_model_data *model_data;
+	struct regmap *regmap_8bit;
+	struct regmap *regmap_16bit;
+	struct iio_chan_spec channels[AD5529R_MAX_CHANNELS];
+	unsigned int num_channels;
+	enum ad5529r_output_range output_range_idx[AD5529R_MAX_CHANNELS];
+};
+
+static const struct regmap_range ad5529r_8bit_readable_ranges[] = {
+	regmap_reg_range(AD5529R_REG_INTERFACE_CONFIG_A, AD5529R_REG_CHIP_GRADE),
+	regmap_reg_range(AD5529R_REG_SCRATCH_PAD, AD5529R_REG_VENDOR_H),
+	regmap_reg_range(AD5529R_REG_STREAM_MODE, AD5529R_REG_INTERFACE_STATUS_A),
+};
+
+static const struct regmap_range ad5529r_16bit_readable_ranges[] = {
+	regmap_reg_range(AD5529R_REG_MULTI_DAC_CH_SEL, AD5529R_REG_INIT_CRC_ERR_STAT),
+	regmap_reg_range(AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC, AD5529R_MAX_REGISTER),
+};
+
+static const struct regmap_access_table ad5529r_8bit_readable_table = {
+	.yes_ranges = ad5529r_8bit_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad5529r_8bit_readable_ranges),
+};
+
+static const struct regmap_access_table ad5529r_16bit_readable_table = {
+	.yes_ranges = ad5529r_16bit_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad5529r_16bit_readable_ranges),
+};
+
+static const struct regmap_range ad5529r_8bit_read_only_ranges[] = {
+	regmap_reg_range(AD5529R_REG_DEVICE_CONFIG, AD5529R_REG_CHIP_GRADE),
+	regmap_reg_range(AD5529R_REG_SPI_REVISION, AD5529R_REG_VENDOR_H),
+};
+
+static const struct regmap_range ad5529r_16bit_read_only_ranges[] = {
+	regmap_reg_range(AD5529R_REG_DAC_DATA_READBACK_BASE,
+			 AD5529R_REG_DAC_DATA_READBACK_BASE +
+			 (AD5529R_MAX_CHANNELS - 1) * 2),
+	regmap_reg_range(AD5529R_REG_TSENS_ALERT_FLAG, AD5529R_REG_TSENS_SHTD_FLAG),
+	regmap_reg_range(AD5529R_REG_FUNC_BUSY, AD5529R_REG_FUNC_BUSY),
+	regmap_reg_range(AD5529R_REG_INIT_CRC_ERR_STAT, AD5529R_REG_INIT_CRC_ERR_STAT),
+};
+
+static const struct regmap_access_table ad5529r_8bit_writeable_table = {
+	.no_ranges = ad5529r_8bit_read_only_ranges,
+	.n_no_ranges = ARRAY_SIZE(ad5529r_8bit_read_only_ranges),
+};
+
+static const struct regmap_access_table ad5529r_16bit_writeable_table = {
+	.no_ranges = ad5529r_16bit_read_only_ranges,
+	.n_no_ranges = ARRAY_SIZE(ad5529r_16bit_read_only_ranges),
+};
+
+static struct regmap *ad5529r_get_regmap(struct ad5529r_state *st,
+					 unsigned int reg)
+{
+	if (reg <= AD5529R_8BIT_REG_MAX)
+		return st->regmap_8bit;
+
+	return st->regmap_16bit;
+}
+
+static int ad5529r_reset(struct ad5529r_state *st)
+{
+	struct reset_control *rst;
+	struct regmap *map = st->regmap_8bit;
+	struct device *dev = regmap_get_device(map);
+	int ret;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	if (rst) {
+		ret = reset_control_assert(rst);
+		if (ret)
+			return ret;
+
+		/* Minimum reset low width (t_reset) is 20 ns per datasheet. */
+		ndelay(20);
+
+		ret = reset_control_deassert(rst);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(map, AD5529R_REG_INTERFACE_CONFIG_A,
+				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Wait 10 ms for digital initialization to complete.
+	 * Per datasheet, Interface Status A register NOT_READY_ERR bit is
+	 * set if SPI transactions are attempted before digital initialization
+	 * completes.
+	 */
+	fsleep(10 * USEC_PER_MSEC);
+
+	return regmap_write(map, AD5529R_REG_INTERFACE_CONFIG_A,
+			    AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
+			    AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
+}
+
+static int ad5529r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+	unsigned int reg_addr, reg_val_h;
+	int ret, range_idx, span_mV;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
+		 * The DAC operates in transparent mode and directly reflects
+		 * whatever value is written to the INPUT_A register.
+		 */
+		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
+		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
+		if (ret)
+			return ret;
+
+		*val = reg_val_h;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		range_idx = st->output_range_idx[chan->channel];
+
+		/*
+		 * The datasheet specifies a 4.096 V external reference,
+		 * matching the nominal output voltage of the internal
+		 * reference.
+		 */
+		span_mV = ad5529r_output_ranges_mV[range_idx][1] -
+			  ad5529r_output_ranges_mV[range_idx][0];
+		*val = span_mV;
+		*val2 = st->model_data->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		range_idx = st->output_range_idx[chan->channel];
+
+		if (ad5529r_output_ranges_mV[range_idx][0] < 0)
+			*val = -BIT(st->model_data->resolution - 1);
+		else
+			*val = 0;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5529r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+	unsigned int reg_addr;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))
+			return -EINVAL;
+
+		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
+
+		return regmap_write(st->regmap_16bit, reg_addr, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5529r_find_output_range(const s32 *vals)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mV); i++) {
+		const s32 *range = ad5529r_output_ranges_mV[i];
+
+		if (vals[0] == range[0] * (MICRO / MILLI) &&
+		    vals[1] == range[1] * (MICRO / MILLI))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5529r_parse_channel_ranges(struct device *dev,
+					struct ad5529r_state *st)
+{
+	unsigned long channel_mask = 0;
+	s32 vals[2];
+	int ret, range_idx;
+	u32 ch;
+
+	device_for_each_child_node_scoped(dev, child) {
+		if (st->num_channels == ARRAY_SIZE(st->channels))
+			return dev_err_probe(dev, -ECHRNG, "Too many channels\n");
+
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing reg property in channel node\n");
+
+		if (ch >= AD5529R_MAX_CHANNELS)
+			return dev_err_probe(dev, -EINVAL,
+					     "Channel %u exceeds maximum 15\n",
+					     ch);
+
+		if (channel_mask & BIT(ch))
+			return dev_err_probe(dev, -EINVAL,
+					     "Duplicate channel %u\n", ch);
+
+		channel_mask |= BIT(ch);
+
+		if (fwnode_property_present(child, "output-range-microvolt")) {
+			/*
+			 * DT stores cells as raw 32-bit values; signed endpoints are
+			 * encoded by dtc in two's-complement and then interpreted
+			 * here as s32.
+			 */
+			ret = fwnode_property_read_u32_array(child,
+							     "output-range-microvolt",
+							     (u32 *)vals, ARRAY_SIZE(vals));
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "Failed to read range for ch %u\n",
+						     ch);
+
+			range_idx = ad5529r_find_output_range(vals);
+			if (range_idx < 0)
+				return dev_err_probe(dev, range_idx,
+						     "Invalid range [%d %d] for ch %u\n",
+						     vals[0], vals[1], ch);
+		} else {
+			range_idx = AD5529R_RANGE_0V_5V;
+		}
+
+		st->output_range_idx[ch] = range_idx;
+		ret = regmap_write(st->regmap_16bit,
+				   AD5529R_REG_OUT_RANGE(ch), range_idx);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure range for ch %u\n",
+					     ch);
+
+		st->channels[st->num_channels++] = AD5529R_DAC_CHANNEL(ch);
+	}
+
+	return 0;
+}
+
+static int ad5529r_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(ad5529r_get_regmap(st, reg), reg, readval);
+
+	return regmap_write(ad5529r_get_regmap(st, reg), reg, writeval);
+}
+
+static const struct iio_info ad5529r_info = {
+	.read_raw = ad5529r_read_raw,
+	.write_raw = ad5529r_write_raw,
+	.debugfs_reg_access = ad5529r_reg_access,
+};
+
+static int ad5529r_probe(struct spi_device *spi)
+{
+	struct regmap_config regmap_16bit_cfg;
+	struct regmap_config regmap_8bit_cfg;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5529r_state *st;
+	bool external_vref;
+	u32 dev_addr = 0;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->model_data = spi_get_device_match_data(spi);
+	if (!st->model_data)
+		return dev_err_probe(dev, -ENODATA,
+				     "Failed to identify device variant\n");
+
+	device_property_read_u32(dev, "spi-device-addr", &dev_addr);
+	if (dev_addr > 3)
+		return dev_err_probe(dev, -EINVAL,
+				     "spi-device-addr %u out of range [0, 3]\n",
+				     dev_addr);
+
+	regmap_8bit_cfg = (struct regmap_config) {
+		.name = "ad5529r-8bit",
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = AD5529R_8BIT_REG_MAX,
+		.read_flag_mask = AD5529R_SPI_READ_FLAG,
+		.rd_table = &ad5529r_8bit_readable_table,
+		.wr_table = &ad5529r_8bit_writeable_table,
+		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
+	};
+	regmap_16bit_cfg = (struct regmap_config) {
+		.name = "ad5529r-16bit",
+		.reg_bits = 16,
+		.val_bits = 16,
+		.max_register = AD5529R_MAX_REGISTER,
+		.read_flag_mask = AD5529R_SPI_READ_FLAG,
+		.val_format_endian = REGMAP_ENDIAN_LITTLE,
+		.rd_table = &ad5529r_16bit_readable_table,
+		.wr_table = &ad5529r_16bit_writeable_table,
+		.reg_stride = 2,
+		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
+	};
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
+					     ad5529r_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable regulators\n");
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_vss_supply_names); i++) {
+		ret = devm_regulator_get_enable_optional(dev,
+							 ad5529r_vss_supply_names[i]);
+		if (ret && ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get and enable %s regulator\n",
+					     ad5529r_vss_supply_names[i]);
+	}
+
+	ret = devm_regulator_get_enable_optional(dev, "vref");
+	if (ret == -ENODEV)
+		external_vref = false;
+	else if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable vref regulator\n");
+	else
+		external_vref = true;
+
+	/* Wait 10 ms after power-up before the first SPI transaction. */
+	fsleep(10 * USEC_PER_MSEC);
+
+	st->regmap_8bit = devm_regmap_init_spi(spi, &regmap_8bit_cfg);
+	if (IS_ERR(st->regmap_8bit))
+		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
+				     "Failed to initialize 8-bit regmap\n");
+
+	st->regmap_16bit = devm_regmap_init_spi(spi, &regmap_16bit_cfg);
+	if (IS_ERR(st->regmap_16bit))
+		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
+				     "Failed to initialize 16-bit regmap\n");
+
+	ret = ad5529r_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
+
+	ret = regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
+				 AD5529R_REF_SEL_INTERNAL_REF,
+				 !external_vref);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure reference\n");
+
+	ret = ad5529r_parse_channel_ranges(dev, st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->model_data->model_name;
+	indio_dev->info = &ad5529r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->channels;
+	indio_dev->num_channels = st->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad5529r_of_match[] = {
+	{ .compatible = "adi,ad5529r-16", .data = &ad5529r_16bit_model_data },
+	{ .compatible = "adi,ad5529r-12", .data = &ad5529r_12bit_model_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5529r_of_match);
+
+static const struct spi_device_id ad5529r_id[] = {
+	{
+		.name = "ad5529r-16",
+		.driver_data = (kernel_ulong_t)&ad5529r_16bit_model_data,
+	},
+	{
+		.name = "ad5529r-12",
+		.driver_data = (kernel_ulong_t)&ad5529r_12bit_model_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5529r_id);
+
+static struct spi_driver ad5529r_driver = {
+	.driver = {
+		.name = "ad5529r",
+		.of_match_table = ad5529r_of_match,
+	},
+	.probe = ad5529r_probe,
+	.id_table = ad5529r_id,
+};
+module_spi_driver(ad5529r_driver);
+
+MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5529R 12/16-bit DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

