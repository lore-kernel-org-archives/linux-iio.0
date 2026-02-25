Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521343D522B;
	Wed, 25 Feb 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032037; cv=none; b=KSGQyKwQm5bfawPEWf8zM/+kGJ2WNoPEQKHO5GwI2GqpCnEW3ugfZQuLjZTJMfNT5X2HJbfqJeaF9AwAXVDoMfdUsaF8bIZA1MCf2Bp1Ygp003UZeTVMx5zXDA9FpGZEKw8YqhnIUKYYUTXTO1MxTmYuRhGXeFx0NK78vZhtKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032037; c=relaxed/simple;
	bh=eRUTVBAO2hokbiuOibV3C7ozM+5NoYaH93/SNwkV4IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeKBNL6F/YJ4XIZbfakpuOyjb04cw6kZiyKa0zUpeiYXv/9Yb3otPbfHKY+QDTYsqD3P1JwkkxpqFN+GZ3sXuMG5gavPikNTCKKxzGHdq1jqcRlrrPBrpLzfZbkVSOGg/S6+cxHMqkhDWeknDa+2RH0VG6Qr145rQt4IPL6GRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dhfw90A8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dhfw90A8"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAjRdH1742992;
	Wed, 25 Feb 2026 10:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dEkzG
	tQZ0dQ4FBtz49U4nu2kDZLPaWhyqtUCRe2Z25w=; b=dhfw90A85/WtQY7mK06hO
	JbqIUCmItkRN9hKtW8ZIABrpQ/ed3snQhgc1Mn1eq28fc5vdgnJ68i7DelVgWOzO
	ZZZfNDQvUwxhWWvm5L/OiHb5JUrPPJEFgdtg/y2dAhAalxuaICb51iqFbZW9b/W/
	z+4iR+8n9FeNxLDaYF68ueErSGO0qFwnD9CrCqPrL+30m3l75MQ9gJjH+hcwFvw5
	ubNZhzrfhFz3/EAicHL/A5tCsqqNZbIsJLpVeoxjrk3aPrTK4yBzmOhB2ZWJt7T6
	HmIFuGwpmQTw0sGYP11CWyO8xMqopoQikcENbMiHKfjkzxKcoV65hZqcfLuKWoRE
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4wa9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:06:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF6qsW024644
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:06:52 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:52 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 25 Feb 2026 10:06:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:06:52 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Ynq006794;
	Wed, 25 Feb 2026 10:06:46 -0500
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
Subject: [PATCH v3 2/6] iio: frequency: admv1014: add dev variable and use dev_err_probe
Date: Wed, 25 Feb 2026 17:05:48 +0200
Message-ID: <20260225150615.274078-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfXxXfnWxqdZ+XW
 p2lHo+a3Jcz6mcCivcnhj5Cxbqtn+zapfXhq+Ts5bIw8k4GonhtQBePieZd2WFDtrhAaWuygi3d
 wsux7b7Icn+fkPZbJsBF8/B4IfVBqoUrJSwKACoOPNJ6LzyUBvqft6STqRjoAw+iUxJkR7E5Shh
 qQ6/AdAQG/jr0r/+EuhWElOj/LfK8GxrVVUQb/H0xVwmK7ripIBOoojG5fp39oEevwfZ4GaCrd0
 UDfGK//zTljTUoBrPGX6YX0VBRcFC8iWI/vk8+qzDY9D9uAJ3+NGofTVoKVLz/g8iiuqzb0U9U4
 b2Qrq/B4uIvhUMWQ8/zzGhTH5pSuIKGAXq1s5cncD07terTreMVEubwRxcatJc8ai/OIVVbVEbt
 z6/QU0o2AzrMC9RHGT0VBBbljwYwP/elLrBN/Y+VWVkZog+49RkAJ1W38eNQNgrY3OwFLxUnPvX
 Ip9VxHmYdh+LKrEx8Cg==
X-Proofpoint-ORIG-GUID: hYv9m2f7sBg-2vo4OSO_WkC9x2pT4Byn
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699f100d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=3cO7uaoVlvYoWMCBlHYA:9
X-Proofpoint-GUID: hYv9m2f7sBg-2vo4OSO_WkC9x2pT4Byn
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

Drop 'SPI' from error messages since the bus type is evident from
the device hierarchy.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 94 +++++++++++++++-----------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 7a8f92ec80a2..eeb01cfb799f 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -609,16 +609,15 @@ static void admv1014_powerdown(void *data)
 static int admv1014_init(struct admv1014_state *st)
 {
 	unsigned int chip_id, enable_reg, enable_reg_msk;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable regulators");
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->regulators);
+	ret = devm_add_action_or_reset(dev, admv1014_reg_disable, st->regulators);
 	if (ret)
 		return ret;
 
@@ -626,16 +625,16 @@ static int admv1014_init(struct admv1014_state *st)
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
 
@@ -643,55 +642,48 @@ static int admv1014_init(struct admv1014_state *st)
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 software reset failed.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 software reset disable failed.\n");
 
 	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
-	if (ret) {
-		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Writing default Temperature Compensation value failed.\n");
 
 	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
 	if (ret)
 		return ret;
 
 	chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADMV1014_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADMV1014_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid Chip ID.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
 					 ADMV1014_QUAD_SE_MODE_MSK,
 					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
 						    st->quad_se_mode));
-	if (ret) {
-		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Writing Quad SE Mode failed.\n");
 
 	ret = admv1014_update_quad_filters(st);
-	if (ret) {
-		dev_err(&spi->dev, "Update Quad Filters failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Update Quad Filters failed.\n");
 
 	ret = admv1014_update_vcm_settings(st);
-	if (ret) {
-		dev_err(&spi->dev, "Update VCM Settings failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Update VCM Settings failed.\n");
 
 	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
 			 ADMV1014_IF_AMP_PD_MSK |
@@ -711,14 +703,14 @@ static int admv1014_init(struct admv1014_state *st)
 static int admv1014_properties_parse(struct admv1014_state *st)
 {
 	unsigned int i;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
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
@@ -726,7 +718,7 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	else
 		st->input_mode = ADMV1014_IQ_MODE;
 
-	ret = device_property_match_property_string(&spi->dev, "adi,quad-se-mode",
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
 						    quad_se_mode_names,
 						    ARRAY_SIZE(quad_se_mode_names));
 	if (ret >= 0)
@@ -737,16 +729,15 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 	for (i = 0; i < ADMV1014_NUM_REGULATORS; ++i)
 		st->regulators[i].supply = admv1014_reg_name[i];
 
-	ret = devm_regulator_bulk_get(&st->spi->dev, ADMV1014_NUM_REGULATORS,
+	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to request regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to request regulators");
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	return 0;
@@ -756,9 +747,10 @@ static int admv1014_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1014_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -787,7 +779,7 @@ static int admv1014_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1014_id[] = {
-- 
2.43.0

