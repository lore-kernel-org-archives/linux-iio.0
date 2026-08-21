Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1E4CA261;
	Fri, 21 Aug 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321310; cv=none; b=ucjDO8w4Okk5odvprJU5Xen8xxM/QwwhwSJeBlcdhRbLc7nZYqhff5v8kb1G8Tm3FxJ4KDRjJv9TSZlImfaMoOrlGMviZbI6DO7SHuMSWTa/N8uXUwnJpZSvpU+hfbzepQvv9aYuCOK3uxuvwy8PnCEwhKO9d/0LbNEADNzRjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321310; c=relaxed/simple;
	bh=/XRRCGpT9KMiA8oa1wpQhEpWRlHiEYU6iGJKhvbqo0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tQzLvP8AQuyvhG+XLW6gPo5uGkKcnpZCImbCU6v7tYxPSwA3y/F323XTV9ZVEAHP195MI7jV5a8erl4cO1e9taz1OwM/PFnuS1BD0C9pqqfHduufKIiTwHIvLVrl+Oo4f4+wVEUyEKuAm+kRFinz825FPQ6Au9Yy9GEPS17VsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BIOHi9JH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BIOHi9JH"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpPbJ3076179;
	Fri, 21 Aug 2026 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7EDhd
	wQMMa34JHtRTEYKeBjBpOdBMsfw5qNSJJbiw2s=; b=BIOHi9JHlbKCC45mDNQRL
	f6rrJLpT+4P3cirQmqU7e8hVLU2lK6tr9mh3ihYwNKDD2avyTcT8EVEv02jLRVTA
	GxrfNQO1jNhKLT4lbnqa+7mOhjAEi2XBkQuTEG3oN8bgLDIgrnqpNzKFHQHZi22X
	vCdx8iYUGyAiMkgGEeLIk3l+CqcCNVZPBcKP7i3WDFNw54mo32lSE1VmQhL5NEcx
	0bT+y0gPHfl1d4Gf0v6MtQqYRbLdvpt7J+l6BNB7LJdgWHmO6HsRCRpKKp+oPpGD
	datn6s00ZoO7F7D13RrKMolEslzrFMmLEX5jd2v52MQecWfWs6LQBOBN/4yjYBjK
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g5rk8ykbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8GPm032987
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:16 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkp024319;
	Fri, 21 Aug 2026 10:08:06 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:06:59 +0200
Subject: [PATCH v4 06/14] iio: adc: ad7768: Add configurable sampling modes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-6-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=22763;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=/XRRCGpT9KMiA8oa1wpQhEpWRlHiEYU6iGJKhvbqo0g=;
 b=D4sNnZS0kCOIuPVeM4E6dyixtcf07PFU5foIrgIljQQY7drtMQ0icLY23l3Me4h3jJHZs6dYk
 C1O2tZofS6XAaFuZ55z+kKVXlflVLQYqc4RPUe3avw00htiEhZbuAdp
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfXzv+WljkjHmqV
 zIIHWErCBHIL3QDDplgTGi1fuDGatqFokH5UUE1Gh7JMCwZFgwd9UIByWPO7HH/qf+4uGbFP5ho
 lsDPetIOwaQoyOVz0ILWbmFTJVejgU5xrGb8VyCh/oOrnUvHhOTC
X-Proofpoint-GUID: 8MK-KzSTGuCzN1oW4MItgOlb-gqHZIz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX7FGa/gJPWbYB
 o3KcsAoLylREm876oIhaYMOtNTynKzgvDGLRZ8pnZuYLB+oQ6Ds0KoeRwoFD1+2WPpWYlwuuVZ8
 fNdsmxWkGJUgdIcQ1J9x2/7emGbh/37N1iOI8jgGN1md8cOc1mfg6swycivgaw5uXCNkov3te2v
 8cDiKg9WqJkNcRUu0FrntbE0bg7YovOFg+23dJHJ81gXnUbPTvb0x1/BVNqcXJt6wjJtYV8Tpaw
 9KzqKdw9tS2o+QAdXQ+GPc6D6sa4qwZkfEfjXOj0HqMOmxCUt3nU2pAsYzM/oE1pNH27gj//23X
 6Q9EA28B9BJA8Ln0JpCGM4b0YIsSA7VhCVstU+95NtWv4ofbN/mYMFT1ft0c89SWdeN7dZ/mi1k
 Gxcjj3RNCc5WT5NybLB/5IUWGyxfInyz7JmaTKhlUUwvKTsbI4TdtwIZuwJebhiaH8/sEOZvaEO
 D5nbQ8HgGUsO/DNtOAQ==
X-Proofpoint-ORIG-GUID: 8MK-KzSTGuCzN1oW4MItgOlb-gqHZIz8
X-Authority-Analysis: v=2.4 cv=P+YKQCAu c=1 sm=1 tr=0 ts=6a885bd1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=DHFYRi2-UijItfTWdScA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Derive the available output data rates from MCLK and expose per-channel
sampling frequency and filter controls.

Select the fastest compatible power mode for the enabled channels and
map matching sampling frequency and filter combinations onto the two
hardware channel profiles. Configure the data clock divider and wait for
the selected filters to settle before capture.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 580 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 543 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 34233ad6cfca..08d8e97d58fc 100644
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
@@ -24,6 +25,7 @@
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
@@ -108,7 +110,19 @@
 
 #define AD7768_SAMPLE_SIZE			32
 #define AD7768_MAX_DCLK_DIV			8
+#define AD7768_MIN_MCLK_FREQ_HZ			(1150 * HZ_PER_KHZ)
+#define AD7768_MIN_XTAL_FREQ_HZ			(8 * HZ_PER_MHZ)
+#define AD7768_MAX_MCLK_FREQ_HZ			(34 * HZ_PER_MHZ)
+#define MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL			8
+#define AD7768_NUM_CHANNEL_MODES		2
+#define AD7768_WIDEBAND_SETTLING_SAMPLES	68
+#define AD7768_SINC5_SETTLING_SAMPLES		7
+
+enum ad7768_filter_type {
+	AD7768_FILTER_TYPE_WIDEBAND,
+	AD7768_FILTER_TYPE_SINC5,
+};
 
 enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_MCLK,
@@ -116,6 +130,20 @@ enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_LVDS,
 };
 
+struct ad7768_power_mode_info {
+	unsigned int mode;
+	unsigned int mclk_div;
+};
+
+static const struct ad7768_power_mode_info ad7768_power_modes[] = {
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_LOW, .mclk_div = 32 },
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_MEDIAN, .mclk_div = 8 },
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
+};
+
+#define AD7768_MAX_FREQS \
+	(MAX_FREQ_PER_MODE + ARRAY_SIZE(ad7768_power_modes))
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -123,6 +151,17 @@ struct ad7768_precharge_config {
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
@@ -140,12 +179,22 @@ struct ad7768_state {
 	struct clk *mclk;
 	unsigned int datalines;
 	enum ad7768_clock_source clock_source;
+	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
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
 static const unsigned int ad7768_available_datalines[] = {
 	1, 2, 8,
 };
@@ -177,6 +226,11 @@ static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
 	return BIT(st->chip_info->chan_map[ch]);
 }
 
+static u8 ad7768_channel_mode_mask(const struct ad7768_state *st, u8 ch)
+{
+	return BIT(ch) | ad7768_channel_mask(st, ch);
+}
+
 static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
 {
 	return GENMASK(st->chip_info->num_channels - 1, 0);
@@ -333,70 +387,272 @@ static int ad7768_sync(struct ad7768_state *st)
 			       AD7768_DATA_CONTROL_SPI_SYNC);
 }
 
-static int ad7768_configure_capture(struct ad7768_state *st)
+static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode)
 {
-	unsigned int dclk_div_reg;
-	unsigned int mode_config;
-	unsigned int dclk_div;
+	unsigned int mode_idx;
 	int ret;
 
+	for (mode_idx = 0; mode_idx < ARRAY_SIZE(ad7768_power_modes);
+	     mode_idx++) {
+		if (ad7768_power_modes[mode_idx].mode == mode)
+			break;
+	}
+
+	if (mode_idx == ARRAY_SIZE(ad7768_power_modes))
+		return -EINVAL;
+
 	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
-				 AD7768_POWER_MODE_POWER_MODE_MSK |
-				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 AD7768_POWER_MODE_POWER_MODE_MSK,
 				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
-					    AD7768_POWER_MODE_POWER_MODE_FAST) |
-				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
-					    AD7768_POWER_MODE_POWER_MODE_FAST));
+					    mode));
 	if (ret)
 		return ret;
 
-	/*
-	 * Start with the wideband filter and a decimation rate of 64. This
-	 * supports every valid data-line configuration at the maximum MCLK.
-	 */
-	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
-				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
-	mode_config |= FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
-				  AD7768_CH_MODE_DEC_RATE_64);
-	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK |
-				 AD7768_CH_MODE_DEC_RATE_MSK,
-				 mode_config);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
+					    mode));
 	if (ret)
 		return ret;
-
-	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
+	ret = ad7768_sync(st);
 	if (ret)
 		return ret;
 
-	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
+	st->power_mode_idx = mode_idx;
+
+	return 0;
+}
+
+static int ad7768_set_clk_divs(struct ad7768_state *st,
+			       unsigned int freq)
+{
+	struct ad7768_freq_config f_cfg = { };
+	unsigned int mclk, dclk, dclk_div, i;
+	unsigned int chan_per_doutx;
+	unsigned int dclk_div_reg;
+
+	mclk = clk_get_rate(st->mclk);
+
+	chan_per_doutx = st->chip_info->num_channels / st->datalines;
+	if (!chan_per_doutx)
+		return -EINVAL;
+
+	for (i = 0; i < st->avail_freq[st->power_mode_idx].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode_idx].freq_cfg[i];
+		if (freq == f_cfg.freq_hz)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode_idx].n_freqs)
+		return -EINVAL;
+
+	dclk = f_cfg.freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
+	if (!dclk || dclk > mclk)
+		return -EINVAL;
+
+	/*
+	 * Set dclk_div to the nearest power of 2 less than the
+	 * original value.
+	 */
+	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
+	if (dclk_div > AD7768_MAX_DCLK_DIV)
+		dclk_div = AD7768_MAX_DCLK_DIV;
+	else
+		dclk_div = rounddown_pow_of_two(dclk_div);
+
 	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
-	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
-				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-					    dclk_div_reg));
-	if (ret)
-		return ret;
 
-	return ad7768_sync(st);
+	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+					     dclk_div_reg));
 }
 
-static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
+static bool ad7768_freq_supported(const struct ad7768_state *st,
+				  unsigned int mode_idx, unsigned int freq)
+{
+	for (unsigned int i = 0;
+	     i < st->avail_freq[mode_idx].n_freqs; i++) {
+		if (freq == st->avail_freq[mode_idx].freq_cfg[i].freq_hz)
+			return true;
+	}
+
+	return false;
+}
+
+static bool ad7768_freq_supported_in_any_mode(const struct ad7768_state *st,
+					      unsigned int freq)
+{
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
+		if (ad7768_freq_supported(st, mode_idx, freq))
+			return true;
+	}
+
+	return false;
+}
+
+static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
+					const unsigned long *scan_mask)
+{
+	unsigned int mode_idx = ARRAY_SIZE(ad7768_power_modes);
+	unsigned int channel;
+
+	/*
+	 * The output data rate ranges overlap between the power modes. At a
+	 * common ODR, the faster mode has lower noise, so prefer the fastest
+	 * mode that supports every enabled channel.
+	 */
+	while (mode_idx--) {
+		for (channel = 0;
+		     channel < st->chip_info->num_channels; channel++) {
+			if (test_bit(channel, scan_mask) &&
+			    !ad7768_freq_supported(st, mode_idx,
+						   st->ch_freq[channel]))
+				break;
+		}
+
+		if (channel == st->chip_info->num_channels)
+			return ad7768_set_power_mode(st,
+					ad7768_power_modes[mode_idx].mode);
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_set_mode_decimation(struct ad7768_state *st,
+				      unsigned int freq, unsigned int mode)
+{
+	struct ad7768_freq_config f_cfg = { };
+	unsigned int i;
+
+	for (i = 0; i < st->avail_freq[st->power_mode_idx].n_freqs; i++) {
+		f_cfg = st->avail_freq[st->power_mode_idx].freq_cfg[i];
+		if (freq == f_cfg.freq_hz)
+			break;
+	}
+
+	if (i == st->avail_freq[st->power_mode_idx].n_freqs)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+				  AD7768_CH_MODE_DEC_RATE_MSK,
+				  FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
+					     f_cfg.dec_rate));
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
 {
+	unsigned int t_settle_us = 0;
+
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		unsigned int settling_samples;
+		unsigned int t_mode_us;
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
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
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
+{
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES];
+	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES];
+	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
 	unsigned int channel_mask;
 	unsigned int standby_mask;
+	unsigned int max_freq = 0;
+	struct device *dev;
+	unsigned int c;
 	int ret;
 
+	guard(mutex)(&st->lock);
+	dev = regmap_get_device(st->regmap);
+
+	ret = ad7768_set_lowest_noise_mode(st, scan_mask);
+	if (ret == -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "No power mode supports all ODRs\n");
+	if (ret)
+		return ret;
+
 	channel_mask = ad7768_all_standby_mask(st);
 	standby_mask = channel_mask;
 	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
 		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
 
-	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
-		if (test_bit(c, scan_mask))
-			standby_mask &= ~BIT(c);
+	for_each_set_bit(c, scan_mask, st->chip_info->num_channels) {
+		unsigned int mask;
+		int mode;
+
+		standby_mask &= ~BIT(c);
+
+		mode = ad7768_find_matching_mode(mode_used, mode_freq,
+						 mode_filter, st->ch_freq[c],
+						 st->ch_filter[c]);
+		if (mode < 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "Over %d channel modes required\n",
+					     AD7768_NUM_CHANNEL_MODES);
+
+		mode_freq[mode] = st->ch_freq[c];
+		mode_filter[mode] = st->ch_filter[c];
+		mode_used[mode] = true;
+
+		mask = ad7768_channel_mode_mask(st, c);
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
+					 mask, mode ? mask : 0);
+		if (ret)
+			return ret;
 	}
 
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
@@ -404,6 +660,121 @@ static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES;
+	     mode++) {
+		unsigned int filter_config;
+
+		if (!mode_used[mode])
+			continue;
+
+		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
+		if (ret)
+			return ret;
+
+		filter_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
+					   mode_filter[mode]);
+		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 filter_config);
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
+	/* Apply a filter settling time (datasheet Tables 28 and 29) */
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
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
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
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
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
+	int ret;
+
+	ret = ad7768_apply_channel_modes(indio_dev, scan_mask);
+	if (ret)
+		return ret;
+
 	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
 		if (test_bit(c, scan_mask))
 			ret = iio_backend_chan_enable(st->back, c);
@@ -458,9 +829,76 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 
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
+	unsigned int mclk = clk_get_rate(st->mclk);
+	struct ad7768_avail_freq *avail_freq;
+
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
+		avail_freq = &st->avail_freq[mode_idx];
+		for (unsigned int dec = ARRAY_SIZE(ad7768_dec_rate);
+		     dec > 0; dec--) {
+			struct ad7768_freq_config freq_cfg;
+
+			freq_cfg.dec_rate = dec - 1;
+			freq_cfg.freq_hz = mclk / (ad7768_dec_rate[dec - 1] *
+					ad7768_power_modes[mode_idx].mclk_div);
+			avail_freq->freqs[avail_freq->n_freqs] =
+				freq_cfg.freq_hz;
+			avail_freq->freq_cfg[avail_freq->n_freqs++] = freq_cfg;
+		}
+	}
+
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[ARRAY_SIZE(ad7768_power_modes) - 1].n_freqs--;
+
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
+		avail_freq = &st->avail_freq[mode_idx];
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
@@ -505,14 +943,36 @@ static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
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
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
+			   &ad7768_filter_types_enum),
+	{ }
+};
+
 static int ad7768_parse_config(struct iio_dev *indio_dev,
 			       struct device *dev)
 {
 	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct ad7768_avail_freq *avail_freq;
 	const unsigned int *available_datalines;
 	struct iio_chan_spec *chan;
 	unsigned int num_channels;
+	unsigned int default_freq;
 	unsigned int standby_mask;
 	unsigned int i, len;
 	int chan_idx = 0;
@@ -576,6 +1036,9 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_separate_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.indexed = 1,
 			.address = channel,
 			.channel = channel,
@@ -585,6 +1048,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				.realbits = 24,
 				.storagebits = 32,
 			},
+			.ext_info = ad7768_ext_info,
 		};
 		chan_idx++;
 	}
@@ -603,6 +1067,27 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid %s property\n",
 				     "adi,data-lines-number");
 
+	ad7768_set_available_sampl_freq(st);
+
+	/*
+	 * Start in fast mode; capture setup may select another
+	 * compatible mode.
+	 */
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7768_set_power_mode(st,
+					    AD7768_POWER_MODE_POWER_MODE_FAST);
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	avail_freq = &st->avail_freq[st->power_mode_idx];
+	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq_hz;
+	for (unsigned int channel = 0;
+	     channel < st->chip_info->num_channels; channel++) {
+		st->ch_freq[channel] = default_freq;
+		st->ch_filter[channel] = AD7768_FILTER_TYPE_WIDEBAND;
+	}
+
 	for (i = 0; i < len; i++) {
 		if (available_datalines[i] == st->datalines)
 			break;
@@ -613,7 +1098,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid data-lines-number %d for %s\n",
 				     st->datalines, st->chip_info->name);
 
-	return ad7768_configure_capture(st);
+	return 0;
 }
 
 static int ad7768_reset(struct ad7768_state *st)
@@ -711,6 +1196,23 @@ static int ad7768_enable_lvds_clock(struct ad7768_state *st)
 	return devm_add_action_or_reset(dev, ad7768_disable_clk, st->mclk);
 }
 
+static int ad7768_validate_mclk_rate(struct device *dev,
+				     const struct ad7768_state *st)
+{
+	unsigned long min_rate = AD7768_MIN_MCLK_FREQ_HZ;
+	unsigned long rate = clk_get_rate(st->mclk);
+
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
+		min_rate = AD7768_MIN_XTAL_FREQ_HZ;
+
+	if (rate < min_rate || rate > AD7768_MAX_MCLK_FREQ_HZ)
+		return dev_err_probe(dev, -EINVAL,
+				     "MCLK rate %lu Hz outside %lu-%lu Hz\n",
+				     rate, min_rate, AD7768_MAX_MCLK_FREQ_HZ);
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	unsigned int spi_readback, rev_id;
@@ -776,6 +1278,10 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->mclk),
 				     "Failed to get master clock\n");
 
+	ret = ad7768_validate_mclk_rate(dev, st);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
 				      st->chip_info->regmap_config);
 	if (IS_ERR(st->regmap))

-- 
2.43.0

