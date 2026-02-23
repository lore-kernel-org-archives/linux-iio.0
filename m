Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949B1EB9F2;
	Mon, 23 Feb 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852514; cv=none; b=GAvxfqq0Zc7W/ypjCxfaiVtiiE4dVgEmYMSGhRLmoJjE9XCjqG7VuQhDfqNcj1LCUp5gKfrDptP+qGCNQOy4R5ffjGd/1R0eq6SI/uGKXhvUkARXivBL/Y85OLG7dkpHegzmmCDdgSL1tSnKJ0B649xwi1rz0NXpDmRXLAFK4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852514; c=relaxed/simple;
	bh=UR0cvINV7Cf3IaNBpeC5pV4GQESP4KSvxF1kPsvMzqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr7zsWU0OwS/JCSY2yDmS7FE3RXtJ20XT0xqxCceZLCdzQUyL0nSED/fwh5NlF4Va/SSigAju5eSvJIc9cPHEXtinXTe7M/vxtV5CtBVOLNsvbXg36670nUUO+AS5zSQkMKcYm+W/PhdmoSr8K/OPqEpk7ZtFFSut+r8753ROQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RVeh9sVa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RVeh9sVa"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6gebm2668062;
	Mon, 23 Feb 2026 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CceAy
	mbNYmLaNdeJU+zYFk+D1oNDCfXFz3BRkZs3MbU=; b=RVeh9sVaMaWCyGSuLzAGK
	qTeUNdgo1OegDmBx+mZzc3ssTG42Ve40DYF6I9vDxKFp8bxRp17U0gLlWu+3yThd
	MJlXxFwI/Xzru2cWaeRA94VfbbD9qGYux2AjbFwFhvEiq6k6YvWdZ/e2rsS/7hVs
	mFVFsY2/gK7aK+aiMlTjRz4AqvG0tOogpmsUXivMZ+4VWCrkju/3uLudmuTkRPBw
	mDD2yGeMmoVxZdTsbcGSJlGNdpLzl9hglwvHAWo2KqD21MBheLu8XgbyVZ3/2nnh
	6miwEzyauzyJBMPMeiSKqom5s0bt1WQWS9tde8LoH23KwFo001OBL1pEkZAAjuZ3
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbb12j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:52 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEp0t009764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:51 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:51 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXd006594;
	Mon, 23 Feb 2026 08:14:47 -0500
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
Subject: [PATCH v2 07/12] iio: frequency: adf4377: introduce struct device variable
Date: Mon, 23 Feb 2026 15:13:58 +0200
Message-ID: <20260223131418.55414-8-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: 6kXypGpJsOUy3_vjoHpvklTxv_a8voOf
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c52cc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=fOTDyBl8tY8esg50VKwA:9
X-Proofpoint-ORIG-GUID: 6kXypGpJsOUy3_vjoHpvklTxv_a8voOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX3vungmR1SKmY
 V52wb0EhXNFTGf5y7t8ox1CeI+TfXGhsCz2EpMX8r0451ftEqcEbtnyjpewU+OeRvtpHjigTRdv
 PgmQw5b1cTlv3B0x5vlQ9vIcfHqskLHfFMcbKG3gUAdXaeTyaiwFSOncBZPED/SHZ930S82WXU7
 mhfBBvfN3wCr5I6BuUUZyhN24AL7TR9+2buNJSFk489djw302IvK0cOQf1kjAIsOUv/sgGmUYIb
 bEks1xiw7+f3Jx8Gh/YNc3jpEIMXB2iDGv1iILLDsNezmr+5Qp8TQaP/PC/6LaoQpZ9n0WWT5I0
 NmOnCgfvdfa7PCzcnUTRPiAvBCrGmw8SExziaszFO8zKovyQrQ2sSBBJIR3lrsPLw6PMs/b4KRt
 IuRXUFd3Mdxz2A5F/cao7Y/Fc6MTmIdcjq5tP0ApV+JbuGG4K93fYzWHCsARHkDenr75Fs/9439
 br7avaaKVXMHTKP3WrQ==
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
 drivers/iio/frequency/adf4377.c | 37 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index fa686f785fa4..919b604b2ce6 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -706,21 +706,21 @@ static void adf4377_gpio_init(struct adf4377_state *st)
 
 static int adf4377_init(struct adf4377_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	adf4377_gpio_init(st);
 
 	ret = adf4377_soft_reset(st);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to soft reset.\n");
+		dev_err(dev, "Failed to soft reset.\n");
 		return ret;
 	}
 
 	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
 				     ARRAY_SIZE(adf4377_reg_defaults));
 	if (ret) {
-		dev_err(&spi->dev, "Failed to set default registers.\n");
+		dev_err(dev, "Failed to set default registers.\n");
 		return ret;
 	}
 
@@ -731,7 +731,7 @@ static int adf4377_init(struct adf4377_state *st)
 				 FIELD_PREP(ADF4377_0000_SDO_ACTIVE_R_MSK,
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W));
 	if (ret) {
-		dev_err(&spi->dev, "Failed to set 4-Wire Operation.\n");
+		dev_err(dev, "Failed to set 4-Wire Operation.\n");
 		return ret;
 	}
 
@@ -748,7 +748,7 @@ static int adf4377_init(struct adf4377_state *st)
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
 	if (ret) {
-		dev_err(&spi->dev, "Failed to set power down registers.\n");
+		dev_err(dev, "Failed to set power down registers.\n");
 		return ret;
 	}
 
@@ -882,35 +882,35 @@ static const struct iio_chan_spec adf4377_channels[] = {
 
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
@@ -1055,9 +1055,10 @@ static int adf4377_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
 	struct adf4377_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1080,7 +1081,7 @@ static int adf4377_probe(struct spi_device *spi)
 		return ret;
 
 	st->nb.notifier_call = adf4377_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1098,7 @@ static int adf4377_probe(struct spi_device *spi)
 		indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id adf4377_id[] = {
-- 
2.43.0

