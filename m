Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B94AD7E6;
	Fri,  4 Sep 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531385; cv=none; b=ZdLnph9VqGKaqLJX76PtCZn+ZvesARrSy55xcbParIM0WPcB4c79j2f2+WhqpanbKlL0r3/xHIKIFreRHXSNn9RfWGGM7pojNLiyxdPxV6PamW6D8zUYySwIqaIV1gpfMs7VvhhOGH3+x3AVLtv98iQKDuvNrY5UEHPbMSZnfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531385; c=relaxed/simple;
	bh=KiQguzkvoEc5W6hNKkSArOr9OIkgiHdS5jX0QyXMxJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VNkl9jAh47i05SWbMI7LiCM0W+U1B44V6APEi6P2rtZZGT7kyLxN2tbiFY5R4/8RRUpFRa4o75yhGW6p2O6DTvKyM8qzKu9FJzt6Dk1Z9q0SmvfCsYh4wRGwjs2dZWozxBC5B4ejW9RGLTEwMPNRO9Ed4K3ryfrK8GSjXXKn4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iGOvQsuL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iGOvQsuL"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dhgcp553720;
	Fri, 4 Sep 2026 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uUntt
	ExvtV1w74S9V9kUlHAJa9Pn3tyjRpnh7mr293c=; b=iGOvQsuL9rUiJy9QJYkFJ
	u75X8aPZk83/J3HfYHtPZmOd6/UBpD4ab/cyIByy6nMdP/Esw5/oX3z5CS7H1i1C
	KAWCZXOrlU3zinE6P9wSWwjCSbET+e4AbhZZG5T2zq8WMGuijWYYhuLdVZ8zLB/1
	gG3nEaGPCF/WxOUE7yMVL4hO5PHYYUXkEFYrfNNhHFcrB9h3pk8WV4LLae8+8dwS
	OTv5sxkWW/7QcEjC5sNk5irW1+lVLMNEQ3OeYEDF0U80HDI4wl15a3x4TbbnFgm1
	6qTPo4qNoVeE+rAu4HSd4dsKa3HuZl9Z28VSFa6omXhIB4vDGOyDLGt+pBXK9xym
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffk4vhaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EG0dX036240
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:00 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dE026210;
	Fri, 4 Sep 2026 10:15:52 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:02 +0200
Subject: [PATCH v6 10/17] iio: adc: ad7768: Add sampling frequency controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-10-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=5135;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=KiQguzkvoEc5W6hNKkSArOr9OIkgiHdS5jX0QyXMxJs=;
 b=zHk95zD5481V1yJrDCeathuJgrZM29cfIhO7MqOfDRygFuIdYgMyJXLx/Wss2Rk50DcsW3QC/
 yWCaOH5RZZqCHeF5Uudi5GbKoiIw8vdcbm/S7MecBvaq/+1qSHg0IgM
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX4PJqUrpM6PnQ
 Yb115BoFU/uLJxuAzlSEdcshdEY3hHnhzwArczxLqQpVMfCxpUCyib8JJxyqrPfD9RTkDDkApMS
 GV7v/3KGhssmktWpFKdaG6IdhP3vwFgm+0yuN4/37jjhLGbALwWAlwAYQWei1kjXt9sa56yzaxp
 t4pXbY1pW8yZB4PT1v/V3L1jaCO2mqg1OQnIe5Dhjm+rJMBCVdORSo354KXDMsUAFn6NxXs6RMD
 NDQN3wOVZ/q0+yg+cYx7A+IstDzgKngRZRsp8uydbdvxxv0qkaBVMmC+/25xu9TI+8Uj5EYAIlX
 4wlyWpuRm+jrLjDABbCXzxRX9R++skO5mxg4CYl04O7yZPHRYtSZVmLHDozbRC90x8ykD0wFfHU
 oTK+Oc1aaXniPeDUkvbs9ryXNh5oZ5tRXhZWnYhJmAIPAAUIFCQtMXdHNbWfH/o/7dXToAejyDv
 eJDpMAV8uFWThtnMZXg==
X-Authority-Analysis: v=2.4 cv=QI1YgALL c=1 sm=1 tr=0 ts=6a9ad2a1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=LMPk9M2IzwWsjleXqZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xkv_B2E4qoJznpHl0l1qbNpFK90ECEJo
X-Proofpoint-ORIG-GUID: xkv_B2E4qoJznpHl0l1qbNpFK90ECEJo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfXzn+GSa+evvcD
 xvSzUWZrb/4oi5UepR9TlfLco3dvuMxZN3NESiAec/FMviBIhFE3n34AEYQblgfo3xLH4eZpIkI
 pmjsJ0c+TR3p7fDGU2ko7jRnrS52urqtLVTLb+5VHV5Hq3ntlxxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Expose the requested sampling frequency and available rates for each
channel. Validate requests against the rates supported by the power mode
tables and apply them when buffered capture starts.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 868130ebcc8f..d5eaef92cbf2 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -125,6 +125,9 @@ static const struct ad7768_power_mode_info ad7768_power_modes[] = {
 	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
 };
 
+#define AD7768_MAX_FREQS \
+	(AD7768_MAX_FREQ_PER_MODE + ARRAY_SIZE(ad7768_power_modes))
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -161,10 +164,12 @@ struct ad7768_state {
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
@@ -500,6 +505,32 @@ static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
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
@@ -678,14 +709,63 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
 
@@ -758,6 +838,20 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
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
@@ -855,7 +949,10 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
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

