Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0324E4C6;
	Thu, 15 Oct 2026 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027356; cv=none; b=FIIZCWjDnISzwIcwG++kr8qhDZktcRWRaYSs9oKzmEddTOFp0R1tO3sl6KAX7aPoSArFvYdDA/HHNk+48oRvJ8MDVmQknPID5zKXilV3jJs+S0ldr0+W4xqJJWEg8fFearrN/9lmVdwznRfOOdhUE05Hojz89Rb9rJwWt3opSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027356; c=relaxed/simple;
	bh=YunwE3f8xf2hGtbbY4OEN0TIMt8an1n3sJSAQtGzYIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT77zOSXqxR3DaI2dMBCoDHREizsuCFHhSNUX1L/TmA5FJKpsOPcOVHtqT01veEA7QrneRyCGkYCKwooxxOz7OHld/QQiYMQzQ2bsF1tOse+ZvowYuUcnfZ0Nn5WexIjgiws4WNMTKwuXuyzu5YDKeZB3O1Aw09xWKNcC2R+TLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=rwiiu5QB; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nXqzmVWv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="rwiiu5QB";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nXqzmVWv"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ELnsFQ3558659;
	Wed, 14 Oct 2026 21:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gaQ+Yj/0F+1ICn4bHD/21WYUpgVECAwjhejLaMSCFFE=; b=rwiiu5Q
	BX4Ql7PmjHg2Kd4ZeTd3DBtcjrY0S3T3gAxgXR5eliotEv46KpqvoKqSL3l5kKZN
	hiWAWU5qo3yq43F0J4LEcfoHqTcxBWqCBhDDLwh9vCDOsnGc48jj0x0Jq7WOkPWy
	jiSnzLHQLF1wZZgKSF9Ut9Xmh1JpxVonQTbkSU+Qrx56QwwiRCQf3max997tV8JP
	qx13istSnatiXpVd76D/W2L4QsovTnjQKY+hEwx263Igxsf26x8l/7enOnw6cPx4
	nNsTqfKkn5vJ/rUVjV8bkdeFB/+lWCHZTaByr1HMcHS9aqypv+NRlIo465NPCnzZ
	sixekWbi0T8QEKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gaQ+Y
	j/0F+1ICn4bHD/21WYUpgVECAwjhejLaMSCFFE=; b=nXqzmVWvWDN0+51vio8+Q
	kNAms9cIotvme6bfeUjLEvaZNMv8Bx4ot/4Wn14ChP8UnmADah5GFWh1eBsecNsQ
	2/8RMz6e85ubOS++STgDcVDtBQAkDCBiJBhEt3wuP5QoHlz8/lhNzuXyzgV7fIHq
	pY1UeEclY7TviBjfH3tTNVjDY4liV3ibPeGVwc3JxxnlH6uxDegOPYadkgp3+yzd
	Ia/LT1CNhYQDAJaAwEHy8yITtUG9AlKHz/Rbm6WS0s5wwbM8FNuD/TfCf+kh5CPx
	p6V8SWnmm68S8gmE8J+e2cM1RpETaOVFZPApJ53U1ZClHAsG38kIe5Pb/Crp/IA9
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnsfqsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 21:22:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69F1MTgF029733
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 21:22:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Oct
 2026 21:22:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Oct 2026 21:22:28 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69F1M7jB003376;
	Wed, 14 Oct 2026 21:22:20 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v4 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Thu, 15 Oct 2026 09:21:59 +0800
Message-ID: <20261015012159.44-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1VMc2aU24e-_jYBcYBcOap_K2Qonq_EQ
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6ad02ad6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=3YitoCh-1JhfrazHmIcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNSBTYWx0ZWRfXz6lUC4sXvhWz
 0kulAwnPoLyixBH0QDpgdWbdhLEo9XCk3nqRDyodCpcrcnSqlCxlQM7clO+Jh1bMG36tAQGUkb0
 6TKo7GHmtJh5dH8dAWV6EJwVCoxV5lI6u+hUw1Q6re32psicQq6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNSBTYWx0ZWRfXztDOzpa5JLP9
 wXqoylxg+vtBmSJ0YC7g7aJXSs101Phn9XkjyxdB336r5q1+AU4mmWO/CKBNsGoLmc+yeBqpCY+
 kqX62lhv5VeZTiWWHNjHIXRJaep5/Z+2d5hdseR/Vr2uU1hgotZBW77yOn2NfKxKsn7zcAW/9p/
 B+JCvqDV8hdjlwVxzZ6RQHqj5RXMUBgmzM3ltFGw8Zxobnvwoc7s2bXaEI+fa15TffXMbE/SKA6
 l3tE74zPOuKdIEtR8EXQKuXknI3aLlwalTgW/MWhYG424JSy1YaXkDhVnZIZs4viuJNn7sbm77N
 jhPZHGNVN4Xp6j2JqjYnoY4SRSA5kFJHCVnonwJmfEgKNLGfkiVxtd2u5iEXk/16WP/13CEr+PY
 G+E6rzJU070fjPWoFHNNSmreQBzK6CyEmCIdXn8Zn7s3hNb79a2e/KJc0thvXIbVt4L2pF24Dcq
 OR5zawJMMkG0vHXZSPg==
X-Proofpoint-ORIG-GUID: 1VMc2aU24e-_jYBcYBcOap_K2Qonq_EQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150005

Add support for the Analog Devices MAX30210 I2C temperature
sensor.

The driver uses regmap for register access and integrates with
the IIO framework. It supports:

- Direct mode temperature conversion
- Configurable sampling frequency
- Threshold events
- FIFO operation with IIO kfifo buffer support
- Optional interrupt-driven data ready signaling

The device provides 16-bit signed temperature data and a
64-sample FIFO.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                        |   1 +
 drivers/iio/temperature/Kconfig    |  13 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30210.c | 788 +++++++++++++++++++++++++++++
 4 files changed, 803 insertions(+)
 create mode 100644 drivers/iio/temperature/max30210.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eb3cf66f431c..e479c64a284e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1659,6 +1659,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
+F:	drivers/iio/temperature/max30210.c
 
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 9328b2250aced..05b3af6872b31 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -152,6 +152,19 @@ config MAX30208
 	  This driver can also be built as a module. If so, the module
 	  will be called max30208.
 
+config MAX30210
+	tristate "Analog Devices MAX30210 temperature sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	help
+	  If you say yes here you get support for MAX30210 low-power digital
+	  temperature sensor chip connected via I2C.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max30210.
+
 config MAX31856
 	tristate "MAX31856 thermocouple sensor"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7f..e5aad14dc09b9 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MAX30208) += max30208.o
+obj-$(CONFIG_MAX30210) += max30210.o
 obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MCP9600) += mcp9600.o
diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature/max30210.c
new file mode 100644
index 0000000000000..04123d51c6da4
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices MAX30210 I2C Temperature Sensor driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#define MAX30210_STATUS_REG			0x00
+#define   MAX30210_STATUS_A_FULL_MASK		BIT(7)
+#define   MAX30210_STATUS_TEMP_RDY_MASK	BIT(6)
+#define   MAX30210_STATUS_TEMP_DEC_MASK	BIT(5)
+#define   MAX30210_STATUS_TEMP_INC_MASK	BIT(4)
+#define   MAX30210_STATUS_TEMP_LO_MASK		BIT(3)
+#define   MAX30210_STATUS_TEMP_HI_MASK		BIT(2)
+#define   MAX30210_STATUS_PWR_RDY		BIT(0)
+#define MAX30210_INT_EN_REG			0x02
+#define MAX30210_FIFO_DATA_REG			0x08
+#define MAX30210_FIFO_CONF_1_REG		0x09
+#define   MAX30210_FIFOCONF1_A_FULL_MASK	GENMASK(5, 0)
+#define MAX30210_FIFO_CONF_2_REG		0x0A
+#define   MAX30210_FIFOCONF2_FLUSH_FIFO		BIT(4)
+#define MAX30210_SYS_CONF_REG			0x11
+#define   MAX30210_SYSCONF_RESET		BIT(0)
+#define MAX30210_PIN_CONF_REG			0x12
+#define   MAX30210_PINCONF_EXT_CNV_EN		BIT(7)
+#define   MAX30210_PINCONF_EXT_CVT_ICFG		BIT(6)
+#define   MAX30210_PINCONF_INT_FCFG_MASK	GENMASK(3, 2)
+#define   MAX30210_PINCONF_INT_OCFG_MASK	GENMASK(1, 0)
+#define MAX30210_TEMP_ALM_HI_REG		0x22
+#define MAX30210_TEMP_ALM_LO_REG		0x24
+#define MAX30210_TEMP_INC_THRESH_REG		0x26
+#define MAX30210_TEMP_DEC_THRESH_REG		0x27
+#define MAX30210_TEMP_CONF_1_REG		0x28
+#define   MAX30210_TEMPCONF1_CHG_DET_EN		BIT(3)
+#define   MAX30210_TEMPCONF1_RATE_CHG_FILTER_MASK	GENMASK(2, 0)
+#define MAX30210_TEMP_CONF_2_REG		0x29
+#define   MAX30210_TEMPCONF2_TEMP_PERIOD_MASK	GENMASK(3, 0)
+#define   MAX30210_TEMPCONF2_ALERT_MODE		BIT(7)
+#define MAX30210_TEMP_CONV_REG			0x2A
+#define   MAX30210_TEMPCONV_CONV_T		BIT(0)
+#define   MAX30210_TEMPCONV_AUTO		BIT(1)
+#define MAX30210_TEMP_DATA_REG			0x2B
+#define MAX30210_TEMP_SLOPE_REG			0x2D
+#define MAX30210_UNIQUE_ID_REG			0x30
+#define MAX30210_PART_ID_REG			0xFF
+
+#define MAX30210_PART_ID			0x45
+#define MAX30210_FIFO_SIZE			64
+#define MAX30210_FIFO_BYTES_PER_SAMPLE		3
+#define MAX30210_FIFO_TEMP_MASK			GENMASK(15, 0)
+#define MAX30210_FIFO_INVAL_DATA		GENMASK(23, 0)
+#define MAX30210_WATERMARK_DEFAULT		(0x40 - 0x1F)
+
+#define MAX30210_UNIQUE_ID_LEN			6
+#define MAX30210_EXT_CVT_FREQ_MIN		1
+#define MAX30210_EXT_CVT_FREQ_MAX		20
+
+struct max30210_state {
+	struct regmap *regmap;
+	/* Raw FIFO byte buffer */
+	u8 fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * MAX30210_FIFO_SIZE];
+	/* Protects autoconv_users and the autonomous-conversion enable bit */
+	struct mutex lock;
+	unsigned int autoconv_users;
+	u8 watermark;
+};
+
+static const int max30210_samp_freq_avail[][2] = {
+	{ 0, 15625 },
+	{ 0, 31250 },
+	{ 0, 62500 },
+	{ 0, 125000 },
+	{ 0, 250000 },
+	{ 0, 500000 },
+	{ 1, 0 },
+	{ 2, 0 },
+	{ 4, 0 },
+	{ 8, 0 },
+};
+
+static bool max30210_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX30210_STATUS_REG:
+	case MAX30210_FIFO_DATA_REG:
+	case MAX30210_FIFO_CONF_2_REG:
+	case MAX30210_TEMP_CONV_REG:
+	/*
+	 * TEMP_DATA_REG is a 16-bit value spanning two byte registers;
+	 * both must be volatile or regmap_bulk_read()'s range check falls
+	 * back to caching the second byte forever (see max30210_read_temp()).
+	 */
+	case MAX30210_TEMP_DATA_REG:
+	case MAX30210_TEMP_DATA_REG + 1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config max30210_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX30210_PART_ID_REG,
+	.volatile_reg = max30210_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int max30210_read_temp(struct regmap *regmap, unsigned int reg,
+			      int *temp)
+{
+	__be16 val;
+	int ret;
+
+	ret = regmap_bulk_read(regmap, reg, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	*temp = sign_extend32(be16_to_cpu(val), 15);
+
+	return IIO_VAL_INT;
+}
+
+static int max30210_write_temp(struct regmap *regmap, unsigned int reg,
+			       int temp)
+{
+	__be16 val;
+
+	val = cpu_to_be16(temp);
+
+	return regmap_bulk_write(regmap, reg, &val, sizeof(val));
+}
+
+/* Keeps the device sampling autonomously while buffer and/or events need it. */
+static int max30210_autoconv_get(struct max30210_state *st)
+{
+	int ret = 0;
+
+	guard(mutex)(&st->lock);
+
+	if (st->autoconv_users == 0)
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+				   MAX30210_TEMPCONV_AUTO | MAX30210_TEMPCONV_CONV_T);
+	if (!ret)
+		st->autoconv_users++;
+
+	return ret;
+}
+
+static int max30210_autoconv_put(struct max30210_state *st)
+{
+	int ret = 0;
+
+	guard(mutex)(&st->lock);
+
+	if (st->autoconv_users == 1)
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0);
+	if (st->autoconv_users)
+		st->autoconv_users--;
+
+	return ret;
+}
+
+static void max30210_fifo_read(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * FIFO_DATA_REG auto-increments in hardware; bulk_read would treat
+	 * each subsequent byte as a separate cacheable register.
+	 */
+	ret = regmap_noinc_read(st->regmap, MAX30210_FIFO_DATA_REG,
+				st->fifo_buf,
+				MAX30210_FIFO_BYTES_PER_SAMPLE * st->watermark);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
+		return;
+	}
+
+	for (unsigned int i = 0; i < st->watermark; i++) {
+		u32 raw = get_unaligned_be24(&st->fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * i]);
+		s16 temp;
+
+		if (raw == MAX30210_FIFO_INVAL_DATA) {
+			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
+			continue;
+		}
+
+		temp = sign_extend32(FIELD_GET(MAX30210_FIFO_TEMP_MASK, raw), 15);
+
+		iio_push_to_buffers(indio_dev, &temp);
+	}
+}
+
+static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Status read failed\n");
+		return IRQ_NONE;
+	}
+
+	if (status & MAX30210_STATUS_A_FULL_MASK)
+		max30210_fifo_read(indio_dev);
+
+	if (status & MAX30210_STATUS_TEMP_HI_MASK)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+
+	if (status & MAX30210_STATUS_TEMP_LO_MASK)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static int max30210_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			       unsigned int writeval, unsigned int *readval)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int max30210_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int *val, int *val2)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int val, int val2)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val < S16_MIN || val > S16_MAX)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
+	if (ret)
+		return ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return FIELD_GET(MAX30210_STATUS_TEMP_LO_MASK, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir, bool state)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int mask;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		mask = MAX30210_STATUS_TEMP_HI_MASK;
+		break;
+	case IIO_EV_DIR_FALLING:
+		mask = MAX30210_STATUS_TEMP_LO_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Threshold events need the device sampling autonomously, independent
+	 * of whether the FIFO buffer is also enabled.
+	 */
+	if (state) {
+		ret = max30210_autoconv_get(st);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG, mask, state);
+	if (ret) {
+		if (state)
+			max30210_autoconv_put(st);
+		return ret;
+	}
+
+	return state ? 0 : max30210_autoconv_put(st);
+}
+
+static int max30210_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int uval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = 5;
+		*val2 = MILLI;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int period;
+
+		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
+		if (ret)
+			return ret;
+
+		period = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
+
+		/*
+		 * TEMP_PERIOD is an index into the sampling frequency lookup
+		 * table. Clamp in case the register holds a reserved value.
+		 */
+		if (period >= ARRAY_SIZE(max30210_samp_freq_avail))
+			period = ARRAY_SIZE(max30210_samp_freq_avail) - 1;
+
+		*val = max30210_samp_freq_avail[period][0];
+		*val2 = max30210_samp_freq_avail[period][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		guard(mutex)(&st->lock);
+
+		/*
+		 * TEMP_DATA_REG is only refreshed by a single-shot
+		 * conversion; the buffer/FIFO path is the only thing that
+		 * gets updated during AUTO mode. If AUTO is already running
+		 * for the buffer and/or events, triggering a one-off
+		 * conversion here would stomp the AUTO bit out from under
+		 * whoever enabled it, and there is no way to get a fresh
+		 * single-shot value without doing so -- refuse instead of
+		 * returning stale data.
+		 */
+		if (st->autoconv_users > 0)
+			return -EBUSY;
+
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+				   MAX30210_TEMPCONV_CONV_T);
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait until CONVERT_T auto-clears.
+		 * Datasheet:
+		 *   tBIAS_WU = 260 µs
+		 *   tINT     = 8 ms
+		 *
+		 * Worst-case conversion ≈ 8.26 ms.
+		 * Use 10 ms timeout for margin.
+		 */
+		ret = regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, uval,
+					       !(uval & MAX30210_TEMPCONV_CONV_T),
+					       500, 10 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = &max30210_samp_freq_avail[0][0];
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(max30210_samp_freq_avail) * 2;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (val < 0 || val2 < 0)
+			return -EINVAL;
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i++) {
+			if (val != max30210_samp_freq_avail[i][0] ||
+			    val2 != max30210_samp_freq_avail[i][1])
+				continue;
+
+			return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
+					MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
+					FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
+		}
+
+		return -EINVAL;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (val < 1 || val > MAX30210_FIFO_SIZE)
+		return -EINVAL;
+
+	/*
+	 * FIFO_A_FULL sets the number of empty FIFO slots remaining when the
+	 * A_FULL interrupt fires. For a watermark of N samples, set
+	 * FIFO_A_FULL = FIFO_SIZE - N.
+	 */
+	ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG,
+			   FIELD_PREP(MAX30210_FIFOCONF1_A_FULL_MASK,
+				      MAX30210_FIFO_SIZE - val));
+	if (ret)
+		return ret;
+
+	st->watermark = val;
+
+	return 0;
+}
+
+static ssize_t hwfifo_watermark_show(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
+{
+	struct max30210_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%d\n", st->watermark);
+}
+
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max, __stringify(MAX30210_FIFO_SIZE));
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
+
+static const struct iio_dev_attr *max30210_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	NULL
+};
+
+static int max30210_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/* Enable FIFO-full interrupt */
+	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG,
+			      MAX30210_STATUS_A_FULL_MASK);
+	if (ret)
+		return ret;
+
+	/* Flush FIFO before starting autonomous conversions */
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF2_FLUSH_FIFO);
+	if (ret)
+		return ret;
+
+	return max30210_autoconv_get(st);
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = max30210_autoconv_put(st);
+	if (ret)
+		return ret;
+
+	/* Flush FIFO */
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF2_FLUSH_FIFO);
+	if (ret)
+		return ret;
+
+	/* Disable FIFO-full interrupt */
+	return regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
+				 MAX30210_STATUS_A_FULL_MASK);
+}
+
+static const struct iio_buffer_setup_ops max30210_buffer_ops = {
+	.preenable = max30210_buffer_preenable,
+	.postdisable = max30210_buffer_postdisable,
+};
+
+static const struct iio_info max30210_info = {
+	.read_raw = max30210_read_raw,
+	.read_avail = max30210_read_avail,
+	.write_raw = max30210_write_raw,
+	.hwfifo_set_watermark = max30210_set_watermark,
+	.debugfs_reg_access = max30210_reg_access,
+	.read_event_value = max30210_read_event,
+	.write_event_value = max30210_write_event,
+	.write_event_config = max30210_write_event_config,
+	.read_event_config = max30210_read_event_config,
+};
+
+static const struct iio_event_spec max30210_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec max30210_channel = {
+	.type = IIO_TEMP,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_index = 0,
+	.event_spec = max30210_events,
+	.num_event_specs = ARRAY_SIZE(max30210_events),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+};
+
+static void max30210_powerdown(void *data)
+{
+	struct gpio_desc *powerdown_gpio = data;
+
+	gpiod_set_value(powerdown_gpio, 1);
+}
+
+static int max30210_setup(struct max30210_state *st, struct device *dev)
+{
+	struct gpio_desc *powerdown_gpio;
+	unsigned int val;
+	int ret;
+
+	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
+				     "failed to request powerdown GPIO\n");
+
+	if (powerdown_gpio) {
+		/* Deassert powerdown to power up device */
+		gpiod_set_value(powerdown_gpio, 0);
+
+		ret = devm_add_action_or_reset(dev, max30210_powerdown, powerdown_gpio);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_set_bits(st->regmap, MAX30210_SYS_CONF_REG,
+				      MAX30210_SYSCONF_RESET);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Datasheet Figure 6:
+	 * tPU max = 700 µs after power-up or reset before device is ready.
+	 */
+	fsleep(700);
+
+	/* Clear status byte */
+	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
+}
+
+static int max30210_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct max30210_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable vdd regulator.\n");
+
+	st->regmap = devm_regmap_init_i2c(client, &max30210_regmap);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to allocate regmap.\n");
+
+	st->watermark = MAX30210_WATERMARK_DEFAULT;
+
+	ret = max30210_setup(st, dev);
+	if (ret)
+		return ret;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &max30210_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->name = "max30210";
+	indio_dev->info = &max30210_info;
+
+	/* Without an interrupt there is no way to drain the FIFO into the buffer */
+	if (client->irq) {
+		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
+						      max30210_fifo_attributes);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	if (!client->irq)
+		return 0;
+
+	/*
+	 * Request the IRQ after registering the IIO device so devm tears it
+	 * down first on removal, before the event interface is freed.
+	 */
+	return devm_request_threaded_irq(dev, client->irq, NULL,
+					 max30210_irq_handler, IRQF_ONESHOT,
+					 indio_dev->name, indio_dev);
+}
+
+static const struct i2c_device_id max30210_id[] = {
+	{ "max30210" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max30210_id);
+
+static const struct of_device_id max30210_of_match[] = {
+	{ .compatible = "adi,max30210" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max30210_of_match);
+
+static struct i2c_driver max30210_driver = {
+	.driver = {
+		.name = "max30210",
+		.of_match_table = max30210_of_match,
+	},
+	.probe = max30210_probe,
+	.id_table = max30210_id,
+};
+module_i2c_driver(max30210_driver);
+
+MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>");
+MODULE_DESCRIPTION("MAX30210 low-power digital temperature sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1

