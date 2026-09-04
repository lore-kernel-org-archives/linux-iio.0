Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306F4AA572;
	Fri,  4 Sep 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531370; cv=none; b=sXEgsL2XGVZADRn7v+AwongHM/iDzIMR5/H+sVifiXsK/6ijdcSSePHUGDbqx0vUImgKs/PQ5QWy4/gPtD70kDXpkrsUlf6X9bWdxgNwQ+JedKawCVIv3JiPtVkIXrnlhDHmc9qTh7wFAjcAWQ0sgwA4+hsRD6lcZlBjPCgq76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531370; c=relaxed/simple;
	bh=6snwAoSaSMSIrb7vkif6gG8ygaB+m/IQ+HJUUbD7nqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Eu4Nxy5F4O42hEMi/huBhKhaR9GBpVqqhRJ8iMf4tWyv5py3DeqU0JEOIv9bOBLLzWgtFCnbrPyduwniMvac9PMXy0SiuVNlBeY3uT99n4AH6KWXZODXDR7/p2mIqpZ4ZohvGH5OADqtt4LRplnTjK5uBubhLKXzJqBd8KxPYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xOHIsG7t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xOHIsG7t"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dg8YC4068329;
	Fri, 4 Sep 2026 10:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JxUUs
	cpwEoHfk2b/DN2S3584MTU+WVnn0om9S5iPrOI=; b=xOHIsG7tu9LBInoTsnUf6
	ph75M06tPid2yBGW899ZIteITLIH3wovjUG+OLMHZBQ3hatrjUmWbhpHv1sFbJby
	dewQXRSAuGWIc+padKdgI7bJZU9Fk16jJ09MnP+2X/H0XUFOVytzMkqkwINduHG4
	GXbq9qdlktjIXvlyeUTXP6jWeM5x/Q+xQeBX7xBR5jkBpcfWjwwyGsZIidhfNVlJ
	C9I8HeH7LneT7iOmiLmTLthXUS+JRWV9KKdL1XzLui/eOmQ0GgwYrJoe+fFqxRDh
	YRlu/pDJ84isZk4Oq5dvuH1Zqddqu77eDEKSMEdnwa7hGNDJobR+u6YmzzBafhov
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfxaw0d1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFi4u036133
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 10:15:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:43 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dA026210;
	Fri, 4 Sep 2026 10:15:36 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:14:58 +0200
Subject: [PATCH v6 06/17] iio: adc: ad7768: Validate master clock rate
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-6-e4378f946bfb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=1994;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=6snwAoSaSMSIrb7vkif6gG8ygaB+m/IQ+HJUUbD7nqs=;
 b=mu3Jbvv/RGzDstJSRmzD6WeWRBO+VIn1rK7iqFS5q8U0/4YEH97rLCVXSgxsTFlyUMTx4ZYKe
 dPll8KGlXfuC3q4Nrz685DRKPhsRbxhwunrSWs6yibvH4rbqrN4KcuU
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UNnt2ify c=1 sm=1 tr=0 ts=6a9ad291 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=FJaljikgz40-E1eqKLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX9KWzJLL7kprj
 C99XNdWwOl/oSRl9fQjKvcZmIpPgCUSlMqdB4eOTQaDi2Nl3VzHeODUBvD3DvbQFNEcvWBHGVC9
 uqn/f8EjjL8ZNHjgKxBtKsPw843zR3uat4QsQen4ovFkqblQjheS
X-Proofpoint-GUID: p1WHGcGttgCoy-L-809KN0NBBECpt7G8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX/50Sw/KVOYqy
 ZDBB9chle76J4FcSLxInplhHItqlK3hlAEO0ZtxUf5fo6tjMcyLUtlfEwwcEwvUQfFaoSNj4tD1
 Pw5UC/50Vcj2oSrm6qm501WVfR+uxwtIFgl0r/naTaOWvoUMVqaLzij2xwJ2uy5qENJr0qWJAnj
 W+Pngp9COEmzFtibyQQ65zg9aCncZT12ynmhrEwsGBli370vDu9TvmWUnoFxwIKPRl1WbjG8aeD
 MtozYzAM0BbxgmiIg+czyABKY0lDS56SAvEnkb1HxALqdVVfdxxMUgACosssDYrSFuTT0qMhzd4
 lMmJckng63Pw5haSEhNi0R/QiOrAq5hX5ote7mzhw9CuUQ+GyhtWwJIr0GEnsXzNsxAOXOowier
 /qAURaar9JOMAdMVP1R/QZmOGXVzQYdxMZ3puYIE/8ManElqFN+Dr/0VzdGFsZO5x+VLHwcjsRi
 YNKhNf8xGiRhLy7q4gA==
X-Proofpoint-ORIG-GUID: p1WHGcGttgCoy-L-809KN0NBBECpt7G8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Reject master clock rates outside the limits specified by the device.
External CMOS and LVDS clocks support 1.15 MHz to 34 MHz, while a
crystal requires 8 MHz to 34 MHz.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index c80056a9edd8..707f3ae70a95 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -95,6 +95,9 @@
 #define AD7768_SPI_REG_MASK				GENMASK(14, 8)
 #define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
 
+#define AD7768_MIN_MCLK_FREQ_HZ				(1150 * HZ_PER_KHZ)
+#define AD7768_MIN_XTAL_FREQ_HZ				(8 * HZ_PER_MHZ)
+#define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_CHANNEL				8
 
 enum ad7768_clock_source {
@@ -777,6 +780,23 @@ static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
 	return refp_uV - refn_uV;
 }
 
+static int ad7768_validate_mclk_rate(struct device *dev,
+				     const struct ad7768_state *st)
+{
+	unsigned long min_rate = AD7768_MIN_MCLK_FREQ_HZ;
+	unsigned long rate = clk_get_rate(st->mclk);
+
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
+		min_rate = AD7768_MIN_XTAL_FREQ_HZ;
+
+	if (rate < min_rate || rate > AD7768_MAX_MCLK_FREQ_HZ)
+		return dev_err_probe(dev, -EINVAL,
+				     "MCLK rate %lu Hz outside %lu-%lu Hz\n",
+				     rate, min_rate, AD7768_MAX_MCLK_FREQ_HZ);
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	unsigned int spi_readback, rev_id;
@@ -852,6 +872,10 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->mclk),
 				     "Failed to get master clock\n");
 
+	ret = ad7768_validate_mclk_rate(dev, st);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
 				      st->chip_info->regmap_config);
 	if (IS_ERR(st->regmap))

-- 
2.43.0

