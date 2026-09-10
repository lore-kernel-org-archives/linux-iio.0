Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CB562609;
	Thu, 10 Sep 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061882; cv=none; b=CQPCL6Vvl6/6o5yxD7Nm6tq5UlBoLgJwvTz8ZOVP2kdzJyyjY7BYSo9+3/PZQ0jXH3S+ew/C4vAzBXbgq3RxZz9MyIvmkiYtinfgmxJqQXDVLb8FC37uisUZrpPMHxKg+dgYOPZqpuxyfSDCOEwrfx4yXvY766RkM8BxF8CeDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061882; c=relaxed/simple;
	bh=JzLGwF4GNdfnWfVfgNQ41pa0YGlM7SlBhitI7Ee8BYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=id9K7Uia6ugf68h81+hxH0Dkx++g+3o8CsaLRE7ccQnnJzW9soOY9WYOOXPrUgs6oEQvn89S9FIJTgvlL0U6GfSiaiS9tLXetptXkJX75APDe9QghPJbTvy+UMz0HidIoFoT7FrYA/XuUSZm1ESQhekGTxO1Ye8bvnEym4rK4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Rj5VrGpY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Rj5VrGpY"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7uVq3830296;
	Thu, 10 Sep 2026 13:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=s754L
	rMJhHhIXzeKWmqCAGus7RIzyNike/JCi3YDr3g=; b=Rj5VrGpYsEsIhUcrk7YI6
	8MC3dSDyFUyxxiF+Eyggn9OcOItqHs6X8ew1rN0ebzD4/9Q75hKs6RHVDH43nLKs
	Tj6HNOQN4Ny2+bA5ldwdRgMcdKeFH+2JjidAL7pBLiPmIQQ76gBzQXnFaqoeHXFu
	nD0wYQGOrYXsWmn1aNtUv/CamoI1WOtxNCFDy0wuqGHLClAfU18nwTXWHXy1mJz/
	sfABHwcrui1kkVbHY0HWdmRojdYdGgWPryOyRlslJp7YNtVlG5pcMFwfQ4gBcuCe
	hHamiVFRWhwPdCkUeZqf6S8rlM8kNvMj8Ud4WyzN/sS6CW3YkWBuZpi+A76Ahdj+
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxad2ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbXAO038820
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:33 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSg018832;
	Thu, 10 Sep 2026 13:37:25 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:28 +0200
Subject: [PATCH v7 10/17] iio: adc: ad7768: Add sampling frequency controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-10-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=5135;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=JzLGwF4GNdfnWfVfgNQ41pa0YGlM7SlBhitI7Ee8BYs=;
 b=E604Whctt/PCPE5tVJ6hbopDMiKUM/eACEcpV/6LgjVTuXTdJlx5+yreyGAZK8l68l5nYJk48
 HPGekrK8HDpBW8P5hBnviMA4xpDCSEb4vIHB9mWMpdEMQjicFC1QJfp
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX3gfo1XAZaGw0
 XcCvnIo2y51F/mTf1WoU5eC7jZd84tchd7RvfGoClFb6d2pyrTGTAFOgi10o78dfP4w10vWQMYq
 xd1xxJZJvS3ywH5o8vume5uVzPs65koBZpHUvskEP/rRMieuiiqB
X-Authority-Analysis: v=2.4 cv=Ao17T+9P c=1 sm=1 tr=0 ts=6aa2eade cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=LMPk9M2IzwWsjleXqZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R5cwsKbAFOaMVrlSf0JOgdTCfKL765WS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX6VXaRKORbm8m
 Jn5atx3/JDHWnb5K+0US5XVvm8YMpDCJuvXvuHmSrv7EQceKKu5CyWqDMSsBfcTIKNSbZMGg7it
 pLPkZxdRMRiXIgNIkSAr089XGrzbOAgUYelvSQFR0l17bWpo1HtvcA4eNpx/nse5l4zinGry3oK
 Z6dVHuO0bB/lvg0Ky6f8aSuu2Brv1NGVdMkoPSKsqEipDcM3O2DkQznykC03sbW0f6YAVEkvqaX
 hnFA4q5i3b54p0POzQI88sVxb1Xbrgmpw4C9VxJC49dkPsRwM2ZgTnjk3/PTmkk84zLhKzbfwnG
 x2fpdHx4ai0JzviKnQjPd4VFSCqtHk4eHgyz2QF9XNgsCmjUtTQwum8mITr7OJojpj2PStP6suf
 PXZADrLNAeqeWkRXZhvDN56naMWkkYlk9QLk313yAZB0z7R/jS8S2Xxe20FZYO5SEjQGWWCuaRI
 ry1Cpf0cXUUrUusmHcg==
X-Proofpoint-ORIG-GUID: R5cwsKbAFOaMVrlSf0JOgdTCfKL765WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Expose the requested sampling frequency and available rates for each
channel. Validate requests against the rates supported by the power mode
tables and apply them when buffered capture starts.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index a957bd8e0d6f..36df678bd00f 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -121,6 +121,9 @@ static const struct ad7768_power_mode_info ad7768_power_modes[] = {
 	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
 };
 
+#define AD7768_MAX_FREQS \
+	(AD7768_MAX_FREQ_PER_MODE + ARRAY_SIZE(ad7768_power_modes))
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -157,10 +160,12 @@ struct ad7768_state {
 	enum ad7768_clock_source clock_source;
 	const struct ad7768_chip_info *chip_info;
 	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
+	unsigned int n_freqs;
+	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
+	unsigned int power_mode_idx;
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
-	unsigned int power_mode_idx;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
@@ -512,6 +517,32 @@ static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
 	return -EINVAL;
 }
 
+static bool ad7768_freq_supported_in_any_mode(const struct ad7768_state *st,
+					      unsigned int freq)
+{
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
+		if (ad7768_find_freq_config(st, mode_idx, freq))
+			return true;
+	}
+
+	return false;
+}
+
+static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
+				    unsigned int freq, unsigned int channel)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (!freq || !ad7768_freq_supported_in_any_mode(st, freq))
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	st->ch_freq[channel] = freq;
+
+	return 0;
+}
+
 static int ad7768_find_matching_mode(const bool *mode_used,
 				     const unsigned int *mode_freq,
 				     unsigned int freq)
@@ -690,14 +721,63 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad7768_read_scale(st, chan, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
+		*val = st->ch_freq[chan->channel];
+
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
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
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
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
 static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = ad7768_reg_access,
 	.read_raw = ad7768_read_raw,
+	.write_raw_get_fmt = ad7768_write_raw_get_fmt,
+	.write_raw = ad7768_write_raw,
+	.read_avail = ad7768_read_avail,
 	.update_scan_mode = ad7768_update_scan_mode,
 };
 
@@ -770,6 +850,20 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
 	if (st->datalines == 1 &&
 	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
 		st->avail_freq[n_power_modes - 1].n_freqs--;
+
+	for (unsigned int mode_idx = 0; mode_idx < n_power_modes; mode_idx++) {
+		const struct ad7768_avail_freq *avail_freq;
+
+		avail_freq = &st->avail_freq[mode_idx];
+		for (unsigned int i = 0; i < avail_freq->n_freqs; i++) {
+			unsigned int freq = avail_freq->freq_cfg[i].freq_hz;
+
+			if (st->n_freqs && st->freqs[st->n_freqs - 1] >= freq)
+				continue;
+
+			st->freqs[st->n_freqs++] = freq;
+		}
+	}
 }
 
 static int ad7768_init_sampling_freqs(struct ad7768_state *st)
@@ -867,7 +961,10 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_separate_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.indexed = 1,
 			.channel = channel,
 			.scan_index = channel,

-- 
2.43.0

