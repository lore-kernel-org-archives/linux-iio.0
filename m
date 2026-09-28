Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D749D595;
	Mon, 28 Sep 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593045; cv=none; b=Q4D/aBOBOnePoOyKeg/a4GNKcgJcVT+xjwQgbdm7RwAlFP0Km6vvfMyTeQGVR1WYN9DP85zsxlw65ZE6LQlvcEYOTyliVEGrevAKOThG1khmVIxHxWYncG9DV9OeXf/OZ2xJwtdUqRC7+Xe7Shet1Al/sw6y9EDptCRI077QPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593045; c=relaxed/simple;
	bh=i5WijjRszeDc5wFRPdBNLXFufvQphIcqYv3nRDOCr90=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDEYqfmh4hYW9v6hWVRgJeVTCw+/Yf0XQfTQUQCl6H5r7ISLrQRyJWqy+KAzePpfHdcfAX+BecKGSVuFNyNHSLK7oMkiMATEX+wFL6OREWFDr5AKnLeTTQAFgcHotKUVBYS7DrTIG+IjiexRrFZLprhmJoYqctVrxoG2zEU8k70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PdURTKWt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PdURTKWt"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HW6N2304162;
	Mon, 28 Sep 2026 06:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pkyFv
	WF1QEt8OJPy2Dz04J2clFDPCvwSPqZqylkLMQk=; b=PdURTKWtPbZxPz4fZNAL1
	EGCNKNMRIBCS2wVjCcn3+W11CMwgtQffMZfiEFUGXtYjz9U6UyoMGQun3MyAeOvE
	Beruwzy9JbGrk1u0O+P2nUWj+fgEiBB0P59aY6sV+w92f141W0SUqewRpQCch6kx
	+cFL9r7Rq+Na3e9yZiQY5jTVXb5xxiqFF7fBJ1JTvCEhjkvAVZVS6dGHguuTEDCQ
	pV4Kju15dLwNHD7M9b3mMahqtOA2jkIIYQdGeryQscGNRv/4SkwPChr4vyX+yuDL
	RGdxdvEuTMCBDFU7SuaQtoxBsS8Z0DxP6YhMuJVDpD9b6u0sMmfnNipFpsIows9o
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gxvcdww1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:57:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68SAvIjW022857
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 06:57:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 28 Sep
 2026 06:57:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 28 Sep 2026 06:57:18 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68SAv0fG015531;
	Mon, 28 Sep 2026 06:57:11 -0400
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
Subject: [PATCH 2/2] iio: adc: ad4080: add support for AD4886
Date: Mon, 28 Sep 2026 13:48:06 +0300
Message-ID: <20260928104806.9330-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928104806.9330-1-antoniu.miclaus@analog.com>
References: <20260928104806.9330-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: pNjwQgFarOdjW8uwKGstmWDqJq4CVhUe
X-Proofpoint-GUID: pNjwQgFarOdjW8uwKGstmWDqJq4CVhUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfX4mRzzpSmiv/E
 +xLgQirHZQ71tW5Ffo1K0UTfANUyngt2mNhFphA3+Y6XeM6Qq+4MV8TCqYexgRi6CKZfxTB7C0A
 ufbxG6m6aUU8GomclchexqIClAWpP797rCQmT/DYLGwV0VKO5bWRxelPx0f1pmuiahDS+iWCYwA
 ecHdJf0tsUXDlANlIVy7XOoYSOAYTofIZQXMe5uYze9+F5E7yydDChjS3bk+A9kAW4NNKN/d9c8
 /nPbwfyzK+2Zas/W83O0uTmQpIoa7EfGtXIUgPaiRqVah7mM03WjAQAsk5RjHziHb9xOMpoyIa0
 KyswMsvk7yBemaF1mLulziqJmhttY0jC2LmXkL/7io62VvWDAOxjdD9BWgmJezYCLCsmccsFi6p
 LLFiAgNEyE0Jt0GlJI4sGJE5iIVSnzh6JAtU5rFGAlBPD3yJw6YNUbG4xxK0Q8iShVojeAvZRVV
 YIL928YScpBWMXK9+9A==
X-Authority-Analysis: v=2.4 cv=S7FMU4sP c=1 sm=1 tr=0 ts=6aba4810 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=Pj8J9hbiPoC5TcOFCywA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfXzoV/2/2RS4Vd
 T0PYctX33nLLRphkhEH5SxtVMXE5HC61KPQdmVuXpT9uEY+cq9QJKb8qsz0DTrUyChLHz3QPt6G
 sNsbsp3pWJRFtas6CzBu1jlFkXTR+KM57iHymwXL0OssI6fztdkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280043

Add support for the AD4886, a dual-channel, 14-bit, 40 MSPS SAR ADC.

The AD4886 is the dual-channel variant of the AD4086, sharing the same
register map and SPI interface as the rest of the AD4080 family. Like
the AD4885, it uses two independent ADC channels, each with its own SPI
configuration interface, but it has 14-bit resolution and therefore uses
the same maximum LVDS conversion clock count as the AD4086.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 4ed82aa42400..19d4d0dfd13a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -138,6 +138,7 @@
 #define AD4883_CHIP_ID						0x005B
 #define AD4884_CHIP_ID						0x005C
 #define AD4885_CHIP_ID						0x005D
+#define AD4886_CHIP_ID						0x005E
 
 #define AD4080_MAX_CHANNELS					2
 
@@ -567,6 +568,11 @@ static const struct iio_chan_spec ad4885_channels[] = {
 	AD4880_CHANNEL_DEFINE(16, 16, 1),
 };
 
+static const struct iio_chan_spec ad4886_channels[] = {
+	AD4880_CHANNEL_DEFINE(14, 16, 0),
+	AD4880_CHANNEL_DEFINE(14, 16, 1),
+};
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -697,6 +703,16 @@ static const struct ad4080_chip_info ad4885_chip_info = {
 	.lvds_cnv_clk_cnt_max = 8,
 };
 
+static const struct ad4080_chip_info ad4886_chip_info = {
+	.name = "ad4886",
+	.product_id = AD4886_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 2,
+	.channels = ad4886_channels,
+	.lvds_cnv_clk_cnt_max = 4,
+};
+
 static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 {
 	struct device *dev = regmap_get_device(st->regmap[ch]);
@@ -908,6 +924,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ .name = "ad4883", .driver_data = (kernel_ulong_t)&ad4883_chip_info },
 	{ .name = "ad4884", .driver_data = (kernel_ulong_t)&ad4884_chip_info },
 	{ .name = "ad4885", .driver_data = (kernel_ulong_t)&ad4885_chip_info },
+	{ .name = "ad4886", .driver_data = (kernel_ulong_t)&ad4886_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -926,6 +943,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4883", &ad4883_chip_info },
 	{ .compatible = "adi,ad4884", &ad4884_chip_info },
 	{ .compatible = "adi,ad4885", &ad4885_chip_info },
+	{ .compatible = "adi,ad4886", &ad4886_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

