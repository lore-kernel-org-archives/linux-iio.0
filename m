Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808C3F4135;
	Mon, 25 May 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727291; cv=none; b=U7EpO6Q1lUSWgeN0wHcWB6u39BpFrk9+RVcvq9FVHaIVCXcutZw3HkFoEeukPlzAqdrshV56pqB3Rc7nzPoPBy9pbEO+0mdyoWE6PMFPnDO3JMUg2Xuz6QCg5nefa535kDykq5hZ04I1KNJf7SSx0YIeoTGYAc9JJmE4miaXuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727291; c=relaxed/simple;
	bh=CudadbESsfPzbX+9jpFxGWvHGBZpQrm/hKaD4Z/NPp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKX4K9+0xXIUs3CVS4rnakyucS21zi9gNUdiHvTaKyIFeN8cabC2ljf4B1Vw/MrgGFTke0Bsg3gALPKMB4aw07dRtFrE/uzbQVAboSbn4Nf0VvwhbU4WWKrOrOrr3AlDx39FWlWSfTWR77qqq7HuRGZKL7POOTh/KkWmf/S9ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=udWwTl6M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="udWwTl6M"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PEf1gt367433;
	Mon, 25 May 2026 12:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d98MD
	gyScq/wOgX4sBvqzz2B3F4EAaPSoGikth9OtC8=; b=udWwTl6Mml6f43R3WoRwf
	Bx9uWjEn0HKoW+5Q4ACmGfIGxTFiJAfiB00X4PvXzq1QniKi8KvupTVGPiAZVXmD
	Vw4Un6SpwHoS1CUBVEcIpV1xAH4wq7cWSGBP9JdWVEvQMI8BZk8An3nH0J/yjM2a
	tAmjagfulTH0G/P2Y0G3jbBggtA+cKNq4iHnLXKgtxzRGfv8ZcqRORKOWJnBc83N
	qIttYN+SztYeAIykHIRjeNcrPDcAN/LEQeYqQPFnn9IAxtO68uhW6JguSUlTprWl
	rsDCdSwHlTVVIK6igjbGpIo33AxMG9qo4LmDXdXBa+tjGWhY/Enf6J8pinf+kUkI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ebwje53vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfPTs022292
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 25 May
 2026 12:41:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:25 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH2028845;
	Mon, 25 May 2026 12:41:17 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
CC: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v4 3/9] iio: temperature: ltc2983: Fix macro parenthesization and rename
Date: Mon, 25 May 2026 19:39:30 +0300
Message-ID: <20260525164013.118614-4-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-1-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX3q6PjwuWJqq9
 jgOAW8wCm0GDQJfmzhBU7sAXqa5N3+UXVDpix0oBYolIkinQv1Ic7Z2G8FEqfkaHlXzvF7nTbAM
 RMfIpPSzTjhk5muDSxiIdYsAF4jyHiOOZcr0BNq3q5q7eFActJjBa+qZFGfpkbIB+G53TyLPsN7
 RkDR8P5oxal/s02CfS+hdcOYAVqwHET3IgVgGIR2cc6IMVv2jJjMzdhTPfFRuUjRe5LjDH04GGn
 0vpMYuF9i1L3yHekxotX3pq2c06BkFhZLb5WByk2QNdJ0t6AGwin5lxgUPJzrapRmJZd0wh7lUo
 3JUWUnSbUInCBEjajahSmMamx/VgHQ7qqbgjJSWBBQEHDSEy6aX8TTCOoIRckK1y7gtgBbd6ite
 QGvx6prFHb3pq+AdGsgCC5Be4mz4yK8FvfRBHMTD6pJLWLSHUJ0u97Txjg0lRw2b+g3MpKGjCCP
 MGhVBVN+k+h7Byt1g6g==
X-Proofpoint-GUID: x9_FTFLSn-GnGwAWHLlnc0lWxkyzyIGg
X-Proofpoint-ORIG-GUID: x9_FTFLSn-GnGwAWHLlnc0lWxkyzyIGg
X-Authority-Analysis: v=2.4 cv=fKEJG5ae c=1 sm=1 tr=0 ts=6a147bb6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=NK9M8l_gB6tpaUwuH9IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250168

Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
them being confused as related.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

 drivers/iio/temperature/ltc2983.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 2bc5cd46a72f..4bae90f03002 100644
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
@@ -1196,7 +1196,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	}
 
 	/* read the converted data */
-	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
+	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan),
 			       &st->temp, sizeof(st->temp));
 	if (ret)
 		return ret;
-- 
2.43.0

