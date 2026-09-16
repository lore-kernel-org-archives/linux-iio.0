Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A94EBACE;
	Wed, 16 Sep 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557357; cv=none; b=BHzPjClAXaCuUWz+/t2srMvtT+z2Y5W3rctaoIpirS3TFl5vOx4KB924b7Y494zzqM5r2nXCZooyOhAihTEWnlcPPNsJysSOrWiRTt2wY0AAzSLw4+6PCfaxrG9UOVQkEhOiqx6vfYvmKKGMk0T4KoWnaLDlSmdUYcgW/jUnKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557357; c=relaxed/simple;
	bh=OHKpOzFSbJVcbWAhWaeUsAynq+Ky75g2oYA2fXGg40w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=COWjmvVns6cDdcZjUKX4FISe1oK8H9w8Whug7K70HPhjqtqtxr3xEB8pbNy5aQHKyLLOJuSLgC4Vb8oYrr5nT5NLIqUIHLhI53a9j6785jEcPruRC8yvgr5MQjyJqJOigXzBtCl/u58N5LRHSwVCMIbu5IunrPvh5s5YYASSDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vq72sGvp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vq72sGvp"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6M7Bg1591671;
	Wed, 16 Sep 2026 07:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6ULxR
	Tpwz4xBrMjMzzLbIWVeLppq6VE9GY6wObPgXTM=; b=Vq72sGvpaAlpkVKjQgrdM
	P7gayd9YyTys7Lx3n69Qx1xksNbiYe5WJb+hoqF7+jpS4ps6g4+LkuZl1jo58mMO
	aQWF3v3Sg5LZWkuGR8qB1tQxsDMCAKtLRqmb1cdooE8epT95248GlvyqCzhUCNqU
	SrVISXRszc5vZTMR9ZnHZfATKUnQWXpIsAEL9gSfGpL3FVk7igf3qAmhE6PEb0Ir
	EotkCQbySfEmfMgbrpfPCud09w4tswHibLEz7Bcmg4hg5asAN2A308y00XNNTwyj
	ENgkHevqug2vEsqG4eEnNJHp+A/AfSlYpLjd5v//yky00Kr554UMAan3At6WbxUv
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFIIw015772
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:17 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE2004263;
	Wed, 16 Sep 2026 07:15:12 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:59 +0200
Subject: [PATCH v8 10/17] iio: adc: ad7768: Add sampling frequency controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-10-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=5208;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=OHKpOzFSbJVcbWAhWaeUsAynq+Ky75g2oYA2fXGg40w=;
 b=+8Fme8g4bkeuXnyUGcavxOIfWrmOfwWOfUNkZz/jf0+Yxq0jLcwN3uaYoqZ/AxO1c6yOxHB1f
 ckY8f6wAlt8DVckhpdlbMA2A9f6LapW9ItztoIc07UIPh72muzhMjen
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX+DFPa1Wknkhe
 /aNg55Y12NZe5ml5NrirXY8229/0LsF1OVdluFWEqnKTGm9pWkbeLFuTdCDLr120wNwQqNq/4xP
 bxdk/iFDzt6p/kcJoouzDbfbxzfVLEM6wlHrFpUx7ARIq7KTDm3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX+ha9KFGUNAVx
 o+rTkwf3/h6H60TjJdqiT97ipEHa/4EeNRyLHI2bP2C6521OBdMniB7blO+2IRyqFmE8jOqfGsm
 +n4P163Q3aoe/9gTkTxNY4bc//NOlOigkoRhV4wAutgzrKRPbYxMSxj2VQ8nFvVNOam44bEFOPS
 VAZNYRyp/o+00MsWSNLpc93lEgJh+wa8/UnGLe2JwthZ53XxKcyLg75Tb6HwQoGZ5y35bzK1e71
 tHwQ0H1Yk+KD8AELrMyqvf+CgnP/Jb14fKl//VGTv9a35STSdYj4k6jgFp+tgeTfdg2uZ8TXur8
 9keiglzQjmBMiIIn34i3/BSFnpZsFeHKKswCLLIg7Y+nnTzFFlYyKqepP3OK/lokRStqx3vAOKi
 L8PRJlczzIG4gDIpenzzSNLEuKoYx2i3FZq4erQ7EePpAziKT80lTfk+NkZ54dfNVvJJsXaatmT
 taGuxEtrm4YosVrVbng==
X-Proofpoint-GUID: gcmP-ZsTNyUb7qfbGfeBIK6FGWXsVDVu
X-Proofpoint-ORIG-GUID: gcmP-ZsTNyUb7qfbGfeBIK6FGWXsVDVu
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a47 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=ry_hK_7kC3Z5520j-_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Expose the requested sampling frequency and available rates for each
channel. Validate requests against the rates supported by the power mode
tables and apply them when buffered capture starts.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index fc8226d5d556..1bd86dc41b2c 100644
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
 
 	/* Used only in regmap_read() callback, hence guarded by regmap lock. */
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
@@ -525,6 +530,32 @@ static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
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
@@ -698,14 +729,63 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
 
@@ -778,6 +858,20 @@ static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
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
@@ -865,7 +959,10 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx++] = (struct iio_chan_spec) {
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

