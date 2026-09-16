Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BF4EC663;
	Wed, 16 Sep 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557334; cv=none; b=WOiFAu6HpBQjqw45pWvFdodiZCVcHSO65ITaqmSMKQ1z0HW6okGtgYtQOyiHQt0uHC89V5rCI3uPUnnUx93S+BCP3e1OgwfLfOKBXF7dCTqgljdEzMJUBvLNj4Psk1wRpdYDEfcMKkO8DV2NMunN4pIrk1U7z7suMPKuHO4B0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557334; c=relaxed/simple;
	bh=9SFGQZx76GeYa163n+o0MuGuOsms0cJc1uW+kg1hSWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ONvm55eOzdfriwkJYlaGbpp+A5g7X0a2fBKeKSpzep6JAuPZjf5LO5yizFQEiIu2TZGGBcAq77jsuWw4ZQ0ja8LzdYYQykSkmANtbCKrX6oKBOT8rB+lqGSzqBn4ilaJ3KBTFtUHumcbwUIM5qdYcSDjl1CBIya19oiiSv4M4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SQlJlVK+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SQlJlVK+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6M7Ba1591671;
	Wed, 16 Sep 2026 07:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=s+Uyr
	IW+M5iJYyJIk1hFtOIyh7Bk7uXfCQKTTyjx8s8=; b=SQlJlVK+8YybclAGGfhnb
	JvcjsH7Yo+uiTecVB0V9fE6GQc/5LhuFjIw7T6xYgLbrzbbmEOjzbw1/T8gLb70u
	T5y5Ebql3JxmTtbf/E9P9uJKr3Fgr8KWP7M1ozxr71IdRopewMGDw9hotpkRNnF+
	Zzdy5pVXZnTUK1ISOVghNq9vw93kUI8azaQf6ff6i0KwvCv5fx/h/XS1uF+hL8Tj
	MevVpOgE2aRtGW57AF/wEKyMjqAo3fjk2wrH3ct+rWHKqRvLn/kOOMXlgBq4aDqh
	2B7+GTZierSRMLLVFwSVRohX7H3BIMixbdu1EnU8/I2RmD4NyiCVIa6ZySCU9U2T
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4ckm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68GBExxD015744
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:14:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:14:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:14:59 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENDu004263;
	Wed, 16 Sep 2026 07:14:53 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:53 +0200
Subject: [PATCH v8 04/17] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-4-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=2323;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=9SFGQZx76GeYa163n+o0MuGuOsms0cJc1uW+kg1hSWE=;
 b=zOQrGEUYE0mB04rDGlkSPxaByPXF3pMC7M0NwJkaiF0cNeYBigkpJ8rxv4q4p/uiHTr9t/VUJ
 R58eUwVdzI5CLbA3uN59twYDHdYvFKceVKjLG5YcdI/pTA8fqVk265o
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX9lBjrhioAmbC
 l8kga0jjanC5Vm/nAYDnYB798Y4cgKX3y+IKbkOpE3U9KXxVeh8wBR5gsyrhNEZznLBDzsh2CJx
 Xi+HkNyJL3OePnlOMM94LRnBlpPgm0RYSSUnFWSiLuE1ms8+cJP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX/fXBn1nYkUe/
 XErvX3Mj4fGeAL+B6iTZADME2NielVJfZfpGiBE6ZE+N8bZFbHsh5ZOosH0W7WPEzpa+/aGWGCm
 GMiXJlgif8swm9VHGKvYyvxRgkzwyo3TdfFDKNDdPaZgVBoLdBIhbm4aVfEoJJGBovUcTzijgSW
 SbH74z1N413S7j7o/3WXLCWVkFWDqf8+gPsyok0dqIozoodG/iPDwozNfEN58FXNPNCF3i5shTG
 kU7txVwKs+Nr+FfsxJQc/4yrhP7jhn+VeXW3aF0hFTgF5PwdhGBN0A+rK6cb2f6py66tTwTpVm5
 j82q2RsvLtwJJNRziDn/RetrpZkyPor6LZakxGSQ2O2zAxh+s4sEaoKULmNusvW7AEghCNPVSPA
 YBIg5Y1MASpf6A3RwOkpE3up3bcq0QOLQCEaRKCME0nZd6XH1toqlPTmKjq2SgLaaFeEFncnQnr
 s9jY2jJ4EP4wNDpqM/Q==
X-Proofpoint-GUID: zeBEAdYYGR6jzFZRBO5qCW5_mDrSR0nm
X-Proofpoint-ORIG-GUID: zeBEAdYYGR6jzFZRBO5qCW5_mDrSR0nm
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a34 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Add support for enabling and disabling Cyclic Redundancy Check (CRC)
processing in the AXI ADC backend. CRC provides data integrity verification
for high-speed ADC data streams, ensuring reliable data transfer between
the ADC frontend and backend processing systems.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index fc7cc92b35f0..8b7c45d51dbe 100644
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
@@ -596,6 +599,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
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
@@ -644,6 +663,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.43.0

