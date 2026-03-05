Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079A377039;
	Thu,  5 Mar 2026 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702132; cv=none; b=I3qGC/tXHa8uQXuhdiXMvevcu1tpCNheLuIDrIZtnfowPhE0O3ZAnHwyhVLHJa51AOgs0VALmxP69AVDyNwFOdDaVXekgcnkZgoa7WKawL90J+q7SIh3CPejJJ1CNrKc1TqsjSF/H0US4QHJJRN9GkGrpYQZ3HRf9/MYqggAunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702132; c=relaxed/simple;
	bh=DtFqYt2RlGIxva5tAf5Y2TkJSPTnNd2KMzcNQakmhJ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aaI4x+TdJ/IccT6WJP78zNbAwLpx6zGEa9sZciA3JTY10lGA1DTwL3/XylNONCP26JXLu8x9IivRVXfOkA7ANh6ks+0eSt/3z0058iALmaysclRB5uo1VruKJqbWxjLaswDzSPUH4khP1S7gEkTxP0Ca7XkcSyYdZWKFW1yffv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zgbp4Jaf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zgbp4Jaf"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6253MsVa2756858;
	Thu, 5 Mar 2026 04:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ulaNIaarhjuD4NrFbM5mgteJaU0
	f8Z7+x/uKozDST5M=; b=zgbp4JafbJiKJJuJA3GntMsiSTl2lbGsA6oyJPXQxFA
	ZPyrX90slc+l+1srU3pjwhjTYMvAR6Cum3hXJT0tviBuI7Iuy0bBYYLdlIwzEr3L
	NTrHCr44VkbwLOBkJ2SPL09c0jczwhxeIANkWcBgLrXWvwsCawPzLIs5zqoxYfU2
	U33GsoS55pXrCblmC1w/g/Utun2Y9KNKqBDSM/mGj0JfuRFdaTX1PHt8mxknv4Ha
	UPF4FVMCeSOV+tfXzK4PpjXXZj2e2nBPMdLvAdIw1YdqYHJHSEvj4yG+RYzZDYnC
	FRr7aX7zMxdq0Jclv86FxhaMngyw5LCzD13TZNvypzQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6bmq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 04:15:09 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6259F8Gl043483
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 04:15:08 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 04:15:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 04:15:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 04:15:08 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6259EwCv031270;
	Thu, 5 Mar 2026 04:15:00 -0500
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
Subject: [PATCH v4] iio: frequency: admv1013: fix NULL pointer dereference on str
Date: Thu, 5 Mar 2026 11:14:48 +0200
Message-ID: <20260305091448.32052-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MyBTYWx0ZWRfXwTmgnMmAsr4B
 EQLrGOBj1TqcxBwrakTq/uMC8Kg4WurRnFSzUJUV5e1xUV6wjiQJjwr7CWFfdqsSPyuGyYNASF9
 xsEwGu9Eyy5xKNATB8qn7Ozuc7l6wtrBtu1AFkXwb9gxP3xEabXmFwJ76Z6UoAKB4WQCeo41JaZ
 0WLe4J3CxL7XiA/rU4pVUQvabBAxC83Foeg3sSWXpBBEeyjT2w64/YQrmzuPqXVXgm/a1lBrn3+
 xOPuPSNJjh5+CYiICBsBGlz2za0tTNl3ouN41Ew4GIR8i7Z+yqdxfZTm9jctl+/57k0G6H7nQNC
 YtXY79xSH5Vt3LdMFisklVfJto5yE6x8Usm36ANX3zwi0pUar5CU+2rOKKeavFIFxRY0AIGxR69
 FhMkJpE5bJb3ePgznmeckbKMAE18Z4IVrFQwpIjDETX0f1yPicwH2aIClpJ/cfY/k790YIvU2MD
 6Ldznfeu3noDYeDVS2A==
X-Proofpoint-GUID: EmkBlZQdfbWR89Y7HyeuGExZDVgbsUhE
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69a9499d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=RbtMeoNm5JkacV20xZsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EmkBlZQdfbWR89Y7HyeuGExZDVgbsUhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050073

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with
device_property_match_property_string() and consolidate the SE mode
enums into a single sequential enum, mapping to hardware register
values via a switch consistent with other bitfields in the driver.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
 - consolidate SE mode enums into a single sequential enum, removing the
   separate ADMV1013_QUAD_SE_* enum and regvals lookup table
 - update commit message accordingly

 drivers/iio/frequency/admv1013.c | 65 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9202443ef445..b852378b3f68 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -85,9 +85,9 @@ enum {
 };
 
 enum {
-	ADMV1013_SE_MODE_POS = 6,
-	ADMV1013_SE_MODE_NEG = 9,
-	ADMV1013_SE_MODE_DIFF = 12
+	ADMV1013_SE_MODE_POS,
+	ADMV1013_SE_MODE_NEG,
+	ADMV1013_SE_MODE_DIFF,
 };
 
 struct admv1013_state {
@@ -468,10 +468,23 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 	if (ret)
 		return ret;
 
-	data = FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode);
+	switch (st->quad_se_mode) {
+	case ADMV1013_SE_MODE_POS:
+		data = 6;
+		break;
+	case ADMV1013_SE_MODE_NEG:
+		data = 9;
+		break;
+	case ADMV1013_SE_MODE_DIFF:
+		data = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
-					 ADMV1013_QUAD_SE_MODE_MSK, data);
+					 ADMV1013_QUAD_SE_MODE_MSK,
+					 FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, data));
 	if (ret)
 		return ret;
 
@@ -512,37 +525,33 @@ static void admv1013_powerdown(void *data)
 	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
 }
 
+static const char * const admv1013_input_modes[] = {
+	[ADMV1013_IQ_MODE] = "iq",
+	[ADMV1013_IF_MODE] = "if",
+};
+
+static const char * const admv1013_quad_se_modes[] = {
+	[ADMV1013_SE_MODE_POS] = "se-pos",
+	[ADMV1013_SE_MODE_NEG] = "se-neg",
+	[ADMV1013_SE_MODE_DIFF] = "diff",
+};
+
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
-		st->input_mode = ADMV1013_IF_MODE;
-	else
-		return -EINVAL;
+	ret = device_property_match_property_string(dev, "adi,input-mode",
+						    admv1013_input_modes,
+						    ARRAY_SIZE(admv1013_input_modes));
+	st->input_mode = ret >= 0 ? ret : ADMV1013_IQ_MODE;
 
-	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
-	if (ret)
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-
-	if (!strcmp(str, "diff"))
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-	else if (!strcmp(str, "se-pos"))
-		st->quad_se_mode = ADMV1013_SE_MODE_POS;
-	else if (!strcmp(str, "se-neg"))
-		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
-	else
-		return -EINVAL;
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
+						    admv1013_quad_se_modes,
+						    ARRAY_SIZE(admv1013_quad_se_modes));
+	st->quad_se_mode = ret >= 0 ? ret : ADMV1013_SE_MODE_DIFF;
 
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
-- 
2.43.0

