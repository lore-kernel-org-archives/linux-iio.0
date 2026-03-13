Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185B388364;
	Fri, 13 Mar 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402984; cv=none; b=Upd3yjGzPRD/Cul7x7svv/O393z/Y5eh5dqv8W8KXFSnGm0D8EzJrQr1bjw+REyJF/RWyHFw5mTHBCn3GzeixgX1vF6zAwzvB0X5ixbv88S2J9ObjUaJpydc+xGCJbYazgEdZAZF5Ag4QpREZ5d+u69eJRMtpQa3BR2ecVrbxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402984; c=relaxed/simple;
	bh=T6SOAijDdHQefwqWMKk3hYm3BRAFM7t1vreAzolrlPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWRS4aTI5zLifO6KV90UrG8Ip9hwUvQFcy8yOsV2IPD20SIh13UZEFyMiU7H/xHE8b1zmnHRqe106X6IZoUFAehPGaInNalzis/S+B90QIuwohhLoc4NRz/zlfQECE6JDmpwlW/1oXPN9QijYIpYanwFDSEVj7jb1jfZjC+zJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0r93L5n+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0r93L5n+"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAKSnp2907096;
	Fri, 13 Mar 2026 07:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CTimU
	rIQ3EEOtkBqfKe1xU8DhCXUP8rz/sxq/FCwHsc=; b=0r93L5n+MmX+auj3X1LAX
	FvAqU7616YhW4phey8k33jTX9pBq871qeJQhnI3LuaTRi6nsZsO7WphT2BUsP+be
	/BYKJgGU9Rm2rcCVw93y/OMCGNUvVTBibH9KJABTDhKaSKh9b/9pBYQDzfC6X+ey
	UiGVhIiiJVe98stiqPvh+U24CA4cROUEzUG3kX1vvBXZ2dXovTdc3NX5lh5PT6dR
	wYObwfMV7cPFa2w7qlFgIqeK2frTfqRI/gtXOsgvKRl9uIb8H+ZF06X92qd0HgTC
	1Qa7HZaB1XwqdRIUwIaSQ646sgxKJluhWD6ly3j5zxNtcM8abhgonCfQrrN+LXlV
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh50xyry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:56:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBu1Dw017351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:56:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:56:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:56:01 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBtTxK024500;
	Fri, 13 Mar 2026 07:55:56 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre
 Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 3/4] iio: accel: adxl372: factor out buffer and trigger setup
Date: Fri, 13 Mar 2026 13:54:56 +0200
Message-ID: <20260313115525.85435-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115525.85435-1-antoniu.miclaus@analog.com>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69b3fb53 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=zUiE2f8s4BErrht2hr8A:9
X-Proofpoint-ORIG-GUID: SJ0-ij3dsNMft1BAuTc4P2KDoKibmWlZ
X-Proofpoint-GUID: SJ0-ij3dsNMft1BAuTc4P2KDoKibmWlZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NCBTYWx0ZWRfX5SIPiiFUriOl
 6dMa10a4xDdIMtg1ED+rzUY848QcxNwt7fuYlMcFAI0NvEtY8D13JwQ0D0yvA7Z8y25vbuDgkML
 K0oEEpJemRT/LOR2eWyv9GTy0M/Z/oiirisv1G1ZKgZ8OHCY+6aSpzz+D76Fdic6hV6H8P/r6/a
 zkh0BbtmFa10kGvLjcpi3/PHxw/R1da9yN8XL3UBp62ySD0OsjAMvtEUcgoszgEBicHGNjczdmk
 M53lkwcFhptShp7RT9y1pTWOMMzkBFc6UMuJ8Uhj15AFXXEggMEn8jOj5dCBxIBpoRCxik26Rln
 QVGJmCiw6ysFqC9xGsqQOZDuIOBvlK1cm9U4ZHrtCS2KIkOX2RB9T783fM9c2cC+qpWbjbjoB7E
 lNhI7fbkj6N1gCUiUUdM4HARN6ISfXJgWDukDptcmzg5QvElRQvTXL3vTNrfFRVrWSWnsMjYbTZ
 nAX27HqVaUg6TJd9TtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130094

Extract the triggered buffer, trigger allocation, and IRQ request
logic from adxl372_probe() into a dedicated adxl372_buffer_setup()
helper. This reduces the probe function complexity and prepares for
conditionally disabling buffer support on device variants with
known FIFO issues.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - None.

Changes in v2:
 - Use adxl372_buffer_setup() helper instead of inlining buffer/trigger
   conditional logic in probe.

 drivers/iio/accel/adxl372.c | 94 ++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index d7c580bc9e49..b1d611619e16 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1192,6 +1192,56 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, "IIO_ADXL372");
 
+static int adxl372_buffer_setup(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	struct device *dev = st->dev;
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup_ext(dev,
+						  indio_dev, NULL,
+						  adxl372_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &adxl372_buffer_ops,
+						  adxl372_fifo_attributes);
+	if (ret < 0)
+		return ret;
+
+	if (!st->irq)
+		return 0;
+
+	st->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						 indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!st->dready_trig)
+		return -ENOMEM;
+
+	st->peak_datardy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-peak",
+							indio_dev->name,
+							iio_device_id(indio_dev));
+	if (!st->peak_datardy_trig)
+		return -ENOMEM;
+
+	st->dready_trig->ops = &adxl372_trigger_ops;
+	st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
+	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+	iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
+	ret = devm_iio_trigger_register(dev, st->dready_trig);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+	return devm_request_irq(dev, st->irq,
+				iio_trigger_generic_data_rdy_poll,
+				IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				indio_dev->name, st->dready_trig);
+}
+
 int adxl372_probe(struct device *dev, struct regmap *regmap,
 		  int irq, const struct adxl372_chip_info *chip_info)
 {
@@ -1226,52 +1276,10 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup_ext(dev,
-						  indio_dev, NULL,
-						  adxl372_trigger_handler,
-						  IIO_BUFFER_DIRECTION_IN,
-						  &adxl372_buffer_ops,
-						  adxl372_fifo_attributes);
+	ret = adxl372_buffer_setup(indio_dev);
 	if (ret < 0)
 		return ret;
 
-	if (st->irq) {
-		st->dready_trig = devm_iio_trigger_alloc(dev,
-							 "%s-dev%d",
-							 indio_dev->name,
-							 iio_device_id(indio_dev));
-		if (st->dready_trig == NULL)
-			return -ENOMEM;
-
-		st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
-							       "%s-dev%d-peak",
-							       indio_dev->name,
-							       iio_device_id(indio_dev));
-		if (!st->peak_datardy_trig)
-			return -ENOMEM;
-
-		st->dready_trig->ops = &adxl372_trigger_ops;
-		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
-		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
-		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
-		ret = devm_iio_trigger_register(dev, st->dready_trig);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
-		if (ret < 0)
-			return ret;
-
-		indio_dev->trig = iio_trigger_get(st->dready_trig);
-
-		ret = devm_request_irq(dev, st->irq,
-				       iio_trigger_generic_data_rdy_poll,
-				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-				       indio_dev->name, st->dready_trig);
-		if (ret < 0)
-			return ret;
-	}
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl372_probe, "IIO_ADXL372");
-- 
2.43.0

