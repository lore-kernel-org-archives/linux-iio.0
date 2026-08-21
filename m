Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C14C8FE9;
	Fri, 21 Aug 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321339; cv=none; b=Pb3j0iH/zqLh9lel0ruiyNuDkFv9PniB5n5cdIMFRgdEnFOZUmac9+OGnMswVHvqrdYWELMMdtzTGJ/lANdomst/7UvOcI+yfOhO6aZmo4Bq6nOqFZMx45mBZ3JZrNVevIgFLeDwOkwFzHoNYo1LlrKNuCH3y71ihvve/EUPNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321339; c=relaxed/simple;
	bh=avB1555kJ+GOyyc5fE8p1FrcUXTJvMXpwCTIYWQx1Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eLALCt1w3+2KbpG1rG7YLWV3BBeqDPJGz3BRj5ym0gkB/P3vOwgNKP1lR2/e5/Dt3q7NwZJAq3K2ajBjGn7vh8F5yhsBNsiNQEOT5viiMnb61be3uWhb87wvT1WpXKsiRip5VsAb0ajghp4OJCqig6PGdapQK02ghNJMGxAJxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MJi93s6A; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MJi93s6A"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpc7x3388113;
	Fri, 21 Aug 2026 10:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xLiYf
	B9zUEHmd49UdNRGkukLG5fLQRmFBLhph/BOetk=; b=MJi93s6Av5BYIpWYI3avZ
	PORzWJbhueCsNWrRjXLG2wfttSDUSgIi5C/dXDDceTlEmAr9uEmnoqGoCjhtjV/N
	vnoK4aauIoPkCToV29xHEFK6fgRsb88lv8bgk+d7C4DgzidbE5H6Kgj/3hHkmup2
	D3ID4U0ySnI7fQKY0Zu9xpRTILF8X9lxXLNdlr6cki/XTzOwiWxOULKzuHPlGd09
	0eWbgzviLCLxR8gRFnsXdrE6eZdND2nmaxEnMZBC1sYeFqmv9lgNMRO/X7dXX7pu
	rZ7Oq0mJXpOb3jasGW+CzMOaeyxMC5nxLvCwYcEAcYb7r+WyQ8pwsoLs5+15ApcJ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g66m6m0j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8lRl033064
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:46 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kku024319;
	Fri, 21 Aug 2026 10:08:36 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:07:04 +0200
Subject: [PATCH v4 11/14] gpio: regmap: Use regmap_test_bits() for single
 bit reads
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-11-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=1956;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=avB1555kJ+GOyyc5fE8p1FrcUXTJvMXpwCTIYWQx1Us=;
 b=px09P536CdmoNMnc0EWL7n0PznSoXteiD/EmLD3RGCIq3pmB2iZiH9HqEmyw1exftszD3EIiS
 +REIkZX6imBAVUL7Im1DxtzeLcmwmIEVJEB3ugpNWPIHzI5BLH9BF5T
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX6DZYg6vfVImr
 vTts7Q6xfIBvfoQFatcmuLG5SO7EwBOtjunVMckTf4RzGkkejH2FhD770vi1FvLNyaGz1krdtDr
 91Mch9bF0pco4t/+Ui5WxVR7mhtfD/Mw3Ca89FAoU4vRefNk15Vb
X-Proofpoint-ORIG-GUID: MAcbq0XjZLO1lBWw4BpBsmLV4VKW5iAS
X-Proofpoint-GUID: MAcbq0XjZLO1lBWw4BpBsmLV4VKW5iAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfXz35uYJfJ0lxf
 RTl5D/O0VFXND5fPPVQ1wuHtKdYcJPm1iWIEmLE2EEdK0QVPyj5j72ea9dCHBjESHyuUzttsuGu
 JTDRWMf4Tki3tzr3nwaIRebeSIFyIYBsB34sU0fjkwIZyLB0SF/qZaPrPLT9d2qntxsFPW4kJQa
 5mh2bCUYW7S/DHvnDlBtaK7QJ2UEaHtZcPfksxkmLTcXU1Wd8axUIXoVhVYBKM9HYJAZiKYNyop
 g3oO9xspLVFB0LPiXqEAv1duhVEctuWozHUJ0VQdgx0JrxEp2i4+G5iSChVckaYm8WQqlOhKCWX
 +A+TS/txmO523GvWBBcHZm+lTWBZK0QQ0BtiT2/fdGrXyM2zKXShFWWhtrOkjzC5stc26I83emQ
 lZLD+R62GUnrFvFC4aORVwnvCNLPAHufCzIDG5UA9JbAP57L20uYT+Lrrze+qZr7jOJodLChdkP
 x8v1pSgxPoO0C07LJCg==
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a885bf0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=D1cL9gYDKEHF3ZsCBWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Use regmap_test_bits() when reading a single GPIO value from a normal
register and when reading the direction bit.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..0012e03d0d4e 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -83,11 +83,11 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
+	if (gpio->reg_dat_base != gpio->reg_set_base)
+		return regmap_test_bits(gpio->regmap, reg, mask);
+
 	/* ensure we don't spoil any register cache with pin input values */
-	if (gpio->reg_dat_base == gpio->reg_set_base)
-		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
-	else
-		ret = regmap_read(gpio->regmap, reg, &val);
+	ret = regmap_read_bypassed(gpio->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -157,7 +157,7 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 				     unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, val, reg, mask;
+	unsigned int base, reg, mask;
 	int invert, ret;
 
 	if (gpio_regmap_fixed_direction(gpio, offset)) {
@@ -186,14 +186,14 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
-	ret = regmap_read(gpio->regmap, reg, &val);
-	if (ret)
+	ret = regmap_test_bits(gpio->regmap, reg, mask);
+	if (ret < 0)
 		return ret;
 
-	if (!!(val & mask) ^ invert)
+	if (ret ^ invert)
 		return GPIO_LINE_DIRECTION_OUT;
-	else
-		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_IN;
 }
 
 static int gpio_regmap_try_direction_fixed(struct gpio_regmap *gpio,

-- 
2.43.0

