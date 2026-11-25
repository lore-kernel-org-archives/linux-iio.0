Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575326;
	b=M1VQjoJEb2C9pCy5TX8Xe3BKi5+nv7w9L5Ii0Ghdn+K1IJEQn1kQSadYfCCTaoGo0oz8
	 AXgoBy/RJc3DvEBnWkcgk7q/iEejCoXvpe5OnuqwjstligTy29hG7ld69RBKzgIdqBAZM
	 43GjgoqODokKRle8hVjvBXixiKNLSSQDN3LMAzfGi7PdYrvIzPaBrHaPAjqfVYHO4tgaQ
	 L6ueuporF/fbalSqotTBfiwnVi5nvUoBLkAkrsu5IWEGx5/JOT6pGrZKe2RrHHniMfGJD
	 QmSLjbNHTWo3YdqC3NWi6NEUjhKCse+j53K2Xx+NmhX/PTvzOKnJumfZap3Qz+JrfxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575326;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NYHJ3ENlL4pCyeUrrKvtg/QqDfRFhVxmUfzj8z+/Vys=;
	b=MaT8EgyYv+dFvameU5r1VZwxo4ns2p3b5PNxIsrUXAFIrN3poP8twxFNW6lIuuJt1UN2
	 jBSPY6+HQNf46d0aIzGtWvEDg1bdQ4igxm+ibJUfo2laHAHkfSMkJXW+19252ISMS6E/6
	 +Bd/Ys8xTKnQd/4W2kYaV0ARGKQROlDB4Q0IB/oMtgt5VEBVgT+vg3hmgM8DfJ0JdKOI2
	 Sk+fH2mfuF4a6nT/zoCjCjwE6Doj8CJq7yCHkh9i+0Apwq58Y1841csF8XbSU5FKNRuMp
	 hy3stnkVwefuHZUK+ya6TfaacBF176uwBR+Iw5U9byMT0TcIiuI2MrDedKOp1d/RBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=neYxe9tS;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZlrHxd0p;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80600606A321;
	Wed, 25 Nov 2026 02:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80600606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=neYxe9tS;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZlrHxd0p
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP29egi2477025;
	Tue, 24 Nov 2026 21:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=NYHJ3ENlL4pCyeUrrKvtg/QqDfRFhVxmUfzj8z+/Vys=; b=neYxe9t
	SW8yQuzdXPhrIZR3MzL5VVP9CDOYOmzEDOUncCVqXgrhz/xTqtoqPAgO1iK1RatZ
	5jw3mHy/KIpdAL2YRgeOx2ytlZuJTc8zsHoehdGodLI2+JlxXxhWCJ3xfeIxIbEG
	0zuDZkYUZMJbjGKALIpjP3yNO88vGQJZwyK8Gr7+cmJ+lAVJIrK8+nHzFpyrAcJT
	LuYlbWA19D7nVxOlyMUyJUG/TkCY8RtVtkwhPO+T5YfheCns3nuXccN9MaBaOctZ
	VUkgBlIkX8hI8lSTGIuLqbD1A6JwxVD0vBxAhFCSG7YmHnei9tQw8UhuEPU1ve3k
	PIm4vIxNGLTRf7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NYHJ3
	ENlL4pCyeUrrKvtg/QqDfRFhVxmUfzj8z+/Vys=; b=ZlrHxd0pQccn+u28dUj/e
	cu58slRv2n+ztoSOikzh+uP9R2MetonqDDCq7z/51t8vPXZv9bB2ITDD9LNJYHE9
	C1djjTNh+h5c3mCmyrZo4LhiEFpSc4z4fs5+FdiRpt/C/osG56orUGY3urcETlfs
	p/1eB5Ujhpvvy54fB7kbeq1O+QS29bk8RKpAurd4YB2PWUYru4ILVaCnlRWIRRXD
	bpP+2NEsTcewLsUcW6yHL04CWn3s2dMGRcs48MVUCYhvCdHWl0IHSbO4dXX8jADZ
	dFCRU9+36bNotzAqbmsSoaQzJ3CZDH0YknoiEfKK9QgvssxI9Si8XXf1+3sd3sQX
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h5jjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 21:55:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AP2t9rC056989
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Nov 2026 21:55:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 21:55:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 24 Nov 2026 21:55:09 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AP2sYQI016116;
	Tue, 24 Nov 2026 21:55:00 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>
Subject: [PATCH v7 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Wed, 25 Nov 2026 10:54:25 +0800
Message-ID: <20261125025425.1176-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261125025425.1176-1-johnerasmusmari.geronimo@analog.com>
References: <20261125025425.1176-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfX1QG2Keo/kJzR
 uEQREFkPf1XXl+ZuXtCHzuObbVxRCidQqa33WonsJslpDKZCHj9aI/3RdVZEPCgusTL9mW4obhU
 CXjkhzVgnWpkNyguR+vovJKzDFiiR2Byi+YAuMWgg5RWefFdr7krJynukPsEcO6Xa7Hpo6Q+sGB
 JKRsQZFfoBRKA1fTSQvOkzdEWfo28VV9d2fMUYHyNcYDKcG2uCBE5n2wJ72BRyWXZzvgLs87muH
 a5yjPAiCBF9JczDOCi1L1qJHvAfSZt4kGm/7iQX2Re6EzViOZ1xciNxSZ3aJCU/iitJHRhPSHG9
 ZYNEJNEDRO5cZJ42d+xfUEJ/9HYWJN7VRJLQ2+o41w+aaFn3J7nWkFb2spx13mav93LcCjFzf/d
 rPMV0SYpMWM0FZ25Nroz3rKfekqi35nfGUD9zLcAMO9VP3zxQ1vCKL17O/e0ERl/0lTJYoihheh
 v0+4C1ytQDU44p4SvQA==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b064e0f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=jKwOpbBgZWvDzDMVsWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eOkJEE7FrCO0tEnCunf-0nWLt3J-28qy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfX6SEb8rfGnzD8
 1s9//T7vIgXPQBxs6HyvEV3/wAe+lAHXy+CdwbuULDmK7GWD4d5qJ5FKgSFsOph6h+OMs77zHrh
 IAYxBdVh4j2V7wuFEIDNkOO/lXG1VnogJzUfvzzjWteXD3w4th0E
X-Proofpoint-ORIG-GUID: eOkJEE7FrCO0tEnCunf-0nWLt3J-28qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250011

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
 drivers/iio/temperature/max30210.c | 859 +++++++++++++++++++++++++++++
 4 files changed, 874 insertions(+)
 create mode 100644 drivers/iio/temperature/max30210.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d00ecbdd21e7c..86d95ca2f3124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1792,6 +1792,7 @@ L:	linux-iio@vger.kernel.org
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
index 0850bf6918204..bb9fdccc104e1 100644
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
index 0000000000000..5f704bf9a8480
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,859 @@
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
+	struct iio_chan_spec channel;
+	struct regmap *regmap;
+	/* Raw FIFO byte buffer */
+	u8 fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * MAX30210_FIFO_SIZE];
+	/* Protects autoconv_users and the autonomous-conversion enable bit */
+	struct mutex lock;
+	unsigned int autoconv_users;
+	int irq;
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
+	case MAX30210_SYS_CONF_REG:
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
+	/*
+	 * Drop the reference even if the write fails;
+	 * a later direct read clears AUTO anyway.
+	 */
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
+		dev_err_ratelimited(&indio_dev->dev, "Failed to read from fifo.\n");
+		return;
+	}
+
+	for (unsigned int i = 0; i < st->watermark; i++) {
+		unsigned int idx = MAX30210_FIFO_BYTES_PER_SAMPLE * i;
+		u32 raw = get_unaligned_be24(&st->fifo_buf[idx]);
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
+	unsigned int status, enabled;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
+	if (ret) {
+		dev_err_ratelimited(&indio_dev->dev, "Status read failed\n");
+		return IRQ_NONE;
+	}
+
+	/* STATUS flags are set whether or not they are enabled in INT_EN. */
+	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &enabled);
+	if (ret) {
+		dev_err_ratelimited(&indio_dev->dev, "Interrupt enable read failed\n");
+		return IRQ_NONE;
+	}
+
+	status &= enabled;
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
+	struct regmap *map = st->regmap;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return max30210_read_temp(map, MAX30210_TEMP_ALM_HI_REG, val);
+	case IIO_EV_DIR_FALLING:
+		return max30210_read_temp(map, MAX30210_TEMP_ALM_LO_REG, val);
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
+	struct regmap *map = st->regmap;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val < S16_MIN || val > S16_MAX)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return max30210_write_temp(map, MAX30210_TEMP_ALM_HI_REG, val);
+	case IIO_EV_DIR_FALLING:
+		return max30210_write_temp(map, MAX30210_TEMP_ALM_LO_REG, val);
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
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
+	if (ret)
+		return ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
+	case IIO_EV_DIR_FALLING:
+		return FIELD_GET(MAX30210_STATUS_TEMP_LO_MASK, val);
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
+	struct regmap *map = st->regmap;
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
+	guard(mutex)(&st->lock);
+
+	/* The core does not dedupe; only take/drop a reference on a real change. */
+	ret = regmap_test_bits(map, MAX30210_INT_EN_REG, mask);
+	if (ret < 0)
+		return ret;
+
+	if (!!ret == state)
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
+
+		ret = regmap_set_bits(map, MAX30210_INT_EN_REG, mask);
+		if (ret)
+			max30210_autoconv_put(st);
+
+		return ret;
+	}
+
+	ret = regmap_clear_bits(map, MAX30210_INT_EN_REG, mask);
+	if (ret)
+		return ret;
+
+	return max30210_autoconv_put(st);
+}
+
+static int max30210_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	struct regmap *map = st->regmap;
+	unsigned int uval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = 5;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int freq_idx;
+
+		ret = regmap_read(map, MAX30210_TEMP_CONF_2_REG, &uval);
+		if (ret)
+			return ret;
+
+		freq_idx = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
+
+		/*
+		 * TEMP_PERIOD is an index into the sampling frequency lookup
+		 * table. Clamp in case the register holds a reserved value.
+		 */
+		freq_idx = min(freq_idx, ARRAY_SIZE(max30210_samp_freq_avail) - 1);
+
+		*val = max30210_samp_freq_avail[freq_idx][0];
+		*val2 = max30210_samp_freq_avail[freq_idx][1];
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
+		ret = regmap_write(map, MAX30210_TEMP_CONV_REG,
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
+		ret = regmap_read_poll_timeout(map, MAX30210_TEMP_CONV_REG,
+					       uval, !(uval & MAX30210_TEMPCONV_CONV_T),
+					       500, 10 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		return max30210_read_temp(map, MAX30210_TEMP_DATA_REG, val);
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
+	struct regmap *map = st->regmap;
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
+			u32 m = MAX30210_TEMPCONF2_TEMP_PERIOD_MASK;
+			u32 v = field_prep(m, i);
+
+			if (val != max30210_samp_freq_avail[i][0] ||
+			    val2 != max30210_samp_freq_avail[i][1])
+				continue;
+
+			return regmap_update_bits(map, MAX30210_TEMP_CONF_2_REG, m, v);
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
+	val = min(val, MAX30210_FIFO_SIZE);
+	if (!val)
+		return -EINVAL;
+
+	/*
+	 * FIFO_A_FULL sets the number of empty FIFO slots remaining when
+	 * the A_FULL interrupt fires. For a watermark of N samples, set
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
+
+	/* Start from an empty FIFO so the first sample is fresh. */
+	return regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			       MAX30210_FIFOCONF2_FLUSH_FIFO);
+}
+
+/* The core calls this after hwfifo_set_watermark(), so the watermark is stable here. */
+static int max30210_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int status;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/*
+	 * Clear a stale A_FULL so it cannot fire on the flushed FIFO. With
+	 * no autoconv user no threshold event is armed, so STATUS holds
+	 * nothing worth keeping; otherwise leave it for the IRQ handler.
+	 */
+	if (!st->autoconv_users) {
+		ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
+		if (ret)
+			return ret;
+	}
+
+	ret = max30210_autoconv_get(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG,
+			      MAX30210_STATUS_A_FULL_MASK);
+	if (ret)
+		max30210_autoconv_put(st);
+
+	return ret;
+}
+
+static int max30210_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret, err;
+
+	/* Stop the FIFO interrupt and wait for a running handler before the buffer goes away. */
+	ret = regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
+				MAX30210_STATUS_A_FULL_MASK);
+	synchronize_irq(st->irq);
+
+	scoped_guard(mutex, &st->lock)
+		err = max30210_autoconv_put(st);
+
+	return ret ?: err;
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	return regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			       MAX30210_FIFOCONF2_FLUSH_FIFO);
+}
+
+static const struct iio_buffer_setup_ops max30210_buffer_ops = {
+	.preenable = max30210_buffer_preenable,
+	.postenable = max30210_buffer_postenable,
+	.predisable = max30210_buffer_predisable,
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
+	gpiod_set_value_cansleep(powerdown_gpio, 1);
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
+		/* CVT/PDB needs a 5 µs low pulse; hold it asserted for twice that. */
+		fsleep(10);
+
+		/* Deassert powerdown to power up device */
+		gpiod_set_value_cansleep(powerdown_gpio, 0);
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
+	st->irq = client->irq;
+
+	ret = max30210_setup(st, dev);
+	if (ret)
+		return ret;
+
+	/* Without an interrupt no event can be delivered, so do not expose any. */
+	st->channel = max30210_channel;
+	if (!client->irq) {
+		st->channel.event_spec = NULL;
+		st->channel.num_event_specs = 0;
+	}
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &st->channel;
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
+		/* Runs after the IRQ is freed and the device unregistered; before powerdown. */
+		ret = devm_add_action_or_reset(dev, max30210_quiesce, st);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						max30210_irq_handler, IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
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

