Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5D3F412B;
	Fri, 22 May 2026 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450905; cv=none; b=Zdo69tNGGbkP5Cg8LrNFRV9MEr3M2oXwmysoJQ4FEKbTYchYS556umMx+EKOouQz/2SZ1YPm4wmGfFuHZwN7T3Gq52wRkjbl24Cwu0rwVi76sq6c0XRfOUcFwCF+nS/l74QykAwluYFkit6aSh/MeFxn+AHQxxfWD0GXlj4r9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450905; c=relaxed/simple;
	bh=uQB0D//jre4cpA2ULwsr6lu7cQqtjlTUdLXY+MLAnCY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m623fUhvrCwpLKiX8VBqe8aFYmoQFutVvqLNAHptBgsbam7e0Gyu61iLi1p39yf58bcQC4nBtsQ1gl9Bh6cgEzJn2JK1wN2+nw+dEJFCWK3k5aoj1GuW5FxbauIN5fyYzjyCWsO583jfB8t2KMVVv7H5bhaSQOxTnlR9u1td8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vEf7iAXJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vEf7iAXJ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8K2D52392214;
	Fri, 22 May 2026 07:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QK95U
	X7aIFtK82k+bOREWhP60kZSFnqkEP3UatlF4jE=; b=vEf7iAXJ5XM3fKlQMYQtn
	tTibGGCAvjLABQNyyZBJ6hzh9l2Bcs3VRrOIBVlq2ONA34rwnO4u9HPVBXosBVF5
	lGlP/Kr1IG3AKRRJk0fPFBKaaDLZ+M2mij0hzfk957n0BA3lR1F5Y1pVqNLusZDH
	AGwPNXy6Gcwavg9U8kjGL2WUhB2bzR1Wxc0M8Z+VSXQL4QQ6lQz1i2cKwyhayn2a
	wTnH1zDDiGo54865NLyNQMYLXVi7qt6K/pjlB1FxxfLzpXyw9OVb4J1cT7OkH9db
	JKjOUlnE2u5wXWQAT8G1zw0r1HWf8MTTM0SCZiKlTtwQ6+t924kfRrNnUwtT+Jpr
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eakhsrk8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 07:55:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64MBt1li020262
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 07:55:01 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 22 May 2026 07:55:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 22 May 2026 07:55:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 22 May 2026 07:55:00 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64MBsi61027511;
	Fri, 22 May 2026 07:54:53 -0400
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
Subject: [PATCH 2/2] iio: adc: ad4080: add support for AD4884
Date: Fri, 22 May 2026 14:53:37 +0300
Message-ID: <20260522115337.18188-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522115337.18188-1-antoniu.miclaus@analog.com>
References: <20260522115337.18188-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 67arl4XVHQ3BbwuSn6aeBq3w-3AjZHod
X-Authority-Analysis: v=2.4 cv=YYKNIQRf c=1 sm=1 tr=0 ts=6a104416 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=9vqVBmU5rEgUO8YIPbMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOSBTYWx0ZWRfX7HnpQKLxqWuJ
 aqnM3VvQZ8q84uk6cLXVhNAjVKeI3Ay3utWC9xbAGXgcvS5GNucY5ql41Qi3GV5nlFzBTzXwNmj
 48Q2KN2n11WWy7/Dg345lvdIiJUpI8GFVrsRbFAkpQ23U5Nlcgawt+X1wGg0kyVrgPLLsI0ZlqR
 71tWU5SF9Zs58y1z8KGUbUEG9P6g3fp/qPc9yU7wtD45d+8l8cUZoRYGTw04Ob7R2Ah+tsrJaqF
 1DzeGZgVIm/prLjhKN/agwS8mktddXHX9QJo+HLYqOGyNCxXjLZ6NiSDp4La5VIaff5Qjzr79bX
 6VWqDcIFaFEVSvbLv5DyKtmZcYTdy6DyUPGuWe898Etj1lkiI8NpfbVHOpZy4FG9zeWmNbinfKR
 RgkrBBccXwJ2Osf/ffP1rJZTthLJm0ZHeb/0anfTBpDAAhw749jDa9T1E298jUSzLwj2OKodNVe
 gznNZeM6Xu4ZfM18psw==
X-Proofpoint-GUID: 67arl4XVHQ3BbwuSn6aeBq3w-3AjZHod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220119

Add support for the AD4884, a dual-channel, 16-bit, 40 MSPS SAR ADC.

The AD4884 is the dual-channel variant of the AD4084, sharing the same
register map and SPI interface as the rest of the AD4080 family. Like
the AD4880, it uses two independent ADC channels, each with its own SPI
configuration interface.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

