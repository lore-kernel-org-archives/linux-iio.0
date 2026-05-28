Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41129C33F;
	Thu, 28 May 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980704; cv=none; b=N3W6nvDxmZkyQYaZ1n9I2QzGf8bISEM849sKPpvs1adhJ8fsus16fjhkKB8mPNkmCIqE1MbJysb8eeCmd8Vh/4m56KybgnQOHhI3dUURSqViQEWkyDPyrQYeFPTrx7RMbovb28PFCv2o5ZFL4GwVl5Va84vzTrulYr9OwBGVZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980704; c=relaxed/simple;
	bh=1M4FAXhAbaPDOBqAeeoXHgYGcka1NGIHgrmoV2D72/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN4Fp/sboMMcVFk52GbcR1YfcFB6LO8XNlJMxltl1eIpP+7CPQfx6HnIteNZaaIf0JSLX/99NYSG0QIjKOCIuz/gMWDq2SAmVKIG69UsihU/8uLxAsZMRlfMLsOR3mjiYvfSXyQLAtt4GS86RkX/eHlJMZRIw1gUpyRKaY44VTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TcHAAMrU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TcHAAMrU"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SDZQFG400648;
	Thu, 28 May 2026 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iWaXR
	feFSr5hMgtYZRopXZvY8NbiSeZIc6ZoN8wG7XI=; b=TcHAAMrUB0eEb3k+kz+dO
	5V+f4itdeq9jAhZxgNMogosDcVqQhjkNnlp7SIeTwFU4y440x2H1+Dg/ULlOlzth
	RbtfB2Qap0WrGjlUtzFFIF5RblZKL6EoF6kPt9oXdcYLa4qE7pD2WoL1BX10x672
	t75YFhxT3W0l64IoH1M7I1OIYJMsCn59fzYvVSlM8fUCMKA3jeuwIjG+FexFTwZx
	jDsnCr61p16c8FhLPzLJcmSmfADKPHMfF53BsGGvUgfn6RqEbHcNU8HKNNwqN0Gh
	Vs6ISjYvQGHMhUTwleBhQK3o2bHzkr45NxMP19hbls0LibdfWT9+6tksunVZb1MJ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x1uage-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:04:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SF4TaD008909
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 11:04:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:04:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:04:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 28 May 2026 11:04:29 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64SF4HbO021411;
	Thu, 28 May 2026 11:04:20 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/4] iio: adc: ltc2378: Enable high-speed data capture
Date: Thu, 28 May 2026 12:04:12 -0300
Message-ID: <e04a432efb6536f93bbe7f410964aa877370de36.1779976379.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1779976379.git.marcelo.schmitt@analog.com>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MiBTYWx0ZWRfX3lmJCpyOHicm
 PS1mCqVJ9Yz8WaH+0dlCqNHuvw3N6mytGQqtnHVK79oMaZXYCokriwqZsgvsbnzAlWjR2hMzj8Q
 k/k2OGdsccObk9YcpVaDALPo1hdN5odRc/F0c5Itjgw+57cYM/o06N+t53zSM7EP6m54eN6xQAP
 9ql5HAhWTGTdLECD4sw1u9xGXyiQm5a/gLZGAlO2OuGgdJzFBuVOXwL+MHGUXVn7DWmVxElUW+T
 EBo9hIflQIprPrW9H9y9IYbYH4f1iyWi3a3HlL7YphZY/5vj9p63eyTagW1JZ860QpbbUcNsP+i
 zgNvFxEskEu7zzINZz1FLy8zcV0pshyJjPb8S4cSWH3Fp0Laww44S9ZjYVj4T/gyAsP+2Sw4TwH
 fe9TK6tgtbceVD46coffYNSs/8n32G9qvqnLofieNojVd71Y4qq06pdP65jYXC2TiajT0OwdMU6
 iZCS4By2Ut3ewA7UbkQ==
X-Authority-Analysis: v=2.4 cv=HMbz0Itv c=1 sm=1 tr=0 ts=6a18597e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=9H_XI321FAzbxM0tdFEA:9
X-Proofpoint-GUID: I8wUoDX798E917Dx1duTNjRwOVnWHjqk
X-Proofpoint-ORIG-GUID: I8wUoDX798E917Dx1duTNjRwOVnWHjqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280152

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 2 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Set loop count to prevent CPU stall when calculating PWM parameters.
- Hardcode set specific offload supported amount of data element bits.
- Fixed devm_spi_offload_get() error path.
- Initialize init scan_type according to buffer selection.
- Offload attributes now are channel based instead of device based.
- Wrapped comments close to 80 columns.

I haven't manage to code an is_visible() filter for device attributes specific
of offload usage.
Using DEFINE_SYSFS_GROUP_VISIBLE() didn't work out as the
sampling_frequency_available attribute would still appear even without offload.
Using DEFINE_SYSFS_GROUP_VISIBLE() and sysfs attribute specific visibility
function resulted in kernel error (Invalid permissions 01).
Instead, I made them channel shared by all attributes.

I tried a lib-like code arrangement like ADIS IMU but didn't manage to get it
to work. Separated the code into ltc2378.h, ltc2378.c (lib), ltc2378-core.c
(base driver), and ltc2378-offload.c with lib and core built as module and
offload.c builtin. Though, I ran into different build and linkage errors
depending on how ltc2378-offload.c utilities were encapsulated. Having read
through IMU ADIS code, I now think LTC2378 is different and doesn't require
a code design that much elaborated. Differently from the separate code for
supporting specific adis devices, all ltc2378-like devices can be supported
by the same set of functions from ltc2378.c. We can maybe have an ops struct
with pointers to buffer specific routines (e.g. offload vs triggered). That
might be worth it if we would want to switch between buffer types at runtime.
For v2, I'm keeping the module design similar to v1. I appreciate additional
examples if a module redesign is still recommended.

 drivers/iio/adc/Kconfig                  |   9 +
 drivers/iio/adc/Makefile                 |   1 +
 drivers/iio/adc/ltc2378-offload-buffer.c | 296 +++++++++++++++++++++++
 drivers/iio/adc/ltc2378.c                |  91 ++++++-
 drivers/iio/adc/ltc2378.h                |  66 +++++
 5 files changed, 457 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 70fec8e3e891..5f7038b5e731 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -944,6 +944,7 @@ config LTC2378
 	depends on SPI
 	depends on GPIOLIB || PWM
 	select IIO_BUFFER
+	select LTC2378_OFFLOAD_BUFFER if SPI_OFFLOAD && PWM && IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
 	  similar analog to digital converters.
@@ -2027,3 +2028,11 @@ config XILINX_AMS
 	  xilinx-ams.
 
 endmenu
+
+config LTC2378_OFFLOAD_BUFFER
+	bool
+	select SPI_OFFLOAD_TRIGGER_PWM
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
+	help
+	  Say yes here to build support for high speed data capture with LTC2378
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1814fb78dde3..2fa5dce0ceea 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
 obj-$(CONFIG_LTC2378) += ltc2378.o
+obj-$(CONFIG_LTC2378_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2378-offload-buffer.c b/drivers/iio/adc/ltc2378-offload-buffer.c
new file mode 100644
index 000000000000..8ad2d319f669
--- /dev/null
+++ b/drivers/iio/adc/ltc2378-offload-buffer.c
@@ -0,0 +1,296 @@
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
+	} while (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS || count++ < 100);
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
+	} while (config->periodic.offset_ns < min_read_offset || count++ < 100);
+
+	st->cnv_wf = cnv_wf;
+	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
+
+	return 0;
+}
+
+int ltc2378_get_sampling_frequency(struct ltc2378_state *st, int *val)
+{
+	*val = st->cnv_Hz;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_get_sampling_frequency, "IIO_LTC2378");
+
+int ltc2378_set_sampling_frequency(struct ltc2378_state *st, int freq_Hz)
+{
+	return ltc2378_update_conversion_rate(st, freq_Hz);
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_set_sampling_frequency, "IIO_LTC2378");
+
+int ltc2378_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		       const int **vals, int *type, int *length, long mask)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = st->sample_freq_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_read_avail, "IIO_LTC2378");
+
+int ltc2378_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		      int val, int val2, long mask)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (val < 1 || val > st->info->max_sample_rate_hz)
+			return -EINVAL;
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return ltc2378_set_sampling_frequency(st, val);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_write_raw, "IIO_LTC2378");
+
+static int ltc2378_prepare_offload_message(struct device *dev,
+					   struct ltc2378_state *st)
+{
+	st->offload_xfer.bits_per_word = st->info->resolution;
+	/*
+	 * Ideally, we would ask the offload provider what data word sizes are
+	 * supported so we could use smaller words for less precise ADCs.
+	 * Though, the currently available SPI offloading hardware only supports
+	 * pushing 32-bit sized data elements to DMA memory. Because of that,
+	 * we hardcode set 4 byte sized transfers.
+	 */
+	st->offload_xfer.len = 4;
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
+							   IIO_BUFFER_DIRECTION_IN);
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
+int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	st->offload = devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
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
+	st->sample_freq_range[0] = 1; /* min */
+	st->sample_freq_range[1] = 1; /* step */
+	st->sample_freq_range[2] = st->info->max_sample_rate_hz; /* max */
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
+EXPORT_SYMBOL_NS_GPL(ltc2378_offload_buffer_setup, "IIO_LTC2378");
+
+MODULE_IMPORT_NS("IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index bdff98157979..6b01d8e96cc6 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -27,36 +27,48 @@
 static const struct ltc2378_chip_info ltc2338_18_chip_info = {
 	.name = "ltc2338-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2364_18_chip_info = {
 	.name = "ltc2364-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2367_16_chip_info = {
 	.name = "ltc2367-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2367_18_chip_info = {
 	.name = "ltc2367-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 	.name = "ltc2368-16",
 	.resolution = 16,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.twos_comp = false,
 
 };
@@ -64,84 +76,112 @@ static const struct ltc2378_chip_info ltc2368_16_chip_info = {
 static const struct ltc2378_chip_info ltc2368_18_chip_info = {
 	.name = "ltc2368-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2369_18_chip_info = {
 	.name = "ltc2369-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2370_16_chip_info = {
 	.name = "ltc2370-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 	.twos_comp = false,
 };
 
 static const struct ltc2378_chip_info ltc2376_16_chip_info = {
 	.name = "ltc2376-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2376_18_chip_info = {
 	.name = "ltc2376-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2376_20_chip_info = {
 	.name = "ltc2376-20",
 	.resolution = 20,
+	.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+	.tconv_ns = 3000,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_16_chip_info = {
 	.name = "ltc2377-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_18_chip_info = {
 	.name = "ltc2377-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2377_20_chip_info = {
 	.name = "ltc2377-20",
 	.resolution = 20,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+	.tconv_ns = 1500,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_16_chip_info = {
 	.name = "ltc2378-16",
 	.resolution = 16,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_18_chip_info = {
 	.name = "ltc2378-18",
 	.resolution = 18,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 527,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2378_20_chip_info = {
 	.name = "ltc2378-20",
 	.resolution = 20,
+	.max_sample_rate_hz = HZ_PER_MHZ,
+	.tconv_ns = 675,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2379_18_chip_info = {
 	.name = "ltc2379-18",
 	.resolution = 18,
+	.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+	.tconv_ns = 412,
 	.twos_comp = true,
 };
 
 static const struct ltc2378_chip_info ltc2380_16_chip_info = {
 	.name = "ltc2380-16",
 	.resolution = 16,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+	.tconv_ns = 322,
 	.twos_comp = true,
 };
 
@@ -190,7 +230,7 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
@@ -200,7 +240,7 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
-
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->ref_uV / MILLI;
 		/*
@@ -216,6 +256,17 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = ltc2378_get_sampling_frequency(st, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -223,6 +274,8 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ltc2378_iio_info = {
 	.read_raw = &ltc2378_read_raw,
+	.write_raw = LTC2378_WRITE_RAW,
+	.read_avail = LTC2378_READ_AVAIL,
 };
 
 static int ltc2378_probe(struct spi_device *spi)
@@ -261,10 +314,35 @@ static int ltc2378_probe(struct spi_device *spi)
 	st->chans[0].type = IIO_VOLTAGE;
 	st->chans[0].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 					  BIT(IIO_CHAN_INFO_SCALE);
-	st->chans[0].scan_type.format = st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_INT :
-							      IIO_SCAN_FORMAT_UNSIGNED_INT;
-	st->chans[0].scan_type.realbits = st->info->resolution;
-	st->chans[0].scan_type.storagebits = st->info->resolution > 16 ? 32 : 16;
+
+	struct iio_scan_type ltc2378_scan;
+
+	ret = ltc2378_offload_buffer_setup(indio_dev, spi);
+	if (ret == -ENODEV) {
+		/* SPI offloading is unavailable. Fall back to triggered buffer. */
+		dev_dbg(dev, "triggered data capture not supported\n");
+		ltc2378_scan.format = st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_INT :
+							    IIO_SCAN_FORMAT_UNSIGNED_INT;
+		ltc2378_scan.realbits = st->info->resolution;
+		ltc2378_scan.storagebits = st->info->resolution > 16 ? 32 : 16;
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
+	} else {
+		/*
+		 * Currently, the available offload hardware + DMA configuration
+		 * only supports pushing 32-bit data elements to IIO buffers in
+		 * CPU endianness.
+		 */
+		st->chans[0].info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		st->chans[0].info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+
+		ltc2378_scan.format = st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_INT :
+							    IIO_SCAN_FORMAT_UNSIGNED_INT;
+		ltc2378_scan.realbits = st->info->resolution;
+		ltc2378_scan.storagebits = 32;
+	}
+
+	st->chans[0].scan_type = ltc2378_scan;
 
 	st->xfer.rx_buf = &st->scan.data;
 	st->xfer.len = BITS_TO_BYTES(st->chans[0].scan_type.storagebits);
@@ -340,3 +418,4 @@ MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
index 399e8f67cd0e..e79619c12ce9 100644
--- a/drivers/iio/adc/ltc2378.h
+++ b/drivers/iio/adc/ltc2378.h
@@ -9,7 +9,10 @@
 #define __DRIVERS_IIO_ADC_LTC2378_H__
 
 #include <linux/iio/iio.h>
+#include <linux/pwm.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -20,6 +23,8 @@
 struct ltc2378_chip_info {
 	const char *name;
 	int resolution;
+	unsigned int max_sample_rate_hz;
+	unsigned int tconv_ns;
 	bool twos_comp; /* Output code is 2's complement or straight binary */
 };
 
@@ -30,6 +35,15 @@ struct ltc2378_state {
 	struct spi_transfer xfer;
 	struct iio_chan_spec chans[2]; /* 1 physical chan + 1 timestamp chan */
 	int ref_uV;
+	unsigned int cnv_Hz;
+	struct pwm_waveform cnv_wf;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_message offload_msg;
+	struct spi_transfer offload_xfer;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	int sample_freq_range[3];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -44,4 +58,56 @@ struct ltc2378_state {
 	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+#define LTC2378_WRITE_RAW LTC2378_WRITE_RAW_PTR
+
+#define LTC2378_READ_AVAIL LTC2378_READ_AVAIL_PTR
+
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+
+int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi);
+
+int ltc2378_get_sampling_frequency(struct ltc2378_state *st, int *val);
+
+int ltc2378_set_sampling_frequency(struct ltc2378_state *st, int freq_Hz);
+
+int ltc2378_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		      int val, int val2, long mask);
+
+int ltc2378_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		       const int **vals, int *type, int *length, long mask);
+
+#define LTC2378_WRITE_RAW_PTR (&ltc2378_write_raw)
+
+#define LTC2378_READ_AVAIL_PTR (&ltc2378_read_avail)
+
+#else /* CONFIG_IIO_LTC2378_LIB_OFFLOAD_BUFFER */
+
+#define LTC2378_WRITE_RAW_PTR (NULL)
+
+#define LTC2378_READ_AVAIL_PTR (NULL)
+
+static inline int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev,
+					       struct spi_device *spi)
+{
+	return -ENODEV;
+}
+
+int ltc2378_get_sampling_frequency(struct ltc2378_state *st, int *val)
+{
+	return -EOPNOTSUPP;
+}
+
+int ltc2378_set_sampling_frequency(struct ltc2378_state *st, int freq_Hz);
+{
+	return -EOPNOTSUPP;
+}
+
+int ltc2378_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		      int val, int val2, long mask)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+
 #endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

