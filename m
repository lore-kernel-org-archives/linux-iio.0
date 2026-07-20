Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548623B19D2;
	Mon, 20 Jul 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554906; cv=none; b=B7BwvOKLaEsVriWIlR4iz5Yi/e3Db5+3Am1HaMbrUXQ0enZCAvYz5RVtvMZMF6ZsR9K+IpqEoJZeFAKUXIWJvfsAbz8B1bAn1RCUFaikZeWtbt0770ZH+xDF+7wYbIaE8jMaJL0IVO6cq4a4mv0C8H7Js2JwmPBff+WvJf4peL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554906; c=relaxed/simple;
	bh=YWDuYE54FGMsRToAlYEQvAf/PRNs0E0iaK3Ivu5r/7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM6MZ4K4rF5fxhZCqTjTx5+A7NpIgeVynD21rQ4O4i7NkDMhJE+4H0LTqqH45JwYj8ooC58KudfLmXpH97VRG6yB0mGA/YrWAUuQF0sXB1QZXId27hrYW6XunYyMiOzNX+ik1m5G7/8ruAlVetIlb9zzvK0rA+HlxQMr/MLXGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yYPPcdrX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yYPPcdrX"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAxvZD1779223;
	Mon, 20 Jul 2026 09:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r0M4L
	t3Og67u8a6/glhhCFyO3tiUgJztE26FW3uJCCI=; b=yYPPcdrXbKc6btoHvl0nO
	n5zRayR4lC8yOSHvFq63k1I4esy8kBLe2WDc/gU/9n7eJ/T9ThCDzY0wPcwTeYud
	O3YTvtxNGfWZuk4Uxr0t5XarkI3vgDWF2xl0aZb+L7LTljIeutkX+RgWfw4rZ+Bp
	+j6uTz7od9Kfb60vvTOwtEOMmt2m9WNER/cV+AHzVDGrIk43KjG4+QqgQF5Gz/mp
	VPDN5+Jkrw0XfJ1iIcgVpbxA0CAv7UWK1q1vwbImeG+UHHvaOsg74WKdUo5UlOeg
	4WonKzfilen5o2d+NDP8SRPbzs8OSH2YWgzycHdJYWNgC/6eoChS0A9h/M+cdMhs
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fgttgc8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:41:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KDfMut011959
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 09:41:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Jul 2026 09:41:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Jul 2026 09:41:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 09:41:21 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KDf5qI018405;
	Mon, 20 Jul 2026 09:41:13 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: ad4080: add support for AD4883
Date: Mon, 20 Jul 2026 16:37:07 +0300
Message-ID: <20260720133707.103366-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720133707.103366-1-antoniu.miclaus@analog.com>
References: <20260720133707.103366-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9ZqPWoXN_jdGIeXkXlI7A_KJtYnp0ZU9
X-Authority-Analysis: v=2.4 cv=DagnbPtW c=1 sm=1 tr=0 ts=6a5e2583 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=fZBKQp7KzR-Evd9DNVIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfX/mT3dH5huOZY
 ZLxHOXZgDIclIACCyuo0WJvcPKG16+D3+3vPHqLNunBKrFHUftq5TUxMYFTS7/YwcJittp1Yd8M
 BhOGstv1kruFothpp2QhqsNzohuDpMawcdUpwC4OlqyUkUS8uBgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfX2FF3m5i/koQ7
 y4rvyc+c4lwK22TzJGAKPgAUFsRD7ejzAAlWntMT3sTMg8qJytDke2xU4ltfcu7Tde+JUFkhp8L
 3ftVok0/lCfyVEXipuFs/B+X7KTWkRwCaCsYwBJke+5S7ei02rLcdtQ9yWl45EbABTxihV3DqmZ
 w4eOyx2yPWfEWvN8hLZh7EdH0Mez4fpaUAfS3SQyUUFvjQ4y5lxqj/msnlwOoqNnEhfFoiusM0W
 6AvuJBXh//LPRPlgpZeFfbyh7Am0pnC9Gg39kpmgAZ4HOhbMAa0yVov8k5kRUbJeuHzh9CxdbvV
 iKcj3BVIZTIqrh6OnKrsc8/rlUEVrU8WacEXlPSHMA9OEMDMMS+mHtAdie5z9yN0FWtP9BKx8C1
 oSBz4AJY9XI9vZvoQN6D8m7RITHaFZYr2z1+i17x7zA+T5fhEqtr5enUgNlMFsPwKW/ESux4Dw5
 pcR29bJlyRyM3d+P7Hg==
X-Proofpoint-GUID: 9ZqPWoXN_jdGIeXkXlI7A_KJtYnp0ZU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200152

Add support for the AD4883, a dual-channel, 16-bit, 40 MSPS SAR ADC.

The AD4883 is the dual-channel variant of the AD4083, sharing the same
register map and SPI interface as the rest of the AD4080 family. Like
the AD4880, it uses two independent ADC channels, each with its own SPI
configuration interface.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index c7ecf6971be4..543728c7e88c 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -135,6 +135,7 @@
 #define AD4087_CHIP_ID						0x0057
 #define AD4088_CHIP_ID						0x0058
 #define AD4880_CHIP_ID						0x0059
+#define AD4883_CHIP_ID						0x005B
 #define AD4884_CHIP_ID						0x005C
 
 #define AD4080_MAX_CHANNELS					2
@@ -541,6 +542,11 @@ static const struct iio_chan_spec ad4880_channels[] = {
 	AD4880_CHANNEL_DEFINE(20, 32, 1),
 };
 
+static const struct iio_chan_spec ad4883_channels[] = {
+	AD4880_CHANNEL_DEFINE(16, 16, 0),
+	AD4880_CHANNEL_DEFINE(16, 16, 1),
+};
+
 static const struct iio_chan_spec ad4884_channels[] = {
 	AD4880_CHANNEL_DEFINE(16, 16, 0),
 	AD4880_CHANNEL_DEFINE(16, 16, 1),
@@ -646,6 +652,16 @@ static const struct ad4080_chip_info ad4880_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4883_chip_info = {
+	.name = "ad4883",
+	.product_id = AD4883_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 2,
+	.channels = ad4883_channels,
+	.lvds_cnv_clk_cnt_max = 5,
+};
+
 static const struct ad4080_chip_info ad4884_chip_info = {
 	.name = "ad4884",
 	.product_id = AD4884_CHIP_ID,
@@ -858,6 +874,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ .name = "ad4087", .driver_data = (kernel_ulong_t)&ad4087_chip_info },
 	{ .name = "ad4088", .driver_data = (kernel_ulong_t)&ad4088_chip_info },
 	{ .name = "ad4880", .driver_data = (kernel_ulong_t)&ad4880_chip_info },
+	{ .name = "ad4883", .driver_data = (kernel_ulong_t)&ad4883_chip_info },
 	{ .name = "ad4884", .driver_data = (kernel_ulong_t)&ad4884_chip_info },
 	{ }
 };
@@ -874,6 +891,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
 	{ .compatible = "adi,ad4088", &ad4088_chip_info },
 	{ .compatible = "adi,ad4880", &ad4880_chip_info },
+	{ .compatible = "adi,ad4883", &ad4883_chip_info },
 	{ .compatible = "adi,ad4884", &ad4884_chip_info },
 	{ }
 };
-- 
2.43.0

