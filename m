Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2238A9A0;
	Tue, 10 Feb 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745923; cv=none; b=sKhlck+tKbfuhx/aKs9jsVg90MDuyilMpu8h/USRPuZGh+D8oXTcnfyuRIu0pSKrNzKLoy9WMAk0LZ3yVDeRrO4TPzkXXk9b3OT/WOpL+dyRDK8XKIfdUt6xuBcTrVROy42uuCtCUE1458LA/fUUX9U2gWpkSFdhJZv7hT1V2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745923; c=relaxed/simple;
	bh=7Xuj/mIKkjNbUnjh+5bDBGHrcX5k9yVT/rvQaBOok/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2hpbEp0D+RLnf4kN5x5zdi4t2ZznfDCkCQhm0so4xKStnZyhmCF79qOd1fFBwqwBssY0rl/twmGegzG6i0H2ECjiXOIVBeDp8I0auHVwfkag74atjFDsKTuGSE2dT9pZvs1AmNTgdtCrq+/gu6J0Rz1EI/rYl9TANAqpO+auPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dYjxsYWC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dYjxsYWC"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ACM5MO2180773;
	Tue, 10 Feb 2026 12:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=b9KEPAmRtO+eyB4oGemRgHhPIaT
	F8P16baV/aW9bZ64=; b=dYjxsYWCS7VBANhsvHIEbzErWLoMxWF4wmk6hRoRcGP
	VeLtAeyiC3SU/vXTs4ndvNxaxeiozMdEf0F2WPZS6R7CMhpyUwSHhgib0XF7+KJC
	yeH7o74CT+6gwH++zuTsU8hzwi1UrROHL3rWmhemnHyJQuxKt1G7f6Ha4qCnQpC9
	YU9FVsIhrLf7ObMR8aYiZze2lh4X2xy4YB9MItz7BotsdjZPDkC9oB0R9KpMrf9P
	60L4khD7oaZaoLq41t9+Bfa+gW9If28OTvqd8u6gg2RqXuG85xmBliFpFfGESpsp
	yINkncsp63CX8H8u4Fh4aIlP5DdFxVvlYmG/zv0WuYg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c84m594fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 12:51:58 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61AHpv6M003336
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Feb 2026 12:51:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 10 Feb
 2026 12:51:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Feb 2026 12:51:57 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61AHphPe031424;
	Tue, 10 Feb 2026 12:51:52 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: magnetometer: si7210: use devm_regulator_get_enable_read_voltage()
Date: Tue, 10 Feb 2026 19:51:28 +0200
Message-ID: <20260210175137.44178-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0OSBTYWx0ZWRfX+fWgu7WHB7ZC
 A35X0c/S2E5MmRBItWxeYl57n3JM8XFfsLvs9cm76HVe8AA/9Qrw7EjnX2/bvy0OZ3ZYob0ierN
 MSZK3Xz9MdAtw0qjiMUhFdk3600lkL5M3OV/nnhGZTbJqYffZBpwWI532/K9t3xliwj5mX067I2
 lISJaFGfklUmJQHbCfRxBgjCRQRmzrCH0wYxA03myWFIDh9rckjJoaiA/EyeW2smw77fgty+SED
 Oar/T7BYcD8KZydk25u3SQGCD8BVuoxGwndguiOlgxpSBNq4E3YpudJtiK8Au6gz9cbHvEQtBC/
 fPV6zlHW5GKtR2dhqZPgNnCbA2aaPDJkJetATUBtPHmqOn/C9wEV7CTrnZMbdHGaierYBGVC4gM
 DLyePhuGwFvS9rNU3PRhFYz700RZJg40yrtRdh0qgUK6jUek2X7FSu10HcOg7xzMtq8mfCGjdVc
 APObV4rL9FAhBKAy8Gg==
X-Proofpoint-GUID: 56halFmPkoaRrEIVq2_UngZ_9Lja6qtj
X-Proofpoint-ORIG-GUID: 56halFmPkoaRrEIVq2_UngZ_9Lja6qtj
X-Authority-Analysis: v=2.4 cv=Fa86BZ+6 c=1 sm=1 tr=0 ts=698b703e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=5qM9zpv9ERtmsko8wBUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100149

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call, caching
the value at probe time.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/magnetometer/si7210.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
index 27e3feba7a0f..0a7a610fbe24 100644
--- a/drivers/iio/magnetometer/si7210.c
+++ b/drivers/iio/magnetometer/si7210.c
@@ -128,13 +128,13 @@ static const struct regmap_config si7210_regmap_conf = {
 struct si7210_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
-	struct regulator *vdd;
 	struct mutex fetch_lock; /* lock for a single measurement fetch */
 	s8 temp_offset;
 	s8 temp_gain;
 	s8 scale_20_a[A_REGS_COUNT];
 	s8 scale_200_a[A_REGS_COUNT];
 	u8 curr_scale;
+	unsigned int vdd_uv;
 };
 
 static const struct iio_chan_spec si7210_channels[] = {
@@ -221,12 +221,8 @@ static int si7210_read_raw(struct iio_dev *indio_dev,
 		temp *= (1 + (data->temp_gain / 2048));
 		temp += (int)(MICRO / 16) * data->temp_offset;
 
-		ret = regulator_get_voltage(data->vdd);
-		if (ret < 0)
-			return ret;
-
 		/* temp -= 0.222 * VDD */
-		temp -= 222 * div_s64(ret, MILLI);
+		temp -= 222 * div_s64(data->vdd_uv, MILLI);
 
 		*val = div_s64(temp, MILLI);
 
@@ -396,14 +392,11 @@ static int si7210_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
 				     "failed to register regmap\n");
 
-	data->vdd = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
-				     "failed to get VDD regulator\n");
-
-	ret = regulator_enable(data->vdd);
-	if (ret)
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get vdd regulator\n");
+	data->vdd_uv = ret;
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0

