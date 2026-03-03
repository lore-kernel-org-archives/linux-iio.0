Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B94282F1D;
	Tue,  3 Mar 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531590; cv=none; b=VhUsQC2MoOFvkrIZRK/nWIpI0QDLBm56y2pKtzh9qfg2NUegFVa4LPYZzLRXuLXjsy3JyvTbpGluUDvEa+c7wuCl3FR1vgokOA5QUapOATBxvttRmpGaJeq+7K166GJs/gvrAAAKij9T6oT8rLRavVIPq9j6ziHAGjSbP+KuluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531590; c=relaxed/simple;
	bh=BxFlspCAPjqjcFLFuSFBDQ3Vc0QqSxak+KhCZD7Ywy0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWuGLojOcisuLnKXurewCJe3XwLSsKD8CTFk+1x2tvWjlRMp4IAqZ6sPF07CD1CFM0iugUhPyEfMqCDykloVkInPWSSznaRCdn5ib5qSeLKu0Ax0BTKtLR+g5V7XClZ7lcPY7T3/GEa0f7M+2yNzhzGdAdgoKGVdpFhBhEQaOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ik6WphUp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ik6WphUp"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6233iDgQ3723179;
	Tue, 3 Mar 2026 04:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=qa5Z//rtgRKOz3cnGtXiVMl/aXr
	3RGH0QKcMKTDIfF4=; b=ik6WphUpBY6XNm97yXIqam1V6vkmUeLF/8yHH3cS9Ew
	TPYc2JnoXY0OOI85/40Sl2KPv1SDNo7oECLKwn4Zusx8b0GasC6eHyAXUG+1T7SD
	/EDdUXxxODuRtDxUCh6Yy8Vt7mxPYGM46yzWpAP7gunS9MvL6Ukf5xdLDXMtZtgK
	8uNf0VZZg3cUtzLQfWz6NHTNb2i0HTJWZP1TXilXwlv2chhbmxvxpxpp9UOeoJP0
	Sp2P789KvpCFcN9fqSQIjPDSFGkx+Ej8k5OMhEzz+b5kSy4CM+DZf7yoYIlu0Qnf
	v0c3q9C7JTY4Kwuv6sOuMbi/dRuTNUG6k2P58luh1OQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ckx54b37j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 04:52:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6239qiml031780
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Mar 2026 04:52:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Mar 2026 04:52:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Mar 2026 04:52:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Mar 2026 04:52:44 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6239qWRr000431;
	Tue, 3 Mar 2026 04:52:34 -0500
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
Subject: [PATCH v2] iio: frequency: admv1013: fix NULL pointer dereference on str
Date: Tue, 3 Mar 2026 11:52:28 +0200
Message-ID: <20260303095228.7494-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: Joc_GpspRpQp4hFU1uQkLiPflJuoROf1
X-Proofpoint-ORIG-GUID: Joc_GpspRpQp4hFU1uQkLiPflJuoROf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NCBTYWx0ZWRfXwjPZY2c5fInS
 8BvHECP+CnRlc9c0Qu2yqZAuYhJUc2A5OXIFblJT752pZHuLC6W5VVRmIXCxSg5hi6+QXMQmQ1P
 SAzyl7BmZlE4eDyPehlyOjJMYvgu/Y1RckNxdA5Ks2KFdj/+G4yKjTKJCmeQ9crffolQH99DOCm
 6UaLaZHt1xX06T3kRh18/wo6BoA0iOPkwCb4W3rOuwTS9hQyBGuv2FE/9Hw892brDyPs91/UTWP
 uWwBwlUsjizea5g3JzdKnR7+n+7Q7h0LgzrVuV4SFWqgL8EZWZibETvijGmFbOYPzu4nNQ+CKGX
 T+wegeEy0Ur/OgexGQiO3kryUvzkAdTb3RyrJGkKPPOiXw93SqPm2iUMw4egWc1iDqMfmFunUok
 iZYEPg3jpmqeyg9EwxGvZJNvFwYpDwvOLfRHtd4SUVrBaaeLl5eMoYFZgnTWELvsr0+GpRW/RBU
 s8X1dRlyZj1eXdiRE4Q==
X-Authority-Analysis: v=2.4 cv=HtJ72kTS c=1 sm=1 tr=0 ts=69a6af6d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=24Vb6qFsTg1BV4DAOQgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030074

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with
device_property_match_property_string() which reads the property as a
single string value and matches it against an array of known valid
strings, handling the missing property case internally.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - use device_property_match_property_string() instead of
   device_property_match_string() (Andy)
 - add Reviewed-by tag from Nuno

 drivers/iio/frequency/admv1013.c | 41 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9202443ef445..3eb0dc2f8dad 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -512,37 +512,36 @@ static void admv1013_powerdown(void *data)
 	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
 }
 
+static const char * const admv1013_input_modes[] = { "iq", "if" };
+
+static const char * const admv1013_quad_se_modes[] = { "diff", "se-pos", "se-neg" };
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
-
-	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
-	if (ret)
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
+	ret = device_property_match_property_string(dev, "adi,input-mode",
+						    admv1013_input_modes,
+						    ARRAY_SIZE(admv1013_input_modes));
+	st->input_mode = ret >= 0 ? ret : ADMV1013_IQ_MODE;
 
-	if (!strcmp(str, "diff"))
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-	else if (!strcmp(str, "se-pos"))
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
+						    admv1013_quad_se_modes,
+						    ARRAY_SIZE(admv1013_quad_se_modes));
+	switch (ret) {
+	case 1:
 		st->quad_se_mode = ADMV1013_SE_MODE_POS;
-	else if (!strcmp(str, "se-neg"))
+		break;
+	case 2:
 		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
-	else
-		return -EINVAL;
+		break;
+	default:
+		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
+		break;
+	}
 
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
-- 
2.43.0

