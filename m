Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FA390219;
	Fri, 13 Mar 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403109; cv=none; b=fUloGG+Gk7yRSHnrDER/zp6hB9FDntep21ldFME0SWXiX3cD/Kwjl9TUt5it/U/zB5Kxpt96+RP8J39nHdW+4yMH9D5ioc/0yIezur1EUAgCcBsQEQFgiEgL6KnpXye6aGSMpEJI9gTf3S0JMllmegQBEzx11l+tioiRdB2/QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403109; c=relaxed/simple;
	bh=NNnshLKY6u1TGyYcvBGCcLvBPlyOb0YU616m7byM7zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti0eImHuaRGOYZRvEbeURezDKmUdaSyfC44ZlIFrgDIL+hcRmCUIQUy09mPH7cFhWHaW90zcs/n4NRAX0e9vhNyeu5LCA5iZ7FwHvutyO6uin4+Y4JhMZnxF8o3dGC2CxPeHVqoWnJQ0OdWnxs7gR3Xg+hflE8nnR4clK9QI9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kbu8eVg9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kbu8eVg9"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAoOjt030390;
	Fri, 13 Mar 2026 07:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eXJda
	/axdJpJzhg6SFmA4F1jJINnWt9MTr4qc328EgA=; b=kbu8eVg9vojrQq4L/CZ4l
	oL/nPUO3gnn5XlHaanDFKh70VfYLgDn9aSNFcWFPLnxyBOvYXgtUZeUiytfoCYjI
	sdWAzDOcEfiLwfHElhnc/gqIrLO88jCKQAyQsBYfQFCOLApqBhCk+Hz3HS557n4x
	XWbknGt7uqEQLNwzKfydHe0pQHqVNarL0QsI/nW6eCDgdnQVo39NcmQdHGQS9/dd
	65JWxdrYljXonvkh6vQYVRNqtLXhjUsJQmUzU5+fjlQC0H7LONClW15x1Ps+tIoS
	FVSDMOTD2Tv27uBaWcYP0ctu0JLXQSiG+ZLjAsLEz8qN3mU889WcNp6xwYkjKikF
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh766yjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:58:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBwD0o017538
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:58:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:58:13 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBvrv3024538;
	Fri, 13 Mar 2026 07:58:05 -0400
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
Subject: [PATCH v2 3/4] iio: frequency: ad9523: add dev variable
Date: Fri, 13 Mar 2026 13:57:43 +0200
Message-ID: <cdb7e229a137c24727bbf201a725f5634a34bfe0.1773050333.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773050333.git.antoniu.miclaus@analog.com>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9-apH99X-UQ9-bNXGy-0v_6ZKAPamln3
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b3fbd6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=9Uukg2pZKlto5Ld3BdsA:9
X-Proofpoint-GUID: 9-apH99X-UQ9-bNXGy-0v_6ZKAPamln3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX3q5lYXrc0GVg
 BfGhcaKjIdPfX1Q0A9d8SWsA+CrsJ67wpqNt6GAmLE0srfwy0pVBzGx0Ni44kXoO9rGEbze4X1Z
 ENs1f0JmO/HQr0nti5nPoYOk3vYmd0Uwgk7ubZw3LaAEAf76RrwoatwNt/9JnRQoFlWW1k1Ct9m
 1G7BbqXO508Eak4jBowZqF3TmRFLr9tyO38CsnfPfy4TC82iyWruzbvleJeWv7yhkrg0wIjHUiA
 th9O+qfq5PTj7DLBJM+VucAhzTqWaPrPB06c2IjXScXozC5x1219k7imrdbWpg8qwOWOsUNmF9T
 0Xir+RWlt98u/lABBMuw8PDDwvrlVQAB26eKcYvM20I9UHWPj9DHzK/WsWyWhsV7P8H/d1u49Q7
 ADC2Y/Wj1TOE/xb3CBPsPUzUJX6Q9wl66jSpC6bf638AO/rJjgD2/hBbbDNMT3p+YJEf46VeUfT
 KuX927GAmtdDThURUTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095

Introduce a local struct device variable in ad9523_probe() to simplify
subsequent conversions and improve code readability.

Split pdata declaration and assignment since the result is validated
immediately after.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Split pdata declaration and assignment
  - Leave dev_err(&spi->dev, ...) untouched, let patch 4 handle
    the full dev_err_probe(dev, ...) conversion

 drivers/iio/frequency/ad9523.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ad32eb66edca..f4e80ea0c6d2 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -948,17 +948,19 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 
 static int ad9523_probe(struct spi_device *spi)
 {
-	struct ad9523_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	struct ad9523_platform_data *pdata;
 	struct iio_dev *indio_dev;
 	struct ad9523_state *st;
 	int ret;
 
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data?\n");
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -966,16 +968,16 @@ static int ad9523_probe(struct spi_device *spi)
 
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
@@ -985,7 +987,7 @@ static int ad9523_probe(struct spi_device *spi)
 		gpiod_direction_output(st->reset_gpio, 1);
 	}
 
-	st->sync_gpio = devm_gpiod_get_optional(&spi->dev, "sync",
+	st->sync_gpio = devm_gpiod_get_optional(dev, "sync",
 		GPIOD_OUT_HIGH);
 	if (IS_ERR(st->sync_gpio))
 		return PTR_ERR(st->sync_gpio);
@@ -1005,7 +1007,7 @@ static int ad9523_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad9523_id[] = {
-- 
2.43.0

