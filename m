Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1342E8E7;
	Fri,  4 Sep 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510991; cv=none; b=ttzEetXFAjTVW0/qRuz4UcbFFAHTjyIZsBqhAinvQKqBKFUsFnGm/h6BHSq0o5jGSrq8iYHT1Mw4rsKqav8fmiV1HvRNKYreFltRVLP7N4KF77fa6g4XHrfJW7J9SPg+HcNo/cY+mwwF7OszHy4QKK4F7Cfbl1Hi1VKu7pv4eB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510991; c=relaxed/simple;
	bh=hzuQ5h0FD07vRSnFP7UKTPWjz3kVmAUmeGq0sVUqxnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jiyaTs4P9fj4kZwRB8+ZoYvzryW+fr+BFD3eIRW4aq0hSMZwGF437EihHw/jCQ1XkALilTFwxCTu4mJqOcavoTrm7s1ADnZiwmYzLCmPS0SRghBYUm9eVLMai2BbPdwnpxw8OwpqtZ61HlFVd5qcSw8X9kzCDGBQXVNMAu99MlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qGQzxOez; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qGQzxOez"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464sZY3147523;
	Fri, 4 Sep 2026 04:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lV8KG
	UAgGwq9FBjWtGP9+0kwib5vayvyXPLi3c/oeXM=; b=qGQzxOezYYGnShpXM9LRK
	rZ0eMkEEBhCH5weGJiQFUtF3F7qtOKxNuvnbW10YSViFA2vMYJgqG1VO88D33OuA
	fQOq3RGXaJuUF9K0EN6SBR8WR5GxAPtiB0dPDxuixdts/qDzHmPcRE0fYp4reBIX
	1qJ4zAfC6MNg8fJ7RbByucTNJGcUvbHZjMJbWPntMz0sk9bioUJQ9w2rFCIjTwH+
	w0Y9pyZ30kLasRLgkrUWWvkzwERgP8wtzYb2ZsvIfw6nQc6JE6mhjFBpGrX1Yry1
	Ipjm/jpYnWdvXjWodgfnF2oi+7Z9tffZwTOT/JgncnYtu09/pk4m8Fvy7yvKA76A
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfqgxrwa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 04:36:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6848aMxa007316
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 04:36:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 04:36:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 04:36:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 04:36:22 -0400
Received: from 10.98.41.145 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6848Zjj5026621;
	Fri, 4 Sep 2026 04:36:08 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 4 Sep 2026 16:35:26 +0800
Subject: [PATCH v5 3/4] iio: dac: ad3530r: parameterize DAC resolution
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-iio-ad5710r-upstream-v5-3-76f985b7d0ee@analog.com>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788510945; l=4356;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=hzuQ5h0FD07vRSnFP7UKTPWjz3kVmAUmeGq0sVUqxnA=;
 b=00hTDOiX3E/jBFH11/4Q3xJXJawpdBcZNOQFRnB6LJchc/RNmjDRb+8DOexM+k4my0WtjsOwl
 svqN9pBfJWIATp33IORkptEWLCZvqQOKcN4oJygKv09qTkH56foGuvz
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cKzQdFeN c=1 sm=1 tr=0 ts=6a9a8307 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=8ya4BvJESguHEMcuTIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX6bmPyoc+J52h
 kJ5eHBy0ie/NHS+AHZe5PtjEkW1BzxmGdfIuI9oR5fQvikxJy9NpwX6IPWNN4ZF51+hNS1hKCwN
 6DkqQAU4TwSq45M9bNMMgRinQ7mAD1TwCzuvP7sziVdoyBhzSz87
X-Proofpoint-ORIG-GUID: rlEHrtlmmIW1XXh_n-aZwIomFqvZRM0N
X-Proofpoint-GUID: rlEHrtlmmIW1XXh_n-aZwIomFqvZRM0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX3aG9lYfr+Tk2
 GABafzkPlol7yEwZm2jCOiKqioE29OhbMkztkA/b5Po++e+FWkT+MqT6UjpKnCy4ATR4OpwAJyj
 MIqt5yQRDNvcsMvl7U+GBwP9yeoJ676Zde2pHF6NlL9SC8xEu+H839joOY7xOYwURnnzwxAANHD
 CiJ0k98DjaQu2ML/LH1lqhHYsZONPS9Yc6XDrcNNClVYUw6+C7kyV91V2Nd7U/BB5bsXIworTSO
 MwU6OqeVQT5eq7R875x7Y0vdkae0n5USasAfsZEe9B4MDoOimtPjWm7M0h0AgWhLKhCYk4gO0pK
 iPA+8VJ2347inVz52GVASIFp5Xfsufm3R8hvSTGYsIBuAinOzGxORdha08W6vdusctN5KP4LUYy
 45RDOen5D9/34b15jBlPaggfKjbq/u24pgEsqcMoEmlmgREXKt0tY8MScVWuB0xSxCgDMO6niJc
 KfdvyNY7JGs+fxHCaEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040078

In preparation for adding the AD5710R/AD5711R, which support selectable
12-/16-bit resolution, add a per-chip resolution field and use it in the
raw read/write and scale paths instead of assuming 16 bits. Drop
AD3530R_REG_VAL_MASK and AD3530R_DAC_MAX_VAL, which hardcoded the 16-bit
width and are now unused.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 06b7f280f61b..3056593a5ca0 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -61,14 +61,12 @@
 #define AD3530R_SLD_TRIG_A			BIT(7)
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
-#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
 #define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))
 
 #define AD3530R_SW_RESET			(BIT(7) | BIT(0))
 #define AD3530R_INTERNAL_VREF_mV		2500
 #define AD3530R_LDAC_PULSE_US			100
 
-#define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
 #define AD3530R_CH_PER_REG			4
 #define AD3530R_CH_PER_BANK			8
 #define AD3531R_MAX_CHANNELS			4
@@ -99,6 +97,7 @@ struct ad3530r_chip_info {
 	unsigned int num_channels;
 	unsigned int num_banks;
 	unsigned int num_op_mode_regs;
+	unsigned int resolution;
 	bool internal_ref_support;
 };
 
@@ -310,7 +309,7 @@ static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
 	int ret;
 
 	guard(mutex)(&st->lock);
-	st->buf = cpu_to_be16(val);
+	st->buf = cpu_to_be16(val << (16 - st->chip_info->resolution));
 
 	ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
 				&st->buf, sizeof(st->buf));
@@ -340,12 +339,12 @@ static int ad3530r_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(st->buf));
+		*val = be16_to_cpu(st->buf) >> (16 - st->chip_info->resolution);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mV;
-		*val2 = 16;
+		*val2 = st->chip_info->resolution;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
@@ -361,7 +360,7 @@ static int ad3530r_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		if (val < 0 || val > AD3530R_DAC_MAX_VAL)
+		if (val < 0 || val > GENMASK(st->chip_info->resolution - 1, 0))
 			return -EINVAL;
 
 		return ad3530r_dac_write(st, chan->channel, val);
@@ -525,6 +524,7 @@ static const struct regmap_config ad3532r_regmap_config = {
 
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
+	.resolution = 16,
 	.channels = ad3530r_channels,
 	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
@@ -541,6 +541,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 
 static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
+	.resolution = 16,
 	.channels = ad3530r_channels,
 	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
@@ -557,6 +558,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 
 static const struct ad3530r_chip_info ad3531_chip = {
 	.name = "ad3531",
+	.resolution = 16,
 	.channels = ad3531r_channels,
 	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
@@ -573,6 +575,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 
 static const struct ad3530r_chip_info ad3531r_chip = {
 	.name = "ad3531r",
+	.resolution = 16,
 	.channels = ad3531r_channels,
 	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
@@ -589,6 +592,7 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 
 static const struct ad3530r_chip_info ad3532_chip = {
 	.name = "ad3532",
+	.resolution = 16,
 	.channels = ad3532r_channels,
 	.regmap_config = &ad3532r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3532r_channels),
@@ -605,6 +609,7 @@ static const struct ad3530r_chip_info ad3532_chip = {
 
 static const struct ad3530r_chip_info ad3532r_chip = {
 	.name = "ad3532r",
+	.resolution = 16,
 	.channels = ad3532r_channels,
 	.regmap_config = &ad3532r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3532r_channels),

-- 
2.34.1

