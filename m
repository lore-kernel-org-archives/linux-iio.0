Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618863D3D1D;
	Wed, 25 Feb 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032036; cv=none; b=bTUkEdsGKuVTKpW4m526J1OUPslggmIX/846X+NtZDsQblfi2LVmtPJ7rzpSjfcFswPNhTiFONEi+0Al3aPyZoJ3PynUYM23J0WFFei3alJZMbzyr3BCMKugigOjUSlByYwM/aaDvJpz9042+WpCmT/xknD5rRmw/Q481MF3OqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032036; c=relaxed/simple;
	bh=KRDNRb2BAHdXtY0aDAMnW8b/HaBxSBxAG/fC1JMttKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doC3bm9lKyYKMTcHg961ru9LuTXrO4YbZwfUGsirJHIdMXK5hKnHWU6ityHcj2JStstCp05oQnqwApVbnBdcqSTd4bpw7ZR6kndrTneO45yCVa6tjJrZl1AgFSRVwIx3ISb9TwB7BxSzzzJN6BClYQiEwQwOOBDm/ufKoECavXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BWBvRr1h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BWBvRr1h"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDbllg1869414;
	Wed, 25 Feb 2026 10:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5u/z2
	X2L+n4xOsvqMLSOQ/NAvDV17Wr6dYVILyZ10kU=; b=BWBvRr1hXABxRadUnmYeQ
	9B15AsCxL6myu1YN0gV9CPlNdUJxWyPb3597HpWcSKci6Giu/aucAjs0QeCZJ4M9
	iXjI3H9eUpFO3cOJV/3tiySX9xLnRlBodlqyrPc+EL+SyShrVH/VVrTqs43NGoBS
	QfFbBNvJFU6LmcClpsR2FrWGZxVVqV9Af34diFonnHUgBd4KyEZpZPR8WdNBYnZ7
	+xuBh9v67NjiZTo3D+GmqHZCcJPsSxFJHOLeauijiNtiRX1Aw9JOiQPeFXIsN+em
	8PSS+OlwxlsmRf44fXGs00MnvHuNQ/10C17mVjJhCGe8/hEIb8Um4TPxrGmrVqYT
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4chvwg1gjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:06:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF6wdq024663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:06:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 25 Feb
 2026 10:06:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:06:58 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Ynt006794;
	Wed, 25 Feb 2026 10:06:54 -0500
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
Subject: [PATCH v3 5/6] iio: dac: ad7293: add dev variable and use dev_err_probe
Date: Wed, 25 Feb 2026 17:05:51 +0200
Message-ID: <20260225150615.274078-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225150615.274078-1-antoniu.miclaus@analog.com>
References: <20260225150615.274078-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Dcgaa/tW c=1 sm=1 tr=0 ts=699f1013 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=BWbAnXfCx2Sueti_qTsA:9
X-Proofpoint-GUID: pLdgnEeI89VbP8rSix6R1EYEXnPzeYcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfX/XM20VjPW9VH
 JtslpJDH98PkI6qXYwz3fbc94g6YojurHwAb/++KKKixoIX7yu7ilCbykljSHKADFDd9HDO0EyU
 6QFC2ba83zBU8ExKe7VBTrP8ChAOmUpM2ztp2ZBkGXxwjoFKH9ylZtsJLvDglOONE18ydyNpoi5
 PeK15bar0DW06klRjoJrk5PLodN37wnYNPr6xE45DoB1VdEvVJb3euSu3VwkRg0nTeJYUomEQp9
 gO2BlBW9fU0xsvpBq1MGJsp7mimOYrfAe8H2omwc7aMaWBDP174fcLXB8ex3hrn37+ZHR27E/C5
 WUfDa72PlA2JUqxZVMsDYWRADddnRqxz3XuhXtP/Sc1eZ3lSep1xlE8HgkSAaSN+LNReh8lCZi4
 mUHCSW7tO/d0wP2AyaCHMi09hUZFTYnOyt249eBl5h6uv37uIIFmreQMYaU8wnBZq8s5Gz0lFhJ
 zWHB8OdXfRXURYh5+vg==
X-Proofpoint-ORIG-GUID: pLdgnEeI89VbP8rSix6R1EYEXnPzeYcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250145

Introduce a struct device *dev local variable and replace dev_err() +
return with dev_err_probe() in functions that use devm_ managed
resources. This simplifies error handling and ensures proper logging
of deferred probes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad7293.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index c3797e40cdd9..e26cc36e9270 100644
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
@@ -821,10 +821,9 @@ static int ad7293_init(struct ad7293_state *st)
 	if (ret)
 		return ret;
 
-	if (chip_id != AD7293_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != AD7293_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid Chip ID.\n");
 
 	if (!st->vrefin_en)
 		return __ad7293_spi_update_bits(st, AD7293_REG_GENERAL,
@@ -845,9 +844,10 @@ static int ad7293_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad7293_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -867,7 +867,7 @@ static int ad7293_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7293_id[] = {
-- 
2.43.0

