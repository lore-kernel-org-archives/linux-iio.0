Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1B8248B;
	Sat, 17 Oct 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202297; cv=none; b=d8Mi/LmgWiSonBlLNKDaBXGp+RnwvwyIH15p6I12vEATpRw2KPW07PSHKAgI7rTVRLaypAbAm/YC22IdlWeIp8IyLIhBKT3/SFll6fDlJaYXMZ1tWN6YFd4/QsOs23tAV5tdZwiAsMpbxbivZCOGt9j5U2t5s9Cm2cF1AJ4kvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202297; c=relaxed/simple;
	bh=dIZqhcHcOPv2t/aiv3g8UhLMhrMUqHyuCdABZjzJboY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFfihcRjkVeYc2VVMUL5AapgL/jWEBPJBvKkhG9lKlYzB1jevFE6eovA+nv2+DpA3aL1gsCTk00ygj+tSwz1hfTkcmzRGZ7lzAkIjgHvq3SQ0rBDtnctir/2r80+73v3w51PYuXjkOZYJgq64FOYNH18umUyNC1p60gnfe4Y/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=f1a8lulf; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A6sPjiFO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="f1a8lulf";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A6sPjiFO"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHSa32680473;
	Fri, 16 Oct 2026 21:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=XCykCoR94aEVH4+pIEzv2W1v+k4WbvmvBv4559wa4Gw=; b=f1a8lul
	fTmv81iK561HhhPf6mbA+ESmBTzcb65ZKqiwusyAgsAAiTSBNMOf+v3GGxoLZVaP
	/JCJKU+y+PJJzJgP933Uvr2bdLb2vS3SO3PCYMgNFctA3fmvHMYZM0bwr0QcRoUQ
	hAmmMwi8mcsoZjCH329IlKC084hodSB8jI2EIT/JdslIf67USpJZffuUuf3gap/t
	udf6XBkayYkF27BMaVUvzNH2JQOtR4ixm4ib5V+Uw1PpGSHcWaAPbsl3AcV6P0vo
	+bAsPasoN2DpQDtDpOre4vjoRLZKKj1p3akA1PpvLjpGae8OU89ufriSsIEv8xYL
	XjlxESl1sBSqgwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XCykC
	oR94aEVH4+pIEzv2W1v+k4WbvmvBv4559wa4Gw=; b=A6sPjiFOFmU4tRonnUP1P
	PLYOIg/t2Oc13RfmiRgAs1FwJWeMEnWFim3bc0VVE84tsc4bt/RzjZKYKt2/UGe1
	nOwWYeRHEK/pbTrra66OWUIfnoH8oAFaRym/Dz993i95age/byRGmR3CwUgxTIuB
	BtZNVvRn/Ih20N4qKMKnaNT4x1oDsGCvLOeDg7BE7uKnjhk7ffO+f8GNgFJF7HjG
	hwAps2PMrKp2xVCI1YmrUHlHgFZd4tEfLXJnrz9rhG8FO824++FBNsQ4L3PQRPh2
	kHmO6jDozW+wxPnVke8u0cdQaySeuyxD3AnY06fdMLroKi1VMRVhUivMUWOKeVT2
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4ua9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:58:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1wAYg061645
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:58:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 16 Oct
 2026 21:58:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:58:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1vssP004318;
	Fri, 16 Oct 2026 21:57:56 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v5 05/15] iio: adc: ad4134: Serialize single-read operations
Date: Fri, 16 Oct 2026 22:57:47 -0300
Message-ID: <fadebc9f9fd6fe3924d086bdd7f549555dc069bb.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX4TiEZrhxj6KP
 fxga90TgBuJ4lx/2OoXO3K+ygDo4HLTGkXL7d9ut3xsX1dxeqGvnx3AnPw+oj4UBzcq68ydv+EA
 mkdVCrmf7bua91XpMFW5WUXCwGVqJVbxDnUuGPbs56Kz/gNIK4qTdEqHMm2rXnyZQa7tUB3m06G
 3ZlgP+cY+FY/7r/gRJFqKu/TRd2c5IQcWa1iBFvY0NQJncU/LCOTe5D9AvK/MVvdCSxOgn7eFC8
 kBnMpXn1VQrimAn6wVL3FCwgrDskP94oxhwcczGmfluonTpeOzyllr/0CM6hVQoVnsFimpMcOTE
 DdmpT8HH2/P4XkgUBVLt5oAsByC79YsX6huocS8jq945bc2x7Yb1PKrEI/6SWQ5zsP6qEtycvmk
 PudavFCPOx7u9O4mSwSjhhcul4wUaUD1MyaV8mOYQPse40nF6Ag5oV36UhMwiipceL0Uw7/EVcI
 fNPaGJqfejPNWh/7/ig==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d633 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=lQRJhboXyqThIMNCO80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V-8RlDPxbyR3hb4fqOy4tU_wSSsyaI2_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX0H7BlFXR3Ied
 Rk47zdPsIfUvSzdraK6RR7dL2v7Z4sUYP+lrJFf2hNG3dXf1NFc8dSIKZQlpgtYjitbUJ0vC1YU
 VaXEAg7tqfwo+RsG3wHUAVTUrkVvBzjC5yYPrUX5im5I+SIWbQ32
X-Proofpoint-GUID: V-8RlDPxbyR3hb4fqOy4tU_wSSsyaI2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Protect single-sample read operations from going wrong if two or more of
them run concurrently. Serialize the data read operation so to avoid
single-sample read requests disrupting each other.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index dc2b32c73a3a..dc4d801490db 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -7,6 +7,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -15,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -98,6 +100,11 @@ struct ad4134_state {
 	struct regmap *regmap;
 	unsigned long sys_clk_hz;
 	struct gpio_desc *odr_gpio;
+	/*
+	 * Synchronize access to device state fields and ensure atomicity of
+	 * consecutive register access operations.
+	 */
+	struct mutex sync_lock;
 	int refin_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -257,7 +264,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->sync_lock);
+
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
 		/*
 		 * For slave mode gated DCLK (data sheet page 11), the minimum
@@ -276,6 +285,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->refin_mv;
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
@@ -445,6 +455,10 @@ static int ad4134_probe(struct spi_device *spi)
 	fsleep(AD4134_RESET_TIME_US);
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
+	ret = devm_mutex_init(dev, &st->sync_lock);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
-- 
2.53.0

