Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47734A3B4;
	Fri, 20 Feb 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593218; cv=none; b=SOFdaoR9ejnqLvbeTJ2mvWyp/p/nTQZCiNELo1UZSUglN0gsjqqv4S5g2GX9KujhQEMPKXKHDeXsQlH6pd5bBlR/+FQlfzZI7YhEkh5C9uo0IwDbOPKCHOXiKlOfOUsPw0EKZMmo9hbUsFLxiZCnZE1suyadDEMeTF8I4XXIg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593218; c=relaxed/simple;
	bh=Lpud9j+44BJBJlNjY7bXCrCuUEASvfR4cd58OmzQLI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQtwYia8Z3+joeRbGKcMzK6i+IJr1Ur8Ngfn7WhK2B+kqapeFxGq8hUIMJZvUbmjcMWInAyQrvU7pWto/2NOOsCoa3aFXBnIIe9nogWYZi5wnoJeCfaAb+5cXbFJJdNo//6CqUdqS8zUkDnOh2KlRo/N5dSIkzPksxcBJblBkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JQFmmJ9O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JQFmmJ9O"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87Eil3823365;
	Fri, 20 Feb 2026 08:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ke3fd
	+UlR1q+igf1bOC8NQ2MbLfihgCO//HgGoRP22E=; b=JQFmmJ9Ol+5A9CrlNrMig
	tJVhN2cPSeXSbPyH8B4/qW52+mKBh3hHlkAcSjwIT0+hyI/vLm5TKHmdn/3Rg85M
	yrpL8VOJiEOgbTSKqh4RpJuMY0zLm/r/+FnY2x7TfTG2nWNKuYx6LHGG+mslGdwq
	Z5CJ2cNMEOcWgJsuI47JHP2Zw4agCAxdgaQcgp2PlBanm3daeSMZLf9aCnfc6whF
	HDYYsNbqc/7vF/lpjKnxJ+BRqLfLuDfyJbsJpLBFBU94F0QMkf71b2MRhX0HvJwe
	jMcCB1/QZYQmcxd6fzr27OoawX/gMEI+5ciJ4UNvSzaBPfYj2DYDUaUpvyeDqIDn
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce0xvw0jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDDMAx064769
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:22 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:13:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:13:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:22 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHY009613;
	Fri, 20 Feb 2026 08:13:16 -0500
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
Subject: [PATCH 7/7] iio: filter: admv8818: use dev_err_probe in probe path
Date: Fri, 20 Feb 2026 15:11:45 +0200
Message-ID: <20260220131151.74329-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220131151.74329-1-antoniu.miclaus@analog.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69985df3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=aH7txxTo_R53wjfIuwcA:9
X-Proofpoint-ORIG-GUID: 3W4bCOGvjBfqx7uPVWJKkbz25kolT91l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfX0Fq3uBmD4e1j
 4u3y0pptByECjCOqs1QX55GoEmbOeiBSwHTw1lWXV46Mlk1s3EEuoKkktvt7bY+RtNK/4R3R8S7
 dszgtmpUEBZIqwjNmMViHcbWJ+V9hjLVERdNaNkF+Xj2Zt5iFOd5kcCHOMhH7xLx4MSY+Ojh72T
 T4GxohpUcokwuX5+P3LaEc5azY0EgdzrpM7vJ2NcYHE4VixPPohe9oo8luiiJvhRk4mPx38it7I
 yF1AlDAfVzk9pgh/vaVrKkdS+yE+gXLrBYeoCbAAXFFcADOrFHNWewc2kbsGP/HL+XK0faq8gxx
 sJIT9UFQ+w5Blf6LCaYXz11fODZD/PrtbSsgqO/4mh6uRbK/ezFZ8hfN1eV9W2UqOS8pbLZYs9/
 maOxn1octOcD5lcRhMbhmh4w2lcVXYsaUtdFiXk4eNQ07TXGmelG9K/zgpPj6BKlLPSDxb8gEEF
 knN+YmQYwG93+cNDOww==
X-Proofpoint-GUID: 3W4bCOGvjBfqx7uPVWJKkbz25kolT91l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200115

Replace dev_err() + return with dev_err_probe() in admv8818_init(),
which is called during probe. Also use dev_err_probe() for the
regmap initialization error in the probe function. This simplifies
error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/admv8818.c | 38 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 19f823446cda..d440f37811a2 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -662,36 +662,31 @@ static int admv8818_init(struct admv8818_state *st)
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV8818 Soft Reset failed.\n");
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV8818 SDO Enable failed.\n");
 
 	ret = regmap_read(st->regmap, ADMV8818_REG_CHIPTYPE, &chip_id);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Chip ID read failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV8818 Chip ID read failed.\n");
 
-	if (chip_id != 0x1) {
-		dev_err(&spi->dev, "ADMV8818 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != 0x1)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "ADMV8818 Invalid Chip ID.\n");
 
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_B,
 				 ADMV8818_SINGLE_INSTRUCTION_MSK,
 				 FIELD_PREP(ADMV8818_SINGLE_INSTRUCTION_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 Single Instruction failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV8818 Single Instruction failed.\n");
 
 	if (st->clkin)
 		return admv8818_rfin_band_select(st);
@@ -766,7 +761,8 @@ static int admv8818_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &admv8818_regmap_config);
 	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "failed to initialize regmap\n");
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
-- 
2.43.0

