Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB83B05A6;
	Mon, 17 Aug 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948686; cv=none; b=JSrXkU2Z8XgXkvnVd69IK1/d+ENiFYTwnwPL4X7Msh+RdEZlIMTiQ3g8S5WEXMcCh/tOic1b5yVX3CNyHnGQRrxzEktspZbgdRt4O1bNYc1KGwo6G1NAX7SzSgMRjKebgnvxm5eG34aWLynPR8i65Mzlbs1Y1K7WLuIHVsHV4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948686; c=relaxed/simple;
	bh=D6xe5PGJXJviyFDODb/53oKeufgYrheYMmjBzSKgOsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z4mcTOX0e2Q4k2ccskTPhZBqM64PWQzVQPnINQjBGXvGPa+QkS/Dprsh2yZgTSOn6tMDQ9bxSxLZN9QyvvzwF0nc09dvvKey2l61ce0wGFTZ80NzWOG3NL9+JAts1DLhmsNSjznxw8oJWG0aFkNIhRqA3uJ4nxt6R/cVZR9yrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VRRBY4CW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VRRBY4CW"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H6CxEs2809436;
	Mon, 17 Aug 2026 02:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V4gyy
	8SqN5WJXNp9LKY8KFw2xD1v8zAlZguPXOBFzL8=; b=VRRBY4CWRrJncwLutQ5WN
	VszCQABjuVOsDa8Z7bCN+6G/SAsikVGd2iVN3x9OG+SNfpqCDoiIcwvt+bDgOep2
	80VuiH40kJhVaHcs+MasY9OS/h6TLo6HG9fS4dVLWZUvYzoPXdC62xuG5MTB/72z
	756YKesVHHlmJJ/XoC4W2DzKzqTm+b/c5e9AyiJaamg3kLwsCNmhLDfrNNjeDUfT
	0zGslXsx/okHTc0iqveLFbHPA9lQoOGx3HHY7KHBghrTkhLDX5uToLMVw80oNiud
	CI7sAEPzewyZ0VCWEpgiAGakHi8ZeB5AhI/c2qMs/BLNw6cl3mjiffzvqK6n0Yk7
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g39efkcp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 02:37:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67H6bwoc012533
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 02:37:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 17 Aug
 2026 02:37:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 02:37:58 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67H6bW5R022522;
	Mon, 17 Aug 2026 02:37:51 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 17 Aug 2026 14:37:13 +0800
Subject: [PATCH v3 3/4] iio: dac: ad3530r: parameterize DAC resolution
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260817-iio-ad5710r-upstream-v3-3-3a4bf7b9c78b@analog.com>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786948652; l=4395;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=D6xe5PGJXJviyFDODb/53oKeufgYrheYMmjBzSKgOsc=;
 b=Fv7CutOcCVO71FskklM6rhf247W6eM3NWMiUkhgpU4HxOvFloGCeAroVcj2GzXsLErB1IWFIA
 6ZrCxgc/5vvCX8dNjYesPxuCu8u6TRf9EBSlDPp+8Cvb2yzc3Ulk6O+
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: l5Uz-QvrXDWH3X2CxSP4b5bIuAGLkupE
X-Proofpoint-ORIG-GUID: l5Uz-QvrXDWH3X2CxSP4b5bIuAGLkupE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX8hXJzEZSjufD
 6X/QEUvQVzzuKjWhwJI9yitp/a9+BTRWD3HiomYuIXNO2V09v8fg0FL2bVvpbG7sjMbnklP4q21
 aA/YT6WflhbPqWHuOt+FKoAbof9SLD8kOWciYTXUfSINHOjKuZh1
X-Authority-Analysis: v=2.4 cv=VM/tWdPX c=1 sm=1 tr=0 ts=6a82ac47 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=8ya4BvJESguHEMcuTIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX+GcExu+zshZj
 RzWM2L3sdZ67Fn822bqEQMPLeJglsG+Xz19i8VF+Q5RzztgsvboOIoMNj8i4+l8/Fb+yVbj4LXl
 Q7d+cJHBMk3JTiEY5m+yJDJtoqUgeYDQaB+Ru76GyAK6ihgdMedWMn69ci0ck7VDxFD6ICrkI07
 KUjBVwxtql8jP2tLmPX08RlXUtEgXOAelh/uKuM97mFg+eDJQTENAuBHH+PymEsZQTqAHddTlqK
 UzoAcLggEBuJgWFSENPseQ+ksASXZwT1BDowlydXi0Q2/lqGNV+SPX6ZPJuIGHHmc6RgD1wg+47
 jXLfUB4tS0EhiHJkKXX4Tj3J+KcRrmDwuZaJJRzXxK1xJ+IbNPZoRfvl8DhMkK1t5V9X3g9CUKC
 JD9kAz0wJxzkBRfdpjeTxVW5sI+wqJxTX5FJZ69YZ1Buc6L54CW6YaWpNHwAAdg+XAarKlrWKDx
 HomPLR9MalskPP4OVbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170047

In preparation for adding the AD5710R/AD5711R, which support selectable
12-/16-bit resolution, add a per-chip resolution field and use it in the
raw read/write and scale paths instead of assuming 16 bits. Drop
AD3530R_REG_VAL_MASK and AD3530R_DAC_MAX_VAL, which hardcoded the 16-bit
width and are now unused.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
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

