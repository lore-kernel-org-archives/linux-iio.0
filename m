Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8F4C77AA;
	Fri, 21 Aug 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321322; cv=none; b=paPS9m3J4AOBdbpI4qsubylTbFHb++KWCDo3RhGlA+xMKu4pkd+pi5jWCRUfe5frvVe8yGxCEzz7nAx8lHuHz2kTk8+DT1et5SALlQDsBZGcN0dU7K7X2LyaEcS3BuR3KkEp3xKNeCbti0I2NW5TNZwPmcWyhK9RUFVYep3Cgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321322; c=relaxed/simple;
	bh=CARzdsTcg5q47aobGrotmIqT738dJfNyAFz3iOVaszo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V/40EZM75qwZIJjbOfFYxZ0nYfonW5V1JWZli7fi9+EbXhE9Dl2EbGoarUcs8b9xmMoaLoQA/x/1m2H+MxuXoTAGAMTQrc0MGt2GiZdp0VO5rfWgouzOXmeK5VQNXbWP4k25jBNUuhhO+Bgk2ybyGZLedbVbp357ylUV8bwgpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=naLKK23g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="naLKK23g"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpb5C3677854;
	Fri, 21 Aug 2026 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZDcBb
	qJFqYyAkk5t4m1+gc6kyIV4HFBDP5L9b5548WM=; b=naLKK23g6c596r6CvpD2a
	cRywhd5W2hyzcKYEgdzHaZ9qz5pCHbLfF30zj7lrZwrGBAKvNMFXEgJvavYnKlDk
	VywXi2O35Oabjg/NDrbrwxPQ3526I3y4dOgrol/m7ekEuji8mNvN92kJuKGn2YWA
	lkAPXMSYSNTwJIShiHJ8zt3SYY5sxaZ6bZViTtb9plVRliAqOkR0QeJz51OLI93t
	RN8C6N1MRgm6cYHFZln4uGbJjCfLe1dlMTnUy0ym3UQe5ueR1L5rLWSFfkWmHenc
	u9pgDtJsEIPRScQIEtfybuNUDHxPGTThifOonscLjutfUpjFa+zAHBuCulPsnjET
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g6a27k401-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8T8A033029
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 10:08:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:29 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkr024319;
	Fri, 21 Aug 2026 10:08:18 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:07:01 +0200
Subject: [PATCH v4 08/14] iio: adc: ad7768: Add per-channel conversion
 delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-8-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=6649;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=CARzdsTcg5q47aobGrotmIqT738dJfNyAFz3iOVaszo=;
 b=fe+XUTZv68UXI0cOiNVCVIgSgVl8SwmT5wl8M+7O9uY/GcfeNbaHn14uhVDOdODiXQdC+q0ZR
 //Oogj8fx7MAVYZ3hczxb0y0o10XKsBexkSNGgYRzYCqqLibdhyyloj
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: HYpPAXB9yM-6kXLt5RVit9Elg_-9nrtM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX7q8ukF1lJVIA
 50D4ba86ODhDUCJQNN+n3zGJGGA+vTHH/RSoYLyqFXpNd8M1ZeH8DIpj3Ps8wUT2ZLC+nfkwe2D
 xDW/fFceQFQ03h+E2PtcP8mweV0fUfV5ALsh+w9DUxLB+Q+xvmCX
X-Authority-Analysis: v=2.4 cv=FeoHAp+6 c=1 sm=1 tr=0 ts=6a885bdf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=QS77uNcazL5vWiXudcsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HYpPAXB9yM-6kXLt5RVit9Elg_-9nrtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX619twwc6PVLx
 xEm1UvtqmYowbLqDsHjohTFepzI0m6krzUEnqyDBCLB22jiJqqyQswgcZo3HYV8rA9MozIab+Bq
 tcWjO1MyB1+hOxb3YYG3U1FCsVCQm7jemVp8KUz59kwnr7UX0s+cpcKeCGcDTTndqQz9KFF9m4S
 VUWjPzXb6Sw2Eb1HUH3LqW8vSaJqs73Bcrh8hZ+URXO4U/ysZO3WG3vwfym5+enz8+WJcn+VSmA
 uBBsLi9j604qndLoZdwpaFnSBLkmOmXLVS/lv/F4MSVeUW1GWAzGKR2f/KKBXXOrk+W2jFp9uKW
 3UYNVKU9kY6kOwCqktQ5rypgvA1jhmi6ifHvrjd1yXqRuSpqe6xPhFvyqZx9J0qR6sVoC/lpwvx
 VYscmJeG8IfwxdM27Lf63yr1tLqIRawo5dmKSBEkSZJtq4n6QSexXWyc4Lwj/9qSt4kYu8DuvTc
 EcT4XPbTPhvygMnEjiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Expose the per-channel synchronization phase offset through the IIO
conversion-delay attribute.

Derive the delay resolution from MCLK, power mode and decimation rate.
Validate the requested delay and program the corresponding phase
register when applying the active channel configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 289f3fa3142e..12370139d03f 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
@@ -158,6 +159,12 @@ struct ad7768_freq_config {
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
@@ -187,6 +194,7 @@ struct ad7768_state {
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 
@@ -250,6 +258,12 @@ static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
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
@@ -615,6 +629,105 @@ static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int ad7768_get_freq_cfg(struct ad7768_state *st, unsigned int freq,
+			       struct ad7768_freq_config *f_cfg)
+{
+	for (unsigned int i = 0;
+	     i < st->avail_freq[st->power_mode_idx].n_freqs; i++) {
+		*f_cfg = st->avail_freq[st->power_mode_idx].freq_cfg[i];
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
+	unsigned int mclk_div;
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
@@ -738,6 +851,16 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -788,6 +911,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
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
@@ -801,6 +931,8 @@ static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_DECIMAL64_PICO;
 	default:
 		return -EINVAL;
 	}
@@ -812,6 +944,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int base_reg;
+	s64 delay_ps;
 	int ret;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
@@ -838,6 +971,15 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 
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
@@ -1133,6 +1275,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 			.type = IIO_VOLTAGE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_CONVDELAY) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

