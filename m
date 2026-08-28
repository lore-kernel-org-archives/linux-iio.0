Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758A369D60;
	Fri, 28 Aug 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931092; cv=none; b=q7Mq6LEXXsHHD8wbuOvIrY9JX9nxjtuNRaOD3LRuFt8p0cMGl58nA3/KlTzf1swBDHO6sZAB/hOK+JHhXECwRQahjan+HphPKwet6w2y0S4yZtt3GZUwz98ALT1xq4EfJ/qWF+ahNr19oHYfhT705fP73VbOVvCzeko/JfE38sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931092; c=relaxed/simple;
	bh=QFMkHmVHWeAR9dsS2ZC32qLZjbpKmsH5vewhY1kfWGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bRE54+Y6PfH9tibQxsPoWQAF9b5bUA1ct83jGc/3Hq9umkm7j1EF1HOeEsinN+fbTOrBAZc7ITb4EizZLj1y4mYrJ00rFoiYn8zThjWJ73wlB5RHqBZZhNEQy3vw9oWgVnqo9fX85H7d2RqrRBVfHBg08W7bzWDuSeOUeStu88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=McjDNR4g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="McjDNR4g"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWf4f1594080;
	Fri, 28 Aug 2026 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=leFHQ
	eFH885JgIzF0x3yAnhQPpYMNtV1tdlKOzzYgVw=; b=McjDNR4gTRSM8o3RW8SrI
	qvOpw+WsB1kPfpAOt7ERbFZrGmbFJ+JIm6s7YWa8GHpUh7/UR0ZFMwgDBWTZS5w5
	RHqz7HRCFp7BB8wvWlD3X/44bM/siS12Nvbfqi/OzmBcJRww0pt/uZCKcqPzKgl3
	dQ8EdKEuNvydn+ZUZok1uEEUqlTNzCG+gddVPYG/h81kBWbke97BJvjdgPhTpt99
	VNF7Hr+Srd63gxsQCQE1bs5HKXj+n+Na6wCkV613q26TCvF/+YrRsJcRt8Wmjy7s
	yWW/oqhgAvXZM+O6oUL117GSAlCNYZrzjgUavim/R/KaDgOvYVZWLKhGCLPn59BO
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbaebgve7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVIM0013036
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:18 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3m031424;
	Fri, 28 Aug 2026 11:31:12 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:30 +0200
Subject: [PATCH v5 07/20] iio: adc: ad7768: Add power mode helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-7-e33ca6f841a2@analog.com>
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
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=3354;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=QFMkHmVHWeAR9dsS2ZC32qLZjbpKmsH5vewhY1kfWGg=;
 b=LYZ9g/UU100QNWfZ4umvdGCy4gYWKGKLEhScmloQWudxCEuPapGLbd8tOxm0pb3krqDk/1zDw
 NsNEQmImrynCAuItKijCe5cUUm4WEZkuNjwImS9C4Le2g7fKK0KOSB1
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXxzy/DKl9Vs95
 WfDIbv7+2MsGBV+xG2S5G/mJTJngp9r4+0hgqoZCnF9J8SyhguaeQbYpMc+S7VZr8a8VZujGRbK
 oApTxwyQl4XF4x0GTo3BmNtYs3rki6HIxnMHawKtYtUvleqpZ1U7
X-Proofpoint-ORIG-GUID: kDRO93T2AEflXfh86Lr_nXn4Jhd5QjcM
X-Proofpoint-GUID: kDRO93T2AEflXfh86Lr_nXn4Jhd5QjcM
X-Authority-Analysis: v=2.4 cv=WMtPmHsR c=1 sm=1 tr=0 ts=6a91a9c8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=fyyMV9E_WP3nD7ChQn0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX7iwBzVFw5GYC
 e9rV3COvmQielP53qPL4h3quj9gAX6h0HhbDEVZQkPhyfgTIw9rx3P4O+C+rhbVwnPJplIn/ZS0
 iUd12ISevZ6zjCIiQKOKCWsfkcmLsA/mQVLyUXls2JEUfrRWni8mOMrg7JqpgEeJLsGbuTVF/CE
 8LOj6sXnJwCch6KXd24ajjhuxXd4/qvO7WOuua0k1UbANarc3CE5MEW3IH5hN0OMqfxqCyiQMqo
 m3cVcFZQ75oVIkGW7ChRYLIIHBLnY0ygtdCCis9JIv+GEEKwPeVNn0iKwMT2WLyykWJ4FccyIJV
 nCpO57OWnu3MOit19NcmZtuElpsaYuoWiUBYPABNXmlkzXVeSu7DUNGCLm0o37L8bL8z+PyZ3U4
 9/fAgxJ6RpS0i87U6FXQH0lxZAJJJzq/CrZWKSFy3go/SY9h4KC7miwb40ejNyD69uQ1tp3LHHB
 p2NCUAC8BYRwzjhMZog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Describe each power mode and its internal master-clock divisor in a
table. Replace the open-coded fast-mode setup with a helper that records
the active mode, preparing for dynamic mode selection.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 52 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index ccd457c75224..67db6f4971a2 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -43,6 +43,8 @@
 #define AD7768_REG_POWER_MODE				0x04
 #define   AD7768_SLEEP_MODE_MSK				BIT(7)
 #define   AD7768_POWER_MODE_POWER_MODE_MSK		GENMASK(5, 4)
+#define     AD7768_POWER_MODE_POWER_MODE_LOW		0x0
+#define     AD7768_POWER_MODE_POWER_MODE_MEDIAN		0x2
 #define     AD7768_POWER_MODE_POWER_MODE_FAST		0x3
 #define   AD7768_POWER_MODE_LVDS_ENABLE			BIT(3)
 #define   AD7768_POWER_MODE_MCLK_DIV_MSK		GENMASK(1, 0)
@@ -112,6 +114,17 @@ enum ad7768_clock_source {
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
@@ -136,6 +149,7 @@ struct ad7768_state {
 	struct clk *mclk;
 	unsigned int datalines;
 	enum ad7768_clock_source clock_source;
+	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
@@ -333,6 +347,36 @@ static int ad7768_sync(struct ad7768_state *st)
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
@@ -482,13 +526,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
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

