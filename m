Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1134FF58;
	Wed, 11 Feb 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797942; cv=none; b=cm4+xDS4z2uVpPTOxE3UeGb2+1/SF/gl3Arwefo9+CAMVxR+vH6vY5Hlib6r9uv2Q9uUTmr6a4wDf56A8NmoXtDjeb+kjYMyVRslG35pj/NFqGVEElGFVOt8hC/uekFExg+a7O1o91nbVlGUp4DcEEWbmlzICqMivORYw5x/V3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797942; c=relaxed/simple;
	bh=wfNTEq2Eh8n+Ab5/65LL5S7pEOwyCNWra0AoJRn0a0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EToZ29a4dYLk4AX/XeEywS4eAEzER4y0XjCyYCz5CUZKxq6DkMlVRlKdSB9vBBo3wrW3lOI+2u7vSVGGJxMurjLqTunfCIzs/tvmmStazqQE3Sm0mZRsC3aVSqvE880H66+mAERacLzSInFvPCKEy+tIHhK+PZUc4jdY3NOFcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g0uRSuRf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g0uRSuRf"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B4LJMS609547;
	Wed, 11 Feb 2026 03:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=40we1iTS/N8XNqUk1GxBbz/eRcU
	U0JomQA8PulJIDoo=; b=g0uRSuRf2WGp0EoPRZKnaaNsIToKP3lbiyFUJhEJaMr
	rVGiDEota8LahPsGABNxqOjvhmMf167FHT8ygAlO0R5SW7bd0pPhA49J+/+fnleq
	opzqyxQOhkMMi/IyQVkIlyi7RhEyKQggjGrls6u1or87RR6eBJoWCXJDiMuFg+Jt
	rQVJWLBBJJ96OfCCX9VY56X579wabMWSfqLYqaMbdMKWcjckREa65mF4Kaw0Wrc3
	xV2hPJwTruDOW4bVYkPY3m9/xTci4pSSikZ5uOTjE/nnv5HK8N/kgN5stfBXwHiX
	OB0yZTY/MCgcJq9S0gxg3EelJs6xY30fsxDZ0IR7C7g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6xgd3ptp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 03:18:58 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61B8IvJg018450
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Feb 2026 03:18:57 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 11 Feb 2026 03:18:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 11 Feb 2026 03:18:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 11 Feb 2026 03:18:56 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61B8IeLV020013;
	Wed, 11 Feb 2026 03:18:48 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: magnetometer: si7210: use devm_regulator_get_enable_read_voltage()
Date: Wed, 11 Feb 2026 10:18:28 +0200
Message-ID: <20260211081837.8169-2-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=I59ohdgg c=1 sm=1 tr=0 ts=698c3b72 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=OxvvlSpeYWXECvea1VIA:9
X-Proofpoint-GUID: Nbq4sNALkuE0SYJdmwBju0uurFN4l0dM
X-Proofpoint-ORIG-GUID: Nbq4sNALkuE0SYJdmwBju0uurFN4l0dM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA2NyBTYWx0ZWRfX+WZAqeJeHr3b
 6RpG7sPMRzFuqM+xBHFo1REYDjhripHG+yIr3tPWp08L9IJWH7dBAQq0Kf7fY9hDqEIwU69oqYZ
 faxyOM5rOvppLLcGiBQtSOaIRnqzT6FQECigBQWkqN9/YcvtbzmVOZLchUDiSrqm3k27Z4eiUA4
 RgFTbSfVnebR351SPOCvN27k33SSGWYB9yqWuLXdL4wG40aKK7ttLmiSMbKWbeWQv15oNabj+SW
 Oq8g5aA5UpDnc27P4Shg5l/hLY72qyjmWYJM3s+7dr2yIgkxpFeTIlj3RIDYxJI9REATnboS9qT
 /5EWw4yn+ck19G9YUIfPMhSsQtodPwnUTquLmnL4QHCeUgYT2l7CtEAqu6mLxelsTpgrZQQpo3F
 4G2F0UB809ER/Nmm2fKKEC74dvU+TUVcnuV3xxxnf6E3hITxIxt1KbFQ0/gJTYpSMTbuVRSWBdt
 gt0yka5N62Ev6ATteOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110067

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - use vdd_uV naming convention
 - remove unnecessary div_s64() for 32-bit division
 drivers/iio/magnetometer/si7210.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
index 27e3feba7a0f..8b98dd4dafa4 100644
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
+	unsigned int vdd_uV;
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
+		temp -= 222 * (data->vdd_uV / MILLI);
 
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
+	data->vdd_uV = ret;
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0

