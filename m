Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A333C2776;
	Fri, 20 Mar 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015772; cv=none; b=RwsuccJmo67/UbuJDlbK7caSe/rZvp5/m5nlICkBOk3QZ/2eP6d74mat+qwh9fC5Z8uXdb7ZVT3IkgbdzBsQM4GcVbjGnf3u5EHZV5xuHsQkd60LSPtjyOfJBnLHxFJMpc4IB55x2zyUqB4BPVHkbufDUEsKXL3RzzUCBHwLKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015772; c=relaxed/simple;
	bh=KFHKTQgjgYF2cQb1HO4PI62ip6RiaELqwOD+KKIDk1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3iQRS/4raAOm4nqfAIBKfUaTGDm9sIB4gVSP1mK2VRp02t4TuJpKek+zoNvA/po0C/Rdnr3omEVhSRnSPMWvveQEtKWaagzUPuV0yvbJzskFyuQXgkUgg11U37s2f2GIGnrMcnDNTLcsf92YP3sboUNbbDQissPNkHLTUYTi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hO41mFaB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hO41mFaB"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K9L5Iq1782538;
	Fri, 20 Mar 2026 10:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OZLAW
	EE/g5mshGaD6k2fdrtdnPQAnwohtcyh7mrnqz8=; b=hO41mFaB6BEjc5ujdaLbR
	dHX2LqX0f1VXmqDXsFGt7UvBnO19yclMBp3+MteIVd0qjOVTIMt9WEbuko8u7ZXb
	hrpaxeyLAgxDlNhk0DbhXCbovcqq2XlNyfj6ChXItc9yHV4KEZiq78zciJVVvh2o
	zbAKYUuLRYCGZ6/op70mHifRdPjGiiVh+lpKfsNFLWjF2cNHthD6y8lATYh39fwS
	WTp/oJCU4M5/rQ573e9dYOpNxY4lIG49YH/YlRbEkf10y94IQ3nJ8I0e6J/Fg6RO
	a9mVmv/mpKwuGCb98v+cJk1NxbjpJ82hzWxUTmNRbjTSH4KjK6WeqcQl5rnO/IMR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjf8cw04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 10:09:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62KE92Wm055460
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Mar 2026 10:09:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Mar
 2026 10:09:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Mar 2026 10:09:02 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62KE8V9M014859;
	Fri, 20 Mar 2026 10:08:55 -0400
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
        Andy
 Shevchenko <andy@kernel.org>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Date: Fri, 20 Mar 2026 22:08:19 +0800
Message-ID: <20260320140819.191700-4-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320140819.191700-1-carlosjr.jones@analog.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Rcidyltv c=1 sm=1 tr=0 ts=69bd54ff cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=as-L6sGpZdkJDf6W14AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s-IjA5MlboPapMMA4UiJmAB_wepk6A68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExMiBTYWx0ZWRfX3Wr3B1AZnpiI
 i5ogggx9BvC1zMUiz7QMFNvaqzOXo38O/ejgv7VUY+EF+oq1gHWdG+C4kVCrU1Tb/IgsE4uwizB
 9kP85f7luik9xXhVB+zfp71ucPVHEyoHMk8EFQO1J1d2/teqqJp5Ze9vtUPLzCBbgM69IgZtjnC
 zkwgQ0EFMMX9BRkKWLAssCZsntniXKfaQbbr+KZKlSEUSpmt7J2VCA1kLlMxECutt98DKtslKSM
 u3ii0W+2vxnNYAcVZ0o/VAmrqkzR+Paf8DchvckZsXNDEdsGlPk6JUTvzd4z2KTkw1/72sPV1yQ
 +6TkKTHqwpmZvAC0JsFKRIYp9Q/d5cq9PP0oGP5j0TcVWxUgXmo++H/xpR+cnpHCcOFG0orLIUR
 j1Ofq8dIm+lrGPK3mi4GoVpXNTLKC9Ls7Z6bPlG9gYxLtA5OPO16ncdwN7bcYQLYXUd0NH0ap4s
 P3/H1XgnfSUN2QR7zzw==
X-Proofpoint-GUID: s-IjA5MlboPapMMA4UiJmAB_wepk6A68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200112

The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
compatible with the LTC2309 (which has 8 channels).

This patch adds support for the LTC2305 by using the chip_info
structure to handle the different channel configurations between the
two variants. The LTC2305 exposes 2 single-ended channels and 2
differential combinations.

The LTC2305 requires a 1.6μs delay between I2C write and read
operations, which is implemented using chip-specific timing to avoid
affecting existing LTC2309 functionality.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/Kconfig   |  6 +++---
 drivers/iio/adc/ltc2309.c | 23 +++++++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..791a1ac594c2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -915,11 +915,11 @@ config LPC32XX_ADC
 	  via sysfs.
 
 config LTC2309
-	tristate "Linear Technology LTC2309 ADC driver"
+	tristate "Linear Technology LTC2309 and similar ADC driver"
 	depends on I2C
 	help
-	  Say yes here to build support for Linear Technology LTC2309, a low
-	  noise, low power, 8-channel, 12-bit SAR ADC
+	  Say yes here to build support for Linear Technology LTC2309 and
+	  similar low noise, low power SAR ADCs.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2309.
diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 4ea25873398c..179ccc780219 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -108,6 +108,13 @@ static const struct iio_chan_spec ltc2309_channels[] = {
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
@@ -175,6 +182,12 @@ static const struct ltc2309_chip_info ltc2309_chip_info = {
 	.read_delay_us = 0,
 };
 
+static const struct ltc2309_chip_info ltc2305_chip_info = {
+	.channels = ltc2305_channels,
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+	.read_delay_us = 2,
+};
+
 static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -188,7 +201,7 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
-	ltc2309->chip_info = &ltc2309_chip_info;
+	ltc2309->chip_info = i2c_get_match_data(client);
 
 	indio_dev->name = "ltc2309";
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -209,13 +222,15 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2309" },
+	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
+	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);
@@ -231,5 +246,5 @@ static struct i2c_driver ltc2309_driver = {
 module_i2c_driver(ltc2309_driver);
 
 MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
-MODULE_DESCRIPTION("Linear Technology LTC2309 ADC");
+MODULE_DESCRIPTION("Linear Technology LTC2309 and similar ADC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

