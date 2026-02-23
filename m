Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB90366542;
	Mon, 23 Feb 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852502; cv=none; b=VJAsbMK9b0Tx9g/WqSjjbfLugcWpIniW7RgJGSpODimBOt60JL5yI8NtD01tbqMlOvnkar9gN9H4J13EnfmGgpPHqahYxnvvz7u5IjQ218ArBv+iHV4ojC6dWHUmiLqNxbtiOs87uEKTRYiaBVOECBFHavNgGbREKtrppFJgTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852502; c=relaxed/simple;
	bh=AvFrLwFPZxIb2JqSSuJ2Vk75qbD7Bqmzb7yTRi+e4Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eL1SURLP8m+hcTuvaSLvGE4OmEsLjfecNkyrSkJjfO9yfOGwUhwbK+PD8xhbQT8QtCYZebxANbpJHrCHRVsgDSWpZG6MIVx2HyBKYTqGxjN6ZTHJLWkKKNgEehmx/ZqSzE484G0ZT9lg9oVhkuzaRF+vb8bejc1DeXycK9kpTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nkIRRjBt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nkIRRjBt"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8TNj61742992;
	Mon, 23 Feb 2026 08:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fUVuM
	INfEV/vwHxhJyoSgukVLInyqFeH+ltiXg/HAX0=; b=nkIRRjBtwGB8JrQz8Zs//
	BRwb+6KGTt60Az9r1nGzn/Jr8mJZN6Hf6utK8TBOHThWSu/n/DPmyQHF5pvHxE9c
	eHDc2lXAXRNZSEJbXXu5BeS+6tHsjaNKaWg3VVsEGky2PvHPH1PiulWj/dm8NG3K
	nHCsG+VDUnKD3YiUQgNmzyV8Dmdq6AcaHlBq3PqDuGZzh8IJEqwhHFL6sN6u9f/n
	vX1//kZG4tCCEJtu4RF3oZPMetBoGt/ZWLI17/rtvs1qIsxii3XWrKFf+l0dF/Jq
	SA9oCq8HuqJpsIqJANtSK6iYklMIVDQfChZUDWgqRzHNnMCk9JHL2jueadetgqgM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4k2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:47 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEjYD009747
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:46 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXb006594;
	Mon, 23 Feb 2026 08:14:41 -0500
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
Subject: [PATCH v2 05/12] iio: frequency: admv1013: introduce struct device variable
Date: Mon, 23 Feb 2026 15:13:56 +0200
Message-ID: <20260223131418.55414-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX3sZDJ5vqrf3T
 4/iuD2JYA4VVJWsb0/9TffQaBqJ88nakQD/0+flRiKamJdx16v9dvWdrwX4XV9hXzxu2yY9Nbf2
 ljyr8N4trfG4tkchfBOa/8eGEQnrTVakS9h82AkAYaVuqNb0jXLIPBrPhHptP/khlgyCEuA2qOy
 ouMOjyPMEG+N51u/suKM/etJnlzLMjvyG/sKRFNEc998SfHPrl3LAnnv6+G9dJc9CQuf1T4FLqG
 bJI4FvQezHBkwlHyo6ByVO8ArqD/kNnzUxbhVmBgaHrpUvSsLbm25Wg1WkGBRNw68DHHhayMmso
 uwYLa9MPNci8MlAoeQnCIlJjnqC3WPD18qc9dAgbDgwdSXXlTBXvvcmdIjvAbXcldK7EH1NKdO7
 irXtxj6gw2s7hgZAbf77zJYiNXQsN7EWmWQ4uZZ6idCQM0iGGl2WDdxJ6qUel20UC1VnBOdqEbU
 NiCOZGMOTB/L2BO9rlg==
X-Proofpoint-ORIG-GUID: y4aAfQMb5pGAye8WzJTn9cmwF-lZ60Wv
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c52c7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=j11YKoYN7QvLHPzYg_IA:9
X-Proofpoint-GUID: y4aAfQMb5pGAye8WzJTn9cmwF-lZ60Wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Add struct device *dev local variable to simplify repeated &spi->dev
dereferences. Where spi is no longer needed beyond &spi->dev, replace
struct spi_device *spi with struct device *dev = &st->spi->dev.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 35 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d8e8d541990f..4e1ebb9a537b 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -441,7 +441,7 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 {
 	int ret;
 	unsigned int data;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	/* Perform a software reset */
 	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
@@ -462,7 +462,7 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 
 	data = FIELD_GET(ADMV1013_CHIP_ID_MSK, data);
 	if (data != ADMV1013_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
+		dev_err(dev, "Invalid Chip ID.\n");
 		return -EINVAL;
 	}
 
@@ -518,11 +518,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
 	const char *str;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
-	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
+	ret = device_property_read_string(dev, "adi,input-mode", &str);
 	if (ret)
 		st->input_mode = ADMV1013_IQ_MODE;
 
@@ -533,7 +533,7 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
+	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
 	if (ret)
 		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 
@@ -546,11 +546,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = devm_regulator_bulk_get_enable(&st->spi->dev,
+	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
 					     admv1013_vcc_regs);
 	if (ret) {
-		dev_err_probe(&spi->dev, ret,
+		dev_err_probe(dev, ret,
 			      "Failed to request VCC regulators\n");
 		return ret;
 	}
@@ -562,9 +562,10 @@ static int admv1013_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1013_state *st;
+	struct device *dev = &spi->dev;
 	int ret, vcm_uv;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -581,20 +582,20 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcm");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcm");
 	if (ret < 0)
-		return dev_err_probe(&spi->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to get the common-mode voltage\n");
 
 	vcm_uv = ret;
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
@@ -602,15 +603,15 @@ static int admv1013_probe(struct spi_device *spi)
 
 	ret = admv1013_init(st, vcm_uv);
 	if (ret) {
-		dev_err(&spi->dev, "admv1013 init failed\n");
+		dev_err(dev, "admv1013 init failed\n");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_powerdown, st);
+	ret = devm_add_action_or_reset(dev, admv1013_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1013_id[] = {
-- 
2.43.0

