Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6A42882C;
	Fri, 27 Feb 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200972; cv=none; b=Wx+5+MU9QecB+QwymFCgbPOE2qxR+BfyvJ8e7twO2truCzOumQzTVaBYsujiuk6N2fq0UR0z9tnHb6XN5Vw3GSsJclosnX851vtyQh8n6QFLcrYW5SOQq44R/0QYvaa2VFepF0BJ6QHpDMXn/bApiwCxFpb/Kmr6WnZEgQ8BDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200972; c=relaxed/simple;
	bh=VzB/StMLYqZx0HzaIcYdtM4PC/90ggm4BLWNAJbB1hw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZzI0Hp1pSqd53UKRXBr2bDXvEyc3JJCTFWm/Dr7Hhx4RnDcjB3MT0xjLQ8As+p0nJHodAuH9FyF5u8cUtLzUASyIVpGI/vFmtzNHoxx3V10phyhfl81+JvGUwwz3X/pxWAvUdp0I2dM4Y90VfcfPP4Ip7KiUq4nyuLNE7i9CYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0uHmPsVy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0uHmPsVy"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RAjOCk3025355;
	Fri, 27 Feb 2026 09:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+RqHD
	q+WGBPm9NgDUB1HFwT8z3xzNPx2sOpi1JO9g5E=; b=0uHmPsVyA7cAdKKfSuKir
	U0uRkqtO0ByyVlk+P4hAeCZ6okAqVQA54+RPQcltpJ1CoDwD4Y0N8bKnSo90hWR6
	xHYsR9iqb53Uku3AX8yr+Cl5NQN2jTlUucy3kJqnwl9Zf7OOejYDTXMIXBbm52A1
	hEUwF96pDDLVEHuuDJauyGfcSPeKu9f/gy1WBqsPP4SVGEbdRV9KEyjU8sHstMCr
	I/Wb0KJc4TCvj8eTnB+m4ljggnsJhdzX0B8Pn44aC9zMwidCu8PONGekt/b9kYb0
	UMIpK1oxEJ5gomPg9vyme0t14J+7U+oMZAlgrCATUnnBj4zA2+/VItK7V47zu9Id
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdgc05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:29 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2SDQ064844
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:28 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:28 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3v001982;
	Fri, 27 Feb 2026 09:02:22 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/12] iio: dac: ad7293: add dev variable
Date: Fri, 27 Feb 2026 16:01:38 +0200
Message-ID: <20260227140152.77529-10-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227140152.77529-1-antoniu.miclaus@analog.com>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a1a3f5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=ZsvJIcEP_zl-ui44aFkA:9
X-Proofpoint-GUID: eoj_XUvlWf8fwzZTEHv9Lj42jMq7MfsQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfX/Mo0GNeNoWp4
 sg7xfo823mHJt17EifuqQ5kcNWRwBgLL734+s3jGAFiiC3ukd5J6+yHORoXEtjjOCktX8IJwM/z
 /FRBUQ+zNQPVW8NY9yPLwaxkqS3BhrG1E0D+8XcOsc4eCDl83FW+wtrg5uLuPlPHQ1vPU75wP7c
 AXeat+wweHzD9B1ofs0aJ4C6xrge8o5lmdjQFlGWMOL0DI/AxIqA+S25BVEDNDB8+rb7kH9Fger
 AX8+Q40DBYnr+A/6Xaby1KjU9A8VJFvODlkfR3IieHQFM3eF+GyJc4QmMMYxL687QVn2fKqrKYb
 UIF3Jll2UDcsKprYJun/LrAdhbmR+TOaLIk+GsDt0R07nhYF1PmVZ+JSWpdDzFziZYbiqmCmkVY
 xZjXnCTiZbwWakr0388d3P+r8y4FvXdAh01nUN44DTYhcJ9Ish5iKOZ3Xq2/y76l4iOIxaOhg4y
 SfGfsQMVfHtBk/4W6Zw==
X-Proofpoint-ORIG-GUID: eoj_XUvlWf8fwzZTEHv9Lj42jMq7MfsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad7293.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index c3797e40cdd9..c86c54d53df1 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -776,27 +776,27 @@ static int ad7293_reset(struct ad7293_state *st)
 
 static int ad7293_properties_parse(struct ad7293_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
-	ret = devm_regulator_get_enable(&spi->dev, "avdd");
+	ret = devm_regulator_get_enable(dev, "avdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD\n");
+		return dev_err_probe(dev, ret, "failed to enable AVDD\n");
 
-	ret = devm_regulator_get_enable(&spi->dev, "vdrive");
+	ret = devm_regulator_get_enable(dev, "vdrive");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "failed to enable VDRIVE\n");
+		return dev_err_probe(dev, ret, "failed to enable VDRIVE\n");
 
-	ret = devm_regulator_get_enable_optional(&spi->dev, "vrefin");
+	ret = devm_regulator_get_enable_optional(dev, "vrefin");
 	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(&spi->dev, ret, "failed to enable VREFIN\n");
+		return dev_err_probe(dev, ret, "failed to enable VREFIN\n");
 
 	st->vrefin_en = ret != -ENODEV;
 
-	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+	st->gpio_reset = devm_gpiod_get_optional(dev, "reset",
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(st->gpio_reset))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
+		return dev_err_probe(dev, PTR_ERR(st->gpio_reset),
 				     "failed to get the reset GPIO\n");
 
 	return 0;
@@ -845,9 +845,10 @@ static int ad7293_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad7293_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -867,7 +868,7 @@ static int ad7293_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7293_id[] = {
-- 
2.43.0

