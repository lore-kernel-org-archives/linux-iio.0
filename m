Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FE423A83;
	Fri, 27 Feb 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200956; cv=none; b=uzswLa2P+juCvLhs33MTx3xTeew7MdKqgeurexfdG07vsUkIFvnNutGV2qjbXpYaxNo3Zu1Zm47v88n238+s4dvDyyLx1q+KYq2wmAK1Lgj3D3q+u7e+jsjCVYMwWoDCih0F9u5rT3b1LCGcgbj0c3RaXS7CbwvA2/zZb3RMWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200956; c=relaxed/simple;
	bh=2Ch6tPmhTC0Lswo8HeSwVeBN1MHd8JHIo0Qx6Oxac90=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbpDUO/qTEjveObp9Ph5yNwmrNQLIRAShO4tvHjRt6+bV+/BBJzc8B3ZZs9U9Dhu1K4kYD10qlkvQJQ7c5eBqFYwfC3r36fruAJqQUPu5wuzPm6sJYk0/KuIDDzfz6Hds2/XaKRO+DS2QNihM+HmNO+h6qUD/Z3NH21w4MoNH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WDtSNiPk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WDtSNiPk"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R8TNXu1869280;
	Fri, 27 Feb 2026 09:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uU4u4
	hNtxkhUcPsn2f5KtM8AR0gVA6XH8HcXyHeZIsA=; b=WDtSNiPkSNFjSGdL30Y+7
	PUjC64U1XLr+EbcKYsi+VNdNQvagsZ9QMpmlaqgqnS9JX+5LSV1H41upJv/POzp1
	yEum+mBE1SmsOCwaat4iUdFr2aHqtYlbRMF/mXwVme5us6b4mcxVERlQJwsjpdME
	h32fgPU9nTM0Qmi5xWHqs8lQwtVcXbFsoMPdgwJmDf5kk/oX0sHxKEfqo3cad2rD
	6DFb9o9LzNcD5AMFOPR84yVt6gHIprF0+ys5y0P4xcMqXlDkrGpxKhez0BwBp12t
	Zq4ofVPEt4OjDgH6stmsS026dTIGgaMj7vacwHacRS7OuET4NDnOhtwIEmktLlJ4
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4chvwgben5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2FOS064802
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:15 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3q001982;
	Fri, 27 Feb 2026 09:02:11 -0500
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
Subject: [PATCH v4 04/12] iio: frequency: admv1014: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:33 +0200
Message-ID: <20260227140152.77529-5-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Dcgaa/tW c=1 sm=1 tr=0 ts=69a1a3e8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=YSkx0eS_6WgA8UCED4YA:9
X-Proofpoint-GUID: 9Y5c8ZCqtMPLsa53CVVmGQcmZsDIhkNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfX1vruIb5EfOBD
 CU2y7suzaMaArkxhK8I2nvx2LX0axd33jMo6WKVww1BrQHd99pN+tap2F5RSs/+Vie1mMlYceGI
 UGpK3hFn6NQPhvTVKmRurho1x3RNx0z0ktfkAn4NFmnBTMQk6q0vhjKbo2PZC10BWfm2ZpAiDWT
 vK9W3Qx8Kzo4CoAZArBfaTiLdyyV4rHjlaQQGYRoor8EUhA9pQLoAI9F+gdfm5RG1rc/L4/6sMF
 wWa2+WU6SDenDl5aO2QokfNRAV2eqIpis6AVZmwl4ZdcV+kR7rD31L3SVYgVRjpae0mNx3r4Naa
 9rEOz1O0WGUp20opp9mgmomnA4Y90UGMCklEC6OtagUu5x8cg6aeacn7463tUkZlvcOJZV2r0ar
 RNZXbSHD0IhkI5un9xF3qQMwQvKxcS7LLSzOhOa06/k8ACKRi++09b5fKXKQQcG+yw/r8J5BeyF
 l2kSYRzoiI6JeXNCs4Q==
X-Proofpoint-ORIG-GUID: 9Y5c8ZCqtMPLsa53CVVmGQcmZsDIhkNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path to simplify error
handling and ensure deferred probes are logged correctly.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 60 +++++++++++++-------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index f829c4595df3..25e8cd8135ad 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -614,10 +614,8 @@ static int admv1014_init(struct admv1014_state *st)
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators");
 
 	ret = devm_add_action_or_reset(dev, admv1014_reg_disable, st->regulators);
 	if (ret)
@@ -644,55 +642,47 @@ static int admv1014_init(struct admv1014_state *st)
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 SPI software reset failed.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 SPI software reset disable failed.\n");
 
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
+		return dev_err_probe(dev, -EINVAL, "Invalid Chip ID.\n");
 
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
@@ -741,10 +731,8 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 
 	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to request regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request regulators");
 
 	st->clkin = devm_clk_get(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-- 
2.43.0

