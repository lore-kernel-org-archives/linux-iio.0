Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8B43C042;
	Thu,  5 Feb 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310181; cv=none; b=e9RvWtJngnE5Cj+N7PERJyvt7y8dCR+suU62K0Ns3TWiQPllGnEXO1KAZZKT7MJiXmRSZ30GbTsJM3oYgKVQdP44owHCC61QuXEB2aMTFuisTJYjQdlAgSl+CSsn4cBMN01FemjwXYyuZGJunwGlYytO1X9FrydscNfB4cvpnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310181; c=relaxed/simple;
	bh=MDnZ6+BU5ks1nIgKOiCHubdsXuxaY4uhwv1KoprDnDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmdBnYBKBAi+eXV9yHHl4fKDxfKRsQhb7PU70eU0e+4ya7NzO+yoQqj3pb/cqW7MAPl+pWtO3OFPCurmGToW1rAltzcINk5iJw5epU6DyTGaEXDuH1dXPf5Jlk3tI9L4Dam9q6MmqlL0pNGTuln6JMrj6CglB6kyQcEn/TuhyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kk39zYQd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kk39zYQd"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615GT6ha2446426;
	Thu, 5 Feb 2026 11:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YvxOR
	hBvsgk/kLoQUyaITC4GDcI0PUDlmrQXHv7K3LU=; b=Kk39zYQdfQTN5kfNz1ddi
	+qOTFOJRLRkE55yfkdCimHCiIVAObDO6BUeZ57nE0mm9KUCYC9+4WELQiJLvYTiG
	o//SNyvnrYQYNU8GmopqG0H0ds9QW7rwpNGazw+gthIIeZYRu8xuOVhYe/3oCpUs
	3Kz0DRFuyuFcI+0IbiroXuAuvqZoeHRWdl6MfcUHQUUJvRlkCDqKr8ryp5YEslSu
	PUaXAzWK7pd9Fh2HTel6dgu8qYAEs/yMApanSb/djE1uIiMPofjR6D0HntIoBc2w
	PaCfWqBcg0angDDEEoWAik/O/aZk4vPdvdHl8GafRc22sHsoJs/Fobz/9yb30rux
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vxvg27k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:49:36 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GnZWu045344
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:49:35 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:49:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:49:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:49:35 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615GnKIW000481;
	Thu, 5 Feb 2026 11:49:22 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 7/8] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
Date: Thu, 5 Feb 2026 13:49:19 -0300
Message-ID: <a5721b31e7cbf8327c74d761757d9051c289297c.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: OlYwJEvTriwMQUWVMO687hSVyL41ctgk
X-Proofpoint-ORIG-GUID: OlYwJEvTriwMQUWVMO687hSVyL41ctgk
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=6984ca20 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=vBz0w1DY-RU6HqRekHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfXw2vUPoOUTkB0
 DM8T8Ht/509sFHZkDfej4ZyxgyPnH9KUpoOnS9EBLKWxiQxdssygilrfD4TWD9Uc1fDEXXPkPvm
 7XL0hTUSm78QPqzHCD5NCBUNu6l71DLi5uUSK4d78QlixBUrFz+KsW3sEIXJa1+VyCzUbSmBW54
 CaOlRbaqajiWAJ4c3kpnkRhUZv9vfIcgkFFhYo14H28WLFqiFid1gw+YlWpCL//M7d9j/9j1cTE
 0g89mnGo1IuUjYRZxwIt5ZZQ+kIJjyUrkadJ8rQAN8Uclrt66a3wUDrdKnk1MNXEudY5aaH9uYy
 EfYnTvu37XuWuU6q8VCC+o4WBubs4A/jfh6yUA5ewzV/yLFAfXtkZSlF2nZ0jtMvKqC2YNgriK3
 nO6Bqfjh515PlwesrMTYRErOIoyJEOTTf4gfE5mP2KcK7rYdlkXkQqm/nPYRnwMgaA+PVA1YqUs
 AZwIU6x6bzesfgVvpHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050127

ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
that scales the analog input signal prior to it reaching the ADC. The PGA
is controlled through a pair of pins (A0 and A1) whose state define the
gain that is applied to the input signal.

Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
through the IIO device channel scale available interface and enable control
of the PGA through the channel scale interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 drivers/iio/adc/ad4030.c | 201 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index d759fb35b977..4f521fe787d9 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -47,6 +47,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
 #define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
+#define     AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE	0x1E
+#define     AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE	0x1C
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -124,6 +126,10 @@
 /* Datasheet says 9.8ns, so use the closest integer value */
 #define AD4030_TQUIET_CNV_DELAY_NS	10
 
+/* HARDWARE_GAIN */
+#define ADAQ4616_PGA_PINS		2
+#define ADAQ4616_PGA_GAIN_MAX_NANO	(NANO * 2 / 3)
+
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
 	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
@@ -144,6 +150,23 @@ enum {
 	AD4030_SCAN_TYPE_AVG,
 };
 
+/*
+ * Gains computed as fractions of 1000 so they can be expressed by integers.
+ */
+static const int adaq4216_hw_gains_vpv[] = {
+	MILLI / 3,		/* 333 */
+	5 * MILLI / 9,		/* 555 */
+	20 * MILLI / 9,		/* 2222 */
+	20 * MILLI / 3,		/* 6666 */
+};
+
+static const int adaq4216_hw_gains_frac[][2] = {
+	{ 1, 3 },  /* 1/3 V/V gain */
+	{ 5, 9 },  /* 5/9 V/V gain */
+	{ 20, 9 }, /* 20/9 V/V gain */
+	{ 20, 3 }, /* 20/3 V/V gain */
+};
+
 struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
@@ -151,6 +174,7 @@ struct ad4030_chip_info {
 	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
+	bool has_pga;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
@@ -174,7 +198,11 @@ struct ad4030_state {
 	struct spi_offload_trigger *offload_trigger;
 	struct spi_offload_trigger_config offload_trigger_config;
 	struct pwm_device *cnv_trigger;
+	size_t scale_avail_size;
 	struct pwm_waveform cnv_wf;
+	unsigned int scale_avail[ARRAY_SIZE(adaq4216_hw_gains_vpv)][2];
+	struct gpio_descs *pga_gpios;
+	unsigned int pga_index;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -231,7 +259,7 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload, _pga) {		\
 	.info_mask_shared_by_all =					\
 		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
@@ -242,6 +270,7 @@ struct ad4030_state {
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
 		BIT(IIO_CHAN_INFO_RAW),					\
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
+		(_pga ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
 		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
@@ -256,10 +285,16 @@ struct ad4030_state {
 }
 
 #define AD4030_CHAN_DIFF(_idx, _scan_type)				\
-	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 0)
 
 #define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
-	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 0)
+
+#define ADAQ4216_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 1)
+
+#define ADAQ4216_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 1)
 
 /*
  * AD4030 can average over 2^N samples, where N = 1, 2, 3, ..., 16.
@@ -417,6 +452,65 @@ static const struct regmap_config ad4030_regmap_config = {
 	.max_register = AD4030_REG_DIG_ERR,
 };
 
+static void ad4030_fill_scale_avail(struct ad4030_state *st)
+{
+	unsigned int mag_bits, int_part, fract_part, i;
+	u64 range;
+
+	/*
+	 * The maximum precision of differential channels is retrieved from the
+	 * chip properties. The output code of differential channels is in two's
+	 * complement format (i.e. signed), so the MSB is the sign bit and only
+	 * (precision_bits - 1) bits express voltage magnitude.
+	 */
+	mag_bits = st->chip->precision_bits - 1;
+
+	for (i = 0; i < ARRAY_SIZE(adaq4216_hw_gains_frac); i++) {
+		range = mult_frac(st->vref_uv, adaq4216_hw_gains_frac[i][1],
+				  adaq4216_hw_gains_frac[i][0]);
+		/*
+		 * If range were in mV, we would multiply it by NANO below.
+		 * Though, range is in µV so multiply it by MICRO only so the
+		 * result after right shift and division scales output codes to
+		 * millivolts.
+		 */
+		int_part = div_u64_rem((range * MICRO) >> mag_bits, NANO, &fract_part);
+		st->scale_avail[i][0] = int_part;
+		st->scale_avail[i][1] = fract_part;
+	}
+}
+
+static int ad4030_set_pga_gain(struct ad4030_state *st)
+{
+	DECLARE_BITMAP(bitmap, ADAQ4616_PGA_PINS) = { };
+
+	bitmap_write(bitmap, st->pga_index, 0, ADAQ4616_PGA_PINS);
+
+	return gpiod_multi_set_value_cansleep(st->pga_gpios, bitmap);
+}
+
+static int ad4030_set_pga(struct iio_dev *indio_dev, int gain_int, int gain_fract)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	unsigned int mag_bits = st->chip->precision_bits - 1;
+	u64 gain_nano, tmp;
+
+	if (!st->pga_gpios)
+		return -EINVAL;
+
+	gain_nano = gain_int * NANO + gain_fract;
+
+	if (!in_range(gain_nano, 1, ADAQ4616_PGA_GAIN_MAX_NANO))
+		return -EINVAL;
+
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << mag_bits, NANO);
+	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
+	st->pga_index = find_closest(gain_nano, adaq4216_hw_gains_vpv,
+				     ARRAY_SIZE(adaq4216_hw_gains_vpv));
+
+	return ad4030_set_pga_gain(st);
+}
+
 static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan,
 				 int *val,
@@ -429,6 +523,13 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
+	/* The LSB of the 8-bit common-mode data is always vref/256. */
+	if (st->chip->has_pga && scan_type->realbits != 8) {
+		*val = st->scale_avail[st->pga_index][0];
+		*val2 = st->scale_avail[st->pga_index][1];
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+
 	if (chan->differential)
 		*val = (st->vref_uv * 2) / MILLI;
 	else
@@ -891,6 +992,15 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(ad4030_average_modes);
 		return IIO_AVAIL_LIST;
 
+	case IIO_CHAN_INFO_SCALE:
+		if (st->scale_avail_size == 1)
+			*vals = (int *)st->scale_avail[st->pga_index];
+		else
+			*vals = (int *)st->scale_avail;
+		*length = st->scale_avail_size * 2; /* print int and nano part */
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+
 	default:
 		return -EINVAL;
 	}
@@ -963,6 +1073,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4030_set_sampling_freq(indio_dev, val);
 
+	case IIO_CHAN_INFO_SCALE:
+		return ad4030_set_pga(indio_dev, val, val2);
+
 	default:
 		return -EINVAL;
 	}
@@ -984,6 +1097,17 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4030_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -1030,6 +1154,7 @@ static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
 	.write_raw = ad4030_write_raw,
+	.write_raw_get_fmt = &ad4030_write_raw_get_fmt,
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
 	.get_current_scan_type = ad4030_get_current_scan_type,
@@ -1271,6 +1396,26 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
 							   IIO_BUFFER_DIRECTION_IN);
 }
 
+static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
+			    struct ad4030_state *st)
+{
+	/* Setup GPIOs for PGA control */
+	st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pga_gpios))
+		return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+				     "Failed to get PGA gpios.\n");
+
+	if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Expected %d GPIOs for PGA control.\n",
+				     ADAQ4616_PGA_PINS);
+
+	st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_vpv);
+	st->pga_index = 0;
+
+	return 0;
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1313,6 +1458,14 @@ static int ad4030_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (st->chip->has_pga) {
+		ret = ad4030_setup_pga(dev, indio_dev, st);
+		if (ret)
+			return ret;
+
+		ad4030_fill_scale_avail(st);
+	}
+
 	ret = ad4030_config(st);
 	if (ret)
 		return ret;
@@ -1566,12 +1719,52 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
+static const struct ad4030_chip_info adaq4216_chip_info = {
+	.name = "adaq4216",
+	.available_masks = ad4030_channel_masks,
+	.channels = {
+		ADAQ4216_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+		IIO_CHAN_SOFT_TIMESTAMP(2),
+	},
+	.offload_channels = {
+		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
+	.precision_bits = 16,
+	.has_pga = true,
+	.num_voltage_inputs = 1,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+};
+
+static const struct ad4030_chip_info adaq4224_chip_info = {
+	.name = "adaq4224",
+	.available_masks = ad4030_channel_masks,
+	.channels = {
+		ADAQ4216_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+		IIO_CHAN_SOFT_TIMESTAMP(2),
+	},
+	.offload_channels = {
+		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
+	.precision_bits = 24,
+	.has_pga = true,
+	.num_voltage_inputs = 1,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
 	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
 	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
 	{ "ad4632-16", (kernel_ulong_t)&ad4632_16_chip_info },
 	{ "ad4632-24", (kernel_ulong_t)&ad4632_24_chip_info },
+	{ "adaq4216", (kernel_ulong_t)&adaq4216_chip_info },
+	{ "adaq4224", (kernel_ulong_t)&adaq4224_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
@@ -1582,6 +1775,8 @@ static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
 	{ .compatible = "adi,ad4632-16", .data = &ad4632_16_chip_info },
 	{ .compatible = "adi,ad4632-24", .data = &ad4632_24_chip_info },
+	{ .compatible = "adi,adaq4216", .data = &adaq4216_chip_info },
+	{ .compatible = "adi,adaq4224", .data = &adaq4224_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);
-- 
2.39.2

