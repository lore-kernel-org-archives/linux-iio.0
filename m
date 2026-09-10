Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A073AC0E5;
	Thu, 10 Sep 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078366; cv=none; b=gx+YjuBhH1isR8bazRZNH/8EElQBgoYMZoeQLSZM4V9Cm3AEnbb8N5KOPlvEC3x8bvzKgci7cZYzqe8bmesiDFQBLbFb296QelSk8umOX0uQb2z8+m8GcgtWqOLuqJpKHVjH5ZyGJFuAYXB8vXGWWYQAF50/aKUt8bxeWYFKLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078366; c=relaxed/simple;
	bh=7YeiVEOys/5QxxkW/Y3UG+DuOo7Hq6le7V0vdtw07MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HotDWDrEMkArjokYsXO2ZTp0eZe16DpUrpqYUgkayUakCdlUc/RpZdI1Zm5HaSQVPr0IFZfmPrF3GA4xrltDRy0i+usOdxulOOypSXpZc26fqI7DvdCJLoyC7dxat15gnpy5G9PzVYC05pJPhcd91c5TzeZyzlI5O2dG9mx3sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U85Bu8lm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U85Bu8lm"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVvAv4005643;
	Thu, 10 Sep 2026 18:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9cntj
	M7+x0qCZFDbLP3c6A9BfRAnrf/BsLKNkkcNJCM=; b=U85Bu8lm0Cbb1r4xzb4Cw
	g1Hgk4q+94BwQBf4mVKX24JGlXKRXoh4M7gwaktMhns8ClDV9bCuoseduIqHkPQC
	+LWooLcaBZ82C5/r1HRXNmpD3hjugBxqAbAwXU8rfHnZJdHuH6ewWVMAcvjMBhor
	IT5zk+99zzL735R55wsekj7Hu9SEh3+30tiIZ60r5x3qery5dZMSWx6x5uSTLynS
	DKG/kBO/QqyqGdqgwiM6/Fgg0Jlj76969gZ78VoyYyVQ69BrXcxGfLDQOHXhcm6K
	FkUB3MAklacuT3ZIuLhIBxJNeMox0saHjlPvg2sE7VWFUrPy+DNQCnapGY/2gxZP
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxce0ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 18:12:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AMCcLb010785
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 18:12:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 18:12:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 18:12:38 -0400
Received: from JGERONI2-L01.ad.analog.com (MABALA-T01.ad.analog.com [10.117.222.255])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AMCIkP028000;
	Thu, 10 Sep 2026 18:12:31 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v3 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Fri, 11 Sep 2026 06:12:17 +0800
Message-ID: <1d3cdd6163923b1c537b8db49b833863ee6bf545.1789032019.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
References: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZFqFShd c=1 sm=1 tr=0 ts=6aa32b58 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=wnaUShoFdWG-XOcECLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5O0fnoM-ODTPRH6lwBFuBvjXXUydkjs5
X-Proofpoint-ORIG-GUID: 5O0fnoM-ODTPRH6lwBFuBvjXXUydkjs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX61PJA/dTYULx
 BCQoNVGIzt7TukzS3NVsr0nXf/NhaHvkXRpHPyOUsUaF5B6XmcWZO4NqlAhSs8Z95BYSdtC6IY/
 IdqJU85ReR9gqL3mKLOw8lI3ia/ix2dVFuvY5Vh+ZmvCLRSR3sJhN+5wOv6Z9eIcFX8VQooMEO8
 xRyMu7c0Isoq6TM03n790hP80JtcF/472Pb+R8K2HhqqT9bxZs2QeMCWgJSgWECngJWNVTjOctA
 FhYGkC0yBYm7sDwcjYRViL3d3k7rT5qkkUSOGX340SKZLxKPdWRNPHO0rQuieoZ0/vHhTrBMojC
 1ZyyzHQ6bZavAal+MS2KO5WiMgcdhy+Gt64etgKHphocRvRiYMlVRYjrumpBYb86pyHTsdGjBKR
 ASJwEGoow/IiqM8zOv8TFuOJLh53XYpU56znUapfInJgMjNr6JIVR8P/N33Qmi/qt9gh820uqXg
 w0BAqGkIT5Yvg07/yrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX/9bCerkm+lwz
 IXjhNmlMxeuv2if4ZbAuTVLOy0Y9+vUlV7wHubNqHllhKFv0EkT5WQv7cbftI/OvTAGs0SlJW9R
 Kf/NcfM8fP2WxyDrkKwSkiFzqMm80g4JIF6y2noU9hpIBz68ntea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100278

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
 drivers/iio/temperature/Kconfig    |  10 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30210.c | 689 +++++++++++++++++++++++++++++
 4 files changed, 701 insertions(+)
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
index 9328b2250aced..cf840f7dda765 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -152,6 +152,16 @@ config MAX30208
 	  This driver can also be built as a module. If so, the module
 	  will be called max30208.
 
+config MAX30210
+	tristate "Analog Devices MAX30210 temperature sensor"
+	depends on I2C
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
index 0000000000000..07ff85d6d4848
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices MAX30210 I2C Temperature Sensor driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#define MAX30210_STATUS_REG		0x00
+#define MAX30210_INT_EN_REG		0x02
+#define MAX30210_FIFO_DATA_REG		0x08
+#define MAX30210_FIFO_CONF_1_REG	0x09
+#define MAX30210_FIFO_CONF_2_REG	0x0A
+#define MAX30210_SYS_CONF_REG		0x11
+#define MAX30210_PIN_CONF_REG		0x12
+#define MAX30210_TEMP_ALM_HI_REG	0x22
+#define MAX30210_TEMP_ALM_LO_REG	0x24
+#define MAX30210_TEMP_INC_THRESH_REG	0x26
+#define MAX30210_TEMP_DEC_THRESH_REG	0x27
+#define MAX30210_TEMP_CONF_1_REG	0x28
+#define MAX30210_TEMP_CONF_2_REG	0x29
+#define MAX30210_TEMP_CONV_REG		0x2A
+#define MAX30210_TEMP_DATA_REG		0x2B
+#define MAX30210_TEMP_SLOPE_REG		0x2D
+#define MAX30210_UNIQUE_ID_REG		0x30
+#define MAX30210_PART_ID_REG		0xFF
+
+#define MAX30210_STATUS_A_FULL_MASK   BIT(7)
+#define MAX30210_STATUS_TEMP_RDY_MASK BIT(6)
+#define MAX30210_STATUS_TEMP_DEC_MASK BIT(5)
+#define MAX30210_STATUS_TEMP_INC_MASK BIT(4)
+#define MAX30210_STATUS_TEMP_LO_MASK  BIT(3)
+#define MAX30210_STATUS_TEMP_HI_MASK  BIT(2)
+#define MAX30210_STATUS_PWR_RDY_MASK  BIT(0)
+
+#define MAX30210_FIFOCONF1_A_FULL_MASK		GENMASK(5, 0)
+#define MAX30210_FIFOCONF1_FLUSH_FIFO_MASK	BIT(4)
+
+#define MAX30210_SYSCONF_RESET_MASK		BIT(0)
+
+#define MAX30210_PINCONF_EXT_CNV_EN_MASK	BIT(7)
+#define MAX30210_PINCONF_EXT_CVT_ICFG_MASK	BIT(6)
+#define MAX30210_PINCONF_INT_FCFG_MASK		GENMASK(3, 2)
+#define MAX30210_PINCONF_INT_OCFG_MASK		GENMASK(1, 0)
+
+#define MAX30210_TEMPCONF1_CHG_DET_EN_MASK	BIT(3)
+#define MAX30210_TEMPCONF1_RATE_CHG_FILTER_MASK	GENMASK(2, 0)
+
+#define MAX30210_TEMPCONF2_TEMP_PERIOD_MASK	GENMASK(3, 0)
+#define MAX30210_TEMPCONF2_ALERT_MODE_MASK	BIT(7)
+
+#define MAX30210_TEMPCONV_AUTO_MASK	BIT(1)
+#define MAX30210_TEMPCONV_CONV_T_MASK	BIT(0)
+
+#define MAX30210_PART_ID		0x45
+#define MAX30210_FIFO_SIZE			64
+#define MAX30210_FIFO_BYTES_PER_SAMPLE		3
+#define MAX30210_FIFO_TEMP_MASK			GENMASK(15, 0)
+#define MAX30210_FIFO_INVAL_DATA		GENMASK(23, 0)
+#define MAX30210_WATERMARK_DEFAULT	(0x40 - 0x1F)
+
+#define MAX30210_UNIQUE_ID_LEN		6
+#define MAX30210_EXT_CVT_FREQ_MIN	1
+#define MAX30210_EXT_CVT_FREQ_MAX	20
+
+struct max30210_state {
+	struct regmap *regmap;
+	u8 watermark;
+	/* Raw FIFO byte buffer */
+	u8 fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * MAX30210_FIFO_SIZE];
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
+static const struct regmap_config max30210_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX30210_PART_ID_REG,
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
+static void max30210_fifo_read(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
+			       st->fifo_buf,
+			       MAX30210_FIFO_BYTES_PER_SAMPLE * st->watermark);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
+		return;
+	}
+
+	for (unsigned int i = 0; i < st->watermark; i++) {
+		u32 raw = get_unaligned_be24(&st->fifo_buf[MAX30210_FIFO_BYTES_PER_SAMPLE * i]);
+
+		if (raw == MAX30210_FIFO_INVAL_DATA) {
+			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
+			continue;
+		}
+
+		s16 temp = (s16)FIELD_GET(MAX30210_FIFO_TEMP_MASK, raw);
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
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG,
+						  MAX30210_STATUS_TEMP_HI_MASK, state);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG,
+						  MAX30210_STATUS_TEMP_LO_MASK, state);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
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
+		*val2 = 1000;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
+		if (ret)
+			return ret;
+
+		uval = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
+
+		/*
+		 * TEMP_PERIOD is an index into the sampling frequency lookup
+		 * table. Clamp in case the register holds a reserved value.
+		 */
+		uval = min_t(unsigned int, uval, ARRAY_SIZE(max30210_samp_freq_avail) - 1);
+
+		*val = max30210_samp_freq_avail[uval][0];
+		*val2 = max30210_samp_freq_avail[uval][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_RAW: {
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+				   MAX30210_TEMPCONV_CONV_T_MASK);
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
+					       !(uval & MAX30210_TEMPCONV_CONV_T_MASK),
+					       500,          /* poll every 500 µs */
+					       10000);       /* 10 ms timeout */
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
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		if (val < 0 || val2 < 0)
+			return -EINVAL;
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
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(MAX30210_FIFO_SIZE));
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
+			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
+	if (ret)
+		return ret;
+
+	/* Start autonomous temperature conversion */
+	return regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+			    MAX30210_TEMPCONV_AUTO_MASK | MAX30210_TEMPCONV_CONV_T_MASK);
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/* Stop autonomous conversion */
+	ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
+	if (ret)
+		return ret;
+
+	/* Flush FIFO */
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
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
+static int max30210_setup(struct max30210_state *st, struct device *dev)
+{
+	struct gpio_desc *powerdown_gpio;
+	unsigned int val;
+	int ret;
+
+	/* Optional hardware reset via powerdown GPIO */
+	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
+				     "failed to request powerdown GPIO\n");
+
+	if (powerdown_gpio) {
+		/* Deassert powerdown to power up device */
+		gpiod_set_value(powerdown_gpio, 0);
+	} else {
+		/* Software reset fallback */
+		ret = regmap_set_bits(st->regmap, MAX30210_SYS_CONF_REG,
+				      MAX30210_SYSCONF_RESET_MASK);
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
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
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
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
+					      max30210_fifo_attributes);
+	if (ret)
+		return ret;
+
+	if (!client->irq)
+		return dev_err_probe(dev, -ENXIO, "Missing interrupt.\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					max30210_irq_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
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

