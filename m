Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F5426EDD;
	Fri, 27 Feb 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200961; cv=none; b=XvCNOcoiDVcq12nnvi9hz7Qc8+/Piw5QdB/QgVRqbVHkz1tO899rYhZ5bMtsS+sTw/C2IgKTNPHbfgJqzF0fImaNEOdthfJXxBzoNWEk33hqCb4E+MKK8gtqcGSXSmFg/px+CrqSuhNrFkzXnnfRbqsCtGIX4tstZdTbolAR7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200961; c=relaxed/simple;
	bh=GuuWwLJ6njYTtZ1JiTfEHEIz79SGVEnWz2x7X8FpBj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELT0m+XCG6CACbJwjynlStFsIOzIeMId2IQNPPJvd5nP507i5hfzs96Ufmtdga3EDlLkuTdCRhlA2digGoVBcOL3LMh/ZwIZqPxSpXripSMZGIeCMVfoAW05kuIVjiabS/qsUHk66deNmcIpsZK6RDH/5r5BHHItFUm9LSJPM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OOwUNT/1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OOwUNT/1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RC0bGp3025436;
	Fri, 27 Feb 2026 09:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d75vg
	3L+dqBXCyoT8acH6+8Zz8oG43fZ3HYHTETG/JE=; b=OOwUNT/1hQKI9q3dUkcYy
	ASDU06P07OfHRti4A5QzPXf7Wcp7wLa043528/Ycc5LabmKL09DbmtvNB76aYUeD
	/PDCMU2c+N+XPsfCCVb8AbinGiPOAPbYsrEhM7EHgVsoKE0hB3VTzD5HFiUKPZnv
	jBSLt7WgUUPrtUWW1nEzxZMRGdsx6P6za1C6tiStb1HKhnGqhty8YLmTBqsDDT/U
	Uy1T6uDe3THjjRkdjD8cFiiNYNSRkRlbTiDarLo+lE4NMEeAaviiwt3V1de68fgC
	8/M4TpsqnkXTmi1TQjpyLcAEEG+t/Zrkqz3AG8ieo31IyKDoOJRr21eWz8BbSm0I
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdgbyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2J8f064816
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:19 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3s001982;
	Fri, 27 Feb 2026 09:02:15 -0500
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
Subject: [PATCH v4 06/12] iio: frequency: admv1013: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:35 +0200
Message-ID: <20260227140152.77529-7-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a1a3ec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=-l8ofh8svJz_XcbgydgA:9
X-Proofpoint-GUID: 0oWMRCxUtD_7kUiaVViBUr2oiJ4oOAzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXzqaZvcTLX/0G
 vfp+E6J/8NlBIM+Pj8nMQzXMM8HEGeZngHPtSsePDE0Kd2PPUdegy1+nK4ESwgZGQdTL/Qq29NQ
 FT40MvVxxwFanjIOvhdAGLfKgU7FfjrhfbUm6oZMLv3acbyFJKe0B+gPMxw43DOG3IfP/hmcgwN
 mMqSZ//9OFtKdGlPQ6K5lC0NaRieMVLej+kmYHeJPX4MXgEtI6CXBcIOfIHI270tJsoct6ZFtA7
 Cd7z/ufvGczZNhQTZpV11HgwNIHxdGdG9FQFJUly6OlAlXS2vplhjApG+60E3v6jC5Gw2O41nKM
 TA+4C2LGBtrNP7uEn/1OPd9xCjUF4hyqdToo3m7i+ddv0EkRa1trW8/P8AJQkSAenm/NnA6opys
 NXC8hiT5538mxQDbtvvzOFjI7qC7dsIlP2TOxIq2WWOT/Ti/QsWhMPBcjB3icPw7rNZgu/W6Jk6
 c58sFGv2SYjvc7H3jWg==
X-Proofpoint-ORIG-GUID: 0oWMRCxUtD_7kUiaVViBUr2oiJ4oOAzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path to simplify error
handling and ensure deferred probes are logged correctly.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d29e288da011..9202443ef445 100644
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
@@ -461,10 +461,8 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 		return ret;
 
 	data = FIELD_GET(ADMV1013_CHIP_ID_MSK, data);
-	if (data != ADMV1013_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (data != ADMV1013_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL, "Invalid Chip ID.\n");
 
 	ret = __admv1013_spi_write(st, ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
 	if (ret)
@@ -602,10 +600,8 @@ static int admv1013_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 
 	ret = admv1013_init(st, vcm_uv);
-	if (ret) {
-		dev_err(&spi->dev, "admv1013 init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "admv1013 init failed\n");
 
 	ret = devm_add_action_or_reset(dev, admv1013_powerdown, st);
 	if (ret)
-- 
2.43.0

