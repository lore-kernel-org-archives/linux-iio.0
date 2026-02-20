Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89E346A1C;
	Fri, 20 Feb 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593206; cv=none; b=Et0kV/L3CiwBh4lcmaDqwzvL7oGEKIZ4PAFYP/Ci3qLJ+uOdCQFgS0dM0by+z1rNEK/7LswQsDp2UTD66eC/cF5yGwG3MxTdW69yT4/cdDL05oZHA2w+Z6qECmr2Yd33iltcjLAN5teOt/xit0i/k/SX6Y6hyMdZp8tfhnh1i24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593206; c=relaxed/simple;
	bh=1fA/QhxTz9c2lIvElxS1lIKLaYwaXASLBCsTi/Mrj30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCgFWUmJLQlacKD8OOEC9JZ2Z+sPt2XB0nLWmyKdJShJ7nAw8IL4kzWWuWwI+fEzAFckrWEzWfbIJx3WH7JW+hDaPIC3XCp/O10xDS5c6NB7Qo3BG3g/olIXIelY4GYhZHPRW0nC2UN8sdpuNi6UHhziIfr6U5+1XJ/y0c10kIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qhYNujS7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qhYNujS7"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K890Gj897178;
	Fri, 20 Feb 2026 08:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4Kcoc
	pnGwE68A9yG4p2Sj7hi2Upe2GSSf3vrdrZ4ccA=; b=qhYNujS7ZohTzpTmaFhfj
	sysn/9IyiLL9jhjMaT5nT5l/otl1Ekwd9dBtkdQ8G1b0w85vMMqyXWbrv/FP61oc
	Qg1MqZ4ym03Ve+rp94eMxKuhopOBoq0r/k8D9SwuU5viUfADb7MgIPH/g/fyLPVa
	e+q0xCz7bYel8T1IDCA7jUsjcQsNaUofD69JcyO1Immmz9TKfgezQshyttHjhytp
	c3FIzz98QJo3NoZUzrSh42T2oOndQ3KQPJ5C4HxKQaI5SCfOGDaltXXWlE1AkpFE
	KLtXTbTous0LEVOQnmXn9Y4duLtxrfi+e86FPuOPTDtUmxyQIvQrpJP0KflCIgo7
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce69kkrmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDD9Gk064740
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:13:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:09 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHT009613;
	Fri, 20 Feb 2026 08:13:05 -0500
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
Subject: [PATCH 2/7] iio: frequency: admv1014: use dev_err_probe in probe path
Date: Fri, 20 Feb 2026 15:11:40 +0200
Message-ID: <20260220131151.74329-3-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Z//h3XRA c=1 sm=1 tr=0 ts=69985de6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=v94z4MtexB56KsHqelIA:9
X-Proofpoint-ORIG-GUID: -0k24L0tjMImaLPVI2V0CWyEjnDI8tQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfXwFRlJkbCmSjt
 vid/WWot6e+5xGLk71T1hSDbMrZprFHpMJZ24yzbiiHBykDhP8iTewdHnNf0kD2ZqqN7KDSlhm8
 kx3hv13u0fpULASjK26/ak14Q5qPK8BTZeKBmZuQ/jWjSk4HP6hHsN7rRh4WqXPXz4p+3rYBzxE
 BVeGAufYIn1pObk2XB2HvJBvOZ/b1CdTGXyts0/p12iyMrVUtrxK0fAYub0enKhydl6EKZuacMI
 dKIM6MAYKXgWn4s0a33emk+TF3COct6ef4vZuCf0rVMjLP/RVPOnn03u25V7oJ+6nk+zWXU3+3K
 f31eGuoet6eWiwvTzW/3Jltcv2Tl+fMjvLlxLJbbHCIWJzpQzlqWFDBEP4hYVBQX23hxr/6RuZq
 srwZVHRTQ06LkhzuCYNmdvgkYuQg4oOnvElu3V4TjxCiBZfU2mzS87YZbWqy2ADt/g8Ni6Fjxf6
 8640r3zZGjY8CDrXk4w==
X-Proofpoint-GUID: -0k24L0tjMImaLPVI2V0CWyEjnDI8tQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200115

Replace dev_err() + return with dev_err_probe() in admv1014_init()
and admv1014_properties_parse(), which are called during probe. This
simplifies error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 63 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 7a8f92ec80a2..5fc7c9fdf2e3 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -613,10 +613,9 @@ static int admv1014_init(struct admv1014_state *st)
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to enable regulators");
 
 	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->regulators);
 	if (ret)
@@ -643,55 +642,48 @@ static int admv1014_init(struct admv1014_state *st)
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV1014 SPI software reset failed.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "ADMV1014 SPI software reset disable failed.\n");
 
 	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
-	if (ret) {
-		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
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
+		return dev_err_probe(&spi->dev, -EINVAL,
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
+		return dev_err_probe(&spi->dev, ret,
+				     "Writing Quad SE Mode failed.\n");
 
 	ret = admv1014_update_quad_filters(st);
-	if (ret) {
-		dev_err(&spi->dev, "Update Quad Filters failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Update Quad Filters failed.\n");
 
 	ret = admv1014_update_vcm_settings(st);
-	if (ret) {
-		dev_err(&spi->dev, "Update VCM Settings failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Update VCM Settings failed.\n");
 
 	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
 			 ADMV1014_IF_AMP_PD_MSK |
@@ -739,10 +731,9 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 
 	ret = devm_regulator_bulk_get(&st->spi->dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to request regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to request regulators");
 
 	st->clkin = devm_clk_get(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
-- 
2.43.0

