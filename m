Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3583314D1D;
	Sat, 21 Mar 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087725; cv=none; b=iOW3HNwbeIO17POmUhigiCLXA1VIcrnL3uffjXpNMChrjTXxBaS5UAN15HtzyilFqOtkr6uMLO+QThuMRiE64MS57m7WshT593MlJBrtnbyhOHjnMwzUZBgs9Hwg25YWHkAvH8+3kjeAJa0Yx55a3LmfZbBa1CIPRQfEa/TYC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087725; c=relaxed/simple;
	bh=PXIAjV6TNOqf1YlNvj8J4ZYc2hdy6syhVEVZ0ilOMPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cailaRvYAeXw4iJOwEI4ktq8ehZUX8zLhCDTo89fcfWdtGFW2CiLRMh2zjj9OWoKggh+m+B1cfom5rKjFjhDY6L/PZw3kBWxWyS5TJYuuYJsO1JXoOCSELtRezjMWPrgV720U0/Ucp0wp7dD+T74wOh9B55+VS+m8AJpQSIydaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uSMMIj1Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uSMMIj1Y"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L5Pg8Q662639;
	Sat, 21 Mar 2026 06:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+19c4
	6oLM+Anx6FSPxobkowKICKg+PxSi8kOK3q7Uow=; b=uSMMIj1YuiOWnvaUYglOX
	/PUBjdfEtJbbuAlabwmH1fEnpJp3scRG3aAIyZ5xAVCZMCStDDDVDkbk/3o7aBIG
	iHg7lPPEzKfK8lLyvbYLYlYrFxbQ5rba8Cok7rLeSNQb1Ld1Lr1uA088O2y1lYfb
	TH/ooavbXukOOG79JTYvoJf+I/nFjKWS7hAZW9oJxlRUQhXKVN38R0FnL4ZLvdb4
	v0EeDi22qWXo0qfKQ/mJPYyZVOih0gubkiCzTvU0kzg4601ZIbiwapPzyBc0sVM/
	yUkFhzzwOR66VdM5esObMBnnYUukoUqi0nz6t+/lVpkA1cZg1E+IhHPSykve8uMp
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n61rjke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:08:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA8LXC041665
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:08:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:08:20 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA7nOL016475;
	Sat, 21 Mar 2026 06:08:13 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] iio: accel: adxl372: factor out buffer and trigger setup
Date: Sat, 21 Mar 2026 12:04:58 +0200
Message-ID: <20260321100729.2440-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321100729.2440-1-antoniu.miclaus@analog.com>
References: <20260321100729.2440-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MiBTYWx0ZWRfX+bL3Lv4ThXJ1
 38l8Fl0s7Z9Eg3cV4OyiZ34MXauUKyIVXWhXhlw4WMmDxBw9gnRG/Bx5wDymLq1d0XAUWyR2A+Q
 BLSPqLbpyPpMkVUNj3bi7S7LhIoitkEyhFvZuxpd51kpt2kgcjd8kyzMyivyFy28B4PiLJrN/qz
 lZbzDGQBsWRiQkSuv149oDXxMHK/+dKxjOzhrgYKbuxUx3RZFA1eDD/c87+HHPnzI2Efh4QxDZL
 opIil5vXm8DbMyfPSjfNMlgTRKP1TRUKcx/8Yx6WNL0JTSYHip3XKvh1aEqYhvhATXfU0nVs988
 lRbr7aOUck7vC3F83Uosgr6ZSTVtOleOeWj9zZrDnWk7ZrU+YOvePDSvHcAke0dNa6P9hooYeqv
 irqvzjpOVwnKZ4f1SOaF33jTbkOEzKR8TLGvI3xaBSpTTVnKOutUPD1aer3Mc2PV2Ro2Sv6kKH7
 zZumA7A3ajgu8bY9yuA==
X-Proofpoint-ORIG-GUID: TlwlX254BHQtollgrmSHkkgbuWLpB4E5
X-Proofpoint-GUID: TlwlX254BHQtollgrmSHkkgbuWLpB4E5
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69be6e16 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=zUiE2f8s4BErrht2hr8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210082

Extract the triggered buffer, trigger allocation, and IRQ request
logic from adxl372_probe() into a dedicated adxl372_buffer_setup()
helper. This reduces the probe function complexity and prepares for
conditionally disabling buffer support on device variants with
known FIFO issues.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
 - Use 'if (ret)' instead of 'if (ret < 0)' for
   devm_iio_trigger_register() and devm_iio_triggered_buffer_setup_ext()
   return checks in adxl372_buffer_setup().

 drivers/iio/accel/adxl372.c | 94 ++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index b34b91cae753..6fd4fe0ec1d9 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1193,6 +1193,56 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
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
+	if (ret)
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
+						       indio_dev->name,
+						       iio_device_id(indio_dev));
+	if (!st->peak_datardy_trig)
+		return -ENOMEM;
+
+	st->dready_trig->ops = &adxl372_trigger_ops;
+	st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
+	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+	iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
+	ret = devm_iio_trigger_register(dev, st->dready_trig);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
+	if (ret)
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
@@ -1227,52 +1277,10 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
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

