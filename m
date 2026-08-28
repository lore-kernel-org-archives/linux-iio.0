Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A07360EF9;
	Fri, 28 Aug 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931102; cv=none; b=IU8o7vRN6v3nVZH8MNUENRYCOXhe7lo4scMv+8Vz+LArJ8WqwDLj9i1/TVGWmrEgegbZomSxyNEc8t/cW2HIkHgu1lLDOfdbLpHArQi6zdrbEIslSEbeRbCzQ6PfejHAsN+5j2gDDOVqWo2CCL3hVHZNrxmi4LmIypBcGe5mn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931102; c=relaxed/simple;
	bh=NZzFqpngcCmjyA3h9Hu/0QYnyj+O4qxb/GTiA1jsTNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MNxcNMt+SXddqYvwLnp66KdmSnq23LR8kktYSGhIpjCU1eOmfIb/YlLlL1IM89GUI/lSKNhsjScckFuWT4JW5iwNPH9BYUp4KrhNIiqeiOaKsaWUKnFYp5Hf5IsduJXe2BQz5TmOw9K0bhJWvFcYq4rpw2JwEGNtZSPwJB8FkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F7ga5dPY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F7ga5dPY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWPtc2013156;
	Fri, 28 Aug 2026 11:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A2a86
	Ll4vlgF9s/SE7NQxQkVP1ygI8LJsI5p+rtv49Y=; b=F7ga5dPYOC6t/0Z+b2tb/
	FMZbOtOHOHwwEMk4ZPrkcIL6T+C2BiClPxOzafFUYAP2St8xHW/3ymT36aKsoJ1F
	rU2F9AtRZ/Vwo6xAv2xuZ7ei85U98E4G87uJBioKJEHmQzkwuZvuwpTquVQIfxp0
	Rbp3yK3ej1R5AOoQrmd8t0TVNY85GjCS8ZQn7Ec2W9aTKB2MVYaui1H8kAeTuldP
	4/4gpVUJMrc4sMIOxb0f4ZceNul1OY4WCrzhfAjI6iHki8LkLFt8CnnJO1FJQ1pJ
	FAxOdUw5/TnyfgmEEzaSodjU0e6cmioe9W9yf2aSm5ClBwDm1b1dfxZxWTRJvmbF
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m14eyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVT4w013093
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:29 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3p031424;
	Fri, 28 Aug 2026 11:31:23 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:33 +0200
Subject: [PATCH v5 10/20] iio: adc: ad7768: Add sampling frequency controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-10-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=5563;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=NZzFqpngcCmjyA3h9Hu/0QYnyj+O4qxb/GTiA1jsTNQ=;
 b=JQDYLzLWCbrYkD010diSzwB58wg9QJh5eqoIhiSk3wM7vt6mHiEtbKYMkGyWVDfAvo85HCOri
 NdxWgxrAJhRAAyeQPT0hvjhoyfJPT0QHQutgyeNWvVD2mtytBxlsTFG
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: hkbI-nEPMiAxJSK4E3ISkf9SFOeDcUHw
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91a9d2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=DQ_gTnqUUE52UBPUpMQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hkbI-nEPMiAxJSK4E3ISkf9SFOeDcUHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX8BzIq+dV4PPK
 V299sktNx7S5GOZAq7X5kT7U5264mqBagB1MpbMh1SmfygG26ufDelcw4coQ8uHKXEWfmcT5p1B
 ZlWB5GoNW8JDuIUciz9nU9545eep9t9wOQ/8NTPo0oOpbacvx6gmgw1bzp0mK1t7ZDJFwYzTQcO
 yK2V7XOl4ZNgpBBY07aHDMro15rA+LmDRD/19lo7b19JGmFEp5h6ekT5qghDwLQwX+lOJWQRzVx
 uOjQdNiM1j0AO4XRrwc6hhhGy5H57vJVk85TNwn8V8xoM0MpFR8uKNC6K0C7Lbrnrog1BXyR1mC
 pMpWfIWVV94/AKMBBbRz657UW4kvfu9VTgvrwed/E2zidyawy9OpGLaGSBrUfzyuOylTR5o01me
 g0GQnNoceAHuA8DiB08TLcHV2sTtzhEgtsSGl4toXfrtIg1NumNYRaMWK5QZMFrvN31138BkxgT
 bJH/G5J7k1H331bxIGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX+mDg0WG3XKDi
 TmmqWx6jfsLxXZPBhLquxh7NyiPQcDM25xVjByQ4j7aTXOAw6uPKao5WGm22xG0UM8F/NaMqFMA
 t/+3SySMzPNuQ4lR+v96XHZ9RlmJL5P8hgJaChSgRbwekFPad2o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Expose the requested sampling frequency and available rates for each
channel. Validate requests against the rates supported by the power mode
tables and apply them when buffered capture starts.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 116 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 00d6f1dce591..1245ec94b637 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -130,6 +130,9 @@ static const struct ad7768_power_mode_info ad7768_power_modes[] = {
 	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
 };
 
+#define AD7768_MAX_FREQS \
+	(AD7768_MAX_FREQ_PER_MODE + ARRAY_SIZE(ad7768_power_modes))
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -167,6 +170,8 @@ struct ad7768_state {
 	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
 	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
+	unsigned int n_freqs;
+	int freqs[AD7768_MAX_FREQS];
 	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
@@ -496,6 +501,32 @@ static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
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
@@ -656,21 +687,74 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
-	unsigned int vref_idx;
 
-	if (info != IIO_CHAN_INFO_SCALE)
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE: {
+		unsigned int vref_idx;
+
+		vref_idx = chan->channel >= st->chip_info->num_channels / 2;
+		*val = 2 * st->vref_uV[vref_idx] / 1000;
+		*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
+		*val = st->ch_freq[chan->channel];
+
+		return IIO_VAL_INT;
+	}
+	default:
+		return -EINVAL;
+	}
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
 		return -EINVAL;
 
-	vref_idx = chan->channel >= st->chip_info->num_channels / 2;
-	*val = 2 * st->vref_uV[vref_idx] / 1000;
-	*val2 = chan->scan_type.realbits;
+	*vals = st->freqs;
+	*type = IIO_VAL_INT;
+	*length = st->n_freqs;
 
-	return IIO_VAL_FRACTIONAL_LOG2;
+	return IIO_AVAIL_LIST;
 }
 
 static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = ad7768_reg_access,
 	.read_raw = ad7768_read_raw,
+	.write_raw_get_fmt = ad7768_write_raw_get_fmt,
+	.write_raw = ad7768_write_raw,
+	.read_avail = ad7768_read_avail,
 	.update_scan_mode = ad7768_update_scan_mode,
 };
 
@@ -743,6 +827,21 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
 	if (st->datalines == 1 &&
 	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
 		st->avail_freq[ARRAY_SIZE(ad7768_power_modes) - 1].n_freqs--;
+
+	for (unsigned int mode_idx = 0;
+	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {
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
@@ -841,7 +940,10 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
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

