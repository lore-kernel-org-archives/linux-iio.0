Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D133E37C;
	Thu, 13 Aug 2026 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608933; cv=none; b=nnObvt41WKn8wNQafCIIvo1dU4fvyCBBYteF1MIlnPy930exTh5vL6KffJtjvAEDf0uAWamvLCstUV5fYUWW+AVR0JhEmNKc3aifMPjw5VjZCEyu/6Ee6RsJHadaDq1pJZGJbyVMCBMOGMjUhYDLgeu/bNjGu7HcxNWnI79UUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608933; c=relaxed/simple;
	bh=gMen07OIg0W/VP59D9NLrP+6UHbOC7wH6JaqXzuxHB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J26RMgU2zF/wn/ZhTZB5H9GPTpugjloEKF0lwGsY5AKAZIO94f03Em3XgqAE6MDObpwfPluWQ8lr52BbxwsYCAgiMUpXDlFN4sagX6Eip4NzTXcSAFOXtTWKW3mPgvmBK9QkbfwlJrjAuC77pthLdEfF/PqSS9aV+KHPc8kAhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NpFDad2+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NpFDad2+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D7whoa1309749;
	Thu, 13 Aug 2026 04:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NrPac
	Qq8kh+ayZDu8pTNCMe4u+2gdIFn2lBEMZAy8Fo=; b=NpFDad2+MPaZUU+mRHPc3
	r0nZ1fvrHHBvKy9r5f1gQkjKIPUoXl8eVAV3BfYFix18zTZ5zxXC1oebsQQ8WR2A
	QJOtBiCMeffB+Tk3GZH+15dYNSKmNsuKTmCI3KZ7poMqW7SwqO4KUE91v6g8Sjcf
	ahKy97dwEnKKaBeVOWLca5TbJZysgoVIJMkeaYnaIRJb0bnKsTcZ2FgXhQqExg8P
	rVnUoLvBYb9B69oRQj09zdv8ldb/fH6nauuUOSyNaNYSpyYmZlaS6EqrP9FYuiEL
	HPLKtuDClzbe6rUxOZTCTnd3hsqqzWe9hwv3Qvy0cRbmxSTofHfh+EA7dRhyvXZ0
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1a0ug44d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 04:15:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67D8FRm3000822
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 04:15:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 04:15:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 04:15:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 04:15:27 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.182])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67D8FArv008160;
	Thu, 13 Aug 2026 04:15:20 -0400
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
Subject: [PATCH v2 3/3] iio: accel: adxl367: add support for INT2 interrupt pin
Date: Thu, 13 Aug 2026 11:14:52 +0300
Message-ID: <20260813081452.4289-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813081452.4289-1-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Sg9uVsrfP77LzvXuy-JPoj4lrsIv8DS8
X-Proofpoint-GUID: Sg9uVsrfP77LzvXuy-JPoj4lrsIv8DS8
X-Authority-Analysis: v=2.4 cv=QbJWeMbv c=1 sm=1 tr=0 ts=6a7d7d20 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=HxlKZNGDwPukNFmCmIsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfXzNi+V3uiqA/X
 aa0guLTMWa9DZgHWOjiNUytHshC72TM5iHTYV6sncywFSYQuEcA3nLSk+cIsmBPKSi9X/ivGtW1
 9jNKhej4VsjpMgccP+Nk8nV3VcgY83KZwWaeS9fnmBP5F4VYHWV2dXrhaBW7lcg2JTT3GCh9DIk
 fz323pCQOJFlBANxV60Q82zZ02gyRg1byKH0b7HFb2AtfGU57wffGBKnT/rMXnJZ+zA60RrauEd
 95mNWdtIgMBay/236i5IJoga+Qjb6aKxwQ1s0mAxGLCs3PEtRwO7UbyRbeohzOaLIKfixajW/9E
 VGbcsMx5nqZWScmXp6WRO0NKwW9qWoVkK9UkcUdNj9KtbeGCjtL1KuJ4BjIR9q2Z5WNK8YOsDpu
 vOjMfQLBQLK5pzN2gstSIMQfTRKyWXdhRQjjL/2DlQkXjzN6sGKFDbE6ER1lDJuiDqsqfbwg6WG
 akUlAMevEnTn9YGGXfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX+zVjfCeQfDIK
 qqLOYP5pk73alqPWo1FPgyKwiIvgFtQQG8ORFQ6QmVI+YJIHnxiHIeTuJb2Hwc7DDH/mafpw5CS
 MiJlpqDIImGryRFHQJwExXzZTVveuDRaVH+RqDTUbhbBDVW2MywZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130056

The ADXL367 provides two independent interrupt output pins, INT1 and
INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
the driver hardcoded INT1 for all interrupt mappings, so a board that
routes only INT2 to the host could never receive activity, inactivity
or FIFO watermark interrupts.

Determine the connected pin from the interrupt-names device tree
property using fwnode_irq_get_byname(), and route the interrupt
mappings to the matching register. When no interrupt-names are present,
default to INT1 to preserve the existing behaviour.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- Propagate -EPROBE_DEFER from fwnode_irq_get_byname().
- Drop the redundant irq return; the helper now only selects the INT map
  register.

 drivers/iio/accel/adxl367.c | 39 ++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 8c3de11a10a3..df385740b17b 100644
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
 
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
+	return regmap_update_bits(st->regmap, st->int_map_reg,
 				  mask, en ? mask : 0);
 }
 
@@ -378,7 +382,7 @@ static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(st->regmap, ADXL367_REG_INT1_MAP, &val);
+	ret = regmap_read(st->regmap, st->int_map_reg, &val);
 	if (ret)
 		return ret;
 
@@ -401,7 +405,7 @@ static int adxl367_set_act_en(struct adxl367_state *st,
 static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
 						   bool en)
 {
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
+	return regmap_update_bits(st->regmap, st->int_map_reg,
 				  ADXL367_INT_FIFO_WATERMARK_MASK,
 				  en ? ADXL367_INT_FIFO_WATERMARK_MASK : 0);
 }
@@ -1426,6 +1430,31 @@ static int adxl367_setup(struct adxl367_state *st)
 	return adxl367_set_measure_en(st, true);
 }
 
+static int adxl367_set_int_map_reg(struct adxl367_state *st)
+{
+	int irq;
+
+	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq > 0) {
+		st->int_map_reg = ADXL367_REG_INT1_MAP;
+		return 0;
+	}
+
+	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq > 0) {
+		st->int_map_reg = ADXL367_REG_INT2_MAP;
+		return 0;
+	}
+
+	/* No interrupt-names: default to INT1 for backwards compatibility. */
+	st->int_map_reg = ADXL367_REG_INT1_MAP;
+	return 0;
+}
+
 int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 		  void *context, struct regmap *regmap, int irq)
 {
@@ -1482,6 +1511,10 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	ret = adxl367_set_int_map_reg(st);
+	if (ret)
+		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
+
 	ret = devm_request_threaded_irq(st->dev, irq, NULL,
 					adxl367_irq_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-- 
2.43.0

