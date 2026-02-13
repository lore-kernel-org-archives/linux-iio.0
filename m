Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB33644A2;
	Fri, 13 Feb 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994061; cv=none; b=Y6119WFieMXthYGqya6NoQGkOD2r5JVIpYTogDHdo4JMhCXzHyci27O8RGssK0SQxQT2sX415xiH9L9n9/KsyMqG1l+1/3GsHp9FzyvAKEcwyphtmX757NUFQFXRV1LGbTxO9A8JpGfhmvjMncWykdo8vh6K+nzTu4ezuUVmDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994061; c=relaxed/simple;
	bh=f3zEzR++i3/yYZOeOlRpnidcO9AsYOL5GkKJAxsjC+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8o2Sgm1sR/h2oao1qg3TOfddOK5reBfMzf86ctthmVUoJ1LfGGnTEh8stcoP/gBVjO2WV/rPuy7BLQzrbPZv+WsrgeyC0L/Y/XjZ7zz15F2h5ipybe2KfcyPr4QbegKtt1n8B/PISkInu0BQJC6OiqZutwPWtjrWbhVp98e1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GpgWxh43; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GpgWxh43"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DE30LP1725303;
	Fri, 13 Feb 2026 09:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZnptR
	oCwiLmZdxA588qV4GoBLf7v+XQG3dmkn4eJdeU=; b=GpgWxh43zhPvF1iVvz3+4
	INOSk5o/Bnq5iKw1tS6sTYxeUDVXciWKf9KYLHLajzBdnPTun3FInwwCqdw5SU5y
	4ysZfACmJnrTY5q+ObPmF0MGd47XyCfK92LPpESbqGtgebvUtrTY/c2w/YoUGTvC
	7dDZRK8t8e99hBm4ytw6WZ4eSIM+h30ZZ6xfykyevdOYF/tnKXqqMfIymbXinHuN
	fiBmhlZtFiIMo/YTLH/wKLY+JZirzvV+QnsD0QFy4B/36a0xCmPWr5Xxze027yIm
	88qyHRSzaMyU0gzqRUg9PVKpBj5njpp9WUW6KalrGP2+8ZN9rm1fx2eKsPTKLGWR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c9yst1e29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DElODF041334
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:23 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH5018425;
	Fri, 13 Feb 2026 09:47:15 -0500
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
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 6/6] iio: adc: ad4080: add support for AD4088
Date: Fri, 13 Feb 2026 16:46:27 +0200
Message-ID: <20260213144629.16001-7-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfX/dXqL6HMIKKc
 eYTUQmzrpWHCed4/8CmWnzOXD4rhybFA6HempgfUhZn6mmf+2JGVU/0LGE8LSED0sHomCqSAk5C
 lPvnvy+s6/HwgXUYPPCagmN0Ih02xiuK/IKzZnX/CwHTPQAUcFN2P3fRwdwNBomLA650wY3KPqa
 DLvt9xQhpCrwPYfwNHmD7z+QV3vJCiN/9hzdaf8u0jGX8O5L8AMGjfJ76mHlF6UtgKNmUJn3CD/
 isoOaP4mUP1GjWvNY24TkRf/sJVwy53+u/LwJD5zKWKWq85vmKRcXP11t6LNY5/y7gIwRy/i3Kp
 nSfo4OsZLG92hyOPDL70id0ERbFZYhQfVX4ZE0Dgn8FU9gL/ZtiqcSYRkD54usdcMSV3TaqC+iI
 +Q0ceKG15irAyzWPtk0+HGyZ9ZUuhZkk58tPKPCgTbIQvdOr9gbqlRGloIHaDhdAzAzupvqTslE
 BHfHU3TJPdmw6Inpp7A==
X-Proofpoint-GUID: WZ-7kkrqf6pWGrOmlSg6bkxnF2KXKTAg
X-Proofpoint-ORIG-GUID: WZ-7kkrqf6pWGrOmlSg6bkxnF2KXKTAg
X-Authority-Analysis: v=2.4 cv=BZbVE7t2 c=1 sm=1 tr=0 ts=698f397d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=9wINcCVDkNTjdzQkOA8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130114

Add support for AD4088 14-bit SAR ADC. The AD4088 has the same
resolution as AD4087 (14-bit) but differs in LVDS CNV clock count
maximum (8 vs 1).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Dropped redundant Changes section from commit body.

 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 728df626f09e..fc261d3d7687 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -133,6 +133,7 @@
 #define AD4085_CHIP_ID						0x0055
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
+#define AD4088_CHIP_ID						0x0058
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -456,6 +457,8 @@ static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16)
 
 static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
+static const struct iio_chan_spec ad4088_channel = AD4080_CHANNEL_DEFINE(14, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -536,6 +539,16 @@ static const struct ad4080_chip_info ad4087_chip_info = {
 	.lvds_cnv_clk_cnt_max = 1,
 };
 
+static const struct ad4080_chip_info ad4088_chip_info = {
+	.name = "ad4088",
+	.product_id = AD4088_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4088_channel,
+	.lvds_cnv_clk_cnt_max = 8,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -698,6 +711,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -711,6 +725,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4085", &ad4085_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4088", &ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

