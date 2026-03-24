Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8C3BA225;
	Tue, 24 Mar 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336482; cv=none; b=XYyMrjgH6R8xuc4JUDDNu0UiUWGyQUvgJa1VoAF6ta0WvuAqw6DPt6L2v1ZmFtsShgMQRrhw6VumB679tEb7USfBHzfxBfufiDjfPYnMknWe/foSRXy4YG6ZKMsbTZIQmtGvAa3ZF0A0Pf4oCEznymCOSyNrma/KodJN4Yg8g4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336482; c=relaxed/simple;
	bh=wN9HE5O+IPyUmehFY9bXGf8km+mj/XuYyBsRnP1EBgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm5CLFdafBe9YUPXIhRgwYSsHtkSgeHf1KbkNNZA9fgBMpJCnzwRNvHpkuFTp3Sx4uAOxKwztQMB+62Y18LpZeWvD5Npsn9KvGiTDU9MsRbnhlYSFJyooXXILARr7e13llPeiWtF+MI0S8HBusjMO/qVCmC73U8QMvLCYtB3GrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q+4rZ3DW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q+4rZ3DW"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O40mw2662592;
	Tue, 24 Mar 2026 03:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tY6YM
	xJ4WjG+clpVVwul7m5JoaLSzMSyfjlx4I9sgIM=; b=q+4rZ3DWboYXJia9NJMbU
	cLQb3N4xP0Z71gQ87YPNYJNark1DTWM/5vdflBFvh8xFGXT5hFsgAShNvrIIgW8d
	FyzUZqInHZrSb+6s/Ty9Zyp4wudBJyH6hf7c0NqFRKZ19GK+m+09eSyHJUq2pNJr
	lNqE6LqZCiNXD7kYz6D9v/t6bfKT9MUxf1PWl0gJYjRrTe1l69e8JGA5SmfLWR7A
	HkTgzdAWpz0of0B6rvqp/UHh4OMVDKSeIx0ThigvGcgDQ4Jl+kGqowkm8DOCBcLE
	41CEycPYgEiAxUYwd5B0Hmb+yLYX8BLB7VhByI9S6UjjY1NclnS1cLCUZiYl7qJV
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n62399w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 03:14:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62O7E7K3020237
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Mar 2026 03:14:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 24 Mar 2026 03:14:06 -0400
Received: from CJONES7-T01.ad.analog.com (HYB-jCCu8MOWEgi.ad.analog.com [10.116.223.230] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62O7Dg0c003654;
	Tue, 24 Mar 2026 03:13:57 -0400
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
Subject: [PATCH v2 1/4] iio: adc: ltc2309: Introduce chip_info structure
Date: Tue, 24 Mar 2026 15:13:28 +0800
Message-ID: <20260324071331.842-2-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324071331.842-1-carlosjr.jones@analog.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NyBTYWx0ZWRfX3f41DVeIZC3r
 U+/BHCRJVgDvPTVBWYvC314LjwC3p8GsNAm4rG6yDCgIEqbkDkHMJlPu0WyJ+2+pMHCWgZ8nwa9
 JlYoRznQGCe3IuVyeKiMs+8MK7sFeuBlFpHF3+PbM7zvTdDFu4cJ1GBZWyqPgE77EEbZ0JB8j0S
 RR1aFrcDPTCpRgd8cV2mw1SpyYFRxHsp0YAc8fsCL6zlE47Zr4Sf9OtfChjjXNZ2DPXaK6G2Nu9
 47+IqQyU44zs6soTz5KBobl4cH8JjpRcSiWkUuu4unEPO9RasPWKe2fBKUZqs4PLMmqh/cXtVPU
 Ki+iuUQqfqZAXvR12wdNVFcA0RWVOpdoLIGwJgo43IN17C/Eku8e/MCoFOv4Z8qv26KBL26wauX
 1yBjOjp8FCVCoz0yyrgfvo4jIzzIxyqMystEnZSjTVOZjvHZgIw3sex7Q8nAUfwpRBFG5JRB2RZ
 qpotWEAwLk904/HFSBg==
X-Proofpoint-ORIG-GUID: juYBNpryKw1xcwZfj62WEpe10yTlWbE0
X-Proofpoint-GUID: juYBNpryKw1xcwZfj62WEpe10yTlWbE0
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69c239c0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=ZorkHgBYlZiqIV_WkfAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240057

Introduce a chip_info structure to facilitate adding support for
chip variants with different channel configurations and timing
requirements.

The chip_info structure contains:
- Device name for proper sysfs identification
- Channel specifications and count
- Read delay timing for variants requiring settling time

The ltc2309 struct is modified to store only the read_delay_us value
rather than a pointer to the full chip_info, as this is the only
runtime-accessed field after probe.

This preparatory refactoring does not modify existing LTC2309
functionality.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/ltc2309.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..0644b1f02568 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -8,12 +8,14 @@
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/array_size.h>
 
 #define LTC2309_ADC_RESOLUTION	12
 #define LTC2309_INTERNAL_REF_MV 4096
@@ -26,18 +28,27 @@
 #define LTC2309_DIN_UNI		BIT(3)
 #define LTC2309_DIN_SLEEP	BIT(2)
 
+struct ltc2309_chip_info {
+	const char *name;
+	unsigned int num_channels;
+	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
+	unsigned int read_delay_us;
+};
+
 /**
  * struct ltc2309 - internal device data structure
  * @dev:	Device reference
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
@@ -117,6 +128,9 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 		return ret;
 	}
 
+	if (ltc2309->read_delay_us)
+		fsleep(ltc2309->read_delay_us);
+
 	ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
 	if (ret < 0) {
 		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
@@ -156,10 +170,18 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
+static const struct ltc2309_chip_info ltc2309_chip_info = {
+	.name = "ltc2309",
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+	.channels = ltc2309_channels,
+};
+
+
 static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;
+	const struct ltc2309_chip_info *chip_info;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
@@ -169,11 +191,13 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
+	chip_info = &ltc2309_chip_info;
+	ltc2309->read_delay_us = chip_info->read_delay_us;
 
-	indio_dev->name = "ltc2309";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2309_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->info = &ltc2309_info;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
-- 
2.43.0

