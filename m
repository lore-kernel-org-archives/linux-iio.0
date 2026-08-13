Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476348096F;
	Thu, 13 Aug 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629504; cv=none; b=FoO+xVmz4nSvDhvL+PFG4KKtXDl6QI4wL5BYebo1Mp+Mhhk0TIwJQ+oLXuY6wwkB93ykn8maTnXIV4HOeDD8+1Ba4v0iyEqE/nMS0aKiFN6PZGL2O01wFKGsXahkhuLCEFERfWVV6f+rhLRncqaOBuO2DaIaeSH06NCT8T/tFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629504; c=relaxed/simple;
	bh=NWYOhHtZJC5C8vlx1JYeY3SjFF04a4RG6WWrunhpQ+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aLE7DVLMZYxeD7wUxliZJbRrsmO3sG7q8FvAqlqHC/yzTNNsG5sEuN6Tx1AqTh5uFJFhVWvT/9djEuHOnjhRn8FH/qhhtJRTwk8S4m5BVHLnhrblwJSwSBFthrfz4obApCv28D+VoZq7lNn78yNaqgj7iCfVHUq6gV1r4yOASGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jLm5oO8/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jLm5oO8/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCLBMH2350839;
	Thu, 13 Aug 2026 09:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=n2tIM
	QzIRKyXAT8qFCJoy88FHUbrTFIZYmRm8jitVJA=; b=jLm5oO8/SBbfa6pRMd+du
	mIepoIv/20TnjwSEJ0zHDEZBQadBGKlTvG3G0qEOgqozRJq+1wTQNGGWDgw0Aoz4
	GKinIKiJ+yKph6q7rzojUH456jQAxPbeyf7Z/QH48gWq/2GPFcf80RCSA99o1ZfC
	cD0cmYMOe6O1822fKa20mlaRIzKvxgyooEZ4QU9slkWPp/KbWFEh41SV1ailbAB2
	6+cK9gPqxT2dDpsT8kD8Q1odX7vtBE/GYD5aqfZcxMYUoQ4+9c5jJNAfvWEdHtdT
	LLmRt8QdROlfGMcz1M7McTVRYvbjiqwq3LoNGZyHjI68nQj2z9MuY7laB8Cv/Bgt
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g19w9hwdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDwCPQ024669
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:12 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwd006802;
	Thu, 13 Aug 2026 09:58:05 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:04 +0200
Subject: [PATCH v3 11/14] gpio: regmap: Use regmap_test_bits() for single
 bit reads
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-11-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=1848;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=NWYOhHtZJC5C8vlx1JYeY3SjFF04a4RG6WWrunhpQ+o=;
 b=cvYjBjqytBnOluGxhttr1DSChbjBYEaWatECQKi7ZlVukNuydaVsPvyFoPY+isQfCUCfEHcfV
 DwK055h1K8HAhQkN1Ja7HG0MLc/Wm2NJmecGoTmiqNOcdy8iAuwFOmd
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX1R47NlPbU9bG
 eVPA5EnvF1zY0NQIWPPAcRXc0kb2Prbnfo0Thrsgn/woRzcLIaII4BSLSgYZ55YL/emdhjLNMfo
 ZoWwfKLBAlaPgS7d+wgzDcSD4FtruGlrBdn6U1b9U/YfUOmENnJnaAWjREGMn2wDKX8K+iGX51d
 BjcBa4O3GQhyjsMwWKsCEMtVqjL/Ac7VsIoqEhP90OhWTPkXG1zu97/f0gkyCIDk2egHJxf5eE2
 6/sEDpkaMBJ57AcVL9W6ixhe3FBPIUdITN73AcI+9I1+pH1hSaKfRUqFt12bvrVe83H+jGEKvoA
 4qZyWqbmUrClYMlqTupaqX57+xzMjfaOwPY4PXgnwNOyLFxSBocayTfe4l1HHI8UjKOIgfeKJst
 tGx6Ku42WaFuyjDv/e9erw85IwQQdpIHudgUc9nrbgPmG44j8T82R5KfffbZoikb4bK8encEOn7
 FqtdXwUYsR+B8UrSp+w==
X-Proofpoint-GUID: WUm76sUEueqhyQT1IlajtBLO8l_10oMd
X-Proofpoint-ORIG-GUID: WUm76sUEueqhyQT1IlajtBLO8l_10oMd
X-Authority-Analysis: v=2.4 cv=f/R4wuyM c=1 sm=1 tr=0 ts=6a7dcd75 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=A82TumGDDQIy_PWe51QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX9n9qtetLtCdQ
 DbKpj2EaSl1ZrSEl0L/pBUOIPz8yxPahMAdXJATe4miwnAo+n9ywWZVpBHL2z8XHlCs69BupqrN
 aX7tMXBdkdx/9XSJ0j50CaeL74VPmGfpU6cpztvzRgZ88cV3Tvx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Use regmap_test_bits() when reading a single GPIO value from a normal
register and when reading the direction bit.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..a5188f8569e3 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -84,14 +84,15 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 		return ret;
 
 	/* ensure we don't spoil any register cache with pin input values */
-	if (gpio->reg_dat_base == gpio->reg_set_base)
+	if (gpio->reg_dat_base == gpio->reg_set_base) {
 		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
-	else
-		ret = regmap_read(gpio->regmap, reg, &val);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
 
-	return !!(val & mask);
+		return !!(val & mask);
+	}
+
+	return regmap_test_bits(gpio->regmap, reg, mask);
 }
 
 static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
@@ -157,7 +158,7 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 				     unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, val, reg, mask;
+	unsigned int base, reg, mask;
 	int invert, ret;
 
 	if (gpio_regmap_fixed_direction(gpio, offset)) {
@@ -186,11 +187,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
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
 	else
 		return GPIO_LINE_DIRECTION_IN;

-- 
2.43.0

