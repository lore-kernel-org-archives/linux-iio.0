Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93882480DE8;
	Thu, 13 Aug 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629498; cv=none; b=YtkD2zZmV6peYAiCXBUbcx6TNJkfLh8qR04/lvhJEP9rxAG+sh5iLOy259nRI0/EnRHYNXfvDrqEsvRRjZbHW9mujjx3HibZUIo9XqLp6DvU4telmM4kV+EtzyLGXHxwg8johEyXWBv2mOx9BPB/vJlQ6+UCgkv7xKXGC6NwkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629498; c=relaxed/simple;
	bh=031BCJtxUXX6B1ACSYHhPP3qepuD5qBFVO6CqEsk818=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eVDJnnBwVhrDUHPH+8815zeqoiNuqC+c7eC3IroZ/j73Rb6k6e5rQSZOA4KLKX88IyMvjwUiAuiGM8OEgTq43baNvab9fQOKUzjfWRl8LUOpSUyxOxWNubmL3ac+mvkqCrsjkQnl0/bS+Y0b14se9+g1k8C/aCVAcM2LagAb0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X35Sljl8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X35Sljl8"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCdCeL1876660;
	Thu, 13 Aug 2026 09:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2doGa
	yEixqGplIb8Uz/5lY28sycBGbNDX8ArpvHDKBA=; b=X35Sljl8NFGqONduW0A2x
	pFJsuSDkqLBI97Hmbe++PIN/7WnJQPkU3c8oG7HUKmJQiEH6MMnelXNnApH2nooK
	ngy4r9xvABVp1GwDE9NVh4w6h46izEuszsMOPN8qigsDPgpK/0m7NJ6j2zTtLBSY
	5dnZP4DmXip+o3vVu6pNcmDTztbG7iZNlPIYJikyFJl3fi/79hQu60fdIyYgLcT3
	IeqWeQ5oXHQxNRT7TB9etqFm13HFZNEH+s2pbjUPFQortJY8V0cI/2l3MmtiSN2M
	+MEjyJivdhFZRzDdKld6dFdwa05cfPUE+lCCWszgFI8GG14EQhwFRytQMh9wemeV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e4b0dbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDw4b2024657
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:04 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwa006802;
	Thu, 13 Aug 2026 09:57:57 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:01 +0200
Subject: [PATCH v3 08/14] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-8-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=6597;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=031BCJtxUXX6B1ACSYHhPP3qepuD5qBFVO6CqEsk818=;
 b=VbNLVJoUxz4enrfdt5d0rfzXiurlXAeKtmvrie8zhxzxwCE83jTav5ExZ6twoVmHhVjH1ih9+
 pg1+mR+sR5qAkxQATRnXu3dPAm37HNUrOiDkdOXx+6t8jG79hNN4fyz
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QqrjfuwdIanX5wvb2DZIvfEj53E7jlT5
X-Proofpoint-ORIG-GUID: QqrjfuwdIanX5wvb2DZIvfEj53E7jlT5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXyNHngJbgKKbD
 cShjb+idVsn5XdhJXCdnPu8iEx3FXSSkcVb49EaVfI0Isl1ltU5PQVSJMIHO8UH97ADwg9afwBn
 yLegSjW0dFP0AOTZAxo/Fl2u1BY6GNBZR5fo7JLB/tSqUb053uQJ
X-Authority-Analysis: v=2.4 cv=ZZYt8MVA c=1 sm=1 tr=0 ts=6a7dcd6d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=QS77uNcazL5vWiXudcsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX9HmA9/Ug+oki
 gSMlw6S3gQGZo/5qT/NJ2vvQ6xITf7xKEulbNZKoNRS6kTZxzdw3qX7eShLwk4XAx464+HuhEB+
 0GdvInUS3LoGWsZ4VchxKA0uUOHdvu4rLfo/Qw7ZHdmjlXMF8OU5GFHfnnmysufytvsGy0JJbxv
 +chA6NyabSouXAbTjMwVjfMDNVIaqF4Ub8K52Y2f8wgCVN7GhN2EjGxpIOLUDOQE8zb0ZaojivW
 GHyKDi5IeaQwshCI+NNPc+yiYw0Cl/PtVbPDCduwi6pkrdJqbgw7PIpbZoFON0yCLDoAXk0/g3b
 VI6VGX0/jqzoezgiB74beYEYmle1yzRAvttN8As4DqXN9CiTO/Rko/O+rTuTDpILwAYa636Z56M
 eLT4b3jQBcCCXBNhmt4o4qTCuqyizsgFd0s+8TkVtUjnI0xxd6z4mqtR3vqHOCcAasf3i08Q/nS
 ZbHWsmEDSfv/BleXdhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Expose the per-channel synchronization phase offset through the IIO
conversion-delay attribute.

Derive the delay resolution from MCLK, power mode and decimation rate.
Validate the requested delay and program the corresponding phase
register when applying the active channel configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 08721079bb37..d332695cc75d 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
@@ -130,6 +131,12 @@ struct ad7768_freq_config {
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
 	unsigned int freqs[MAX_FREQ_PER_MODE];
@@ -157,6 +164,7 @@ struct ad7768_state {
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 
@@ -223,6 +231,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
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
@@ -569,6 +583,105 @@ static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int ad7768_get_freq_cfg(struct ad7768_state *st, unsigned int freq,
+			       struct ad7768_freq_config *f_cfg)
+{
+	for (unsigned int i = 0;
+	     i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		*f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg->freq_hz)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
+				       struct ad7768_convdelay_params *params)
+{
+	struct ad7768_freq_config f_cfg;
+	unsigned int dec_rate;
+	unsigned int mult;
+	u64 mclk;
+	int ret;
+
+	ret = ad7768_get_freq_cfg(st, st->ch_freq[ch], &f_cfg);
+	if (ret)
+		return ret;
+
+	dec_rate = ad7768_dec_rate[f_cfg.dec_rate];
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
+	params->step_ps = DIV_ROUND_CLOSEST_ULL((u64)mult *
+						PSEC_PER_SEC *
+						ad7768_mclk_div[st->power_mode],
+						mclk);
+
+	return 0;
+}
+
+static int ad7768_set_channel_convdelay(struct ad7768_state *st,
+					unsigned int ch)
+{
+	struct ad7768_convdelay_params params;
+	u64 delay_ps = st->ch_convdelay_ps[ch];
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
@@ -687,6 +800,19 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		max_freq = max(max_freq, mode_freq[mode]);
 	}
 
+	for (c = 0; c < st->chip_info->num_channels; c++) {
+		if (!test_bit(c, scan_mask))
+			continue;
+
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
@@ -737,6 +863,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		*val = calib;
 		return IIO_VAL_INT;
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
@@ -750,6 +883,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -760,6 +895,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	s64 delay_ps;
 	unsigned int base_reg;
 	int ret;
 
@@ -787,6 +923,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 
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
@@ -1080,6 +1225,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.type = IIO_VOLTAGE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

