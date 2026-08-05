Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144E4570C2;
	Wed,  5 Aug 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931230; cv=none; b=I5M7nq/xH+k113JTnJDg/S9ly0TdQUvfkWpHGkpZDdViUoRgEDyfM4DIpAsbuCEGXg8QDnnYleH/9/xftyOpUr54bNdSfbQVPKmcnnYDP1yRf9Kj0cqF0TurA+LuB3TWyWjWLs4UhoL5bZeufUMUIgO3tvYBA4ush0FeMASVHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931230; c=relaxed/simple;
	bh=CK2U/JermEMYHACHsdxC9InUtu/NVMVm982/i1t1jVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2UNOYL+75UcflhTTVVpQzWzG3HbfapWl+pyozPlZxiAe5F0PrB+JM7PbMJgSF6I/QlPms0JVD8xwzrcTepLlzq3l5jfGUGfQHAKD3QMvhW78+H5b7+wgSG8CDy/9GILmKcJVVJYGorMNrcbN+KdX4kOUGTx2vmWYYWU9K7SLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0wIU5dfl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0wIU5dfl"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675AG4oo440645;
	Wed, 5 Aug 2026 08:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yQ05x
	N2ZwZNucv09JUtBHuEoS53i7zvIPTZSNEq32AQ=; b=0wIU5dflmjbXwLDeLBr9w
	QT2KVJuHnCodCWDnefymwN6YbvWBjuA+V0N8p+wXEJbwFkmtJbUDE9ukdel2eKHn
	q/Q85yVYG1sbIKcSnaHkGJd9oeOsiyl4RazhoH5UQrQXaEhTLrTmAyHDfcyxRLgb
	nEe06hKoTt0UD1o6G3Rcs8tcL3+uZOCGAcGI29de0BMY77njd77EPA0ZI04iFkLn
	ZegZ+KrAeuXf0IHuo0S+fvkbfa+hpvDhBe6Ji/rnxn0FVhjBzSqWkFdOFNE6YxfP
	nNAhj2f1qUChD6RDH7BC6k1d3C7tG1cT/YhrIUU4q5iw1W+AYLFUgGIKdQ3g7Fkb
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fv397ga55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:00:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 675C0Nno016184
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 08:00:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Aug
 2026 08:00:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 08:00:23 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 675C049n000726;
	Wed, 5 Aug 2026 08:00:15 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: accel: adxl367: add support for INT2 interrupt pin
Date: Wed, 5 Aug 2026 14:59:52 +0300
Message-ID: <20260805115952.33894-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115952.33894-1-antoniu.miclaus@analog.com>
References: <20260805115952.33894-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Fivx8x2s7ybzuslydthd1iQlT1cbX-Py
X-Proofpoint-ORIG-GUID: Fivx8x2s7ybzuslydthd1iQlT1cbX-Py
X-Authority-Analysis: v=2.4 cv=Qv5uG1yd c=1 sm=1 tr=0 ts=6a7325d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=WtObvA9HK0rePKymfrAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfX/cBY9wlls1ID
 +4TR6clm3jJ0pMeKFgCcpIdLO0ZMp6r8hGXYILBZqRSuK9vhGKJdfM3hs4lj/HXE4WpkrLtZGpg
 XmmuGyLiL8ON9XNamzy1DZFKvGf2XXfxmD3uUio6tIwTYd3/A/iQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfX8LPaTlf9MpzC
 6ahjoafN21clGs0PCj0F5i1Azzc9ZWY7yFvhUT0DrnUFOBO6mj/o+jxeFmAnX6nhg6g+Am9bc2c
 3myMzvNxsW+ByF3NWOOF4Q649yp+F20ttfYJ9IEBpKmt6YiF7eT671d+ayQtN8Hjy3T3RpUP7pz
 mQJ9qSSmbJ6EWdPSnn2RNNucn823GnsufFgABPKgF1KtArxlqcADw8zmXthSyoIQhHpEq3pBDZY
 uSJAPqFCJcnOiE35Bpvn2ym79y1lG7E9h0gp8ODmBTlXEAu3/FRHS20kzOVl5R1SJZN+KzB0I0t
 zaf1HZ6zzULYsIwLDeCAgj8U7p74o/1b9fbgYEYqejSjs3ma7mZew2wlY3RQXpmHYSyp8kuakcq
 dPn9vIdOtF0/ayeC5FpUaFuxrBluVNILpkSpRs7y80HSR2hba7LeQWMh11Ig4W9AbFSX3ReKmyz
 wYCudCWKbMXoIiFtvkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050095

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
 drivers/iio/accel/adxl367.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 8c3de11a10a3..229974478d10 100644
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
@@ -1426,6 +1430,27 @@ static int adxl367_setup(struct adxl367_state *st)
 	return adxl367_set_measure_en(st, true);
 }
 
+static int adxl367_get_int_line(struct adxl367_state *st, int irq)
+{
+	int int_irq;
+
+	int_irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
+	if (int_irq > 0) {
+		st->int_map_reg = ADXL367_REG_INT1_MAP;
+		return int_irq;
+	}
+
+	int_irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
+	if (int_irq > 0) {
+		st->int_map_reg = ADXL367_REG_INT2_MAP;
+		return int_irq;
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
@@ -1482,6 +1507,8 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	irq = adxl367_get_int_line(st, irq);
+
 	ret = devm_request_threaded_irq(st->dev, irq, NULL,
 					adxl367_irq_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-- 
2.43.0

