Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453337F327;
	Fri, 21 Aug 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335705; cv=none; b=BvdStdRfRxOToFY+Fd/uaoZTUjOvfZc+zJCfwpShtLgQ9xVYjH47Yb2cTP1iY6Gv5Fk78CdEaFXGBeYqrZ2i4lkITBMo38k1p2aECHByfbjtagSAyXX6SD4xle2OiWZcp/U2bkyVaDcSGh0zNqG6NrzdCfcwpCPG8JOsPbJbDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335705; c=relaxed/simple;
	bh=d1ov1nECp1P5sfQjvxRdISyJL0rGbvgWKEJ6bbCqglI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfuwMFvuLmCZvVo6TzsqoFtq8ZOL8c/NUlXSiZx4Q92qeYO4Yh71bTudx7RS8ib7UnK6t891b1oAqXHLgXqOWmyUDWifPGnXNdNCWeIWSz9f2gR9BTeycsefWMcDZhysQDQKUHZA1L8neOJ/5p/uMrnRlUXOJ2tH7YyG2tJN5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BQy0zRSW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BQy0zRSW"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LI4NfG3253841;
	Fri, 21 Aug 2026 14:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PzbQA
	wGVrLJwOcUCBGCQaDUxjaabvXU6jcGJf/aJj28=; b=BQy0zRSWCeTtULkcPu9y5
	F8KiDif0SCfYj0m7glWZqKGKxTaSPG1vXHaX+sq/4pglk+K8Ogazy0xcGNN4Wex6
	MOQjSQOZHb3hZTMuSzHWZJGMdyiYiftyM7jYJ14SL7Jhga/7nexPCRPZMYeYkecr
	ZLxWmtLle31grq/cAiVLXd4Vgh2T+vL4wO9ERLA0weQxI6Iw9BjXA/EPHmGUi8IZ
	fHTM8BMRhitYdXBWTLe/OHDNPm6bY/I73mGKAruVtPBvfApYk74Acvs7iPFDnPnx
	Ne8JP5rzEmk/xg6h6Gy9iY3V1396t23MGc52pbmX3wqgZ8SS+aBvMiHYeR8jhzse
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g6rga8qsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:08:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LI8K19064952
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 14:08:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 14:08:19 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LI80fN032181;
	Fri, 21 Aug 2026 14:08:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] iio: accel: adxl367: use regmap_assign_bits()
Date: Fri, 21 Aug 2026 21:07:52 +0300
Message-ID: <20260821180753.4633-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821180753.4633-1-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GCW6PJxGy863ikoFia1W4hRUVbfS86Sz
X-Proofpoint-GUID: GCW6PJxGy863ikoFia1W4hRUVbfS86Sz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX4oozLePC4SfM
 DK1ZfsSosk1K4XXm/HsOZjj1uPYZQarICZgSjvlnp5+ad6DAzlvuillzzJUefuR5FoEkqOzwvzR
 jimeFk59wORm4OiQ5/sVJPagmB+jV9c4rLgmoM/E5sXZi9zwQMvP
X-Authority-Analysis: v=2.4 cv=fcCdDUQF c=1 sm=1 tr=0 ts=6a889415 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=6G0qDAfybOyQFWdpEooA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX5DxjKGs3ewth
 uUN+2nDAG6e2LlHqQKoeu+RO/cm+51LFsWSW3iA1aBzjJwPnuLSw9l9EcKyOxEB0Q9TsVWvnpMY
 dQwFo+JrJ74ysmz5DThbwFLLu3p9Wi4XWVpLF+q+NDSPAOFEtLaDuzbIgeIK8lyELM29Fxj7G4Y
 NKN3PzR8YUHGf+B71NHRAXUlxJupyCh6RMm/qOIhlobLAGKHMgzm2cLkV/iUHaGmaTwBhimIt9k
 DlsVLKdicIfvc8H/GZ4JnCf8Vx7JjCKmh7F01y5EvbsxSbc0eqsgmhv0Oubq21HaYHXfS3H/t0H
 fLRNPAtBrbJlYfO5RLAc53gm535j4p4a5OqUytuSQDHzU+c19+beSdXvYN+54g7z0mx/YJZKBAE
 We8K0EsLuTAS5LzvxBZyYH5uzka4+zf6XidAh1B7T9W6bQyq3FNq2hcfqONiWblAaD6ef/DntD2
 svMbPLqAkBzzDfLeBNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210143

Several helpers set or clear a fixed set of bits based on a boolean using
the regmap_update_bits(reg, mask, en ? mask : 0) idiom. Replace these with
regmap_assign_bits(), which expresses the same intent more concisely.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
- New patch, splitting out the regmap_assign_bits() conversion suggested
  during review of the INT2 patch.

 drivers/iio/accel/adxl367.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 4ff1c7a0988b..54c4d1226790 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -366,8 +366,7 @@ static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
 {
 	unsigned int mask = adxl367_act_int_mask_tbl[act];
 
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
-				  mask, en ? mask : 0);
+	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP, mask, en);
 }
 
 static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
@@ -401,9 +400,8 @@ static int adxl367_set_act_en(struct adxl367_state *st,
 static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
 						   bool en)
 {
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
-				  ADXL367_INT_FIFO_WATERMARK_MASK,
-				  en ? ADXL367_INT_FIFO_WATERMARK_MASK : 0);
+	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP,
+				  ADXL367_INT_FIFO_WATERMARK_MASK, en);
 }
 
 static int adxl367_get_fifo_mode(struct adxl367_state *st,
@@ -631,8 +629,7 @@ static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
 				   bool en)
 {
-	return regmap_update_bits(st->regmap, reg, ADXL367_ADC_EN_MASK,
-				  en ? ADXL367_ADC_EN_MASK : 0);
+	return regmap_assign_bits(st->regmap, reg, ADXL367_ADC_EN_MASK, en);
 }
 
 static int adxl367_set_temp_adc_reg_en(struct adxl367_state *st,
-- 
2.43.0

