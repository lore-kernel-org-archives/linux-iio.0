Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893E2E7363;
	Wed, 17 Jun 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661883; cv=none; b=TwmFPzyuY5t9jBNAE0yPNPz0GXjFOFLkJt0MSItZqb2wNOsjyWvac2otRjOnkb+A7hRa+tuhafDoKa69Gs/a3lAEpY3m2AJ2KuQmwX5eS5jk3yxXgV3dvZk5F6egCPhIXSx34A8llvdQBdZkEcGhG1EYII0vzruneIJjFtlHqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661883; c=relaxed/simple;
	bh=k9tMFRw0NReHYdwrlFkEFBCI9fT9X7g406/5x21Dx8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqHj8oTXr14VxMMMZxPrF1vi97mIVqfiXXkt/QAUrlarhd7+2dmpOLD29jW5OXjn2JVrGfFxjKdwG+grbqoUFueiRWERNSVXS4HCk/qdDE2yr3HqOJeyzjXrS2HwS6B4ZVeMuHxoQr5/C3L2jPD4Bdo9tr92mpcSDrpZonnmfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FTqRulK4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FTqRulK4"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLWmcE868546;
	Tue, 16 Jun 2026 22:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F/tVO
	vQDqDOCHvuleOi0YljzHBdUmBPMzvaQSN0Tx3s=; b=FTqRulK4u133G8fo7Z07B
	WN2evYJ2hIU55BZg8G0tQlaziq0XovxM3vjzQXbT3RYx2m9+njhsuCFKQoZPDKOa
	+2Y1KwXtxS/plgWgbcbU2YnHRpUpt3e1Scpf4wtrCokHuQI+xgiUav86J+PW+T3w
	hP9LrHZse3VijpCJALPXBhRrs71lWOIe+ui+B09h7SVfV0ZuUcxY28vaM08vEAXb
	X2H1l0+fhCXS0WrinQmuRMMN0CeslC9pyOWT1O0EIYki7XKVbF0q/kZE1zNuI5dF
	L40ZCeX/VlxuJZH3CbBbFmiAReOnGunYjjQW3iz5D/LepTXClRPbWj8Hma8NNdMr
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4euegf0rps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 22:04:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65H24awX014091
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 22:04:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 16 Jun
 2026 22:04:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 16 Jun 2026 22:04:36 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65H24PZt006750;
	Tue, 16 Jun 2026 22:04:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 4/5] iio: adc: ltc2378: Enable high-speed data capture
Date: Tue, 16 Jun 2026 23:04:20 -0300
Message-ID: <9f173c47928446aa3e900cf0becb6130dd76846b.1781661028.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SaHHsPRu c=1 sm=1 tr=0 ts=6a3200b6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=I7Ct1wI2BZskGqBcPl8A:9
X-Proofpoint-GUID: _zj4BpYz6Id94jMSZ0mv6ygf7ij_RoUT
X-Proofpoint-ORIG-GUID: _zj4BpYz6Id94jMSZ0mv6ygf7ij_RoUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX3EZbHL7nDLTt
 WTobsdp8Sq6O7ke/tImJs3/bu7tsIJ7Z1ThqtJesuPnYkcFupFDKebYpQqZvDpXMHi8UOkp6KNC
 PVxNxqUV7v4pbKJs5CY+3HsXwzW8r6bpTCE5mLB5dTK1KJc90e7I16WBFLFmcVxq33UmkG/wi/D
 yMNZRhds/Qz2PNnh79g7HtHLpPEPFkDEommQxqFl5YEm448hel0qmbrs8Xc/w996uvrNFhFmoLd
 n1S6EfIJX9m4vRFc4/I2rVHVlWl8AXHiDluN0mkrpWgoN6vLLwVqRCcP6ZjxV0xkyy9QRGAh0Nm
 Qv10zKlZBTo5rLIDyxDb0J+0tT0QqjNw4OxLcalc6NSLN5E8m1kjX468SGen/+GnzZWngIg6gy7
 CSs/X7dL+u4vY0Y0lrBnCjkd7+ioNUYK87zpyr4mgz+59nYRr5oEWe2JHJfxEUyE8//8/H0gjA1
 8fO6GmoUEQ2bQRvbPpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX1pj4TTB+oxB7
 xgSx7OXyfN9F8IfnWF6vfRK61hbhQ5maLZL5gRi15pY18hUv3RrD+tM35JoQEyHYjUtieU7VsVo
 4y4eGJ/Pps8byXBw8kL8JkpNnrbhJzj5S3OjnGErJh8FNMMNtEIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170017

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 2 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Fixed the evaluation loop conditions for CNV PWM and SPI Engine trigger PWM,
  avoiding potential infinite loop if and CPU stall.
- Added comment to about initial PWM disable.
- Adjusted SPI offload setup initialization to not print error on a valid condition.
- Fully initialize IIO channel scan_type.
- Reworked to make offload support not imply all dependencies to be built in.
- Made sampling_frequency a buffer attribute.
- Made offload support not require DMA and other features to be built in.
- Now using same scan_type configuration for all use cases.

 drivers/iio/adc/Kconfig                  |  19 ++
 drivers/iio/adc/Makefile                 |   6 +
 drivers/iio/adc/ltc2378-lib-core.c       |  35 +++
 drivers/iio/adc/ltc2378-offload-buffer.c | 305 +++++++++++++++++++++++
 drivers/iio/adc/ltc2378.c                |  46 ++++
 drivers/iio/adc/ltc2378.h                |  42 ++++
 6 files changed, 453 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2378-lib-core.c
 create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 2b8203451367..f96d9262b891 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -944,6 +944,9 @@ config LTC2378
 	tristate "Analog Devices LTC2378 ADC driver"
 	depends on SPI
 	depends on GPIOLIB
+	select LTC2378_LIB
+	select LTC2378_LIB_OFFLOAD_BUFFER if SPI_OFFLOAD && PWM && SPI_OFFLOAD_TRIGGER_PWM && IIO_BUFFER && IIO_BUFFER_DMAENGINE
+	select LTC2378_LIB_TRIGGERED_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
 	  similar analog to digital converters.
@@ -2027,3 +2030,19 @@ config XILINX_AMS
 	  xilinx-ams.
 
 endmenu
+
+config LTC2378_LIB
+	tristate
+	help
+	  Say yes here to build support for buffered data capture with LTC2378
+
+config LTC2378_LIB_OFFLOAD_BUFFER
+	bool
+	help
+	  Say yes here to build support for high speed data capture with LTC2378
+
+config LTC2378_LIB_TRIGGERED_BUFFER
+	bool
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for buffered data capture with LTC2378
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1814fb78dde3..109cd39237c9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -82,6 +82,12 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
 obj-$(CONFIG_LTC2378) += ltc2378.o
+
+ltc2378_lib-y += ltc2378-lib-core.o
+ltc2378_lib-$(CONFIG_LTC2378_LIB_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o
+ltc2378_lib-$(CONFIG_LTC2378_LIB_TRIGGERED_BUFFER) += ltc2378-triggered-buffer.o
+obj-$(CONFIG_LTC2378_LIB) += ltc2378_lib.o
+
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2378-lib-core.c b/drivers/iio/adc/ltc2378-lib-core.c
new file mode 100644
index 000000000000..1160f4324d01
--- /dev/null
+++ b/drivers/iio/adc/ltc2378-lib-core.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices LTC2378 ADC series driver
+ *
+ * Copyright (C) 2026 Analog Devices Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+
+#include "ltc2378.h"
+
+int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = __ltc2378_set_offload_ops(st);
+	if (ret == -EOPNOTSUPP)
+		return 0; /* Let device setup complete without buffer support */
+
+	if (!ret)
+		ret = st->ops->buffer_setup(indio_dev, st);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_lib_buffer_setup, "IIO_LTC2378");
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ltc2378-offload-buffer.c b/drivers/iio/adc/ltc2378-offload-buffer.c
new file mode 100644
index 000000000000..3e8c7ab64a54
--- /dev/null
+++ b/drivers/iio/adc/ltc2378-offload-buffer.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/pwm.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
+#include <linux/time64.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+
+#include "ltc2378.h"
+
+/*
+ * SPI offload wiring schema
+ *
+ *     +-------------+         +-------------+
+ *     |         CNV |<-----+--| GPIO        |
+ *     |             |      +--| PWM0        |
+ *     |             |         |             |
+ *     |             |      +--| PWM1        |
+ *     |             |      |  +-------------+
+ *     |             |      +->| TRIGGER     |
+ *     |             |         |             |
+ *     |     ADC     |         |    SPI      |
+ *     |             |         | controller  |
+ *     |             |         |             |
+ *     |         SDI |<--------| SDO         |
+ *     |         SDO |-------->| SDI         |
+ *     |        SCLK |<--------| SCLK        |
+ *     +-------------+         +-------------+
+ *
+ */
+static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int freq_Hz)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	unsigned int min_read_offset, offload_period_ns;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = LTC2378_TCNV_HIGH_NS;
+	unsigned int count = 0;
+	u64 offload_offset_ns;
+	int ret;
+
+	if (freq_Hz == 0)
+		return -EINVAL;
+
+	if (freq_Hz < 1 || freq_Hz > st->info->max_sample_rate_hz)
+		return -ERANGE;
+
+	/* Configure CNV PWM waveform */
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
+
+	/*
+	 * Ensure CNV high time meets minimum requirement (20ns). The PWM
+	 * hardware may round the duty cycle, so iterate until we get at least
+	 * the minimum required high time.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += 10;  /* Increment by PWM duty cycle period */
+	} while (count++ < 100 && cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS);
+
+	/* Double check the minimum CNV high time is met */
+	if (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS)
+		return -EIO;
+
+	/*
+	 * Configure SPI offload PWM trigger.
+	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
+	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
+	 *
+	 * Use the same period as CNV PWM to avoid timing issues.
+	 * Convert back from period to frequency for the SPI offload API.
+	 */
+	offload_period_ns = cnv_wf.period_length_ns;
+	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
+	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
+	offload_offset_ns = min_read_offset;
+	count = 0;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += 10;
+	} while (count++ < 100 && config->periodic.offset_ns < min_read_offset);
+
+	st->cnv_wf = cnv_wf;
+	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
+
+	return 0;
+}
+
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct ltc2378_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%u\n", st->cnv_Hz);
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = ltc2378_update_conversion_rate(st, val);
+
+	return ret ?: len;
+}
+
+static ssize_t sampling_frequency_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "[%u %u %u]\n",
+			  1, 1, st->info->max_sample_rate_hz);
+}
+
+static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
+static IIO_DEVICE_ATTR(sampling_frequency, 0644,
+		       sampling_frequency_show, sampling_frequency_store, 0);
+
+static const struct iio_dev_attr *ltc2378_offload_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency_available,
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
+static int ltc2378_prepare_offload_message(struct device *dev,
+					   struct ltc2378_state *st)
+{
+	st->offload_xfer.bits_per_word = st->info->resolution;
+	st->offload_xfer.len = st->info->resolution > 16 ? 4 : 2;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	/* Initialize message with offload */
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(dev, st->spi, &st->offload_msg);
+}
+
+static int ltc2378_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		return ret;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+	return ret;
+}
+
+static int ltc2378_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ltc2378_offload_buffer_ops = {
+	.postenable = &ltc2378_offload_buffer_postenable,
+	.predisable = &ltc2378_offload_buffer_predisable,
+};
+
+static int ltc2378_spi_offload_setup(struct iio_dev *indio_dev,
+				     struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ltc2378_offload_buffer_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN,
+							   ltc2378_offload_buffer_attrs);
+}
+
+static int ltc2378_pwm_get(struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "failed to get cnv pwm\n");
+
+	/*
+	 * Disable the PWM connected to CNV in case it was left running by
+	 * something else.
+	 */
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct spi_offload_config ltc2378_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev,
+					struct ltc2378_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	st->offload = devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret)
+		return ret;
+
+	ret = ltc2378_spi_offload_setup(indio_dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to setup SPI offload\n");
+
+	ret = ltc2378_pwm_get(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start with a slower sampling rate so there is some room for
+	 * adjusting the sampling frequency without hitting the maximum
+	 * conversion rate.
+	 */
+	ret = ltc2378_update_conversion_rate(st, st->info->max_sample_rate_hz >> 4);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to sampling frequency\n");
+
+	ret = ltc2378_prepare_offload_message(&spi->dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
+
+	return 0;
+}
+
+static const struct ltc2378_ops ltc2378_offload_ops = {
+	.buffer_setup = ltc2378_offload_buffer_setup,
+};
+
+int ltc2378_set_offload_ops(struct ltc2378_state *st)
+{
+	st->ops = &ltc2378_offload_ops;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_set_offload_ops, "IIO_LTC2378");
+
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 88582bdcd6a6..bf17b202230b 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
@@ -26,120 +27,160 @@
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
 	.resolution = 16,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 	.bipolar = false,
 };
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
 	.resolution = 20,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
 	.resolution = 20,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
 	.resolution = 16,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
 	.resolution = 20,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 675,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 	.bipolar = true,
 };
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 	.bipolar = true,
 };
 
@@ -266,6 +307,10 @@ static int ltc2378_probe(struct spi_device *spi)
 	st->xfer.len = st->info->resolution > 16 ? 4 : 2;
 	st->xfer.bits_per_word = st->info->resolution;
 
+	ret = ltc2378_lib_buffer_setup(indio_dev, st);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = st->chans;
 	indio_dev->num_channels = st->num_iio_chans;
 
@@ -336,3 +381,4 @@ MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
index a3a69351de6c..f6e10f9a83e0 100644
--- a/drivers/iio/adc/ltc2378.h
+++ b/drivers/iio/adc/ltc2378.h
@@ -8,10 +8,14 @@
 #ifndef __DRIVERS_IIO_ADC_LTC2378_H__
 #define __DRIVERS_IIO_ADC_LTC2378_H__
 
+#include <linux/errno.h>
 #include <linux/iio/iio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/pwm.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -19,12 +23,24 @@
 #define LTC2378_TBUSYLH_NS		13
 #define LTC2378_TCNV_HIGH_NS		20
 
+struct ltc2378_state;
+
 struct ltc2378_chip_info {
 	const char *name;
 	int resolution;
+	unsigned int max_sample_rate_hz;
+	unsigned int tconv_ns;
 	bool bipolar;
 };
 
+/**
+ * struct ltc2378_ops: Setup specific procedures for ltc2378 devices.
+ * @ltc2378_buffer_setup: Custom buffer setup implementation.
+ */
+struct ltc2378_ops {
+	int (*buffer_setup)(struct iio_dev *indio_dev, struct ltc2378_state *st);
+};
+
 struct ltc2378_state {
 	const struct ltc2378_chip_info *info;
 	struct gpio_desc *cnv_gpio;
@@ -33,6 +49,15 @@ struct ltc2378_state {
 	unsigned int num_iio_chans;
 	struct iio_chan_spec chans[2]; /* 1 physical chan + 1 timestamp chan */
 	int ref_uV;
+	const struct ltc2378_ops *ops;
+	unsigned int cnv_Hz;
+	struct pwm_waveform cnv_wf;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_message offload_msg;
+	struct spi_transfer offload_xfer;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -60,4 +85,21 @@ static inline int ltc2378_convert_and_acquire(struct ltc2378_state *st)
 	return ret;
 }
 
+int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st);
+
+#define __ltc2378_set_offload_ops(st) ltc2378_set_offload_ops((st))
+
+#ifdef CONFIG_LTC2378_LIB_OFFLOAD_BUFFER
+
+int ltc2378_set_offload_ops(struct ltc2378_state *st);
+
+#else
+
+static inline int ltc2378_set_offload_ops(struct ltc2378_state *st)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_LTC2378_LIB_OFFLOAD_BUFFER */
+
 #endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

