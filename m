Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FA4EE860;
	Wed, 16 Sep 2026 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557354; cv=none; b=OE1On+MgtuBc6XuIAUH0Aeh4Y5C4mNvkS629TxuRQDIYV+w0NWJhsh2akkPtXT+ncCD51YskjZiUiG5gMY7m7sYPcn5wuVnKVfI5ddF9MNGAIkfIVhlqk52beQzCBJv+2z62nVU8G9vJrPwmEIXkUVhG4YB2JM6TQE7qiSgsg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557354; c=relaxed/simple;
	bh=UZ4nlGxIX217C8FJhsVoqK5iQ+ACocDuMy2UipKdJmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a3SsMChxf9qXgmEsgvNqJAO+ORzMYqO4GINu25/PC9k5nO4xkobFJCT3sz1JYVnOM6vWQxgvn0CeZX5LJ6n64gGEujkVTfpog5tqyh1yYSI49M/joQ6J45vHhdTGESPK8lvSGCwkqYXFAtMszZWBG/oRdTmL5Be9S4WGGyDC83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0QFebpk2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0QFebpk2"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GBBKKn2358617;
	Wed, 16 Sep 2026 07:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t6wsD
	BrALxY//LcHVLLhuQYAV3MyhOyyVSmnN7Og1LE=; b=0QFebpk2uqDTifFR+n1fa
	l4leVOgphGn1ySnkXKJ1SK5uZ/vb2MHvSjV0WLGqBCrl/+xHFH2JLOfvCMA9REWb
	BeY+b9N6/bAEx4vUHLmoQy/cmrZbVDhQZog8Bo0SFkBpKxTdN7pJDAUmlBcz9Yla
	1JKC9cBHHXlIj9ztF0+DIBTTVUCx4sUZ+jCzHnT0GTIKCkilCBJoq47379wU01TT
	JqHbT1Whu8rDNShOPJXFhz2ILt4N6XArgWa29q0Fk7JVDSJ/qOrBDjbdlafk/bRa
	esrk+9JqmrHAhvqwDh1YqZitofY6CkjWSNud4WWKqVk6ap8s3iLvdMbWqdRb8fMe
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ee2s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFBQl015759
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:15:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:11 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE0004263;
	Wed, 16 Sep 2026 07:15:06 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:57 +0200
Subject: [PATCH v8 08/17] iio: adc: ad7768: Derive output data rates
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-8-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=8036;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=UZ4nlGxIX217C8FJhsVoqK5iQ+ACocDuMy2UipKdJmU=;
 b=+V6IFtkn+gbeK9UmKtl40xTZR6Rr891vsRjTW9dW6qnXpisYN0tbGB0xo8E21q7TBYIYgsAvi
 MPtO4SXi+OeDwk/gu2T9qpLzXwQoZDlJ9YUES3eGG23vD2gHFftvh36
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iD6giv4rqLqhq0_wL3WtFf1yZ2ZT0d1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX4/6/Fiy9JxRx
 /KtMTPXQwLCPNpMsnkJCNf4lvJl+yVdxDKJxB2HGMxlrNlTehcPqUM2VeR62JrVZV/9mRCxL8t8
 Axr6ubwxHMSxDpYEWpsEAG4M1/YLmdI3QOJ4xnezahj0rKO4uU1/AZ/P21ruaqAqu/ErxviFDTd
 ARhcYcywKElPMfwWrp2pw1ydS0DDyamjq5KPV0NJbeUWF07wHomNyIQ8a2ObkGUbRmAbxFXkn5q
 +lT9Yxvuptck7fA2tssFwGnAOpkyINOuTZTldBJ0XQ6r8bUOubY92S4S6i4HdgHi+l5J56pSg1n
 D7X43DA0yukNrUADuBSqbT+z/c74Yr6pSwxZpv1X+qpZoB/wlalO92W2JZc0S3uWFAseAnoR5QZ
 YwGFjpABfz55Qa+ME48GUAg3uueDv+j1xyy325nRfcb0k+MxLBEWoxWUocVy5PyfWqsVxTlGKxv
 ksmec8xZz17CIQ72mmg==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aaa7a41 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=8zL7B6ODU1ky_bk3ulwA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: iD6giv4rqLqhq0_wL3WtFf1yZ2ZT0d1e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX2gC1ZA1q5ZiU
 L7r2zNc3PFVyh4GICyCQqLjDVVNDX2pirzgLSQMcsSsmN3vBtpQdVX6O29mVGhV+uNJtaWAKuoa
 hm9knsl3QCgHCGep9Jd/OFrjYJZqhtsmXEwCqhcvb7rI6cFnMjic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Derive valid output data rates from the master clock, power mode and
decimation ratio.

Replace the fixed x64 decimation with the derived default output rate
and a new decimation helper. Extend the existing clock-divider helper
to derive the DCLK divider from the selected rate. Select the maximum
rate supported by the configured data interface for the initial capture
configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 134 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 5bd01f457a54..2d051d91e1cf 100644
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
@@ -34,7 +35,6 @@
 #define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
 #define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
 #define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
-#define     AD7768_CH_MODE_DEC_RATE_64			0x1
 
 #define AD7768_REG_CH_MODE_SEL				0x03
 
@@ -93,9 +93,12 @@
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
@@ -122,6 +125,16 @@ struct ad7768_precharge_config {
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
 	const struct regmap_config *regmap_config;
@@ -138,6 +151,8 @@ struct ad7768_state {
 	unsigned int datalines;
 	enum ad7768_clock_source clock_source;
 	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
+	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
 	unsigned int power_mode_idx;
@@ -146,6 +161,10 @@ struct ad7768_state {
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
 
+static const unsigned int ad7768_dec_rate[AD7768_MAX_FREQ_PER_MODE] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
 static const unsigned int ad7768_available_datalines[] = {
 	1, 2, 8,
 };
@@ -386,17 +405,45 @@ static int ad7768_set_power_mode(struct ad7768_state *st,
 	return 0;
 }
 
-static int ad7768_set_clk_divs(struct ad7768_state *st)
+static const struct ad7768_freq_config *
+ad7768_find_freq_config(const struct ad7768_state *st,
+			unsigned int mode_idx, unsigned int freq)
 {
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
 	unsigned int dclk_div_reg;
-	unsigned int dclk_div;
 
-	/*
-	 * DCLK(min) is ODR * channels per DOUTx * 32. With fast mode
-	 * (fMOD = MCLK / 4) and x64 decimation, this gives:
-	 * MCLK / DCLK = 8 * data lines / channels.
-	 */
-	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
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
+	if (dclk > mclk)
+		return -EINVAL;
+
+	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
+
+	/* Set the divider to the next-lowest supported power of two. */
+	dclk_div = rounddown_pow_of_two(min(dclk_div, AD7768_MAX_DCLK_DIV));
+
 	switch (dclk_div) {
 	case 1:
 		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_1;
@@ -420,6 +467,21 @@ static int ad7768_set_clk_divs(struct ad7768_state *st)
 					     dclk_div_reg));
 }
 
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
@@ -567,8 +629,37 @@ static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
 }
 
+static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
+{
+	unsigned int n_power_modes = ARRAY_SIZE(ad7768_power_modes);
+	unsigned int mclk = clk_get_rate(st->mclk);
+
+	for (unsigned int mode_idx = 0; mode_idx < n_power_modes; mode_idx++) {
+		unsigned int dec = ARRAY_SIZE(ad7768_dec_rate);
+		struct ad7768_avail_freq *avail_freq;
+		unsigned int div;
+
+		avail_freq = &st->avail_freq[mode_idx];
+		div = ad7768_power_modes[mode_idx].mclk_div;
+		while (dec--) {
+			struct ad7768_freq_config *freq_cfg;
+
+			freq_cfg = &avail_freq->freq_cfg[avail_freq->n_freqs++];
+			freq_cfg->dec_rate = dec;
+			freq_cfg->freq_hz = mclk / (ad7768_dec_rate[dec] * div);
+		}
+	}
+
+	/* One DOUT line cannot carry the AD7768 fast-mode x32 output rate. */
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[n_power_modes - 1].n_freqs--;
+}
+
 static int ad7768_configure_capture(struct ad7768_state *st)
 {
+	const struct ad7768_avail_freq *avail_freq;
+	unsigned int default_freq;
 	unsigned int mode_config;
 	int ret;
 
@@ -576,17 +667,20 @@ static int ad7768_configure_capture(struct ad7768_state *st)
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
-				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND) |
-		      FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
-				 AD7768_CH_MODE_DEC_RATE_64);
+				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK |
-				 AD7768_CH_MODE_DEC_RATE_MSK,
+				 AD7768_CH_MODE_FILTER_TYPE_MSK,
 				 mode_config);
 	if (ret)
 		return ret;
@@ -595,7 +689,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	if (ret)
 		return ret;
 
-	ret = ad7768_set_clk_divs(st);
+	ret = ad7768_set_clk_divs(st, default_freq);
 	if (ret)
 		return ret;
 
@@ -707,6 +801,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid %s %u for %s\n", propname,
 				     st->datalines, st->chip_info->name);
 
+	ad7768_set_available_sampling_freqs(st);
+
 	return ad7768_configure_capture(st);
 }
 

-- 
2.43.0

