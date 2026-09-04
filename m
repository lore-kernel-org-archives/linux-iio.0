Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0934AA001;
	Fri,  4 Sep 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531400; cv=none; b=mtYWNoL9xHbP6xcOSsiUFZS+yOu+K1da6s++pMHvjUUYhJWAgATxfIlFzQys0xZiESjmZVxw9zp91e1/XS3uFcdHe1t4Be8iXyKHfPWWf9d+/WT88IdcS9MZOvTbRJVbWlPgqe7BHn3H77IU3QiaWOg/BxUjLuGCAY1Ln5UzlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531400; c=relaxed/simple;
	bh=oO4uo+23np++Y/7p+i4afFeckxmNLvOBTrgRTMXkKNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X3kQp5ACmKns92eh0vI1XXcbvxm/TGvJC6Yt0N9t5dZY8zM2NsjOu1Pnq1xno4bNuGi1bKaE/6lZJmjo5ojokrwyF4nNC5ls/1Xh9aQB58TbuSxkl4RcRB5Adh/1BSjU3KD0H4C1JXhsErCTqSqZBWNRbYwX+y9Qk2DQydc1Ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sf0cHVdW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sf0cHVdW"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgAwZ4068362;
	Fri, 4 Sep 2026 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y9Vbe
	GYZ6t5zqTdxpfkCh99pvOxr18SIRZzn0cGA0zs=; b=sf0cHVdWDdBAZNMdmR/oz
	uSGjOsxYuVB5cwTz/ciB/tEOsTaXHoQqcji6DSIUeFg5MKsJLtrlOfHK0oLOKASJ
	RrVhnVhNlgaH1/mOGh57uuJjpfWpSHLca09ki3auSkyCre7W5N+nb+C2rwRfHKei
	kLLGJRLzZiGTc06CiPIbh2K/p9SDfRKVo+mQqqXhstv+F5EVC5zksIdK+MtOiSg/
	g/LiSw91C94J94PZ5CHEpVtT1SL55QP4OeyKw1U0MmA+yfxMN6PXBH8XCj38d0ZJ
	oJ3XYOqHtbHB5ubEINVBv80aZqevv1p8+WsMyp8v4Sk9iZwIqigw05EV1MtzaQDa
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfxaw0d5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGGWO036381
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:16 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dI026210;
	Fri, 4 Sep 2026 10:16:08 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:06 +0200
Subject: [PATCH v6 14/17] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-14-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=6229;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=oO4uo+23np++Y/7p+i4afFeckxmNLvOBTrgRTMXkKNo=;
 b=XR9GdIAvfnSYbkPjEemRc9BSqFAQTKXSAOi8d8wR7BXjhWjppNUzuMJCKgGcV670YztgrYo//
 uyv39/9r+nXAmN6FBl8KYnZPCyLOMv+QzcJW4Kng+ryDQb+2CQYllW2
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UNnt2ify c=1 sm=1 tr=0 ts=6a9ad2b2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=g92PuHId75YPrMRR_n4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX4upwTGOIv02y
 p2OaaC1rfyJD5QjUhZ+4YBgOFqnXV5UAXrMWSBUQn8ntKoy1qOhMqZWMe59fi3bixJU27wSJwkI
 J8U2AtlPcjJvAl2U+kDECsQmF2WOckuifphveCT5HrniT0hkM+W7
X-Proofpoint-GUID: Sds-tBiCN7FFCY2FzxopRCCAgXtUJI3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX7QN9ZVd2jRO6
 x/+7TNfEW9Dh034LysHn+Cg6nx7QRzxx5aWbm7OvlWpmemKos/yPxcSkYuMxHRHBgHIMgmhwDk7
 IHXT2p2b4ImPm258MwbvJYEfziVereBkPvgjAss7ULG5wsP5qr/uxJI0OGlsD1Lpx3oeM1eakPh
 BLEH22luh+uvJlywky5PblGMX0d6xXZH8a8MyRUWWGJDj1B4bnnPNHbleY4Oi0EJAceXoqM17oX
 UA8QNuQWkefr7yy+YXO6OHrDx9sMwMW7Iy4Pch+fMsfVY2cWiKUUxV+Opn4sjgkERJ7r1hKwz7M
 6lKZcYrmTXkB+LM2VbgWkoRHxh6h5RpTj9C759g5haj2zWBjm94yf0bntwMjuktKtzOGiu6VwvM
 qDiKMSlVxoj4JWbADbIBtyVaw0BRq6jxWe4FSGw0dY9c3q+42lYlCqIvTrXF56NAFMdIeCfXerB
 mMn2uXxBezNzxiH9U+Q==
X-Proofpoint-ORIG-GUID: Sds-tBiCN7FFCY2FzxopRCCAgXtUJI3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Expose the per-channel synchronization phase offset through the IIO
conversion-delay attribute.

Derive the delay resolution from MCLK, power mode and decimation rate.
Validate the requested delay and program the corresponding phase
register when applying the active channel configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 802666f7abd4..9c6bebb1857f 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -149,6 +149,12 @@ struct ad7768_freq_config {
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
@@ -175,6 +181,7 @@ struct ad7768_state {
 	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	unsigned int power_mode_idx;
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
@@ -246,6 +253,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
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
@@ -665,6 +678,92 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 	return -EINVAL;
 }
 
+static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
+				       struct ad7768_convdelay_params *params)
+{
+	const struct ad7768_freq_config *freq_cfg;
+	unsigned int dec_rate;
+	unsigned int mclk_div;
+	u64 mclk;
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
+	if (!mclk)
+		return -EINVAL;
+
+	mclk_div = ad7768_power_modes[st->power_mode_idx].mclk_div;
+	params->step_ps =
+		DIV_ROUND_CLOSEST_ULL(mult * PSEC_PER_SEC * mclk_div, mclk);
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
+	max_delay_ps = (u64)params.max_raw * params.step_ps;
+	if (delay_ps > max_delay_ps)
+		return -EINVAL;
+
+	raw = DIV_ROUND_CLOSEST_ULL(delay_ps, params.step_ps);
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
@@ -771,6 +870,16 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -891,6 +1000,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		*val = calib;
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
@@ -904,6 +1020,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -915,6 +1033,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int base_reg;
+	s64 delay_ps;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
@@ -935,6 +1054,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 
 		base_reg = ad7768_get_calib_reg_base(st, chan, true);
 		return ad7768_write_calib_value(st, base_reg, val);
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
@@ -1151,6 +1279,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
 					      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

