Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BF428820;
	Fri, 27 Feb 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200968; cv=none; b=D/VyX7MFw/B0pm08FafcsbnpG6oIXWhlt7iXZNVoB1ka7NQUYus6G+UkujO5n9R/mlq93eS15cICC2vzb3a0Qz0I34WNwLTfjZb5qVgRctRqYzjWGmapQF8pJPUcO6+eQgm9JvXWSdSE/eIWS1GEPZNslWBCLBJ7dzRLwuWKJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200968; c=relaxed/simple;
	bh=FU4UKwNtcGttS8EsQDjVjV/j7nZWls5PYrFK6wJCWp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEuSWp0rysbMCMsu2Cd2GaidW3dp+lXQevk2cU21Bf/xwRHSmr9o08q+OoI6xHe9cco1KTyHf6EDw3ZyfPT7uho69mHdP9ZnMsx6gyKraCH6HFoFM+u3nrPxPW2eFor73rRrbrk/fxCj71Say/DBA+Q3tW7ZnH8DBgwNVQvj1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CW0lmBKC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CW0lmBKC"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RACUY12502285;
	Fri, 27 Feb 2026 09:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/I6Rx
	aKz95PajiTSO80ix/Q+En69PBeEBx4xXcBSUdQ=; b=CW0lmBKCuLOqQf9IAtl54
	A5xr7JX7CpMdTUxjxZC3qWK7dLnWj2fxfy5GLWAhY55n4pN98KIhA7YrgloIUeM7
	l6fidHn1Xee2sHzo9vdGgmkNi+w0UOo3ZsJe8MA+Pp0dBStEgWXgmdjsBhdNDp07
	Gju9SUFURdJLwrjVNEYOXTp5/cWRYDlZ/zlxTcmUZXPwMo2fA2viSnywfPCBIcbf
	7uYphLQF/I4JR1MGKMKWda5xjHoifnjNVpmNfg/LdfcuRnb8+0WUBkQVZgqdvxqY
	kSfrEgaPraJ+voCPyXiGAtFf8T562fszmw6Z0iKx+BMYlZxrjOG6dTlsOiiWA5fj
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cjbw3yk85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2TI3064847
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:29 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 09:02:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:28 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3w001982;
	Fri, 27 Feb 2026 09:02:24 -0500
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
Subject: [PATCH v4 10/12] iio: dac: ad7293: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:39 +0200
Message-ID: <20260227140152.77529-11-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXxXhg8Pwdnc59
 QeOAS9kD3ZBxRlmIU5DOsbSOtfgnEGMNAm2Jy8NgkAGpyXk6d6yLqovJP/BJAA8VUsEnHWAZX6r
 wVGo805qLWWpDFuBmwwNNv9g0fx92vUlOCiCnVZ7ZJ+o+SMSUxm2vyZPsJJW1oZeGSBQXFbjdm7
 v7FU1ubHczgx9s3V+lPz2QT3Jtql5a75MEM1POIhGcYPnPmvdUU4OH8iM1IUKy4KvecTA6pyRka
 aDP1YQQGsYVofa+lZoul36GtpKsOE6ukmvK/5r0faHciitg+G/9eXL3D1s4NoeqDOmuLXUc0k+N
 0EpAO4QbzKZxEyqQwhr2sCZBzk+z3DePl/8ND9CeZTIjvvKrUYvnWuekfs5dogRNsCnCR2cLRlo
 0z3wrD/a8PFAledl1Gzs/EACp+janyv3SMpkRiiIGEwWLnd2Ol51I/ohEg9BDxRtanQYJVRG147
 Q+oBttyUtUFFh6tjeNA==
X-Authority-Analysis: v=2.4 cv=AtXjHe9P c=1 sm=1 tr=0 ts=69a1a3f6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=iLbTipQpLQTOoodFea4A:9
X-Proofpoint-ORIG-GUID: AFcg1IfV32TYHyc8VkNIXp7IR5raGWKC
X-Proofpoint-GUID: AFcg1IfV32TYHyc8VkNIXp7IR5raGWKC
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
 drivers/iio/dac/ad7293.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index c86c54d53df1..df6f126abf05 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -806,7 +806,7 @@ static int ad7293_init(struct ad7293_state *st)
 {
 	int ret;
 	u16 chip_id;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
 	ret = ad7293_properties_parse(st);
 	if (ret)
@@ -821,10 +821,8 @@ static int ad7293_init(struct ad7293_state *st)
 	if (ret)
 		return ret;
 
-	if (chip_id != AD7293_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != AD7293_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL, "Invalid Chip ID.\n");
 
 	if (!st->vrefin_en)
 		return __ad7293_spi_update_bits(st, AD7293_REG_GENERAL,
-- 
2.43.0

