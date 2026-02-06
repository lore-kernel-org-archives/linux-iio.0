Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95253D331B;
	Fri,  6 Feb 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383384; cv=none; b=ZgZvG5az9uPvVfg4SDcDxmj/KI48r2yzx6Ppqge6ZwNZfCQZEmLX5qINUeN3XsV8kpXTkkjGKlqVlw2EDLK1inj5dMtfVhPdS7R61j7tikw2YsmXrS2OpG91+IqJsti9Z14a6CQ4LW6TYkMNazhzkTkcHgyzebxZ45hYl2ktgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383384; c=relaxed/simple;
	bh=42906T8zLMVlbdLhTDT0E9VfiS3XhtgUqW3Hd0eLR9k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL9bcAwOjtgZK+DO05JUl/evTpfbrmTPvYV9fxlftvMkyjIN8UvmZFqMa1Zp81u20tAomvlYf4Hjyt816MAOitikavyUJpOamDeO63tNm6MSxyJQg35BMPn3Hgmo2m7bGmna3W/CmYgGvQjIsG1GPbI5UDFztdD07b5w4FAD4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j4oQE+qC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j4oQE+qC"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6166dnmt2060017;
	Fri, 6 Feb 2026 08:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TJSow
	1/IHOxMrG2kDTZrbDAoa570wQmihdl8tMSaxek=; b=j4oQE+qCySY66n7607gi/
	/3VxiHSltL9dcDjxwlyyZEg1Td0dBaAm1hBJI9JSOpCpuFrq3mJuD3rxCvnBbkq/
	vZfI+08vU3VZLf5vbMF62WBoWSVDiqyIfqcShS8IEpGYSLsITJlZc8ipMp58nOaI
	RrJeKWJyefsq+R+aAuAtxV/e41BiijGw02zU63SlFKlNvlxsJ+m9iigLqW1yLCR+
	WfSELIXw88t3U6XfRsqyKiUIox8t889Eezq0u+MyWtrsw14ntAS5bZL22l2fJGe+
	D2xLES9R7Hs1sj4Ow9+l2CJJU340XFP0U2F4DXeubkf5gjXgFMFomt03+bFwbwKT
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4ygqut9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:25 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9Ofe038234
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:24 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JL024213;
	Fri, 6 Feb 2026 08:09:17 -0500
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
Subject: [PATCH 4/6] iio: adc: ad4080: add support for AD4085
Date: Fri, 6 Feb 2026 15:08:23 +0200
Message-ID: <587dbc9c21b49c7d99b6b5b8dad419fad415e040.1770382796.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: CSZe6ieBTcBrDEKLxCbsGunIqzlak4sH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfXwTjq1SVYQtYp
 5z6OFQ37ZT6qqvDkMu9Mvp3sbg9HzULkbKIpwSFUdGqoxuafhWKTLBNUdQ+FMnmK8GZ/2X3eErL
 +AqufJ7TuTX7l17fNZECMwb1L7HUeMYYiJ5CROH150jXmxXl1kCcE3KWxH/UqUoRa6XqMK+rYUa
 93sdmyZTAV/9P8VhGnGMf9S9kM6CzP4eHkNtPzroFUVcBP7FFWqDVyQJCsI461H7mQzIE4WmCYx
 Ni9A6CpbTGzPnz/8JSlRvbqzGUt2M1T9OKG15CQEodSr9aTXBb+1o2RRZFd9O9RSqbA6IU+tdP2
 RViE6ki2yoVJQJ/88YqN0umkzBgUbdit12WnMDRCbMGwXfomZdf5gtX0F4wuRjVyt6aJNTyTW4T
 XUHXWhPkpf44kYBrjmoMubjp3+VFQoI48vEgYrP2ElDOnL0UJEtdftMdhH6HBvI/r4rwjP+SfZp
 SGvRygh/U5YC+pSzsRw==
X-Proofpoint-ORIG-GUID: CSZe6ieBTcBrDEKLxCbsGunIqzlak4sH
X-Authority-Analysis: v=2.4 cv=CLUnnBrD c=1 sm=1 tr=0 ts=6985e805 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=ngMnFeWuTyqPK_3jndAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060093

Add support for AD4085 16-bit SAR ADC. The AD4085 has the same
resolution as AD4084 (16-bit) but differs in LVDS CNV clock count
maximum (8 vs 2).

Changes:
- Add AD4085_CHIP_ID definition (0x0055)
- Create ad4085_channel with 16-bit resolution and 16-bit storage
- Add ad4085_chip_info with lvds_cnv_clk_cnt_max = 8
- Register AD4085 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

