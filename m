Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1B2DF15C;
	Tue, 23 Jun 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205685; cv=none; b=DnyFsWs1StSNpgq/hSXMTPjTomso+vH77bBF+izQ9HlAxP7aAxOnCjc9mUxOh1HCZThXJCr/D1RLKdutVvrA7ZUixRfpS5W4fe3toRZogZSWQZu3kKNDvmLJfN0XlHQIXNvRgamwGwK+lx1fVzmMJNdzwjj7ZyrOtXX0qJF/LWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205685; c=relaxed/simple;
	bh=zH91ZQvsUzQ9Ptzqie1NMLHjGxuLbUQYSEDB/eTSs4E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBxHGzRql5bQLNZNeGYRIqu11wPUoZ8XylB7n/M1duqDzOHJvYJmepD2XcaJ+AjBcXkZSWDpFm6r3w84DvjRUdyQCygx8ceXVISXj3aqCFMdKoEcKidmLNSLnKXHo8fVBlzYm6zRnkGIbOvdK3iWTropdu/3pOlKROvqEcWLFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xaXr73or; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xaXr73or"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6j8H51517089;
	Tue, 23 Jun 2026 05:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=I36A/
	YeDtN1NAWwfA2XPwgfvGBrBFomYnMod+ydLCJg=; b=xaXr73orRcXOZIT26IqmN
	e5R4Rmd22CjB4yYK92aHRjZHtobgByxHFemwO2ipvVqw35feDfyjk/714UT0CkaR
	hiZDqHL9akINGvjEiuNpWzNFGk5zhuHt0+7PuUJ3jJmp38GaTkBxN/t2R2TrxUw2
	j4QiXHIKDlfDHqil2WLnHfwI++wuXzk+iuSFjHYiNZHVY44Y0QJ5O4bLRmxWo3k0
	nqYC6QPOt00yV6frWAWSqetZaPO8vc4sivf6OgU9AGx1Su9yDNv4fCWakpWNq6Qr
	GoBemXuy1+echreGCzNfEVsIrW+8LFSpGDvng6ezJ5S5qgmp4bEwbnkkMFEQXiL+
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eyffxtd90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 05:08:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65N980w6030649
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jun 2026 05:08:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 23 Jun
 2026 05:08:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 23 Jun 2026 05:08:00 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65N97Yos008608;
	Tue, 23 Jun 2026 05:07:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: adc: adi-axi-adc: add data size support for AD408X backend
Date: Tue, 23 Jun 2026 12:07:16 +0300
Message-ID: <20260623090717.3296-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623090717.3296-1-antoniu.miclaus@analog.com>
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX/joPUi3JbQtz
 /I3XTnahkKxwa8jjOz99F35QW3GtjalMKwev8MW+sMFWL5HYXlRy8nGUs4TCVoTM6A5sjsR79U4
 0TS4ciVxOUUeXtI0o7fcIyWqa3eAgA3PFZ6rg2NNjCA5JXskRr3ltJIRg4EsEcCxczYX4TDXvb0
 XN4ee8u9DrnUfM60tbBw/GV/Xic1yDJfw184T5+wV+cFldK6b2ocwWXbe1+LCphoGr5ay837M2C
 mzzqsyKChgRvvedsL5FawGCRpr2CKM/kUuPC4coglkOxBvCsVEobUEUXC0/InweV4llf8j517oD
 mIq0VWgWyRIkJWNATAT8vTvlwN2jLC+7+H101Fa4+ichPJOXdlVlMw7vv2u6e/K//7oH3j7Ic+d
 IlVKYBS0e1Hg5uGXero8vzbY2BlXs3MW/rNa0wZo+fg723EKxy9zCPnp2GnWim1duhDRxzyb+3l
 cRzqtg13DN3d7IG693g==
X-Proofpoint-ORIG-GUID: tfJ5RzRiZxx_3rZag3HRik95dYORswwU
X-Authority-Analysis: v=2.4 cv=OuR/DS/t c=1 sm=1 tr=0 ts=6a3a4cf2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=jyUTmoUkxtoYOXpmdiwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfXzFe7PoAsDBsA
 iILx9yh9YGASyNHd9OI3zbXUMkpalr+dg3SX7ZT3CVOwnRT18apDlCD6PMinK1vBo3CalgTtrDv
 z6tcL6uzVKXjRru5uBS/GnKLKdocrOz33hbal/hloxTle262YpxT
X-Proofpoint-GUID: tfJ5RzRiZxx_3rZag3HRik95dYORswwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230073

The AD408X AXI core can pack the sample data on the bus using different
word widths. Expose this through the data_size_set backend operation so
that frontends can program the packet format field (bits 3:2 of the
CNTRL_3 register) according to the ADC resolution: 20-bit, 16-bit and
14-bit map to packet format values 0, 1 and 2 respectively.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

