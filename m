Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593E36EA83;
	Mon,  2 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454376; cv=none; b=qXGLOvJA/THUezTCs5bm2+4/3LZiudklLlVHcRxLRebiYD7h8+beTV04Rh0hafY3cRrrBXH/yNL2cV+QRB1irA/uTKpceH0bWnl82xvrb4ahRgw64XS2mkcFuXgBUfkLm0hZIaFTLIMGYKMvpxWX8FZ16elKKaFW1OSnThTvzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454376; c=relaxed/simple;
	bh=c+d+vqYk/ftKHZbMyWTI+oGv8VJCvcFuuIWiXDDFIN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnMPCwiFmHqlF/6DV3HKl5Fy2WvqHD0Q+jM9vn9ZAjyy1QNVZsQNcTghdQ0wcyc8Ih0uAn/l5jPPkWlq7t5uRkMVjLmEb+Da20LaV4O88ao79YDsiaoRwgU11WJHDEaq8XKiqL1FFotWvrF8jo4UxrHHe2kRAHvVsE6KpdtQxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m77OlI0U; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m77OlI0U"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227GBBr3409422;
	Mon, 2 Mar 2026 07:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IiGvh
	YCJUw2BPr2PO5TkmuRiPzUyC9uHodcU6/KwZd0=; b=m77OlI0Uuj+jFs19QXpaH
	Y9XBZG6CU7wxdWANnsXkYTB6OADkcgtJSlLfrlSofBLAbfQcGKTLGg11fmCxsqXD
	L3DVbsoljnjAI+5gDuUB0LS9rVJo+cNUlfMaBHlXhl13uEmpCgc1MXLhgdQkq1Nh
	iINQt3kL7cGGFjZGga/U5e/2wgJuJQfQ7YcPQInBpb3i6iGU36EP0zV3TVBFfeW+
	yf/bpwB28YpmqfSa8DozPB/kQkxi9PLVfCmcWDqdP0umaIHiYYW0MuIi294/WDzo
	fp2wSdMh5ONZm1Qw82y6tRn2UMoNCRkMduaiIHSXuqHfZe4ZiCOejpomiXKZF3z5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cmfjcma9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:25:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CPtMT002663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:25:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Mar
 2026 07:25:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:25:55 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CPfwj010669;
	Mon, 2 Mar 2026 07:25:44 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <cosmin.tanislav@analog.com>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 3/3] iio: adc: ad4130: add new supported parts
Date: Sat, 28 Feb 2026 09:39:04 -0300
Message-ID: <1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1772078999.git.Jonathan.Santos@analog.com>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=adpsXBot c=1 sm=1 tr=0 ts=69a581d4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=EsEnk9AjGcqY5lGx4pYA:9
X-Proofpoint-GUID: AyGLvbMrS6Xt0bGZ6NWEXp0GsWyI7f5B
X-Proofpoint-ORIG-GUID: AyGLvbMrS6Xt0bGZ6NWEXp0GsWyI7f5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNCBTYWx0ZWRfX4YhWeveKk07e
 IoBRDQ7HDhCWh5UBUyM16Bt5ueZ+/qSxT1q21HiaPN12wkcn+/pEA+Xx3ipVu9f4F8CBW3MDPC4
 a8ApK6EV/oytL8zqePkHZOBWiCO7cuZqnWt+8VqpHpgAjl2VKnO1cg82xsAzejnvNdZsdpTqsXY
 yKS+0ZaSJW5ajNdXI9ozJzHugeGFRY+LaBhFBbmKxExcgDGbBkNHTkpuunfSjK+EMuk9yymRXog
 JoTZkf0OZQfMyLujieoPv+6lfooHXphz0zMqhgY3qXimOfXEq3rvya/+S96lqGK6kSWhc63b4UX
 EaL3q2UrSspWyswGFJRQ6IuZCDGbwtFJ+0xcjOKygu41KxHgO3W18yxF5Xt5yk6ySBlp3KLhzyW
 Hm53QdeasdX2D8ymQxsqbp3r6XclEILmhNEttu4Fv5IyCRXmy+3Qt30v+Eb/9wI8CUK9SDhBTId
 zCmw00hz2v6s5/YnPJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020104

Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.

The AD4129 series supports the same FIFO interface as the AD4130 but with
reduced resolution (16-bit). The AD4131 series lacks FIFO support, so
triggered buffer functionality is introduced.

The 4-channel variants feature fewer analog inputs, GPIOs, and sparse pin
mappings for VBIAS, analog inputs, and excitation currents. The driver now
handles these differences with chip-specific configurations, including pin
mappings and GPIO counts.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad4130.c | 435 ++++++++++++++++++++++++++++++++-------
 1 file changed, 365 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 138fc0b99d81..e3a3b373e99d 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -9,6 +9,7 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -21,6 +22,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <asm/div64.h>
@@ -30,6 +32,9 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define AD4130_NAME				"ad4130"
 
@@ -40,6 +45,7 @@
 #define AD4130_ADC_CONTROL_REG			0x01
 #define AD4130_ADC_CONTROL_BIPOLAR_MASK		BIT(14)
 #define AD4130_ADC_CONTROL_INT_REF_VAL_MASK	BIT(13)
+#define AD4130_ADC_CONTROL_CONT_READ_MASK	BIT(11)
 #define AD4130_INT_REF_2_5V			2500000
 #define AD4130_INT_REF_1_25V			1250000
 #define AD4130_ADC_CONTROL_CSB_EN_MASK		BIT(9)
@@ -54,7 +60,9 @@
 #define AD4130_IO_CONTROL_REG			0x03
 #define AD4130_IO_CONTROL_INT_PIN_SEL_MASK	GENMASK(9, 8)
 #define AD4130_IO_CONTROL_GPIO_DATA_MASK	GENMASK(7, 4)
+#define AD4130_4_IO_CONTROL_GPIO_DATA_MASK	GENMASK(7, 6)
 #define AD4130_IO_CONTROL_GPIO_CTRL_MASK	GENMASK(3, 0)
+#define AD4130_4_IO_CONTROL_GPIO_CTRL_MASK	GENMASK(3, 2)
 
 #define AD4130_VBIAS_REG			0x04
 
@@ -125,6 +133,28 @@
 
 #define AD4130_INVALID_SLOT			-1
 
+static const unsigned int ad4129_reg_size[] = {
+	[AD4130_STATUS_REG] = 1,
+	[AD4130_ADC_CONTROL_REG] = 2,
+	[AD4130_DATA_REG] = 2,
+	[AD4130_IO_CONTROL_REG] = 2,
+	[AD4130_VBIAS_REG] = 2,
+	[AD4130_ID_REG] = 1,
+	[AD4130_ERROR_REG] = 2,
+	[AD4130_ERROR_EN_REG] = 2,
+	[AD4130_MCLK_COUNT_REG] = 1,
+	[AD4130_CHANNEL_X_REG(0) ... AD4130_CHANNEL_X_REG(AD4130_MAX_CHANNELS - 1)] = 3,
+	[AD4130_CONFIG_X_REG(0) ... AD4130_CONFIG_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_FILTER_X_REG(0) ... AD4130_FILTER_X_REG(AD4130_MAX_SETUPS - 1)] = 3,
+	[AD4130_OFFSET_X_REG(0) ... AD4130_OFFSET_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_GAIN_X_REG(0) ... AD4130_GAIN_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_MISC_REG] = 2,
+	[AD4130_FIFO_CONTROL_REG] = 3,
+	[AD4130_FIFO_STATUS_REG] = 1,
+	[AD4130_FIFO_THRESHOLD_REG] = 3,
+	[AD4130_FIFO_DATA_REG] = 2,
+};
+
 static const unsigned int ad4130_reg_size[] = {
 	[AD4130_STATUS_REG] = 1,
 	[AD4130_ADC_CONTROL_REG] = 2,
@@ -147,6 +177,24 @@ static const unsigned int ad4130_reg_size[] = {
 	[AD4130_FIFO_DATA_REG] = 3,
 };
 
+static const unsigned int ad4131_reg_size[] = {
+	[AD4130_STATUS_REG] = 1,
+	[AD4130_ADC_CONTROL_REG] = 2,
+	[AD4130_DATA_REG] = 2,
+	[AD4130_IO_CONTROL_REG] = 2,
+	[AD4130_VBIAS_REG] = 2,
+	[AD4130_ID_REG] = 1,
+	[AD4130_ERROR_REG] = 2,
+	[AD4130_ERROR_EN_REG] = 2,
+	[AD4130_MCLK_COUNT_REG] = 1,
+	[AD4130_CHANNEL_X_REG(0) ... AD4130_CHANNEL_X_REG(AD4130_MAX_CHANNELS - 1)] = 3,
+	[AD4130_CONFIG_X_REG(0) ... AD4130_CONFIG_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_FILTER_X_REG(0) ... AD4130_FILTER_X_REG(AD4130_MAX_SETUPS - 1)] = 3,
+	[AD4130_OFFSET_X_REG(0) ... AD4130_OFFSET_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_GAIN_X_REG(0) ... AD4130_GAIN_X_REG(AD4130_MAX_SETUPS - 1)] = 2,
+	[AD4130_MISC_REG] = 2,
+};
+
 enum ad4130_int_ref_val {
 	AD4130_INT_REF_VAL_2_5V,
 	AD4130_INT_REF_VAL_1_25V,
@@ -224,12 +272,32 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+/* Map logical pins to register value */
+static const u8 ad4130_4_pin_map[] = {
+	0x00, /* AIN0/VBIAS_0 */
+	0x01, /* AIN1/VBIAS_1 */
+	0x04, /* AIN2/VBIAS_2 */
+	0x05, /* AIN3/VBIAS_3 */
+	0x0A, /* AIN4/VBIAS_4 */
+	0x0B, /* AIN5/VBIAS_5 */
+	0x0E, /* AIN6/VBIAS_6 */
+	0x0F, /* AIN7/VBIAS_7 */
+};
+
+static const u8 ad4130_8_pin_map[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* AIN0/VBIAS_0-AIN7/VBIAS_7 */
+	0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, /* AIN8/VBIAS_8-AIN15/VBIAS_15 */
+};
+
 struct ad4130_chip_info {
 	const char *name;
 	unsigned int max_analog_pins;
+	unsigned int num_gpios;
 	const struct iio_info *info;
 	const unsigned int *reg_size;
 	const unsigned int reg_size_length;
+	const u8 *pin_map;
+	bool has_fifo;
 };
 
 /*
@@ -303,6 +371,7 @@ struct ad4130_state {
 	u32			mclk_sel;
 	bool			int_ref_en;
 	bool			bipolar;
+	bool			buffer_wait_for_irq;
 
 	unsigned int		num_enabled_channels;
 	unsigned int		effective_watermark;
@@ -310,6 +379,7 @@ struct ad4130_state {
 
 	struct spi_message	fifo_msg;
 	struct spi_transfer	fifo_xfer[2];
+	struct iio_trigger	*trig;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires any transfer
@@ -324,6 +394,12 @@ struct ad4130_state {
 	u8			fifo_tx_buf[2];
 	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
 					    AD4130_FIFO_MAX_SAMPLE_SIZE];
+
+	/* Triggered buffer data structure */
+	struct {
+		u32 channels[AD4130_MAX_CHANNELS];
+		s64 timestamp;
+	} scan __aligned(8);
 };
 
 static const char * const ad4130_int_pin_names[] = {
@@ -514,7 +590,8 @@ static int ad4130_gpio_init_valid_mask(struct gpio_chip *gc,
 
 	/*
 	 * Output-only GPIO functionality is available on pins AIN2 through
-	 * AIN5. If these pins are used for anything else, do not expose them.
+	 * AIN5 for some parts and AIN2 through AIN3 for others. If these pins
+	 * are used for anything else, do not expose them.
 	 */
 	for (i = 0; i < ngpios; i++) {
 		unsigned int pin = i + AD4130_AIN2_P1;
@@ -535,8 +612,14 @@ static int ad4130_gpio_set(struct gpio_chip *gc, unsigned int offset,
 			   int value)
 {
 	struct ad4130_state *st = gpiochip_get_data(gc);
-	unsigned int mask = FIELD_PREP(AD4130_IO_CONTROL_GPIO_DATA_MASK,
-				       BIT(offset));
+	unsigned int mask;
+
+	if (st->chip_info->num_gpios == AD4130_MAX_GPIOS)
+		mask = FIELD_PREP(AD4130_IO_CONTROL_GPIO_DATA_MASK,
+				  BIT(offset));
+	else
+		mask = FIELD_PREP(AD4130_4_IO_CONTROL_GPIO_DATA_MASK,
+				  BIT(offset));
 
 	return regmap_update_bits(st->regmap, AD4130_IO_CONTROL_REG, mask,
 				  value ? mask : 0);
@@ -597,10 +680,43 @@ static irqreturn_t ad4130_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ad4130_state *st = iio_priv(indio_dev);
 
-	if (iio_buffer_enabled(indio_dev))
-		ad4130_push_fifo_data(indio_dev);
-	else
+	if (iio_buffer_enabled(indio_dev)) {
+		if (st->chip_info->has_fifo)
+			ad4130_push_fifo_data(indio_dev);
+		else if (st->buffer_wait_for_irq)
+			complete(&st->completion);
+		else
+			iio_trigger_poll(st->trig);
+	} else {
 		complete(&st->completion);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad4130_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4130_state *st = iio_priv(indio_dev);
+	unsigned int data_reg_size = ad4130_data_reg_size(st);
+	unsigned int num_en_chn = bitmap_weight(indio_dev->active_scan_mask,
+						iio_get_masklength(indio_dev));
+	struct spi_transfer xfer = {
+		.rx_buf = st->scan.channels,
+		.len = data_reg_size * num_en_chn,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret < 0)
+		goto err_unlock;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
+					   iio_get_time_ns(indio_dev));
+
+err_unlock:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
@@ -1300,12 +1416,77 @@ static const struct iio_info ad4130_info = {
 	.debugfs_reg_access = ad4130_reg_access,
 };
 
+static const struct iio_info ad4131_info = {
+	.read_raw = ad4130_read_raw,
+	.read_avail = ad4130_read_avail,
+	.write_raw_get_fmt = ad4130_write_raw_get_fmt,
+	.write_raw = ad4130_write_raw,
+	.update_scan_mode = ad4130_update_scan_mode,
+	.debugfs_reg_access = ad4130_reg_access,
+};
+
+static const struct ad4130_chip_info ad4129_4_chip_info = {
+	.name = "ad4129-4",
+	.max_analog_pins = 8,
+	.num_gpios = 2,
+	.info = &ad4130_info,
+	.reg_size = ad4129_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4129_reg_size),
+	.has_fifo = true,
+	.pin_map = ad4130_4_pin_map,
+};
+
+static const struct ad4130_chip_info ad4129_8_chip_info = {
+	.name = "ad4129-8",
+	.max_analog_pins = 16,
+	.num_gpios = 4,
+	.info = &ad4130_info,
+	.reg_size = ad4129_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4129_reg_size),
+	.has_fifo = true,
+	.pin_map = ad4130_8_pin_map,
+};
+
+static const struct ad4130_chip_info ad4130_4_chip_info = {
+	.name = "ad4130-4",
+	.max_analog_pins = 16,
+	.num_gpios = 2,
+	.info = &ad4130_info,
+	.reg_size = ad4130_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4130_reg_size),
+	.has_fifo = true,
+	.pin_map = ad4130_4_pin_map,
+};
+
 static const struct ad4130_chip_info ad4130_8_chip_info = {
 	.name = "ad4130-8",
 	.max_analog_pins = 16,
+	.num_gpios = 4,
 	.info = &ad4130_info,
 	.reg_size = ad4130_reg_size,
 	.reg_size_length = ARRAY_SIZE(ad4130_reg_size),
+	.has_fifo = true,
+	.pin_map = ad4130_8_pin_map,
+};
+
+static const struct ad4130_chip_info ad4131_4_chip_info = {
+	.name = "ad4131-4",
+	.max_analog_pins = 8,
+	.num_gpios = 2,
+	.info = &ad4131_info,
+	.reg_size = ad4131_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4131_reg_size),
+	.pin_map = ad4130_4_pin_map,
+};
+
+static const struct ad4130_chip_info ad4131_8_chip_info = {
+	.name = "ad4131-8",
+	.max_analog_pins = 16,
+	.num_gpios = 4,
+	.info = &ad4131_info,
+	.reg_size = ad4131_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4131_reg_size),
+	.pin_map = ad4130_8_pin_map,
 };
 
 static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
@@ -1315,44 +1496,91 @@ static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
 
 	guard(mutex)(&st->lock);
 
-	ret = ad4130_set_watermark_interrupt_en(st, true);
-	if (ret)
-		return ret;
+	if (st->chip_info->has_fifo) {
+		ret = ad4130_set_watermark_interrupt_en(st, true);
+		if (ret)
+			return ret;
 
-	ret = irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
-	if (ret)
-		return ret;
+		ret = irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
+		if (ret)
+			return ret;
+
+		ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WM);
+		if (ret)
+			return ret;
+	}
 
-	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WM);
+	ret = ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
 	if (ret)
 		return ret;
 
-	return ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
+	/*
+	 * When using triggered buffer, Entering continuous read mode must
+	 * be the last command sent. No configuration changes are allowed until
+	 * exiting this mode.
+	 */
+	if (!st->chip_info->has_fifo) {
+		ret = regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
+					 AD4130_ADC_CONTROL_CONT_READ_MASK,
+					 FIELD_PREP(AD4130_ADC_CONTROL_CONT_READ_MASK, 1));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad4130_state *st = iio_priv(indio_dev);
 	unsigned int i;
+	u32 temp;
 	int ret;
 
 	guard(mutex)(&st->lock);
 
+	if (!st->chip_info->has_fifo) {
+		temp = 0x42;
+		reinit_completion(&st->completion);
+
+		/*
+		 * In continuous read mode, when all samples are read, the data
+		 * ready signal returns high until the next conversion result is
+		 * ready. To exit this mode, the command must be sent when data
+		 * ready is low. In order to ensure that condition, wait for the
+		 * next interrupt (when the new conversion is finished), allowing
+		 * data ready to return low before sending the exit command.
+		 */
+		st->buffer_wait_for_irq = true;
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(1000));
+		st->buffer_wait_for_irq = false;
+		if (!ret)
+			dev_warn(&st->spi->dev, "Conversion timed out\n");
+
+		/* Perform a read data command to exit continuous read mode (0x42) */
+		ret = spi_write(st->spi, &temp, 1);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad4130_set_mode(st, AD4130_MODE_IDLE);
 	if (ret)
 		return ret;
 
-	ret = irq_set_irq_type(st->spi->irq, st->irq_trigger);
-	if (ret)
-		return ret;
+	if (st->chip_info->has_fifo) {
+		ret = irq_set_irq_type(st->spi->irq, st->irq_trigger);
+		if (ret)
+			return ret;
 
-	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
-	if (ret)
-		return ret;
+		ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
+		if (ret)
+			return ret;
 
-	ret = ad4130_set_watermark_interrupt_en(st, false);
-	if (ret)
-		return ret;
+		ret = ad4130_set_watermark_interrupt_en(st, false);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * update_scan_mode() is not called in the disable path, disable all
@@ -1427,6 +1655,34 @@ static const struct iio_dev_attr *ad4130_fifo_attributes[] = {
 	NULL
 };
 
+static const struct iio_trigger_ops ad4130_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ad4130_triggered_buffer_setup(struct iio_dev *indio_dev)
+{
+	struct ad4130_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
+					  indio_dev->name, iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad4130_trigger_ops;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ad4130_trigger_handler,
+					       &ad4130_buffer_ops);
+}
+
 static int _ad4130_find_table_index(const unsigned int *tbl, size_t len,
 				    unsigned int val)
 {
@@ -1513,6 +1769,17 @@ static int ad4130_parse_fw_setup(struct ad4130_state *st,
 	return 0;
 }
 
+static unsigned int ad4130_translate_pin(struct ad4130_state *st,
+					 unsigned int logical_pin)
+{
+	/* For analog input pins, use the chip-specific pin mapping */
+	if (logical_pin < st->chip_info->max_analog_pins)
+		return st->chip_info->pin_map[logical_pin];
+
+	/* For internal channels, pass through unchanged */
+	return logical_pin;
+}
+
 static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
 {
 	struct device *dev = &st->spi->dev;
@@ -1931,9 +2198,14 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 	 * function of P2 takes priority over the GPIO out function.
 	 */
 	val = 0;
-	for (i = 0; i < AD4130_MAX_GPIOS; i++)
-		if (st->pins_fn[i + AD4130_AIN2_P1] == AD4130_PIN_FN_NONE)
-			val |= FIELD_PREP(AD4130_IO_CONTROL_GPIO_CTRL_MASK, BIT(i));
+	for (i = 0; i < st->chip_info->num_gpios; i++) {
+		if (st->pins_fn[i + AD4130_AIN2_P1] == AD4130_PIN_FN_NONE) {
+			if (st->chip_info->num_gpios == 2)
+				val |= FIELD_PREP(AD4130_4_IO_CONTROL_GPIO_CTRL_MASK, BIT(i));
+			else
+				val |= FIELD_PREP(AD4130_IO_CONTROL_GPIO_CTRL_MASK, BIT(i));
+		}
+	}
 
 	val |= FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st->int_pin_sel);
 
@@ -1943,21 +2215,23 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 
 	val = 0;
 	for (i = 0; i < st->num_vbias_pins; i++)
-		val |= BIT(st->vbias_pins[i]);
+		val |= BIT(ad4130_translate_pin(st, st->vbias_pins[i]));
 
 	ret = regmap_write(st->regmap, AD4130_VBIAS_REG, val);
 	if (ret)
 		return ret;
 
-	ret = regmap_clear_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
-				AD4130_FIFO_CONTROL_HEADER_MASK);
-	if (ret)
-		return ret;
+	if (st->chip_info->has_fifo) {
+		ret = regmap_clear_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
+					AD4130_FIFO_CONTROL_HEADER_MASK);
+		if (ret)
+			return ret;
 
-	/* FIFO watermark interrupt starts out as enabled, disable it. */
-	ret = ad4130_set_watermark_interrupt_en(st, false);
-	if (ret)
-		return ret;
+		/* FIFO watermark interrupt starts out as enabled, disable it. */
+		ret = ad4130_set_watermark_interrupt_en(st, false);
+		if (ret)
+			return ret;
+	}
 
 	/* Setup channels. */
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1965,10 +2239,14 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 		struct iio_chan_spec *chan = &st->chans[i];
 		unsigned int val;
 
-		val = FIELD_PREP(AD4130_CHANNEL_AINP_MASK, chan->channel) |
-		      FIELD_PREP(AD4130_CHANNEL_AINM_MASK, chan->channel2) |
-		      FIELD_PREP(AD4130_CHANNEL_IOUT1_MASK, chan_info->iout0) |
-		      FIELD_PREP(AD4130_CHANNEL_IOUT2_MASK, chan_info->iout1);
+		val = FIELD_PREP(AD4130_CHANNEL_AINP_MASK,
+				 ad4130_translate_pin(st, chan->channel)) |
+		      FIELD_PREP(AD4130_CHANNEL_AINM_MASK,
+				 ad4130_translate_pin(st, chan->channel2)) |
+		      FIELD_PREP(AD4130_CHANNEL_IOUT1_MASK,
+				 ad4130_translate_pin(st, chan_info->iout0)) |
+		      FIELD_PREP(AD4130_CHANNEL_IOUT2_MASK,
+				 ad4130_translate_pin(st, chan_info->iout1));
 
 		ret = regmap_write(st->regmap, AD4130_CHANNEL_X_REG(i), val);
 		if (ret)
@@ -2018,17 +2296,19 @@ static int ad4130_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->spi = spi;
 
-	/*
-	 * Xfer:   [ XFR1 ] [         XFR2         ]
-	 * Master:  0x7D N   ......................
-	 * Slave:   ......   DATA1 DATA2 ... DATAN
-	 */
-	st->fifo_tx_buf[0] = AD4130_COMMS_READ_MASK | AD4130_FIFO_DATA_REG;
-	st->fifo_xfer[0].tx_buf = st->fifo_tx_buf;
-	st->fifo_xfer[0].len = sizeof(st->fifo_tx_buf);
-	st->fifo_xfer[1].rx_buf = st->fifo_rx_buf;
-	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
-					ARRAY_SIZE(st->fifo_xfer));
+	if (st->chip_info->has_fifo) {
+		/*
+		 * Xfer:   [ XFR1 ] [         XFR2         ]
+		 * Master:  0x7D N   ......................
+		 * Slave:   ......   DATA1 DATA2 ... DATAN
+		 */
+		st->fifo_tx_buf[0] = AD4130_COMMS_READ_MASK | AD4130_FIFO_DATA_REG;
+		st->fifo_xfer[0].tx_buf = st->fifo_tx_buf;
+		st->fifo_xfer[0].len = sizeof(st->fifo_tx_buf);
+		st->fifo_xfer[1].rx_buf = st->fifo_rx_buf;
+		spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
+						ARRAY_SIZE(st->fifo_xfer));
+	}
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -2077,7 +2357,7 @@ static int ad4130_probe(struct spi_device *spi)
 	st->gc.owner = THIS_MODULE;
 	st->gc.label = st->chip_info->name;
 	st->gc.base = -1;
-	st->gc.ngpio = AD4130_MAX_GPIOS;
+	st->gc.ngpio = st->chip_info->num_gpios;
 	st->gc.parent = dev;
 	st->gc.can_sleep = true;
 	st->gc.init_valid_mask = ad4130_gpio_init_valid_mask;
@@ -2088,9 +2368,12 @@ static int ad4130_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
-					      &ad4130_buffer_ops,
-					      ad4130_fifo_attributes);
+	if (st->chip_info->has_fifo)
+		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+						      &ad4130_buffer_ops,
+						      ad4130_fifo_attributes);
+	else
+		ret = ad4130_triggered_buffer_setup(indio_dev);
 	if (ret)
 		return ret;
 
@@ -2100,34 +2383,46 @@ static int ad4130_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
 
-	/*
-	 * When the chip enters FIFO mode, IRQ polarity is inverted.
-	 * When the chip exits FIFO mode, IRQ polarity returns to normal.
-	 * See datasheet pages: 65, FIFO Watermark Interrupt section,
-	 * and 71, Bit Descriptions for STATUS Register, RDYB.
-	 * Cache the normal and inverted IRQ triggers to set them when
-	 * entering and exiting FIFO mode.
-	 */
-	st->irq_trigger = irq_get_trigger_type(spi->irq);
-	if (st->irq_trigger & IRQF_TRIGGER_RISING)
-		st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
-	else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
-		st->inv_irq_trigger = IRQF_TRIGGER_RISING;
-	else
-		return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
-				     st->irq_trigger);
+	if (st->chip_info->has_fifo) {
+		/*
+		 * When the chip enters FIFO mode, IRQ polarity is inverted.
+		 * When the chip exits FIFO mode, IRQ polarity returns to normal.
+		 * See datasheet pages: 65, FIFO Watermark Interrupt section,
+		 * and 71, Bit Descriptions for STATUS Register, RDYB.
+		 * Cache the normal and inverted IRQ triggers to set them when
+		 * entering and exiting FIFO mode.
+		 */
+		st->irq_trigger = irq_get_trigger_type(spi->irq);
+		if (st->irq_trigger & IRQF_TRIGGER_RISING)
+			st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
+		else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
+			st->inv_irq_trigger = IRQF_TRIGGER_RISING;
+		else
+			return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
+					     st->irq_trigger);
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id ad4130_of_match[] = {
+	{ .compatible = "adi,ad4129-4", .data = &ad4129_4_chip_info },
+	{ .compatible = "adi,ad4129-8", .data = &ad4129_8_chip_info },
+	{ .compatible = "adi,ad4130-4", .data = &ad4130_4_chip_info },
 	{ .compatible = "adi,ad4130", .data = &ad4130_8_chip_info },
+	{ .compatible = "adi,ad4131-4", .data = &ad4131_4_chip_info },
+	{ .compatible = "adi,ad4131-8", .data = &ad4131_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4130_of_match);
 
 static const struct spi_device_id ad4130_id_table[] = {
+	{ "ad4129-4", (kernel_ulong_t)&ad4129_4_chip_info },
+	{ "ad4129-8", (kernel_ulong_t)&ad4129_8_chip_info },
+	{ "ad4130-4", (kernel_ulong_t)&ad4130_4_chip_info },
 	{ "ad4130", (kernel_ulong_t)&ad4130_8_chip_info },
+	{ "ad4131-4", (kernel_ulong_t)&ad4131_4_chip_info },
+	{ "ad4131-8", (kernel_ulong_t)&ad4131_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4130_id_table);
-- 
2.34.1

