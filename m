Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAC284690;
	Fri, 28 Aug 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931102; cv=none; b=M8Mn1m65ZX7K9ZfF4kctjm2BJ0P7Ca/LM7ph0enqkzgpoRdAgsqVNhFvIhcPjfirgKVnFzFEUsjBq++FfRrC88Xmysp0E+3i78o+lMJhq0B38oMXK0q4M8TuoWGYdUek0cCeNWSAamakZ9Q5gTsKFd9ci3GSvVB8ZL+ztk0xaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931102; c=relaxed/simple;
	bh=FWza9itWpZjwiiihqcKtGyjyrARO3ZgsFfv2fIF48i8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BH2X3xmqUqxq/s3ATuRKELIwd4gT/p5ZAK151BkDXaf4EJy33S0DQyNdj/MB/LL5jKZaTp1MDOInHpM4otB5D4rDQlL0dSY/twQNXHXo7VDunkSefcHgnvyRY/k2+a38RrXoGVqV9WYscLQOfnk9hNDwT/yZ1Xcc3/vF7FNVzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YTnC/koP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YTnC/koP"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWYnw1593807;
	Fri, 28 Aug 2026 11:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EWZNT
	wTESBCPX3u3Aeolyap5oRBCzQc9KLxxLF/lns4=; b=YTnC/koPkLYzvo6s6Zrh5
	TkSFHaSgZ4H2pYRafZt7wRboN0mO5tfIQHTcRTtm3Khd+3W5iMe/KTvbV0YeOfMz
	wjciEjwk9nwq+jVYzT0bYKuoEQ08WAvUCMptS7zCdXbBw59DjcfG+YMLLvqEyuTr
	gVGXJnY5bC0Rk7KLwpW/XGDYRIj7FkRTo+2enUXs+x5iiO6XrMrltIyHKbANOqjU
	wc6AbpRoVSAWl3nqXRfnvtRFFHxdkxTh4gBkYpVmu3W/bLbxEScWlnU8FT3LJM6p
	s6eyMSVk9shOfHX3snRMS2uwhg6+KB5eK3Wy6kAOKgXoNDPXWBjytlOs6kcgXuDV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbaebgvfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVRLG013081
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:27 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:27 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3o031424;
	Fri, 28 Aug 2026 11:31:19 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:32 +0200
Subject: [PATCH v5 09/20] iio: adc: ad7768: Configure channel sampling
 profiles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-9-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=7379;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=FWza9itWpZjwiiihqcKtGyjyrARO3ZgsFfv2fIF48i8=;
 b=W1+/uqM7no46uxSp60IES3fP5nUbYdWWjDW8JnmAC4XK3UUtsF59xlmJXsmGG5kwbsLB1A5aY
 ZXvnkonnC2gB2nD2wknZqlcYzYRb2fKFdj1yrasyX9dc78TY8Qogwmh
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX9Ib9Vyq32Zcz
 nKCxGH9RzbGw0NIIrmDMb9+DWHOkP5T5F6GN1S1djYWMS4gXMV4jbvThUhr52rG/vjEjUQNF5Hq
 Ggell4iYjxOGgZFVRqngXfV0kmnOowl2k+99xsfKr0aWgHw9PUF0
X-Proofpoint-ORIG-GUID: rOdmRLRE38mKrTl05rrnzGsdJmjMRkGX
X-Proofpoint-GUID: rOdmRLRE38mKrTl05rrnzGsdJmjMRkGX
X-Authority-Analysis: v=2.4 cv=WMtPmHsR c=1 sm=1 tr=0 ts=6a91a9d2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=K0dpHdiJ8xCuxrgygZsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXy+Uy/4L3PZ2E
 bY1m+EqwO1Xfdy3fj1nUbrwliMa6pxBVz+lU8kIC1pk5IeH4hry1VQIfGvhYja2WVZ+5nlP+Dwn
 +ol00U6yqyYPwXZPbfIz7WNqK1KUzyi7AdLvRHTDJ6vg92nJfJ1y0P0nYJZdg2mmXpDRmkgD9QH
 DVUZlbiYVmQGew+Ibb1IcyR/we4H+NVgSoBjxRdfJB6O/ZDwtcEb/nNjKiuovJC8DK3fzdrQF3p
 MMzKIL3SxMb6tPRQDwK/0YEB5JnWVf+jpz3YDGXDQ/33ZxUxpIuSD21HNRq0VSu5n+FcvtPZ65+
 6kNLYb8VeOXBuzwkErCLrnULvrgAUgFpW9/XseuIL1G2VJvQOjzDcCAymHjBXyWe18EK2NZNgzH
 kHWWBHEt4EGAY7Zenq2zWbn6AOepGKxPOCO3+WTvGnupodVy3L6opcrDtJ9gMolYkHynsZrgUH0
 PWxlycgHNpjR/IPIshA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

At buffered capture setup, select the fastest compatible power mode for
the enabled channel rates. Group channels into the two hardware mode
profiles and program their decimation, mode selection, and data clock.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 153 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 126 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 09b4e2f32304..00d6f1dce591 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -7,7 +7,9 @@
 
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -35,7 +37,6 @@
 
 #define AD7768_REG_CH_MODE(x)				(0x01 + (x))
 #define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
-#define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
 #define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
 
 #define AD7768_REG_CH_MODE_SEL				0x03
@@ -110,6 +111,7 @@
 #define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
+#define AD7768_NUM_CHANNEL_MODES			2
 
 enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_MCLK,
@@ -212,6 +214,11 @@ static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
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
@@ -460,14 +467,69 @@ static int ad7768_set_mode_decimation(struct ad7768_state *st,
 					     freq_cfg->dec_rate));
 }
 
-static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
+static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
+					const unsigned long *scan_mask)
+{
+	/*
+	 * The output data rate ranges overlap between the power modes. At a
+	 * common ODR, the faster mode has lower noise, so prefer the fastest
+	 * mode that supports every enabled channel.
+	 */
+	for (unsigned int mode_idx = ARRAY_SIZE(ad7768_power_modes);
+	     mode_idx-- > 0;) {
+		bool supported = true;
+		unsigned int channel;
+
+		for_each_set_bit(channel, scan_mask,
+				 st->chip_info->num_channels) {
+			if (!ad7768_find_freq_config(st, mode_idx,
+						     st->ch_freq[channel])) {
+				supported = false;
+				break;
+			}
+		}
+
+		if (supported)
+			return ad7768_set_power_mode(st, mode_idx);
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_find_matching_mode(const bool *mode_used,
+				     const unsigned int *mode_freq,
+				     unsigned int freq)
+{
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode] || mode_freq[mode] == freq)
+			return mode;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
 {
+	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
+	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	unsigned long channel_mask;
 	unsigned long standby_mask;
+	unsigned int max_freq = 0;
+	unsigned int c;
 	int ret;
 
+	guard(mutex)(&st->lock);
+
+	ret = ad7768_set_lowest_noise_mode(st, scan_mask);
+	if (ret == -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "No power mode supports all ODRs\n");
+	if (ret)
+		return ret;
+
 	channel_mask = ad7768_all_standby_mask(st);
 	standby_mask = channel_mask & ~*scan_mask;
 
@@ -478,11 +540,65 @@ static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
 		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
 
+	for_each_set_bit(c, scan_mask, st->chip_info->num_channels) {
+		unsigned int mask;
+		int mode;
+
+		mode = ad7768_find_matching_mode(mode_used, mode_freq,
+						 st->ch_freq[c]);
+		if (mode < 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "Over %d channel modes required\n",
+					     AD7768_NUM_CHANNEL_MODES);
+
+		mode_freq[mode] = st->ch_freq[c];
+		mode_used[mode] = true;
+
+		mask = ad7768_channel_mode_mask(st, c);
+		ret = regmap_assign_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
+					 mask, mode);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
 				 channel_mask, standby_mask);
 	if (ret)
 		return ret;
 
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		if (!mode_used[mode])
+			continue;
+
+		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					AD7768_CH_MODE_FILTER_TYPE_MSK);
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
+	return ad7768_sync(st);
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
@@ -629,11 +745,10 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
 		st->avail_freq[ARRAY_SIZE(ad7768_power_modes) - 1].n_freqs--;
 }
 
-static int ad7768_configure_capture(struct ad7768_state *st)
+static int ad7768_init_sampling_freqs(struct ad7768_state *st)
 {
 	const struct ad7768_avail_freq *avail_freq;
 	unsigned int default_freq;
-	unsigned int mode_config;
 	int ret;
 
 	ret = ad7768_set_power_mode(st, ARRAY_SIZE(ad7768_power_modes) - 1);
@@ -646,27 +761,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	     channel < st->chip_info->num_channels; channel++)
 		st->ch_freq[channel] = default_freq;
 
-	ret = ad7768_set_mode_decimation(st, default_freq, 0);
-	if (ret)
-		return ret;
-
-	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
-				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
-	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK,
-				 mode_config);
-	if (ret)
-		return ret;
-
-	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
-	if (ret)
-		return ret;
-
-	ret = ad7768_set_clk_divs(st, default_freq);
-	if (ret)
-		return ret;
-
-	return ad7768_sync(st);
+	return 0;
 }
 
 static int ad7768_parse_config(struct iio_dev *indio_dev,
@@ -787,7 +882,11 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 	ad7768_set_available_sampling_freqs(st);
 
-	return ad7768_configure_capture(st);
+	ret = ad7768_init_sampling_freqs(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	return 0;
 }
 
 static int ad7768_reset(struct ad7768_state *st)

-- 
2.43.0

