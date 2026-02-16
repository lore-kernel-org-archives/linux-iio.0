Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DD313272;
	Mon, 16 Feb 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254724; cv=none; b=r+j15uX60HBQ2eJURdHBsXeXF6pJ1cAoKDgQxTrKDXW58rFvqIpnSEOrP8fLmDpYWYv3504qsTymYbFsg7bnqnYrYfCOQkOfM+9RVzGQa51TytxjWjcUEwjh0voG/T+tEfndsin6MxHcJYf/+9iYIsiTZjuaDEtuUd+CBD9anYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254724; c=relaxed/simple;
	bh=K6q2uvUFNe74IlsTDGrMP4E+PlT8aZ9Rg6OHl6Ov8wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEpDvOVZ6vRAqf8xH5y8el8zCcqDoJ76SiIOh59bwrBik0EbaT9YBfU0RlnQP5EcxbEM3wrWmnB1W+QVBklI8/Z75oMH6H9w16OqtLCJ2s5DiIrFXuiayUpvF9zS7jTr3/9xNg9tv/JH8iXxLtlCwUyL/psHqVi0MsbiOj07zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MUcA5Z6e; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MUcA5Z6e"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GDRsV34079294;
	Mon, 16 Feb 2026 10:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5PvLE
	OsRpHbflBCStESm7hryd52QgpUq4ThFgSnBS3g=; b=MUcA5Z6edSBiwr+yqOfCv
	IPiKb/Vlk0h7bA9Hm6oZPn/WeQGTK5nRdto+BbYfLjS5IgxS1079NFogKlmkVC/M
	rznFBBsblVYqMM2NvniRcthFKgKzul6t95n0nJtS+7a3gp+D9IJT5D32Yx+cx4vW
	w86YOd4tC0EWdO+0cxLkFuKTvkHnUzsE/7PO7/SoWXufC3jMM6TRGxyHuzC9cF13
	HQRDx9zuA3t8vgqRv2IbpQufLTwNCpCjA9r/ydPP3CpEN6cFxKaBiAjeHLXthnem
	zdRQ3gPMh51fp2yKz0AnpllJmhwuj/jad+I459eYMoLvUEEjbSLxyR/b8ihqNqHP
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cbn8r3et1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:11:48 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GFBloJ021598
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:11:47 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:11:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:11:47 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GFBT9D017396;
	Mon, 16 Feb 2026 10:11:40 -0500
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
Subject: [PATCH v3 2/2] iio: adc: ad4080: add support for AD4082, AD4085 and AD4088
Date: Mon, 16 Feb 2026 17:11:11 +0200
Message-ID: <20260216151112.139359-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216151112.139359-1-antoniu.miclaus@analog.com>
References: <20260216151112.139359-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wFIm4DDa3sB_8STTGME2W2tyXz0Fnabi
X-Proofpoint-ORIG-GUID: wFIm4DDa3sB_8STTGME2W2tyXz0Fnabi
X-Authority-Analysis: v=2.4 cv=aIb9aL9m c=1 sm=1 tr=0 ts=699333b4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=N7TgUSQySV4cBu0JIyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOSBTYWx0ZWRfXy+QAoObLmga9
 3AcSUE+Ab3EefMWQd7OQQC4Ypu3sfsEaI6NMcxh4TCQgXP7w4cN40NNIpSZHcyCJ2JPBjJvNYn8
 qLL/A8JRJUwTIRrrCnqd4thyCnovi2KbGwsfZ6HsfhFszfzKSSmGj+rrqr69wxyukbsNJkMpPre
 bu0QfP7nznNrS2FxMFJH5HMO5uz/ldidAxpj1YnPk2M/M1rjneAmPyyI8XyoUOwHjj8AhFxROVf
 j3zTRqAZKk09RY4BO+bFusXxNTscZhT8EJQQLsafsunTDED5nYtY/tRuKN/yG7oYrzJT214wC+h
 e8BiZVpmTxoxPnjSLnUuZLmkiU/EiLy98lhx2v0bIuYwrcRncDf78SeTD50jkpbbCoLEO3k40K8
 2Td8ur7nw3Dj4E+lmxviEOQ194yP6CRIYjCt85i1LCQYoMQrbWQO24KgBkxM3s+FeL3WtPOTM4c
 cMz5kiRSwebZnckUt7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160129

Add support for the AD4082, AD4085 and AD4088 SAR ADCs. These devices
share the same resolution as their base variants but differ in LVDS CNV
clock count maximum:
  - AD4082 (20-bit, like AD4080): lvds_cnv_clk_cnt_max 8 vs 7
  - AD4085 (16-bit, like AD4084): lvds_cnv_clk_cnt_max 8 vs 2
  - AD4088 (14-bit, like AD4087): lvds_cnv_clk_cnt_max 8 vs 1

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
  - Merged individual per-device driver patches into a single patch
    adding AD4082, AD4085 and AD4088.

 drivers/iio/adc/ad4080.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..fc261d3d7687 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -127,10 +127,13 @@
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
 #define AD4081_CHIP_ID						0x0051
+#define AD4082_CHIP_ID						0x0052
 #define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
+#define AD4085_CHIP_ID						0x0055
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
+#define AD4088_CHIP_ID						0x0058
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -442,14 +445,20 @@ static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32)
 
 static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4082_channel = AD4080_CHANNEL_DEFINE(20, 32);
+
 static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
+static const struct iio_chan_spec ad4085_channel = AD4080_CHANNEL_DEFINE(16, 16);
+
 static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
 static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
+static const struct iio_chan_spec ad4088_channel = AD4080_CHANNEL_DEFINE(14, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -470,6 +479,16 @@ static const struct ad4080_chip_info ad4081_chip_info = {
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
@@ -490,6 +509,16 @@ static const struct ad4080_chip_info ad4084_chip_info = {
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
@@ -510,6 +539,16 @@ static const struct ad4080_chip_info ad4087_chip_info = {
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
@@ -666,10 +705,13 @@ static int ad4080_probe(struct spi_device *spi)
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
 	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
+	{ "ad4082", (kernel_ulong_t)&ad4082_chip_info },
 	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
+	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -677,10 +719,13 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
 	{ .compatible = "adi,ad4081", &ad4081_chip_info },
+	{ .compatible = "adi,ad4082", &ad4082_chip_info },
 	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
+	{ .compatible = "adi,ad4085", &ad4085_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4088", &ad4088_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

