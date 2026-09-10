Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CD4F054B;
	Thu, 10 Sep 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061889; cv=none; b=g95ixtbBBlT7WferUT0Gl03+KOxCMBnHnvGL9MM6B0oClZHerR2qrGlwFtKfOrx7Eb7dve4vpMdS0rIa4YqF8ggfiER9wxw13WvL4xlzY5r9XVCjEczgP15h23/qcdAkFm2xZjKd6axbKXBTg10GWAYoKsIS9hiALPWq9TcVdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061889; c=relaxed/simple;
	bh=qFBDlxtBYcHhwsTePHahJ96kK93Jlnvb1qN6fWu6fMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ayANtz4ymHQyu/FTNC8JSz7+2RkEHGFPWoiurfkcDQsiM/dqtFvwhvL80k3O7ZOm65xNpeCHmcuPJd3kd/mVLzhDelLPv6bYEx81o6dDHGUDfGq9WAdpDfNr6uhyNIM7J0RZWp0VFKjHM+N9khZqnE9rqox4cY5HNM+vY1boEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TGvC0L7B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TGvC0L7B"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF8G7P094914;
	Thu, 10 Sep 2026 13:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=m9BvK
	IxXV2qazgFlLu3MO5DwNYgIdhLmZk1CZefSIAs=; b=TGvC0L7B6M7lZgIUXTuuq
	9oT3SzgKbaTsNuXr+plM0FuR709gQ7U/gBSCTPUzjJtcfg9BHuvqJilSCJIJOS8F
	5wV/oSSGaAMsvvV4DQDeK+IJZMKR1eq0IZkFeyIMMAcENK8d4hBi1AnSVUOfr1qa
	5L1cD93ULRgJUPR7GBp0i9nA/13NfCrs9OI3WFP91YgraGLnkJktPrR7HhGdPnfZ
	/ict0uHLH/EYFMAsqX1nVCxUHZ4Jgb+lnBiKIRIrWTcuBDzsJSQTLIdJr95ZiD9o
	OTU/vSitksvX3rAH+hPEsWZpPBm0nga4o4C7OcRYCNDpwS+vudfNjjeLhQ7cjYvv
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcw1ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbaRo038829
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:37:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:36 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSh018832;
	Thu, 10 Sep 2026 13:37:28 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:29 +0200
Subject: [PATCH v7 11/17] iio: adc: ad7768: Add per-channel filter controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-11-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=5046;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=qFBDlxtBYcHhwsTePHahJ96kK93Jlnvb1qN6fWu6fMg=;
 b=7ZXf2WfB7cMrWXsjOSRBKw/4esuTLM947C1TFwt/tYDgRGWF5hfEbFKno3z+iLFWoif8vVqos
 gCELWftCDVSDzWq6MZ7KwX4TPze1bsaTJ2kYqa+Oh7lbH6fVVhWG9uX
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX4TGFZIsiLy/5
 r8i9AHQ/BXhX/zYIpP1iX8PTMUkSXtXVgSFhDJjqG6PHrmUKvbJsYi9sfaNAyvDtJFSAHFDFVXw
 ITIWsh768RTr3cvfAhfo6ia9xedRZZil287XBL0WpEnKF2o6su8XYstmZ9tTw0ZyjSqJNutsz/M
 tZ7l4KuTsdlaUdcnzcWv3iolABWjlrYcrc/HcSt+nB2J7lpg8uSVdQnuJT5eJlPdzswoZx4ny4V
 qsVnJTvQ/KV9lkW5aA+Rz1IP1YcLUD5U3WhenzGFBaSdLRCBro+mq0zrwLM0Ft/vK8q6abH/hy7
 X2QB+j73gCNTI7wz6LWMSrsnHSosWWiKDuQef3GFkD65f0bVR01sj5AjsM/fKqfVI4kohWbLQ0W
 0CRaylVlQPZ3cSP0GSeVU2xeQa8zuc/K64AuSNpKxA15u24d5Kturih7pNP2fpSJnij0pmphR8W
 QALqqjuk5Zr5IVikhng==
X-Authority-Analysis: v=2.4 cv=GoTXaU1C c=1 sm=1 tr=0 ts=6aa2eae1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=u1yhE7RKQyILiklAgKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX5fSoezhe5Wls
 e2ezpDhox4BGsat7K4YgNoNnCaYgUrWZEugFeXQCi7qwBB705rmx1cITKgdgs2KMgndWMN0Pxd+
 dEXasOTxR+4/CVMvF79w0d6hrsfYZybNwq2IjNIAY73+GTs9zazJ
X-Proofpoint-GUID: fMWEiXTLGpT5PD0lvpbbsk26ACoCpNAk
X-Proofpoint-ORIG-GUID: fMWEiXTLGpT5PD0lvpbbsk26ACoCpNAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Expose wideband and sinc5 filter selection for each channel. Group
enabled channels by their requested sampling frequency and filter pairs
and program each pair into one of the two hardware mode profiles.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 72 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 36df678bd00f..2ff8a8569c0e 100644
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
 
@@ -543,12 +549,59 @@ static int ad7768_set_sampling_freq(struct iio_dev *indio_dev,
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
 
@@ -558,6 +611,7 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
+	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES] = { };
 	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
 	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -592,13 +646,15 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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
@@ -622,8 +678,9 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_MODE(mode),
-					AD7768_CH_MODE_FILTER_TYPE_MSK);
+		ret = regmap_assign_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+					 AD7768_CH_MODE_FILTER_TYPE_MSK,
+					 mode_filter[mode]);
 		if (ret)
 			return ret;
 
@@ -879,8 +936,10 @@ static int ad7768_init_sampling_freqs(struct ad7768_state *st)
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
@@ -973,6 +1032,7 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				.realbits = 24,
 				.storagebits = 32,
 			},
+			.ext_info = ad7768_ext_info,
 		};
 		chan_idx++;
 	}

-- 
2.43.0

