Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B84F0537;
	Wed, 16 Sep 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557346; cv=none; b=Js9NxWsuOWIIgNkfRYlzhqJaw0GDclJvBUewX/MkYqR0qBqg+coHsB4E5BzuqeTN3DUTzI3VrAwVPlT+FxAC9IIPplBbZCB+aKrgWMad/oxqneu1KRzPFz+j+PZBtKqVEhmb04edeD1F74lvf6AVHyXwOpth8oosHiuFx0hXaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557346; c=relaxed/simple;
	bh=kfZ/qMGdaLc9JqtlgpRlLCks7N0v+gTh6WRH08apTuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RCDzdlV6aKESRYwJs3/IvXnWOTIH4E8Gkb82KfKHp2BLWQNgmVWOlJlZEmHlos4RyQ7yzrIfO7SbRTPGSf/cqeq0QJp0XQpCUSMcHfleOjl2yICqzAoMcDrhC6INTzXt5KR6LvZHvQJDR0oJMvD7t3DsaCBeQW/Zln8lknI2Xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tx3LWXlN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tx3LWXlN"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GB0pJ72358614;
	Wed, 16 Sep 2026 07:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9IKrS
	XKAMmMA9spcClJH1y73W6vj/qGk1asS1dpN0fY=; b=tx3LWXlNzExpMCeh9nOTz
	Wlu0l+XH6+N81d2AicqKf4QdFXQuKY3xRclgPFwl3zEThcJRjqVS5lo48HQgCbxW
	X/jawp9v9TZsK/TivUSjuxREalIouc6z+h1ZQSopB4LxA5etirxydJs0acdPZnzY
	QRvP5sBVFeUwawrXpdG6+S2IKKUw6fF0iDIzwl/S8YG/PLZy7rdc1VA+0AfCVfb+
	9VgIA8sJiNg/crQuBrQL+ABZjD5L/6T/KGPTcYMAzg+ABwwmwMOLg+u/rEWztUfu
	XaP1oV2lJuWsVCX3WlsFt+2ZXZetSPBokdChIbekZjUeF5s8Rz5AhF5FJxl/2Z3n
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ee2sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFFFf047112
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:14 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE1004263;
	Wed, 16 Sep 2026 07:15:09 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:58 +0200
Subject: [PATCH v8 09/17] iio: adc: ad7768: Configure channel sampling
 profiles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-9-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=8361;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=kfZ/qMGdaLc9JqtlgpRlLCks7N0v+gTh6WRH08apTuc=;
 b=6MeJVvzZocs6Asz+xFEr3V416VSFSPkMtWY8IJEa8fWkjuvpjNClwZYOFAuIoB5gsfujT+GMz
 PwOBBTIKsreAUEYoGxEvGH2YCLrHxXfYYmjftzsVgybQjxTWcEaxrcn
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -jHuz5oxXS2DT0417p-UppSnn1DUEBvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX58xuWKbbW3CZ
 uwGnpGFhHi/3uphCEemA3h8cp7hW6npAQeqJzZFpdOUXGC9N+u0zWpOpDSQ+PRVStDDapXa19Po
 18PGxuCuAZlIkS47CrxnP86x8CTOM08gN65bKcgMzMzevHtsed4hseS5RWq1SmFuaDvNy+Qi24a
 hhM0L4HgVp3ePHswACtUqzJTbPGdakGdp8STEKC9RN8M0lBKUk5DQJOcjGmyXqXeVJNrxJGF5F9
 GfUGYxakEi8vgWe7kBy3WuhrBksoz+V61F2BvtYl8NrZAlf5OLqiH5rcHnUmzan6OFeiaLwl7FX
 vYLqV2Ey/m3eueYv7crb4CQza/PW8Ho4HdJZGXESsBRZnv8nlxlAQC5hXPf/IlHvsj7eyEXj0mO
 viepGCDyjVNUWR2vXtLMulsHaRPp1ElJE1TfpX8x05daxo58Ej5F8iMKxgWlvaVue+GGONHLHMl
 4B/1q61V/F94o1A6Vyw==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aaa7a44 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=YaUG07iyn5Nj4qywQSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -jHuz5oxXS2DT0417p-UppSnn1DUEBvJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfXxS+c8BtD/3oJ
 q4uPz1mUAyx5IRjdqQsbrel4//zerjpE3DOWNzC6PaDJuueQEZ2PkETzDCV5eeCreyvMk+hknEZ
 a7ablRSzzQuoP8Btmfnkdg6K38xxekN2Um9G3WXS3vCM6qID+Kiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

At buffered capture setup, select the fastest compatible power mode for
the enabled channel rates. Group channels into the two hardware mode
profiles and program their decimation, mode selection, and data clock.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 165 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 138 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 2d051d91e1cf..fc8226d5d556 100644
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
@@ -201,6 +206,17 @@ static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
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
@@ -482,23 +498,131 @@ static int ad7768_set_mode_decimation(struct ad7768_state *st,
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
+		unsigned int channel;
+
+		for_each_set_bit(channel, scan_mask, st->chip_info->num_channels) {
+			if (!ad7768_find_freq_config(st, mode_idx,
+						     st->ch_freq[channel]))
+				break;
+		}
+
+		/* All enabled channels support their requested frequency. */
+		if (channel == st->chip_info->num_channels)
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
 	ad7768_keep_xtal_channel_active(st, &standby_mask);
 
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
@@ -656,11 +780,10 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
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
@@ -673,27 +796,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
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
@@ -803,7 +906,11 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 	ad7768_set_available_sampling_freqs(st);
 
-	return ad7768_configure_capture(st);
+	ret = ad7768_init_sampling_freqs(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power mode\n");
+
+	return 0;
 }
 
 static int ad7768_reset(struct ad7768_state *st)
@@ -976,6 +1083,10 @@ static int ad7768_probe(struct spi_device *spi)
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

