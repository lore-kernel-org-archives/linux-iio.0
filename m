Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497EE37D123;
	Fri, 28 Aug 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931116; cv=none; b=b7LxK5+1cM3voOihvsFdBvKFzYcA3OMKuyO9FIyPiTR/NLKR2es5HmO+3L3J1Q38axUDSt0EwHfGYpY76faBiSxobET1DjdPvD3kuxRWGM+jDwUziURuC7US05iSMQUi6cJBumJExy5fcCY2QMdHynLZ3+hGFjEMUiMGaP4Hlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931116; c=relaxed/simple;
	bh=8R44WiSWc5C8CuII5XNxbwdk18kSc6TANR70HZFXLI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jkAkh1D243c3CiarWqEyn0WM/Led5wfospeDM4d3Y3+IQq8gU4vJU+zV8owlghpoDyDifh3NgQZ+sG9SlYSvvb/EOOXfWlqhQ/VwV1sK6qD2cRpR1+xNZ6S5GSDEAgc4/WGijpXDcLIF6EKuk1w8osydwoujwZIO/3MCiNgwJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AZXlnIk8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AZXlnIk8"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVmuR1142384;
	Fri, 28 Aug 2026 11:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WG975
	IkcdjFVsbiHLren9l09hKLAsd9Lqh5VLAbzN84=; b=AZXlnIk8FZiy47nK4pLIP
	TnSaiI6NkCZfN9Gfa7Jz/AA0eb9emWKouyoaezhlW1AUWEUhkvFPNzHD8SuhgGFX
	BhkOLo0nhoiSk4y75y1diGNR3Yct5i1HVgHvo56y0CNFYffvw9ZaOCIiKaL6QQOu
	QlcDaXTu7TZkScMahzuyRCbQOZhLV9sb+8LdUXiFoD9cxjmnyDFo7LptazA1ao3/
	GXODJe0DQvGysWQp+5JrngUFZX9dR3LEty6Zr+zavum9u0J6DTFr7awuUn66zivI
	1KfmnsIhD1UHXkH5L639n/n46cBKYbG/hrOAFFQlJ+2PSp5fEuyTvNpcFZwVYWZA
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVjp0013202
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:45 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3t031424;
	Fri, 28 Aug 2026 11:31:37 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:37 +0200
Subject: [PATCH v5 14/20] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-14-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=6189;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=8R44WiSWc5C8CuII5XNxbwdk18kSc6TANR70HZFXLI4=;
 b=rLFZlnHwd41It0Q7WxZxDEQ38c3sQwosHDuq5+VOJM1Siq4n48dg0xKarokUmubv6CtFOYuVY
 IYELaAbvIQlDMrXXMt5q4fZgPIl12eIU9SE36ae2dmT3iTRp8RsQLrn
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rjezPWwAEVDNhTzHXrkXQ1KpSeG-RBP0
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9e2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=Q-mZ1VjmJmedMbfahesA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rjezPWwAEVDNhTzHXrkXQ1KpSeG-RBP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX9Yrz9tbN5Myf
 xdVt9/xAOPI5Y4AoFJOOWapdCLlZxDoDMK7PBhB/5mJ2HU+u+szmwAvVr7QNtfCAL4WkzbZzK1J
 LhEdMS48YM3N0I3hMVqD/ZvTtMPrKCv8OSIFM3iLAWqSQSaarlxbKYQ0k90juT9zKYjUz1zJvFi
 Zo7ktBLs6iD3LbYO7Zl26bUul1l3DK5fmUcdL/k4WXKbDRYYUVQdu+Re86tJrhmvsdSB8F0ghy1
 qNEr71Y0+3Ax10kb9f+/jf/m//drXGlZGm86FSNei1GDNUslRFTlu3TnIGDlUv9UYAY1OQPOlcN
 jl6ajwee8VHUEdwbH08ZbL6YErIG/oDW9oUpr70qCMoTlK67ZvLLQEC+Jxg99WMpVeotiFx/IJy
 BhdXz+5HOEMM34mBrVjK++ZM9tT/hXQO5y6MX5Re/7RZY4h22hiHc7M7SZJxN4Ab0ML6kDLYgWJ
 odWObe8uxyRJnlF4OpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX62tFqZwzhBU0
 meEUsAVTRxN97m6x1yPm85iLYeLCGhP9yKnH6jTqGH5E2IHqXk8G9PVxkmFYjXi0FoLUm8WvgDe
 vnYuIEN4MFQqnp0+gYm3vM4Mi15yX+jlvyg6N60fhTZp8HBVqtLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

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
index f2f318ebf964..4133e3a033b4 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -154,6 +154,12 @@ struct ad7768_freq_config {
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
@@ -182,6 +188,7 @@ struct ad7768_state {
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
@@ -251,6 +258,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
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
@@ -661,6 +674,92 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 	return -EINVAL;
 }
 
+static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
+				       struct ad7768_convdelay_params *params)
+{
+	const struct ad7768_freq_config *freq_cfg;
+	unsigned int dec_rate;
+	unsigned int mclk_div;
+	unsigned int mult;
+	u64 mclk;
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
+	params->step_ps = DIV_ROUND_CLOSEST_ULL((u64)mult * PSEC_PER_SEC *
+						mclk_div, mclk);
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
@@ -766,6 +865,16 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -880,6 +989,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -893,6 +1009,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -904,6 +1022,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int base_reg;
+	s64 delay_ps;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
@@ -924,6 +1043,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 
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
@@ -1141,6 +1269,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.type = IIO_VOLTAGE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SCALE) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =

-- 
2.43.0

