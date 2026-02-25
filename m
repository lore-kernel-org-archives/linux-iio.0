Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ABE3D5258;
	Wed, 25 Feb 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032038; cv=none; b=SGcxTFv5a2kaKYuu8sTopr9JkrMWgMyQYw3tNUtQF8Qdd5BbaHv9YO356DnKw6faCFeAHsU+vhaFVbVHnumWv8rfa99/CG6x0Ig/4l0YSy4K8svd2+SJ3M3Y/Jr/1igu07uVXmAPbgs8/jd8LBf9434z5BgGvPD6wFo47CrCmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032038; c=relaxed/simple;
	bh=3Wle/4NMS9dUvTddlrz8Abwbv3sDB98Hc0n3VxHRZJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU2SPeUnxgJ478Ya7fYyes+7YYtzsIGkcAJ2oS6cYBAGHkrZ+TLrTWIehujtXJfr6QyO0LT2YxZgK+wCMppPxfaz0zgMgY0cKFgcpC1I3i4zf3YkAaO5GaP+cRq2LeF2qlFHrDMc7sUhxIXf4nEkNXH9XEtwwJ2uWv6yzqdEO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cU3W9Zzp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cU3W9Zzp"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAZ2N6818460;
	Wed, 25 Feb 2026 10:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q5Z8f
	rijDJjPhMFrkOlOcb/yCuimb5QOM2qOM5uGcg4=; b=cU3W9ZzpWoE3Lha9Jyydg
	C964b0ANIt35tRhHe/9fwymRXsnKuGWl30EW8NvuE5uOQ6SC/6FpeSpGKtnG6YbA
	/XT2LQgtWQhfAsGPP3AQq7joXQ1t0qd77QX0Ii9Gfylhhsui4vzh+DDXVyc0KwG7
	GyrS+7PmN/JDjmTQKAHxiRCFzUQHsc95ean9Et7PUau3n4lpmGGTJNd7jvuIdXhD
	WQN9BYInQD7G2juwNf2H+qY2WRGRRzmQGiGbM7RsDC9Fxr+jl80xJqpTVulAhBG0
	pSOAMcrBLYgnOjp0zNLDlYz6YmHKBtiJ+UwOKJoymtzkHh3wynU4o1PXvgo29KJM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p0d54v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:06:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF6m4K024632
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:06:48 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:06:47 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Ynp006794;
	Wed, 25 Feb 2026 10:06:44 -0500
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
Subject: [PATCH v3 1/6] iio: frequency: adrf6780: add dev variable and use dev_err_probe
Date: Wed, 25 Feb 2026 17:05:47 +0200
Message-ID: <20260225150615.274078-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 3Tzh2P8q-tq0lsN-O0w58kd6JZwh7zRu
X-Proofpoint-GUID: 3Tzh2P8q-tq0lsN-O0w58kd6JZwh7zRu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfXzo5Pb8JYtfHc
 wm4LgvYvxtaoBSFq/fj8i1pdGvmYY0ncWsEvnTURWyWd7wj1450w4uioUjqmsrJ4Y35IIlevdd6
 a0he2KyuRlC/OZz1gmfWWx5jhi+e1gdrq1ZBFCLvm/xcmTKuXwkgw7IbmstPJcLfy1EL6UyhxtN
 w3Z2OpZCInYDyzghnTRlvxRNbZ9TEz2e86KnJOc/aWxZHCCbRC5NsSQoMS4/Qgk5uTM4NuV0u9N
 lATiDYa48eyebeb6vutIKxft+AN3WbYauJEZfN3fB4haYcFXx2IIhqPxqm2+doXjhk5CZwaYzxZ
 3yhF/mrQAv0n22qPDz4n4ssneF1zam2iKK/qmrENe4Bvw7fuY+A78KjeUMIBCd1RRObSes0OK8j
 RA4PW76Po2p/+LyPVXjPJuqc+bBWRC4GF3nuyQLXvq78C3xl8TUJfwTGPzsrs42U7RjmvMoa8OD
 hdqf+S9ovhw3RfAfoow==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699f1009 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=bMEtPg1WnvWC4BS4PrsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250145

Introduce a struct device *dev local variable and replace dev_err() +
return with dev_err_probe() in functions that use devm_ managed
resources. This simplifies error handling and ensures proper logging
of deferred probes.

Drop 'SPI' from error messages since the bus type is evident from
the device hierarchy.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 60 +++++++++++++++-----------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index a7a21f929970..be8838ab10fb 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -346,23 +346,21 @@ static const struct iio_chan_spec adrf6780_channels[] = {
 static int adrf6780_reset(struct adrf6780_state *st)
 {
 	int ret;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 software reset failed.\n");
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 software reset disable failed.\n");
 
 	return 0;
 }
@@ -371,7 +369,7 @@ static int adrf6780_init(struct adrf6780_state *st)
 {
 	int ret;
 	unsigned int chip_id, enable_reg, enable_reg_msk;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	/* Perform a software reset */
 	ret = adrf6780_reset(st);
@@ -383,10 +381,9 @@ static int adrf6780_init(struct adrf6780_state *st)
 		return ret;
 
 	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADRF6780_CHIP_ID) {
-		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADRF6780_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "ADRF6780 Invalid Chip ID.\n");
 
 	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
 			ADRF6780_DETECTOR_EN_MSK |
@@ -426,18 +423,18 @@ static int adrf6780_init(struct adrf6780_state *st)
 
 static void adrf6780_properties_parse(struct adrf6780_state *st)
 {
-	struct spi_device *spi = st->spi;
-
-	st->vga_buff_en = device_property_read_bool(&spi->dev, "adi,vga-buff-en");
-	st->lo_buff_en = device_property_read_bool(&spi->dev, "adi,lo-buff-en");
-	st->if_mode_en = device_property_read_bool(&spi->dev, "adi,if-mode-en");
-	st->iq_mode_en = device_property_read_bool(&spi->dev, "adi,iq-mode-en");
-	st->lo_x2_en = device_property_read_bool(&spi->dev, "adi,lo-x2-en");
-	st->lo_ppf_en = device_property_read_bool(&spi->dev, "adi,lo-ppf-en");
-	st->lo_en = device_property_read_bool(&spi->dev, "adi,lo-en");
-	st->uc_bias_en = device_property_read_bool(&spi->dev, "adi,uc-bias-en");
-	st->lo_sideband = device_property_read_bool(&spi->dev, "adi,lo-sideband");
-	st->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
+	struct device *dev = &st->spi->dev;
+
+	st->vga_buff_en = device_property_read_bool(dev, "adi,vga-buff-en");
+	st->lo_buff_en = device_property_read_bool(dev, "adi,lo-buff-en");
+	st->if_mode_en = device_property_read_bool(dev, "adi,if-mode-en");
+	st->iq_mode_en = device_property_read_bool(dev, "adi,iq-mode-en");
+	st->lo_x2_en = device_property_read_bool(dev, "adi,lo-x2-en");
+	st->lo_ppf_en = device_property_read_bool(dev, "adi,lo-ppf-en");
+	st->lo_en = device_property_read_bool(dev, "adi,lo-en");
+	st->uc_bias_en = device_property_read_bool(dev, "adi,uc-bias-en");
+	st->lo_sideband = device_property_read_bool(dev, "adi,lo-sideband");
+	st->vdet_out_en = device_property_read_bool(dev, "adi,vdet-out-en");
 }
 
 static void adrf6780_powerdown(void *data)
@@ -450,9 +447,10 @@ static int adrf6780_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct adrf6780_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -467,9 +465,9 @@ static int adrf6780_probe(struct spi_device *spi)
 
 	adrf6780_properties_parse(st);
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	mutex_init(&st->lock);
@@ -478,11 +476,11 @@ static int adrf6780_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, adrf6780_powerdown, st);
+	ret = devm_add_action_or_reset(dev, adrf6780_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id adrf6780_id[] = {
-- 
2.43.0

