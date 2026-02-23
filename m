Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943818FDBE;
	Mon, 23 Feb 2026 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852512; cv=none; b=HXxgYyPZkZYO+FZIJpiZtxUXTOeQuwajEBI6bXTUdQviu05n0j69RqtTR0l4qkbER98YCjSr96hfqzj8eXQp10SufDirRVAnQckt1AA1Wx8L9j6ap6kEqN1neQ0S6hneQISUuG7iqV/3AVHxo6XrXJIk1WHf2wKwwV2suFcDZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852512; c=relaxed/simple;
	bh=+rlHpUtmIGLBKv6QD3GOr1gK5xCaxsR6NkdY8SgE3WM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2JNUtcUeq9Cs1aC3aFDP425lWogmCD/Aa3rOzVeSNjrYhb3aPnBD6GJQe0IpB21e9xYfX+FkWZ7qkM9sl5c0EELs/rnUEtKh70i9VtT2bCeGXS2Fq4FL/Fb2ymoIZzZDbu4vkRpOeWzxo/yZ5StUb3ed226Gpx9xETrJQ7yl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mf+/wtih; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mf+/wtih"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N80KUQ818277;
	Mon, 23 Feb 2026 08:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wddPJ
	Mp7lNFnMlvHlmcmFwcuINWMNAFAp4nj8L/wpgk=; b=mf+/wtihhAiPEwCQQPkzm
	NaJ3yfYqDBEkT7szsxVeJMhuqPPW8X17esuCY9kSAzkT6zUakN9cBK59my27bZC0
	b+jI5R/RHYFpL1GsOKTebCkT8tHWADqPdoBK6zEIQjPrLE2+85ZcsA9PbVfDE2CP
	JPYdFVmoOBbzflzsihSmFIxgAZdZeb4iHZhl8yG3WpDoh1v6KbjJN4GChQeAA8Ku
	lyOAlP1AwtSN92LVRInSE1RGJAGeM+Eh0600knoxZheK+l0Q8++gEx5TEyh0qiLe
	4AmdzzegqClFKV/mihAoywwcU9pDmUPe6FACX8IqqjNk20jgeYvV+7HnZIN/yc//
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p02y7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:55 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEsec009768
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:54 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:53 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXe006594;
	Mon, 23 Feb 2026 08:14:50 -0500
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
Subject: [PATCH v2 08/12] iio: frequency: adf4377: use dev_err_probe in probe path
Date: Mon, 23 Feb 2026 15:13:59 +0200
Message-ID: <20260223131418.55414-9-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: hP0Nuf0I7ItywHtsqUuEJw75Ve7ojYeC
X-Proofpoint-GUID: hP0Nuf0I7ItywHtsqUuEJw75Ve7ojYeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX0O7AI5Pd4G9i
 oqsb9HFoUo5QXZ8V2t12DtUjZ6oTdTpj/jj01FLk283Xfgs7Jqaiztc9mue8lljpNpiTrxCVsXc
 DQZzINskH7uzS2VsitwWcvdv3QmJqJwvtF0DqbMuW1M5hfJEr1uHeeL1Hq9gfTXN6GUSyRMnQSe
 3SYlhZjM1yG6nfXoNTLFNHN7zjEP0nYHFUu9wL7mvlcf5OM7vOuRi8kaakJpdl3tOLPEAlOXnDX
 s2wwOOlKpV5siezypcFJ7mlLr7zJEkOjU6s8qLHOfeaNZzDuwV5GWRA8w3U811qEK8oV/u7Oz+Z
 9wHBAfY0BAtH1gIS0ePlg2sfppIegju+sT1p4sIhDjCkN+EkCODXM7GomR/6w0AbSS24Tulr2/c
 O8VkGVgjXPMG/rDPuFft94gTFBXE/kmSaoGlf1be/332aa+RnA+G80Q6PH/9ma5sjcR5vBqUnKi
 j6qJ7iUMKMYG8v6xbZg==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699c52cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=XIZiaBmXTVxVH1IbRYoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230113

Replace dev_err() + return with dev_err_probe() in the probe path
to simplify error handling and to ensure the error code is logged.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 919b604b2ce6..cfc0c524c4a4 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -712,17 +712,15 @@ static int adf4377_init(struct adf4377_state *st)
 	adf4377_gpio_init(st);
 
 	ret = adf4377_soft_reset(st);
-	if (ret) {
-		dev_err(dev, "Failed to soft reset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to soft reset.\n");
 
 	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
 				     ARRAY_SIZE(adf4377_reg_defaults));
-	if (ret) {
-		dev_err(dev, "Failed to set default registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set default registers.\n");
 
 	ret = regmap_update_bits(st->regmap, 0x00,
 				 ADF4377_0000_SDO_ACTIVE_MSK | ADF4377_0000_SDO_ACTIVE_R_MSK,
@@ -730,10 +728,9 @@ static int adf4377_init(struct adf4377_state *st)
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W) |
 				 FIELD_PREP(ADF4377_0000_SDO_ACTIVE_R_MSK,
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W));
-	if (ret) {
-		dev_err(dev, "Failed to set 4-Wire Operation.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set 4-Wire Operation.\n");
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
@@ -747,10 +744,9 @@ static int adf4377_init(struct adf4377_state *st)
 			   FIELD_PREP(ADF4377_001A_PD_PFDCP_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
-	if (ret) {
-		dev_err(dev, "Failed to set power down registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set power down registers.\n");
 
 	/* Set Mux Output */
 	ret = regmap_update_bits(st->regmap, 0x1D,
-- 
2.43.0

