Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE5313E34;
	Mon, 16 Feb 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254113; cv=none; b=afVVgiHCz73BF/NRclOEiXzkCwJj9ht6umdZsLDQsyk+XRd3qnEA7+Rm7Ic0qVXr75KyQFBrUs5VaZx6Sh2LssCVoymhf/mkRvmp/rzG4l4ZJUsJ2hXU57eZPG3sXOYfQTraiXyyAVYldfa3WtHSCEcXikj2KAaWOIFGiQ1fcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254113; c=relaxed/simple;
	bh=Kg4KbF9Ayo5fDFe2DCoztlCooC2e2JnxJ5JPWu09qf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZzm2VeQbDidp92DxTv5U8uhkDJJT9OBiTJLH577/00eW188WahAPkbh51o17Lwk9MHNlzX/a054XWKD3FmvwAsae1nJ0YJ65A+G442cdX6B5HB5v3MkwkkTFl5DLld/ywxFj77fsg4Df0GUOCfbxkP5aeziG4hi+LG6Knl47E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MMluxWzq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MMluxWzq"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GDRsSx4079294;
	Mon, 16 Feb 2026 10:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SdJPq
	cH4KW+4ZEUoKp9s9IPFwGh1tanRWSY6P2sZAmE=; b=MMluxWzqNi4/VoengDBTu
	d7sCTL09nKMihuIPAffwaM8Qyp36rHmRIte6chLQ4ZHlBCIxMCkThLosBkv+qAHN
	fKSOwmss+QgEVxchIaVxatisYwpoPFGB42F3tlFUW6pMpJrUQxL51angBCmHluy3
	OoBW2VJewFOZbQMhV49TkQ5dnYPSlcdJgQGacUccFV4SR0/lnDztD8XXVE1OMDU7
	31Jt+GRH9RYJ5lTRaEfeNg8ZDoioMbnY3eMU0laUxCPEaGo0PSLAQjS8gKSVunfo
	En5U9VBFUFOGDznYYghTGrDjqIauN+AMcfgQkYDBoycLsVD1Ypo97fYrCIotIOyv
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cbn8r3djd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:01:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GF1jiN020326
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:01:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:01:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:01:45 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GF1STW017057;
	Mon, 16 Feb 2026 10:01:30 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        David Lechner
	<dlechner@baylible.com>
Subject: [PATCH v9 8/8] iio: adc: ad4030: Support common-mode channels with SPI offloading
Date: Mon, 16 Feb 2026 12:01:27 -0300
Message-ID: <e6599ac890ed7447a4378f129d0101e7a20eb38b.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yhZLwLwlwPjHUl5mvoEjHCsnRJ8vhNUW
X-Proofpoint-ORIG-GUID: yhZLwLwlwPjHUl5mvoEjHCsnRJ8vhNUW
X-Authority-Analysis: v=2.4 cv=aIb9aL9m c=1 sm=1 tr=0 ts=6993315a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=rdXqIxahAAAA:8 a=gAnH3GRIAAAA:8
 a=9qqsCk6Y5STkw7SjBagA:9 a=qWU3L9Jmq6PeI4v8DYd9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfXyaIaXmKI2AU+
 Znnq3gIChT3BPnQVOjGniNv8i8PQLf8DNgBjPD0vdeGg2S3AwSwSNXH4x4TtzjVqENP9f6BBuKY
 ja0lDwmdfbS9zaKQBRv3fUw2Jo/TwtiO+iezzSgkZoaY+hLnH6fnizILA4BwAciHZuPs21wttIT
 HGWrmtTGvyGCKPOONAhmsk/eCW0/Gyuhd+VmlO5C5N8IHB/YPacaCRJdh12pX1lsmEKfo47xuKO
 UtEuwAN4mrgk564v5gZ3KkugEECd6WTfFxtwHOTGxyNsQhr04Q9hnxj8yE79NSs7ugugJRm7e3N
 ZpeWtnM3ZGwR8JV8VyZBNWzKaUFL4bLJOc8eNu9OHvZ8rnF2y1MdEHNGJedXLzELywnScRm8u7P
 0hsdHKhsmghPzffFzcVO/Rvcg6GP6WRfW4Or3gH3IW2Lf7WNa4x6zJYijBSstAClYFReKu4z9bn
 iilt6y8jlnNnO7vLWUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160128

AD4030 and similar devices can read common-mode voltage together with
ADC sample data. When enabled, common-mode voltage data is provided in a
separate IIO channel since it measures something other than the primary
ADC input signal and requires separate scaling to convert to voltage
units. The initial SPI offload support patch for AD4030 only provided
differential channels. Now, extend the AD4030 driver to also provide
common-mode IIO channels when setup with SPI offloading capability.

Reviewed-by: David Lechner <dlechner@baylible.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v8 -> v9
- Picked up David's review tag.

 drivers/iio/adc/ad4030.c | 106 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 3427a6887920..3770db337d0a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -151,13 +151,6 @@ enum {
 	AD4030_SCAN_TYPE_AVG,
 };
 
-static const int adaq4216_hw_gains_db[] = {
-	-10,	/* 1/3 V/V gain */
-	-5,	/* 5/9 V/V gain */
-	7,	/* 20/9 V/V gain */
-	16,	/* 20/3 V/V gain */
-};
-
 /*
  * Gains computed as fractions of 1000 so they can be expressed by integers.
  */
@@ -200,7 +193,7 @@ struct ad4030_state {
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 	/* Offload sampling */
-	struct spi_transfer offload_xfer;
+	struct spi_transfer offload_xfer[2];
 	struct spi_message offload_msg;
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
@@ -208,7 +201,7 @@ struct ad4030_state {
 	struct pwm_device *cnv_trigger;
 	size_t scale_avail_size;
 	struct pwm_waveform cnv_wf;
-	unsigned int scale_avail[ARRAY_SIZE(adaq4216_hw_gains_db)][2];
+	unsigned int scale_avail[ARRAY_SIZE(adaq4216_hw_gains_vpv)][2];
 	struct gpio_descs *pga_gpios;
 	unsigned int pga_index;
 
@@ -245,7 +238,7 @@ struct ad4030_state {
  * - _idx - _ch * 2 + _ch gives the channel number for this specific common-mode
  *   channel
  */
-#define AD4030_CHAN_CMO(_idx, _ch)  {					\
+#define __AD4030_CHAN_CMO(_idx, _ch, _offload)  {			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_SCALE),				\
 	.type = IIO_VOLTAGE,						\
@@ -255,12 +248,18 @@ struct ad4030_state {
 	.scan_index = (_idx),						\
 	.scan_type = {							\
 		.sign = 'u',						\
-		.storagebits = 8,					\
+		.storagebits = (_offload ? 32 : 8),			\
 		.realbits = 8,						\
-		.endianness = IIO_BE,					\
+		.endianness = (_offload ? IIO_CPU : IIO_BE),		\
 	},								\
 }
 
+#define AD4030_CHAN_CMO(_idx, _ch)					\
+	__AD4030_CHAN_CMO(_idx, _ch, 0)
+
+#define AD4030_OFFLOAD_CHAN_CMO(_idx, _ch)				\
+	__AD4030_CHAN_CMO(_idx, _ch, 1)
+
 /*
  * For a chip with 2 hardware channel this will be used to create 2 differential
  * channels:
@@ -482,7 +481,7 @@ static void ad4030_fill_scale_avail(struct ad4030_state *st)
 		 * result after right shift and division scales output codes to
 		 * millivolts.
 		 */
-		int_part = div_u64_rem(((u64)range * MICRO) >> mag_bits, NANO, &fract_part);
+		int_part = div_u64_rem((range * MICRO) >> mag_bits, NANO, &fract_part);
 		st->scale_avail[i][0] = int_part;
 		st->scale_avail[i][1] = fract_part;
 	}
@@ -1190,6 +1189,7 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
+	bool common_mode;
 	u8 offload_bpw;
 
 	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
@@ -1197,10 +1197,22 @@ static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 	else
 		offload_bpw = st->chip->precision_bits;
 
-	st->offload_xfer.bits_per_word = offload_bpw;
-	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
-	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
-	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_xfer[0].bits_per_word = offload_bpw;
+	st->offload_xfer[0].len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	common_mode = st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
+		      st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM;
+
+	if (common_mode) {
+		offload_bpw = 8;
+		st->offload_xfer[1].bits_per_word = offload_bpw;
+		st->offload_xfer[1].len = spi_bpw_to_bytes(offload_bpw);
+		st->offload_xfer[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	}
+
+	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer,
+					common_mode ? 2 : 1);
 }
 
 static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
@@ -1265,6 +1277,7 @@ static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
 	.postenable = &ad4030_offload_buffer_postenable,
 	.predisable = &ad4030_offload_buffer_predisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -1409,43 +1422,19 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
 static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
 			    struct ad4030_state *st)
 {
-	unsigned int i;
-	int pga_gain_dB;
-	int ret;
+	/* Setup GPIOs for PGA control */
+	st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pga_gpios))
+		return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+				     "Failed to get PGA gpios.\n");
 
-	ret = device_property_read_u32(dev, "adi,pga-gain-db", &pga_gain_dB);
-	if (ret == -EINVAL) {
-		/* Setup GPIOs for PGA control */
-		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
-		if (IS_ERR(st->pga_gpios))
-			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
-					     "Failed to get PGA gpios.\n");
+	if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Expected %d GPIOs for PGA control.\n",
+				     ADAQ4616_PGA_PINS);
 
-		if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
-			return dev_err_probe(dev, -EINVAL,
-					     "Expected 2 GPIOs for PGA control.\n");
-
-		st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_db);
-		st->pga_index = 0;
-		return 0;
-	} else if (ret) {
-		return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
-	}
-
-	/* Set ADC driver to handle pin-strapped PGA pins setup */
-	for (i = 0; i < ARRAY_SIZE(adaq4216_hw_gains_db); i++) {
-		if (pga_gain_dB != adaq4216_hw_gains_db[i])
-			continue;
-
-		st->pga_index = i;
-		break;
-	}
-	if (i == ARRAY_SIZE(adaq4216_hw_gains_db))
-		return dev_err_probe(dev, -EINVAL, "Invalid PGA gain: %d.\n",
-				     pga_gain_dB);
-
-	st->scale_avail_size = 1;
-	st->pga_gpios = NULL;
+	st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_vpv);
+	st->pga_index = 0;
 
 	return 0;
 }
@@ -1539,7 +1528,7 @@ static int ad4030_probe(struct spi_device *spi)
 		 * Offloaded SPI transfers can't support software timestamp so
 		 * no additional timestamp channel is added.
 		 */
-		indio_dev->num_channels = st->chip->num_voltage_inputs;
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
 		indio_dev->channels = st->chip->offload_channels;
 		ret = ad4030_spi_offload_setup(indio_dev, st);
 		if (ret)
@@ -1659,6 +1648,7 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	},
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
@@ -1680,6 +1670,8 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
@@ -1701,6 +1693,8 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
@@ -1722,6 +1716,8 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
@@ -1743,6 +1739,8 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
@@ -1761,6 +1759,7 @@ static const struct ad4030_chip_info adaq4216_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
 	.precision_bits = 16,
@@ -1780,6 +1779,7 @@ static const struct ad4030_chip_info adaq4224_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
 	.precision_bits = 24,
-- 
2.39.2

