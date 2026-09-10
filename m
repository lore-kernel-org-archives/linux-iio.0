Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8E583AA8;
	Thu, 10 Sep 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061913; cv=none; b=QbXAcSRcwZFQWA2eoDlepgjuuyM+zJW3pfWe8aZokNQ+kWef2ZUe5Rmd6tIoJSsFTxJgS1csGy6Yz0tGz3pXzUALvIioVBYgyxLpNxXIOFCLpNiD4nb/5P/NZ0j87pezs/MbaVzNodi6q3xCDWj3Q0wHa0C/b/q1Le5+o5ZlK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061913; c=relaxed/simple;
	bh=/VcY3CjOlmZJf5G7BG8OojUcmtvwrGQrV4aA2S/NBK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FIWVeM/UEYa1CtA/xvdFpJbMkSei812ZTcoZTD6wjyuBoClaBjmTPmmGfX59fVZjuOi2LzK5BHQfz/YHnMmtwsZUolGSjWM8U2LCzHcB3OkzIBCt7qL5j1wWuTpne6xHbsnCmvQokzTHZF5NdKbGzvjxP0X/nbW+41V0kYI5ocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vUI7YX+5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vUI7YX+5"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF8Gkg094915;
	Thu, 10 Sep 2026 13:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TaJLM
	cW9sz7V12rkFKur5T4gS/+VztAzbvh7/TTZOo0=; b=vUI7YX+5vzrej2UNUl49Y
	6/okbsJ4Lc3yc8grXqvFaPtcN6b9woaUFaXe2/KJHDWH8q5UGlSq8fPFU5mCOjHK
	RLkb7hhWveb92wC9pAloHE8+JoopOZRPqmufrJvF1VaSGkVrEdjiPXdqmctMN5Xa
	KYd6+eKGPl/3TqjSjvw9kswutJrk67pZpJq9jaBfoe6Vfwe91NvJ/J6WRFRSjJd0
	txqM4etvAtHgHfDjht7+7VSEboT+7/2Qw+da16uQRYI4SNOF28hG5VS3+Kiyz+ZV
	RgrLDG+XwBKUC6CJrdbb7qkWUbfvmnB0AhQCwc9wZ3HZQANF5jLhB2/2k5Air/2k
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcw1sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHblQ0038859
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:37:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:47 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSk018832;
	Thu, 10 Sep 2026 13:37:39 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:32 +0200
Subject: [PATCH v7 14/17] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-14-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=6551;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=/VcY3CjOlmZJf5G7BG8OojUcmtvwrGQrV4aA2S/NBK8=;
 b=1rl/Y7VFhaz5KRyuPPiLMtyv/Q25kPYzgcAW/Ue4Rj/ZHaLSfUo+TJ4zNclfVyvdQKnH8VLsX
 hfLFtnWkpkFAqI5tvdT7//fjeyO5fSgxnd37zwyLPVrqFJLQ375B1Qd
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX1kHM+uNcBbpA
 RlPHVrAXJueZgxZd6Yl7qQNBXicvDeL4as7RegwciT4KyKq7Vwz4SsCNMV5gzu+4Y9CHpRxFBLc
 Qcy02XResanFc2asfZjMsg7Bc1Y9I86ez3HNjY6q6TKvFPzi79aZqs3ATauvmUE5Swduy3mr7LM
 6a14qi5ojBeLv9w0Gu7KRZkJjwbsykZas8Owx5IYKp4RoBNETv+65oSVcoaKjGgYqUKOrHclmKZ
 vbUVU6kz/80ex0owO/+U9c8LKYvvtdfc/WCNrt1TXNVJxxpBE9eQuCpDJxa2LcaWJkmRtJcHtJP
 027SXZYsNJGjhWQbGeJwvC6M9DRzPaEnieoYqBxY+ewlWj/NTiADE4LL4S4QnU7beKuv//HPuRS
 I+V+L0Bsosm3+c0OM/EzJvIjMNbPdD2UIIOZh/MCoobukPSai2SNn4OR5V4bUd06lMUS7KGQJny
 o2fpG4I6h3RNfM/nQzg==
X-Authority-Analysis: v=2.4 cv=GoTXaU1C c=1 sm=1 tr=0 ts=6aa2eaec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=g92PuHId75YPrMRR_n4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX1vP/rj+b3w7u
 SZEYyJ9vKQQcGwN0wWCQmMbHjUM8Ih+0hAFgKlq+RJBQ/Kx+448K26SI4ydW63vzpANzO8ec7qm
 Dn9F0rdTVltyqxQ85osNzkx6QD49/7S7VdC3ZDmXip7B44Ubsz0j
X-Proofpoint-GUID: _TZJoTvptRxXVp30NOw9cBXHj7y0Qtsf
X-Proofpoint-ORIG-GUID: _TZJoTvptRxXVp30NOw9cBXHj7y0Qtsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

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
index ab82355c839a..941fdac634a6 100644
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
@@ -249,6 +256,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
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
@@ -686,6 +699,99 @@ static int ad7768_find_matching_mode(const bool *mode_used,
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
@@ -792,6 +898,16 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -910,6 +1026,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
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
@@ -923,6 +1046,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -934,6 +1059,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int base_reg;
+	s64 delay_ps;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
@@ -948,6 +1074,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
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
@@ -1164,6 +1299,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
 					      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

