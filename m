Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B50364059;
	Fri, 28 Aug 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931174; cv=none; b=FDf5iKM9P7upCrZwbkjtiqRjUXcFbK2KKp+SH9Cn2za66P2rG6vDCvtYlz0u0ciXcIZcOi5eTB/5vRF5LuIZSUiBWZ8E2vQtl+zxAqEr3EH4sHiAT1KCbvTTE1xQUfHb666J19s2Ko+KF9hm/nybx2OjTy9VeQe7dZYcFjJt1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931174; c=relaxed/simple;
	bh=cIFKPg7aR19JvA32/JMcyUeMAkV0UsHAmAU+6sSAUBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=huWNvKL0eTws6o0c0abL4mzHh/AtXt3cn/ho4jokjEmGkiUTYZ4qdte57lqIQTS5VgquTSZ1CupbLTfANdJbdYosnHlibjxlcbf2gix8zE6sOzXHo0bz817EmM+urRNuFKc5w7U5gluHV9VQb8aa+rEvZsV0HnpoPk9Ly+8qcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FOsPjMR2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FOsPjMR2"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWYoK1593807;
	Fri, 28 Aug 2026 11:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hREVb
	gNyWj2wZiKrMUXMIztb7e8NfeL35pSryE9Au/U=; b=FOsPjMR2y5X4qUsrrhKVQ
	qSoETD+0F9IrkyfdPPimoCxllBsVGvW7HBNZp79uN8h179LK7aFvHcFx8ZdRpstM
	vra7+Mll9lNTc508fo3on3D2LxTC12mlp3vy+VvH6LwP9Yrp49tx3uNsDIoZGL1y
	akmwywDG9Q1UPi/EpQrIs1JOT5ByGWUBqKrRSK3dZvXk46GdwYf0IYhk3CFbF7Yc
	2FMiKSWQqqO+MIuJqOju2/3tVMthe5NyfoOktwS4T71SyNVg7fNrYpyp17r6E/14
	/PAjMehByq42buuQg5i8fVovGvFv+wmu1exaXFlP++JZFnoRuY3E6ms9MSrSX+IQ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbaebgvms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVt0u013282
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:55 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3w031424;
	Fri, 28 Aug 2026 11:31:49 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:40 +0200
Subject: [PATCH v5 17/20] gpio: regmap: Use regmap_test_bits() for single
 bit reads
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-17-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
        Janani Sunil <janani.sunil@analog.com>,
        Andy
 Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=2016;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=cIFKPg7aR19JvA32/JMcyUeMAkV0UsHAmAU+6sSAUBU=;
 b=wcFdQeEED1ChQXMqVXT74/A8nRPiqdKrbO5yAfKuR9ph2nW3htneCUyvJX1F77qowX6jtrAKn
 +Mb5/mANOpOBHQPNjvs2FEoOCHoOOc6rw42WKvLdwh+4TVNXZDNeplf
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX4FLEE+/UNTga
 DdPafSqBDo+hcI3eLQmF4TPXcawmFLJHyDTQrEhTu2pcUCknui9HFHDYbsuuxiSeOO2yeWMaFzx
 gjnaiy0KQCcePEoqPlrPyLSDMVDeeGfjwtzobGfucPddYb9RB+DI
X-Proofpoint-ORIG-GUID: 0Q-UURXz2nRUqTFNNWfgmc4F0j34f3p-
X-Proofpoint-GUID: 0Q-UURXz2nRUqTFNNWfgmc4F0j34f3p-
X-Authority-Analysis: v=2.4 cv=WMtPmHsR c=1 sm=1 tr=0 ts=6a91a9ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=D1cL9gYDKEHF3ZsCBWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX4vu9HOcdI0BI
 sXssbVAobCf5totu8fwlwlCJ6A9909AImVs1gBs/j633q8qu7n3LdrdVM0CGkn31X/aGIPVY8H9
 hjzdHwHuqKyJ1tp8dntiZ4RRt2EhnbFAKPr1GNHN/nCrpONFmFL4qkbuddbxMb/OSmu1yV6xFRN
 ocB/snY6lN4lKdD+AU5wdKA5D7KQMz8GmCBkSmMLNXU8xc393EOAPVLPfTg1F+/nmZQqC2AbWsr
 aXBfplPN8IoSKmbOpamDP9M7Cyu/b+q0vHkv9Cuge7xy5jonPHU4gm8i7HKScuaUrui6kc7++So
 2pXDlQx4mkb2lhxLh0Xe6hRW5O567hfpRwIgJ8K/rG/VdpR6AhFjP5wazoHsGixhvbBqLdY6YrJ
 pLtXVZJA+si67U71BxcqgE0iW+9g0unS4NCI0Q4h+HF1YtGufvu7tXvrjZZGwG7D4us1tJq+rib
 +ZnMndnxLHx98OXi66A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Use regmap_test_bits() when reading a single GPIO value from a normal
register and when reading the direction bit.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

