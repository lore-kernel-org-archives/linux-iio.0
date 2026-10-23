Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742822;
	b=cJ5nNTi6rXSQHWncpRhfWGGEyHgzHMZmbAzo4Uz7E2jX6IbIs5fnkRn2yer5/y+MuU8U
	 GBCiU67VyYxtGJq9a2kkREEdF2dDxGQJ3QVmK0DWC1wNArRPCBcfvfVLpNZYrBpOqXYMw
	 VZ6cFhBxJcDXnMVcMKKLqdCqciz8ULIuGLNh1dp1+bWZFTDmkA2QcWM7tyhKqWOdBMB+O
	 3Jx/3h2dt6P8dkgCedFTE3FKl1SGFx07Hwy7kE8cz5BPISNXls7C4SjO6Da3AytnTfDQF
	 rlDpeVCUrlpkHgkkMC0Tdbyrpvz28+u+paLtRJ+Jm4dZgsabvPT7ufq0bvjEGNmNr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742822;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w977YKzZ+9/YR1Aaj+kPE6nUOO2/pe9Y3WzT+c014w4=;
	b=35+ctZsKfkW3768bcjdn93gXvllOzgT7YNwsva4OfvnXkjie/T8IC6CJlvtoPF8dR6ny
	 NE94A1THj1BjV/MQYGK7AovzDLAJNCDrnZ06gP4N60JgtQH2/C9I9Pqs0f+ECHKUidb0s
	 bCDve5467fwPenL3oAVA2TPyamvgvclJShGYxZ0IvjbxLFMSHCTcQyLu1rDLsCjykg9I4
	 su/bS6G82k5nUUXmBWafdOTbOyyTCn4jYETFZUS7i2lybBEoSHU7g9KAeVBp2zV2BBvLX
	 YR2SszbAowAz9FGueP8Toz/xq4wFVO2xXKOBlX6RrzXmUCelXMnt4/EAcafN8jeTtxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZCjeLcAh;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jPOUtqLi;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE4606A31F;
	Fri, 23 Oct 2026 08:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBEE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZCjeLcAh;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jPOUtqLi
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7NBgT1231577;
	Fri, 23 Oct 2026 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=w977YKzZ+9/YR1Aaj+kPE6nUOO2/pe9Y3WzT+c014w4=; b=ZCjeLcA
	hImH9pjWuZOfEp1A3mMtsNNHlv+SIbc6CsupzmfDIEXf6q3AEn0ImB1vZxtOv91M
	YNzr2QcEQ9X6L2mLNvjAVoDv+DydS22Gywk6TJz9WF8emB2jTFi8mCw1eebvXcfM
	/RVnkSDU5BSSwXBA5xQ1UoEGvvWQTBBTtlM48ylCOQRBIknp/+jD1ThOU2dmC7UE
	oTsOX+fLb0cYFo6XcwRXCIqtvNsK7aYvHSnfJ0YQvvYDBNcK9Amltdmqgf8jQAoP
	GKjp98FugsCCLrHIFyL59TP5IiM5aiytup2zGzrOomXUPTGBp64xjnqyiBWzAZdA
	fdBZgWjqa3/zCSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w977Y
	KzZ+9/YR1Aaj+kPE6nUOO2/pe9Y3WzT+c014w4=; b=jPOUtqLi94dJbUbPbNCL1
	XqKUFAYCEwoSWZrs0DRsaf2vDinl/JJ9ViJhoTHCb+QRj+0CJomwEnv9xeXXjqce
	khcKWk+hUIl9VgPgM/F64ICFv0GZ7whrqeJnVWSAVpfIBZdZ4+GzQetYGRf6MHSx
	Js36l0E/nPRFTqIqCniHSaWdNyiyvADIJmSc9rid9/a6lIpZzaclrh/WB/Q9KFau
	XNkHZaP/lAUxUzpZr4d91us5BU2aMxK/r/xqmMEFnJ1Xoo/O3SvP1/N7CwrMy5PF
	traBC+VkK/FG11X1Oye0RcT8s091pu/HszHP8GyAbBpY+QLSRPaY/RvLbWFL3UaQ
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg35706bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 04:06:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69N86uC8045330
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 04:06:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 04:06:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 04:06:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 04:06:56 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69N86VIP020871;
	Fri, 23 Oct 2026 04:06:49 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>
Subject: [PATCH v5 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Fri, 23 Oct 2026 16:06:23 +0800
Message-ID: <20261023080623.1830-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
References: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-ORIG-GUID: wrHmvIATuHYgB5XIvp5MXdQmFjy8Zhrp
X-Proofpoint-GUID: wrHmvIATuHYgB5XIvp5MXdQmFjy8Zhrp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX91IMANxJsfsE
 I4YAl8YAZ4lAyptwn8hKrAkcaw97DkKOEisdhTRoMnRhs2JGFGYVoz9S1lkR27RYOMv0h8GdXDc
 sqPkW8mFxvksqR7OaKOj6sp++lpxQlYmSaLvj9T8pP8i/Ae59c2BGhawMeQoPC7mxcBkRtREpO2
 2FnTgFtjmb2kYpzLdV/4ZI8tN7+vdpVm3RfqKADj+lfEn4LUmfi0XMpF0R43OjSvwXgBDOhycCW
 OmGgDL5wKP4BfMj6fOL6SByH3b6w8xyemNpJlZDQytlXvNi7kuTcK24K/85pGu/rKaplc63fRMS
 CuioLRaoUYOlUnzu+5GKR0SetCDIWojlTDQzAz9qyZxaFu9VbPXO0HAasRm4KvElG+NvTkPgQIp
 IOQS+HcKY9C1j6XIJ5XHNN/OV3Z32L354y2s01itIovH8ui1UiiKsw0EI4sFxnMefIev1auiFR2
 7ZJTTPcMMBax/U+KaBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7NSAxmLhU0ok
 LCq2BZXT9z2ceTCeNIa3ltSrN2Lgtu7OGbaUOrBG5VV+oi6Fre6eCobdfCdWVbXGJAsaHfOtCr6
 +ALyugyPbp9GZmpW0rGWtQe1cPhPELWgg4skiFvx8lzvOrL87Epy
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adb15a1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=lukCjBvraipxyrcdDRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

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

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                        |   1 +
 drivers/iio/temperature/Kconfig    |  13 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30210.c | 844 +++++++++++++++++++++++++++++
 4 files changed, 859 insertions(+)
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
index 0000000000000..01a1eff4da663
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,844 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices MAX30210 I2C Temperature Sensor driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/lockdep.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#define MAX30210_STATUS_REG			0x00
+#define   MAX30210_STATUS_A_FULL_MASK		BIT(7)
+#define   MAX30210_STATUS_TEMP_RDY_MASK		BIT(6)
+#define   MAX30210_STATUS_TEMP_DEC_MASK		BIT(5)
+#define   MAX30210_STATUS_TEMP_INC_MASK		BIT(4)
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
+static int max30210_read_temp(struct regmap *regmap, unsigned int reg, int *temp)
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
+static int max30210_write_temp(struct regmap *regmap, unsigned int reg, int temp)
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
+	int ret;
+
+	lockdep_assert_held(&st->lock);
+
+	if (st->autoconv_users == 0) {
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+				   MAX30210_TEMPCONV_AUTO | MAX30210_TEMPCONV_CONV_T);
+		if (ret)
+			return ret;
+	}
+
+	st->autoconv_users++;
+
+	return 0;
+}
+
+static int max30210_autoconv_put(struct max30210_state *st)
+{
+	int ret = 0;
+
+	lockdep_assert_held(&st->lock);
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
+	if (!(status & (MAX30210_STATUS_A_FULL_MASK |
+			MAX30210_STATUS_TEMP_HI_MASK |
+			MAX30210_STATUS_TEMP_LO_MASK)))
+		return IRQ_NONE;
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
+	unsigned int mask, val;
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
+	guard(mutex)(&st->lock);
+
+	/* The core does not dedupe; only take/drop a reference on a real change. */
+	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
+	if (ret)
+		return ret;
+
+	if (!!(val & mask) == state)
+		return 0;
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
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
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
+		period = min(period, ARRAY_SIZE(max30210_samp_freq_avail) - 1);
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
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
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
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
+
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max, __stringify(MAX30210_FIFO_SIZE));
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
+		goto err_disable_irq;
+
+	scoped_guard(mutex, &st->lock)
+		ret = max30210_autoconv_get(st);
+	if (ret)
+		goto err_disable_irq;
+
+	return 0;
+
+err_disable_irq:
+	/* The core won't call postdisable() when preenable() fails. */
+	regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
+			  MAX30210_STATUS_A_FULL_MASK);
+
+	return ret;
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret, err;
+
+	scoped_guard(mutex, &st->lock)
+		err = max30210_autoconv_put(st);
+
+	/* Keep going on error so the interrupt is always disabled below. */
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF2_FLUSH_FIFO);
+	if (!err)
+		err = ret;
+
+	/* Disable FIFO-full interrupt */
+	ret = regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
+				MAX30210_STATUS_A_FULL_MASK);
+
+	return err ?: ret;
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
+static void max30210_quiesce(void *data)
+{
+	struct max30210_state *st = data;
+
+	/* Stop interrupt sources and autonomous conversions; errors are not actionable here */
+	regmap_write(st->regmap, MAX30210_INT_EN_REG, 0);
+	regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0);
+}
+
+static int max30210_setup(struct max30210_state *st, struct device *dev)
+{
+	struct gpio_desc *powerdown_gpio;
+	unsigned int val;
+	int ret;
+
+	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown", GPIOD_OUT_HIGH);
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
+		/* The supply was just enabled; the device needs tPU before it accepts I2C. */
+		fsleep(700);
+
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
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
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
+	/* Currently, without an interrupt there is no way to drain the FIFO into the buffer */
+	if (client->irq) {
+		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
+						      max30210_fifo_attributes);
+		if (ret)
+			return ret;
+
+		/* Runs after unregister, so nothing can re-arm the device; before powerdown. */
+		ret = devm_add_action_or_reset(dev, max30210_quiesce, st);
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
+	{ .name = "max30210" },
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

