Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7243A7590;
	Mon, 13 Jul 2026 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932098; cv=none; b=qnVAl+zNsVmtgr7YV8p93DNEyeEEtPiQQzyFXZzZx9e+ySJPhOIZb0s/V6nttSXZjZUPlW6r7O30K7GX/JshwywsEOCub8kz7GG3DgNs8owpT1huHuqURjralIz9lbc6DmD8Au07dWMmwzrk8BuBhi9yxcdpHhWvMaCED0RPt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932098; c=relaxed/simple;
	bh=vs8K6L61IRabs5X7uHpT9wQObgpdVW1lD4Ii1ASKGTQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LV/7V0BzJ+USIeKBxbJMzSimhiwyZFSn1Mmxnf8PMKdARTkaT35f2E4eODurkFufjuthq8rdeaSJ98xY6LYjMtLStw2JKynkdNjVKSPvA+sX63j+9EUzyzhRbahUkhnRjUdW4CNTu5iQbhdo8rRTwF8JKa9k19hzXVdrT81FfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MhRq6eDa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MhRq6eDa"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6RWtq2931615;
	Mon, 13 Jul 2026 04:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=glQ8T
	nLd7mQsHbz7D1YPUVMbfryinkbP63+ewvYeScc=; b=MhRq6eDaIUxNkC9lZ8obO
	Ym6WSmRdI+19yI815JE6wRmRIURfm6KRQikZqC6rGrAsKIY3SbxDfMe7sBw2qnMj
	c7r/iwPY4VhROInMh6KdV1UM3DDa6KE9eA9N4ivnga8GCpIcEw9DQ/67rO6CvnU7
	knJkodtrnymebvEpgxXKQiWd7gIqsIeEwaKU7rEUJMIQG8TGw1h7byPiKeeZQJU6
	ZKrha49zKggozSy9VzTYxxAl/UsguogIQug5zK3Vrhvaar+407UGsvYDaxinld/C
	z5D12SocHsdgzAVIv3lo2PdBg5Mpu81B8gB1Ed9llrVGdUZG8XRHtgB1ejruNrUj
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fbg2c5txs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:41:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66D8fUiC047355
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 04:41:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 04:41:30 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66D8fIAA015758;
	Mon, 13 Jul 2026 04:41:24 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iio: adc: adi-axi-adc: add data size support for AD408X backend
Date: Mon, 13 Jul 2026 11:40:42 +0300
Message-ID: <20260713084043.10856-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713084043.10856-1-antoniu.miclaus@analog.com>
References: <20260713084043.10856-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=eLYjSnp1 c=1 sm=1 tr=0 ts=6a54a4bb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=jyUTmoUkxtoYOXpmdiwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfX/ZgSDWmLKEUE
 ete7+j5G8FRQDgSwwe/qbSnqRVV2tfhOLl5oalF1v0CPnSmB6Ql8C58Dfjop6lVTO9HJXF3UVDV
 ZRs0dCFYupgAlCfofjmufAVulAzBfqcpVtw1PFTDc5X6c/Voqlq+
X-Proofpoint-GUID: 51bMXLgHx5V7XKYAIE6qKXaNaHyWFB_2
X-Proofpoint-ORIG-GUID: 51bMXLgHx5V7XKYAIE6qKXaNaHyWFB_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfX9CdTrbv5YAsl
 U/HXzzkUSg6zWUXVju9a0q254lLHiUOoMNiyHzi3S+Z+HYOA5AQOe/qkBDRfKgAuaeUnesBcbPT
 rsbDtEZGIL9WtAjrTgD68gxJ/JlCxog6XoCaiQGxuBdARZAIBuPt+YCW/sLMiNxe2As0EjZOFXM
 EYG4TE1HuIyq9qd9ow30qyyVJjnbR9NSCV/u6S/ocg+39BYWZXutpDRTFznh1aNCaYx5/rEdgAe
 YcPD+ugW+mPERVFhEDU9B7cq/sS1d8Tr61pcpyFVArAivWN30NlRLWfb5GGgiwzCubCxrvQiq/E
 gqZ9mZwi9RG7MziWoVIQBOSi5k8c64qROQl5LAJN8hY2sShrQ7Pz2tHQ6s5Ayw6/3Rs2ccLuRGv
 IPvyKEbHfrC5LKMwZylRicXUZZb3qQfj19n11JvAwFGSLIKy02aa19M2PG8PzT7O7ySuOrCWu1y
 bJinDCHhSKfE4zjIDdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130090

The AD408X AXI core can pack the sample data on the bus using different
word widths. Expose this through the data_size_set backend operation so
that frontends can program the packet format field (bits 3:2 of the
CNTRL_3 register) according to the ADC resolution: 20-bit, 16-bit and
14-bit map to packet format values 0, 1 and 2 respectively.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - No changes.

 drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index ced0a2321ecf..aac6f4a0705e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -54,6 +54,10 @@
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
+#define   AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(3, 2)
+#define   AXI_AD408X_PACKET_FORMAT_20BIT	0x0
+#define   AXI_AD408X_PACKET_FORMAT_16BIT	0x1
+#define   AXI_AD408X_PACKET_FORMAT_14BIT	0x2
 
 #define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
 #define   ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK	BIT(0)
@@ -437,6 +441,31 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_ad408x_data_size_set(struct iio_backend *back,
+					unsigned int size)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+
+	switch (size) {
+	case 20:
+		val = AXI_AD408X_PACKET_FORMAT_20BIT;
+		break;
+	case 16:
+		val = AXI_AD408X_PACKET_FORMAT_16BIT;
+		break;
+	case 14:
+		val = AXI_AD408X_PACKET_FORMAT_14BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				  AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK,
+				  FIELD_PREP(AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK, val));
+}
+
 static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					       u32 timeout_us)
 {
@@ -660,6 +689,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
+	.data_size_set = axi_adc_ad408x_data_size_set,
 	.interface_data_align = axi_adc_ad408x_interface_data_align,
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
-- 
2.43.0

