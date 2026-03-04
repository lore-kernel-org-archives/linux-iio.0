Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865B36D9E2;
	Wed,  4 Mar 2026 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618342; cv=none; b=rRWuJkhk7Zov4hJvEKOzFWevrlJj8lR+BN/Hs+TFSDVbsJGvnQzayfZZOmktYPt3bpRCaJG8uSJ9SCy0MV3l7zvb2QvqO9hXupx1m/X8+4tlR1p4AtF6dFAmmLQzHqkzO1NxeJ24ET35X3yCSAsfPsqyAjBglr8KWUTIrhWa5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618342; c=relaxed/simple;
	bh=Nmv4KTdk2TGFSfi+J95Mn/ybFCabmBK4bVrUkgO83QI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLPaaldXq86f3YtDHxNKBy0OEATtzIHdz0qINqk4rFbImPkWei0kdb655YlVd4f9vRy6YEqVMJZLt4MxwVF2qiuha3MuJoEzIS4K5QRrjWA12ITR99SPThc3fMMneXCfIVlZaSikO9CWwpJLUhJq3IfipnwgJaIJw4D9BZW99Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ACsq22xQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ACsq22xQ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6244ULME2140227;
	Wed, 4 Mar 2026 04:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=RpD55Gd7f/jDUF3vbTTAL2sPS9x
	gttJBQ5IXfNWyKqU=; b=ACsq22xQR8FZVsv34oMaVBSnLzAvbW8Vcd6emAi+jSv
	rcA5kfXCHK+pvzurWWwVzDUzaB83OPRvQewzJKKy+3n/fnxDmMUc6a9W+YXo6/ws
	sxKnW/VpMhZFKBaAZpUnZO8gXpm0SYZK0FH7qXzR4bDsS8LCPwAkezcux9Ezwffx
	0I/g3OJowKvRd/ARSYSBdI9YfbuMCDYSx1zsRL0dQJoNu2dHgfrBGu9OMAaJC2CH
	cWK7Lq2A8trmN0g87MfEWKCDXyaq0+MhZFw0xCf3BOunaaVENcncS732IBExhSc1
	GmNfX1ihT0X0AmMS8raGfkT+8FyP2GLuXCvLPwz3q2A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpd6h94mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 04:58:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6249whFl017061
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 04:58:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Mar
 2026 04:58:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Mar 2026 04:58:42 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6249wUFZ031114;
	Wed, 4 Mar 2026 04:58:33 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] iio: frequency: admv1013: fix NULL pointer dereference on str
Date: Wed, 4 Mar 2026 11:58:18 +0200
Message-ID: <20260304095818.5459-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3NSBTYWx0ZWRfX6xzylsdtZ7Hj
 6yJtDOMcihclln7KA9+PdHOz1TFV/1Y1orkMU0wM5zfPL1fGkk2OSzsi2O+p77ShYyA9MlTajhu
 DiX4QjXC2KMuCiUab8xDKYIGRO4B+5GHtJV5TGyiE3/4c9cMYyZB76WN9zWzmn2Cy0doNTEijiC
 KjX2yMn8amDEsUYQejL5pa2qLqPqY388qgpHNVrLB/Ph7AksiUOBbLOgCA+r8a0pVHRKTtCbpPY
 6Ca60kIHEYG8QBEJO4KhQr9I6OMI3ijws+ZULs5tx1GQmP/oD5EO1RvpMfqPdbZK6lL1dJHiXJU
 nGKtlHlCvk9sQiYLtvcICEzUL+C3Z8dgy5I66Gka9fuoN7ygge/N1/QFHzn6idM+xaNRFYRyao3
 o1om6zbs6+AwVu2GIys+DAtVXKf2oqCOjY4kNc4BW14cWw7knxel/Rdragq3h7fo02bQ4Opl0Xr
 QmVCVnTFO/VuTRHZKFw==
X-Proofpoint-ORIG-GUID: TX9UP_zHwvntQXZoAB1rsK4c-bi3QMRc
X-Proofpoint-GUID: TX9UP_zHwvntQXZoAB1rsK4c-bi3QMRc
X-Authority-Analysis: v=2.4 cv=Jtz8bc4C c=1 sm=1 tr=0 ts=69a80254 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=RbtMeoNm5JkacV20xZsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040075

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with
device_property_match_property_string() which reads the property as a
single string value and matches it against an array of known valid
strings, handling the missing property case internally.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - add enum for quad SE mode indices to avoid magic numbers
 - use designated initializers for string arrays
 - replace switch with a lookup table for quad SE register values

 drivers/iio/frequency/admv1013.c | 55 +++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9202443ef445..afdf06a0de43 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -90,6 +90,12 @@ enum {
 	ADMV1013_SE_MODE_DIFF = 12
 };
 
+enum {
+	ADMV1013_QUAD_SE_DIFF,
+	ADMV1013_QUAD_SE_POS,
+	ADMV1013_QUAD_SE_NEG,
+};
+
 struct admv1013_state {
 	struct spi_device	*spi;
 	struct clk		*clkin;
@@ -512,37 +518,42 @@ static void admv1013_powerdown(void *data)
 	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
 }
 
+static const char * const admv1013_input_modes[] = {
+	[ADMV1013_IQ_MODE] = "iq",
+	[ADMV1013_IF_MODE] = "if",
+};
+
+static const char * const admv1013_quad_se_modes[] = {
+	[ADMV1013_QUAD_SE_DIFF] = "diff",
+	[ADMV1013_QUAD_SE_POS] = "se-pos",
+	[ADMV1013_QUAD_SE_NEG] = "se-neg",
+};
+
+static const unsigned int admv1013_quad_se_regvals[] = {
+	[ADMV1013_QUAD_SE_DIFF] = ADMV1013_SE_MODE_DIFF,
+	[ADMV1013_QUAD_SE_POS] = ADMV1013_SE_MODE_POS,
+	[ADMV1013_QUAD_SE_NEG] = ADMV1013_SE_MODE_NEG,
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
+	ret = device_property_match_property_string(dev, "adi,input-mode",
+						    admv1013_input_modes,
+						    ARRAY_SIZE(admv1013_input_modes));
+	st->input_mode = ret >= 0 ? ret : ADMV1013_IQ_MODE;
 
-	if (!strcmp(str, "iq"))
-		st->input_mode = ADMV1013_IQ_MODE;
-	else if (!strcmp(str, "if"))
-		st->input_mode = ADMV1013_IF_MODE;
-	else
-		return -EINVAL;
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
+						    admv1013_quad_se_modes,
+						    ARRAY_SIZE(admv1013_quad_se_modes));
+	if (ret < 0)
+		ret = ADMV1013_QUAD_SE_DIFF;
 
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
+	st->quad_se_mode = admv1013_quad_se_regvals[ret];
 
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
-- 
2.43.0

