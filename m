Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE40481FCA;
	Thu, 13 Aug 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629486; cv=none; b=hlQs0pN+08pHJeDuX1lslpybgWaJdPi6xOLGbsE9I+OU1G0l2OH85eSYSkzLDeL36QtImrZhBk18/KJeKJt6QSohw7aymEk4l+7V/l8SibXzwD75i7VRwscx7XHdWWTIyEVOFXkdGZeu9oSUeryQ87CL0NBYXncp3ESelaqJ2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629486; c=relaxed/simple;
	bh=BC3GY2a0PfAaf1anUYAI3VBIwF6NWvD9eEF7jo39oM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tt8GVSLzNHyRxk/0CYsPnaVeK4U+Ypjk1xJUvGsIrUHSkREsW1/Gx1fKFPLbZaYwwz/vGC+MIfJLmpiIWkLsGMeKrthCuXeDfUXl4AgTae/w66tNgQRuv/xu9goxpp+P/TExFztfN7bRaIE3GajxTFQjo3VasADUMQ3esI9ai8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cbjzSc8d; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cbjzSc8d"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCdD631876680;
	Thu, 13 Aug 2026 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=meDou
	IdYda+dFUbpyjE577+DP2BMvJelM4xTd/l8MgY=; b=cbjzSc8dmyq0kD84QoJSD
	72vFMDyGAZjAy8Us7e3ZwPnnc9X+7fI93mw7OkS5b0deiLtmpAjVUGXWcSd/7Hmm
	BRuWwhm71SvplMS8/kK4JF6LGR4SaVUrbzf+z5reTs/gnCKySJjzAuxp7RV4rI3N
	7YwdMLVpNcoYfVn1inTzray4i7LLqam0DMVD5OjjzdPpx9wkZtK+g/UHZZvF01n4
	MIEJTpoQOaApncBHg6N6DDlLu+2fvdAObEfwAt2Gjt347mbosk1+9pzdmPlgvy66
	OFtVOpopkPCNQcq8sIw7ZWKXtRw2r7oKZ22Huc8Ag1ExHMAskXaijw/q07HrC44O
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e4b0dax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:57:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvsdM024631
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:57:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:57:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:53 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwW006802;
	Thu, 13 Aug 2026 09:57:46 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:57 +0200
Subject: [PATCH v3 04/14] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-4-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=2211;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=BC3GY2a0PfAaf1anUYAI3VBIwF6NWvD9eEF7jo39oM4=;
 b=AVi+Nh2JQ4ixXN+MnBZEc5QeXGJI0S3MmbOLsiCNK39sdRqdRTixpl5YV+46U3Gw9O4jSF4jL
 Sfz3ginynpvB53T8TvnV3fTpDo9ZbWXu2Y6+F44xxuBukPNjkeTirAw
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: fsUhZO1XOSu0qGaLjQ977imB8ynPzayr
X-Proofpoint-ORIG-GUID: fsUhZO1XOSu0qGaLjQ977imB8ynPzayr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX6ViOH4KUmnL1
 UA9vNLKcgxPhuUqPyOQjcaICriqRWeRY+Rl8VlXYtOxJAvmrh0GuGYljy/CHSeGwMYzds5olwE7
 yrhWQf5HetHaGCSLUaz3UErw0IM4rlxh1wicHDiihi26Ryi/zuwq
X-Authority-Analysis: v=2.4 cv=ZZYt8MVA c=1 sm=1 tr=0 ts=6a7dcd63 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX56CXMqmJJGIU
 3WeV6+etHKX7boorpQurbyaUOhRi6tBbWbKlsuRor7RL/N358E0tGFkbCp9UZYxMwp3q5Q2HSaj
 Y6yP9Ml60yOPM8ttm3s0op/+KqhGPyhLH+RDIkpBGCWwjN+teA0rTOoXkrfetCjU5NohwgeGSeO
 qmXecUiImT3hGM8/DzUAnESEodd8A9M4DHwu4sg9sDQnd8pPTGXUI+jMS82XXbGsfFBrxSHr9Rs
 fW+2Z39FhPNMZA8zOzdbbXlfWsL73cHXzrit9HIRrcEIaFC4kAzl4pjtRbhL19L+X9WoPtyLBcM
 L5W9qN//ryhF2lS4AKXmM2rHkxlpxBCZt4/ap3eERDY+dAkVQXJwbaihBp8JuV5GKNV/xb2IFG+
 4sBWt0AmZqSajO5Ycce9KumVfFMUQoYiGFojKEC9YkIkuUy9DaN+KeksrJ8FXh/WxbhJ4kL1lSX
 zGXuLh646mkoyziNNsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Add support for enabling and disabling Cyclic Redundancy Check (CRC)
processing in the AXI ADC backend. CRC provides data integrity verification
for high-speed ADC data streams, ensuring reliable data transfer between
the ADC frontend and backend processing systems.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index b5e59b1871b6..e8f149e230e7 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -47,6 +47,9 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+/* Bit 8 is common to all AXI ADC cores; bits 7-0 are per-HDL-project. */
+#define    ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK	BIT(8)
+
 #define   AXI_AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
@@ -567,6 +570,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int axi_adc_crc_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+			       ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
+static int axi_adc_crc_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
 static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -615,6 +634,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.43.0

