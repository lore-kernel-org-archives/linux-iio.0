Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007063;
	b=IcGyJoMWrFsIsDj7OmOeENGUQCy6wkSabmxkdGANleiTjSRutaqDiyO2NnGYuW+CkmkV
	 1OuvKXEYOq6RtNp5aegJnjeU5oyUJFDavSX8Hm6IdbT/bj+sIXV3N+Jta16Wls3VGVUax
	 mvLMutp4kKH7vaVkUS0G1z3Wf8uO/0xclLgSetE1BxipHtlIIzZHONSbXY0dqFecQKJZw
	 xW+9nJRF8r8eGrKRrXd7LIQuiqeG79ZL8c935M6UPMsdzpAznRgyhPgeEl6K6+hKWCzTv
	 as/zVWRNIDXwIvWihpsgGWM0NjqnE9XZxe2TQ3YTioNhWcdi1fLewB4v2XaMTdKQ/gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007063;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NjStu/B9qXLwr4S4TkCRr5Iu4JtV1ctDb8tl+4hPlIA=;
	b=zuBIfOWE0J2UyHAgRyVcLqwYRtJThgtz8ihMboTzirOwOEnPUyhsb0rxonr61o2PwBqy
	 dW5nWd7T+Qwqps2cYXKada1bRcImtWRSlX72SuWucGu/vpHcDKD29HmkBIqPLduKV8XCL
	 hDZzm6EwL5cRY5iZZCikgxGkIcdq2x4XDNiTwzUBc1X881SVLlFVO7axMWY2GC4JLwbKC
	 7bjkFqSuABeICoMk4GhzOQnZFGzRGaKYs8w4rIid+o//Cx5OcH6ELd9qh96YV7SBTHxy2
	 9veYrdgdbcf+nwtK4V1aSy7zwdrEIKyAboc2FHvTZ3bEG9exvPSsxpTJ7J6w5iUgZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=WQdq6Qzx;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=An4uS+QU;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC777606A31C;
	Wed, 18 Nov 2026 13:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC777606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=WQdq6Qzx;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=An4uS+QU
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBLFJR900214;
	Wed, 18 Nov 2026 08:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=NjStu/B9qXLwr4S4TkCRr5Iu4JtV1ctDb8tl+4hPlIA=; b=WQdq6Qz
	x2cHQst+DuBhx0qyrQQsMqFyteCjJ1bcybZvp3440TwNxjFo3ncsthrObee+xUE3
	TxYMJz2/q7swhMD9lkeSyAgqMna1Qe3PkPFD/o7NyfB7YcZkfLgamh+/7xji7N2A
	14YAuICxMBvvJaLy2Mn793sL1yooUOBpDZq7QcfhqkYLexBY+hk7nrNbeUFptkaf
	FTuLjKkeKdv9nM+7OlZFTL0gQvVVYgUK04bOFzT0CtccLR5TwfWgYY3bafJjETz1
	2TuravamyiN9AxL2OP9odxeASJGApf3VRTa60KVWBp7oFFTTDFRcviGFulyBn9uc
	2LVjArv89XhlTZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NjStu
	/B9qXLwr4S4TkCRr5Iu4JtV1ctDb8tl+4hPlIA=; b=An4uS+QUQgL6apyIM00Ew
	I5kTj3w6Z9/Nu5e5LMUPekJMKzzHNLteQz2fQ3ALHOEmS867i54SHpN34vWx32/c
	DVCljS/ah/o9Ss/A+tc0EogngVD4uQM1d1d9zY/Q7xOaPwGJ+0eu1901BJN94NEQ
	pBSlYUky9RnVQMusOe61w/ZznIOoLIu1e3Z2N9vRuhdJOPAs6CRujmNdM1i4spc0
	gy2/0dCrW5mkhz4ReHzYKKlYbxJL15LqPPdq1VHvgf54EnK46+QvC/SPOFERU3w/
	zenHOJoX0Z9yh3NTcEOmizFC4nAvSWPxtTaVNEIudhycZA1wvXmCHdiA+DqqSRn+
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j174g1nsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:04:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AID4E5R004438
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:04:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:04:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:04:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:04:14 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID40Bi022830;
	Wed, 18 Nov 2026 08:04:03 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 3/5] iio: adc: adi-axi-adc: Support AXI ADA4355 IP core
Date: Wed, 18 Nov 2026 10:03:55 -0300
Message-ID: <b3d994efcb896a1fd004c7bd15d387b3122090c5.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G+2JgNk5 c=1 sm=1 tr=0 ts=6afda250 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8
 a=OjnDG6chPnepvdpQngoA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: Oph6VKcOv0roXVDcSo1-TCzNyqVDVq_J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXwbtgm8wKvIv2
 M7VnqFMbqYqZvoGWj0wpc4L2LAyxHpinvoSNXrO6xFv4tQ2mbB739lTudKBuU14BBZWCN3892Iv
 M0amBpf1T+PIJKENGS63+nL3oirncQCWNYD13QN1TZXgdbRNku49
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX5trk5fUMD3cC
 LNSXWKpqtLW1W/7PrfWqhBtn8dDwoSHZcrhrF28mO7X4VW91nMqpjgGYkoAuwPX0cIgPtOSjuPo
 MmiIn6QOdYHm2yI9Zsela3qs5NyBo+rGIHzFN5QTYV5vfgbboP6Mh6AbR0Pd8QW6rcR4Np+zokQ
 AN9X85s+7rfabBqofA1PiOGthiZ9cErArRMUbbxTKOaz1SSgqIkP7gx+Oi5hAyJJCatLPzY3zBy
 XPve7k+Wunh/6iWiYKvpNuLfxW0aBjwoa6a0+v7YEel3BvltZyoi9XDXnlPkKT50q7looJuVdrh
 SAoUr2OTRCoSOvVBK64Rbhtg+sp1d0H+0Ed69x0bq3SKnLj9Zh7PFKR9QDiT2bonhch5FvyXD6u
 ShPtNPmGHgBoZWlNOS8sU9f6j6rw1OEbs2YSN46KP8lOhR3VBtIHFBHqG8Y5QjNNlFgHC9wQ9ip
 fLc7AueoY0dDIOb0jEg==
X-Proofpoint-ORIG-GUID: Oph6VKcOv0roXVDcSo1-TCzNyqVDVq_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052

The AXI ADA4355 IP core provides the HDL interface to ADA4355 devices. It
differs from the generic AXI ADC core in its register layout and requires
a data frame setup step in which the number of active serial lanes is
programmed.

Add a separate backend operation for the AXI ADA4355 IP core and register
it as a new compatible of the adi-axi-adc driver.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ada4355/index.html
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 8b7c45d51dbe..84c918cf5e6b 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -67,6 +67,10 @@
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
+#define ADI_AXI_ADC_REG_LVDS			0x00c8
+#define   ADI_AXI_ADC_LVDS_FRAME_ERROR		BIT(2)
+#define   ADI_AXI_ADC_LVDS_LANE_ERROR		GENMASK(1, 0)
+
 /* ADC Channel controls */
 
 #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
@@ -486,6 +490,34 @@ static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					1, timeout_us);
 }
 
+static int axi_adc_ada4355_calibration_source_set(struct iio_backend *back,
+						  enum iio_backend_calib_source source,
+						  unsigned int lane)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+
+	switch (source) {
+	case IIO_BACKEND_CALIB_SOURCE_NONE:
+		val = 0;
+		break;
+	case IIO_BACKEND_CALIB_SOURCE_FRAME:
+		val = ADI_AXI_ADC_LVDS_FRAME_ERROR;
+		break;
+	case IIO_BACKEND_CALIB_SOURCE_DATA_LANE:
+		if (BIT(lane) & ~ADI_AXI_ADC_LVDS_LANE_ERROR)
+			return -EINVAL;
+		val = BIT(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_LVDS,
+				  ADI_AXI_ADC_LVDS_FRAME_ERROR |
+				  ADI_AXI_ADC_LVDS_LANE_ERROR, val);
+}
+
 static int axi_adc_num_lanes_set(struct iio_backend *back,
 				 unsigned int num_lanes)
 {
@@ -722,6 +754,34 @@ static const struct iio_backend_info axi_ad408x = {
 	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
+static const struct iio_backend_ops adi_ada4355_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.iodelay_set = axi_adc_iodelays_set,
+	.test_pattern_set = axi_adc_test_pattern_set,
+	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
+	.interface_data_align = axi_adc_ad408x_interface_data_align,
+	.calibration_source_set = axi_adc_ada4355_calibration_source_set,
+	.num_lanes_set = axi_adc_num_lanes_set,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+};
+
+static const struct iio_backend_info axi_ada4355 = {
+	.name = "axi-ada4355",
+	.ops = &adi_ada4355_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -841,12 +901,18 @@ static const struct axi_adc_info adi_axi_ad408x = {
 	.backend_info = &axi_ad408x,
 };
 
+static const struct axi_adc_info adi_axi_ada4355 = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ada4355,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ .compatible = "adi,axi-ad408x", .data = &adi_axi_ad408x },
 	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
+	{ .compatible = "adi,axi-ada4355", .data = &adi_axi_ada4355 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
-- 
2.39.2

