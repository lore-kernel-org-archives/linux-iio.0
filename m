Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1537CD32;
	Fri,  6 Mar 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792758; cv=none; b=MWTv0DU1Rsx1YH9qfpkP/gjt3SIyqrh0dS6O1awdi3yioAqCiJzi3Z8TYdmtHJ74CYFD2xsE5mIr1QOUJ6sSKffvPlqIMK5OIWn1Yp6CgLEUhzM2+nlrJUJCaodk299Hx64tYrmOkStxzXevxCu4slLhsT/a+FCskquOXr9awog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792758; c=relaxed/simple;
	bh=1uEQ7V5Zslugz68x+KNuTmlmcSELM0M1byik9KPH7Mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ1GNNaf+mX04BAGHzd3zxdp8m13590Lwz1nQKRfVF3GhVGF20euoA9xP/zW6BSEjJ9F4mXhmpAVuVY/bWAwfvD4/Phf4Cy0FRVlAY+6F7goq509Na+mGJvFiFXltkpIOvxv2SufuXbAWhomxre9ThKpoTd4EMbIE9b+LMFnwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r/p6C8QZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r/p6C8QZ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6266JRjc3330887;
	Fri, 6 Mar 2026 05:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xVYxq
	fXiLj+HbUbaOc3ciyuopxWYtbOl9LWu8NDiKHM=; b=r/p6C8QZf0AHL5xjZjU7J
	+eB1WVxXWRqb4JZcI/kUPPwRwB4/8F8/xtzbuatmtjHH63sOI1QDkkKZY6k4AxN2
	jmrV2v0tOymUdnhm7dC2fRDjKro76REGncbEU1U8edGMmj397K8wpuTP7iz41WqN
	6WExVqaRjimySV5Z/1z8whwtWXunalnrUh+zxA6D1GZ2bDn9R9XG8DDl8qoZOods
	fDRU2OplWyKk8nR3jUx9Xt47RAXiLClOByVnP8YIoCTN0z/SddpIvBE8p2hpUtwu
	OrzgKq0geDUE7jg0uvlDtX/KOVN4D3UNgCAVrE2pxJy9ARt1BJJl/SzeTgfyUocP
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpb6jugmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:25:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626AParR007781
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 05:25:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 05:25:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 05:25:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 05:25:36 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626APG2V003684;
	Fri, 6 Mar 2026 05:25:32 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/4] iio: frequency: ad9523: add dev variable
Date: Fri, 6 Mar 2026 12:24:47 +0200
Message-ID: <20260306102504.42395-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306102504.42395-1-antoniu.miclaus@analog.com>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=69aaaba1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=9Uukg2pZKlto5Ld3BdsA:9
X-Proofpoint-GUID: VAgIifdVLGY56lDD0hLz4AXskDBjW965
X-Proofpoint-ORIG-GUID: VAgIifdVLGY56lDD0hLz4AXskDBjW965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX6XCKfoZpM7YX
 V74yj/mR23X4FnbXCF9opyrlPt0C/v9uBZQZIO3nnumm0zLh9g47Ax6ZKRAx4nqMEp1YyoPVa8Q
 uSVayCeuloY7XFijodbQpcDcROtAIkcoWC0MTiPbBZK+qsmxS05y4eMswsIiR4YlOrmz8qpoh9W
 gEpXssKkKdcRxrhbnKAz20FNXQvRgD1IJYdILvdF87yxTkdXPXXWmiMoZnkJ9rnqJtDgPOQCHkK
 +ryBC3MOjcWk6mktCGt9Vi9B6FU5taCkeAVT0a8GwEjxJk2OHuVF2GTOdr6ZsgGwZi9RGlLmLvc
 1vKI5+zoEQp38zEdZqOVx/YsueC3czI9E1vU4ZCztf7OnY32xowEquUJEUD4V1vldZKg+HLL4E0
 N6b9dCJM+jso8JPyVvCoKimmQzHTgYzdvAm0dbG/6kgAfs4/wYG/IbQ7nVSyQSwCBsyV1zg7dg7
 1j3JMIFuQ88fibyUHzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060099

Introduce a local struct device variable in ad9523_probe() to simplify
subsequent conversions and improve code readability.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/ad9523.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ad32eb66edca..6d15ec648280 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -948,17 +948,18 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 
 static int ad9523_probe(struct spi_device *spi)
 {
-	struct ad9523_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	struct ad9523_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad9523_state *st;
 	int ret;
 
 	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
+		dev_err(dev, "no platform data?\n");
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -966,16 +967,16 @@ static int ad9523_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = devm_regulator_get_enable(&spi->dev, "vcc");
+	ret = devm_regulator_get_enable(dev, "vcc");
 	if (ret)
 		return ret;
 
-	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
+	st->pwrdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
 		GPIOD_OUT_HIGH);
 	if (IS_ERR(st->pwrdown_gpio))
 		return PTR_ERR(st->pwrdown_gpio);
 
-	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+	st->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 		GPIOD_OUT_LOW);
 	if (IS_ERR(st->reset_gpio))
 		return PTR_ERR(st->reset_gpio);
@@ -985,7 +986,7 @@ static int ad9523_probe(struct spi_device *spi)
 		gpiod_direction_output(st->reset_gpio, 1);
 	}
 
-	st->sync_gpio = devm_gpiod_get_optional(&spi->dev, "sync",
+	st->sync_gpio = devm_gpiod_get_optional(dev, "sync",
 		GPIOD_OUT_HIGH);
 	if (IS_ERR(st->sync_gpio))
 		return PTR_ERR(st->sync_gpio);
@@ -1005,7 +1006,7 @@ static int ad9523_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad9523_id[] = {
-- 
2.43.0

