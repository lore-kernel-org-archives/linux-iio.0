Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AF54CF4A;
	Thu, 10 Sep 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061880; cv=none; b=Ij9ma0niGaWeGdIdRtRX0vBsxBJ+LYtJLLTWqiDmwXTc49VlfzQuLph/PWllPHJ9O+rXp0dMi+HfASyEkxzV39nDT9pULPkUU7ldRta9DP9qjg8cpSGRHYZMpVwNuz277soPK5m55onvGjihs4xIH7KeDMI0h9kbsP/dPzfXbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061880; c=relaxed/simple;
	bh=QACP0/ytA4mDRxdmoQAW9IVbtFEg6cSRsqBOH6rmdmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qj+btV5VPEINohf+KtxGRuRQbFB47fzogOHz0PSn4fRT5DUuaOYGoVcA48jXOIf1W6NAg0anBbumWrFqt0PXRr06rgv3/40MhN1CU0rMA6KBu5vmbSUkh/NlkeUQDPf8IIrFzJ7x/z9w4iMq0TkEZYclM+HgJ0xXJVhXu6J1qQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xyNL5Gs+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xyNL5Gs+"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7Mo2343054;
	Thu, 10 Sep 2026 13:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1W4uK
	0DRg+CN7TW+o96MTnpjyTo+lsa2WyLgVI7iNsA=; b=xyNL5Gs+H7AXsIPiA2O5A
	T/uQmHP1eT+ONXPrx9vDx6pz39OquGCawnZA9cC3kPZ4iKEUMowYSTZZS8yk+ODO
	Mpq8sTwXUcs4kfW++QRh3sAKmprrES1u3V0A8gwKjbWwx9kDKOZA+Km/r/IHdMsd
	+z6DYOkOyil1Z7dgqolKhKZCo0GaBYDHQaoLS5lk95gBhK5GcIbFOckMY62B0SFO
	OjRiqSzxDQwjmM6kexqpnO1KV/zUMfPPt43eJl0cpkCwhhBCeXlKgvuCqlbBbEQh
	OKFNSxH9rfWyw8Z0onTPJwnHs6Szn/MjE0/T87x7FqQvSmUWeb6gHKyvwDCbFRQG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx9521q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbRWZ038804
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:27 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSf018832;
	Thu, 10 Sep 2026 13:37:21 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:27 +0200
Subject: [PATCH v7 09/17] iio: adc: ad7768: Configure channel sampling
 profiles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-9-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=8484;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=QACP0/ytA4mDRxdmoQAW9IVbtFEg6cSRsqBOH6rmdmY=;
 b=29cW6xIZ4U0jHCGuKmyM7XUItXWaCQiXSzAVEhBKjsJqeNCFzyYPg8+gZYcQM+hV0hqELYCEf
 zGMEPpnL7NDA6O9O5lqVWbf5ThRAsvR0sc7p5zWLcV/vXOCvLtDdYHb
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX+DbG/zbYP0ME
 qK+BJORCICYHAsZslGMITcnBc3r1NDeLSQGRoLRtVaFbVFMyVqR+GpZHNOCHG21FEmuA6JYWmcz
 B4ru38Xc5ycXoWTLT+9OUMUfQ3338C+alc1HhoX6ZuYQ1SgBgHv2
X-Proofpoint-GUID: nH4mUfwufm2tEznadet0e1hw_BGYT5Iy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX6eZJHuPHUPnM
 LL87K6N399fccJMrW0oMjvp42XT8T014zmVwBxSzsrgaczlA2GElvjD92UNkL58MnqxQ8Cwv4Db
 B6xYYnu+yjg2czfo7l/5X6j/SYtSwcgGBn+98h8Bnoy/n28M2z14brO5WhkkYGaWDtOt6iQ8UmU
 KtwaCXNk/J4x+RHN28mV3wejrANhyr6bJXUHHqkBuKWJkfwQJopFWPr+oPtQYVPJUnpv++tuOoy
 BtyXdr0PC2Brvi9VI32ysWAHbfRrquyRfJwcWqcM8gECLQhPg3QH/y58WrpNjkrJPLQ16y8CIxr
 fwCfT+fnw18ocdB+IKx4xKsUo1VXHSVe/k3X2mS7PYpLZhsVzbCCIY5S8ipaGBtXE5xPf0ZysyH
 VnVjxdSdQRGTXzV0iYkdlsa3UVoEKbt8sniRdmDHjSAkq1gteNp/QvFNiSPihk6rDPfDpe4dBSK
 OwxXMj3shZv/UfD8Inw==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2ead8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=YaUG07iyn5Nj4qywQSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nH4mUfwufm2tEznadet0e1hw_BGYT5Iy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

At buffered capture setup, select the fastest compatible power mode for
the enabled channel rates. Group channels into the two hardware mode
profiles and program their decimation, mode selection, and data clock.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 168 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 141 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 03ba48be3153..a957bd8e0d6f 100644
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
@@ -16,6 +18,7 @@
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -33,7 +36,6 @@
 
 #define AD7768_REG_CH_MODE(x)				(0x01 + (x))
 #define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
-#define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
 #define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
 
 #define AD7768_REG_CH_MODE_SEL				0x03
@@ -100,6 +102,7 @@
 #define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
+#define AD7768_NUM_CHANNEL_MODES			2
 
 enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_MCLK,
@@ -147,6 +150,8 @@ struct ad7768_chip_info {
 
 struct ad7768_state {
 	struct regmap *regmap;
+	/* Protects device register access and configuration. */
+	struct mutex lock;
 	struct clk *mclk;
 	unsigned int datalines;
 	enum ad7768_clock_source clock_source;
@@ -200,6 +205,17 @@ static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
 	return BIT(st->chip_info->chan_map[ch]);
 }
 
+static u8 ad7768_channel_mode_mask(const struct ad7768_state *st, u8 ch)
+{
+	/*
+	 * AD7768-4 channels 2 and 3 use bits 4 and 5 for CH_x_MODE, while
+	 * their CH_x_MDE_EN fields are in bits 2 and 3 and must be programmed
+	 * to the same value. On AD7768, chan_map[] is an identity map, so the
+	 * OR produces a single bit.
+	 */
+	return BIT(ch) | ad7768_channel_mask(st, ch);
+}
+
 static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
 {
 	return GENMASK(st->chip_info->num_channels - 1, 0);
@@ -466,14 +482,70 @@ static int ad7768_set_mode_decimation(struct ad7768_state *st,
 					     freq_cfg->dec_rate));
 }
 
-static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
+static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
+					const unsigned long *scan_mask)
+{
+	unsigned int mode_idx = ARRAY_SIZE(ad7768_power_modes);
+
+	/*
+	 * The output data rate ranges overlap between the power modes. At a
+	 * common ODR, the faster mode has lower noise, so prefer the fastest
+	 * mode that supports every enabled channel.
+	 */
+	while (mode_idx--) {
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
 {
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
+{
+	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
+	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	unsigned long channel_mask;
 	unsigned long standby_mask;
+	unsigned int max_freq;
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
 
@@ -484,11 +556,66 @@ static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
 		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
 
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
 
+	max_freq = 0;
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
 	for (unsigned int ch = 0; ch < st->chip_info->num_channels; ch++) {
 		if (test_bit(ch, scan_mask))
 			ret = iio_backend_chan_enable(st->back, ch);
@@ -645,11 +772,10 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
 		st->avail_freq[n_power_modes - 1].n_freqs--;
 }
 
-static int ad7768_configure_capture(struct ad7768_state *st)
+static int ad7768_init_sampling_freqs(struct ad7768_state *st)
 {
 	const struct ad7768_avail_freq *avail_freq;
 	unsigned int default_freq;
-	unsigned int mode_config;
 	int ret;
 
 	ret = ad7768_set_power_mode(st, ARRAY_SIZE(ad7768_power_modes) - 1);
@@ -662,27 +788,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
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
@@ -804,7 +910,11 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 	ad7768_set_available_sampling_freqs(st);
 
-	return ad7768_configure_capture(st);
+	ret = ad7768_init_sampling_freqs(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	return 0;
 }
 
 static int ad7768_reset(struct ad7768_state *st)
@@ -979,6 +1089,10 @@ static int ad7768_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, st);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->chip_info = spi_get_device_match_data(spi);
 	if (!st->chip_info)
 		return dev_err_probe(dev, -ENODATA, "Failed to get match data\n");

-- 
2.43.0

