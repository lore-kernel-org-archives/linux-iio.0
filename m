Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D5883F;
	Mon, 23 Feb 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852504; cv=none; b=q7K+YbTbXo6iZ9xd+WLfxUTZ2Jc3tNk8/psWpDnvZ2bd8E7Jgjc5Lg4LyCstdSSPRxuaCvN02M8/Wj+Cs/h4xeEd8wg1SYXa0MT4QfEecpqPLndq4RqSOBYgRvW4zXZQ0LJBQaTywEdi5Gf00DVVs6JAOTwc8oAVMXuFoeZIRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852504; c=relaxed/simple;
	bh=hBssVFaNQY0+yXmiNeK96LwwS3FgXo76PlnB942ElrU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcgA4ncKJ8x7eScyucgMhpwCWYnmT+QY1Ef9ITjFqmDBuK5dg7EWja/C5ZKDC0nGe+GojaImDV4ZDssCIJfIY3kiXsxxoJ4xhXcHMI2MdxgeLNsRcKos/4uBFND2Z2nC6BRXqfnPfrwEXX3ZPGHzMOC3wbzUWVQaCSfdW1xMON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aOCEqXVS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aOCEqXVS"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6xcNL2667992;
	Mon, 23 Feb 2026 08:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o5Doc
	GBc4zeUhe88Xnw5qRJAxb9dZbudffZpZAIEvzM=; b=aOCEqXVSkmHiqgBpRXDC5
	k/Du348j5x5pmFhzK9FzqXf/qoomn3tGbJjWQPGy3tcyjCzOVF1/j/XFIgFWNOXD
	F4j2JBPEO71yY0pOP/23MSq34wEQWb4FhNOMYsZIqKi0ybrRgM36M0eSolDTpwg3
	tUDmWTHzj8YbeaFwHpwOwFqjWgSnFTSFtIvQGw7N79Js92naL0jjJwyelrEE51AU
	CLjUBQKj25X5CAozXIgR5IhiIWf3+MCLzGUSWM3qnhY4isErTKYrsUkd71Nrvvwi
	Cka/BVWHxQXnXNhFRNZu7u/z33H1qttyANIHYTz8J4EM31xM8AVV5hTi/PyY2QR8
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbb12d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEmJe009755
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:48 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXc006594;
	Mon, 23 Feb 2026 08:14:44 -0500
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
Subject: [PATCH v2 06/12] iio: frequency: admv1013: use dev_err_probe in probe path
Date: Mon, 23 Feb 2026 15:13:57 +0200
Message-ID: <20260223131418.55414-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AmvjIIqnDWi1hrLxYwObeVB70jBi8667
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c52c9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=3LiYLoh_h3RjBjQ2HpkA:9
X-Proofpoint-ORIG-GUID: AmvjIIqnDWi1hrLxYwObeVB70jBi8667
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfXx1hZ4X/U7aHz
 cKc61v+2brQF7jrNC04INvx0AIJl8yVukqZe5KjSYtUfXnrQuiZZrHUEAk+i/NJgfk6/ym7qWv0
 0d3QNCTaPlxXIPmdebdES1a6FcPRTsDGfTnZbLLJ0Ghp+vK7DEffXfNdjqEJtnjWSaVHSLCAELD
 e+9A85g4ACE/eW29lqiHHoqj/0JEk0c/Me623NZmO/OB14QdpCMwqXUDhAmZ0UneZNeQtsTgVZT
 tnbeYqi6XHQ6elFfCRVmxbKSZjLM60Fq6PB6RwDp4CHJUSAp644EbfOs/S9AkJzlv5qKulnuAt+
 elpjjR+L7gt1S3S6Yhjl6fTXnotRuKZLVPW62d98BmDAsmcdD3CKhHRpC/ivZQWFlM+RIGIIu2i
 O12doHBV8oPTBukhcj/7sQn/iLQhJZw9Qhc6pKIsY/8GvWG6jdUcpaekdsOj4LYGvpkrSILBv31
 h33tTezW1KlBM6VG3Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Replace dev_err() + return with dev_err_probe() in the probe path
to simplify error handling and to ensure the error code is logged.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 4e1ebb9a537b..514cf9f8eacb 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -461,10 +461,9 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 		return ret;
 
 	data = FIELD_GET(ADMV1013_CHIP_ID_MSK, data);
-	if (data != ADMV1013_CHIP_ID) {
-		dev_err(dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (data != ADMV1013_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid Chip ID.\n");
 
 	ret = __admv1013_spi_write(st, ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
 	if (ret)
@@ -549,11 +548,9 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
 					     admv1013_vcc_regs);
-	if (ret) {
-		dev_err_probe(dev, ret,
-			      "Failed to request VCC regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to request VCC regulators\n");
 
 	return 0;
 }
@@ -602,10 +599,9 @@ static int admv1013_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 
 	ret = admv1013_init(st, vcm_uv);
-	if (ret) {
-		dev_err(dev, "admv1013 init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "admv1013 init failed\n");
 
 	ret = devm_add_action_or_reset(dev, admv1013_powerdown, st);
 	if (ret)
-- 
2.43.0

