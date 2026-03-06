Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB433B2A0;
	Fri,  6 Mar 2026 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792755; cv=none; b=mg8JIs+QMszlytOmnZWXp9/hEAT/+wcRgqhEDbZ9r01ewRKz9kaSmQXLkvn+bG14U0ftjhNdgCIgGuQXp/lGT6fA3oon/kYPF2EBrkWCJYzIumqLZYHchVo3CQRhc71B3Y6CtuyAL9TeOp/iVDpzOC0QdivdwkcPfeUdJnq51os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792755; c=relaxed/simple;
	bh=/1ln1f5ASvqMEhGgj9sKTz/Svc5XSdHZ5ERyvUNc96A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYcDGnTNKk2c182qjZ9rj0wnwNei3GF0jzjOlhTiMOQ4j9spmVwEM1qGmeWkIULinKqwT0tc2uGcynFsbgkrPyZZL9V0axQrQGw41Aeg2hvubBPyeClAS4RkEpy6pmohXXmCpcHxjASNTJnOmLzDyl8l/N4dNbw7Mk2AUf5Pg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=odjmE6R0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="odjmE6R0"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265mv8H2756978;
	Fri, 6 Mar 2026 05:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JMH9Y
	cstxDSXDcLa5QjRkSbMp3wKb8bGd3J0Yg343RU=; b=odjmE6R0WdkEcFjYyrAzw
	V8ATQmEskqcfgCEej33ovI0pLHx179K0MubPWVW4z0ZVgXcw1lxhp++Z2yPKJiDz
	iWUV/WWNW6+mAI7uQpXQIsFvGfpYeBecpj6/r4wL3OZZkGtkxFs+IWg8vCQupPhW
	86w7z4scm5eHTzfTJNCSYbxOQoa1EVrlI+i1Gg6OlrGPUQLG48l+ibMtq2Z7JLQl
	heHaKOuSyEEX971WA0PG8skC5IYFPJbYo1hyE9fWBqd8x/Ga5FRGKY+EChDJHUe6
	zJUGQKJ30bW6wEwKvZ0XkOj7fgM0sdLap6bYcwOQPLOq6c06cTjgXZGwwGz5/kFa
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6gxvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:25:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626APWbx007762
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 05:25:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Mar
 2026 05:25:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 05:25:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626APG2U003684;
	Fri, 6 Mar 2026 05:25:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/4] iio: frequency: admv4420: use dev_err_probe
Date: Fri, 6 Mar 2026 12:24:46 +0200
Message-ID: <20260306102504.42395-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306102504.42395-1-antoniu.miclaus@analog.com>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX+8Q9chPrhgYV
 UXJZO9vRMKeffQXY9SoiQt+kqiTASY94IYjp2CBkLNy2Imq2IpmiWZtDG75CX/knNiJw7n+fKyQ
 ysE+aV2Na6KDyKnFiZ2Q8l7fN3XTe1OMPDM2LXnn8P5g9SqAUoN6QoO905+1RRn1GcNlSVp+smo
 FlN6D/pRztt6UcsX7PVsljU5Mgk/SJJZ/b4v+rtcaC0e4RoV+zKW3WKfT2y08NshykQTr6idv8q
 SuLYu19upEAkD11t+oLsBxL1LJmqEnp6si57t1AW7qgPmdBwGfV2Avj1mvLrXWXGNWwaKDA7wJA
 uLSFi4CnCbDUa6NOfHW42eRZNERsRZbpJuvlcSNWM5FOyZhHKOdj5h+KqeVEJRapSwgvBykq4Uv
 lVsi32nO67Nufuty5RLsR+l3ug9ddqj4jCZvsIJ/TtKD9O4ulq4GUP0bNhzV6So+ynP0B81CeRX
 WVUlCSpv4zmH0OoSMzA==
X-Proofpoint-GUID: h-QtoGPWu_dxhm9FTLvWqeiu92ZpCpFG
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69aaab9d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=rh7gjDiLLP6ny2FSsboA:9
X-Proofpoint-ORIG-GUID: h-QtoGPWu_dxhm9FTLvWqeiu92ZpCpFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv4420.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 6ebfe08fc211..2416fe850ecf 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -279,10 +279,9 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val != ADMV4420_SCRATCH_PAD_VAL_1) {
-		dev_err(dev, "Failed ADMV4420 to read/write scratchpad %x ", val);
-		return -EIO;
-	}
+	if (val != ADMV4420_SCRATCH_PAD_VAL_1)
+		return dev_err_probe(dev, -EIO,
+				     "Failed ADMV4420 to read/write scratchpad %x\n", val);
 
 	ret = regmap_write(st->regmap,
 			   ADMV4420_SCRATCHPAD,
@@ -294,10 +293,9 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val != ADMV4420_SCRATCH_PAD_VAL_2) {
-		dev_err(dev, "Failed to read/write scratchpad %x ", val);
-		return -EIO;
-	}
+	if (val != ADMV4420_SCRATCH_PAD_VAL_2)
+		return dev_err_probe(dev, -EIO,
+				     "Failed to read/write scratchpad %x\n", val);
 
 	st->mux_sel = ADMV4420_LOCK_DTCT;
 	st->lo_freq_hz = ADMV4420_DEFAULT_LO_FREQ_HZ;
@@ -305,10 +303,9 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	admv4420_fw_parse(st);
 
 	ret = admv4420_calc_parameters(st);
-	if (ret) {
-		dev_err(dev, "Failed calc parameters for %lld ", st->vco_freq_hz);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed calc parameters for %lld\n", st->vco_freq_hz);
 
 	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
 			   FIELD_GET(0xFF, st->ref_block.divider));
@@ -369,10 +366,8 @@ static int admv4420_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
 
 	ret = admv4420_setup(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Setup ADMV4420 failed\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.43.0

