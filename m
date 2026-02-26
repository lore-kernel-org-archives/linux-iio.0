Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96D43E4A0;
	Thu, 26 Feb 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123510; cv=none; b=sUM4Sv2mJCSRB9QWiu/J4HRc6GGz+g4boBBjgREV/+pxIVsOO5+0FGWnGPmSgNW5avm/oVNzQRndiQoG0ldKSwSpKpL+phw9IwyB6qgDsTejF0rfkD9S5BuTIn23K4VJoCk/EiJPoKXobhrunpTZ4DYKQz69+pXj+8bQNvOINP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123510; c=relaxed/simple;
	bh=z/KWzUHMb54VEyUeH2mPdNeQoyUyEwGuGPFoNwxPs/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxwEtJqKhMY9HeQrMkKNENUNNEGb3/qnSgm+P0S9SSmeTGbAuWJ6SFdQHQNO/p3OpVVs6Z1tBz7KWjbQ5I6WdIhOniwWJSPfa97YLcKNWL/2bl4BzWqpJXSVhBaE/tageIRbf/PaABLtfunxyB/nvp3O+WDOfrbwKvbZRKD0x8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Imtz/Ra/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Imtz/Ra/"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QGM4sx3025355;
	Thu, 26 Feb 2026 11:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FhufH
	28ky51X5eRSCsSAfZ/g/5BO2JUPKVmZpYaA7+k=; b=Imtz/Ra/ZlYxJ73nz3ink
	C+0V3ir60iuGPhh8WVHsdzFDl31XcwVZXRKdEcOlrCrwigCSeJZPr9mN3Rccpc3F
	TzzNZozDKL94yf7aEM31i7irkXFyLapSEdAPiO322ikQsRwRsTRxSVPNeHtwyPMe
	liwvDCYU7S38jobpzHv7iQo+XQGJ5sL3aHNudxf+33Yjdb9WyXyQk+eTonMFghKF
	Jxa2tX9lJPhSCu9jk2M2DgZxCVsFrbVz9P1pe+7m/fOdYPEVi3pdaVzukBbaUVpx
	zX9bEFALWGA/U6FDIoE6KofwEEfTTXLq4HX/yzyZ48lmRFWSWasIirlV2jouokp4
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdc0x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 11:31:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61QGVapg056516
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Feb 2026 11:31:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 26 Feb
 2026 11:31:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 26 Feb 2026 11:31:35 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61QGUkMp008067;
	Thu, 26 Feb 2026 11:31:30 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
Subject: [PATCH 2/2] iio: temperature: add ADI MAX30210 driver
Date: Fri, 27 Feb 2026 00:30:41 +0800
Message-ID: <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a07569 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=UXJdt2enOCQcncN7INsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w4ZZMj4JDXCuARqXXvWkjibCvBAINRXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0OSBTYWx0ZWRfXzG4rb8MTEfaJ
 7lXyMfl22wcE8C+iUmZ3PAkmMDA6n7oqkZUIVBk0wbz3hvcbEi3uQ3wQI68y5qguVw/byFkhQCF
 n3qX1F6p8volb4gbCy/QcUdx4vZMVeUi70/YCN5UU/1/E6CRCROCQ5VgCHQ5yNTLCWXB0DzoNJT
 z00VpYi1zCzl+7ohFpryaU9bEoNcJVQLz0v6fbf6mrJ3IBvwb12vyJZPa1H3ACnPT6eAEZ9ufHv
 OCjyniI00eYiRtCs6QoFQ9M//FsrrkpG5rQ/4hT8E3snpXy45U1Cr8l1KGhy3KWgk3go4O3yZpT
 Ze1sW1DKlCIEkO97/rOT2OLr7y85pF5G9SeClsEWgDEayJwzZnk0TPija8HK3n3mswet7cf9Bov
 KVPDrmbrIzVAyc/7dVBo/H8vD0V/773EuIFdVPSArqqeQ57wxss5xH75x+ACDroydmadzbajGNa
 +GnGvB1RcMNlQFsG5Lg==
X-Proofpoint-ORIG-GUID: w4ZZMj4JDXCuARqXXvWkjibCvBAINRXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260149

MAX30210 ±0.1°C Accurate Ultra-Small Low-Power Digital Temperature Sensor

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 MAINTAINERS                        |   8 +
 drivers/iio/temperature/Kconfig    |  10 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max30210.c | 758 +++++++++++++++++++++++++++++
 4 files changed, 777 insertions(+)
 create mode 100644 drivers/iio/temperature/max30210.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c75276404df..2abdbcf3a8e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1638,6 +1638,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
 F:	drivers/iio/dac/max22007.c
 
+ANALOG DEVICES INC MAX30210 DRIVER
+M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
+F:	drivers/iio/temperature/max30210.c
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 9328b2250ace..2d7cb50e2538 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -184,4 +184,14 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+config MAX30210
+	tristate "MAX30210 Low-Power I2C Digital Temperature Sensor"
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
index 000000000000..aaa3a26be131
--- /dev/null
+++ b/drivers/iio/temperature/max30210.c
@@ -0,0 +1,758 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices MAX30210 I2C Temperature Sensor driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <asm/div64.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/interrupt.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/stat.h>
+#include <linux/string.h>
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
+#define MAX30210_A_FULL_MASK   BIT(7)
+#define MAX30210_TEMP_RDY_MASK BIT(6)
+#define MAX30210_TEMP_DEC_MASK BIT(5)
+#define MAX30210_TEMP_INC_MASK BIT(4)
+#define MAX30210_TEMP_LO_MASK  BIT(3)
+#define MAX30210_TEMP_HI_MASK  BIT(2)
+#define MAX30210_PWR_RDY_MASK  BIT(0)
+
+#define MAX30210_FLUSH_FIFO_MASK BIT(4)
+
+#define MAX30210_EXT_CNV_EN_MASK	BIT(7)
+#define MAX30210_EXT_CVT_ICFG_MASK	BIT(6)
+#define MAX30210_INT_FCFG_MASK		GENMASK(3, 2)
+#define MAX30210_INT_OCFG_MASK		GENMASK(1, 0)
+
+#define MAX30210_CHG_DET_EN_MASK	BIT(3)
+#define MAX30210_RATE_CHG_FILTER_MASK	GENMASK(2, 0)
+
+#define MAX30210_TEMP_PERIOD_MASK	GENMASK(3, 0)
+#define MAX30210_ALERT_MODE_MASK	BIT(7)
+
+#define MAX30210_AUTO_MASK	BIT(1)
+#define MAX30210_CONV_T_MASK	BIT(0)
+
+#define MAX30210_PART_ID		0x45
+#define MAX30210_FIFO_SIZE		64
+#define MAX30210_FIFO_INVAL_DATA	GENMASK(23, 0)
+#define MAX30210_WATERMARK_DEFAULT	(0x40 - 0x1F)
+
+#define MAX30210_INT_EN(state, mask)	((state) ? (mask) : 0x0)
+
+#define MAX30210_UNIQUE_ID_LEN		6
+#define MAX30210_EXT_CVT_FREQ_MIN	1
+#define MAX30210_EXT_CVT_FREQ_MAX	20
+
+struct max30210_state {
+	/*
+	 * Prevent simultaneous access to the i2c client.
+	 */
+	struct mutex lock;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct gpio_desc *powerdown_gpio;
+	u8 watermark;
+	u8 data[3 * MAX30210_FIFO_SIZE]  __aligned(IIO_DMA_MINALIGN);
+};
+
+static const int samp_freq_avail[] = {
+	0, 15625,
+	0, 31250,
+	0, 62500,
+	0, 125000,
+	0, 250000,
+	0, 500000,
+	1, 0,
+	2, 0,
+	4, 0,
+	8, 0
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
+	u8 uval[2] __aligned(IIO_DMA_MINALIGN);
+	int ret;
+
+	ret = regmap_bulk_read(regmap, reg, uval, 2);
+	if (ret)
+		return ret;
+
+	*temp = sign_extend32(get_unaligned_be16(uval), 15);
+
+	return IIO_VAL_INT;
+}
+
+static int max30210_write_temp(struct regmap *regmap, unsigned int reg,
+			       int temp)
+{
+	u8 uval[2] __aligned(IIO_DMA_MINALIGN);
+
+	put_unaligned_be16(temp, uval);
+
+	return regmap_bulk_write(regmap, reg, uval, 2);
+}
+
+static void max30210_fifo_read(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	u32 samp;
+	int ret, i, j;
+
+	ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
+			       st->data, 3 * st->watermark);
+	if (ret < 0)
+		return dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
+
+	for (i = 0; i < st->watermark; i++) {
+		samp = 0;
+
+		for (j = 0; j < 3; j++) {
+			samp <<= 8;
+			samp |= st->data[3 * i + j];
+		}
+
+		if (samp == MAX30210_FIFO_INVAL_DATA) {
+			dev_err(&indio_dev->dev, "Invalid data\n");
+			continue;
+		}
+
+		iio_push_to_buffers(indio_dev, &samp);
+	}
+}
+
+static irqreturn_t max30210_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int status;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Status byte read error\n");
+		goto exit_irq;
+	}
+
+	if (status & MAX30210_PWR_RDY_MASK) {
+		dev_info(&indio_dev->dev, "power-on\n");
+		st->watermark = MAX30210_WATERMARK_DEFAULT;
+	}
+
+	if (status & MAX30210_A_FULL_MASK)
+		max30210_fifo_read(indio_dev);
+
+	if (status & MAX30210_TEMP_HI_MASK)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+
+	if (status & MAX30210_TEMP_LO_MASK)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+
+exit_irq:
+	iio_trigger_notify_done(indio_dev->trig);
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
+static int max30210_validate_trigger(struct iio_dev *indio_dev,
+				     struct iio_trigger *trig)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+
+	if (st->trig != trig)
+		return -EINVAL;
+
+	return 0;
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
+	if (info == IIO_EV_INFO_VALUE) {
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			switch (type) {
+			case IIO_EV_TYPE_THRESH:
+				return max30210_read_temp(st->regmap,
+							  MAX30210_TEMP_ALM_HI_REG, val);
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (type) {
+			case IIO_EV_TYPE_THRESH:
+				return max30210_read_temp(st->regmap,
+							  MAX30210_TEMP_ALM_LO_REG, val);
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
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
+	if (info == IIO_EV_INFO_VALUE) {
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			switch (type) {
+			case IIO_EV_TYPE_THRESH:
+				return max30210_write_temp(st->regmap,
+							   MAX30210_TEMP_ALM_HI_REG, val);
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (type) {
+			case IIO_EV_TYPE_THRESH:
+				return max30210_write_temp(st->regmap,
+							   MAX30210_TEMP_ALM_LO_REG, val);
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
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
+			return FIELD_GET(MAX30210_TEMP_HI_MASK, val);
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			return FIELD_GET(MAX30210_TEMP_LO_MASK, val);
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir, int state)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	unsigned int val;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			val = MAX30210_INT_EN(state, MAX30210_TEMP_HI_MASK);
+
+			return regmap_update_bits(st->regmap,
+						  MAX30210_INT_EN_REG,
+						  MAX30210_TEMP_HI_MASK, val);
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_DIR_FALLING:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH:
+			val = MAX30210_INT_EN(state, MAX30210_TEMP_LO_MASK);
+
+			return regmap_update_bits(st->regmap,
+						  MAX30210_INT_EN_REG,
+						  MAX30210_TEMP_LO_MASK, val);
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
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
+		if (ret)
+			return ret;
+
+		uval = FIELD_GET(MAX30210_TEMP_PERIOD_MASK, uval);
+
+		*val = 8;
+
+		/**
+		 * register values 0x9 or above have the same sample
+		 * rate of 8Hz
+		 */
+		*val2 = uval >= 0x9 ? 1 : BIT(0x9 - uval);
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+				   MAX30210_CONV_T_MASK);
+		if (ret)
+			goto release_dmode;
+
+		fsleep(8000);
+
+		ret = max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
+
+release_dmode:
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
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
+		*vals = samp_freq_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(samp_freq_avail);
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
+	u64 data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		/**
+		 * micro_value = val * 1000000 + val2
+		 * reg_value = ((micro_value * 64) / 1000000) - 1
+		 */
+		data = (val * MICRO + val2) << 6;
+		do_div(data, MICRO);
+
+		data = fls_long(data - 1);
+		data = FIELD_PREP(MAX30210_TEMP_PERIOD_MASK, data);
+
+		ret = regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
+					 MAX30210_TEMP_PERIOD_MASK,
+					 (unsigned int)data);
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max30210_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_trigger_ops max30210_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
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
+	NULL,
+};
+
+static int max30210_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
+				 MAX30210_A_FULL_MASK, MAX30210_A_FULL_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+				 MAX30210_FLUSH_FIFO_MASK,
+				 MAX30210_FLUSH_FIFO_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
+			   MAX30210_AUTO_MASK | MAX30210_CONV_T_MASK);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct max30210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
+				 MAX30210_A_FULL_MASK, 0x0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
+				 MAX30210_FLUSH_FIFO_MASK,
+				 MAX30210_FLUSH_FIFO_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
+	if (ret)
+		return ret;
+
+	return 0;
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
+	.write_raw_get_fmt = max30210_write_raw_get_fmt,
+	.hwfifo_set_watermark = max30210_set_watermark,
+	.debugfs_reg_access = &max30210_reg_access,
+	.validate_trigger = &max30210_validate_trigger,
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
+	.output = 0,
+	.scan_index = 0,
+	.event_spec = max30210_events,
+	.num_event_specs = ARRAY_SIZE(max30210_events),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+};
+
+static int max30210_setup(struct max30210_state *st, struct device *dev)
+{
+	unsigned int val;
+
+	/* Power down to reset device */
+	st->powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(st->powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->powerdown_gpio),
+				     "Failed to request powerdown GPIO.\n");
+
+	/* Power up device */
+	gpiod_set_value(st->powerdown_gpio, 0);
+
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
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
+						  max30210_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &max30210_buffer_ops,
+						  max30210_fifo_attributes);
+	if (ret < 0)
+		return ret;
+
+	if (client->irq) {
+		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return -ENOMEM;
+
+		st->trig->ops = &max30210_trigger_ops;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, st->trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = st->trig;
+		ret = devm_request_threaded_irq(dev, client->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL, IRQF_TRIGGER_FALLING,
+						indio_dev->name, st->trig);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct i2c_device_id max30210_id[] = {
+	{ "max30210", 0 },
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

