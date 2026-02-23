Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102721F4615;
	Mon, 23 Feb 2026 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852522; cv=none; b=UHkm6hmW6ycAOoLyliC+NM/eSx/yC5arUpFaB/R5lz2zWoBXkvoEayvI6qFzN3fw3LN69B/tLPKe6UeBJolhLaL2H72qC3ym6F27CiP9yb9Pg/wMbDPwIaXp6WuWUzSPJfaRHgkoBeHPowWFx6wFGAvWjuSj9z7G/C1XDgWj/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852522; c=relaxed/simple;
	bh=iB6gga91VTjtuHbXqJjutwhI8s26s1hSSthoZne7jlU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6vFdUAOnVBMrW6NDKGAGK769Or4xfhSC0RnC2kubOHuyPHnqsKMC3NjKXY5fvP9lDm+Ab3PrQHgcodyBcy8HSKInk1bIGvsOikexdWFTvxR15KXP7KplMdbZU2OlPo28sfLZB9/zoBKBodf+4EUIneqLeS8S/hgZfTfUIHhSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RCOY1ymS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RCOY1ymS"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCW8ak1742937;
	Mon, 23 Feb 2026 08:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jaTt0
	jIK95oTCetEWdWJWZAdMh8suzvV8zjRYwvUX60=; b=RCOY1ymSTGrtM9ORqkhd4
	syToEh4nCYPFl/T/GDLjVSLOnYe2XZKzW7q4Ear8soouokcTG+IXNQSfhj5z+7HE
	lZFcfi/iAwObu77/dfz1v4ur1boF4QLDqiFiUof1KiEemsliVVL9xv5g+IASinpE
	GCewS6evsMWKH68G91dDeHl11l8txiYG3E+wP6BpcK/Pc9kXET3/VENNDHAhmfgl
	ch9Md+XyYDVPRydXQPJrl+RN46Lw1ACsjbn+4H3YGyFTqJy+C6KFaZuVhqxL8ZbE
	7rZsPUGo2vc7yTrjniwVInONIxn/eOO5XJpW8Zoj6czuTq275VcfQKGP8FQcnC1f
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4k2xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:15:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDF6VY009812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:15:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:15:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:15:06 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXi006594;
	Mon, 23 Feb 2026 08:15:00 -0500
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
Subject: [PATCH v2 12/12] iio: filter: admv8818: use dev_err_probe in probe path
Date: Mon, 23 Feb 2026 15:14:03 +0200
Message-ID: <20260223131418.55414-13-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX15vM64T+mMg8
 /UlmR9Dryr/pK8dYISIWrvtM4vTTYHdrOpy9Yp5qmccYZg9YD43WQiXN2obVe5eCyeck/GZuICb
 tcY/PgEXT2RfPJIN+ZmrIsKLA1IbjxHU+YJrJ3TqSUIFIBKREJok3icGi50xSXIOScsePFbhPA2
 AhkGP2A8o4wJcnxLQn5H9nhJow0GnIroFGkogbsFYcg5UNBmtmyzxR9pBBIXoLUDkz9iBvv2Dec
 0sMdLBbb2Ny4jn2qj4kHgqQSIiVtQiulrOViHs7cpxaPXKyg76JcZlFcv1K/uZXwJ6NHAN/aQgS
 RHk9PiVdQU418+rHru7DdiOuPSCRYgQ84cNrEPAEmBU8/zR7JDQ/xtW3jeswrvxOBAAiGrkrzcX
 tOB9ighIglmQLWCXAOdNwonCilA+Ux3w2s40Z9urS6XVB3Hy5SMExRmp4HWrsq9vQ4ZIyODBXN+
 3iTFqRkkG00eaHYHrNQ==
X-Proofpoint-ORIG-GUID: P-hv0wZzhUeYGYMo9Afd6qH3dmaMHupm
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c52db cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=XIZiaBmXTVxVH1IbRYoA:9
X-Proofpoint-GUID: P-hv0wZzhUeYGYMo9Afd6qH3dmaMHupm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Replace dev_err() + return with dev_err_probe() in the probe path
to simplify error handling and to ensure the error code is logged.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/admv8818.c | 38 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 82f433532804..a4c127d12882 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -662,36 +662,31 @@ static int admv8818_init(struct admv8818_state *st)
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
-	if (ret) {
-		dev_err(dev, "ADMV8818 Soft Reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Soft Reset failed.\n");
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
-	if (ret) {
-		dev_err(dev, "ADMV8818 SDO Enable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 SDO Enable failed.\n");
 
 	ret = regmap_read(st->regmap, ADMV8818_REG_CHIPTYPE, &chip_id);
-	if (ret) {
-		dev_err(dev, "ADMV8818 Chip ID read failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Chip ID read failed.\n");
 
-	if (chip_id != 0x1) {
-		dev_err(dev, "ADMV8818 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != 0x1)
+		return dev_err_probe(dev, -EINVAL,
+				     "ADMV8818 Invalid Chip ID.\n");
 
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_B,
 				 ADMV8818_SINGLE_INSTRUCTION_MSK,
 				 FIELD_PREP(ADMV8818_SINGLE_INSTRUCTION_MSK, 1));
-	if (ret) {
-		dev_err(dev, "ADMV8818 Single Instruction failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV8818 Single Instruction failed.\n");
 
 	if (st->clkin)
 		return admv8818_rfin_band_select(st);
@@ -767,7 +762,8 @@ static int admv8818_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &admv8818_regmap_config);
 	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
-- 
2.43.0

