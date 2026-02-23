Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BB1A9FA8;
	Mon, 23 Feb 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852516; cv=none; b=qUAPOIeHG6fYtl4H39QgQSs+c82uAD4+bO8dVTTKw/4HlfEr9nEHBFog7hNTmqhnvWZEUGyn0KmLe+irfatWD+s7BJ3G8KPSwDFOUK2ZJqnfCdM9QxvIy7YwVBH4Uxu8YTnMacRTkoUTn3X0aUAHgcIyyxDHT6iwLmvk6OxGWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852516; c=relaxed/simple;
	bh=0NDMZ0guBQkdGSQJjwXkzesTGiCfDQd8YSxGTzs+OSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAeytK5+XyD9SZCqInL2PAUR0St4ektNNCSl7LZBlFz+DVavXYmkbAKgczDuYLBDzmOO6Mi9ajlO2zKCHJeEuuiva5z+dHWec58xkJ1bnSCw+gnjR6d9/3NWHfbJV7WNTkJnCo9oLda6UYhLSTg5PZnPdznv57nw3kUDLsZ/Dy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BdCk2+11; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BdCk2+11"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6gebo2668062;
	Mon, 23 Feb 2026 08:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7NB7g
	Jk60goleya4WTN0G6xyz/+UgYn4umNGueq5I0c=; b=BdCk2+113uc+coUBTus3D
	d0Ulkk1Toh353K6yKk+UvFY8w6QZIiN35QXoJ+scmhhmSnFoEcCKE9ikkZsy8c+u
	S/h8AjbtQbXUK6JRwKXEy9C3vmdTURXQI5zWOo8Q5cpIDNGO4tdeIyFV4DxYOOkF
	7U2XCIEFPg0sWsVjwJEqU7Qey1LPGjsLuZ7xJcgWN2vuVFJfmiJS1vryoU5RQILZ
	d9+bKq57zSfYRTusKvJvDGVqZimUtQAFsWS/5/mOqFm4l4fyvMzHGxklcJfT3wg+
	K/zGB/dVwmo8npOBrGLlw7TJQ0nqPjuNqVCHjGadRqtbgkadfuuJtZ7mx4B7NpIA
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbb12w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:15:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDExSZ009776
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:59 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:59 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXf006594;
	Mon, 23 Feb 2026 08:14:53 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/12] iio: dac: ad7293: introduce struct device variable
Date: Mon, 23 Feb 2026 15:14:00 +0200
Message-ID: <20260223131418.55414-10-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LH6buICk24YikVxMT7GGHmkeBS8cteO6
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c52d4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=vjhhOmsZBZqeCypw3Y8A:9
X-Proofpoint-ORIG-GUID: LH6buICk24YikVxMT7GGHmkeBS8cteO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX20fifIyWHglw
 DfbWcvDEkeMrW/2t+PxAWQex7ZKcwRngE8wnmWdO8JBtNJX9dcwiaiUm06dMuwSkieq/G303IcY
 8Z9pgHFNztfa3D0EOiacD/aaHrkSOhb5cQOq7CHZDzU/kn16+0/pbcyYYDnDImzRbKjWeuVhWXQ
 YeT6g/G/ewySGnZ0v8PNXkT2oc15Se93FK0WO35ku7l96W/Np1mXdlWm8QJwTs84HQ943TZ2XX3
 2IYgTgGn++rEHm3vBhzEv9u3Jp6queS1k5crU03MrUP24zhWpfnbsDjIMk6ZVk5/DvRUYJgeY97
 /lAUgiEGM3mQyUlF/ebKD1LHCM2XObOaVGN+qvKO+1sdFVE4XZDueliEey1ExVOsfSF9s9eFftj
 8nX8cdVsd81X9A1P9hVaRt1DHEW/G0decXdVaT4hYDyKZVKsIVCZWdynizUPxYMjEPWdsDky7vX
 JaxbZgSReV6vIrE7b1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Add struct device *dev local variable to simplify repeated &spi->dev
dereferences. Where spi is no longer needed beyond &spi->dev, replace
struct spi_device *spi with struct device *dev = &st->spi->dev.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad7293.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index c3797e40cdd9..0168d111ecbc 100644
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
@@ -806,7 +806,7 @@ static int ad7293_init(struct ad7293_state *st)
 {
 	int ret;
 	u16 chip_id;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	ret = ad7293_properties_parse(st);
 	if (ret)
@@ -822,7 +822,7 @@ static int ad7293_init(struct ad7293_state *st)
 		return ret;
 
 	if (chip_id != AD7293_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
+		dev_err(dev, "Invalid Chip ID.\n");
 		return -EINVAL;
 	}
 
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

