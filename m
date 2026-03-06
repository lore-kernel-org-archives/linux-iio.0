Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898A3E95AD;
	Fri,  6 Mar 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811583; cv=none; b=kKfTL5rumDElbjlUKmT3eK3kGfeOOUotq7xjnxaaEereafSBtERcbBDYpr7laLGScqMo8XjRcrurI0TDAvvVMrjBhl1AWLN2ZTnBK5zfF5ADii9rUkU1pnTUfra5irirNpClXCgLHAvNtRf7/oLCMY3Xs791+ns5MciJCGU4+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811583; c=relaxed/simple;
	bh=Q0Iduk8Mlam+E/b26pcOUWQ2Op95T835ttm2lRhfEu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aP/mzpSz4Vhiy0G5yxVWl9R50N+DawvFtqVjx/PbZyyMSgxsJjhmoFZjzGVbEqQ547soxefihx0bX5uw2vvj971hLczCQSC+YkmP4Y+08YM5wQ65AUs0J2gvb4MVDljM4+dCcxRvWnz2KN6tBO8sTyBjWV4IOw2G9Eoy3DtVd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FptPtkar; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FptPtkar"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626C1fGp2756375;
	Fri, 6 Mar 2026 10:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GE1S+
	YpIwUSUq2Y/bZANchyd9r3ntRRSIOGRKDHdayQ=; b=FptPtkar7vyRPs0Roypmo
	7R2MQrfo4iSPUtTigEE4CERuz+Yk+kGiMcY0q+Iw16ORFerHCVR+4xZrBw5tx8eu
	+Yanj8AUlJu893t0QpXI/I3Lu8uxt3qaHGQ/kGJpt2EqZffCxaraWY9yXMUwYGoY
	XVYvzLwFgdcxUUJZaxTwNxSjd5McosXPHDwNnCl0pC7lb4QFXsMjoIIGLz0IJLQ+
	5R/vFN6pKlcr7tqPoBG27e4CYn1P9VSej9YT3t5H30he/9ETAeqQPG2Vm8TPj0Lr
	W4eDEAfgqE6y2zDIFzFDUXPx0ADZtl+ebof547JtmM9x6VPB8jpO38d5dEL9XaX2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6j2cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 10:39:25 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626FdO4k045305
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 10:39:24 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 10:39:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 10:39:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 10:39:24 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626FctKw002837;
	Fri, 6 Mar 2026 10:39:19 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Petre Rodan
	<petre.rodan@subdimension.ro>,
        Jorge Marques <jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] iio: accel: adxl372: factor out buffer and trigger setup
Date: Fri, 6 Mar 2026 17:18:23 +0200
Message-ID: <20260306151859.131934-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151859.131934-1-antoniu.miclaus@analog.com>
References: <20260306151859.131934-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NyBTYWx0ZWRfX9m5IrKo0vPG4
 VtGEfatSuK2xD7mfHFSKMV3azWvcGouR++t0BL1w/CEsVxOslZuWgBOwqRpgc5Owblr5cx7GxWz
 pYBXJnH621adc58CyP+Be4hc561P/zVT5gAqvDhRRxgOOlwjUpGsOsto5ILlsWTD/XgLDeFTj7j
 lN4FXVfr3KrJPd+TzYZdlDPNks7MLLCAJQ/iIn0qAF1WR79phdtYj+3c6fZ5gtGmNoKol/CMRmv
 pfL/fuFit4tYMX35Q7AgyINDJ97fv4XKJJMsloT25lrb8aOfqHmIJNSS0HgvnEsVMsHuSpiYtCh
 vnGH2u2rOwCSbpkGsctjKQDkYMOr0v9iRvVvehry4zjCFjmEw1PrV/mPxwR0wKrsf9n/uQJYoZe
 CLUCNugpgNrNMGI3eOyUR5M0tTXmytINQ5FJ8h2CV7264VQY7nCTrlhOzPSe8zEEseuyN2iMDJR
 XUW0Vvg7fF8cC4rFmAg==
X-Proofpoint-GUID: Vs09Twz-rCRA_rc1c5zdQs-ZGDWUMS9k
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69aaf52d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=zUiE2f8s4BErrht2hr8A:9
X-Proofpoint-ORIG-GUID: Vs09Twz-rCRA_rc1c5zdQs-ZGDWUMS9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060147

Extract the triggered buffer, trigger allocation, and IRQ request
logic from adxl372_probe() into a dedicated adxl372_buffer_setup()
helper. This reduces the probe function complexity and prepares for
conditionally disabling buffer support on device variants with
known FIFO issues.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
New patch in v2.

 drivers/iio/accel/adxl372.c | 94 ++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 6918a5834d74..adb9e42653f1 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1179,6 +1179,56 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
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
@@ -1213,52 +1263,10 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
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

