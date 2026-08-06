Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEE47D92F;
	Thu,  6 Aug 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030956; cv=none; b=F+a/fX97Cyr1iddIP8KQXyIX/3Q5n6vQcExHcVEuksRS/S7AJnvFcTmyLfb5pEei276qzEFCsk9g14hdZ92BBhOb9su1jxy2JsqrYIzJ5a+RuOaJd2MyIrDh4YIigNSobXT7YGv9VQ/b3giWrHf0dgMI2JeXHP2Kef3peBHXVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030956; c=relaxed/simple;
	bh=mGbENuMI/PxKQecwKN6ARiP5Ar+sPQHHFLNirZ/eLK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LeLK0jKEwDJEqsCpgK3IuUhR4U3+h3FAoD0lYAjiWtmq02Fc+IQ/tuTfhZbfUqPlrie3yiErPvVw4Y0FQQ5isDlZCUD/8pgbE2GDgyzc33WyQ1GB9hEuy7Xpv7uvZ3BB1pH8ohgt6HSxxq8xDWvw0HXTpclRewfc5dqECHA6r40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wbJUDVAI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wbJUDVAI"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Eq9FX3855388;
	Thu, 6 Aug 2026 11:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pVWno
	gmxDq4jK19HbLzIjd+vnJqaBf/7DCRm7/Z2ckc=; b=wbJUDVAIjEJh+hyqe+aaW
	KwSdhtUKgudqcZK1j8vJ2sd7WOqPSJKKDknKs07Qvexxx2S6ePsgwXBVjBti9VtQ
	A+x5JYDe6s3NwrdfUNN5zUH55KFA6hmdmZExsRGi+VZ8a9QQdMmy2Z2xdiWbTP74
	07mKBlz+CnF7cFXpbKsDdbrDGITQM4WF9xGJN5D35Ap60lBHvsPp7W1ETY/vdasd
	UmyTr0SY9FCd+vuazCgBscPYaX1Cl/mTSDxq+nPFTk2OzFk3gnc2IjjZVI7eRxZU
	YTxnOmZjyuJ2Jsi3W3iF4rAG0hA/3TwAJaSFSN7fxtXhipfK2yuyn1GDF+Is0URZ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpsf75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676FgGEj007047
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:15 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676Ffcgb008127;
	Thu, 6 Aug 2026 11:42:07 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:23 +0200
Subject: [PATCH v2 4/7] iio: adc: Add AD7768 IIO Driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260806-ad7768-driver-v2-4-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=50010;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=mGbENuMI/PxKQecwKN6ARiP5Ar+sPQHHFLNirZ/eLK0=;
 b=MKUuliqGiBeh3CQ4Pe4JDHZZoL2141e2TBbrv6kj3PFlRAAInigolAkIPB+/PXGp9MvnFku33
 0uOFmo6pZG3Co3Muz2J8E5R/uX+3d1vZpQHxWqa5TzJb8tGG6JOKO/V
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mkf6sINqUIjbOIdirPy5iFTbhhktFSYf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX3Cj+J+kGHnYy
 UUrqYeMuhW3aeQS9xQuYyy005p5wQTVgQ5JVDGjTqsM1pikcwW1X7SZuAV+uhMWeeKpjj7LOpsl
 FEsk3m9DrcYeCzp7sKlas/s4PWlfQyoR0Rk4XD96kGgJNjZYVfzV
X-Proofpoint-ORIG-GUID: mkf6sINqUIjbOIdirPy5iFTbhhktFSYf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX2BuT1NAxbZRT
 xXpg4+mYOM4e6KtaSiNzUarPj+HNJoJn7nwXrJttW+WCQ/05o2TIv7ynBct6em+7fiH84l7sykP
 71FHndF/ONQXh1B3ALvjOfIYpt87kGmslwzp2PNR0Z9hDQ6TJDav+Uo1xsjPA7kuxxrW75I6VC0
 /UuYZqpSb5qxuhUjdHBqTJUHbOpaHQe5A8LQxzJwTiqmYLpJd/kVSRvXOfzhbVNel5/+5z7nmwD
 aDQ4UovqKloBcWQj9Q56P9XUVjdQvO0FnNXVq0Z8Na8CqlCnIYrRrJSTOb9k/kkm3Q0xEaQbvfh
 yROOQbAtI7lqdJz23U6J9SFlY1pWCOVAsRnv8g4HK0IbsQzthHGJn2Ooe+95MkfZqNUoW17QWcX
 yerHsrP0uzUtgBLIpOAZeM4zD2gUSC1WwyM0fiPM+NC1422VqnVkDKonA95A+3YOg2b+MDX2qC1
 RLvRo3u12Fe8VlLmPCA==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a74ab59 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=_WSb5ZJg9_xE67b7vncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060121

Add support for AD7768 4/8 channel,simultaneous sampling Sigma-Delta
ADCs. The driver supports configurable decimation filters, per-channel
conversion delay, VCM regulation, runtime PM and IIO backend data
capture.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   16 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad7768.c | 1720 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1738 insertions(+)

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
index d1b198cb8a80..1325cdbedea4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -429,6 +429,22 @@ config AD7766
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
index 000000000000..1bba066435e3
--- /dev/null
+++ b/drivers/iio/adc/ad7768.c
@@ -0,0 +1,1720 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7768 ADC driver
+ *
+ * Copyright 2018-2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
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
+#define AD7768_REG_DIAGNOSTIC_MUX_CTRL		0x57
+#define AD7768_REG_MODULATOR_DELAY_CTRL		0x58
+#define AD7768_REG_CHOP_CTRL			0x59
+
+/* AD7768_REG_CH_MODE */
+#define   AD7768_CH_MODE_FILTER_TYPE_MSK	BIT(3)
+#define   AD7768_CH_MODE_FILTER_TYPE_MODE(x)	(((x) & 0x1) << 3)
+#define   AD7768_CH_MODE_DEC_RATE_MSK		GENMASK(2, 0)
+#define   AD7768_CH_MODE_DEC_RATE_MODE(x)	(((x) & 0x7) << 0)
+
+/* AD7768_REG_CH_MODE_SEL */
+#define   AD7768_CH_MODE_READ_MSK		GENMASK(7, 0)
+#define   AD7768_CH_MODE_READ_MODE(x)		((x) & 0xFF)
+#define   AD7768_CH_MODE_READ_GET(x)		((x) & 0xFF)
+#define   AD7768_CH_MODE_READ_CHN(n)		BIT(n)
+#define   AD7768_GET_CH_MODE_8CH(ch, x)		(!!((x) & BIT(ch)))
+
+/* AD7768_REG_POWER_MODE */
+#define   AD7768_SLEEP_MODE_MSK			BIT(7)
+#define   AD7768_POWER_MODE_POWER_MODE_MSK	GENMASK(5, 4)
+#define   AD7768_POWER_MODE_POWER_MODE(x)	(((x) & 0x3) << 4)
+#define   AD7768_POWER_MODE_MCLK_DIV_MSK	GENMASK(1, 0)
+
+/* AD7768_REG_DATA_CONTROL */
+#define   AD7768_DATA_CONTROL_SPI_RESET_MSK	GENMASK(1, 0)
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
+#define   AD7768_GEN_CONFIG_VCM_SEL_MSK		GENMASK(1, 0)
+#define   AD7768_GEN_CONFIG_VCM_PD		BIT(4)
+
+/* AD7768_REG_PRECHARGE_BUF1 and 2*/
+#define   AD7768_PREBUF_POS_EN(ch)	BIT((ch) * 2)
+#define   AD7768_PREBUF_NEG_EN(ch)	BIT(((ch) * 2) + 1)
+
+#define   AD7768_SPI_READ_CMD			BIT(15)
+#define   AD7768_SPI_REG_MASK			GENMASK(14, 8)
+#define   AD7768_SPI_DATA_MASK			GENMASK(7, 0)
+#define   AD7768_OUTPUT_MODE_TWOS_COMPLEMENT	0x01
+#define   AD7768_SAMPLE_SIZE				32
+#define   AD7768_PICO_PER_SEC			1000000000000ULL
+#define   MAX_FREQ_PER_MODE			6
+#define   AD7768_MAX_CHANNEL  8
+#define   AD7768_NUM_CHANNEL_MODES		2
+#define   AD7768_CALIB_REG_MSB_MSK		GENMASK(23, 16)
+#define   AD7768_CALIB_REG_MID_MSK		GENMASK(15, 8)
+#define   AD7768_CALIB_REG_LSB_MSK		GENMASK(7, 0)
+#define   AD7768_CALIB_REG_MSK			GENMASK(23, 0)
+#define   AD7768_REV_ID_VAL			0x06
+#define   AD7768_WIDEBAND_SETTLING_SAMPLES	68
+#define   AD7768_SINC5_SETTLING_SAMPLES		7
+
+enum ad7768_filter_type {
+	AD7768_FILTER_TYPE_WIDEBAND,
+	AD7768_FILTER_TYPE_SINC5,
+};
+
+enum ad7768_power_modes {
+	AD7768_LOW_POWER_MODE,
+	AD7768_MEDIAN_MODE,
+	AD7768_FAST_MODE,
+	AD7768_NUM_POWER_MODES
+};
+
+#define AD7768_MAX_FREQS	(MAX_FREQ_PER_MODE + AD7768_NUM_POWER_MODES)
+
+struct ad7768_precharge_config {
+	bool prebufp_en;
+	bool prebufn_en;
+	bool refbufp;
+	bool refbufn;
+};
+
+struct ad7768_freq_config {
+	unsigned int freq;
+	unsigned int dec_rate;
+};
+
+struct ad7768_convdelay_params {
+	unsigned int shift;
+	unsigned int max_raw;
+	u64 step_ps;
+};
+
+struct ad7768_avail_freq {
+	unsigned int n_freqs;
+	int freqs[MAX_FREQ_PER_MODE];
+	struct ad7768_freq_config freq_cfg[MAX_FREQ_PER_MODE];
+};
+
+struct ad7768_chip_info {
+	const char *name;
+	unsigned int num_channels;
+	const struct iio_chan_spec channel[AD7768_MAX_CHANNEL];
+	const struct regmap_config *regmap_config;
+	const unsigned int *available_datalines;
+	unsigned int num_datalines;
+	const u8 *chan_map;
+	u8 prebuf_split;
+};
+
+struct ad7768_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct mutex lock; /* Protects device register access and configuration */
+	struct clk *mclk;
+	unsigned int datalines;
+	enum ad7768_power_modes power_mode;
+	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[AD7768_NUM_POWER_MODES];
+	unsigned int n_freqs;
+	int freqs[AD7768_MAX_FREQS];
+	unsigned int chn_mode[AD7768_MAX_CHANNEL];
+	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
+	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
+	struct iio_backend *back;
+	struct regulator_dev *vcm_rdev;
+	unsigned int avdd1_uv;
+
+	__be16 d16 __aligned(IIO_DMA_MINALIGN);
+};
+
+static const unsigned int ad7768_vcm_voltage_table[] = {
+	0, 1650000, 2500000, 2140000
+};
+
+static int ad7768_vcm_list_voltage(struct regulator_dev *rdev,
+				   unsigned int selector)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+
+	if (selector >= ARRAY_SIZE(ad7768_vcm_voltage_table))
+		return -EINVAL;
+
+	if (!selector)
+		return DIV_ROUND_CLOSEST(st->avdd1_uv, 2);
+
+	return ad7768_vcm_voltage_table[selector];
+}
+
+static int ad7768_vcm_enable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+				AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static int ad7768_vcm_disable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+			      AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		return ret;
+
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return 0;
+}
+
+static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GENERAL_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	return !(val & AD7768_GEN_CONFIG_VCM_PD);
+}
+
+static int ad7768_vcm_set_voltage_sel(struct regulator_dev *rdev,
+				      unsigned int selector)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+				  AD7768_GEN_CONFIG_VCM_SEL_MSK, selector);
+}
+
+static int ad7768_vcm_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GENERAL_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD7768_GEN_CONFIG_VCM_SEL_MSK, val);
+}
+
+static const struct regulator_ops ad7768_vcm_ops = {
+	.enable = ad7768_vcm_enable,
+	.disable = ad7768_vcm_disable,
+	.is_enabled = ad7768_vcm_is_enabled,
+	.list_voltage = ad7768_vcm_list_voltage,
+	.set_voltage_sel = ad7768_vcm_set_voltage_sel,
+	.get_voltage_sel = ad7768_vcm_get_voltage_sel,
+};
+
+static const struct regulator_desc ad7768_vcm_desc = {
+	.name = "vcm",
+	.of_match = of_match_ptr("vcm-output"),
+	.n_voltages = ARRAY_SIZE(ad7768_vcm_voltage_table),
+	.ops = &ad7768_vcm_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ad7768_register_vcm_regulator(struct device *dev,
+					 struct ad7768_state *st)
+{
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = st,
+	};
+	int ret;
+
+	/*
+	 * Start with VCM disabled so each enabled state is paired with the
+	 * runtime PM reference acquired by ad7768_vcm_enable().
+	 */
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+			      AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		return ret;
+
+	st->vcm_rdev = devm_regulator_register(dev, &ad7768_vcm_desc, &config);
+	return PTR_ERR_OR_ZERO(st->vcm_rdev);
+}
+
+static const int ad7768_dec_rate[MAX_FREQ_PER_MODE] = {
+	32, 64, 128, 256, 512, 1024
+};
+
+static const int ad7768_mclk_div[3] = {
+	32, 8, 4
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
+static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode);
+
+static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
+{
+	return BIT(st->chip_info->chan_map[ch]);
+}
+
+static u8 ad7768_all_channels_mask(const struct ad7768_state *st)
+{
+	u8 mask = 0;
+	unsigned int ch;
+
+	for (ch = 0; ch < st->chip_info->num_channels; ch++)
+		mask |= ad7768_channel_mask(st, ch);
+
+	return mask;
+}
+
+static unsigned int ad7768_offset_reg(const struct ad7768_state *st,
+				      unsigned int ch)
+{
+	return AD7768_REG_OFFSET(st->chip_info->chan_map[ch]);
+}
+
+static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
+				    unsigned int ch)
+{
+	return AD7768_REG_GAIN(st->chip_info->chan_map[ch]);
+}
+
+static unsigned int ad7768_phase_reg(const struct ad7768_state *st,
+				     unsigned int ch)
+{
+	return AD7768_REG_PHASE(st->chip_info->chan_map[ch]);
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
+	st->d16 = cpu_to_be16(AD7768_SPI_READ_CMD |
+			      FIELD_PREP(AD7768_SPI_REG_MASK, reg));
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret)
+		return ret;
+
+	*data_val = FIELD_GET(AD7768_SPI_DATA_MASK, be16_to_cpu(st->d16));
+
+	return ret;
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
+	.readable_reg = ad7768_readable_reg,
+};
+
+static const struct regmap_config ad7768_4_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD7768_REG_CHOP_CTRL,
+	.use_single_read = true,
+	.readable_reg = ad7768_4_readable_reg,
+};
+
+static unsigned int ad7768_get_calib_reg_base(struct ad7768_state *st,
+					      const struct iio_chan_spec *chan,
+					      bool is_gain)
+{
+	if (is_gain)
+		return ad7768_gain_reg(st, chan->address);
+
+	return ad7768_offset_reg(st, chan->address);
+}
+
+static int ad7768_read_calib_value(struct ad7768_state *st,
+				   unsigned int base_reg, unsigned int *val)
+{
+	u8 data[3];
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_bulk_read(st->regmap, base_reg, data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	*val = (data[0] << 16) | (data[1] << 8) | data[2];
+
+	return 0;
+}
+
+static int ad7768_write_calib_value(struct ad7768_state *st,
+				    unsigned int base_reg, unsigned int val)
+{
+	int ret;
+
+	if (val > AD7768_CALIB_REG_MSK)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_write(st->regmap, base_reg,
+			   FIELD_GET(AD7768_CALIB_REG_MSB_MSK, val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, base_reg + 1,
+			   FIELD_GET(AD7768_CALIB_REG_MID_MSK, val));
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, base_reg + 2,
+			    FIELD_GET(AD7768_CALIB_REG_LSB_MSK, val));
+}
+
+static int ad7768_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
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
+static int ad7768_set_clk_divs(struct ad7768_state *st,
+			       unsigned int freq)
+{
+	unsigned int mclk, dclk, dclk_div, i;
+	struct ad7768_freq_config f_cfg = {};
+	unsigned int chan_per_doutx;
+
+	mclk = clk_get_rate(st->mclk);
+
+	chan_per_doutx = st->chip_info->num_channels / st->datalines;
+	if (!chan_per_doutx)
+		return -EINVAL;
+
+	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg.freq)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode].n_freqs)
+		return -EINVAL;
+
+	dclk = f_cfg.freq * AD7768_SAMPLE_SIZE * chan_per_doutx;
+	if (dclk > mclk)
+		return -EINVAL;
+
+	/* Set dclk_div to the nearest power of 2 less than the original value */
+	dclk_div = DIV_ROUND_CLOSEST_ULL(mclk, dclk);
+	if (dclk_div > AD7768_MAX_DCLK_DIV)
+		dclk_div = AD7768_MAX_DCLK_DIV;
+	else if (dclk_div > 0 && hweight32(dclk_div) != 1)
+		dclk_div = 1 << (fls(dclk_div) - 1);
+
+	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MODE(dclk_div));
+}
+
+static bool ad7768_freq_supported(const struct ad7768_state *st,
+				  unsigned int mode, unsigned int freq)
+{
+	unsigned int i;
+
+	for (i = 0; i < st->avail_freq[mode].n_freqs; i++) {
+		if (freq == st->avail_freq[mode].freq_cfg[i].freq)
+			return true;
+	}
+
+	return false;
+}
+
+static bool ad7768_freq_supported_in_any_mode(const struct ad7768_state *st,
+					      unsigned int freq)
+{
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		if (ad7768_freq_supported(st, mode, freq))
+			return true;
+	}
+
+	return false;
+}
+
+static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
+					const unsigned long *scan_mask)
+{
+	unsigned int channel;
+	unsigned int mode;
+
+	/*
+	 * The output data rate ranges overlap between the power modes. At a
+	 * common ODR, the faster mode has lower noise, so prefer the fastest
+	 * mode that supports every enabled channel.
+	 */
+	for (mode = AD7768_NUM_POWER_MODES; mode-- > 0;) {
+		for (channel = 0; channel < st->chip_info->num_channels; channel++) {
+			if (test_bit(channel, scan_mask) &&
+			    !ad7768_freq_supported(st, mode, st->ch_freq[channel]))
+				break;
+		}
+
+		if (channel == st->chip_info->num_channels)
+			return ad7768_set_power_mode(st, mode);
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_set_mode_decimation(struct ad7768_state *st,
+				      unsigned int freq, unsigned int mode)
+{
+	struct ad7768_freq_config f_cfg = {};
+	unsigned int i;
+
+	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg.freq)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode].n_freqs)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+				  AD7768_CH_MODE_DEC_RATE_MSK,
+				  AD7768_CH_MODE_DEC_RATE_MODE(f_cfg.dec_rate));
+}
+
+static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
+				    unsigned int freq, unsigned int ch)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (!freq)
+		return -EINVAL;
+
+	if (!ad7768_freq_supported_in_any_mode(st, freq))
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	st->ch_freq[ch] = freq;
+
+	return 0;
+}
+
+static int ad7768_get_freq_cfg(struct ad7768_state *st, unsigned int freq,
+			       struct ad7768_freq_config *f_cfg)
+{
+	unsigned int i;
+
+	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		*f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg->freq)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void ad7768_filter_wait(const unsigned int *mode_freq,
+			       const enum ad7768_filter_type *mode_filter,
+			       const bool *mode_used)
+{
+	unsigned long t_settle_us = 0;
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		unsigned long t_mode_us;
+		unsigned int settling_samples;
+
+		if (!mode_used[mode] || !mode_freq[mode])
+			continue;
+
+		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
+			settling_samples = AD7768_SINC5_SETTLING_SAMPLES;
+		else
+			settling_samples = AD7768_WIDEBAND_SETTLING_SAMPLES;
+
+		t_mode_us = DIV_ROUND_UP_ULL((u64)settling_samples *
+					     USEC_PER_SEC,
+					     mode_freq[mode]);
+		t_settle_us = max(t_settle_us, t_mode_us);
+	}
+
+	if (t_settle_us)
+		fsleep(t_settle_us);
+}
+
+static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
+				       struct ad7768_convdelay_params *params)
+{
+	struct ad7768_freq_config f_cfg;
+	unsigned int dec_rate;
+	unsigned int mult;
+	u64 mclk;
+	int ret;
+
+	ret = ad7768_get_freq_cfg(st, st->ch_freq[ch], &f_cfg);
+	if (ret)
+		return ret;
+
+	dec_rate = ad7768_dec_rate[f_cfg.dec_rate];
+	switch (dec_rate) {
+	case 32:
+		params->shift = 3;
+		params->max_raw = 31;
+		mult = 1;
+		break;
+	case 64:
+		params->shift = 2;
+		params->max_raw = 63;
+		mult = 1;
+		break;
+	case 128:
+		params->shift = 1;
+		params->max_raw = 127;
+		mult = 1;
+		break;
+	case 256:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 1;
+		break;
+	case 512:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 2;
+		break;
+	case 1024:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mclk = clk_get_rate(st->mclk);
+	if (!mclk)
+		return -EINVAL;
+
+	params->step_ps = DIV_ROUND_CLOSEST_ULL((u64)mult *
+						AD7768_PICO_PER_SEC *
+						ad7768_mclk_div[st->power_mode],
+						mclk);
+
+	return 0;
+}
+
+static int ad7768_set_channel_convdelay(struct ad7768_state *st,
+					unsigned int ch)
+{
+	struct ad7768_convdelay_params params;
+	u64 delay_ps = st->ch_convdelay_ps[ch];
+	u64 max_delay_ps;
+	u64 raw;
+	int ret;
+
+	ret = ad7768_get_convdelay_params(st, ch, &params);
+	if (ret)
+		return ret;
+
+	max_delay_ps = (u64)params.max_raw * params.step_ps;
+	if (delay_ps > max_delay_ps)
+		return -EINVAL;
+
+	raw = DIV_ROUND_CLOSEST_ULL(delay_ps, params.step_ps);
+	if (raw > params.max_raw)
+		return -EINVAL;
+
+	return regmap_write(st->regmap, ad7768_phase_reg(st, ch),
+			    raw << params.shift);
+}
+
+static int ad7768_find_matching_mode(const bool *mode_used,
+				     const unsigned int *mode_freq,
+				     const enum ad7768_filter_type *mode_filter,
+				     unsigned int freq,
+				     enum ad7768_filter_type filter)
+{
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode] ||
+		    (mode_freq[mode] == freq && mode_filter[mode] == filter))
+			return mode;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES];
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES];
+	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
+	unsigned int channel_mask;
+	unsigned int standby_mask;
+	unsigned int max_freq = 0;
+	unsigned int c;
+	int mode, ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = ad7768_set_lowest_noise_mode(st, scan_mask);
+	if (ret == -EINVAL)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "No power mode supports all enabled channel frequencies\n");
+	if (ret)
+		return ret;
+
+	channel_mask = ad7768_all_channels_mask(st);
+	standby_mask = channel_mask;
+
+	for (c = 0; c < st->chip_info->num_channels; c++) {
+		unsigned int mask;
+
+		if (!test_bit(c, scan_mask))
+			continue;
+
+		standby_mask &= ~ad7768_channel_mask(st, c);
+
+		mode = ad7768_find_matching_mode(mode_used, mode_freq,
+						 mode_filter, st->ch_freq[c],
+						 st->ch_filter[c]);
+		if (mode < 0)
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+				"Enabled channels require more than %d mode profiles\n",
+				AD7768_NUM_CHANNEL_MODES);
+
+		mode_freq[mode] = st->ch_freq[c];
+		mode_filter[mode] = st->ch_filter[c];
+		mode_used[mode] = true;
+		st->chn_mode[c] = mode;
+
+		mask = ad7768_channel_mask(st, c);
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
+					 mask, mode ? mask : 0);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
+				 channel_mask, standby_mask);
+	if (ret)
+		return ret;
+
+	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode])
+			continue;
+
+		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 AD7768_CH_MODE_FILTER_TYPE_MODE(mode_filter[mode]));
+		if (ret)
+			return ret;
+
+		max_freq = max(max_freq, mode_freq[mode]);
+	}
+
+	for (c = 0; c < st->chip_info->num_channels; c++) {
+		if (!test_bit(c, scan_mask))
+			continue;
+
+		ret = ad7768_set_channel_convdelay(st, c);
+		if (ret == -EINVAL)
+			return dev_err_probe(&st->spi->dev, ret,
+					     "Invalid conversion delay for channel %u\n",
+					     c);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad7768_set_clk_divs(st, max_freq);
+	if (ret)
+		return ret;
+
+	ret = ad7768_sync(st);
+	if (ret)
+		return ret;
+
+	/* Apply a filter settling time (Datasheet table 35 and 36) */
+	ad7768_filter_wait(mode_freq, mode_filter, mode_used);
+
+	return 0;
+}
+
+static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode)
+{
+	unsigned int regval;
+	int ret;
+
+	if (mode >= AD7768_NUM_POWER_MODES)
+		return -EINVAL;
+
+	regval = ad7768_map_power_mode_to_regval(mode);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_POWER_MODE_MSK,
+				 AD7768_POWER_MODE_POWER_MODE(regval));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK, regval));
+	if (ret)
+		return ret;
+
+	ret = ad7768_sync(st);
+	if (ret)
+		return ret;
+
+	st->power_mode = mode;
+
+	return 0;
+}
+
+static int ad7768_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
+	unsigned int calib;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
+		*val = st->ch_freq[chan->channel];
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		base_reg = ad7768_get_calib_reg_base(st, chan, false);
+		ret = ad7768_read_calib_value(st, base_reg, &calib);
+		if (ret)
+			return ret;
+
+		*val = calib;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		base_reg = ad7768_get_calib_reg_base(st, chan, true);
+		ret = ad7768_read_calib_value(st, base_reg, &calib);
+		if (ret)
+			return ret;
+
+		*val = calib;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_CONVDELAY: {
+		guard(mutex)(&st->lock);
+		iio_val_s64_decompose(st->ch_convdelay_ps[chan->channel],
+				      val, val2);
+
+		return IIO_VAL_DECIMAL64_PICO;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7768_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	s64 delay_ps;
+	unsigned int base_reg;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < 0 || val > AD7768_CALIB_REG_MSK)
+			return -EINVAL;
+
+		base_reg = ad7768_get_calib_reg_base(st, chan, false);
+		return ad7768_write_calib_value(st, base_reg, val);
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val < 0 || val > AD7768_CALIB_REG_MSK)
+			return -EINVAL;
+
+		base_reg = ad7768_get_calib_reg_base(st, chan, true);
+		return ad7768_write_calib_value(st, base_reg, val);
+
+	case IIO_CHAN_INFO_CONVDELAY: {
+		delay_ps = iio_val_s64_compose(val, val2);
+		if (delay_ps < 0)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		st->ch_convdelay_ps[chan->channel] = delay_ps;
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7768_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (info != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	*vals = st->freqs;
+	*type = IIO_VAL_INT;
+	*length = st->n_freqs;
+
+	return IIO_AVAIL_LIST;
+}
+
+static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	ret = ad7768_apply_channel_modes(indio_dev, scan_mask);
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
+	return pm_runtime_resume_and_get(&st->spi->dev);
+}
+
+static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(&st->spi->dev);
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
+	.read_raw = ad7768_read_raw,
+	.write_raw_get_fmt = ad7768_write_raw_get_fmt,
+	.write_raw = ad7768_write_raw,
+	.read_avail = ad7768_read_avail,
+	.update_scan_mode = ad7768_update_scan_mode,
+};
+
+static void ad7768_set_available_sampl_freq(struct ad7768_state *st)
+{
+	struct ad7768_avail_freq *avail_freq;
+	unsigned int mclk = clk_get_rate(st->mclk);
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		avail_freq = &st->avail_freq[mode];
+		for (unsigned int dec = ARRAY_SIZE(ad7768_dec_rate); dec > 0; dec--) {
+			struct ad7768_freq_config freq_cfg;
+
+			freq_cfg.dec_rate = dec - 1;
+			freq_cfg.freq = mclk / (ad7768_dec_rate[dec - 1] *
+					ad7768_mclk_div[mode]);
+			avail_freq->freqs[avail_freq->n_freqs] = freq_cfg.freq;
+			avail_freq->freq_cfg[avail_freq->n_freqs++] = freq_cfg;
+		}
+	}
+
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[AD7768_FAST_MODE].n_freqs--;
+
+	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		avail_freq = &st->avail_freq[mode];
+		for (unsigned int i = 0; i < avail_freq->n_freqs; i++) {
+			unsigned int freq = avail_freq->freqs[i];
+
+			if (st->n_freqs && st->freqs[st->n_freqs - 1] >= freq)
+				continue;
+
+			st->freqs[st->n_freqs++] = freq;
+		}
+	}
+}
+
+static int ad7768_gpio_adev_init(struct ad7768_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct auxiliary_device *adev;
+	int id;
+
+	if (!device_property_read_bool(dev, "gpio-controller"))
+		return 0;
+
+	/* Use the SPI bus number and chip select to derive a stable per-device ID. */
+	id = (st->spi->controller->bus_num << 8) | spi_get_chipselect(st->spi, 0);
+	adev = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, "gpio",
+					      NULL, id);
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to create GPIO auxiliary device\n");
+
+	return 0;
+}
+
+static int ad7768_set_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int mode)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	st->ch_filter[chan->channel] = mode;
+	return 0;
+}
+
+static int ad7768_get_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	return st->ch_filter[chan->channel];
+}
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
+static const char *const ad7768_filter_types[] = {
+	[AD7768_FILTER_TYPE_WIDEBAND] = "wideband",
+	[AD7768_FILTER_TYPE_SINC5] = "sinc5",
+};
+
+static const struct iio_enum ad7768_filter_types_enum = {
+	.items = ad7768_filter_types,
+	.num_items = ARRAY_SIZE(ad7768_filter_types),
+	.set = ad7768_set_filter_mode,
+	.get = ad7768_get_filter_mode,
+};
+
+static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE,
+		 &ad7768_filter_types_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
+	{}
+};
+
+static int ad7768_parse_config(struct iio_dev *indio_dev,
+			       struct device *dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct ad7768_avail_freq *avail_freq;
+	const unsigned int *available_datalines;
+	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
+	struct iio_chan_spec *chan;
+	unsigned int num_channels;
+	unsigned int channel;
+	unsigned int i, len;
+	unsigned int default_freq;
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
+			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
+					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_separate_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.indexed = 1,
+			.address = channel,
+			.channel = channel,
+			.scan_index = channel,
+			.scan_type = {
+				.sign = 's',
+				.realbits = 24,
+				.storagebits = 32,
+			},
+			.ext_info = ad7768_ext_info,
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
+	ad7768_set_available_sampl_freq(st);
+
+	/* Start in fast mode; capture setup may select another compatible mode. */
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7768_set_power_mode(st, AD7768_FAST_MODE);
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	avail_freq = &st->avail_freq[AD7768_FAST_MODE];
+	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq;
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		st->ch_freq[i] = default_freq;
+		st->ch_filter[i] = AD7768_FILTER_TYPE_WIDEBAND;
+	}
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
+	return 0;
+}
+
+static int ad7768_reset(struct ad7768_state *st)
+{
+	struct reset_control *reset_ctrl;
+	unsigned long reset_low_us;
+	unsigned long mclk;
+	int ret;
+
+	reset_ctrl = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
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
+	st->spi = spi;
+	spi_set_drvdata(spi, st);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->chip_info = spi_get_device_match_data(spi);
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd1");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable AVDD1 supply\n");
+
+	st->avdd1_uv = ret;
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
+	ret = regmap_attach_dev(dev, st->regmap, st->chip_info->regmap_config);
+	if (ret)
+		return ret;
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
+	ret = ad7768_register_vcm_regulator(dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register VCM regulator\n");
+
+	indio_dev->setup_ops = &ad7768_buffer_ops;
+
+	ret = ad7768_gpio_adev_init(st);
+	if (ret)
+		return ret;
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

