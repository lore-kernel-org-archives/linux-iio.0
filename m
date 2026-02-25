Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227F3D6483;
	Wed, 25 Feb 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032040; cv=none; b=Qb7Fi63AS2CRH8fpfMUOiHyjguBPiD/JUhc1DkG/aBd5tP7LIgl11XvmtbNuhRHa8lTj+HNfIqLC+CwP0RbqwLQu7/Xboe0f5SYm69Od0OFNrq6KSql9HllSMin84ieJ+uS0Yui+Y+3Pc6Hu0L2hmn1jTY1cFx0rtVTpsmCvAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032040; c=relaxed/simple;
	bh=cs5pJiU5q3s9zOlQcOh/aWtHbo+8avXU6Qjt1rfHXdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A55y72Rs6nH9Dqr+Mg63PfBz42LHm4ue9h9EZ7oChIopiOeYA/V0pfVs+DiBXImm/4sPquFzz0wPS5qYzE5ciqoTgCOPI4Tk63jqEVao9WwLYlA8LA1vSKP13pOFBD/IZuASquZKhUHxeH93UURx/isrr7Sj2m2BXcXRYl6ugUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r5Qkb0em; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r5Qkb0em"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PD2KpC1743183;
	Wed, 25 Feb 2026 10:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y2xcN
	WnE2Z1j/e5V2J6AOlQ1whJL/c9R1EDYSbBLEl4=; b=r5Qkb0emr7INcnM1szKXS
	7V3CtM/Atu4wYgSYYV+fii1d4THXPFO0wdG6sD/kK7V/jXd+wDFoB/XmQlvNZMMv
	7cp/TlliihpluYSxisrsioVTZ+ux9JDl6CyXK+0OT1MN+z5YD3UJKXUdd5Apf2bH
	RMXMp7yXP2QkIrC/9bh0o+LbgB1x+AO8/JOm7ID92Aa8HfOsgD3/7yJeMzwwxQjV
	9Qi6LzIboHAvOfb4O6zLhqZmR8K/i4q5wkeIY1VuOzV7ka96Yi9tpWQrc2Es+ktl
	jvxVxolYHZqFNsoRWNWleAom6/836Qg/oFlyPAV/3Vmd/XbLN3n3bcUGrSSkdpIb
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4wa9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:07:01 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF70NZ024681
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:07:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 25 Feb
 2026 10:07:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:07:00 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Ynu006794;
	Wed, 25 Feb 2026 10:06:57 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] iio: filter: admv8818: add dev variable and use dev_err_probe
Date: Wed, 25 Feb 2026 17:05:52 +0200
Message-ID: <20260225150615.274078-7-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfXwOGK8bwpo14k
 kd5oQRTbsYTPXbIp609550QyOjCks/Or7YOUWeaTZYwkOwi8Wu7szgJy05oFv0o2KYMr/VDk5Gq
 8gbVuxAkJFsm5d7Wz3TGeTkjz7bfwBe5yT01txkTdqTytoQ/dORr5M+ldM0gxRJNPNMcpusGIzm
 Y2dVVkvrm4mRLu/aMe5j+Him1qEZL9lflgHssGCXSEjeoUGFENG4MfbnS6voFFYiofDud5vFnWq
 00Noia84+ccNowKPRGJD54VxmLNfkbx0AQYoykMvgL2gP857CswaXSCkUMgZBK37BSWDy4hHgGV
 l6yvd4AVHSS4UY23HkJPclkI84uUhAVfvhWQU1yRZsAqXuhK5npsYFW2O4DOM3uWef1PzwBfaGN
 ++8jjm18XWxEdp9cHuHNVTCzORgmtiIxLhcGkWhIX1UGR/JAy2QtuvcWqpocgQY18lohzCAo4+G
 nXFJEmWdEy3OWN0tcyg==
X-Proofpoint-ORIG-GUID: 706xqVMYizuji3sczWnkxQLMmmdkQ0Ti
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699f1016 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=O8djgtFz8mmoGGuIiJcA:9
X-Proofpoint-GUID: 706xqVMYizuji3sczWnkxQLMmmdkQ0Ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250145

Introduce a struct device *dev local variable and replace dev_err() +
return with dev_err_probe() in functions that use devm_ managed
resources. This simplifies error handling and ensures proper logging
of deferred probes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/admv8818.c | 61 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 19f823446cda..a4c127d12882 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -657,41 +657,36 @@ static void admv8818_clk_disable(void *data)
 static int admv8818_init(struct admv8818_state *st)
 {
 	int ret;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	unsigned int chip_id;
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Soft Reset failed.\n");
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 SDO Enable failed.\n");
 
 	ret = regmap_read(st->regmap, ADMV8818_REG_CHIPTYPE, &chip_id);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Chip ID read failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Chip ID read failed.\n");
 
-	if (chip_id != 0x1) {
-		dev_err(&spi->dev, "ADMV8818 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != 0x1)
+		return dev_err_probe(dev, -EINVAL,
+				     "ADMV8818 Invalid Chip ID.\n");
 
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_B,
 				 ADMV8818_SINGLE_INSTRUCTION_MSK,
 				 FIELD_PREP(ADMV8818_SINGLE_INSTRUCTION_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Single Instruction failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Single Instruction failed.\n");
 
 	if (st->clkin)
 		return admv8818_rfin_band_select(st);
@@ -701,12 +696,12 @@ static int admv8818_init(struct admv8818_state *st)
 
 static int admv8818_clk_setup(struct admv8818_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
-	st->clkin = devm_clk_get_optional(&spi->dev, "rf_in");
+	st->clkin = devm_clk_get_optional(dev, "rf_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the input clock\n");
 	else if (!st->clkin)
 		return 0;
@@ -715,7 +710,7 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, admv8818_clk_disable, st);
+	ret = devm_add_action_or_reset(dev, admv8818_clk_disable, st);
 	if (ret)
 		return ret;
 
@@ -724,16 +719,16 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 	if (ret < 0)
 		return ret;
 
-	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
+	return devm_add_action_or_reset(dev, admv8818_clk_notifier_unreg, st);
 }
 
 static int admv8818_read_properties(struct admv8818_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	u32 mhz;
 	int ret;
 
-	ret = device_property_read_u32(&spi->dev, "adi,lpf-margin-mhz", &mhz);
+	ret = device_property_read_u32(dev, "adi,lpf-margin-mhz", &mhz);
 	if (ret == 0)
 		st->lpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
 	else if (ret == -EINVAL)
@@ -742,7 +737,7 @@ static int admv8818_read_properties(struct admv8818_state *st)
 		return ret;
 
 
-	ret = device_property_read_u32(&spi->dev, "adi,hpf-margin-mhz", &mhz);
+	ret = device_property_read_u32(dev, "adi,hpf-margin-mhz", &mhz);
 	if (ret == 0)
 		st->hpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
 	else if (ret == -EINVAL)
@@ -758,15 +753,17 @@ static int admv8818_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
 	struct admv8818_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	regmap = devm_regmap_init_spi(spi, &admv8818_regmap_config);
 	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
@@ -792,7 +789,7 @@ static int admv8818_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv8818_id[] = {
-- 
2.43.0

