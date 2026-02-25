Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B82765DF;
	Wed, 25 Feb 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032038; cv=none; b=EPH1QDzM3uD/I4Hp4NMvuJCyVXY1wJPF947mx0ksDqZyn0nr5YO2fTi44Cgab/oWu0vmEyVnGOPN9qIcmVvRrW7qPkbAbO9Rh/N975u04S3zwYBCym3L62x7NYvmGpQsZFVYI4j+tbRYJNy2TqN9H4yP67p+RT+OAsTNfeBMGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032038; c=relaxed/simple;
	bh=muWTidDgZC9sIL7qemOOCo7YhSW6CaNju3U8ammyWOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdVq1nxXQX41MTrFk6xFa0NyC27ziC9wf9CaC4LgIF/e5v5WosOdocNCp/WAIxafOJgNYhuz/w/Ruwcb7KjRoUHd6KFxWOwOOuxv37Tu2sWsKwSEuJpHqSuTOQIbXIBKeNJ7jygbLoZsmJ3KR7qWi3vH2bwQUD2ygp7fud+8f9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kLMxj7Sz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kLMxj7Sz"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PAYBs11743439;
	Wed, 25 Feb 2026 10:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HY/Y6
	MCC31p81tbU6zX5VsnJe+qJaILepGq8elcs/Lo=; b=kLMxj7SzP5/HW4xuakfJx
	bJuqPyBCnR8r3d8Egz6zdhwnRnrf+pT49fjOVKcQzve41DTIowvFIXIuwKtDXorF
	lxDujHV4X2DObiTAiPkQEDSbTPYm+NNFmxBD8lU2gp5IuderV3WM3lb5n/4Xq7b9
	ncJw/6ERm9ubNZzf3CXRRge+gKiZIYi1CGz734/oWUoKcrWcNN8t12m6PlcewdWJ
	7R/gSFowvCESRlD8neGgmv2XyNJGJotN8tOwLcWr0bBzKYQxcWkSlfdLGECwqaZe
	fxYYJboYM+E/qK1b526aizK086Ip9HDNio/n+lyD1Fo4lKKz78LkBR1J51AFn99y
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4wa9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:06:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61PF6tKL024656
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Feb 2026 10:06:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 25 Feb
 2026 10:06:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 25 Feb 2026 10:06:55 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61PF6Yns006794;
	Wed, 25 Feb 2026 10:06:51 -0500
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
Subject: [PATCH v3 4/6] iio: frequency: adf4377: add dev variable and use dev_err_probe
Date: Wed, 25 Feb 2026 17:05:50 +0200
Message-ID: <20260225150615.274078-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NSBTYWx0ZWRfXyTxIIjVazScK
 xOIIbeTEOtvsU0X4On2RBl2Q9bdjc+SLcfOw6o27EhPdmZkapD5IlAs47l1m/55ZED2yIyPaEjB
 BOK323L8045Du32BawKbe2mt+T3gH++ZQny96+/ZeZOahAYExZGh+iEnevsC2SZwHGvEb/4gdPE
 G+UnGhdJf6YyK0Esn7NR/ngupfPyJQOYGUnWLleotJEIprHDK75HjjJI22hQleDkH7GFDwF6Tkj
 tt9wQ5o1/iDSwAPao1smujOnBdAIZ6UAKZ+9YPN2qfBIvb2rcbhwzuTOXB51UQt1G0wV7+czAjH
 J1uGQxlafibhJAyYdh40E1i2DVFOhbi2zHXNTF3c6Vaq9+7YRmVSEh/n5cSv+fBV4CInUOA4j6M
 NfWtoMGmEgnay5Cf9TO7BRDlIF61lFq1/FyGMzWTBUoUf8w0CgttXtNMKxXSF0uugW+xCoxrbAj
 PcG4KAeyzyPxxIqaMDg==
X-Proofpoint-ORIG-GUID: Gf9ZHZKfoPtOwFwFa3od8LSJf_sW0t2y
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699f1010 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=bMEtPg1WnvWC4BS4PrsA:9
X-Proofpoint-GUID: Gf9ZHZKfoPtOwFwFa3od8LSJf_sW0t2y
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
 drivers/iio/frequency/adf4377.c | 57 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index fa686f785fa4..cfc0c524c4a4 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -706,23 +706,21 @@ static void adf4377_gpio_init(struct adf4377_state *st)
 
 static int adf4377_init(struct adf4377_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	adf4377_gpio_init(st);
 
 	ret = adf4377_soft_reset(st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to soft reset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to soft reset.\n");
 
 	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
 				     ARRAY_SIZE(adf4377_reg_defaults));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set default registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set default registers.\n");
 
 	ret = regmap_update_bits(st->regmap, 0x00,
 				 ADF4377_0000_SDO_ACTIVE_MSK | ADF4377_0000_SDO_ACTIVE_R_MSK,
@@ -730,10 +728,9 @@ static int adf4377_init(struct adf4377_state *st)
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W) |
 				 FIELD_PREP(ADF4377_0000_SDO_ACTIVE_R_MSK,
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set 4-Wire Operation.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set 4-Wire Operation.\n");
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
@@ -747,10 +744,9 @@ static int adf4377_init(struct adf4377_state *st)
 			   FIELD_PREP(ADF4377_001A_PD_PFDCP_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set power down registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set power down registers.\n");
 
 	/* Set Mux Output */
 	ret = regmap_update_bits(st->regmap, 0x1D,
@@ -882,35 +878,35 @@ static const struct iio_chan_spec adf4377_channels[] = {
 
 static int adf4377_properties_parse(struct adf4377_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "ref_in");
+	st->clkin = devm_clk_get_enabled(dev, "ref_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the reference input clock\n");
 
-	st->gpio_ce = devm_gpiod_get_optional(&st->spi->dev, "chip-enable",
+	st->gpio_ce = devm_gpiod_get_optional(dev, "chip-enable",
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_ce))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_ce),
+		return dev_err_probe(dev, PTR_ERR(st->gpio_ce),
 				     "failed to get the CE GPIO\n");
 
-	st->gpio_enclk1 = devm_gpiod_get_optional(&st->spi->dev, "clk1-enable",
+	st->gpio_enclk1 = devm_gpiod_get_optional(dev, "clk1-enable",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_enclk1))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
+		return dev_err_probe(dev, PTR_ERR(st->gpio_enclk1),
 				     "failed to get the CE GPIO\n");
 
 	if (st->chip_info->has_gpio_enclk2) {
-		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
+		st->gpio_enclk2 = devm_gpiod_get_optional(dev, "clk2-enable",
 							  GPIOD_OUT_LOW);
 		if (IS_ERR(st->gpio_enclk2))
-			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
+			return dev_err_probe(dev, PTR_ERR(st->gpio_enclk2),
 					"failed to get the CE GPIO\n");
 	}
 
-	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
+	ret = device_property_match_property_string(dev, "adi,muxout-select",
 						    adf4377_muxout_modes,
 						    ARRAY_SIZE(adf4377_muxout_modes));
 	if (ret >= 0)
@@ -1055,9 +1051,10 @@ static int adf4377_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
 	struct adf4377_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1080,7 +1077,7 @@ static int adf4377_probe(struct spi_device *spi)
 		return ret;
 
 	st->nb.notifier_call = adf4377_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1094,7 @@ static int adf4377_probe(struct spi_device *spi)
 		indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id adf4377_id[] = {
-- 
2.43.0

