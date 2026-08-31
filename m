Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE82D9EDB;
	Mon, 31 Aug 2026 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165132; cv=none; b=nMORaUdRMyEr5URrYHFRuYYzQ3Sh4XGJEMpSWAPSmrJ5rgC188hQTYKreBkht8kBi/SmKXWwjJczG7ytEEc5vnzub/RKoekYy9YOESTpOXbvVjcWOZtBdNCmLyzG9ICIpdoz4bseXzoJ/I1rGt1wbm3ele4z5MMv1EMosGBuYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165132; c=relaxed/simple;
	bh=oRMMw1uqvN25JpNyDmnvkedCMBm/GQAIzjAxCssu20w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBK/yqXNwp9FEslCO1Cyh6KCrb2WpMmmw6IXumkm9hVI7OhzOnI91U3Av+F7KfeF5vZejl383BW/FNOF2bS/OkOl1xB5em4v2X8rcL1qNnTktnvD9w1Y9T1UmhN+t7uk7mR9urzWkAk6e7MtV6SRRxjkn/s6r4JnOuYyRJF0v+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CTPGIFpt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CTPGIFpt"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82hOE146719;
	Mon, 31 Aug 2026 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YSphe
	ozhPWizajNWA9grVGsmTzERuKPYzDTS6pTun7g=; b=CTPGIFptNaIb2BpZB34N/
	4JfXhKRYNVa0ImJiusijHyG/euRxlPM7dvc4qTYWhaRx/BJHGS0jjr3Y1CHwSO1Y
	7l+GiPLGuGhOQ5z0Vas85bgXB37gVy2AQ0/jEb7H7XXmC6ert8+kqNgxvrSeaDHq
	Y2VDDEC67unBbledHZ9eEEiDhDya2G1UCmfdpS1Qw2e1LedVMAVJV0M0KliuhANz
	pQDRVmiVxKoRF3/5Ysi8dfSZKTdcGMCmfnU/Qj2FY4+3G+KvYW5iNVjRvUs+7FhB
	B4h7vyW0hs2dTa7C+vQfui3e76icUQk/xBAb+JYGPErhIPIC6wqBf8RwgqiGXnAY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdkw4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 04:31:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67V8VsE7012515
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 04:31:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 04:31:54 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.222])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67V8VVaj006721;
	Mon, 31 Aug 2026 04:31:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2 interrupt pin
Date: Mon, 31 Aug 2026 11:31:22 +0300
Message-ID: <20260831083122.3486-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083122.3486-1-antoniu.miclaus@analog.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfXw5k5n6yzcEV8
 JRaOuNn1f7dfwcZhHuacIjzfI5kpVhp3BONjOnA1HnpBvKEsf4oO0fCjORfIL0w7VfSNnnPjfPR
 aM3JFvJmTIkO42mvuKyoZGYzsy4qXpRZ+zo3n6il2cWHB9/A7qcr
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a953bfb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=OEf6KZoglCvnwJEIrVQA:9
X-Proofpoint-ORIG-GUID: VSLAjuX5qYbb9Dm2XmcrDwhG2CWA7lEh
X-Proofpoint-GUID: VSLAjuX5qYbb9Dm2XmcrDwhG2CWA7lEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX1rPVYTtroKdL
 TFRA1/pBspI1BzclxH7BmGwqzdZEsGxapyrc1N627Z0L9yIW5m/Jf1tZrXh5MECwBJi/LmzltGC
 TqicECn78EblqXPZ9RhnP4WWkkirirHMxdWt09Bc4Z7rmzETBfX/jtYUxHPXLcJf/79q6Y/9AFY
 YRkxoa76u0uGGoIu0QNn1mjlQwTwfwWuvKJjm/1lhQURZEF/u1hO+0g6sff2Lc4HQogi6BU73RL
 zJnxHl7WYktogGqOOXpcz8mk4XGtGObJuLgJyYx42BlvoRBF5y/iI3214ErngLrA7cCl+wCq2a6
 cIwe8DxaZdO9X8H6HQK+RiEl+GXHw2HaDP86UPWgNgcO4WJAWx66yQpsTcc3ibYVKz8iDDC7Uxc
 OHYgM1e7npCjbnHs6fwpzfLzaDucHzm5XAISiPdSf1jDhWMbWD7p8yEbXOrWwKquq+9sJiiUPpy
 4I4Vz1i3uqstU5qORbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310072

The ADXL367 provides two independent interrupt output pins, INT1 and
INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
the driver hardcoded INT1 for all interrupt mappings, so a board that
routes only INT2 to the host could never receive activity, inactivity
or FIFO watermark interrupts.

Determine the connected pin from the interrupt-names device tree
property using fwnode_irq_get_byname(), and route the interrupt
mappings to the matching register. Use the interrupt number returned by
the lookup for devm_request_threaded_irq() so the requested line always
matches the routed INTMAP register, regardless of the order in which the
interrupts are listed. When no interrupt-names are present, default to
INT1 and the bus-provided interrupt to preserve the existing behaviour.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
- Propagate errors from fwnode_irq_get_byname() instead of silently
  falling back: only -EINVAL (no interrupt-names) and -ENODATA (requested
  name not listed) select the INT1 default, so -EPROBE_DEFER and other
  errors are returned to the caller.

 drivers/iio/accel/adxl367.c | 45 ++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 54c4d1226790..9a2312da6238 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -13,6 +13,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/unaligned.h>
@@ -81,6 +82,7 @@
 #define ADXL367_SAMPLES_L_MASK		GENMASK(7, 0)
 
 #define ADXL367_REG_INT1_MAP		0x2A
+#define ADXL367_REG_INT2_MAP		0x2B
 #define ADXL367_INT_INACT_MASK		BIT(5)
 #define ADXL367_INT_ACT_MASK		BIT(4)
 #define ADXL367_INT_FIFO_WATERMARK_MASK	BIT(2)
@@ -168,6 +170,8 @@ struct adxl367_state {
 	enum adxl367_odr	odr;
 	enum adxl367_range	range;
 
+	u8		int_map_reg;
+
 	unsigned int	act_threshold;
 	unsigned int	act_time_ms;
 	unsigned int	inact_threshold;
@@ -366,7 +370,7 @@ static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
 {
 	unsigned int mask = adxl367_act_int_mask_tbl[act];
 
-	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP, mask, en);
+	return regmap_assign_bits(st->regmap, st->int_map_reg, mask, en);
 }
 
 static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
@@ -377,7 +381,7 @@ static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(st->regmap, ADXL367_REG_INT1_MAP, &val);
+	ret = regmap_read(st->regmap, st->int_map_reg, &val);
 	if (ret)
 		return ret;
 
@@ -400,7 +404,7 @@ static int adxl367_set_act_en(struct adxl367_state *st,
 static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
 						   bool en)
 {
-	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP,
+	return regmap_assign_bits(st->regmap, st->int_map_reg,
 				  ADXL367_INT_FIFO_WATERMARK_MASK, en);
 }
 
@@ -1423,6 +1427,36 @@ static int adxl367_setup(struct adxl367_state *st)
 	return adxl367_set_measure_en(st, true);
 }
 
+static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
+{
+	int ret;
+
+	/*
+	 * Route the mappings to whichever of INT1/INT2 is named in the
+	 * interrupt-names property. -EINVAL (property absent) and -ENODATA
+	 * (name not listed) are not errors; anything else is.
+	 */
+	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
+	if (ret > 0) {
+		st->int_map_reg = ADXL367_REG_INT1_MAP;
+		return ret;
+	}
+	if (ret != -ENODATA && ret != -EINVAL)
+		return ret;
+
+	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
+	if (ret > 0) {
+		st->int_map_reg = ADXL367_REG_INT2_MAP;
+		return ret;
+	}
+	if (ret != -ENODATA && ret != -EINVAL)
+		return ret;
+
+	/* No INT1/INT2 named: default to INT1 and the bus interrupt. */
+	st->int_map_reg = ADXL367_REG_INT1_MAP;
+	return irq;
+}
+
 int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 		  void *context, struct regmap *regmap, int irq)
 {
@@ -1479,6 +1513,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	ret = adxl367_set_int_map_reg(st, irq);
+	if (ret < 0)
+		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
+	irq = ret;
+
 	ret = devm_request_threaded_irq(st->dev, irq, NULL,
 					adxl367_irq_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-- 
2.43.0

