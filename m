Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34F153598;
	Wed,  4 Feb 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208413; cv=none; b=uPMj5c3S3F9ktrVtJM7UzMQIoP68RIzt6C+1UWrZIAl26RjpNxCEgoEO8dXSPXwP8pcrdgI3pveFwSg70npG8e5/ekf619OlWJ7us2mfrIxTKdfXZllgyRxAASY/N51LBeSkSJa2FQVcRiFD0bBfCjHGwKHJ75K8qjr2cz4EsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208413; c=relaxed/simple;
	bh=IgV/DU6YxXOg4vs7YlSibBcIh+madLf5wAWuPfG0pEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awGD02ySrncm+KeaKhqE2KDjrWUXuKTpv+0OCpNmw8sFbQLl6doPmDQielvQv2dV0l3JnWW9wkEBlxO80TOVVZ9aaVZBJ1pXAsigeVZcUFrsw85LVi/LtwhecmKsEgd0x3PoIRxVSE1cQeUGqBNSdFNiNsZOLhl1olFRjJEttes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ShDLRpc3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ShDLRpc3"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6147ZTqG2906777;
	Wed, 4 Feb 2026 07:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LaCR1
	Oiz99cnCqbhnowostw8uBxcemc9MVjMJiyJXEQ=; b=ShDLRpc3aCPkjXUDMV5/u
	A7nBroxYHg/q+rDo8J4CTq+v/LMoDnmRWu+XpgUGSfV09QU/EgkUt1vOKgNLdhKX
	/rFeKUtVxXVo5fB+vpU1Ktw9v3bj9tZLqZZXthT8RtbWI6Y1dQFJ+vsduOPXV302
	fcxcUXV/L10B386hpMM4ZTSBi+cM8TK63lODAHMdv5vIiaTmqj/0GV4wCyrSuJ78
	IPIduBjvgBnmLZisHjuO31sxATdhH1GQO+2bVDlOb7rh5cpJdjBfTCCR3Edsjehs
	Tu8+YmLTMZu3EsT4h38lenxZrfNVvlS2b6CecGabuIqzXHCL7sbi+PFIxorK9ODf
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vxva474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 07:33:18 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 614CXHe5055447
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Feb 2026 07:33:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Feb
 2026 07:33:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Feb 2026 07:33:17 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 614CX71i007401;
	Wed, 4 Feb 2026 07:33:09 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
Date: Sat, 31 Jan 2026 22:35:39 -0300
Message-ID: <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769889074.git.Jonathan.Santos@analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 7dfl1rKuLqWrCuMZANxwSvcDtvCnrHl6
X-Proofpoint-ORIG-GUID: 7dfl1rKuLqWrCuMZANxwSvcDtvCnrHl6
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=69833c8e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=XwM87tFdlOxRk03B94YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5NCBTYWx0ZWRfXyIxoRfy9wT5V
 WQZzFEgr9ue7+7gz37DZZiA8LSmOec2OJNJjkqyGgimzGdsr3+bAT9QuEeYQTu+0WAVObvoX0cs
 HJ5B8M9mFs0LuJOUJSoi1n7Rcw3TbiDsUofIxbVKb28apafRKnGe6jqfVfVMqZYgf0dQNqUhnyZ
 DRwdADGP7+gwJSuQMpXWHsVVOchS9xuLCEp3/NMcafDiWVFZddfszbM3YQS0YxFJpRTeQZXoyrZ
 tvw8q/ixsKy/EdluYJjfCgNu8amDOMV6xyHHvlqVpUR0TwZ2lgPkh3mi4Hrko5yXgYVeK5Ife7x
 smPLk3y+aH/sfsJksz9kqmXF/ut/SowHlYZR6QG9KYihcuB848Pb1UlEJm3+CZWiMa+pDjhROq+
 18jOfbgyqTYYuDNZXHWBeAzH/ZdJcUyN4JCGqL0WybLUItjF/zJgfRnj1PDjoxvLRFWj2X9dR6G
 ez/arfytCuyOKd96SMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040094

The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
the capabilities of conventional triggered buffer operations due to SPI
transaction overhead and interrupt latency.

Add SPI offload support to enable hardware-accelerated data acquisition
that bypasses software SPI transactions using continuous data streaming.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/Kconfig    |   2 +
 drivers/iio/adc/ad7768-1.c | 187 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..a1c3226c3631 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -413,8 +413,10 @@ config AD7768_1
 	select REGMAP_SPI
 	select RATIONAL
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD
 	help
 	  Say yes here to build support for Analog Devices AD7768-1 SPI
 	  simultaneously sampling sigma-delta analog to digital converter (ADC).
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 374614ea97ac..fc497fb639d0 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -25,12 +25,15 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/sysfs.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/spi/spi.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 #include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -161,6 +164,8 @@ enum ad7768_filter_regval {
 enum ad7768_scan_type {
 	AD7768_SCAN_TYPE_NORMAL,
 	AD7768_SCAN_TYPE_HIGH_SPEED,
+	AD7768_SCAN_TYPE_OFFLOAD_NORMAL,
+	AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED,
 };
 
 enum {
@@ -266,6 +271,18 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 		.storagebits = 16,
 		.endianness = IIO_BE,
 	},
+	[AD7768_SCAN_TYPE_OFFLOAD_NORMAL] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
 };
 
 struct ad7768_chip_info {
@@ -283,6 +300,8 @@ struct ad7768_chip_info {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
 	struct regmap *regmap;
 	struct regmap *regmap24;
 	int vref_uv;
@@ -306,8 +325,11 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
 	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
+	bool offload_en;
 	struct mutex pga_lock; /* protect device internal state (PGA) */
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -1139,6 +1161,10 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
+	if (st->offload_en)
+		return st->oversampling_ratio == 8 ?
+			AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED : AD7768_SCAN_TYPE_OFFLOAD_NORMAL;
+
 	return st->oversampling_ratio == 8 ?
 	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
 }
@@ -1320,7 +1346,7 @@ static irqreturn_t ad7768_interrupt(int irq, void *dev_id)
 	struct iio_dev *indio_dev = dev_id;
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	if (iio_buffer_enabled(indio_dev))
+	if (iio_buffer_enabled(indio_dev) && !st->offload_en)
 		iio_trigger_poll(st->trig);
 	else
 		complete(&st->completion);
@@ -1357,6 +1383,72 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 	.predisable = &ad7768_buffer_predisable,
 };
 
+static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	const struct iio_scan_type *scan_type;
+	int ret;
+
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(scan_type->realbits));
+	st->offload_xfer.bits_per_word = scan_type->realbits;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	/*
+	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
+	 * continuous read mode. Subsequent data reads do not require an
+	 * initial 8-bit write to query the ADC_DATA register.
+	 */
+	ret =  regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
+	if (ret)
+		return ret;
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret) {
+		dev_err(&st->spi->dev, "failed to prepare offload, err: %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_offload_trigger_enable(st->offload,
+					 st->offload_trigger,
+					 &config);
+	if (ret) {
+		spi_unoptimize_message(&st->offload_msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad7768_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int unused;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
+	/*
+	 * To exit continuous read mode, perform a single read of the ADC_DATA
+	 * reg (0x2C), which allows further configuration of the device.
+	 */
+	return regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &unused);
+}
+
+static const struct iio_buffer_setup_ops ad7768_offload_buffer_ops = {
+	.postenable = ad7768_offload_buffer_postenable,
+	.predisable = ad7768_offload_buffer_predisable,
+};
+
 static const struct iio_trigger_ops ad7768_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
@@ -1591,6 +1683,36 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
 	return 0;
 }
 
+static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	/* Requires 1 arg to indicate the trigger output signal */
+	if (nargs != 1 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
+		return false;
+
+	return true;
+}
+
+static int ad7768_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	/* Should already be validated by match, but just in case. */
+	if (nargs != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct spi_offload_trigger_ops ad7768_offload_trigger_ops = {
+	.match = ad7768_offload_trigger_match,
+	.request = ad7768_offload_trigger_request,
+};
+
 static const struct ad7768_chip_info ad7768_chip_info = {
 	.name = "ad7768-1",
 	.channel_spec = ad7768_channels,
@@ -1628,6 +1750,51 @@ static const struct ad7768_chip_info adaq7769_chip_info = {
 	.has_variable_aaf = true,
 };
 
+static const struct spi_offload_config ad7768_spi_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static int ad7768_spi_offload_probe(struct iio_dev *indio_dev,
+				    struct ad7768_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct spi_offload_trigger_info trigger_info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &ad7768_offload_trigger_ops,
+		.priv = st,
+	};
+	struct dma_chan *rx_dma;
+	int ret;
+
+	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register offload trigger\n");
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+		SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+		rx_dma, IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to setup offload RX DMA\n");
+
+	indio_dev->setup_ops = &ad7768_offload_buffer_ops;
+	st->offload_en = true;
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -1727,9 +1894,21 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7768_triggered_buffer_alloc(indio_dev);
-	if (ret)
-		return ret;
+	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad7768_spi_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get SPI offload\n");
+
+	/* If not using SPI offload, fall back to low speed usage. */
+	if (ret == -ENODEV) {
+		ret = ad7768_triggered_buffer_alloc(indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad7768_spi_offload_probe(indio_dev, st);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.34.1

