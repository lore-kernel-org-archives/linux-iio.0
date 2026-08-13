Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875A48165B;
	Thu, 13 Aug 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629495; cv=none; b=E+aiTKgWmFaKizXouKy8qhoY+EfZAlSF2UezWpDS0k9yE/dcZhQH6NE2nmGELxTfl011WClXo6lAWpZ/qIM4Lr8T+bT1Id5w26EIjI0SxLgrdtIX/oOZVZbp45rVLHBsH7Hig0b/r2N+WXaGzUT36mRjInmubzOgWp9QnM2Nku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629495; c=relaxed/simple;
	bh=MRlxmvZgUYvkNw2WavYW1bUulKMKjOx0Bzp3UgavGss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c2WhXttL2nQEsxMt/cC4pMLIY7bMHbGPSbcArZOa8fSX5yWZAncPnIdBNm47p2bUHVXk/H6+XFFz0M/ziXm8bQx0cL8VEbnGMMenaHesUhnEsb0bV5okcHjxBuIQ7iCGAtvdOhNGSMoTFgf8m0ELZ1YPdQMteQv2Kz+jhY+nOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BYpKWnK6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BYpKWnK6"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCa9WQ2129076;
	Thu, 13 Aug 2026 09:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OF2Mz
	7c+7fxGrlrx3o7QaxleGrvmmjB4c+JnSruOJZQ=; b=BYpKWnK6DFBl+IAIbix8K
	IesLXaCGsMTAwqoHzyDMiGFssOm4Lw1B4sjKqFR77JnosmCkXKnleyeKV5GQPsYM
	ux1V2sXi4zPovx/Uv0NeTMOMrm9S8MPXncJOMANFUAMWrTStuYVireTpmaX7IFVj
	LxsLtlBqcPzZVZxjgFLB3CCrvUkYy7VqTRBjUTPt45O9pv3EaYNCOFD1NkS/nWl7
	C+vhtoQgdZ4SQfFqzBr0G6rnNCXekiXf4eLW1Kkss9Ia0ehFHILeZlwXuKe14AIF
	00ozinSHX2eVxAbCguLtfMuGLl/FX32mEXWINpkEwiRLzzUcJ1N9FsP+bzztfIGG
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e2wgccm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvx5T024639
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:57:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:59 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwY006802;
	Thu, 13 Aug 2026 09:57:51 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:59 +0200
Subject: [PATCH v3 06/14] iio: adc: ad7768: Add configurable sampling modes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-6-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=20056;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=MRlxmvZgUYvkNw2WavYW1bUulKMKjOx0Bzp3UgavGss=;
 b=PFsKzy01Rfc5j+toAiZddIUJTJ8X0kfwbr4NnW89SvJNsQlkzzT0hNBWx79k7EqHj1E4JwL/e
 GZD5t0Lg3HaApA3efJAZbrY1ursfpdMuIjvgWiNqcWsaT8XmRDLj3VK
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXyNd4vnjYYekK
 Zz6NVuER8szyyjcJZXVGbc4udeVJmYrjWqfxjFxYCarRLR9rxrbPrQxGeO9deycF/v75kK2V0qb
 sAvaHzhTNaX+lyqcuR1XtvzB1tj2VRR6U/Xz3xnlNzjtWHMhVXML
X-Proofpoint-GUID: B0XFVwvkd7d-UbMIQ0Jxh5zvaGY2xbj8
X-Authority-Analysis: v=2.4 cv=UJzt2ify c=1 sm=1 tr=0 ts=6a7dcd68 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=1WhRpiEg_uwopUd1aA8A:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX2UaDWbTdwuG3
 P4Xwu2H3+OvlzKCW5Nxswe+XCrN3TVTmI4d1OBKskckHqZ04f1nl6KbWW9vxz8BRhfFGawuyyVr
 3TlfqTUAX2u76gxrUxq3+24i33lY2FBKpM20VVX/prBCrblNGBaj7Ic8RzxfMAWRcEO7BurJEXX
 tWbyiAm/hfkCnmpdAl4KQ7UPs5b7A+S+lJBzPDtviBOP7u1wSEb/yuekt0JgkwWDOuQyU9RFQS5
 q5SfTOQBm0PUS/lEDaCIjVXTxHz9PY2SEq7pkDGwcmieJYR4B/8Gh4KW/v27gaaIISrvvEheowf
 W5iIokhNB9ZBMR5u+bzSyXHQ0qtZgxmapNyrEr9V//pzV5hCA0Ea6JHbcC8qf/5JfXutAsFzFD+
 Lnyg7WNODi2RYU9+4tntk1JDy4Plzd74jsz94D/aC78zOmCn0I2mQGF+IBv6t9VoBe/lqW2mh+r
 FQ4366BKm6A/qiy9Zzw==
X-Proofpoint-ORIG-GUID: B0XFVwvkd7d-UbMIQ0Jxh5zvaGY2xbj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Derive the available output data rates from MCLK and expose per-channel
sampling frequency and filter controls.

Select the fastest compatible power mode for the enabled channels and
map matching sampling frequency and filter combinations onto the two
hardware channel profiles. Configure the data clock divider and wait for
the selected filters to settle before capture.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 507 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 477 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 9b908ce0a1c3..3849f544a1e5 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -94,8 +95,17 @@
 #define   AD7768_SPI_REG_MASK			GENMASK(14, 8)
 #define   AD7768_SPI_DATA_MASK			GENMASK(7, 0)
 #define   AD7768_SAMPLE_SIZE				32
+#define   MAX_FREQ_PER_MODE			6
 #define   AD7768_MAX_CHANNEL  8
+#define   AD7768_NUM_CHANNEL_MODES		2
 #define   AD7768_REV_ID_VAL			0x06
+#define   AD7768_WIDEBAND_SETTLING_SAMPLES	68
+#define   AD7768_SINC5_SETTLING_SAMPLES		7
+
+enum ad7768_filter_type {
+	AD7768_FILTER_TYPE_WIDEBAND,
+	AD7768_FILTER_TYPE_SINC5,
+};
 
 enum ad7768_power_modes {
 	AD7768_LOW_POWER_MODE,
@@ -104,6 +114,8 @@ enum ad7768_power_modes {
 	AD7768_NUM_POWER_MODES
 };
 
+#define AD7768_MAX_FREQS	(MAX_FREQ_PER_MODE + AD7768_NUM_POWER_MODES)
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -111,6 +123,17 @@ struct ad7768_precharge_config {
 	bool refbufn;
 };
 
+struct ad7768_freq_config {
+	unsigned int freq_hz;
+	unsigned int dec_rate;
+};
+
+struct ad7768_avail_freq {
+	unsigned int n_freqs;
+	unsigned int freqs[MAX_FREQ_PER_MODE];
+	struct ad7768_freq_config freq_cfg[MAX_FREQ_PER_MODE];
+};
+
 struct ad7768_chip_info {
 	const char *name;
 	unsigned int num_channels;
@@ -126,12 +149,26 @@ struct ad7768_state {
 	struct mutex lock; /* Protects device register access and configuration */
 	struct clk *mclk;
 	unsigned int datalines;
+	enum ad7768_power_modes power_mode;
 	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[AD7768_NUM_POWER_MODES];
+	unsigned int n_freqs;
+	int freqs[AD7768_MAX_FREQS];
+	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
 
+static const int ad7768_dec_rate[MAX_FREQ_PER_MODE] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
+static const int ad7768_mclk_div[3] = {
+	32, 8, 4,
+};
+
 static const unsigned int ad7768_available_datalines[] = {
 	1, 2, 8,
 };
@@ -323,61 +360,253 @@ static int ad7768_sync(struct ad7768_state *st)
 				  FIELD_PREP(AD7768_DATA_CONTROL_SPI_SYNC_MSK, 1));
 }
 
-static int ad7768_configure_capture(struct ad7768_state *st)
+static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode)
 {
-	unsigned int dclk_div;
 	unsigned int regval;
 	int ret;
 
-	regval = ad7768_map_power_mode_to_regval(AD7768_FAST_MODE);
+	if (mode >= AD7768_NUM_POWER_MODES)
+		return -EINVAL;
+
+	regval = ad7768_map_power_mode_to_regval(mode);
 	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
-				 AD7768_POWER_MODE_POWER_MODE_MSK |
-				 AD7768_POWER_MODE_MCLK_DIV_MSK,
-				 AD7768_POWER_MODE_POWER_MODE(regval) |
-				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK, regval));
+				 AD7768_POWER_MODE_POWER_MODE_MSK,
+				 AD7768_POWER_MODE_POWER_MODE(regval));
 	if (ret)
 		return ret;
 
-	/*
-	 * Start with the wideband filter and a decimation rate of 64. This
-	 * supports every valid data-line configuration at the maximum MCLK.
-	 */
-	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK |
-				 AD7768_CH_MODE_DEC_RATE_MSK,
-				 AD7768_CH_MODE_FILTER_TYPE_MODE(0) |
-				 AD7768_CH_MODE_DEC_RATE_MODE(1));
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK, regval));
 	if (ret)
 		return ret;
 
-	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
+	ret = ad7768_sync(st);
 	if (ret)
 		return ret;
 
-	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
-	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
-				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-				 AD7768_INTERFACE_CFG_DCLK_DIV_MODE(dclk_div));
-	if (ret)
-		return ret;
+	st->power_mode = mode;
 
-	return ad7768_sync(st);
+	return 0;
 }
 
-static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
+static int ad7768_set_clk_divs(struct ad7768_state *st,
+			       unsigned int freq)
+{
+	unsigned int mclk, dclk, dclk_div, i;
+	struct ad7768_freq_config f_cfg = {};
+	unsigned int chan_per_doutx;
+
+	mclk = clk_get_rate(st->mclk);
+
+	chan_per_doutx = st->chip_info->num_channels / st->datalines;
+	if (!chan_per_doutx)
+		return -EINVAL;
+
+	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg.freq_hz)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode].n_freqs)
+		return -EINVAL;
+
+	dclk = f_cfg.freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
+	if (!dclk || dclk > mclk)
+		return -EINVAL;
+
+	/* Set dclk_div to the nearest power of 2 less than the original value */
+	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
+	if (dclk_div > AD7768_MAX_DCLK_DIV)
+		dclk_div = AD7768_MAX_DCLK_DIV;
+	else
+		dclk_div = rounddown_pow_of_two(dclk_div);
+
+	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MODE(dclk_div));
+}
+
+static bool ad7768_freq_supported(const struct ad7768_state *st,
+				  unsigned int mode, unsigned int freq)
+{
+	for (unsigned int i = 0; i < st->avail_freq[mode].n_freqs; i++) {
+		if (freq == st->avail_freq[mode].freq_cfg[i].freq_hz)
+			return true;
+	}
+
+	return false;
+}
+
+static bool ad7768_freq_supported_in_any_mode(const struct ad7768_state *st,
+					      unsigned int freq)
+{
+	for (unsigned int mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		if (ad7768_freq_supported(st, mode, freq))
+			return true;
+	}
+
+	return false;
+}
+
+static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
+					const unsigned long *scan_mask)
+{
+	unsigned int channel;
+	unsigned int mode = AD7768_NUM_POWER_MODES;
+
+	/*
+	 * The output data rate ranges overlap between the power modes. At a
+	 * common ODR, the faster mode has lower noise, so prefer the fastest
+	 * mode that supports every enabled channel.
+	 */
+	while (mode--) {
+		for (channel = 0; channel < st->chip_info->num_channels; channel++) {
+			if (test_bit(channel, scan_mask) &&
+			    !ad7768_freq_supported(st, mode, st->ch_freq[channel]))
+				break;
+		}
+
+		if (channel == st->chip_info->num_channels)
+			return ad7768_set_power_mode(st, mode);
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_set_mode_decimation(struct ad7768_state *st,
+				      unsigned int freq, unsigned int mode)
+{
+	struct ad7768_freq_config f_cfg = {};
+	unsigned int i;
+
+	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
+		if (freq == f_cfg.freq_hz)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode].n_freqs)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+				  AD7768_CH_MODE_DEC_RATE_MSK,
+				  AD7768_CH_MODE_DEC_RATE_MODE(f_cfg.dec_rate));
+}
+
+static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
+				    unsigned int freq, unsigned int ch)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (!freq)
+		return -EINVAL;
+
+	if (!ad7768_freq_supported_in_any_mode(st, freq))
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	st->ch_freq[ch] = freq;
+
+	return 0;
+}
+
+static void ad7768_filter_wait(const unsigned int *mode_freq,
+			       const enum ad7768_filter_type *mode_filter,
+			       const bool *mode_used)
+{
+	unsigned int t_settle_us = 0;
+
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		unsigned int t_mode_us;
+		unsigned int settling_samples;
+
+		if (!mode_used[mode] || !mode_freq[mode])
+			continue;
+
+		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
+			settling_samples = AD7768_SINC5_SETTLING_SAMPLES;
+		else
+			settling_samples = AD7768_WIDEBAND_SETTLING_SAMPLES;
+
+		t_mode_us = DIV_ROUND_UP(settling_samples * USEC_PER_SEC,
+					 mode_freq[mode]);
+		t_settle_us = max(t_settle_us, t_mode_us);
+	}
+
+	if (t_settle_us)
+		fsleep(t_settle_us);
+}
+
+static int ad7768_find_matching_mode(const bool *mode_used,
+				     const unsigned int *mode_freq,
+				     const enum ad7768_filter_type *mode_filter,
+				     unsigned int freq,
+				     enum ad7768_filter_type filter)
+{
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode] ||
+		    (mode_freq[mode] == freq && mode_filter[mode] == filter))
+			return mode;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES];
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES];
+	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	unsigned int channel_mask;
 	unsigned int standby_mask;
+	unsigned int max_freq = 0;
 	unsigned int c;
-	int ret;
+	int mode, ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = ad7768_set_lowest_noise_mode(st, scan_mask);
+	if (ret == -EINVAL)
+		return dev_err_probe(regmap_get_device(st->regmap), ret,
+				     "No power mode supports all enabled channel frequencies\n");
+	if (ret)
+		return ret;
 
 	channel_mask = ad7768_all_channels_mask(st);
 	standby_mask = channel_mask;
+
 	for (c = 0; c < st->chip_info->num_channels; c++) {
-		if (test_bit(c, scan_mask))
-			standby_mask &= ~ad7768_channel_mask(st, c);
+		unsigned int mask;
+
+		if (!test_bit(c, scan_mask))
+			continue;
+
+		standby_mask &= ~ad7768_channel_mask(st, c);
+
+		mode = ad7768_find_matching_mode(mode_used, mode_freq,
+						 mode_filter, st->ch_freq[c],
+						 st->ch_filter[c]);
+		if (mode < 0)
+			return dev_err_probe(regmap_get_device(st->regmap), -EINVAL,
+				"Enabled channels require more than %d mode profiles\n",
+				AD7768_NUM_CHANNEL_MODES);
+
+		mode_freq[mode] = st->ch_freq[c];
+		mode_filter[mode] = st->ch_filter[c];
+		mode_used[mode] = true;
+
+		mask = ad7768_channel_mask(st, c);
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
+					 mask, mode ? mask : 0);
+		if (ret)
+			return ret;
 	}
 
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
@@ -385,6 +614,117 @@ static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode])
+			continue;
+
+		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 AD7768_CH_MODE_FILTER_TYPE_MODE(mode_filter[mode]));
+		if (ret)
+			return ret;
+
+		max_freq = max(max_freq, mode_freq[mode]);
+	}
+
+	ret = ad7768_set_clk_divs(st, max_freq);
+	if (ret)
+		return ret;
+
+	ret = ad7768_sync(st);
+	if (ret)
+		return ret;
+
+	/* Apply a filter settling time (Datasheet table 35 and 36) */
+	ad7768_filter_wait(mode_freq, mode_filter, mode_used);
+
+	return 0;
+}
+
+static int ad7768_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	if (info != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	*val = st->ch_freq[chan->channel];
+
+	return IIO_VAL_INT;
+}
+
+static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	if (info == IIO_CHAN_INFO_SAMP_FREQ)
+		return IIO_VAL_INT;
+
+	return -EINVAL;
+}
+
+static int ad7768_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	if (info == IIO_CHAN_INFO_SAMP_FREQ)
+		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
+
+	return -EINVAL;
+}
+
+static int ad7768_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (info != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	*vals = st->freqs;
+	*type = IIO_VAL_INT;
+	*length = st->n_freqs;
+
+	return IIO_AVAIL_LIST;
+}
+
+static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	ret = ad7768_apply_channel_modes(indio_dev, scan_mask);
+	if (ret)
+		return ret;
+
 	for (c = 0; c < st->chip_info->num_channels; c++) {
 		if (test_bit(c, scan_mask))
 			ret = iio_backend_chan_enable(st->back, c);
@@ -439,9 +779,73 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 
 static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = ad7768_reg_access,
+	.read_raw = ad7768_read_raw,
+	.write_raw_get_fmt = ad7768_write_raw_get_fmt,
+	.write_raw = ad7768_write_raw,
+	.read_avail = ad7768_read_avail,
 	.update_scan_mode = ad7768_update_scan_mode,
 };
 
+static void ad7768_set_available_sampl_freq(struct ad7768_state *st)
+{
+	struct ad7768_avail_freq *avail_freq;
+	unsigned int mclk = clk_get_rate(st->mclk);
+	unsigned int mode;
+
+	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		avail_freq = &st->avail_freq[mode];
+		for (unsigned int dec = ARRAY_SIZE(ad7768_dec_rate); dec > 0; dec--) {
+			struct ad7768_freq_config freq_cfg;
+
+			freq_cfg.dec_rate = dec - 1;
+			freq_cfg.freq_hz = mclk / (ad7768_dec_rate[dec - 1] *
+					ad7768_mclk_div[mode]);
+			avail_freq->freqs[avail_freq->n_freqs] = freq_cfg.freq_hz;
+			avail_freq->freq_cfg[avail_freq->n_freqs++] = freq_cfg;
+		}
+	}
+
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[AD7768_FAST_MODE].n_freqs--;
+
+	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {
+		avail_freq = &st->avail_freq[mode];
+		for (unsigned int i = 0; i < avail_freq->n_freqs; i++) {
+			unsigned int freq = avail_freq->freqs[i];
+
+			if (st->n_freqs && st->freqs[st->n_freqs - 1] >= freq)
+				continue;
+
+			st->freqs[st->n_freqs++] = freq;
+		}
+	}
+}
+
+static int ad7768_set_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int mode)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	st->ch_filter[chan->channel] = mode;
+	return 0;
+}
+
+static int ad7768_get_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	return st->ch_filter[chan->channel];
+}
+
 static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 					      struct ad7768_precharge_config *precharge_cfg)
 {
@@ -487,16 +891,37 @@ static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
 }
 
+static const char *const ad7768_filter_types[] = {
+	[AD7768_FILTER_TYPE_WIDEBAND] = "wideband",
+	[AD7768_FILTER_TYPE_SINC5] = "sinc5",
+};
+
+static const struct iio_enum ad7768_filter_types_enum = {
+	.items = ad7768_filter_types,
+	.num_items = ARRAY_SIZE(ad7768_filter_types),
+	.set = ad7768_set_filter_mode,
+	.get = ad7768_get_filter_mode,
+};
+
+static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE,
+		 &ad7768_filter_types_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
+	{}
+};
+
 static int ad7768_parse_config(struct iio_dev *indio_dev,
 			       struct device *dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct ad7768_avail_freq *avail_freq;
 	const unsigned int *available_datalines;
 	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
 	struct iio_chan_spec *chan;
 	unsigned int num_channels;
 	unsigned int channel;
 	unsigned int i, len;
+	unsigned int default_freq;
 	int chan_idx = 0;
 	int ret;
 
@@ -558,6 +983,9 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_separate_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.indexed = 1,
 			.address = channel,
 			.channel = channel,
@@ -567,6 +995,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				.realbits = 24,
 				.storagebits = 32,
 			},
+			.ext_info = ad7768_ext_info,
 		};
 		chan_idx++;
 	}
@@ -582,6 +1011,22 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 		return dev_err_probe(dev, ret,
 				     "Invalid \"adi,data-lines-number\" property\n");
 
+	ad7768_set_available_sampl_freq(st);
+
+	/* Start in fast mode; capture setup may select another compatible mode. */
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7768_set_power_mode(st, AD7768_FAST_MODE);
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	avail_freq = &st->avail_freq[AD7768_FAST_MODE];
+	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq_hz;
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		st->ch_freq[i] = default_freq;
+		st->ch_filter[i] = AD7768_FILTER_TYPE_WIDEBAND;
+	}
+
 	available_datalines = st->chip_info->available_datalines;
 	len = st->chip_info->num_datalines;
 
@@ -595,7 +1040,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid data-lines-number %d for %s\n",
 				     st->datalines, st->chip_info->name);
 
-	return ad7768_configure_capture(st);
+	return 0;
 }
 
 static int ad7768_reset(struct ad7768_state *st)
@@ -679,6 +1124,8 @@ static int ad7768_probe(struct spi_device *spi)
 	st->mclk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
+	if (!clk_get_rate(st->mclk))
+		return dev_err_probe(dev, -EINVAL, "MCLK rate must be non-zero\n");
 
 	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
 				      st->chip_info->regmap_config);

-- 
2.43.0

