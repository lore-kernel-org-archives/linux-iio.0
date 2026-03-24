Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595226ED4F;
	Tue, 24 Mar 2026 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336498; cv=none; b=KSTegHy7Rdjc5FaiBw8Yq+FAgh/r2MDMQPb5ucb9kgJ7dP/04uxrfOiaOMCPDITr38UHHiwfXoL3UOmix7ei61t76plV0y5JXZGTpNrPmYzufc+8BgndR6yUAlCNkKIsghVnu3p7zXaVtUD/KZxmorML/a5+OxFuVZ1d3J+KLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336498; c=relaxed/simple;
	bh=QI+7OwK/6gfmL5qJ6Q/FweMXtMqrsPBgbjixqh0ZHqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR8CwZkMt//rrnngFFaZklDLIkr0GhhOagckEmaXMNasgUor7d5RKJUtBygMOB3umnS5cd4jD0V320J9AP7czjZKarXlHD42zMu0CRI26NOtnNzRJg/i5xLmJgq92cwBQFLTb42ssbcBPpDcjjd0w2Kdsd2o6Jpj2E73ShirtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J2u6tgQZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J2u6tgQZ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O6JcN7662684;
	Tue, 24 Mar 2026 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9SMk4
	v6lawPJ8GlytxKAe+R6/fXHgfP0fQYq4r9ro00=; b=J2u6tgQZ0dW3z1ZzJGm12
	FZurbPP0aHUR/wFFiT+Q9fnFkWSZ16GSVNDmEnvEcdpfEYAQtl3+zdaSCrUsNs0/
	yG/HDqIG3RCWzSgj9gOBLh0Q1M4laDyQwikGJWIP65Rf5/mQiDIKR90c/8FrAkkp
	3JgCh20oLA9B7urpfaSsPC9U/CkS2XcdCUVuhfLSVvyiOuWd1dF1+/aHC0EUfuVx
	hSpRyaIC8tlpoXGVIrNyEh65mvVtJgW5zDW9eKPU/hq1WHgQWGx0BtQJDHa/d+Fz
	UByV8jUtSedYvcmZrpa42rNpSK44zMDI39pf69mXHC2uGGhGYkZG4l8nY3kVx321
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n6239af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 03:14:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62O7EN5u020263
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Mar 2026 03:14:23 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 24 Mar 2026 03:14:23 -0400
Received: from CJONES7-T01.ad.analog.com (HYB-jCCu8MOWEgi.ad.analog.com [10.116.223.230] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62O7Dg0f003654;
	Tue, 24 Mar 2026 03:14:13 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] iio: adc: ltc2309: Add LTC2305 support
Date: Tue, 24 Mar 2026 15:13:31 +0800
Message-ID: <20260324071331.842-5-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324071331.842-1-carlosjr.jones@analog.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NyBTYWx0ZWRfX1mTazD52ASzV
 E1Wr6vjj8W/70PJiMWDcf4hMTE+ONYBLyweam4GQSwu2neVSMkYIgGweLHGzdOMf+jOMJm2oUv2
 JAa/nh86hO9LD8iDIMD/xvFKcb3GfWpCtDwBhJSt+JfyBcXyC9oTXS+QGOpdbLcg3LKJaObDzSS
 yBdUVc8dOalmFTQDmeDc1Y8UvR+pe8nOL794HI3/WmmpRhsuH4UUpbdc/TR6QI0MA/icxixbxah
 vgesJZB33cwWebGOV92Alb3kcTsfmsJUYLh06tazrMChCBkr21gTRGwBjnJgG/mobyWUr8f7XQc
 ha8b0cDuasUxzWbXMBMf3I/DQoHLEMUr9CoR6xGcJ+5SgtoqroZPqiCVOT89Rru/L/4yQfNS97z
 cJ0k9HpzqQpD3m0+DLiPZe1gUG74nPrOjzu7L8OFfEc7OQts3y5nkGfVmNwiv6AaHl6meY+XD1e
 GsdAbs6HBBNPQIdKKKw==
X-Proofpoint-ORIG-GUID: t90mSKuwfX-O7O07uQDE82CnPk5mihv9
X-Proofpoint-GUID: t90mSKuwfX-O7O07uQDE82CnPk5mihv9
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69c239d0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=6VD43Srf4_-BMiEuy00A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240057

Add support for the LTC2305, a 2-channel, 12-bit SAR ADC that shares
the same I2C interface as the LTC2309.

The LTC2305 differs from the LTC2309 in:
- Channel configuration: 2 single-ended + 2 differential vs 8
  single-ended + 8 differential
- Read timing: Requires 2μs delay (1.6μs rounded up)
  between I2C write and read operations

Device tree binding added in previous commit.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/Kconfig   |  8 +++++---
 drivers/iio/adc/ltc2309.c | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..860c0909dbbb 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -915,11 +915,13 @@ config LPC32XX_ADC
 	  via sysfs.
 
 config LTC2309
-	tristate "Linear Technology LTC2309 ADC driver"
+	tristate "Linear Technology LTC2309 and similar ADC driver"
 	depends on I2C
 	help
-	  Say yes here to build support for Linear Technology LTC2309, a low
-	  noise, low power, 8-channel, 12-bit SAR ADC
+	  Say yes here to build support for Linear Technology low noise,
+	  low power 12-bit SAR ADCs:
+	  - LTC2305 - 2-channel
+	  - LTC2309 - 8-channel
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2309.
diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 475ecc21ebe9..d7ec4d92a96c 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
+ * Low noise, low power 12-Bit SAR ADC with an I2C Interface.
+ *
+ * Supported devices:
+ * LTC2305 - 2-channel
+ * LTC2309 - 8-channel
  *
  * Datasheet:
  * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
@@ -110,6 +115,13 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
 };
 
+static const struct iio_chan_spec ltc2305_channels[] = {
+	LTC2309_CHAN(0, LTC2309_CH0),
+	LTC2309_CHAN(1, LTC2309_CH1),
+	LTC2309_DIFF_CHAN(0, 1, LTC2309_CH0_CH1),
+	LTC2309_DIFF_CHAN(1, 0, LTC2309_CH1_CH0),
+};
+
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
@@ -170,6 +182,13 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
+static const struct ltc2309_chip_info ltc2305_chip_info = {
+	.name = "ltc2305",
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+	.channels = ltc2305_channels,
+	.read_delay_us = 2,
+};
+
 static const struct ltc2309_chip_info ltc2309_chip_info = {
 	.name = "ltc2309",
 	.num_channels = ARRAY_SIZE(ltc2309_channels),
@@ -213,12 +232,14 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
 	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
+	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
 	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
@@ -235,5 +256,5 @@ static struct i2c_driver ltc2309_driver = {
 module_i2c_driver(ltc2309_driver);
 
 MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
-MODULE_DESCRIPTION("Linear Technology LTC2309 ADC");
+MODULE_DESCRIPTION("Linear Technology LTC2305/LTC2309 ADC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

