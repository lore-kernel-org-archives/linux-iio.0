Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370556E043;
	Thu, 10 Sep 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061870; cv=none; b=DAZUcQ7b4gE5ns9k6Ka+Z3iuaTOL+rDx5gsoHcc3gM3yqMM54sotzm0ZDFcyhO27l5qFpbdZnpAopAbYKB5XDlj3f3zgUmCJM3+tmX8aj9mniGDUrIjVvqXKTbVki5PMSm+MdAhrl6rAE8MGK1Oc1xyb1nQ0CsL51BxmTuL3dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061870; c=relaxed/simple;
	bh=3x7Wgo0kEm2BblffQYiq1d+jLEVI476bgnfkgy7twhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cNZnyquYnczvXV51c6wqlbJjmj4N/bvuDJM9crJxAmM4H8Guy6OVMBPeEqDvXdOlf1rdaVp4c6rxsmErkVHi22KbMIWzLJb9V1nMGgPkVoUzpXOOhduwwA0SFDFjBN/s+eQWUIZFeNOLwazHM8gTejMT+G5vdK9R2vMlOPDlIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ljoDUPXD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ljoDUPXD"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7OqU343068;
	Thu, 10 Sep 2026 13:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WyZ6G
	X+aD0b0dCK+Y0sWnOmEUEYsziXle+FAYqfNjHw=; b=ljoDUPXDte28yRJyYKaOw
	CXvpGJ3sBInNne5GQH5Kt0Kka4KBG1OHTQmmN856wP6ufyrx3NuNLs9ptuHtbhga
	497+FAkTU0CF9zVZ5SJHrezgcCnxxZ6koYcIstlqNHGTiwUZZZkgKPBD/SBkpi5H
	GyntI+ohsxY/trTSu5HSERzYbPfClAO1hLrYwGgYHicx44LSjlQlcuEWiEDwKqJN
	AEgRMWavfrWcWcpNRj+4jOmuTOTMelsUHON7yUykKLLzItwO6v8FaRzxLSSrTjUJ
	Qamx1arbFD7ptNZZ5vg8fxMuW4DgYYZnGMAFCssAdwgZCCD4X+Z6vCHhg8HEHwam
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx9521d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbKjl038791
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:20 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSd018832;
	Thu, 10 Sep 2026 13:37:14 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:25 +0200
Subject: [PATCH v7 07/17] iio: adc: ad7768: Add power mode helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-7-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=3222;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=3x7Wgo0kEm2BblffQYiq1d+jLEVI476bgnfkgy7twhw=;
 b=XZRYvLAIs4PRBlVl63TpOgRAvlVGaU5gzY5KKdt1zMP/L8dJmgxD/NaihDGkZMANGrULb5wEM
 V1c9ZPSX9o+CbT0c7j7CMRONHSloekGo6JTVkHF9Ts8jOd6kUAnCils
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfXwwnFKr8v4lVV
 /UfEr+wasipV7X/ZRN/6Rn1qJ9DROGEP4CBSClQ29dX34Senb29Qi9NVNcBajsva24oMiSBjeQT
 Ufb+bTh/spVJdOKS96WSwwjHjN9Z1G4TA+OZJrLXFA2CxanyBRb+
X-Proofpoint-GUID: RxO-cN6h24SP40Go1Tj6bF8sCbq5lftR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX7YvPWCSmOkKJ
 Pj9A8krdz4TBVWLiAKesfykTSdIilM7INSDVrw/XanjmCJd1B5Q0STk5p2Ol0JGWMP5vApP3e0N
 Y94poVR96KYSKW+bI0oL7e1ASBiDQHExbhApqPTlp3VgxAlHWa7zbrxtCE8VROj/wPRZVVZweoD
 qh1oP9xQHwnc7M+uN1CytTWa/LZbSHXjFHjudnrQ1cbzR8UnZ6Zbl31grTY+fFRB4nQG9ChbXDU
 tjPMmaU8mauR7OIkQSI5sU+A4Jo6NP3N7OleYw37dpmkDj/JU0gJrGtxGEq8j2CtKLgftKxXz+e
 U4I24CGaGTG2vXyJ4uw1Y/4++ylPi/+wpSBXDP8VeylwKso8sxCrlSZSeEnto00fnDvGXky9gfR
 jcSXpK7qT/pApCpbzdmmyKtgo9KTkPg72R4K/7frgGwahqOKjQDkayLYe8lc2/5/UuMKVu1CyzM
 /6Yc+LMhwTvjbzCfLHA==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2ead1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=ouHy9IwMRfQpid4n9IYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RxO-cN6h24SP40Go1Tj6bF8sCbq5lftR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Describe each power mode and its internal master-clock divisor in a
table. Replace the open-coded fast-mode setup with a helper that records
the active mode, preparing for dynamic mode selection.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 44ba19fb2096..be815b8c6766 100644
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
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
@@ -330,6 +344,32 @@ static int ad7768_sync(struct ad7768_state *st)
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
 static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -489,13 +529,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
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

