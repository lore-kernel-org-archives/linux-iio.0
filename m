Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B724FECC6;
	Wed, 16 Sep 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557393; cv=none; b=AgqideAcBA0hwLiSGkL3xLW1elYTk3a5PZXTuV1CKzkudvrprbzYex8dzjnMaFZG0FkZjjPLA+UcOm7720ujg80Cz1YhGB3TMZL0GeU64qeAg2kmQ6fwUl+TkiSTfdUE8Yfw24JIE5rhEVE5d9GAR9v1O2pdp6XWzdYF0ldQ5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557393; c=relaxed/simple;
	bh=QMDv6Z+9DfIc1qsBFbZ3zcdqksbBzntjhCFRKTeVxh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y/nZUF3z3iz1LqqgIQKBrclScegOV80+dgXzHBeFowHvVSWdH6fPYiTm6mET8/NX50lulDZWEWq7EZMv4U/ckeZMNTBuEqGolZsh1ql7Lz1s8gXFWcFxqjf1oUU4mu+islsEiiVI4ZPyldBPgskzP7PMXAHTWNrCK6Sysx5zoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HMmE+0OY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HMmE+0OY"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6q5cE1548664;
	Wed, 16 Sep 2026 07:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=80GtY
	x+6JWQ3GZ4kVDWs+J4wRmFs/OOuwDjtZvMR2Xw=; b=HMmE+0OYS90moOy5lgn1a
	V5g+pCeLjbH+s9deE2lLZqIfqCUuLVkFNwJj8Q9t6MLgUJcYKhK5oQTBxydGMLMe
	2eTEEDD/UZzMrdLoDGztWc3T7pEa1Pz6ar2v2RF3ENW2fcmW7ZUJP+YFatZXfEEX
	ifLUBxb0xFH31v8YT36J4UOXzuDxzHBxGmMLVW3l07oaRj/yokqxFRqr3km37PgC
	w9ex9gyZd4wDRihxrXk0kDhnKxXEA0BI6ebHoVDNHkiM67wWY2/9BVrmvdyHpu0T
	E7XRGu/klhGzbSL1jVFVtsZgNku5GLutX1o2hCVNA3r4dEI/JpBQ566gWtAMu6Lq
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57hxfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFVWs047151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:15:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:31 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE6004263;
	Wed, 16 Sep 2026 07:15:24 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:03 +0200
Subject: [PATCH v8 14/17] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-14-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=6551;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=QMDv6Z+9DfIc1qsBFbZ3zcdqksbBzntjhCFRKTeVxh4=;
 b=kSeuHJy1sYJMfOba2uK0hzBOd3pTIhBxZ7n50klEnTN/6XBt6bORJLoeYPKnlCUOn6E+cbi6o
 15y+zfhZe3iD/21L7ssxYkusiUx4Qbj9Vaxd5HyVtkn22J3JcohmWv7
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX3Deb6R5GA90U
 W3sS90lkYsES43hMRwBZdLXycUdD5gmSqQKURWpi+IrVYuilzEaL0utPms6L5qJ7Rbqflv2vDtJ
 /z+EDPOVgtCAt1FHN+VlJ7c5j0akdJ5x5984o5mNGX7RRP5v/qg7
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aaa7a55 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=g92PuHId75YPrMRR_n4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uMoEeK2GgzVAFPyDFnevt_j-M8b3h5Wl
X-Proofpoint-GUID: uMoEeK2GgzVAFPyDFnevt_j-M8b3h5Wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX7XTx76uYPaTF
 pvMMPIs7dqVi065zj5dvUwZxtZZQFOlPrl7jhFEBg0UWxRInTJQN4Eeo3JvcGxCn6ZWMcgnDzpl
 ZyYp4Y1KPNTw6roUyzEurexpDzHOkn0781hFk5TCNOy956wTHMfYN1euaGGV5V9KXTyInsXt/e1
 iFyv0QZ/DlNWgCWEkG/J7kH37+ehfJFb487tBnvNuDazr5uGC4BLUVC/eXeRiW1hvmImnjqg0NJ
 FPNUL1exHx7cQpulBRqayCXNJvj8duBvnO9s307t3aIXzA8ipydKTfmhwUUOsa7cUmSK5GQRcD0
 sWyBGY6H3IJO6M+lT3yEpdEbHKq/lNPlLs680kLilpFtka4v2II7GVQzfGTWFzbS3sC8HbIWCwm
 Xihgi2X3kI35GPL0TTjmACY6yMsP/6X6tew3TKIflHZTeFl7HGbuawQ5Um9o+6Fvl5jDRyFSyrI
 auCZV9R94GjYzLfP9Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Expose the per-channel synchronization phase offset through the IIO
conversion-delay attribute.

Derive the delay resolution from MCLK, power mode and decimation rate.
Validate the requested delay and program the corresponding phase
register when applying the active channel configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index e9462278a812..be2eb21c5b63 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -146,6 +146,12 @@ struct ad7768_freq_config {
 	unsigned int dec_rate;
 };
 
+struct ad7768_convdelay_params {
+	unsigned int shift;
+	unsigned int max_raw;
+	u64 step_ps;
+};
+
 struct ad7768_avail_freq {
 	unsigned int n_freqs;
 	struct ad7768_freq_config freq_cfg[AD7768_MAX_FREQ_PER_MODE];
@@ -172,6 +178,7 @@ struct ad7768_state {
 	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	unsigned int power_mode_idx;
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
@@ -261,6 +268,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
 	return AD7768_REG_GAIN(st->chip_info->chan_map[ch]);
 }
 
+static unsigned int ad7768_phase_reg(const struct ad7768_state *st,
+				     unsigned int ch)
+{
+	return AD7768_REG_PHASE(st->chip_info->chan_map[ch]);
+}
+
 static u8 ad7768_precharge_buf1_mask(const struct ad7768_state *st, u16 val)
 {
 	return val & GENMASK(st->chip_info->prebuf_split - 1, 0);
@@ -699,6 +712,99 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 	return -EINVAL;
 }
 
+static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
+				       struct ad7768_convdelay_params *params)
+{
+	const struct ad7768_freq_config *freq_cfg;
+	unsigned int dec_rate;
+	unsigned int mclk_div;
+	unsigned long mclk;
+	u64 mult;
+
+	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx,
+					   st->ch_freq[ch]);
+	if (!freq_cfg)
+		return -EINVAL;
+
+	dec_rate = ad7768_dec_rate[freq_cfg->dec_rate];
+	switch (dec_rate) {
+	case 32:
+		params->shift = 3;
+		params->max_raw = 31;
+		mult = 1;
+		break;
+	case 64:
+		params->shift = 2;
+		params->max_raw = 63;
+		mult = 1;
+		break;
+	case 128:
+		params->shift = 1;
+		params->max_raw = 127;
+		mult = 1;
+		break;
+	case 256:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 1;
+		break;
+	case 512:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 2;
+		break;
+	case 1024:
+		params->shift = 0;
+		params->max_raw = 255;
+		mult = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mclk = clk_get_rate(st->mclk);
+	if (!mclk || mclk > U32_MAX)
+		return -EINVAL;
+
+	mclk_div = ad7768_power_modes[st->power_mode_idx].mclk_div;
+	params->step_ps =
+		DIV_ROUND_CLOSEST_ULL(mult * PSEC_PER_SEC * mclk_div, (u32)mclk);
+	if (params->step_ps > U32_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad7768_set_channel_convdelay(struct ad7768_state *st,
+					unsigned int ch)
+{
+	u64 delay_ps = st->ch_convdelay_ps[ch];
+	struct ad7768_convdelay_params params;
+	u64 max_delay_ps;
+	u64 raw;
+	int ret;
+
+	ret = ad7768_get_convdelay_params(st, ch, &params);
+	if (ret)
+		return ret;
+
+	/*
+	 * Validate the requested delay before rounding so an out-of-range value
+	 * cannot round down into the valid range. Then verify that the rounded
+	 * value fits in the hardware register.
+	 */
+	max_delay_ps = (u64)params.max_raw * params.step_ps;
+	if (delay_ps > max_delay_ps)
+		return -EINVAL;
+
+	raw = DIV_ROUND_CLOSEST_ULL(delay_ps, (u32)params.step_ps);
+	if (raw > params.max_raw)
+		return -EINVAL;
+
+	return regmap_write(st->regmap, ad7768_phase_reg(st, ch),
+			    raw << params.shift);
+}
+
 static void ad7768_filter_wait(const unsigned int *mode_freq,
 			       const enum ad7768_filter_type *mode_filter,
 			       const bool *mode_used)
@@ -799,6 +905,16 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		max_freq = max(max_freq, mode_freq[mode]);
 	}
 
+	for_each_set_bit(c, scan_mask, st->chip_info->num_channels) {
+		ret = ad7768_set_channel_convdelay(st, c);
+		if (ret == -EINVAL)
+			return dev_err_probe(regmap_get_device(st->regmap), ret,
+					     "Invalid conversion delay for channel %u\n",
+					     c);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad7768_set_clk_divs(st, max_freq);
 	if (ret)
 		return ret;
@@ -918,6 +1034,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	}
+	case IIO_CHAN_INFO_CONVDELAY: {
+		guard(mutex)(&st->lock);
+		iio_val_s64_decompose(st->ch_convdelay_ps[chan->channel],
+				      val, val2);
+
+		return IIO_VAL_DECIMAL64_PICO;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -931,6 +1054,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -942,6 +1067,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int base_reg;
+	s64 delay_ps;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
@@ -956,6 +1082,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBSCALE:
 		base_reg = ad7768_get_calib_reg_base(st, chan, true);
 		return ad7768_write_calib_value(st, base_reg, false, val);
+	case IIO_CHAN_INFO_CONVDELAY: {
+		delay_ps = iio_val_s64_compose(val, val2);
+		if (delay_ps < 0)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		st->ch_convdelay_ps[chan->channel] = delay_ps;
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1162,6 +1297,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
 					      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

