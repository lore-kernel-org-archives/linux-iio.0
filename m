Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9B423A71;
	Fri, 27 Feb 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200955; cv=none; b=lSeT3sAaI/sOYi0RxUSKpuV3y9braZaEodjBfxmw6IvWYHfp0LbaVRdgmP/P4yETtW12nra1N1WZNQlCu5DT1DdyXXRzquip+kT37W23bB7auIO7GK/mqsLzNEJwkKNaX46SgoKG2iH4lzF/WSdNsH0H7lHCE+VEGjLUY4Sk7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200955; c=relaxed/simple;
	bh=Ruhb8t/iOGzwzF35KttoSKS0HZERoy3mKtVzcFYC4pI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXkIWGl+iQ22D6uf3k/vCW66G4hpq2Foerci634+4gaKagzDfPlBIBvHQHifCcYUk6M90pECUB15zfY2NyA8ZjQtSKxz28fGUW0tWYhcR02pe49/bF4/d7vRTUa4UlIqxrvzRxhle1lpNiIXppeuEV+nZcbXtMbwqNOjJMdWmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ikrqO71t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ikrqO71t"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RACUXx2502285;
	Fri, 27 Feb 2026 09:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nmuHg
	0A99dItASrXa3p/fn2EKC6ScvBKqKNPrB4uYIk=; b=ikrqO71t+C9DE0XkC3fhK
	VbzuM48qEIZluhYaYeeCNxlqWIzoSxoVKIqZ4RQM8InBd6Zx/jr5jH7xxrQBQgs3
	aJggsG/CgAhPrGi3bE0SaG6cm6QSQEglgvb+IEtoKVJ1G9e5Oaups6K7e4QzPe9E
	O640QZ+Dcs7MN6q3ZrysUHvYYR9xYf2Xa6vOW6BAoVrqxoaRUOAIpAqkIqiLvPOz
	JSvg2Z9erndblEye4hB1qiiZ2oKACZSyqXrw4QS2HSM+MBZnDu3eCi8t04Ocp1yr
	zsW6iFtly4TJf4gC9UlgYuK4YBy8bXqZdYtYj4SCerPo+4FXpyVrDPHsKiLZYRae
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cjbw3yk78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2E8o064799
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3p001982;
	Fri, 27 Feb 2026 09:02:08 -0500
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
Subject: [PATCH v4 03/12] iio: frequency: admv1014: add dev variable
Date: Fri, 27 Feb 2026 16:01:32 +0200
Message-ID: <20260227140152.77529-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXyrBjCwSFknJT
 PJlfH1fycGU/R97NUgTCcsWivg9rObtJRao6Uh7LgyJ47XpdNHYSzPEQXeTl8OPH4jE1KZkZ2B3
 mFxo6H4My9sD1cAq5HMBZmQvjlt4C6/rvXe8g721gZqQbI3JHIocOivo4w+AY0x+LdKXTF4mN4D
 YgI7OUWpoVc/ewGFX05pY3H2UPKkLcEYd5IUpF4nD63wVSz4BA/bQNe0LKSfCVW/QBlpvBC0MUE
 rgpPI9e+kMliJdR8xgwQHNnTJ7Z77y75ZoOI2RXqQg0y2NHuTrnHAbpjsUucA/QDqXwsfOvd3/O
 H84PYkaZHH8SsEIokDCoIkWEM4mjT4a1DVhM3O6N55Ff3z9yJ9g09J5rMnOED1+e4setJcDhQHN
 +yo11uwssLObxSkYKVu1pybNl4RR/+7JJILUxCExU/hEzTZc4U1pnjhGEHgKPPedrZR7W8+4oBZ
 PpjSXqPTiIFioMwvmEg==
X-Authority-Analysis: v=2.4 cv=AtXjHe9P c=1 sm=1 tr=0 ts=69a1a3e8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=s4zbWEo9eQHfHvupQDMA:9
X-Proofpoint-ORIG-GUID: 8cw4LSooDIY5fcRU11mkEs8XHBMZjMe4
X-Proofpoint-GUID: 8cw4LSooDIY5fcRU11mkEs8XHBMZjMe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 7a8f92ec80a2..f829c4595df3 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -610,6 +610,7 @@ static int admv1014_init(struct admv1014_state *st)
 {
 	unsigned int chip_id, enable_reg, enable_reg_msk;
 	struct spi_device *spi = st->spi;
+	struct device *dev = &spi->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
@@ -618,7 +619,7 @@ static int admv1014_init(struct admv1014_state *st)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->regulators);
+	ret = devm_add_action_or_reset(dev, admv1014_reg_disable, st->regulators);
 	if (ret)
 		return ret;
 
@@ -626,16 +627,16 @@ static int admv1014_init(struct admv1014_state *st)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
+	ret = devm_add_action_or_reset(dev, admv1014_clk_disable, st->clkin);
 	if (ret)
 		return ret;
 
 	st->nb.notifier_call = admv1014_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
+	ret = devm_add_action_or_reset(dev, admv1014_powerdown, st);
 	if (ret)
 		return ret;
 
@@ -712,13 +713,14 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 {
 	unsigned int i;
 	struct spi_device *spi = st->spi;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
+	st->p1db_comp = device_property_read_bool(dev, "adi,p1db-compensation-enable");
 
-	ret = device_property_match_property_string(&spi->dev, "adi,input-mode",
+	ret = device_property_match_property_string(dev, "adi,input-mode",
 						    input_mode_names,
 						    ARRAY_SIZE(input_mode_names));
 	if (ret >= 0)
@@ -726,7 +728,7 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	else
 		st->input_mode = ADMV1014_IQ_MODE;
 
-	ret = device_property_match_property_string(&spi->dev, "adi,quad-se-mode",
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
 						    quad_se_mode_names,
 						    ARRAY_SIZE(quad_se_mode_names));
 	if (ret >= 0)
@@ -737,16 +739,16 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	for (i = 0; i < ADMV1014_NUM_REGULATORS; ++i)
 		st->regulators[i].supply = admv1014_reg_name[i];
 
-	ret = devm_regulator_bulk_get(&st->spi->dev, ADMV1014_NUM_REGULATORS,
+	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to request regulators");
 		return ret;
 	}
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	return 0;
@@ -756,9 +758,10 @@ static int admv1014_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1014_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -787,7 +790,7 @@ static int admv1014_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1014_id[] = {
-- 
2.43.0

