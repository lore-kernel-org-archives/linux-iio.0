Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D544F4749;
	Wed, 16 Sep 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557377; cv=none; b=jsJiKA5d+7ail+jsN+5bUhaZFNhvQCNN7freA4Q4+oY0JTZ1v9d6xtkRkY2N6HuaIwhjLLMlRLzSyqUR6N79rNMeJaV71it8KgL3L2l2AzyV34x4E2Gxo2HKJgFWEKjTnc1xszFYEbsY4shsGLpGs4aHF4jRL+/NQW22yOPVgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557377; c=relaxed/simple;
	bh=35OkYFOWBEMMZ4daLpY2GcuANZ4j5fZkzy9bdNhgsLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BZoykIyhFbyAodvVzJbW8sXYtOES0b8lpAbC+WBlH37XgidvEZpw1DSsYZrXbUpJVdDiwakiP4kU3X3siAnApY5BkiBdFPCZ3GxgC1qB/Dlxge7Chg5rWupvwnKR68Qz6aR00HIXs3KXDyLQ2imlAkfXGhlav8pbQGROopheDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E94N2+M7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E94N2+M7"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G79dNm1591639;
	Wed, 16 Sep 2026 07:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7cDZj
	50L3wCrX3fd95v045w/2Wh5HWpt6csfuPyCcPE=; b=E94N2+M7+HFnnDSJmyGAB
	DGrw442FioLPm8iX63Jo9FH5+k75s869siWFYQ0qbKaQ7SNEhK2e5uP1LqJV8O+b
	kjk4PuOtOhStcsM1XEKMok5ORgCtCeMIZr3ETvMChK3ttkXILpXMtlodR8hfqNX3
	WdqtqRyx6Fo94BEHWk7hK9E/MulW2XYbMW1xNGiH9XaQBkFwQ2s7PIsLlsaS161k
	D/m6IZ/3K3LrcDqKw8rwEkrLXonc3HteBT0K2mmALOBRNldIkgnQQKeyT6barqS4
	NvNxr5m6EEQcRbz7ztI/1brRXBk69rO7jvhmuzIWma2UhYik69vY0bre9JKi+/7K
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFKDA047121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:15:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:20 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE3004263;
	Wed, 16 Sep 2026 07:15:15 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:00 +0200
Subject: [PATCH v8 11/17] iio: adc: ad7768: Add per-channel filter controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-11-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=5033;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=35OkYFOWBEMMZ4daLpY2GcuANZ4j5fZkzy9bdNhgsLs=;
 b=D+RWGcf7nO6dwvZesf2NJuAUgrKI2YK/8qlbPggzXR9up06uH348rrRecssJLpInNXxEWgDDA
 nC/LRxE2+t4CYUGmUVypRRptB/RQAQa74XtGWJ29J7wU1RKlOzshKP0
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfXzb3K354BAiGn
 uGsFZvqfKD+NRh3z7jcWiiyhm6woogAr/0gNhr2TdboWoSUnMI5tfwsRfYMCMDtslxBJ9+B4bEV
 yEhOwOxLEPK93pJSkMkbfUJYUKc9Tx9wd+OUSvaTAseSXSNYEvzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfXwz054VgdjRZt
 rBVhY//zyopCKHn7vRvSnUzL6ZAzTh1QReYEcRQbktCgqhLHUXCs1FM/Qxt/1TavdosHIXXNPwn
 0goaBy0eEB7Cn1m4N4LgnGZAd8u6wF0eYppmMH9+u41ylOHXpJZ8HRQnNaN3wtNRT5RUmKis/dg
 Cr5PHJC5swSZBzOKb7MX/CniBtEicv1PhijFpNPg5jN6DNxD8mDJll7VksxLxmJ2FVrKHQPTpjx
 YG1nvbc6pTN/NsV75sctdLpLhcZavX0I0nY4of5mZ7wLMYt129EuR9OJUAh2crETwWVcFrSEftw
 rb/879nZ4BPkgMvfwan3ONeYJj4tmG/PaNDYxshbcVQTyvVCpPS6oVFfb72aTllgecG4DRV1aiR
 hF7jRXLg9PIntJyVQAmhoNu3pAQOdNQFpGR/4NCCRnM+sH1ndI88Qb5ggmYQ9B0vhWmz2+SXGTg
 WFVocNBHehsAta3y8qA==
X-Proofpoint-GUID: sGPRKycywAcwiE22VZ3w2mNbuZUAA7Wa
X-Proofpoint-ORIG-GUID: sGPRKycywAcwiE22VZ3w2mNbuZUAA7Wa
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a4a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=u1yhE7RKQyILiklAgKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Expose wideband and sinc5 filter selection for each channel. Group
enabled channels by their requested sampling frequency and filter pairs
and program each pair into one of the two hardware mode profiles.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 72 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 1bd86dc41b2c..b2e129e6fa33 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -104,6 +104,11 @@
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
 
+enum ad7768_filter_type {
+	AD7768_FILTER_TYPE_WIDEBAND,
+	AD7768_FILTER_TYPE_SINC5,
+};
+
 enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_MCLK,
 	AD7768_CLOCK_SOURCE_XTAL,
@@ -164,6 +169,7 @@ struct ad7768_state {
 	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	unsigned int power_mode_idx;
+	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
 
@@ -556,12 +562,59 @@ static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
 	return 0;
 }
 
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
+
+	return 0;
+}
+
+static int ad7768_get_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	return st->ch_filter[chan->channel];
+}
+
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
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
+	{ }
+};
+
 static int ad7768_find_matching_mode(const bool *mode_used,
 				     const unsigned int *mode_freq,
-				     unsigned int freq)
+				     const enum ad7768_filter_type *mode_filter,
+				     unsigned int freq,
+				     enum ad7768_filter_type filter)
 {
 	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
-		if (!mode_used[mode] || mode_freq[mode] == freq)
+		if (!mode_used[mode] ||
+		    (mode_freq[mode] == freq && mode_filter[mode] == filter))
 			return mode;
 	}
 
@@ -571,6 +624,7 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES] = { };
 	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
 	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -599,13 +653,15 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		int mode;
 
 		mode = ad7768_find_matching_mode(mode_used, mode_freq,
-						 st->ch_freq[c]);
+						 mode_filter, st->ch_freq[c],
+						 st->ch_filter[c]);
 		if (mode < 0)
 			return dev_err_probe(dev, -EINVAL,
 					     "Over %d channel modes required\n",
 					     AD7768_NUM_CHANNEL_MODES);
 
 		mode_freq[mode] = st->ch_freq[c];
+		mode_filter[mode] = st->ch_filter[c];
 		mode_used[mode] = true;
 
 		mask = ad7768_channel_mode_mask(st, c);
@@ -629,8 +685,9 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_MODE(mode),
-					AD7768_CH_MODE_FILTER_TYPE_MSK);
+		ret = regmap_assign_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 mode_filter[mode]);
 		if (ret)
 			return ret;
 
@@ -887,8 +944,10 @@ static int ad7768_init_sampling_freqs(struct ad7768_state *st)
 	avail_freq = &st->avail_freq[st->power_mode_idx];
 	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq_hz;
 	for (unsigned int channel = 0;
-	     channel < st->chip_info->num_channels; channel++)
+	     channel < st->chip_info->num_channels; channel++) {
 		st->ch_freq[channel] = default_freq;
+		st->ch_filter[channel] = AD7768_FILTER_TYPE_WIDEBAND;
+	}
 
 	return 0;
 }
@@ -971,6 +1030,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				.realbits = 24,
 				.storagebits = 32,
 			},
+			.ext_info = ad7768_ext_info,
 		};
 	}
 

-- 
2.43.0

