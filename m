Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF20383304;
	Thu, 21 May 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381911; cv=none; b=VXyEQ6DFtPPmFzcPSGTb0Q+au4IPcQYpyj8qenLPIK9DVHZ0FM/Ye+PBs7r0whw8URLc9RljTLvebX8Y6wcvfrgHg3kS1/OGHf0lpmrkN1gIOBfP4VUtCTUqrrk6xjo2yHp3Mzk5DHYK/89u9oDSjOeH1DPmoEqHKeWFoOst/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381911; c=relaxed/simple;
	bh=XRkWNNG5Hg7rhStGHHUc0jjdRA6wzpSLFuTGDWL4u+0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSNUrYR0R+or3YWKOHf0NFM3tFr+9657iwf1f7/ktEXS6igs1ew95UfNF/SW/s34iIyE2fOQxf+3JlukQyyttbljHODC8SvJDLNfCCm9Rrd1OOBsSrOP//ie8HqjXVkj9XQYKSLBRt4vAsu+0UGGqP9K1oZ0CiVvtMKm0NGc/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Dcp+jy79; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Dcp+jy79"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFM4iR263011;
	Thu, 21 May 2026 12:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eJ9eY
	G8/CVKIb4mWxI/df25/ySycLq1tpIcZ3pk+wmc=; b=Dcp+jy79B6ArL5r1uX0S5
	uhUW5egET5CKNMY20MJ0Sx0+etXyWy5mY6gEWEXhsBjIwYMsriarb3z1KZdRSnPy
	AmCJRMrYX7Tx0Chuc4m3El9a4HzLnpGCYJPqicgbKtaSbrvWC7yApy9T+Nenp2Xh
	gzHgk3ig7BjO4RiIKtrLryu4BJ3ehNdrcnUHc9qATW1SJiD6GIA587uDyy2AoNrP
	pDjlKtxdoh/vZjHllSyBA+Eq9sVJGVpADtxtvoesnPYkAsYEDc3w8WLNMC1I/Jmf
	Ecb+d7CAMVGy2u4KWUXW1qwn7o7LrOK9XY1rEohwHrlx/oVjHRRpnQwp2k5dwqKE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2fa7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGj6rg000333
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:05 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0l024538;
	Thu, 21 May 2026 12:44:57 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/8] iio: temperature: ltc2983: Fix macro parenthesization and rename
Date: Thu, 21 May 2026 19:42:54 +0300
Message-ID: <20260521164323.770626-2-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: jLofeNu4z8xjXjGBpSJO15NZxIZ1Ej4L
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f3693 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=OHmJ13SYX3OmEOrlRk8A:9
X-Proofpoint-GUID: jLofeNu4z8xjXjGBpSJO15NZxIZ1Ej4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfXw64ZlyVNeg/F
 CSt42vkcjXT5fyTJ3u0VOGlE295mltqDn6Hvx9lpgNspIV8K45+aPHsiSvAeWkXWHVC2E6kbDxZ
 3RfHphGLUVsIdf591IK/1HXbUKqvihjr0xvIRcGJZ0mP7d1jq3O2KT9vgxl5UO7i8M1xTIvFmm9
 2VWsa/5xsNACdahgkPCaT0ybMNYmq4icassMu+dVoA6Dn/49ivW0PoGxoxKxud6ajIXqKrDW5G7
 NAJaT37JVbWtkJI/mOb79rtuCtfqLRTeOzPsHEd1/s3LM8OTTDgLslHTyJ1oarp5CSTDZxcYLE1
 UE5ftNMrBqmvtgN7LYeXr5W2nBDZGzdG9NM5RAjJXMPeWQkRg/oTQXezj7rYfOtEkV9oWi56xlX
 h8WlGIfEpikC8VkUVh3hNGAaB1IAMPvXu1i0cwUQol78I/CDPMrKe56m8TlDeboy8LZcALvJIse
 XTbehcGtguNZIrpa16w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
them being confused as related.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Dropped the Fixes: tag
- Removed the "base" parameter from ADT7604_RES_RES_ADDR(); the resistance
  result memory region is (currently) ADT7604-specific so the macro's
  modification belongs in the driver patch

 drivers/iio/temperature/ltc2983.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..67a09934c5bd 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -56,10 +56,10 @@
 #define LTC2983_EEPROM_WRITE_TIME_MS		2600
 #define LTC2983_EEPROM_READ_TIME_MS		20
 
-#define LTC2983_CHAN_START_ADDR(chan) \
-			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
-#define LTC2983_CHAN_RES_ADDR(chan) \
-			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
+#define LTC2983_CHAN_ASSIGN_ADDR(chan) \
+			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
+#define LTC2983_RESULT_ADDR(chan) \
+			((((chan) - 1) * 4) + LTC2983_TEMP_RES_START_REG)
 #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
 #define LTC2983_THERMOCOUPLE_SGL(x) \
 				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
@@ -351,7 +351,7 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
-	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
+	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
 	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
@@ -1197,7 +1197,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	}
 
 	/* read the converted data */
-	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
+	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan),
 			       &st->temp, sizeof(st->temp));
 	if (ret)
 		return ret;
-- 
2.43.0

