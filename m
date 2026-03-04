Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0473AE70B;
	Wed,  4 Mar 2026 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627139; cv=none; b=T+UUY3gnqcii+cWsgjnDzb7WOAYKc71bTrkX6Jtlba8owyfvBRKVtaoAC+uw7r5JcfD6e9UGvR/5MdWBaJrJ9V/vhszJ1cmevkParF5Qd1gY2nBX2GcnwK0KCceH6Tf9lYHcTOCmg53lXFlUFbz4I6zUvrQZQplVCNeyYEh0SDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627139; c=relaxed/simple;
	bh=Lku5ONQaew8MjKXOjayW0itAe3ocXkLMzDxes9/3k1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hfv52BAONuNZ2MOKvxpUzphr2v22zN5SQh/HVTsCEiuIeR8jfH9KrOKB67Y75jkHyQdjZE92roYFf8KOYqN1Zg4jWLJqKHw/uKP4t5wRF9j9FJwV6mRuK04I3EanpUVT0gzzSQMGk+5wikLUf4/qe39zhK2SlL2dC1UYmWA0JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FaTfhiLK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FaTfhiLK"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624AhD9h1133063;
	Wed, 4 Mar 2026 07:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=367Ga
	bDRkxsG8k8seyTIWsgC6sxnrZ9ZEDWV2lTVnoQ=; b=FaTfhiLKKsGhy76MXMOAi
	EsV6WliMNscm44OGXv2MBoD/6rUbnTqFpSDdxNplP/jD89NzJJTZgIlUz7JcyYyS
	z2FVe/nO8FSwmgDZYljam6rqw0++nXEoGIJ7LfS9w+M54TLBINlLSJt41tJX7q29
	d3h2/CGklBGA3K1FPsHKdAUsufC9aKu0R3LY17ULeYLJVNq1N5cEekIn5yQAklUc
	mTz0SvJJri1pDEvIFwmy+oK6KIWrN+tqlwt++q7qOgUt6FhCRJxaIUfzOLt3W271
	koPQGSYdy2LZeGMg3nBS6n4lUS5M7vaGUGtsU4LDayXHAyJ1iHr0Ak6krMfaVupp
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cnwnnnh3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 07:25:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 624CPVOm032275
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 07:25:31 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Mar 2026 07:25:31 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 624CPCsD006193;
	Wed, 4 Mar 2026 07:25:23 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Wed, 4 Mar 2026 20:25:09 +0800
Message-ID: <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: elmiUMI6KhL0KPHBlP-SpTyCnWtABSCj
X-Authority-Analysis: v=2.4 cv=dY6NHHXe c=1 sm=1 tr=0 ts=69a824bc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=ze7kzr7wla5GQQ3aEv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: elmiUMI6KhL0KPHBlP-SpTyCnWtABSCj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5OCBTYWx0ZWRfX6WBuUk6w51BG
 qlC7phv3+LkplNhakemksTyeaT9xo3jWZrcqIJQmUbAfmrvzP1ifME2R1QOxCYhQbE1GU1h5GDv
 4HASeD6dHtYAdEyPcgMQ/piG8OSpeUZNrmdxVbKu5/QZxWx7weTKEvRBeQW5pOIT3jp+HuM7AwI
 QCuPKyYdJblRKPNBJm4Py9TlFh6q0DMZtwCTl9XfsNtqbPWEhA9RvF1vKNPskamt4LnyVvOtWl4
 KYGMdz6JHPWigs0dVW1ZZu0WQNOBOddkMyyjCii5sTjGaV0GcUMqqzUOtIUS3/XfSMoria2oBNn
 msKMXo92DL6yik7OxaY952f0WQERnHj1icsdyJI9UESNJUIfKxaD9acMwP8rSkRFiItoboktnt8
 IVGfoEc/g7018QFtXRFzzXwwmWDUzExHqkE9KHF9spOlWMeVk82/6B2GkTWhboT+GSlcG2JWoBs
 MMuRrlOLwoNoeIEgs7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040098

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
 drivers/iio/temperature/max30210.c | 664 +++++++++++++++++++++++++++++
 4 files changed, 676 insertions(+)
 create mode 100644 drivers/iio/temperature/max30210.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 09345b9f32ed..2abdbcf3a8e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1644,6 +1644,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
+F:	drivers/iio/temperature/max30210.c
 
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 9328b2250ace..b396757eb761 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -184,4 +184,14 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+config MAX30210
+	tristate "Analog Devices MAX30210 temperature sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for MAX30210 low-power digital
+	  temperature sensor chip connected via I2C.
+
+	  This driver can also be build as a module. If so, the module
+	  will be called max30210.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7..e5aad14dc09b 100644
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
index 000000000000..839ed9830957
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices MAX30210 I2C Temperature Sensor driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/regmap.h>
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
+#define MAX30210_FIFOCONF1_FLUSH_FIFO_MASK BIT(4)
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
+#define MAX30210_FIFO_SIZE		64
+#define MAX30210_FIFO_INVAL_DATA	GENMASK(23, 0)
+#define MAX30210_WATERMARK_DEFAULT	(0x40 - 0x1F)
+
+#define MAX30210_UNIQUE_ID_LEN		6
+#define MAX30210_EXT_CVT_FREQ_MIN	1
+#define MAX30210_EXT_CVT_FREQ_MAX	20
+
+struct max30210_state {
+	struct regmap *regmap;
+	u8 watermark;
+	/* Raw FIFO byte buffer (3 bytes per sample) */
+	u8 fifo_buf[3 * MAX30210_FIFO_SIZE];
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
+			       st->fifo_buf, 3 * st->watermark);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
+		return;
+	}
+
+	for (unsigned int i = 0; i < st->watermark; i++) {
+		u32 raw = get_unaligned_be24(&st->fifo_buf[3 * i]);
+
+		if (raw == MAX30210_FIFO_INVAL_DATA) {
+			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
+			continue;
+		}
+
+		s16 temp = (s16)(raw & 0xFFFF);
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
+	if (!readval)
+		return regmap_write(st->regmap, reg, writeval);
+
+	return regmap_read(st->regmap, reg, readval);
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
+		if (uval >= ARRAY_SIZE(max30210_samp_freq_avail))
+			uval = ARRAY_SIZE(max30210_samp_freq_avail) - 1;
+
+		*val = max30210_samp_freq_avail[uval][0];
+		*val2 = max30210_samp_freq_avail[uval][1];
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_RAW: {
+		if (iio_buffer_enabled(indio_dev))
+			return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
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
+			if (val == max30210_samp_freq_avail[i][0] &&
+			    val2 == max30210_samp_freq_avail[i][1]) {
+				return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
+						MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
+						FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
+			}
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
+	unsigned int reg;
+	int ret;
+
+	if (val < 1 || val > MAX30210_FIFO_SIZE)
+		return -EINVAL;
+
+	reg = MAX30210_FIFO_SIZE - val;
+
+	ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG, reg);
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
+	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG, MAX30210_STATUS_A_FULL_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+			    MAX30210_TEMPCONV_AUTO_MASK | MAX30210_TEMPCONV_CONV_T_MASK);
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
+	if (ret)
+		return ret;
+
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
+static const struct iio_chan_spec max30210_channels = {
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
+		.shift = 0,
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
+		ret = regmap_update_bits(st->regmap, MAX30210_SYS_CONF_REG,
+					 MAX30210_SYSCONF_RESET_MASK,
+					 MAX30210_SYSCONF_RESET_MASK);
+		if (ret)
+			return ret;
+	}
+
+	/* Datasheet Figure 6:
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
+	indio_dev->channels = &max30210_channels;
+	indio_dev->num_channels = 1;
+	indio_dev->name = "max30210";
+	indio_dev->info = &max30210_info;
+
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
+					      max30210_fifo_attributes);
+	if (ret)
+		return ret;
+
+	if (client->irq) {
+		ret = devm_request_irq(dev, client->irq, max30210_irq_handler, IRQF_NO_THREAD,
+				       indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	}
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
+MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com");
+MODULE_DESCRIPTION("MAX30210 low-power digital temperature sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1

