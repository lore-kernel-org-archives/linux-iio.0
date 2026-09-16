Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF04EBAF6;
	Wed, 16 Sep 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557334; cv=none; b=qWUWE5f1hn2BJ7StRasHY6Lfa7dKrN9bdgVLB8uwPQvQ8Falux457gDA9cQvPeFGSvacBo/0xk2XG2i+lRopdgjAzq3fxyeS4Y3BVJHDvbhzKjLidHDY79uoQFycOt1sMcKU5zFVElY0usi95VMiTPqt+Wu18WLHjHZLddvkbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557334; c=relaxed/simple;
	bh=OVrmdB9KJL9GuhLhwj/wQtA3bU2+j7s9xOnpoKtM4cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZZbhbfHetYOh0oW/6MYn+l0gc1tRDz+1LjQgCd0gRUhG8H5/zpFEt/jzAmjvW/fYkDgbIA8Up7PehayRllJ775QVYcLoqK0b3CTeWS6oRDaVhM8AbjxnFY6qdDB2Xe0s/LDhm0p9lPJL76y9Km8gYnjwNmf3yDPOcd74quPNeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Squlw37G; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Squlw37G"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6aHH51592114;
	Wed, 16 Sep 2026 07:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vBHGo
	ohsxdog2NbEiy5qYYXwIIq54HBfZFjLUx0ItVo=; b=Squlw37G2vFK/WtxzUf7a
	bKo8YquzzgeRQNAyGgMyfzis8A7QbIBqZLyOZaUfVU8zQ2IVV72FLTumcfOxNulB
	gWMuD/vl9+nlg7Rk0hP6Ihhl1c8P2xihsl3Tfx1ncYV/uHOX5XSQDUrxj1LNhRnK
	yM5GwtegJ83FnFwlMvX1PuhI65CrMh5SJUnNPdET2jXA6F0FZ9dmbV99gjC7dqt6
	72Art5oyfaX3LqMbxbyafh/YwCym7MmdjgBzDvhSc0L3E2ZWRK5fXrkChjjVwlrT
	KqHtuTfd7reLE9eQM1kibTAkQrLSepZsbTgejOxSEyNvJCjFqHBB0CEATW/qfXHN
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBF6jV047095
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:05 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENDw004263;
	Wed, 16 Sep 2026 07:14:59 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:55 +0200
Subject: [PATCH v8 06/17] iio: adc: ad7768: Validate master clock rate
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-6-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=2045;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=OVrmdB9KJL9GuhLhwj/wQtA3bU2+j7s9xOnpoKtM4cY=;
 b=hdqSU/g+XwfHh4P3jHwgr6+sut0Oi+kTb2ziJWGQ9kOUSdXwGoMgeMXSht/r+V/cvCC+RJfLS
 akdt+tDEb+MA1PyR8IS/dEB0/eOGNy+ttjIyTAzoBs47VtNHwChtJmM
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX7R64ajOAxp+M
 03J+2hTYFRAwlqevIIWprLZV3E19NPz1hrlF6nXltiNSKwjq+pP341hB9R/UEEuBZK1uOXIB4k+
 dTQ4xneyxn8nEoUa6Ucek5pavtk8aKvRdTsP7QNyh4/JKL9skY64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX5csXBBLCmRMA
 T2qT6RznZoG1oTx/mbYzhoo5zeiblg1bkPNOpC7CGMZjkqCrtRmqIIYjDEg7lcRZiIcZ0VK7iPk
 JH1BtqnUoNvVMG3iP4XpFXm0w7pffvb6HRX87gOZD05GG+eiirPeweAx48M8Ut3dEvNkBP5AWlk
 k2nVP9jW6OYEvrJ/pOlEIc2aqnSvy5DFDzITv8GiFPwMJYZW7AIHCqDNEWPOlsKlQ/3Y7DM6LHi
 M3KCL3/XdH5X4gkQ6zf53ZWXWsfM2G/3KHQJoMiXGFOABpfU6oyxRXp6F84mfwhazKRCdYDGsyf
 Hmv2UBVmq8/W/gVz4ty/CItVkmVPFyF8HRFLiLWrj7IOb/wQjl0y/a7mxuf93XF1ZuK1f9KLeiB
 fzmIT/Bdg206uTy9NM/Kg3yto5bacXSxHHYYXqBkRW2Itga9zc+H+vHohOXH+0vtc4amSGazyZc
 9gBidwfvTtoB3S7vTUA==
X-Proofpoint-GUID: 2JYOsyr5tNH2rr9Ys0SQkUFYG7fCWEsh
X-Proofpoint-ORIG-GUID: 2JYOsyr5tNH2rr9Ys0SQkUFYG7fCWEsh
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a3b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=FJaljikgz40-E1eqKLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Reject master clock rates outside the limits specified by the device.
External CMOS and LVDS clocks support 1.15 MHz to 34 MHz, while a
crystal requires 8 MHz to 34 MHz.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 2c5d0657edf9..7ce0229b5b7c 100644
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
@@ -810,6 +813,23 @@ static void ad7768_power_off(void *data)
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
@@ -884,6 +904,10 @@ static int ad7768_probe(struct spi_device *spi)
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

