Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE443C10AB;
	Tue, 21 Jul 2026 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623680; cv=none; b=CsIZcgfa0XwzbPViHAKCF7SFSv19kWjAvXygxGdhtMnwx6z2lDq88Xjg43cXyeo0MJIvjM7/9TuAbo1+Asc8HKWCU2qlL4cYW8ht5xLilfHSit7RdIeN8bH5WA++Y0ckNSDXos9R5fmoeepL8xbTrAFP+G5Fq+kRdgyKtENWk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623680; c=relaxed/simple;
	bh=PSVXgdaCKCbSMwMAgkyPs7aaJFNx8djUNn3PeZDMQ2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y7R10MC7Kae0ycn9MLDf+vD6Nqrb584o2Vmf0u2/xs19254rLxgShqSg1iL1hBoo+R+kznARh+gOLnR0wW4j9WWwIDJGyDg7CV4fb9gkGKsUWDP5bP0ZKNfTDS8ggAuCaukK4UxT5etqW4r+hhaR5f/zjxGAJT9Dwl/8Mwz2eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1fY4c5Tr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1fY4c5Tr"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L4kCbY3311034;
	Tue, 21 Jul 2026 04:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mueth
	oLOSSXH3ZJlqMBAmZcwmLPN1O5d+Sman2BpiD4=; b=1fY4c5TrY0PVcagibA71d
	gwiyCem9NGpzpmBKyddgBE3ijFr9jFAo1OqO6TSITXzzjSqzHuNPOrMqyHTrlCNy
	yG3KxNBAav9Z0xNMRaF1awbODHEsXR5Rr6wfMWcPFZYObIew8jom9smsQbQ7FGW3
	C0Es3NVl9+qXXoajhuT8iYdNbrBEinsRzUjGFafQVbFnYqIRe0moTIuIG5jeNdf+
	a1yRp5+gEJdngFE4M74onyBGsMaWsP9EBSnOHGDetDpDlWFz+BpG0itZN7QzZU/e
	6/MKSwDOYkJUK4vVhkLjYP7BE/Q8labOl9qqzZIGR+Bm+v8fT8ckP5ZAjtWnwcIp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg3ay30ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:47:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66L8lrTS000839
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 04:47:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Jul
 2026 04:47:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Jul 2026 04:47:53 -0400
Received: from 10.33.20.150 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66L8lNHX015326;
	Tue, 21 Jul 2026 04:47:45 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 21 Jul 2026 16:47:12 +0800
Subject: [PATCH v2 3/4] iio: dac: ad3530r: parameterize DAC resolution
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-iio-ad5710r-upstream-v2-3-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784623644; l=4255;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=PSVXgdaCKCbSMwMAgkyPs7aaJFNx8djUNn3PeZDMQ2g=;
 b=vafdqJ/ySVrp76AvZExTpFjnnJcg6lNzanQRa132EPX9wzO7APw1YHPnCLrMrGYq0oU/xbJrN
 17MWtj/wyPHC6ZMQXjVPzDPVlfzDsg5SwBbYN6Xp5+dgGPRroPTd8DJ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX4fQexL7mQ2mV
 lSQUJj1aReEf1TqIFbM8J0aW7/8m5QkyA1IelITsxO7cDYccAuauYd5CWdvKGBO4BNMVfnkJVl1
 UO1AOR8fmm/vZQ9AspI9GPH1oAiJ5PaSMQFJJ+M/DW2SQcbJZZ/1sg0xPqYU7rGXpy/eqb9eNu1
 QE74bSyLKNw0fHX8JQqIfwQY91eSpON2mKXrmILXMmXBrjUUiMAcTqRVBMlAnfVk04Xg3zjkfwf
 onifUfjTPjZBFzs/6p0d24qBGJpB0UTQIV8Lz+k5X4bKXr6kNojfC79PwyhHk1zGznDbULLfLOx
 /jaRcDsQU3Ek0iBm272YQS7jGwEZPJNOul5Sxwi1GcnANclIHWB/gp5rljYGOdDBJ/MQDZsR2wj
 eaAvkbhucZW8DBo+7SpazzsLPJlJKPvNub+U+FqSDtuzIHVY+SyOE4fROkMvHIgZZ58iTzWOcGv
 oZr1D1Zgp8My4OnelQQ==
X-Authority-Analysis: v=2.4 cv=evjvCIpX c=1 sm=1 tr=0 ts=6a5f323a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=2yRuljZf9PWinY4dLS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -keWj8oZxk_kPQ7m8OIiloYwEtwHVSLq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfXzops7XGdJ62q
 /3maNdolKu04ZO+jprhKvsDiqZup/stevv2y7GNwRkeqwg4lKMaF83X3ueN2SCUWie0Alb6HBUE
 B5sDvp3bwd9863ix8QNaIVA4jQYZmbYla9QSQVJoxzEi5FK7C80d
X-Proofpoint-ORIG-GUID: -keWj8oZxk_kPQ7m8OIiloYwEtwHVSLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210092

Add a per-chip resolution field and use it in the raw read/write and
scale paths instead of assuming 16 bits. Drop AD3530R_REG_VAL_MASK and
AD3530R_DAC_MAX_VAL, which hardcoded the 16-bit width and are now
unused.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 06b7f280f61b..97483534f8c3 100644
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
+		if (val < 0 || val > (1 << st->chip_info->resolution) - 1)
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

