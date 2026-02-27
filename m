Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC42049;
	Fri, 27 Feb 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198231; cv=none; b=hNoVdjJ2wXDmprEublUd9t9GzQdVi0m/ZJeoTleoItSUrTl4l3hSipin0wKDKZ4J2dsaCMqzgf9EfjaMPQ29KjaUYxt18YirfDg73YVC6xWLehXRYQgb2UB8P4YXig6hg+iikw220C8/woHH3TlvOGtXMjStiaLurS1bUwlNiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198231; c=relaxed/simple;
	bh=s7u+SJffdf5EY0dInOWokcg6ezRZqueDmg9ULaE3xmM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YqMoA1wpF3Tg9jYKm1Y2qakE+SZgmI2Z9wuPtFnMZtmnuTdkKiMXxcdOCiIHPRQ/VxZ64+wnc4pf1CHcv/e7yGFbQHsG/2crWkxNm6UR4AK+k4RM97H/J1uLQ0k6jEyS6Q5e1vdShHEtiM7wSTMH8sYZG0+CDlfv1RgWzgUB+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MsRXTTTx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MsRXTTTx"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RACUS62502285;
	Fri, 27 Feb 2026 08:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BUzO798GZO/LTuSSQjIKI3NQC4n
	RcGuPJ1/knNF2QO0=; b=MsRXTTTxlJGdJcQDuZsTyXJvVpa6l2yGiVofYzMKUhX
	IpYkPzzRjMB5iJER5iO28d1QllQ7frd6V2JDOBDA+fn9mSR/5Yz3K67l6ei1Y5WN
	wv9LSgcZzyoaZ5IGQOCQwJv4l3+9XUX2v2BbQF1Euc3z7Z6BldMEE9NuG8rPF/OQ
	x+SLbBlQ6cb0X06TbbsBSlPW/3TPCLDHPyCgAL4p6ozikpvYTa06BhVQAN8h63J3
	240iC3WbJ5dxDyfnO1Xc8LVxVQRDPQWN8fHkyt2B219JalaQtKb3OMPZofqVuPA+
	VthXCyFMNHz9oavmS66LGBdZeb12jYltiDsv4x3jNPw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cjbw3yemk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:16:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RDGr7G060216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 08:16:53 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 08:16:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 08:16:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 08:16:53 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RDGeI4032178;
	Fri, 27 Feb 2026 08:16:43 -0500
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
Subject: [PATCH] iio: frequency: admv1013: fix NULL pointer dereference on str
Date: Fri, 27 Feb 2026 15:16:31 +0200
Message-ID: <20260227131631.62303-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExNyBTYWx0ZWRfX/KL0vs9dMHX8
 EsGDNcCfLkRN/saWxdnpUPRercl6VXkKJZpycw1P5xXPCCuXZTebsKLUiheyEysBPRya4e+D2Dh
 TI+Vs3VrxQGXCyfP0VpAb46VvPfPrbvSGV8Q41a8l29u29B1wpF5llBIsD97O2ttYr9iyXvvtIm
 USUP8sIOsfHWaHY8oToG/+cnNDdD87PIyYuzdNsGzPNpfZN1G1jtwRl13Gc/88TPpidy6uZ0Olw
 MIjRKIXIYSdIVp6f9i4CoNRRMvH/oPkaMYP/Ix3R+ArryojwKLOyTz3rVUqjvlWbH1ntKG6BiFA
 TBLBkxkdN1053GvgK72s3WAST/q+4N4C8NKpF3Ch/25Bd7fIiqrF7wq4SmRHpfl8m7YMZubmAw7
 h3SStg9IxD9FGqkn8YitLAra2YLHMA0KogHMPslVAPKZgs3e5TyNG8p2cmWcESv1x2MFqKEqD7h
 bBX9oMrRDaZAENwUteQ==
X-Authority-Analysis: v=2.4 cv=AtXjHe9P c=1 sm=1 tr=0 ts=69a19946 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=0_-YnQLmfojgUjuhM5wA:9
X-Proofpoint-ORIG-GUID: bk7qM2oAsrGmb473LPLpW6hNJ2YIVIrK
X-Proofpoint-GUID: bk7qM2oAsrGmb473LPLpW6hNJ2YIVIrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270117

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with device_property_match_string()
which handles the missing property case internally.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9202443ef445..a1f88138939d 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -515,34 +515,21 @@ static void admv1013_powerdown(void *data)
 static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
-	const char *str;
 	struct device *dev = &st->spi->dev;
 
 	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	ret = device_property_read_string(dev, "adi,input-mode", &str);
-	if (ret)
-		st->input_mode = ADMV1013_IQ_MODE;
-
-	if (!strcmp(str, "iq"))
-		st->input_mode = ADMV1013_IQ_MODE;
-	else if (!strcmp(str, "if"))
+	if (device_property_match_string(dev, "adi,input-mode", "if") >= 0)
 		st->input_mode = ADMV1013_IF_MODE;
 	else
-		return -EINVAL;
-
-	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
-	if (ret)
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
+		st->input_mode = ADMV1013_IQ_MODE;
 
-	if (!strcmp(str, "diff"))
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-	else if (!strcmp(str, "se-pos"))
+	if (device_property_match_string(dev, "adi,quad-se-mode", "se-pos") >= 0)
 		st->quad_se_mode = ADMV1013_SE_MODE_POS;
-	else if (!strcmp(str, "se-neg"))
+	else if (device_property_match_string(dev, "adi,quad-se-mode", "se-neg") >= 0)
 		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
 	else
-		return -EINVAL;
+		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
-- 
2.43.0

