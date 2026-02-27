Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DF4279F8;
	Fri, 27 Feb 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200964; cv=none; b=St5PsDHUjY0CHOfKGIgCfivfZsehTIPZWbXxLdoR0n+nFpUWjzTvPIDE9Pr+nvWmUoGoNP0OdIqp/bKwEQ8SRWJhmLFX0BUBlfz8jyJEFr9qsp/NUYTqG10tT1DZePwIXG2S1HsMl5kLF4iT/YHG63C6uR27CNJCnustuZMHwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200964; c=relaxed/simple;
	bh=Nu9Huj+p0YZcCPqgiK+kXyOum6DeVNqzR8QcNdYgA4o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja6PjVk6r+Eb0dsAc9HvSRdpOMvqZqf3/zkSh+Jnx1nSfmQLrwoGEhYZZqVldYze9gyT5uPpUvfKsyFqcYLG4D4PthsnjY/MgINmNuv/n1Atd/1NGtS3vojuIyLAeW3PucTKkEjkqMNZ9Lf4pMSbe6BjU732ZHfNjJ4txGcxORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ycvbn2Uu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ycvbn2Uu"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R8SE9o1868874;
	Fri, 27 Feb 2026 09:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oPXHl
	ewuIfQZEXspZZYOaDdNdBCyLYmMKR1JodC36cc=; b=Ycvbn2UucGnsZkXomxjD+
	naLC8qStByVx+X41fWRG+v+2Wn/kzDK9FzgbrQ41nkRyYdMo4w/n0TzduVbSDMnl
	bCkHs6SsPg9g0pVMrLMYZTxQKWYMci7kUYKL8SpSBgteq6QVERV7ix0YHSaf4k0G
	TiguFO6uGudB0cc8p2XxLfFD1BWT1XE+9HBdFn3gVNpygBlZ+MEJn3n/XtbyFg9v
	z8Me811mTsR5afcHLaUUWOzcfIzSDCFe44WfC5ye9eU4xCXXDC26SEVQBhKOfQ7X
	E8WQ1k0VIkHBFPJpKGVMMHNuecs+oFHc/QENReeem+8f1w+Vb0+5aM60sfoUdNVT
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4chvwgbeng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:23 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2MGm064828
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:22 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:22 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3t001982;
	Fri, 27 Feb 2026 09:02:18 -0500
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
Subject: [PATCH v4 07/12] iio: frequency: adf4377: add dev variable
Date: Fri, 27 Feb 2026 16:01:36 +0200
Message-ID: <20260227140152.77529-8-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Dcgaa/tW c=1 sm=1 tr=0 ts=69a1a3ef cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=EBMa5aonOlVRU8X19M8A:9
X-Proofpoint-GUID: HWcNwoPuapf1WRf6__19GXLzkUuu8G6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXy6Pmj+Bh1/KE
 m2MXASqHQDDJAWfENxXOIYzRWeI4NRtLqfm93QfnGC6pMwJBZW0PcsJzRhc/zC3ABrK4BIgDanH
 I71wwxa7Nnxpr8a6q4G6kPN13JCm11bCASU6Ju/NRd6aPV2jg05kbWhnRm8Xg8TGZ1BuSPefwdN
 dFJ17giJcLXIKS4042kkFsKSCSJC4pGDcIeUDoJetvXjytW16LCezagrGnCe8IO4g4aJmouTDqF
 k8mDoScNq+iPmh+0fmSTcrBezrs+WR7g+t8x+uky4nauFe0ayYKnxIJ379LpnwWkhkvTiKEmN0Q
 8seJx46JcMdZA+qg5B14vjTm0tmROjnuITnvIg1Q0PfyMwq5/goSi2nDjFVUA+CiTbe0OE4DW85
 kVSNas2vpCluHWHGqXy6t/aXkVNTuQE915iugbzT/78o2PzF3DYx/KO8b35Ew4aB49KnESSiodY
 y6hpDBQ+Sye/UyHDCMQ==
X-Proofpoint-ORIG-GUID: HWcNwoPuapf1WRf6__19GXLzkUuu8G6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270124

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index fa686f785fa4..c2ae6f2012ce 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
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

