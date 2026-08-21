Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBB2DA768;
	Fri, 21 Aug 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335709; cv=none; b=HOT5QSpIDA27BtsGUdDBHLkLyLAebDIR/Ld3pE3teCxAaA6bYBzz1XJX123Z6zrWrtfpI4Q34P9qi2ssdDLgvDMxqkZIC6zKcCc6PnEV7mRatmqU3UL1XoSM1E6+cNA4OPerRKdF5+jMkUKF23WCsOe2PD9HS+tmHCueQ6geH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335709; c=relaxed/simple;
	bh=PG9oWEuPDHL+6aD5FtwtFInGs9tOyBSHceFba49R/N8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSqEDZVDLZXTsc3DCIZ1eNJN9xbkSKKzj++fTmXnYJJKr+Vph0+QOJGvMp70Nbo/yOIuOV3qGMY7ztdl37ALIqXaGIc8dF7NbnOL9nIjzt4Bz4KhgOzsB3Rngf0i31F8F9vFXwxXqcvXRi43lRZniX3hYe5EpHVyiDWw5p3ZwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y5H/VHFU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y5H/VHFU"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LI4ge33681842;
	Fri, 21 Aug 2026 14:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S9Qf4
	4UBYKep4il+4/Au2TLMhqBGvJKad1mpe785eJY=; b=Y5H/VHFU5PMyoV41cACmc
	f6i/mTID1OSgMDNnmufjFZFNLuCkW4gOPGc126uBeSwlCkQsz2EgE2EInt6CKihc
	vWF0554BRFCVLSWC12TD+1OyMEcVEu+4QezXKmzQSkIl/FzMeaqt+qiPunwpPyh+
	iudCjgBB3pWRBlqKlHmayqQH2EeATcuXrrmIfwNpluLStsCH2Q+5t1sGsEq5A5+e
	ccwRHwiygd0djG6JzCcKI2y6+Yb6NnTh81hjtNbeswgcTOi5VEr5u2V5gX/lyeCy
	HRwlRASk52CcrHR7msYohcIm2AnWfdBYR8LTbJtlFuO8y3qWDHMEK36VX1Ceh2e4
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g5rk90das-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:08:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LI8MX3064955
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 14:08:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 14:08:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 14:08:21 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LI80fO032181;
	Fri, 21 Aug 2026 14:08:15 -0400
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
Subject: [PATCH v3 4/4] iio: accel: adxl367: add support for INT2 interrupt pin
Date: Fri, 21 Aug 2026 21:07:53 +0300
Message-ID: <20260821180753.4633-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821180753.4633-1-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX1q9Y2cSoa0kJ
 doQ0sg4DYOXgSYWGCFD1Y9wzqyinCZjzy35ezELxZ82lP+81Ny/Wy3z+Hhkx+dIUHApexXU6CPr
 9HJS9duUUaXXslmp/C1KWlpC8ebBxuDub+7DKQtIMJJIqYdxFBqT
X-Proofpoint-GUID: DTI5DCEc6QvZF3giBZI8VorOh37dpih_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfXygANrOmKUN+p
 51cxJl3eR0xdnzlajncVNV9fkx7WbtpgqeLalUffQwYId2J9Ui4bYSXG8mC3mS1WXqj5MM4loIg
 LUKgAA94BHaPbo5QejmQu6+s9L7fp5TPUmwXhzh6ydPobHTFCSPXxZrv3awcZSoC5gDRMbAvSmE
 yUVQCy6ko2HA4EewNqQ8uKKYCSer7LGVzgnUHLNtQbHLrtvp/TEoLyVUGdo/5X9Ivt4iFVNgoke
 Km//gYTLyzRhoP5IapOYzbP/XAaHazEju/AN9H7FZ5SBZo02OUMAryB/kaBjNPZcdKj97v3Fkr4
 kbxvhLk9mgiS50kQGT+eP5GYeYWdXlgLlRQGM7/bJoosKYOxXK9wzKaRZz5jCZVV9r+lMBAJ6v6
 mwzLi5EA3dzR1Lb0E8ZKHjJnWJ4z3phOP5rPL8X9a98gi5ICgKxr0URrfQz7WsOkEo2WZYRuDqQ
 Nq1x6xdqLlWQGF/6vbA==
X-Proofpoint-ORIG-GUID: DTI5DCEc6QvZF3giBZI8VorOh37dpih_
X-Authority-Analysis: v=2.4 cv=P+YKQCAu c=1 sm=1 tr=0 ts=6a889418 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=YVKJyccxw9hhrd0nmYAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210143

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
Changes in v3:
- Use the interrupt number returned by fwnode_irq_get_byname() for
  devm_request_threaded_irq() so the requested line always matches the
  routed INTMAP register, regardless of the interrupt-names order.
- Access the interrupt map register via regmap_assign_bits() following
  the new precursor patch.

 drivers/iio/accel/adxl367.c | 40 ++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 54c4d1226790..f5808980b639 100644
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
 
@@ -1423,6 +1427,31 @@ static int adxl367_setup(struct adxl367_state *st)
 	return adxl367_set_measure_en(st, true);
 }
 
+static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
+{
+	int ret;
+
+	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret > 0) {
+		st->int_map_reg = ADXL367_REG_INT1_MAP;
+		return ret;
+	}
+
+	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret > 0) {
+		st->int_map_reg = ADXL367_REG_INT2_MAP;
+		return ret;
+	}
+
+	/* No interrupt-names: default to INT1 for backwards compatibility. */
+	st->int_map_reg = ADXL367_REG_INT1_MAP;
+	return irq;
+}
+
 int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 		  void *context, struct regmap *regmap, int irq)
 {
@@ -1479,6 +1508,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
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

