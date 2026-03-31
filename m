Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13A1D5CD1;
	Tue, 31 Mar 2026 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920335; cv=none; b=e7uGhtDjVuqONGmrINTNOsOjtO9S5qyT800mBGcEZrH986Vd6BXb/DdDwHWTD1cAWKCEl3XAtcrM4REwoXWLPhIQeke3GfLSsKR6Sp+2vBtcGUEeo6oKOxbkFjfHyAqPMYMtKIPJP0R5o6TnFNPggZZddCiNN1GCHtZIyAzywss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920335; c=relaxed/simple;
	bh=RZY91OMjJU28Y7liW+BhB8BHNyy+3hpc+bc9SQWyHV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWsa8cZOQM57ENZL/X1Xi6ttg5XVbw/4XemDAqFY7TvjQfoTl9xsZzIY51q5NpYF+BCcXdPc5gA9bQqXlIE2ciIlGSxe9sPMPQxTZlzIHwJVlgby5Pl2b5gPA9KoVMKtXLWWlqomT1b+wNay0utxRwwSjnXe6XniXgnB8AtxMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TzYAIqsT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TzYAIqsT"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V0drYs3764506;
	Mon, 30 Mar 2026 21:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3a9qY
	G8Ob6vH+A4MposzRp3at50bEOpQJt3N/E5xu3g=; b=TzYAIqsThC3uH3r/DP1Ie
	YO7ABTpFEJKSnCXyv/zjifAuJH4NcolUt8FNM0Pw+uw+goplFN9vQCjjVsyhK3ze
	Diy8X+l/tNdKJLqeppZX3KIydnZGi0aLLfiV7NxgYsdPskqwOPYaK5zgwgjtldHD
	SOphmh51MvtkUcxEj/HAj7hX7ImTQRSwX/sRMON9spXnvnoNX2qcYgu+TE6jRxHt
	/yzynfC1E6qEeGK1AG4dP2NiounoSGCSawahnpulBQ7GY0qFo8yg/hNXOZZcAwSX
	ePVBjRYFAhEY/QiV6Yl330PRcCBvhgJMUOU4GRNWYyUem2EwXGrkY41oavv8/gxg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw11w1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 21:25:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62V1PS1n061178
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 21:25:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 21:25:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 21:25:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 21:25:28 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62V1P8RT006886;
	Mon, 30 Mar 2026 21:25:21 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iio: adc: ltc2309: add read delay for ltc2305
Date: Tue, 31 Mar 2026 09:24:56 +0800
Message-ID: <20260331012457.9324-2-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331012457.9324-1-carlosjr.jones@analog.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ByTF7iYNgV_reMd_jnftCDhIkx80RSLF
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69cb228a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=gHBF1_SLQoPjBxjgEcUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ByTF7iYNgV_reMd_jnftCDhIkx80RSLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAxMSBTYWx0ZWRfX7U/NiBKtyaeh
 tll1fqVIj2h8coRTrZdr7gKUgDItXuse2tCF3K9c4EhjVIoXqFGZ+9aoxRAiBtyq4fD845dZY6+
 0SJtuZETtNVbmh0gOpsTzKiW0o15jlGVIWaQer37SK8xBiCYJ7M5xIAvCgOXVuPV9sz/6oyxtKA
 iwTBmXhQkLtKofpQpwDBHSd+vblSs+lhaM40kYWnWSLKRIDejq/7l97DqCPZSc+9I1JujhFzLMY
 XZRhYXpUgW621dfBN08EgNKy2/1j+xi5FP6VrFm7Qt4I4hTSLCraAPpS7ceGdGIWoZ3h/Dh1N4K
 6PZR10XrWMyvZop1R6ddPKJaFiMF+PRFA7r9VHqfJ66gt1NKZn+PERjOZ7muEKkeE5F70PjueJl
 bNMDQcK22d/w5bmkFstVUtLiKJWGOztsctVKyVlHr8SuUXDWiOOv6u0Mywqro3qWy7tYV2iEuD/
 h5lwEHFeQVkpROXy1lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310011

The LTC2305 requires a minimum 1.6μs delay between the I2C write
operation (channel selection) and the subsequent read operation to
allow the chip to process the command and prepare the result. While
not explicitly documented in the datasheet, this timing requirement
was identified by the hardware designer as necessary for reliable
operation.

Add a read_delay_us field to both the ltc2309_chip_info and ltc2309
device structures to support chip-specific timing requirements. Use
fsleep() to implement the delay when non-zero, with LTC2305 set to
2μs (1.6μs requirement rounded up). LTC2309 does not require
additional delay beyond inherent I2C bus timing.

This extends the existing LTC2305 support added in
(commit 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305"))
with the missing inter-transaction delay.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/ltc2309.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 316256edf150..094966289922 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -9,7 +9,9 @@
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
@@ -34,12 +36,14 @@
  * @client:	I2C reference
  * @lock:	Lock to serialize data access
  * @vref_mv:	Internal voltage reference
+ * @read_delay_us:	Chip-specific read delay in microseconds
  */
 struct ltc2309 {
 	struct device		*dev;
 	struct i2c_client	*client;
 	struct mutex		lock; /* serialize data access */
 	int			vref_mv;
+	unsigned int		read_delay_us;
 };
 
 /* Order matches expected channel address, See datasheet Table 1. */
@@ -118,12 +122,14 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 struct ltc2309_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
+	unsigned int read_delay_us;
 	int num_channels;
 };
 
 static const struct ltc2309_chip_info ltc2305_chip_info = {
 	.name = "ltc2305",
 	.channels = ltc2305_channels,
+	.read_delay_us = 2,
 	.num_channels = ARRAY_SIZE(ltc2305_channels),
 };
 
@@ -151,6 +157,9 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 		return ret;
 	}
 
+	if (ltc2309->read_delay_us)
+		fsleep(ltc2309->read_delay_us);
+
 	ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
 	if (ret < 0) {
 		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
@@ -206,6 +215,7 @@ static int ltc2309_probe(struct i2c_client *client)
 
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
+	ltc2309->read_delay_us = chip_info->read_delay_us;
 
 	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.43.0

