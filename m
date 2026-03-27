Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449D2DC344;
	Fri, 27 Mar 2026 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582963; cv=none; b=JALmim6UhrLm/llhBlaysgRBs2XC2ipArVrlgWEXG1ZrmOAKL2BiQxvuLiQh8xyGqFHuTYSW8UvrcugFfwa6oNyNzDwL4fyjiBQ7q/0X/vClyaD6Tbhjk53RueWFVp/zHgUoZVZHxOni3SY4a5yiOPNx4POosrJAl6JXgnE1Dc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582963; c=relaxed/simple;
	bh=haeH7OQsFQbwTmSClNSgsvTamdwjIV7GzQEI1SvHh80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RPVwW4EQoBQSwmKkuTMI3Iq/7OnwW2nbjuSrQllZfyiyckcuNHqlk+GOZ4qHYY6je+7HuhQHxBl/DoRxjhv7G2Ys2rZHifY6S6ehr1s3YqU5S7dNaySnpSoMoxC2G6Mi3kPG5jV/zUD0IU5RjZp4aX7kRmrzKfko8Ppmfth7d6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LiaoZgYE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LiaoZgYE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QKaQTo970507;
	Thu, 26 Mar 2026 23:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=CgVgoDP8oXjYhE1nsUtrb/ui0uf
	ozQI8QA6hBjpHbSY=; b=LiaoZgYEwryeX5vtTAIP+CZd+XQvoGAGLrbbhqAnY67
	pBzeD3jhyK62Je2M3ranxpe3m2cXNjd6hlz4acjXlTaz/xB8eBG/5TIOxQE8HcIN
	zUkh7WD34JdSuItwo20i7cPFUXvLg+Hl/Tmfs99zlUgki1AhdPyExGycy5moUFZ8
	DOAu3OFcDxOyh6Hi5bG76eMJTgw3PmMQaTO2e2iRTP2z2CqUUARmZYD1xkvP/VdB
	P71CrYV8kb9Dd0+NNwDuOnRoqBxbfgxHuC2kxHnSRsBMMgH4qXlVTs594rfDtu80
	ISxHZAQz3H23xjRI/J6Eh/dnjEY3y2NGDMnzJKXtDHg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d45h03k7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 23:42:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62R3gIc9021334
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Mar 2026 23:42:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 26 Mar 2026 23:42:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 26 Mar 2026 23:42:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 26 Mar 2026 23:42:18 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62R3g3fT012413;
	Thu, 26 Mar 2026 23:42:06 -0400
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
Subject: [PATCH] iio: adc: ltc2309: Add read delay support for LTC2305
Date: Fri, 27 Mar 2026 11:41:59 +0800
Message-ID: <20260327034159.15545-1-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: egsn4_AkwfoLjM3-FKyp_q7sgj5-Mz_r
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69c5fc9b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=-BrAIW7jJhjszspebQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: egsn4_AkwfoLjM3-FKyp_q7sgj5-Mz_r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAyNSBTYWx0ZWRfX43LqX5CuLKAR
 Ep39Ivp+q9GUXZMk8rqdNDpEM+YE6tUjnOlzBX3XNhN6khGwX5xnbHBCWb7yD0ApVLuR6WT0Sw2
 v1P7/P/rPHuwj4grAIleJ0EbYobPkCqeFVNVOBgSDjYVqyO3Tc4044PAz3xGfDE4ag9JBH46dp9
 zjzeqJtXZyWKlZ872Lwqp77CIvxSZrpOMhUEHBE+X07Iz2uxfz1wrezNw17firYqslgQRcfl9Wg
 2WKSceQFRkNlPetGXImRBwPxw+fhmJ0HASljLA10e0CPX+gbrhaG1hRaKylDJJIDJIApMLJQqRQ
 TmQKKQA6wCDNvzRp5VNKp1q6144QvlGe1hq6giKK3kuCtxSyeEMlb0o2DO4QOybqYRCz3xkLD5a
 0rHYc7Sfs672d4qVSRYXJtVK2a75cl7tRdBSyIIG/ePgwXwuXYEfWtxcM/IXf9zPalKsWm6VOd2
 0Z4nQXYPGNt/EQOIBCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270025

The LTC2305 requires a minimum 1.6μs delay between the I2C write
operation (channel selection) and the subsequent read operation to
allow the chip to process the command and prepare the result. While
not explicitly documented in the datasheet, this timing requirement
was identified by the hardware designer as necessary for reliable
operation.

This extends the existing LTC2305 support (commit 8625d418d24b
("iio: adc: ltc2309: add support for ltc2305")) with the missing
inter-transaction delay.

Add a read_delay_us field to chip_info to support chip-specific timing
requirements. Use fsleep() to implement the delay, with LTC2305 set to
2μs (1.6μs requirement rounded up). LTC2309 does not require additional
delay beyond inherent I2C bus timing.

Also optimize chip_info structure with __counted_by_ptr() annotation
and field reordering to minimize padding.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
Note: During independent development of LTC2305 support, the hardware
designer clarified that while the I2C bus timing might inherently provide
the 1.6μs gap in many cases, it should be explicitly guaranteed in the
driver to ensure reliable operation across different I2C controller
implementations and bus speeds.

 drivers/iio/adc/ltc2309.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 316256edf150..87b78d0353f1 100644
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
@@ -117,20 +121,22 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 
 struct ltc2309_chip_info {
 	const char *name;
-	const struct iio_chan_spec *channels;
+	unsigned int read_delay_us;
 	int num_channels;
+	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
 };
 
 static const struct ltc2309_chip_info ltc2305_chip_info = {
 	.name = "ltc2305",
-	.channels = ltc2305_channels,
+	.read_delay_us = 2,
 	.num_channels = ARRAY_SIZE(ltc2305_channels),
+	.channels = ltc2305_channels,
 };
 
 static const struct ltc2309_chip_info ltc2309_chip_info = {
 	.name = "ltc2309",
-	.channels = ltc2309_channels,
 	.num_channels = ARRAY_SIZE(ltc2309_channels),
+	.channels = ltc2309_channels,
 };
 
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
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

base-commit: 8625d418d24bc0ff463267b26b7cb2e7a612495f
-- 
2.43.0

