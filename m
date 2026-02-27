Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488542B72B;
	Fri, 27 Feb 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200975; cv=none; b=dArhWd8ZdFkWwzu/mcEY8YB5qU2vQXBFUUWx2aah3tmvonMQytxAwE6F8d5KWGTRxobTOQU4bLmhXXq0QKdFexYrIRviaNg6T9tUhOq/Zp4ICJ21zeLe+2N4dFDOdawaCHv5Z4TQ5StuPLHz/LWIVBNkHxQDTJKbsLR+7h5+LdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200975; c=relaxed/simple;
	bh=5d0uKzynfG4aR2rTXOs/TJpC/Ni+jVbOz19e5BqPuGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0MGDwAaKQcHGr3tsjkn3Y/ftB7FkozYtjJHDMfupYaNY91cfVDBu6D+v+KhxTgK6pLLFLSJX4N+TQ3otWsvjy77NXy69vkT/rSFZSwD4+1xENpO+t5V+lC6MDNRZ7jz8zn0WtgbbsKJMbMOj5cFq0bam8TG2M29p+ztBSjUif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t47Tpdeh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t47Tpdeh"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R8N07j2503421;
	Fri, 27 Feb 2026 09:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tTy4U
	QjwjXMCB3pTfM6BvJYl6/oelW7t0M0WX6YwZLU=; b=t47TpdehvTjdvO059MJqe
	VTHBDUwM2kFIR4tV5NTC0sk2krFtDX6PrPkBNzjmKmXW6ehW12amuelwHGighXTn
	7ksdcN7WuWoyRGJXkJvy8ZEtXnf+Gy/7iEyS7b0zRfZFmgGt+nPGksJuvRmBaFBZ
	soagLzDRRtNPSpbZS2UkWBOdiHL4T+Uz8wkb3VlMZ0GqLNsAGINby96W2KqCj3mw
	m6NGznkKCfsEXL2G39b/a4FSjCY74zuyKk1O66X1KriGZohb+RRdwKWnE/QZUysw
	GBx6jCsxrry4pGkYr9eFRQ8r+PBtUigzVYGqZJRTNhiwq0Nd3T8cZVl193Xzmr3q
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cjbw3yk8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2XFU064861
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:33 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t40001982;
	Fri, 27 Feb 2026 09:02:29 -0500
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
Subject: [PATCH v4 12/12] iio: filter: admv8818: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:41 +0200
Message-ID: <20260227140152.77529-13-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXyHFLwlcp2Z6t
 P7V8CqOOsJ5SypwIjC1/TkrzzWHbinIko2qu+jYgmFOjhvgGgPD0g3v/7VZQA24BYVIck/axCDG
 JYLGLkiNgi9N+W4kgIOlUVOXJd96E0uwVC6E21uRn00sxbutVzm2SNdwfs22SrQJWb/ax27ZyTR
 K/2tdm+OII4TgMcM2apUEWzjifoFu+kGaUsMcEi+SraFAEKWvdK2EX0UPA7B6I8GO4nOVlpTbM3
 WxZOs4GPDkm3Vefy6hT7M/ou0/zeLW8YV6luQRtVERmgfVuLQoW9h1TFCTOUytn/CAScttQcoYr
 DcMVJp4f7b9s51I51eUSBtW9I4IEG90qGmFg6uyd4CCfVUtqjTaHVFU9tehAUwxkvbQOwwaXRZR
 74d8vqFgzF++Xjay91h4FgHrCI04R+mSGPDB/72p++1D43AnE6Yijn7rwYOb6lF7cxZCM3KizTM
 Fnppbkdu7eIp/z2nlzw==
X-Authority-Analysis: v=2.4 cv=AtXjHe9P c=1 sm=1 tr=0 ts=69a1a3fa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=bzgjXaNoBxcg6uAtW_MA:9
X-Proofpoint-ORIG-GUID: zMbrysNc0nvHdtjgqE-bGyAziFw3Zo-x
X-Proofpoint-GUID: zMbrysNc0nvHdtjgqE-bGyAziFw3Zo-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path to simplify error
handling and ensure deferred probes are logged correctly.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/admv8818.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 5fafd71da2b3..0b9e3ba55476 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -657,41 +657,34 @@ static void admv8818_clk_disable(void *data)
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
+		return dev_err_probe(dev, ret, "ADMV8818 Soft Reset failed.\n");
 
 	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
 			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
-	if (ret) {
-		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "ADMV8818 SDO Enable failed.\n");
 
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
-- 
2.43.0

