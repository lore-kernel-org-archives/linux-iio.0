Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54034EF05;
	Mon, 23 Feb 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848030; cv=none; b=K33tqrpxe4JHZnDax5RIe8QtzzunWvzvcPKoegViGFoVaPHfcAuzocSEngdrS53px1fBxIUL//yQsXTqanAwhO/TKLUjeGMw58pDhQ0Y8EZYg2ZbPupjlYoVV5RM9OjfX5xDVgRtXdEZyIMlVlCujjdJahkCZXFJl1YCGpsPGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848030; c=relaxed/simple;
	bh=2R2xy/w74RwHiUGGRRo01Q25jBxIUgz/3hIUSjS4/xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBvw2d98O+tJTh2V9JemwqWJp9/Z/2vyYNFMPT+4K4U31T8WsW/ePR5eyVFbJAbrTvVGyl6EnnAFR4zPVSDxGw2j2YIz1Fw+z4QGG2m25+2f+2wrQosBmrexZsX8kOFp21zBLdfp3lgzhicffwsMkMN0i4WWDkDHucz9Ku/YRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=o73Ysatr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="o73Ysatr"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6geR02668062;
	Mon, 23 Feb 2026 07:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y32PL
	KqeQmyMwEuOCod+DtSJnzdaYxFB1d7IUXoV3ew=; b=o73Ysatr+irem/2unT89Q
	bftrMhP2fKWBzyPFIg2JRZ7ViGudhoGeb2ItSmXMsUhGqA8fOrBYsmh/fHfSrqHM
	ILlPtsJlsekqxk2TiwAFr+vqhj8No5mN8WZ0mS8O3hwemQ30pLR0QSoxeuB+b24D
	c7JmPvmLtwhsV3km77pTLi43+KPjYR0xKazPABcBQvc7UO/jgGHx38pscQ00gKh6
	opyqC6MLpO+xdKJ03bp6B7MFHhpPXrcSo2OHGJl/MyzRj6UA5EbBVMjaxuSHAeNC
	1oT91113IAKodPPFdxphmkORfxEF5syJx4odQJ7MFq1/rrDXQWaC2Beyiz4nKtQb
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbatnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 07:00:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NC0BwJ001055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 07:00:11 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 07:00:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 07:00:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 07:00:10 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NBxuAF017992;
	Mon, 23 Feb 2026 06:59:58 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v2 4/4] iio: adc: ad7768-1: add support for SPI offload
Date: Mon, 23 Feb 2026 08:59:53 -0300
Message-ID: <79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771362939.git.Jonathan.Santos@analog.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: eFunLOcZ0Qba69BsA-p9XoEZYP7iivhN
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c414c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=tgav_aEpjPthpoIVNhMA:9
X-Proofpoint-ORIG-GUID: eFunLOcZ0Qba69BsA-p9XoEZYP7iivhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfXz7K0hqj2aYkY
 c6NH9i9aFLXbxs0pW2d55s2EW7E6euteA5RK8sl6w2sXloYQUBtCSSe4YsGLmIbCxKfWtpEvlHc
 t29Kg9DFio63jD4PN9fnow5gNsb6CM0BX7oyW5VQn3LNp3nCKpdAOkrLUkgTpU3PDy5a3BmzEs3
 XkUe/U/BYbR3u+8RGgZixJMzR3I8TeUyRw7GOtJJNPd0irD5dRvFDqggOitIYUg79H1DY7QUaBT
 rs7BSZAjbIBGwegc+vUnQvTRPr+ocQY1W2Jp+c8iPgSG8ATNi3O3CeVDTjiIV0B5EMq5tDMsGRv
 B0hjuGExcpa5epCQxSoB1DaOKL2yfRUAXu69m0S5TdfakpGOxlPFSQHgWenE8tDln8XlShaEPAx
 ZN+PW/ZtE3rHpc4R8CratRj4GKOQDnnM7WqB+uO3iRfFNGdy636VfoFLHb+svjnv60jzQQ83rbY
 pmLXTLnH+Gl77FfKyzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230102

The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
the capabilities of conventional triggered buffer operations due to SPI
transaction overhead and interrupt latency.

Add SPI offload support to enable hardware-accelerated data acquisition
that bypasses software SPI transactions using continuous data streaming.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* Removed offload_en element in ad7768_state.
* Refactored ad7768_offload_buffer_postenable() to undo continuous read 
  mode in case something fails afterwards.
* Allow 1 or 2 arguments in the offload trigger, instead of only 1.
* Fixed indentation issues suggested by the Andy.
* Import IIO_DMAENGINE_BUFFER namespace (Reported by kernel test robot).
* Fixed error pointer reported in https://lore.kernel.org/all/202602051234.5gArzLyZ-lkp@intel.com/
  It was supposed to return ret instead of the rx_dma pointer.
---
 drivers/iio/adc/Kconfig    |   2 +
 drivers/iio/adc/ad7768-1.c | 186 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 185 insertions(+), 3 deletions(-)

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
index b77523393a18..da8b0bbeaec9 100644
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
@@ -306,6 +325,8 @@ struct ad7768_state {
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
 	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
 	struct mutex pga_lock; /* protect device internal state (PGA) */
@@ -1119,6 +1140,10 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
+	if (st->offload)
+		return st->oversampling_ratio == 8 ?
+		       AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED : AD7768_SCAN_TYPE_OFFLOAD_NORMAL;
+
 	return st->oversampling_ratio == 8 ?
 	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
 }
@@ -1341,6 +1366,78 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 	.predisable = &ad7768_buffer_predisable,
 };
 
+static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	const struct iio_scan_type *scan_type;
+	unsigned int unused;
+	int ret;
+
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits);
+	st->offload_xfer.bits_per_word = scan_type->realbits;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
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
+	/*
+	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
+	 * continuous read mode. Subsequent data reads do not require an
+	 * initial 8-bit write to query the ADC_DATA register.
+	 */
+	ret =  regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
+	if (ret)
+		goto err_unoptimize_message;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+	if (ret)
+		goto err_exit_continuous_read_mode;
+
+	return 0;
+
+err_exit_continuous_read_mode:
+	regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &unused);
+
+err_unoptimize_message:
+	spi_unoptimize_message(&st->offload_msg);
+
+	return ret;
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
 static int ad7768_set_trigger_state(struct iio_trigger *trig, bool enable)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -1589,6 +1686,36 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
 	return 0;
 }
 
+static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	/* Requires 1 or 2 args to indicate the trigger output signal */
+	if (nargs == 0 || nargs > 2 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
+		return false;
+
+	return true;
+}
+
+static int ad7768_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	/* Should already be validated by match, but just in case */
+	if (nargs == 0 || nargs > 2)
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
@@ -1626,10 +1753,51 @@ static const struct ad7768_chip_info adaq7769_chip_info = {
 	.has_variable_aaf = true,
 };
 
+static const struct spi_offload_config ad7768_spi_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER | SPI_OFFLOAD_CAP_RX_STREAM_DMA,
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
+		return dev_err_probe(dev, ret,  "failed to register offload trigger\n");
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							  IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup offload RX DMA\n");
+
+	indio_dev->setup_ops = &ad7768_offload_buffer_ops;
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
 	struct iio_dev *indio_dev;
+	struct device *dev = &spi->dev;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -1725,9 +1893,20 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7768_triggered_buffer_alloc(indio_dev);
-	if (ret)
-		return ret;
+	st->offload = devm_spi_offload_get(dev, spi, &ad7768_spi_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret == -ENODEV) {
+		/* If not using SPI offload, fall back to low speed usage */
+		ret = ad7768_triggered_buffer_alloc(indio_dev);
+		if (ret)
+			return ret;
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
+	} else {
+		ret = ad7768_spi_offload_probe(indio_dev, st);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
@@ -1763,3 +1942,4 @@ module_spi_driver(ad7768_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7768-1 ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.34.1

