Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFA3E928F;
	Fri, 29 May 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064086; cv=none; b=oxR7J4RkUVuv9E9RLSx1qCa2GFNGlwIJ021ioIuIyYgLgctH3aS5ea6aPijZERc920opOsdYu5EY0WxR8V4Rf1NtDNfjy1C4Y9kTmJjiwNF0KxyWuc6oRi0qxvhUawH9/OGHslb+PnPX+rEhroyw+esnbPTf90LnPr8UL2ghuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064086; c=relaxed/simple;
	bh=6gvX1uTfgrG8xdGDGLmFAGlRteMrmf/gAYpKDynJ+Wc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szmKIXjNNkyejqg8WGFi+lKcxIi4icoGGi8mE7fg7rIHzWy2ugDnvdawoNhy4OGCFtBncdPk/96OkoUT+67jIklpOkxFk6IjUEz6yxY8s6PNiutPyKQ1w67wiWYLhs7HoJXpfw7IclCS6a/oURd4BKSVbRcpqmD59ExnkVyDqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Of9G2GHw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Of9G2GHw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T9eD8A3917099;
	Fri, 29 May 2026 10:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V3RT5
	1x504HoZ9tZEtCfL0GJ3jY8Y3A4vH40palxk3Q=; b=Of9G2GHwEI+nhYqJkcLvT
	o/1pmbscMemWlDYzn4BDMVVGwIYioZOELKKJp23MbqldxdRAg6Fp3e1twTFxVDgo
	rsiFXgU6ql/EarqPUBufqev5znQnwPd682uqp/6jBYprYAcjz0zaUTZf/bSAsEkL
	GYjJeZb3Nk3kEME4wtesqgBO1hhY16AToF6HDnpxDu0H+5kao9HO3QrbGrL9Yms6
	TUJp1sK7FY5bkh4FFzbb8K7PbAYSC9PLP79xyLTjvV7MTbf3oD5YBmoP+4tHvePP
	CZMxdqB4c8EkfCxiGgLaJafvfCyvvdVCcud6eDzzC0T9VJt1qHj3bYKoo8DlHGPJ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7xdqks5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:14:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64TEEaIf012824
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 May 2026 10:14:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 29 May
 2026 10:14:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 29 May 2026 10:14:36 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64TEE8Mc020671;
	Fri, 29 May 2026 10:14:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ad4080: add support for AD4884
Date: Fri, 29 May 2026 17:13:53 +0300
Message-ID: <20260529141353.8492-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529141353.8492-1-antoniu.miclaus@analog.com>
References: <20260529141353.8492-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=VMPtWdPX c=1 sm=1 tr=0 ts=6a199f4d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=9vqVBmU5rEgUO8YIPbMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0MiBTYWx0ZWRfXzFh3qNKAzadI
 uYKaC5F8GI3x5njHdQ9mvY6K6TqHZE+En//wI5i8Bun8Y79sd8Nu3qDveY5WQVnfKDMkoN0EMgN
 AOLrtGuX3kELs8SJTsSDgOmMh6gpNiNysR8dhlXx6e/wNk02t4eqkbsssK/MJLnL8O3rpSM3k0h
 mFWJnFvXSz81jYQlbuG/qOsu9eKWtZlFEDXgfGmtx0TLkwDJss2cizNiKRgT355jlyrHhqjIx2h
 KnrfUxwMsdADkIrCaMFa6iFrQ6XUb9zZUONz3N6aTBQzwa/jdODXGrnU8esRSvVVR/A9BXoD9cb
 fNivvc0gLtJfdyanoP8lkNPW2oyPN+3ZpXzt146GgqsuYR95B+YyaJHziMieJxotsd81yGwMbn1
 OUeLloJqMlHup9NUHhWDVwzS3u1yWttHJUtHlYDRg4MWOd8xnQInRjqpYvbeZhI9Z0yYba744GA
 KNAY/5QFXy4xMiMCbfg==
X-Proofpoint-GUID: QBixx0662-i8dPPz88pvDkpeZ8nVyZI2
X-Proofpoint-ORIG-GUID: QBixx0662-i8dPPz88pvDkpeZ8nVyZI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290142

Add support for the AD4884, a dual-channel, 16-bit, 40 MSPS SAR ADC.

The AD4884 is the dual-channel variant of the AD4084, sharing the same
register map and SPI interface as the rest of the AD4080 family. Like
the AD4880, it uses two independent ADC channels, each with its own SPI
configuration interface.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- No changes.

 drivers/iio/adc/ad4080.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 265d85ac171a..764d49eca9e0 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -136,6 +136,7 @@
 #define AD4087_CHIP_ID						0x0057
 #define AD4088_CHIP_ID						0x0058
 #define AD4880_CHIP_ID						0x0750
+#define AD4884_CHIP_ID						0x005C
 
 #define AD4080_MAX_CHANNELS					2
 
@@ -541,6 +542,11 @@ static const struct iio_chan_spec ad4880_channels[] = {
 	AD4880_CHANNEL_DEFINE(20, 32, 1),
 };
 
+static const struct iio_chan_spec ad4884_channels[] = {
+	AD4880_CHANNEL_DEFINE(16, 16, 0),
+	AD4880_CHANNEL_DEFINE(16, 16, 1),
+};
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -641,6 +647,16 @@ static const struct ad4080_chip_info ad4880_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4884_chip_info = {
+	.name = "ad4884",
+	.product_id = AD4884_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 2,
+	.channels = ad4884_channels,
+	.lvds_cnv_clk_cnt_max = 2,
+};
+
 static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 {
 	struct device *dev = regmap_get_device(st->regmap[ch]);
@@ -843,6 +859,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
 	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
 	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
+	{ "ad4884", (kernel_ulong_t)&ad4884_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -858,6 +875,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
 	{ .compatible = "adi,ad4088", &ad4088_chip_info },
 	{ .compatible = "adi,ad4880", &ad4880_chip_info },
+	{ .compatible = "adi,ad4884", &ad4884_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

