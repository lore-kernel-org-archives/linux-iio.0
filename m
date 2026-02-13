Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD33624B1;
	Fri, 13 Feb 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994051; cv=none; b=XKR7cSW/ucszv02kW6y+hl1i2+Z2PuUSXMSWrDaJ7Ht7K3aUAO2C384/1An2GLnvo3AeBBm8uPUYodnz+pM++TaTTI2mNGfl3eo16IAtBJoHqys+chV0KTVqoPUtgyJLllxaPtoGP2GUUU6qhBfTGKhh5mlUvIeriZ1OWZ3lMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994051; c=relaxed/simple;
	bh=RFC4/aewhs/cPIbpvMNJitdecHFAmIMBWrQnV0K9lpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WK+DDYkgFZMhDTSFvu1+9FA9K6/DeBdUppDj3fBtXeGS16aQkR6hOSbXchJIkTEvyH6G0vwJe7w7ySuo/KLKBty2mpmAbA9hkqqX1HxS10e5sRL1pt651zS3rvWUiHRVIf1nuXEZOpmKTdH8itbJ9hfLz5pqO59On62aME6BIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kg/ECYyz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kg/ECYyz"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DE30LO1725303;
	Fri, 13 Feb 2026 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NiJmX
	KVUnFY3ESsfQkBxjpepV4UM2eT0k0CZdgQC64E=; b=Kg/ECYyzJRgaY8MxStt1L
	GAomIPAHkoq2WgNGkzSp3gLGSlwO6kvWwehitgIdA1mdSzYYC4fjzJe4Jv48MeUK
	iqn3uTCf7e4sqwXmqo3UXT8ZvY2hoh2GROKthX3klNahiVcq2UuSxb9s4d0AMxOA
	0ETGihn31sYSkSOXZK3/8fZzGIgPLTbZUK6f05wld2L5Hb3dFD0d7nA7L0eACG3r
	w6ib0v9WfCdnTGntXlz9yPOjR629jwH9/Oj1hSDb+fovLqKsFbBjGpVRKqNgb+yb
	gIXfrlRIjLp+S01e8cHTP0/etbWZbXwaIqBZjs2ukiqcZweobakRN6IlGArx3+3d
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c9yst1e1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:14 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DElDXt041305
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Feb
 2026 09:47:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:13 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH1018425;
	Fri, 13 Feb 2026 09:47:05 -0500
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
Subject: [PATCH v2 2/6] iio: adc: ad4080: add support for AD4082
Date: Fri, 13 Feb 2026 16:46:23 +0200
Message-ID: <20260213144629.16001-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfX8LbsIPBfNjNP
 hDQyOtYG7i8PM9NZkJt4ru5fbSJdxy8M6PtVO49PJINrOT/56MHN66AJEz92ZsQG572DNgPPW0z
 16iue26+hekX90UXRFbPzUYkqewMY0xGkvlFtCl20sRAGj/DsC5Ze860CfOgi03qJFp5cxwIv0Y
 +l/if0K4sORFW2p65gIqW3YUaF3+qnEQepsKDOTNKwFZ8i04Mf6vVC7/pc4IJiDL4M54nO7vlQR
 0VT+gTAVrs16NYewb/7zG8juTHHouX/ENYuxlc7kVY/acoTvQW6ECjCWiyGOOtIorEo1OiWslWI
 JqL5Cc2tix/WcSpRqKnHp1y/kM6LHXrjeHjlBcSZnjuessp/0ppx29GemfFFzn0PM5fRqkpGtox
 zCK1PQZCtMAYVFvpCWuFo7Dke4sD28r4ydgMug7eGnVc3ZmoRZO0oI9QqnNakNZ4p6smIaZ218K
 bG++l3QKkNFZHuZLx9Q==
X-Proofpoint-GUID: CUZq-nn26A2SgZVb094rV5LUyovzuqbq
X-Proofpoint-ORIG-GUID: CUZq-nn26A2SgZVb094rV5LUyovzuqbq
X-Authority-Analysis: v=2.4 cv=BZbVE7t2 c=1 sm=1 tr=0 ts=698f3973 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=RcLRY3Osc2xF_o6bJksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130114

Add support for AD4082 20-bit SAR ADC. The AD4082 has the same
resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
maximum (8 vs 7).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Dropped redundant Changes section from commit body.

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

