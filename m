Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CC423A6B;
	Fri, 27 Feb 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200955; cv=none; b=OtxgAs2ARjZkiCXhUjWmuBFHUMsFArpK/VuKatuwwSUgmuuNq1VBM8d+czaZjBmPeLglNwtFKOM6XLTGetwkSAmxWJziJJP+QsNlcDvHP48lbRyhtnLGSNvfzYUpv5Dmqb9pVeYiVLe7uHNHFEQ4iBwEkARpBIGaPbfdrgMjsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200955; c=relaxed/simple;
	bh=g6eO3s5rFnTdvnNMAQl/mYoZarNKwZi5bs4gNrz+KGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnFD/56YJ3BJ71++B+xGTC7aMtjZ+yByAEQWFM81LmeKSUIZCgiMd8D5NMOB6OzR0w8DfA/Npcsd+eriv9Trm0XpaHyKcqpJE7DtslHDhXX41Gr/ElJx2mbRDi7KGVJ0kJgJoDyJIwrrWiz2xuxzeyu5duniFdqqAtwpZ5yxMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HcjiN0Ke; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HcjiN0Ke"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RBfx5N1380254;
	Fri, 27 Feb 2026 09:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bwIZa
	hzf/2xI79oT6khag0iXQuYtkUC6EXcy89W3+yg=; b=HcjiN0Keh1NOqWXcbDqrA
	7SygvoAkwzE59Kkj+FTBRcvxlwx+7aZ72/oGvOaaw1dl9joUJZ37bHquD80IlMU4
	YFGFUop1FDykSm67auypGrA2yujaDYNDVBhDeoR5bLpG7JMm31OvdZ8zEjhL8Gr3
	hi2YVoxx4Y1Rx7aPI988vvJNYNRLGfah9BlxxF8PfhJ58BARauusI1XkxqIVK8IT
	fVynHnL66ic3lyuFp+VjzHQtq2Hk35kD4ofmhl3YRHSfYp6Gxciu2tZo9bIQLRaG
	XPLhB8/eXUSgzoj5dJT4V/ghPU42QdoPy/q7GDYvcx+feX3QvGjbWaJMxRXEsFJz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cja98r2cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2Agh064792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:10 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:10 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3o001982;
	Fri, 27 Feb 2026 09:02:06 -0500
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
Subject: [PATCH v4 02/12] iio: frequency: adrf6780: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:31 +0200
Message-ID: <20260227140152.77529-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXwZWCoCDm9qdr
 yS4Qk2rzJGBlKIdCh+0ifE0YfAHOQ6w6dKhrhZdzFzE1dHUShGjC97e5SrJ9TM3KdLPIcBjszg6
 7DtAGl0ww1EO1FIXPy2RXDkqiMSAK97IvkDpSwCqjnR9QKXW5i8yMa9I3sYPFVbjGzUsdS5bF8p
 eH+ZnPlOnt+S1FYzQCy9cZkp4iGsWOwE+mg/5F67Nue/bXw6j7WMKudNO1w8lMi7owpyIdX1vnW
 hyqdx2q9pEUmLuaZoBvbo3ecUxKkcQ0TllybpsbTAjWCPg5yjQ0tR6SYTv4Z32dEBmA3Q5IhOqP
 pb7HAhA6J8h0ndFG1CH7CqFMEgOV2CD3vgfN8Q24Okbat5lCms591Fw61BhPTFlckxJQTXa3rHq
 PeXy6CfA38G1vMzMiYIh1bt3r6w6YtQ9u6w7Sd09BiQZYpe5IJNNH41PPZjWF/4WqmIqhNwNQK9
 QavlW1u5TEWeLz8huVQ==
X-Authority-Analysis: v=2.4 cv=a+A9NESF c=1 sm=1 tr=0 ts=69a1a3e3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=Hf3kJZ1x935sqW1ssrkA:9
X-Proofpoint-ORIG-GUID: gecItKZ6iOx7FePTKZJ1P0r7cLdb3q7K
X-Proofpoint-GUID: gecItKZ6iOx7FePTKZJ1P0r7cLdb3q7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path to simplify error
handling and ensure deferred probes are logged correctly.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 1899995f7b20..257fd31a0b0e 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -346,23 +346,21 @@ static const struct iio_chan_spec adrf6780_channels[] = {
 static int adrf6780_reset(struct adrf6780_state *st)
 {
 	int ret;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 SPI software reset failed.\n");
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "ADRF6780 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 SPI software reset disable failed.\n");
 
 	return 0;
 }
@@ -371,7 +369,7 @@ static int adrf6780_init(struct adrf6780_state *st)
 {
 	int ret;
 	unsigned int chip_id, enable_reg, enable_reg_msk;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	/* Perform a software reset */
 	ret = adrf6780_reset(st);
@@ -383,10 +381,9 @@ static int adrf6780_init(struct adrf6780_state *st)
 		return ret;
 
 	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADRF6780_CHIP_ID) {
-		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADRF6780_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "ADRF6780 Invalid Chip ID.\n");
 
 	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
 			ADRF6780_DETECTOR_EN_MSK |
-- 
2.43.0

