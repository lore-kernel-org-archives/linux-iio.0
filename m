Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A94AEBED;
	Fri,  4 Sep 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531429; cv=none; b=dwvi4jzEz4P0b58JjAThnOn20cOdtJSMqEFPFgdDx94McaggwPJFEgo6NsK3IiaT7EAWEI5MItK2Q0aawqlpDU8f1oJ8UR0LkOu43X3VFCVQPR+AajNicsCJKfONSqFOp16HYxZKSqrvT7MzxphiONjjSSXqvTLK6AhMv3LcQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531429; c=relaxed/simple;
	bh=q/9+ryLJEraKeP+/7D8n8PffyibVBnkMXyyawnCI1BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G1RtW0XTbxeRuKfEjoQbzS/w13VfcfUIkWGYqLJZE15Sv007mqn7tGOfJ3IM7a+3zSZ5aD+qr8XgvBQetcfCAI8z12qxjvLMHo+qymXddARNEpTfvwADkIMQmfyr7qBb5Ag7qeG0n1luGJ8RMU/8C7GdSeNWV6sPLFiySzKKh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l1LUsWm5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l1LUsWm5"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684E2QM93597856;
	Fri, 4 Sep 2026 10:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=55hn+
	IUUN7mHugJYPtQlfoiOZqM7Vo0Gs0sdUyCViIo=; b=l1LUsWm5ukvGdUzZLNp2U
	45Njms6G72yPs6Bm4ih73EBHO53L8V2XSL6j8FHVi/hH08wE1+qDBA/72ewAdXyA
	N3FhlJUtW8UdDbpBFPUyV4vPvTAAkx9YtBLu9xCtky3gqqeIWyZmL2QlIgWSYjyT
	y75HHiV2kFCZLbIIhXInzuz+vbYGimzQJIRpAu9Oqfwx8IeO3yft9Ud1PiSfUKwF
	FDVXrVAh+bhKC193ILL6yCdZZioiPSmfP8RZYNMnzddT4WrUr2Ot0TNcsJU3jFYR
	vqJrxDjuk8iAPmQj6c4d6v0KBYomfD2+yJ4UwMZtwbooIJHyyxADuis7BplpMUrp
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gftu3smkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFllD036145
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 10:15:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:47 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dB026210;
	Fri, 4 Sep 2026 10:15:39 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:14:59 +0200
Subject: [PATCH v6 07/17] iio: adc: ad7768: Add power mode helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-7-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=3315;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=q/9+ryLJEraKeP+/7D8n8PffyibVBnkMXyyawnCI1BE=;
 b=wQPl1vInTF+UqYruYkDt/5SlnzqKzg8kc6QU//v73fmI16WWeSJITenylP8CNef53CLFmMglZ
 h6LsXmwhWZ7Ax6xoTeRRPSIm3EiTma3he5jLAbnX5yoVw/AvRjSt4Ga
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R6wz39RX c=1 sm=1 tr=0 ts=6a9ad295 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=ouHy9IwMRfQpid4n9IYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX2JK9e/rdzeom
 wY3lo4xq/dqgd6yV8fmk9P1GgwpqqILanqNGbwbrpdmgJEkJpciSvkRvxa9r3GvwYPrXPvCEA5S
 XEuX1To3qnU+cqG5A701C+FSIZS898YAMvJwSE3oECl3SXK8Otej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX2Zeas0kGItQF
 DCN3YM4tv76gfakRDIzo0UPpI13QxYl2omRBBIFpB7Hi/6LPbvYQ1klmLO8bJNdaEtY4IAWxY11
 7IqNGcHf5OoFY04mdyb3Am0HMK1L2o6ZuV5ock5J8acUFL1WDjV3QUUGWhvPC0TunVOXyzddn91
 BPp1wTclORWwqpao8pSqgVjsuxvS8lPmLavJwbDalXXw2G85NKV8J54Liip+y6Fmz56L6MTEcfX
 54qpaHXUxXOFuI1hl2g3q4O2ZDBVQzfqbO/7l0ct+8NecPKgI2+bzq1oUaiD3OVk6dZHmvK8NpV
 ajltLQItLGML3GeBddozxWJ1X3q92hAKrN2HDDRmajIVCE+pe94STOrpZF9CCltBWHE8n5QFS75
 uU0NDI6wjVZyGehcNLYFYrX9HxXppKoGUM1RvgWA2nycqY0dW4G6lLUVYJ9RseETMOloLoFuDzU
 A01aTdB3ajbgsrYUB2g==
X-Proofpoint-GUID: W3_Hpo3zRbNCzwetfThHAJhiM8C5UG-k
X-Proofpoint-ORIG-GUID: W3_Hpo3zRbNCzwetfThHAJhiM8C5UG-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Describe each power mode and its internal master-clock divisor in a
table. Replace the open-coded fast-mode setup with a helper that records
the active mode, preparing for dynamic mode selection.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 52 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 707f3ae70a95..71db57a2b9dd 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -41,6 +41,8 @@
 #define AD7768_REG_POWER_MODE				0x04
 #define   AD7768_SLEEP_MODE_MSK				BIT(7)
 #define   AD7768_POWER_MODE_POWER_MODE_MSK		GENMASK(5, 4)
+#define     AD7768_POWER_MODE_POWER_MODE_LOW		0x0
+#define     AD7768_POWER_MODE_POWER_MODE_MEDIAN		0x2
 #define     AD7768_POWER_MODE_POWER_MODE_FAST		0x3
 #define   AD7768_POWER_MODE_LVDS_ENABLE			BIT(3)
 #define   AD7768_POWER_MODE_MCLK_DIV_MSK		GENMASK(1, 0)
@@ -106,6 +108,17 @@ enum ad7768_clock_source {
 	AD7768_CLOCK_SOURCE_LVDS,
 };
 
+struct ad7768_power_mode_info {
+	unsigned int mode;
+	unsigned int mclk_div;
+};
+
+static const struct ad7768_power_mode_info ad7768_power_modes[] = {
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_LOW, .mclk_div = 32 },
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_MEDIAN, .mclk_div = 8 },
+	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
+};
+
 struct ad7768_precharge_config {
 	bool prebufp_en;
 	bool prebufn_en;
@@ -131,6 +144,7 @@ struct ad7768_state {
 	const struct ad7768_chip_info *chip_info;
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
+	unsigned int power_mode_idx;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
@@ -335,6 +349,36 @@ static int ad7768_sync(struct ad7768_state *st)
 			       AD7768_DATA_CONTROL_SPI_SYNC);
 }
 
+static int ad7768_set_power_mode(struct ad7768_state *st,
+				 unsigned int mode_idx)
+{
+	const struct ad7768_power_mode_info *mode_info;
+	int ret;
+
+	mode_info = &ad7768_power_modes[mode_idx];
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_POWER_MODE_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
+					    mode_info->mode));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
+					    mode_info->mode));
+	if (ret)
+		return ret;
+
+	ret = ad7768_sync(st);
+	if (ret)
+		return ret;
+
+	st->power_mode_idx = mode_idx;
+
+	return 0;
+}
+
 static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -494,13 +538,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	unsigned int dclk_div;
 	int ret;
 
-	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
-				 AD7768_POWER_MODE_POWER_MODE_MSK |
-				 AD7768_POWER_MODE_MCLK_DIV_MSK,
-				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
-					    AD7768_POWER_MODE_POWER_MODE_FAST) |
-				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
-					    AD7768_POWER_MODE_POWER_MODE_FAST));
+	ret = ad7768_set_power_mode(st, ARRAY_SIZE(ad7768_power_modes) - 1);
 	if (ret)
 		return ret;
 

-- 
2.43.0

