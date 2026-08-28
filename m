Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2F371D01;
	Fri, 28 Aug 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931095; cv=none; b=ew7+ayJ3RG0axVdJ5BGjPwjugTYsURlN4jv2SwLQyDc5YraDEmMd3ODVUcNaEuJAT7XgK19WBegh/zvdyfTaMJPiYxdWXWxN5rA3Z94mUCMtC4lGtFFRNoicVbHcojuNG2bvFCBLx7NjocbV6tb4YWbFCZNFX24ZRsTj+V7eRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931095; c=relaxed/simple;
	bh=4W1tQg6rf8oywE+TtuI292VI79BUIB+y2apu24unE8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ECx5qWcnBDOV6xkaq16GvyeNfaiU5wh1KUn1o4AMed5WH9BuzzzrynRolc2yhAZzqUOp528sabRsgCtWWQjKlrA9oJSePj9vJoZUZp4+Oxl3JZauQIjZplmEIUWGP/+Nk02m08h5EhOJA/gEIdcgdl6yi3Q/qXfK4eomd1ZQnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bamHc7HC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bamHc7HC"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWNAL2013140;
	Fri, 28 Aug 2026 11:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vky9z
	f6IKq94zNT3C8XYumR9KIQ52T1ySwKVLnm6vK0=; b=bamHc7HCxhKxqhJGeuN3I
	IHU+kCkO+81lQmu1GbfRfsMxdIsUhtIGjG7uLc/K914Z/mbzlZ2/WG29SL7M3irP
	TjM2ysLy8s1JRKzaFRkPMKgRC75JWR6Z/e5MipgADddofAucTjvk2f32CpWC8W62
	02kCGEfQrka3sBfHhNBe83LEAW1bsN0TSmTgjSSVvx97OnKCXVAu6/86bOodyZBt
	BjYX3YWZU1TGdQeT8ZoFslBvoIPBVlSmnDNLtgR2J8A7IRZ/8dTbNgi8OIZ22kqw
	2lA1LXcZrC7dJiHZDma2f6FB/smQE1nep2S7bs365pWc6Hk81g1PpHsFZRlyjwMn
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m14exg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVMM3013051
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:21 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3n031424;
	Fri, 28 Aug 2026 11:31:16 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:31 +0200
Subject: [PATCH v5 08/20] iio: adc: ad7768: Derive output data rates
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-8-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=8004;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=4W1tQg6rf8oywE+TtuI292VI79BUIB+y2apu24unE8A=;
 b=Wa3hUamtqZbfbZtvlx84xsVF65EobEvZTAU8JAlgSM+PJmOY1Z3MultgmdN/ls2OABLbdOmpW
 0oDB/+daI2gBiE/6It5wekODcsxk+nhUrJllMqiLQTyO59xmuC+txcI
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VxybT15hMv-M9cTy3aeAFL_a0MashqV5
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91a9cb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=Q8OhHFwT6lX-Zkp3stoA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: VxybT15hMv-M9cTy3aeAFL_a0MashqV5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX+0/gVpHhXmc8
 dJhItbncXt9n+a2HO+iUefO11WFj1rnSPvmOIjmUGRAueXtEANGJwbRb4yP8jzo/OMA/jkclOhu
 DpVBjGayFrM69xHoj1nRy9YCRcFIO3XqcCil5GHdMVIEDbVvm41gOw4KgvEX/lxiG4y/Zwvp1Xa
 1NLCubpn9FfCCJAWEiVQNMY0NyGtmQbhirgONqq6LWKuXkFT70PehmCt7+anp1xY6u7imFQ1m3x
 blx6d2YN7t+EontoBC2qWBH9yViOBFaLy+0HAxDpwslqNUiDhrUrDsiV+JHvVy78pVfxi7v8hUs
 0GvM5dkaE4qXnyYQP6DWdLEPLt5ElNFLdzlW8D/Aehi4GeAr9ZXRDwyDvYCePNqkRQC2u9s5ecc
 Ss0mSOt07PR4ydIt5hnJCstXA2DU+RDvcY4cx5OdT1xjpaiX6bomenOwzv8u3b7Ys2B7IT/GavZ
 aFqlxxl5jhKUxB0TZdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX0OPKLPkGLW79
 iCn8p4MY/CJOo5pK1RtoQcOZya4MqDeDjGkLlV8qR1z/bvFlIvaU99MvEV1viE8vJVckUc6WaEG
 PTFWtftzItP8bZwb2i6qIu4CW8ziS7/OlfsEhLm+syGI7G3JS4Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Derive valid output data rates from the master clock, power mode and
decimation ratio.

Replace the fixed x64 decimation and open-coded DCLK divider in
ad7768_configure_capture() with the derived default output rate and the
new decimation and clock-divider helpers. Select the maximum rate
supported by the configured data interface for the initial capture
configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 144 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 67db6f4971a2..09b4e2f32304 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -36,7 +37,6 @@
 #define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
 #define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
 #define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
-#define     AD7768_CH_MODE_DEC_RATE_64			0x1
 
 #define AD7768_REG_CH_MODE_SEL				0x03
 
@@ -103,9 +103,12 @@
 #define AD7768_SPI_REG_MASK				GENMASK(14, 8)
 #define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
 
+#define AD7768_SAMPLE_SIZE				32
+#define AD7768_MAX_DCLK_DIV				8
 #define AD7768_MIN_MCLK_FREQ_HZ				(1150 * HZ_PER_KHZ)
 #define AD7768_MIN_XTAL_FREQ_HZ				(8 * HZ_PER_MHZ)
 #define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
+#define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 
 enum ad7768_clock_source {
@@ -132,6 +135,16 @@ struct ad7768_precharge_config {
 	bool refbufn;
 };
 
+struct ad7768_freq_config {
+	unsigned int freq_hz;
+	unsigned int dec_rate;
+};
+
+struct ad7768_avail_freq {
+	unsigned int n_freqs;
+	struct ad7768_freq_config freq_cfg[AD7768_MAX_FREQ_PER_MODE];
+};
+
 struct ad7768_chip_info {
 	const char *name;
 	unsigned int num_channels;
@@ -151,12 +164,18 @@ struct ad7768_state {
 	enum ad7768_clock_source clock_source;
 	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
+	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
 
+static const unsigned int ad7768_dec_rate[AD7768_MAX_FREQ_PER_MODE] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
 static const unsigned int ad7768_available_datalines[] = {
 	1, 2, 8,
 };
@@ -377,6 +396,70 @@ static int ad7768_set_power_mode(struct ad7768_state *st,
 	return 0;
 }
 
+static const struct ad7768_freq_config *
+ad7768_find_freq_config(const struct ad7768_state *st,
+			unsigned int mode_idx, unsigned int freq)
+{
+	const struct ad7768_avail_freq *avail_freq = &st->avail_freq[mode_idx];
+
+	for (unsigned int i = 0; i < avail_freq->n_freqs; i++) {
+		if (freq == avail_freq->freq_cfg[i].freq_hz)
+			return &avail_freq->freq_cfg[i];
+	}
+
+	return NULL;
+}
+
+static int ad7768_set_clk_divs(struct ad7768_state *st, unsigned int freq)
+{
+	const struct ad7768_freq_config *freq_cfg;
+	unsigned int mclk, dclk, dclk_div;
+	unsigned int chan_per_doutx;
+	unsigned int dclk_div_reg;
+
+	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
+	if (!freq_cfg)
+		return -EINVAL;
+
+	mclk = clk_get_rate(st->mclk);
+	chan_per_doutx = st->chip_info->num_channels / st->datalines;
+	if (!chan_per_doutx)
+		return -EINVAL;
+
+	dclk = freq_cfg->freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
+	if (!dclk || dclk > mclk)
+		return -EINVAL;
+
+	/* Set the divider to the next-lowest supported power of two. */
+	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
+	if (dclk_div > AD7768_MAX_DCLK_DIV)
+		dclk_div = AD7768_MAX_DCLK_DIV;
+	else
+		dclk_div = rounddown_pow_of_two(dclk_div);
+
+	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
+
+	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+					     dclk_div_reg));
+}
+
+static int ad7768_set_mode_decimation(struct ad7768_state *st,
+				      unsigned int freq, unsigned int mode)
+{
+	const struct ad7768_freq_config *freq_cfg;
+
+	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
+	if (!freq_cfg)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+				  AD7768_CH_MODE_DEC_RATE_MSK,
+				  FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
+					     freq_cfg->dec_rate));
+}
+
 static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -519,28 +602,58 @@ static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
 }
 
+static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
+{
+	unsigned int mclk = clk_get_rate(st->mclk);
+
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
+		struct ad7768_avail_freq *avail_freq;
+
+		avail_freq = &st->avail_freq[mode_idx];
+		for (unsigned int dec = ARRAY_SIZE(ad7768_dec_rate); dec > 0;
+		     dec--) {
+			struct ad7768_freq_config *freq_cfg;
+
+			freq_cfg = &avail_freq->freq_cfg[avail_freq->n_freqs++];
+			freq_cfg->dec_rate = dec - 1;
+			freq_cfg->freq_hz = mclk /
+				(ad7768_dec_rate[dec - 1] *
+				 ad7768_power_modes[mode_idx].mclk_div);
+		}
+	}
+
+	/* One DOUT line cannot carry the AD7768 fast-mode x32 output rate. */
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[ARRAY_SIZE(ad7768_power_modes) - 1].n_freqs--;
+}
+
 static int ad7768_configure_capture(struct ad7768_state *st)
 {
-	unsigned int dclk_div_reg;
+	const struct ad7768_avail_freq *avail_freq;
+	unsigned int default_freq;
 	unsigned int mode_config;
-	unsigned int dclk_div;
 	int ret;
 
 	ret = ad7768_set_power_mode(st, ARRAY_SIZE(ad7768_power_modes) - 1);
 	if (ret)
 		return ret;
 
-	/*
-	 * Start with the wideband filter and a decimation rate of 64. This
-	 * supports every valid data-line configuration at the maximum MCLK.
-	 */
+	avail_freq = &st->avail_freq[st->power_mode_idx];
+	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq_hz;
+	for (unsigned int channel = 0;
+	     channel < st->chip_info->num_channels; channel++)
+		st->ch_freq[channel] = default_freq;
+
+	ret = ad7768_set_mode_decimation(st, default_freq, 0);
+	if (ret)
+		return ret;
+
 	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
 				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
-	mode_config |= FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
-				  AD7768_CH_MODE_DEC_RATE_64);
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK |
-				 AD7768_CH_MODE_DEC_RATE_MSK,
+				 AD7768_CH_MODE_FILTER_TYPE_MSK,
 				 mode_config);
 	if (ret)
 		return ret;
@@ -549,12 +662,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	if (ret)
 		return ret;
 
-	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
-	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
-	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
-				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-					    dclk_div_reg));
+	ret = ad7768_set_clk_divs(st, default_freq);
 	if (ret)
 		return ret;
 
@@ -677,6 +785,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid data-lines-number %d for %s\n",
 				     st->datalines, st->chip_info->name);
 
+	ad7768_set_available_sampling_freqs(st);
+
 	return ad7768_configure_capture(st);
 }
 

-- 
2.43.0

