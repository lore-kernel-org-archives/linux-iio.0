Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F972ECE9B;
	Fri,  6 Feb 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404565; cv=none; b=NhuhH8hLdWBfD2BrdFRhXBvbQsyC2qOd5ECFiYsMuIegjNem+QOY81hitS69IwUEkWb+NeZLc1k8vIDPK8szSjYdJ/CCUdIxNXtIY7D8f2UXLHs/aMTzp2144mQN/EOVEoekQVFrw2s/fUSO0D/pQ6/FJQxRZhXulWLTkEdOr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404565; c=relaxed/simple;
	bh=vL9vkegTiLfVuSfemZhCHrumg0DjIJpxvM5bkC3OAMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFr8PN7jk0p9RDbRin/dn14vsvEm/naH0M7WbLVTIiWRfJUErFp4vnYTVYiLKoq3HmZoLG5kk2Lf76spRi9A9UwUONOWFxo63uVS4xNY/RfqC76USU6GUyVSXPoHKjfyXWTwsT6NeG4PfhHqTz2cHMCSOloAygxAoSM4pMOYhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VZM2IRBE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VZM2IRBE"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLZqM1708574;
	Fri, 6 Feb 2026 14:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NpY7s
	T3cqfbQwGfkHkXGO7qaPGEzJE2oO3hq/hNwbL0=; b=VZM2IRBE+aTGCKtfaELge
	kIz0mJX/MajIm1zfIxMi/R7Cdvy4bIg28zvzftOfl1JMsOI0+DL5jYD2Rkks5tIP
	SNxT0d9MXqpijCq0ipVvOVpYCi7KIukSO3ZQ/2TXOCJWjKSuBlS34dU3Txl0CsaX
	DbSTrT8biXcD5ZRJqfrk84ZuzLn4dh2InW73T+nS1rfhzZs0n03w0w/q7uMlbwea
	e4yGfDtQXj3EQuYGDu6fIo0aQJJXiY6u7xXM3fTrsMGAtAZzhUqtdr+2lbEVdUKr
	TTHlPectKxW/nnf/fn9CxUyz5e84jVLFxtvcd3T5vBnKUZu01GIAFfZ2UphWIiG0
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4q2fex71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:02:35 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J2XNM012927
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:02:34 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:02:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:02:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:02:33 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J2JtO009038;
	Fri, 6 Feb 2026 14:02:22 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 7/8] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
Date: Fri, 6 Feb 2026 16:02:19 -0300
Message-ID: <b437e4ca90df98220f2cabc514c201743e269889.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: c6ajE8cgx21Cva3BP-GzHGYF4_fdxFRm
X-Proofpoint-GUID: c6ajE8cgx21Cva3BP-GzHGYF4_fdxFRm
X-Authority-Analysis: v=2.4 cv=MpVfKmae c=1 sm=1 tr=0 ts=69863acb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8
 a=vBz0w1DY-RU6HqRekHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX8ABxjV3Py7KH
 s7wKty9LecOGtOrPQ8OiOTZMobMKsRVi05RLuy4jn72iYo5l+CiwXit0vxkw59T8mXLFzW0rJOY
 Strwd4qTQeUqOm/uzRmWcppQe6L9BqRS/kRsjkDeHkvyzAVkz07pU9RqaJkGa6IVn+Dzzf8zMMs
 NHbt9rjJNWQ1Zs+Whzq1TGYXXkeG/yHkm9FMJ97ckTU7DyJvQvx/RHh1hE9JipmsSMiWfG7QW1j
 mvmi8JzWBN/q9mR6Caae7KjlHz0xsgcSPgBpotDv80Uu1KhM+A3qEpHdIuj8GdVLPzX+op8jBCH
 vM9ycgCEEKWoFPA4rkywA9y8b5poZig5HB4sowi1eIMffaDpeDXYFIw4cf0IZ55XXF6ogFcz+9p
 WqOkIJFdJHhxE8G2UTyY8WIWjAJ5vsEpvxpK2Em/br2gBC4Ld3dzoyCH6yD5PGFUgkzT3aKqe6/
 V6eB1M+y6ZFx8CzUM6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060140

ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
that scales the analog input signal prior to it reaching the ADC. The PGA
is controlled through a pair of pins (A0 and A1) whose state define the
gain that is applied to the input signal.

Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
through the IIO device channel scale available interface and enable control
of the PGA through the channel scale interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- Minor tidy up for macro consistency and fewer blank lines.

 drivers/iio/adc/ad4030.c | 200 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 8f14cf58f860..3e4eb7ce6185 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -48,6 +48,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
 #define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
+#define     AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE	0x1E
+#define     AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE	0x1C
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -125,6 +127,10 @@
 /* Datasheet says 9.8ns, so use the closest integer value */
 #define AD4030_TQUIET_CNV_DELAY_NS	10
 
+/* HARDWARE_GAIN */
+#define ADAQ4616_PGA_PINS		2
+#define ADAQ4616_PGA_GAIN_MAX_NANO	(NANO * 2 / 3)
+
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
 	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
@@ -145,6 +151,23 @@ enum {
 	AD4030_SCAN_TYPE_AVG,
 };
 
+/*
+ * Gains computed as fractions of 1000 so they can be expressed by integers.
+ */
+static const int adaq4216_hw_gains_vpv[] = {
+	1 * MILLI / 3,		/* 333 */
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
@@ -152,6 +175,7 @@ struct ad4030_chip_info {
 	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
+	bool has_pga;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
@@ -175,7 +199,11 @@ struct ad4030_state {
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
@@ -232,7 +260,7 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload, _pga) {		\
 	.info_mask_shared_by_all =					\
 		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
@@ -243,6 +271,7 @@ struct ad4030_state {
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
 		BIT(IIO_CHAN_INFO_RAW),					\
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
+		(_pga ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
 		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
@@ -257,10 +286,16 @@ struct ad4030_state {
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
@@ -418,6 +453,64 @@ static const struct regmap_config ad4030_regmap_config = {
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
@@ -430,6 +523,13 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
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
@@ -890,6 +990,15 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
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
@@ -962,6 +1071,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4030_set_sampling_freq(indio_dev, val);
 
+	case IIO_CHAN_INFO_SCALE:
+		return ad4030_set_pga(indio_dev, val, val2);
+
 	default:
 		return -EINVAL;
 	}
@@ -983,6 +1095,17 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
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
@@ -1029,6 +1152,7 @@ static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
 	.write_raw = ad4030_write_raw,
+	.write_raw_get_fmt = &ad4030_write_raw_get_fmt,
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
 	.get_current_scan_type = ad4030_get_current_scan_type,
@@ -1270,6 +1394,26 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
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
@@ -1312,6 +1456,14 @@ static int ad4030_probe(struct spi_device *spi)
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
@@ -1563,12 +1715,52 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
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
@@ -1579,6 +1771,8 @@ static const struct of_device_id ad4030_of_match[] = {
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

