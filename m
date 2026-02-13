Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9C36215A;
	Fri, 13 Feb 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994053; cv=none; b=uxG0sErpSjdLRuKOepLTe7/lmNeIF8AL7gyQ6j8mxEz4OCNMTkD8smCzeC70q8ZmxSA721AyF32FPz+Xc669x8WtXlYofDVQ9NMeTjMR5cAFGDyvwbpb3sMB30sI9j9Yyb4aQ28hvZdSDlo+HkjyIzPsq2emMLvwy7iRGXWk/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994053; c=relaxed/simple;
	bh=z5XD9W6OBuIlzH8X+fZOYSdu6sLWEWmrELMpZEc8MsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9qxaU1ABJ91+cctig2yRhwc4TrEI09is7YyP8gsQziUdlRA5zorXSqgYKlRQyKDRwt7tSAo9L4TWkjE5lJV16bFPpcyr8uiQmYwQqZALUGayqQkZ7G9E1ACKxagTAzWXmhGWpTW5D0Umz6GykqEbYIvY7YjqpQnarHS27de5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UBghRdLF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UBghRdLF"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEEkEm1628217;
	Fri, 13 Feb 2026 09:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TSiyC
	OcqClUqPXsdDBxngEV2aM6GKDy4hzdBsH6alyY=; b=UBghRdLFBe1uiKC6hJSNE
	0RQlHGk03d0O54JX+uv1IrkaADhlHUOFoEm9h8aAAs2aOS+2Hu33Kg/8NCCrlNes
	91dkjqs4CO4iaBwO8AZnnnkczp1cvY8PNLiLX5+POC3BCZzGUJjEJ86fS3i2E+0p
	2xF2tK9Kg0TcBuHnrhmB0BReqlv4pdk7y4uQfp/EK4vPsfKet2UEG3qjCFuDoNPJ
	MRKftPWdH0QOLcPCc20I0uhLOog0EtFHwrO+77c5aAHzS2g829KMMAffl14m2QxK
	/RwRGw2i5v0vAUx6TnVv9S9XVAUIu6RKvKMrCQDKiGAws06Bk7EfyiaOtyzab1aD
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ca5j50400-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DElGGY041327
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Feb
 2026 09:47:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:16 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH3018425;
	Fri, 13 Feb 2026 09:47:10 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 4/6] iio: adc: ad4080: add support for AD4085
Date: Fri, 13 Feb 2026 16:46:25 +0200
Message-ID: <20260213144629.16001-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144629.16001-1-antoniu.miclaus@analog.com>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXyCMro1Im0A2M
 xvw5IOTQBemH3M52CgGAQThnYi+vt1WZrcy1LoUFiZ7Gp/9dmEsZIXamusDHuOFqui8AgssHKAO
 Tv+ziiJ3n3wO1Y8A7vaDRCASTqd+Kx/ckh2i0ijpFXIAdQ3XadX6BR9DRDPxzyPEV3cdFPh9tp8
 xoitPhdTl5bn7u46u25ZUK6EWVe5FK2gsUR5gJAkt70LVawR2hUi/k4cmVicgxpaoGoII2FtpNi
 LmJc+UXpsXCvLcDMPdU+CrVANN99g5sTepG4qnNwnPCaCu3C1eQsn1ay7Q4aH7T/fcYMBgwFwYj
 KlDQj7f/+davrqe4q/lpsm8JmBqwfHiufRrW482TNB7vrfvn1/fkY6ynIQ5Wpt1eeAQWMax2N0P
 R50nLgBXXHBwPzuJxx6gt2tTWIkaB9vwSbtS9t3fGGsGp4WuB8I1A2MXNVfDMPdOo83mwb7S1+o
 Fdel4pekcaGhPoYaG7g==
X-Proofpoint-GUID: wv45j9oY8DJ9PCyjzZi8qIdNv4gIfJ5I
X-Proofpoint-ORIG-GUID: wv45j9oY8DJ9PCyjzZi8qIdNv4gIfJ5I
X-Authority-Analysis: v=2.4 cv=CPsnnBrD c=1 sm=1 tr=0 ts=698f3975 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=Aj2ksenJpUlf0aDQ7hgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130114

Add support for AD4085 16-bit SAR ADC. The AD4085 has the same
resolution as AD4084 (16-bit) but differs in LVDS CNV clock count
maximum (8 vs 2).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Dropped redundant Changes section from commit body.

 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cbbe284dea7..728df626f09e 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -130,6 +130,7 @@
 #define AD4082_CHIP_ID						0x0052
 #define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
+#define AD4085_CHIP_ID						0x0055
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
 
@@ -449,6 +450,8 @@ static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16)
 
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
+static const struct iio_chan_spec ad4085_channel = AD4080_CHANNEL_DEFINE(16, 16);
+
 static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
 static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
@@ -503,6 +506,16 @@ static const struct ad4080_chip_info ad4084_chip_info = {
 	.lvds_cnv_clk_cnt_max = 2,
 };
 
+static const struct ad4080_chip_info ad4085_chip_info = {
+	.name = "ad4085",
+	.product_id = AD4085_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4085_channel,
+	.lvds_cnv_clk_cnt_max = 8,
+};
+
 static const struct ad4080_chip_info ad4086_chip_info = {
 	.name = "ad4086",
 	.product_id = AD4086_CHIP_ID,
@@ -682,6 +695,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4082", (kernel_ulong_t)&ad4082_chip_info },
 	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
+	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
 	{ }
@@ -694,6 +708,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4082", &ad4082_chip_info },
 	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
+	{ .compatible = "adi,ad4085", &ad4085_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
 	{ }
-- 
2.43.0

