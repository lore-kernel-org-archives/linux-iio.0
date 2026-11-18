Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007104;
	b=MAsfoc/Eciu8LA5H+WyZSj0SOEGZPzGc9sw4zNl8uFF6zGCHq6XYzibV7mR+VlHmRMTD
	 ucf/QbL/VoJ3Z92DesINGRyNuB7CL7+aCAymRbvHal7xSS/o8OflkWZAzhxsMVpc5L7v2
	 jDu3ZO91PmTgGgt91iPrTbqNsC60cEM2UL7i6agKdykKbvLiAYzItqSCH2Chdvx8xdI5/
	 OTxxDxTy6NmtEnwQ5a7oCMKviT4u4NVQK1YA0dwnMqUUwOdXtroUAICD9ru5pyYGhl/4j
	 sYSKCYMqs5IUHGz4sdCpI+A+S9BjJOkFx1z5xj7OPE8bnyUVYwjbgeMYo5wwmIuy5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007104;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tsVPY+eQFebxYY/CK7S76Ud6Mn+8upQmmixc/dcmSbU=;
	b=2XlS8TXQ6n8nU9INHfGnJOpagBJKaQFciN/oqaNx0reZi/70U1UaqnuViLerQgwQSMRH
	 0Jau6EZ2Ew3xTx0F8dB+JnPw+oZAXssfuoHsfDwiLbb5yq4InmNZhP2MQ3yWgZjG3RTlX
	 h8XvDvxbSqY6xeDdcEF+PU7CaKiJeBXS0lJ9wcFaIpqAnEwiifM2de0ykBYSkw0jwGWxZ
	 UTRD7wvuNbC3zP260Liq50/rMdzdLDW4kDKO29VFet7+dHGrS6kX3vji23AXL6m5aAUFn
	 9F8JMc1VCDQ21uP231vyYNSxSO8sp8M4RtHbTHaoe/zrl8z7u83wW3Y184ad94kI8Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="nPd/fXlE";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CLqCFTN1;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEC606A31C;
	Wed, 18 Nov 2026 13:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nPd/fXlE;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CLqCFTN1
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBLFZ1900236;
	Wed, 18 Nov 2026 08:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tsVPY+eQFebxYY/CK7S76Ud6Mn+8upQmmixc/dcmSbU=; b=nPd/fXl
	E7qU945UN/Ks4Wr5VNousT7kudkp8fC0/R1XN45OrBByrkBxCdpGBRFm4Sm+xVla
	No3x3UcKwYv4Z4qU4Rzq3MRzlRbAm5dhdv0eD3SWnK37v/2OG2HTnrV9+wrwIiJw
	Q1PbKsmyxXgFxV5iT+VTwpyAdMD4TyvB1BzaIMMjyzv4KxSMn5NTMipXQ6PcYrlI
	sSXzqwi7G4VeYkHm8y7ZaJZbo8yYZjfkF5XiSxAuNIN9GUOJGZ2dlAfmIT6oF29S
	vbH42Dr0lVi4/1McV/PWjZhqDGdlQBAlLiUw0UuyF6OlppluNH6rH4i8V9uwlET4
	pWs6mPdYBtXyGdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tsVPY
	+eQFebxYY/CK7S76Ud6Mn+8upQmmixc/dcmSbU=; b=CLqCFTN18x+xfY0os1ENJ
	3h6zvVYFPD9tMGvi3hcx63P9DG0eSC0kBsnYrl9T3yKLilrxWRDr3hmaGTZ2pEJ1
	hgQ7VnM+YzmOF07WQc1AqFOpBayqGM1ptfmVRJTDcaRIUNbh5cjL/U8P4S+Q4S5+
	1z99+VqB1mkx9NoCx2hbB7ZG2s+duBiPimRcRocd4FpstrxplOGOfuJIlXV7u1ow
	ds3em7QdLpM2InKY6BIlq8RoUthpp7bFTpquVdvrLG28g/jTs8nQJ4A18OC+sgNg
	2SzK6ew5fd5YQxe2nMqktKk00IGHRQ10iCBtVhNxiOOvaCNOnUC3ku/SxitaHLVJ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j174g1nva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:04:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AID4sbs057545
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:04:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 08:04:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:04:53 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID4dZv022842;
	Wed, 18 Nov 2026 08:04:41 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 5/5] iio: adc: Add support for ADA4355 and similar ADCs
Date: Wed, 18 Nov 2026 10:04:33 -0300
Message-ID: <2f5e83aa17aea08bbff69ca6ef7d32b11368f518.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G+2JgNk5 c=1 sm=1 tr=0 ts=6afda277 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=y2cn4dvvLQReLAy5-fIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vlhZ6p1f4YlF5SEEcZl5dPvvr-UTekd9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXzUMLrpN7YsMF
 9/DCSb+CMpNbg0ckBRCx3bRAjNxjxASh4JDRmrLxAE88LKpqs4dsYYr8p+X/6QJO44YPxu1kykI
 qIxdav7FEKFb/1IW/87bHAom7OZgrtASJHXxzXlJhWlr2ontv9Mz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX/Xd/SItIhHxL
 qtTb3n/McKngVWzGCXO/1luru7S6rtTKW+gutjm3cfqqnmafh6zAbCiUniAi0iNmGlbdY5LaD/f
 /EW52tEerp6a5QBTNuO+b3QjJFGaHRcSUzBQ857ZlQJcJEdfaSIn9BPpTf3ffLohuGUqiiU/U2F
 zRMpphpLU8z24EueH6OcxrM1Vu7Pr1yoxbpkB6J3GIGHp8V+wuRUwTAXG0BoG3G9QHmo+2qj2VA
 Oa0yxuUrGMuQsR3ltfyrLdg8Kc8bkNFQnIsduUHSbkXL7Ghh4ho48JXhtxyF/aR3z9tx4dJUatz
 htdJD+5RAcHLrJyFQdGtvmF3UYZ9ljftNNN/sfeOWxJrbZYog27/TWAddvB3W2ihGtz8Cywa0tn
 84Zff8eSPXYcTUApZJjAX6EhS24lbxXq9dZPdGP9hXpYoRTioyG5c1AurQisyZNKZq4AFAkFHMh
 wsoHY5zG16L71b3V7kw==
X-Proofpoint-ORIG-GUID: vlhZ6p1f4YlF5SEEcZl5dPvvr-UTekd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052

The ADA4355 and AD4356 are 14-bit, 125 MSPS, analog-to-digital converters
with integrated analog front-end. These chips are configured over SPI while
conversion data is streamed over a serial LVDS interface handled by an IIO
backend.

Add an IIO device driver for ADA4355 and similar designs, providing device
configuration, debugfs register access and buffered captures through the
IIO backend framework.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  11 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ada4355.c | 798 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 811 insertions(+)
 create mode 100644 drivers/iio/adc/ada4355.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 692f1e6d56ec..9e655a215c18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,6 +1800,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
+F:	drivers/iio/adc/ada4355.c
 
 ANALOG DEVICES INC ADE9000 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab..173e50e177fc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -606,6 +606,17 @@ config AD9467
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad9467.
 
+config ADA4355
+	tristate "Analog Devices ADA4355 uModule Data Acquisition Module"
+	depends on SPI
+	select IIO_BACKEND
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices ADA4355
+	  14-bit, 125MSPS, high-speed dual-channel analog to digital
+	  converters (ADC) that realize a complete current to bits data
+	  acquisition solution.
+
 config ADE9000
 	tristate "Analog Devices Multiphase Energy and Power Quality Monitoring IC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 769965295dcc..167967999ba9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_AD7944) += ad7944.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AD9467) += ad9467.o
+obj-$(CONFIG_ADA4355) += ada4355.o
 obj-$(CONFIG_ADE9000) += ade9000.o
 obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
diff --git a/drivers/iio/adc/ada4355.c b/drivers/iio/adc/ada4355.c
new file mode 100644
index 000000000000..7f9f58a14385
--- /dev/null
+++ b/drivers/iio/adc/ada4355.c
@@ -0,0 +1,798 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices ADA4355 device driver
+ *
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ *
+ * Expanded and improved version made on top of preliminary code from:
+ *	Antoniu Miclaus <antoniu.miclaus@analog.com>
+ *	Pop Ioan Daniel <pop.ioan-daniel@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define ADA4355_CHIP_CONFIG_REG			0x00
+#define ADA4355_CHIP_ID_REG			0x01
+#define ADA4355_CHIP_ID				0x8B
+
+#define ADA4355_DEVICE_INDEX_REG		0x05
+#define ADA4355_TRANSFER_REG			0xFF
+#define ADA4355_TRANSFER_OVERRIDE		BIT(0)
+
+#define ADA4355_POWER_MODES_REG			0x08
+#define ADA4355_PW_MODE_DIGITAL_RESET		GENMASK(1, 0)
+
+#define ADA4355_TEST_MODE_REG			0x0D
+#define ADA4355_TEST_MODE_MASK			GENMASK(3, 0)
+/* Reset the pattern generator whenever a test mode is selected. */
+#define ADA4355_TEST_MODE_RESET_PN		BIT(6)
+#define ADA4355_TEST_MODE_OFF			0x0
+#define ADA4355_TEST_MODE_ALT_CHECKERBOARD	0x4
+#define ADA4355_TEST_MODE_USER			0x8
+
+#define ADA4355_OUTPUT_MODE_REG			0x14
+#define ADA4355_OUTPUT_MODE_TWOSCOMP		BIT(0)
+
+#define ADA4355_USER_PATT1_LSB_REG		0x19
+#define ADA4355_USER_PATT1_MSB_REG		0x1A
+#define ADA4355_USER_PATT2_LSB_REG		0x1B
+#define ADA4355_USER_PATT2_MSB_REG		0x1C
+#define ADA4355_SERIAL_OUT_DATA_CNTRL_REG	0x21
+#define ADA4355_SERIAL_OUT_LANE_MODE_MASK	GENMASK(6, 4)
+#define ADA4355_DDR_ONE_LANE_WORDWISE		0x4
+#define ADA4355_DDR_TWO_LANE_BITWISE		0x2
+
+#define ADA4355_SERIAL_CHANNEL_STATUS_REG	0x22
+#define ADA4355_RESOLUTION_SAMPLE_RATE_REG	0x100
+#define ADA4355_125_RATE			0x06
+
+/*
+ * Pattern the digital interface is calibrated against. The pattern match
+ * block of the HDL core expects this exact value.
+ */
+#define ADA4355_CALIB_PATTERN			0xFFFC
+
+#define ADA4355_MAX_TEST_POINTS			32
+/*
+ * Number of data lanes of the LVDS interface. The frame signal gets its own
+ * I/O delay line, right after the data ones.
+ */
+#define ADA4355_MAX_DATA_LANES			2
+#define ADA4355_FRAME_LANE			ADA4355_MAX_DATA_LANES
+/* One set of test points per data lane, plus one for the frame signal. */
+#define ADA4355_MAX_CALIB_MAP_SIZE \
+	(ADA4355_MAX_TEST_POINTS * (ADA4355_MAX_DATA_LANES + 1))
+
+#define ADA4355_SYNC_TIMEOUT_US			1000
+/* Time the duty cycle stabilizer loop needs to relock after a rate change. */
+#define ADA4355_DCS_RELOCK_US			5
+
+#define ADA4355_MAX_SAMP_RATE_SPS		(125 * MEGA)
+
+/* ADC differential input span, ±1 V with the 1 V internal reference. */
+#define ADA4355_ADC_SPAN_mV			2000
+/* ADC differential input with no input current flowing. */
+#define ADA4355_ADC_BIAS_mV			825
+
+#define ADA4355_NUM_GSEL_GPIOS			2
+
+enum ada4355_tz_options {
+	ADA4355_TZ0,
+	ADA4355_TZ1,
+	ADA4355_TZ2,
+};
+
+static const unsigned int ada4355_tz_options_ohms[] = {
+	[ADA4355_TZ1] = 2000, /* -80 to +800 uA input range */
+	[ADA4355_TZ2] = 20000, /* -8.0 to +80 uA input range */
+	[ADA4355_TZ0] = 200000, /* -0.8 to +8.0 uA input range */
+};
+
+static const unsigned int ada4356_tz_options_ohms[] = {
+	[ADA4355_TZ1] = 4540, /* 3 to 300 uA input range */
+	[ADA4355_TZ2] = 11000, /* 1 to 100 uA input range */
+	[ADA4355_TZ0] = 133000, /* 0.1 to 10 uA input range */
+};
+
+struct ada4355_chip_info {
+	const char *name;
+	unsigned int id;
+	const unsigned int *gain_options;
+	int gain_options_size;
+};
+
+struct ada4355_state {
+	struct iio_backend *back;
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct clk *clk;
+	const struct iio_chan_spec *chan;
+	/* GSEL0 and GSEL1, in that order. */
+	struct gpio_descs *gsel;
+	/* Precomputed scale for each gain option, as {integer, nano} pairs. */
+	int scale_tb[ARRAY_SIZE(ada4355_tz_options_ohms)][2];
+	unsigned int scale_tb_size;
+	unsigned int scale_idx;
+	DECLARE_BITMAP(calib_map, ADA4355_MAX_CALIB_MAP_SIZE);
+	unsigned int calib_map_size;
+	/* Protect against concurrent accesses to the device and data content */
+	struct mutex lock;
+};
+
+static const struct regmap_config ada4355_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static int ada4355_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				      unsigned int writeval, unsigned int *readval)
+{
+	struct ada4355_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+/*
+ * The ADC output code decreases as the input current increases so the scale to
+ * milliamps is sign reversed.
+ */
+static void ada4355_fill_scale_tb(struct ada4355_state *st,
+				  struct ada4355_chip_info const *chip_info)
+{
+	u64 numerator, denominator;
+	u32 rem;
+
+	st->scale_tb_size = chip_info->gain_options_size;
+	for (unsigned int i = 0; i < st->scale_tb_size; i++) {
+		numerator = (u64)ADA4355_ADC_SPAN_mV * NANO * MILLI;
+		denominator = BIT_ULL(st->chan->scan_type.realbits) * chip_info->gain_options[i];
+		numerator = div64_u64(numerator, denominator);
+		st->scale_tb[i][0] = div_u64_rem(numerator, NANO, &rem);
+		st->scale_tb[i][1] = -(int)rem;
+	}
+}
+
+static int ada4355_get_scale(struct ada4355_state *st, int *val, int *val2)
+{
+	*val = st->scale_tb[st->scale_idx][0];
+	*val2 = st->scale_tb[st->scale_idx][1];
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int ada4355_set_scale(struct ada4355_state *st, int val, int val2)
+{
+	unsigned long gsel;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	for (unsigned int i = 0; i < st->scale_tb_size; i++) {
+		if (st->scale_tb[i][0] != val || st->scale_tb[i][1] != val2)
+			continue;
+
+		gsel = i;
+
+		ret = gpiod_multi_set_value_cansleep(st->gsel, &gsel);
+		if (ret)
+			return ret;
+
+		st->scale_idx = i;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * The ADC input is biased at ADA4355_ADC_BIAS_mV with no input current, so that
+ * is the code that has to read as zero milliamps.
+ */
+static int ada4355_get_offset(struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	s64 tmp;
+
+	tmp = div_s64(((s64)ADA4355_ADC_BIAS_mV * MICRO) << chan->scan_type.realbits,
+		      ADA4355_ADC_SPAN_mV);
+	*val = div_s64_rem(-tmp, MICRO, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ada4355_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long m)
+{
+	struct ada4355_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		return ada4355_get_scale(st, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		return ada4355_get_offset(chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(st->clk);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4355_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ada4355_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scale_tb;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = st->scale_tb_size * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec ada4355_channel = {
+	.type = IIO_CURRENT,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.scan_type = {
+		.format = IIO_SCAN_FORMAT_SIGNED_INT,
+		.realbits = 14,
+		.storagebits = 16,
+		.shift = 2,
+	},
+};
+
+static const struct ada4355_chip_info ada4355_chip_info = {
+	.name = "ada4355",
+	.id = ADA4355_CHIP_ID,
+	.gain_options = ada4355_tz_options_ohms,
+	.gain_options_size = ARRAY_SIZE(ada4355_tz_options_ohms),
+};
+
+static const struct ada4355_chip_info ada4356_chip_info = {
+	.name = "ada4356",
+	.id = ADA4355_CHIP_ID,
+	.gain_options = ada4356_tz_options_ohms,
+	.gain_options_size = ARRAY_SIZE(ada4356_tz_options_ohms),
+};
+
+static int ada4355_testmode_set(struct ada4355_state *st, unsigned int test_mode)
+{
+	unsigned int val = 0;
+
+	if (test_mode != ADA4355_TEST_MODE_OFF)
+		val = ADA4355_TEST_MODE_RESET_PN |
+			FIELD_PREP(ADA4355_TEST_MODE_MASK, test_mode);
+
+	return regmap_write(st->regmap, ADA4355_TEST_MODE_REG, val);
+}
+
+/*
+ * Find the maximum number of successful points in a row and get the one in the
+ * middle.
+ */
+static unsigned int ada4355_find_optimal_point(const unsigned long *calib_map,
+					       unsigned int start,
+					       unsigned int nbits,
+					       unsigned int *val)
+{
+	unsigned int bit = start, end, start_cnt, cnt = 0;
+
+	for_each_clear_bitrange_from(bit, end, calib_map, nbits + start) {
+		if (end - bit > cnt) {
+			cnt = end - bit;
+			start_cnt = bit;
+		}
+	}
+
+	if (cnt)
+		*val = start_cnt + cnt / 2;
+
+	return cnt;
+}
+
+static int ada4355_calibrate_prepare(struct ada4355_state *st)
+{
+	struct iio_backend_data_fmt data = {
+		.enable = false,
+	};
+	int ret;
+
+	/*
+	 * The channel spec already accounts for the 14-bit sample being left
+	 * aligned in a 16-bit word, so the backend format conversion stays off
+	 * both during and after the calibration.
+	 */
+	ret = iio_backend_data_format_set(st->back, 0, &data);
+	if (ret)
+		return ret;
+
+	ret = ada4355_testmode_set(st, ADA4355_TEST_MODE_USER);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_USER_PATT1_MSB_REG,
+			   ADA4355_CALIB_PATTERN >> 8);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_USER_PATT1_LSB_REG,
+			   ADA4355_CALIB_PATTERN & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_USER_PATT2_MSB_REG,
+			   ADA4355_CALIB_PATTERN >> 8);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_USER_PATT2_LSB_REG,
+			   ADA4355_CALIB_PATTERN & 0xFF);
+	if (ret)
+		return ret;
+
+	return iio_backend_chan_enable(st->back, 0);
+}
+
+static int ada4355_calibrate_stop(struct ada4355_state *st)
+{
+	int ret;
+
+	ret = iio_backend_calibration_source_set(st->back,
+						 IIO_BACKEND_CALIB_SOURCE_NONE,
+						 0);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_chan_disable(st->back, 0);
+	if (ret)
+		return ret;
+
+	return ada4355_testmode_set(st, ADA4355_TEST_MODE_OFF);
+}
+
+/*
+ * Sweep the I/O delay of one delay line while only the error source fed by
+ * that line is reported, and apply the delay in the middle of the widest run
+ * of valid test points. @offset is where this line's test points start in
+ * @st->calib_map.
+ */
+static int ada4355_calibrate_lane(struct ada4355_state *st,
+				  enum iio_backend_calib_source source,
+				  unsigned int lane, unsigned int offset)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int point, val, cnt;
+	bool stat;
+	int ret;
+
+	ret = iio_backend_calibration_source_set(st->back, source, lane);
+	if (ret)
+		return ret;
+
+	for (point = 0; point < ADA4355_MAX_TEST_POINTS; point++) {
+		ret = iio_backend_iodelay_set(st->back, lane, point);
+		if (ret)
+			return ret;
+
+		ret = iio_backend_chan_status(st->back, 0, &stat);
+		if (ret)
+			return ret;
+
+		if (stat) {
+			dev_dbg(dev, "Invalid point(%u) for lane %u\n", point,
+				lane);
+			continue;
+		}
+
+		__clear_bit(offset + point, st->calib_map);
+	}
+
+	cnt = ada4355_find_optimal_point(st->calib_map, offset, ADA4355_MAX_TEST_POINTS,
+					 &val);
+	if (!cnt) {
+		dev_err(dev, "No valid delay found for lane %u\n", lane);
+		return -EIO;
+	}
+
+	/* "normalize" the selected value */
+	val -= offset;
+	dev_dbg(dev, "lane %u: selected delay: %u\n", lane, val);
+
+	return iio_backend_iodelay_set(st->back, lane, val);
+}
+
+static int ada4355_calibrate(struct ada4355_state *st)
+{
+	unsigned int lane;
+	int ret;
+
+	/* all points invalid */
+	bitmap_fill(st->calib_map, st->calib_map_size);
+
+	ret = ada4355_calibrate_prepare(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * The frame signal has to be aligned first: the pattern match block
+	 * only reports meaningful per-lane errors once the word boundary is
+	 * known.
+	 */
+	ret = ada4355_calibrate_lane(st, IIO_BACKEND_CALIB_SOURCE_FRAME,
+				     ADA4355_FRAME_LANE,
+				     ADA4355_MAX_DATA_LANES * ADA4355_MAX_TEST_POINTS);
+	if (ret)
+		return ret;
+
+	for (lane = 0; lane < ADA4355_MAX_DATA_LANES; lane++) {
+		ret = ada4355_calibrate_lane(st,
+					     IIO_BACKEND_CALIB_SOURCE_DATA_LANE,
+					     lane,
+					     lane * ADA4355_MAX_TEST_POINTS);
+		if (ret)
+			return ret;
+	}
+
+	return ada4355_calibrate_stop(st);
+}
+
+/*
+ * The internal state machine needs a stable clock to bring the ADC up. If the
+ * clock was absent or unstable by then, the ADC starts in an unknown state and
+ * only a digital reset recovers it. The same holds for clock instability during
+ * normal operation, a rate change included. Unlike the soft reset of
+ * ADA4355_CHIP_CONFIG_REG, this one leaves the user registers untouched.
+ */
+static int ada4355_digital_reset(struct ada4355_state *st)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_write(st->regmap, ADA4355_POWER_MODES_REG,
+			   ADA4355_PW_MODE_DIGITAL_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADA4355_POWER_MODES_REG, &reg);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(st->regmap, ADA4355_POWER_MODES_REG,
+				 ADA4355_PW_MODE_DIGITAL_RESET);
+}
+
+static int ada4355_update_clock(struct ada4355_state *st, long r_clk)
+{
+	unsigned long sample_rate;
+	int ret;
+
+	/* Avoid unnecessary calibration if the clock won't change. */
+	sample_rate = clk_get_rate(st->clk);
+	if (sample_rate == r_clk)
+		return 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = clk_set_rate(st->clk, r_clk);
+	if (ret)
+		return ret;
+
+	fsleep(ADA4355_DCS_RELOCK_US);
+
+	/*
+	 * Changing the rate under the running state machine counts as clock
+	 * instability, so put the digital side back into a known state.
+	 */
+	ret = ada4355_digital_reset(st);
+	if (ret)
+		return ret;
+
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return ada4355_calibrate(st);
+
+	return 0;
+}
+
+static int ada4355_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ada4355_state *st = iio_priv(indio_dev);
+	long r_clk;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		r_clk = clk_round_rate(st->clk, val);
+		if (!in_range(r_clk, 1, ADA4355_MAX_SAMP_RATE_SPS))
+			return -ERANGE;
+
+		return ada4355_update_clock(st, r_clk);
+	case IIO_CHAN_INFO_SCALE:
+		return ada4355_set_scale(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ada4355_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ada4355_iio_info = {
+	.read_raw = ada4355_read_raw,
+	.read_avail = ada4355_read_avail,
+	.write_raw = ada4355_write_raw,
+	.write_raw_get_fmt = ada4355_write_raw_get_fmt,
+	.debugfs_reg_access = ada4355_debugfs_reg_access,
+};
+
+static int ada4355_setup(struct ada4355_state *st,
+			 struct ada4355_chip_info const *chip_info)
+{
+	struct device *dev = &st->spi->dev;
+	struct gpio_desc *gpio_vld_en;
+	struct gpio_desc *gpio_lfp;
+	unsigned int id;
+	int ret;
+
+	gpio_vld_en = devm_gpiod_get(dev, "adi,vld-en", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio_vld_en))
+		return dev_err_probe(dev, PTR_ERR(gpio_vld_en),
+				     "Failed to find adi,vld-en-gpios\n");
+
+	if (gpio_vld_en) {
+		gpiod_set_value_cansleep(gpio_vld_en, 1);
+		fsleep(1000);
+	}
+
+	gpio_lfp = devm_gpiod_get(dev, "adi,lfp", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio_lfp))
+		return dev_err_probe(dev, PTR_ERR(gpio_lfp),
+				     "Failed to find adi,lfp-gpios\n");
+
+	ret = ada4355_digital_reset(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_CHIP_CONFIG_REG, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x02);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_SERIAL_CHANNEL_STATUS_REG, 0x03);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x31);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADA4355_CHIP_ID_REG, &id);
+	if (ret)
+		return ret;
+
+	if (id != chip_info->id)
+		dev_warn(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
+			 id, chip_info->id);
+
+	ret = regmap_update_bits(st->regmap, ADA4355_SERIAL_OUT_DATA_CNTRL_REG,
+				 ADA4355_SERIAL_OUT_LANE_MODE_MASK,
+				 FIELD_PREP(ADA4355_SERIAL_OUT_LANE_MODE_MASK,
+					    ADA4355_DDR_TWO_LANE_BITWISE));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, ADA4355_TRANSFER_REG,
+			      ADA4355_TRANSFER_OVERRIDE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_OUTPUT_MODE_REG,
+			   ADA4355_OUTPUT_MODE_TWOSCOMP);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADA4355_RESOLUTION_SAMPLE_RATE_REG,
+			   ADA4355_125_RATE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ada4355_gain_setup(struct ada4355_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned long gsel;
+
+	st->gsel = devm_gpiod_get_array(dev, "adi,gsel", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gsel))
+		return dev_err_probe(dev, PTR_ERR(st->gsel),
+				     "Failed to get adi,gsel-gpios\n");
+
+	if (st->gsel->ndescs != ADA4355_NUM_GSEL_GPIOS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Expected %u adi,gsel-gpios, got %u\n",
+				     ADA4355_NUM_GSEL_GPIOS, st->gsel->ndescs);
+
+	/* Start with the widest input current range configuration. */
+	st->scale_idx = ADA4355_TZ1;
+	gsel = ADA4355_TZ1;
+
+	return gpiod_multi_set_value_cansleep(st->gsel, &gsel);
+}
+
+static int ada4355_interface_setup(struct ada4355_state *st)
+{
+	int ret;
+
+	ret = iio_backend_num_lanes_set(st->back, ADA4355_MAX_DATA_LANES);
+	if (ret)
+		return ret;
+
+	return iio_backend_interface_data_align(st->back,
+						ADA4355_SYNC_TIMEOUT_US);
+}
+
+static int ada4355_probe(struct spi_device *spi)
+{
+	const struct ada4355_chip_info *chip_info;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ada4355_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODATA;
+
+	st->regmap = devm_regmap_init_spi(spi, &ada4355_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->calib_map_size = ADA4355_MAX_CALIB_MAP_SIZE;
+
+	st->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(st->clk))
+		return PTR_ERR(st->clk);
+
+	indio_dev->name = chip_info->name;
+	indio_dev->channels = &ada4355_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ada4355_iio_info;
+	st->chan = &ada4355_channel;
+
+	ret = ada4355_setup(st, chip_info);
+	if (ret)
+		return ret;
+
+	ada4355_fill_scale_tb(st, chip_info);
+
+	ret = ada4355_gain_setup(st);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get IIO backend\n");
+
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
+		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ENABLE)) {
+		ret = devm_iio_backend_enable(dev, st->back);
+		if (ret)
+			return ret;
+	}
+
+	ret = ada4355_interface_setup(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to setup the digital interface\n");
+
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+		ret = ada4355_calibrate(st);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ada4355_id[] = {
+	{ .name = "ada4355", .driver_data = (kernel_ulong_t)&ada4355_chip_info },
+	{ .name = "ada4356", .driver_data = (kernel_ulong_t)&ada4356_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ada4355_id);
+
+static const struct of_device_id ada4355_of_match[] = {
+	{ .compatible = "adi,ada4355", .data = &ada4355_chip_info },
+	{ .compatible = "adi,ada4356", .data = &ada4356_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ada4355_of_match);
+
+static struct spi_driver ada4355_driver = {
+	.driver = {
+		.name = "ada4355",
+		.of_match_table = ada4355_of_match,
+	},
+	.probe = ada4355_probe,
+	.id_table = ada4355_id,
+};
+module_spi_driver(ada4355_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADA4355 device driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.39.2

