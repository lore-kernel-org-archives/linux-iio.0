Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3204A2A64;
	Thu, 10 Sep 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061866; cv=none; b=pn+wegxNhcXM39CcD1dikuSVv3ryKeWIa8G4OGVV8Pq9d08lytXnTyL894TI7CZtuBjSLT+ze9HO+DVMTy6MyLb2jxiJeXYgI32uyWVQv5ah9DafgCC6wAjP52cC9/PyjC7D34nvqOp1PVkkB98LsgJYIuuGzoV0KG4d6MJpn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061866; c=relaxed/simple;
	bh=TL+k5c8jqO8OjcLK7T4JJ1/BN2LBdR+pUwCAsxAiVhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nFZwqIm1hIO1jhkaT8yNdBgD56lPVq+VhjUg/ixH2kQzbRfRYCWHPFXXHwtOfcUu8iqALTRHCyo3P3Y5JwO4hODe02/mTe35axK6Ui1IBtdw/Qe77TtHorSfYA0M0+4DfMwcLbwygRLBk+UvAPKvQyLmRO3AZk16Mlsygp+d3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DRNxIVRS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DRNxIVRS"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7FgA3263734;
	Thu, 10 Sep 2026 13:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mLbDO
	BtZ6KqRd2nsycqox6v3dTROHs7fImith9hBPFA=; b=DRNxIVRSw3pv/OaWhLqaS
	ua2JonIqmHiKX57IDZ/3DVcsVUYy7JAwxkY4iFTVx6IAuDq7YIH9GH3y3cBQpoSj
	PDaWollzneH5WwkXCzn8MKg7OGEUAb5V7DcXaa+zyHK5psJmaV8KWJKnl0UkUphg
	aJAuDLFVNAOg3K+aELufmhV5kYvqsfRyxDpOWO8SpriAIi2b3IZeY4i0E2eL/GCr
	SYJFFEx6nxFtMm7BGnNl2CW6pIyAeX4/sCwZuy3OV3kG0jOFa2KKxmUiMjLo4WVk
	4seKpItblSFgqM8N4x1XyvRNDuYSx2DN1qc6ZkapM+MZXg49VBJZbMcHCkgY1gse
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcd0vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbGYE038788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:16 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSc018832;
	Thu, 10 Sep 2026 13:37:10 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:24 +0200
Subject: [PATCH v7 06/17] iio: adc: ad7768: Validate master clock rate
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-6-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=1985;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=TL+k5c8jqO8OjcLK7T4JJ1/BN2LBdR+pUwCAsxAiVhQ=;
 b=eNAKrTcA34yyrBF3CgauPbjHwliIWEUrZLXTeiHp09x5Zof+krsxCMIhZ/gSB4lgCLDkB8C/s
 1ISUSRokG6uDt7EEsRPHDEWyUEBleTaTbJqEa5ni8xSRtz1FIgUolj+
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZFqFShd c=1 sm=1 tr=0 ts=6aa2eace cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=FJaljikgz40-E1eqKLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5oaTmD6Ut7AAKuKwUNyW0tDMx_g2z3Ji
X-Proofpoint-ORIG-GUID: 5oaTmD6Ut7AAKuKwUNyW0tDMx_g2z3Ji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfXwHlcyRwDuq+V
 5kZIMqUQsOvQcx4+cHk5ybkIhR0PoRYvGMJco+vWmwLsawAHGJcnHoZHlnfA/rz4dtyzdiu25KK
 5Nbv40z3A6xFIDUC00blsOTX+yQmlz8pnIqOBblIMEO4LVTD1FnYUH9tBxqjZmCppEbCnK9F2Zx
 9M2w23CK7Tc9428hMqT70nujmFtYY55J8mXuFcFcxixw9iHkvSD5KdoKfEh4hmuSO0qfSpqEdlC
 R0uTbsuopL3NdRNwMhNQi7g84oPtnMauFK1RWUqonNII3WR4JTpjoqjtmnQrsAqeFd+sblEokuN
 kUNw3M9Pfc5hUWCvS5p7y4E3IWgmVV6VSFBZPWYdjCIndw6//nlY/Pccy9jfEdfT8lDwfnTsrmi
 xGz0bUe5qDbeGDkCyqs8m5jM1hIhx97DnHHUzutjCOY71TWwc34S6oN2rpkPhKh8DKYmRAi+mBF
 ZHciPFHt+eYQeaKGnsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX4BjgUAt5bY6q
 krhKXfR8pbZsvjiCbode/1Bpx4nzFKRSsBUKijdHYT27HEsfhrpn607pwnsffEoe0iCYp0b3r93
 Z4Ga2J8xqH2mi9yYKxCilVP6e6sNzNdqpyQjInoJ+Pb/pDfK464z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Reject master clock rates outside the limits specified by the device.
External CMOS and LVDS clocks support 1.15 MHz to 34 MHz, while a
crystal requires 8 MHz to 34 MHz.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 3cb58c2554a3..44ba19fb2096 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -91,6 +91,9 @@
 #define AD7768_SPI_REG_MASK				GENMASK(14, 8)
 #define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
 
+#define AD7768_MIN_MCLK_FREQ_HZ				(1150 * HZ_PER_KHZ)
+#define AD7768_MIN_XTAL_FREQ_HZ				(8 * HZ_PER_MHZ)
+#define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_CHANNEL				8
 
 enum ad7768_clock_source {
@@ -807,6 +810,23 @@ static void ad7768_power_off(void *data)
 		dev_err(dev, "Failed to put device to sleep\n");
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
@@ -882,6 +902,10 @@ static int ad7768_probe(struct spi_device *spi)
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

