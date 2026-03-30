Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3E37C113;
	Mon, 30 Mar 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869657; cv=none; b=uppAtqYToGHeqA5IQqGkZpPyGStnLHPUU9snZwfJIYeTtW/hJewThU4pR8PyC6Q69nbT3FU9Gh3MtboLI7YOEy0UN8ptMXU/PuenKaDPDRWfiGbqvTGGtbjO72WgCmrN4rL/QHJCDIexnLTNUUz4f7b9fN77wWVkwF+oetnePfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869657; c=relaxed/simple;
	bh=JZdRjC8+BZFhcwq2gjX1TR6ONItuOQS7SEINtpqxhts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beHPgX0pynL5CqiFcHOt7e7FU0a5fgOlO7/NG22n13DkDzVeWHPXdKCdqLKqM13etKbTJSbjoqXMnGsppqXmG18MSxLT6J+nY/LeITQdq6TpGASj1+X8+vWAptYpGDPhLrEsABYDqyIZNAJ5P7zkoI6xVryPBhIEmmv+3dnUUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uyyX6ny3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uyyX6ny3"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAw7sq3973001;
	Mon, 30 Mar 2026 07:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rdVPl
	LrdYkuoG7++joWcI7oIDaYPGkzdu/KItXnowZw=; b=uyyX6ny3fX8KeaiJOeNYC
	88Tada4VJ5uIGtaywysS5kLKkEq4JguhynOUCE5ngVYiBPQBosuiWQJbKQ6uR9Pe
	yHHS9J2Oi0HYSNFGpv3xXD1SS6OQlA/78DSdNJNeUWTHo/3NGYyPlxX4AFqS46tC
	n6dy1b4rvZp1WSFoCs7Br4O/yzvPHj2d8LUeehD527MuRctDUKuf1S5j9pigw80R
	8aAK1Oj5Y9O5I7HatFf6kg5RU8dEbY90TVakGUC9JYVqPxNjwplq6SXeDCtkWjxd
	0/bg3Y7Qv2KWLFkV1ATPLnrd215MrP+bh4VmP9SaFvB6U0saU+QZkY+Wrlj0Op0o
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkv9kej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKV7k026873
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:31 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgW014225;
	Mon, 30 Mar 2026 07:20:25 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 03/13] iio: adc: ad7780: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:46 +0300
Message-ID: <20260330111856.121589-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R9skgND3amYOn2ID_bwDECn36ttUqJWs
X-Proofpoint-ORIG-GUID: R9skgND3amYOn2ID_bwDECn36ttUqJWs
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca5c80 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=0a4eyNQZxP4F6lfmbKAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX7kDgJBs5S/vx
 pgBC+fkdZ68xDbch4+6I8kCDvFIROy+upLIs+IFcPiBdoPreNKOlxpXGEuIQyggu3lhd6QnP3Ge
 UCwvB4lwcohPic1raFf3vObCPZHdrsdtB24JXtdv+tY7OSDkVGc4DaEn6dhcF0oIMs9HA6lcCg/
 eO8rkdFQ6NWrj+ztzqoahhLKnrDsCKFv2zJHCEJ0lcS/pRlA0P1/6R4oEnQfetAYVbY4KWxC+c/
 l2ntjSudt/NcthGKkrrOxq4Hay1zgHaGggTmW1pGIb1blCg9GZmZVfjYTyFOgkxEfM4v8Yo+0Sp
 jqTYZSPBYgizMMUbstsXyDJnEbIVKm+mF4BmxRRUe5usAcYupsQoOoGmDN9NpscB97WTibZQa1T
 cr0YQ0XA6dvadPpW0Ac2KftmxtEW896Ip6jQ5+AFwVowlntWDV5kM3HzGfWiNsTHTdpAMDXCT90
 IUaaB4b5OIDfbCMoaNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7780.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 4c1990e27213..26382b1f8c9e 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -264,16 +264,12 @@ static const struct iio_info ad7780_info = {
 
 static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
 {
-	int ret;
-
 	st->powerdown_gpio = devm_gpiod_get_optional(dev,
 						     "powerdown",
 						     GPIOD_OUT_LOW);
-	if (IS_ERR(st->powerdown_gpio)) {
-		ret = PTR_ERR(st->powerdown_gpio);
-		dev_err(dev, "Failed to request powerdown GPIO: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(st->powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->powerdown_gpio),
+				     "Failed to request powerdown GPIO\n");
 
 	if (!st->chip_info->is_ad778x)
 		return 0;
@@ -282,20 +278,16 @@ static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
 	st->gain_gpio = devm_gpiod_get_optional(dev,
 						"adi,gain",
 						GPIOD_OUT_HIGH);
-	if (IS_ERR(st->gain_gpio)) {
-		ret = PTR_ERR(st->gain_gpio);
-		dev_err(dev, "Failed to request gain GPIO: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(st->gain_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->gain_gpio),
+				     "Failed to request gain GPIO\n");
 
 	st->filter_gpio = devm_gpiod_get_optional(dev,
 						  "adi,filter",
 						  GPIOD_OUT_HIGH);
-	if (IS_ERR(st->filter_gpio)) {
-		ret = PTR_ERR(st->filter_gpio);
-		dev_err(dev, "Failed to request filter GPIO: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(st->filter_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->filter_gpio),
+				     "Failed to request filter GPIO\n");
 
 	return 0;
 }
@@ -339,10 +331,9 @@ static int ad7780_probe(struct spi_device *spi)
 		return PTR_ERR(st->reg);
 
 	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable specified AVdd supply\n");
 
 	ret = devm_add_action_or_reset(dev, ad7780_reg_disable, st->reg);
 	if (ret)
-- 
2.43.0

