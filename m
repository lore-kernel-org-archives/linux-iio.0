Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89836C9EC;
	Fri, 28 Aug 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931104; cv=none; b=qJJZfR5/1a8eyhUaAuoEysutSbBYdilUwAVZwdSDq3yuLs9wlugEp5eI6HmNIG29HWju4Tc3h8AzOvA9aFMFdW1xFfFHf6P5P3qYq+ZvpaAbTiILIallmFo6m6Pn7UEFE+1cZgwslwSft7gm4WRt5NfTz8WgoZll1UZgrTsgxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931104; c=relaxed/simple;
	bh=W/QCsFcdxiiKnoTH+2LSrhHpFVYdPanIhbm7w87rDzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fQ2z5Q7+RjgQ5CMkzmCQKx+DIL/363OymyyE+K9uXjLnVfZ06XwVUzd7Hn7qMqLbrX97vuNLvnOVb89jAYhraZakzsIyzllqXsgsr9N9OGR+I4RyMqIA+5Nzy3bgHLZxmotG9knRTtxL17WjC5hqPw+xklxpZZ9UOgd8Djn8BPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dMXsx80F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dMXsx80F"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWNJt2013118;
	Fri, 28 Aug 2026 11:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mKiTn
	I8PlQzXhNaW2vAdjgyozHcfKntzk2l2vlp+jPw=; b=dMXsx80FAlyW3PKdZKBSM
	+4jleT8QqGQN21Odfv7/gDY7RTaX7mVbrA7fgpQ49o/wtB1unckQ1GY2kZ7iYHPv
	mUSXIsy4Q+FAqg1ZaJAZOig9MF/XAynpMY7UGGUViTFAEkHy0iMF+hWTlUDZfd6y
	wKgNCfN26z3hPy6dIse/I6rayrR/ekvq7B+wllpt0DsEEZPRJUTHla65N/bEPHJJ
	XY7mBrdUEZoNytzgexhXf/tFrNzKaw5qivouAODvXx7hPEmetsEEWngUuVzz0air
	ash0WoVFiMI0kJ8b+m1804kfYl/VsUD8JQNGRnkxcviq0FfBAVxy55nxL+XPinB4
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m14eyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVX0e013126
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:32 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3q031424;
	Fri, 28 Aug 2026 11:31:26 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:34 +0200
Subject: [PATCH v5 11/20] iio: adc: ad7768: Add per-channel filter controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-11-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=5039;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=W/QCsFcdxiiKnoTH+2LSrhHpFVYdPanIhbm7w87rDzE=;
 b=XILRZnQ9Lk0tI8kz8tsWh+lY0cHHcuioAbIZj7299+egxUeKQLGxJI/lnzBiovhzzbyrtA+WG
 m8jIBQT9UjOD2nM8VrN0peg/D7nzGGa5XI892PAbCzvpJUaviYBuqAS
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EanwDyvgJrgRmfIe0CCgk-ohtqHlBXww
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91a9d6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=u1yhE7RKQyILiklAgKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EanwDyvgJrgRmfIe0CCgk-ohtqHlBXww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX5c+Vqa0OdJag
 7lYSMQ6b2/WV8qN0hpOCC3xDizIzamlBUfsvfUBRTy9FSA2X75i4M6I76NArCUZIlP536mVSn8u
 9GuEedj4WAQ1lnzSblN+IffcxAbYQZb2GFyDH8k2OD1kFaek+OKXjR8p6HSgYEaWwG3fdbV61zq
 iaMkrnbGsKqtv3A4K22AtdmT/jO/qZmNrt+H0TDDIsMZiUs6GtiTqiWih+Pmq2Ka9qDlrI0ZR62
 /j9rw4ik9us/B3mvHWcLLxOjIX22fZ53lck1rrQNhCv1rkZgTWcwRhoPMTJuuH2BzUz/dQ68BMi
 4MS/uUxs5U9zhMr7jlgngHkvPYnZ718UdWygsKKWuj2gU9pSZP2EKlkt+rDEDGjQjJsNuo9uEi8
 RtVmTvFY7pAAavXc8fN9/BNYlti3dtBisw4sHYZ6Gy14YgXSSib2IoedUXpyvktOGflBG1QcDxB
 2KiJ9cFbGVir5BtSFzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX+7wVGz8eO5Ds
 Czza1MHzTI9pqfF+RnG4QrL2JdRinbDelXVFmRFVSIFuL8iRjAd2SCkGOHzp3rI7PPAzmoVAJz8
 Y1N4ZIAboIFBV6n2YeJirVXIOWl4IiU+PdFwmYsDpBLYxSpHyGZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Expose wideband and sinc5 filter selection for each channel. Group
enabled channels by their requested sampling frequency and filter pairs
and program each pair into one of the two hardware mode profiles.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 72 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 1245ec94b637..4c67f692861e 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -113,6 +113,11 @@
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
@@ -173,6 +178,7 @@ struct ad7768_state {
 	unsigned int n_freqs;
 	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
 
@@ -527,12 +533,59 @@ static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
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
 
@@ -542,6 +595,7 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES] = { };
 	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
 	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -576,13 +630,15 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -605,8 +661,9 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_MODE(mode),
-					AD7768_CH_MODE_FILTER_TYPE_MSK);
+		ret = regmap_assign_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 mode_filter[mode]);
 		if (ret)
 			return ret;
 
@@ -857,8 +914,10 @@ static int ad7768_init_sampling_freqs(struct ad7768_state *st)
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
@@ -952,6 +1011,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				.realbits = 24,
 				.storagebits = 32,
 			},
+			.ext_info = ad7768_ext_info,
 		};
 		chan_idx++;
 	}

-- 
2.43.0

