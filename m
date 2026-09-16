Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB84E56F9;
	Wed, 16 Sep 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557349; cv=none; b=K/B92DwvPjkHpoZNs+W3SNkEFnldL6HyxQhTW3INwVFaVk6AWwCdeGLu39St/IeM6YRVOrKONICoieAddkfEhksjXwS3X3wBVuWI+7T2du63o7/GC3mgBRuXXg3RmosUVfpEdM8MkZq0FFzC5zeMfKGowjnFhZztIahOPVdv0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557349; c=relaxed/simple;
	bh=uGoDTXAkuXT/tRFiL5NmChsrJ3JCMw+VY2GjXOW4WtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IDCl2fb+ZQn4OfleOea2FyM+JS0NDUkVAfg4yhfTDqc9/f8k5cCyjxbk+9mf+m5ufgY/uxb+FHrj9qJwG5TrSaA82EnrhtBcbVr5wkrvlxG4Q7aETLLZFKV3o0VGcZB3o3gFH8oS/LNCxfKIF2ISArlMmNx3P4ReLajli3CoEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aN70zOtn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aN70zOtn"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6M7Bd1591671;
	Wed, 16 Sep 2026 07:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=K6Dax
	QLLmfUzC8MCqcqw8RGkoYapiKAqfkv5Tjdie9s=; b=aN70zOtnOsvM7/a/hk8rv
	ECe2RCXM/SuNtFvmvcj/fzsRjxUaELcWLrAaN6cZUXbAw3qNBij6Uw+hw6Bi74sW
	rdTvVngcpMDt21Tt+Fq8xOiDzBqvQpOmiaSMkMFbEEN5vcrkLf6TfOC2Yxbcy5i4
	mRB0TdLT65XcW+/GquMWRHl441/G5npoU6oplLCCWcfO+rme14HE/AMmZYkIDcLS
	uF8SzGLaakGnEY8YLoS178w/G1M6eZd18AItM1HkhrDWZiU8Gq2c7Ufms7RV6z2T
	RV6z8pasyGbmlyoDSnYQ0o0g0ZUgy6ZQFF6rxEeKqdg3wa9QcjCdqhLe257+ZHaM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBF82Q047103
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:15:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:08 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENDx004263;
	Wed, 16 Sep 2026 07:15:03 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:56 +0200
Subject: [PATCH v8 07/17] iio: adc: ad7768: Add power mode helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-7-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=3339;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=uGoDTXAkuXT/tRFiL5NmChsrJ3JCMw+VY2GjXOW4WtY=;
 b=0Yw5ZLlLHB0Y0mGG0V+p/JgwK2RRbrPypuQAh17Q4DFkq4gau8cLN6EwdKwvhFk61+eBrTjYu
 IeEoT7QqXWqAfHqk1zAT64oerN7BoW2us33LQbgTtrNqD/vd0yLnMd8
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX7UxqtOECNcw9
 KAsUkUY7r0bhc9dTpaSdI5Uu+9WQSduLr4WiXKzoFXw2fKnmQT2/59prSg/oCTRejsrJdPIeseg
 2ICm8CJP+iUwLJXT6hiSW6rIZ2DKU2DGSnkClHrJuOH1G0tfbg4+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfXzHKWNIUZi1Zp
 WB2BA9sx4POZYJBwWe3yIkZTJO2fo8QnI6rm8VTLbs1dHIJLNALLkdQ911woh/xcbBpb9sDZQcU
 kVyBssxPG4oSAO0oOofHzIe9WAJ8F3jOhKoGYGCiG7iU4pe5acaLWBMElUW8awrKKTVrIP1iR/t
 Ta+GEqd0BUoq1Z+8GZ9N1gGi3ZFfhy5wbChL8PHAypPPgzgfQP5B6ihQ2a2Vqgrqzwtxm6SKRHm
 DR+IgeRLQk5IrTiQEhdbEiDlYpk+goBG07iBWHFuc7Ub/SWlF9B4MCGGksJW9hZfhsfemnYZnif
 QV9S3fcyqgN5ofy8axCHAoXErVvYIdZGxU45MiSqASFV6KQagTBcGYFqruAPzpe+ZkqnIWu/cEJ
 cvEHMtqD6P+T+sfI8+kkkQ7ZLM3NY0Kgr+Ymj0Iz5xLD0Qq78O1L5DgHVmxFjDJgocKnGwgm8sF
 xrqk/Cjkg/RhciC8rqQ==
X-Proofpoint-GUID: QXAMAVRQnwdq6T3dPsrPI_wczoRt404q
X-Proofpoint-ORIG-GUID: QXAMAVRQnwdq6T3dPsrPI_wczoRt404q
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a3d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=ouHy9IwMRfQpid4n9IYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Describe each power mode and its internal master-clock divisor in a
table. Replace the open-coded fast-mode setup with a helper that records
the active mode, preparing for dynamic mode selection.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 7ce0229b5b7c..5bd01f457a54 100644
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
@@ -102,6 +104,17 @@ enum ad7768_clock_source {
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
@@ -127,6 +140,7 @@ struct ad7768_state {
 	const struct ad7768_chip_info *chip_info;
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
+	unsigned int power_mode_idx;
 
 	/* Used only in regmap_read() callback, hence guarded by regmap lock. */
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
@@ -346,6 +360,32 @@ static int ad7768_sync(struct ad7768_state *st)
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
+				 AD7768_POWER_MODE_POWER_MODE_MSK |
+				 AD7768_POWER_MODE_MCLK_DIV_MSK,
+				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
+					    mode_info->mode) |
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
 static int ad7768_set_clk_divs(struct ad7768_state *st)
 {
 	unsigned int dclk_div_reg;
@@ -532,13 +572,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	unsigned int mode_config;
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

