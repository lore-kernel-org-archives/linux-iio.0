Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5113D330D;
	Fri,  6 Feb 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383386; cv=none; b=MnJ/952AOCcUFlvFUPlHoFKtov/Sj933fGU9KW9AvqgG0a9wrdou4/+9BDj4nymUQfCxtSvkQLZRk/pR0P5fyQXCJ2jsNAFalhAk268Lr+m8nFG4nl1zSDI7Q9h0ZHvykCw+E6XAK2gCrkiygCYP58BtwC3BBuypKPjuTwL/WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383386; c=relaxed/simple;
	bh=ow4pbxfi/BRy1+mZj4V0183iAoywUDolbQYdATXlG/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYX4inuVDJvXGGlrZr0ENeyl1m2usW7xdj6wykNgudBn536TzPQWDjeuZblSa6AeuLr9+1KigsJF5jU022vPWub7YXWlHxyd1lrQGrR7LaRsHhc6230NjWBDw+NwfGwpWkrI4BcWUxnUiYnrdDjVOhbcVvdtR60FUgKAmiSIKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z/MYmMbp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z/MYmMbp"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616AIhA02328489;
	Fri, 6 Feb 2026 08:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PhARH
	btKCbxf1PfPXrlLTOrmEIujQlq1pjuYuxiNEC8=; b=z/MYmMbpeTPLsidL9x1up
	vd9b1jcPXgRCBQNlrKscujowiJkliZmPgbv3nA/WcF5p670XKNR7xu2ITw5OaHBs
	p9V1iWcKMHXXvE5cisNS8p1UMsVDEQACdskERID4Qm19Jdt3OhGxWXZ8E8J/LaFZ
	mmR79fZ84bP1+UXY5OSc8uIOSF+JJd4FsTrzw7CR5B1A/jOsRuiBaJpu6ClVZcA9
	nvlRUCBP28Lh75vHHBzJujnwkSqv0So1M5TowT9lXFt6gqgoPf1LXQdSGZeTcTyb
	sxlmQ2ReHoxtqItFfCBLdsySPtj6r1Xl083+vXJtmVol/X/A9M4RcR13zT/nZO0+
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c58721sg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9JD4038219
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:19 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:19 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JJ024213;
	Fri, 6 Feb 2026 08:09:13 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] iio: adc: ad4080: add support for AD4082
Date: Fri, 6 Feb 2026 15:08:21 +0200
Message-ID: <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: HbjnBVgcNEb3RmhcFbGs8gnRzx008mqy
X-Proofpoint-GUID: HbjnBVgcNEb3RmhcFbGs8gnRzx008mqy
X-Authority-Analysis: v=2.4 cv=eqzSD4pX c=1 sm=1 tr=0 ts=6985e800 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=WE_zQvbRmN3YjbOaRLcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfX5sYnNy0N4ADM
 vR5qdj/BWSCu+3nughv54yq4m82gdpkd16meFLldrjS+k/j0SfSMNkjhtjif/Fn9v9fqeItYCYi
 TvKWio7oo3yHcWIeMtK0+2Lis2Ry5e6ptKRAkD65Di3dkZ4YlHJ1yL0mwdqL9o5VIXS7uxennYw
 s2+k8LKpgT0BKylKEXFjrWWM734WfWoGOZh6X6bcjHhVfueDkSZ4TnKf8UkaWFUctkz1+zlSxpn
 E7MGAUkY+LvC8WCvvbvdNvZ6y4dI28qMMIVCEGRRhQoLufIWeSN6ixHc8dtR1vTebxstuyD7wFo
 upEFvJsKAHyD/1G8De7rLjZJLAPccX7xbYVUOnwxlA/lOWHVr9wRI7XjYDMaFCNBPsz/Bfuy9GB
 q2fE2oVLr3zeEa38R4gIEib1Jw7yEBglTKJSK7TT96IzbclO9WwUjoPEnODYM66/glX4uaU8CD8
 9Bz02qcfea6PCAIHUkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060093

Add support for AD4082 20-bit SAR ADC. The AD4082 has the same
resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
maximum (8 vs 7).

Changes:
- Add AD4082_CHIP_ID definition (0x0052)
- Create ad4082_channel with 20-bit resolution and 32-bit storage
- Add ad4082_chip_info with lvds_cnv_clk_cnt_max = 8
- Register AD4082 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..7cbbe284dea7 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -127,6 +127,7 @@
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
 #define AD4081_CHIP_ID						0x0051
+#define AD4082_CHIP_ID						0x0052
 #define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
 #define AD4086_CHIP_ID						0x0056
@@ -442,6 +443,8 @@ static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32)
 
 static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4082_channel = AD4080_CHANNEL_DEFINE(20, 32);
+
 static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
@@ -470,6 +473,16 @@ static const struct ad4080_chip_info ad4081_chip_info = {
 	.lvds_cnv_clk_cnt_max = 2,
 };
 
+static const struct ad4080_chip_info ad4082_chip_info = {
+	.name = "ad4082",
+	.product_id = AD4082_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4082_channel,
+	.lvds_cnv_clk_cnt_max = 8,
+};
+
 static const struct ad4080_chip_info ad4083_chip_info = {
 	.name = "ad4083",
 	.product_id = AD4083_CHIP_ID,
@@ -666,6 +679,7 @@ static int ad4080_probe(struct spi_device *spi)
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
 	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
+	{ "ad4082", (kernel_ulong_t)&ad4082_chip_info },
 	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
@@ -677,6 +691,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
 	{ .compatible = "adi,ad4081", &ad4081_chip_info },
+	{ .compatible = "adi,ad4082", &ad4082_chip_info },
 	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
-- 
2.43.0

