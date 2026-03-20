Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF93AA503;
	Fri, 20 Mar 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015767; cv=none; b=qlE3NMC6FLU2pFgQLrDErWjoTq/5GxWcXqo9RySzOnzVyy/HcMw44svHLN1sZ6qKfobvcUN5pJJjjxrTmPMPz1SBv0VzBiE4VrYO3tL7fPzpshjA0VtZbxk0NFO0J7t1QqX/Y09Cte7oOzNR0uS9LpBnQPzU9jC39pzx+of4fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015767; c=relaxed/simple;
	bh=W8gPvAuWcxBnjfCdcxSLHN8rzWLn20W4iK27zCmdb1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pR3v6m1skiPUbfpGsWLS6aFg6UMxlhXwPfQgPKjLow2wbbvCllJnI6RA/8a2WJzul/ASySWgDLZ6Mx04AjfqnzIMNogUn61uyDl67RHXArN9NlMOu9FilJXk3S38g9TJt/O/Awhuo3huqkNyjNq+6yrurTRzYrw578SKkUEWoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P36El2NE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P36El2NE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K844Da1782791;
	Fri, 20 Mar 2026 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zJeyf
	lNdnnZVKG0R4BssY+0T8vmN4J2SAHJx1l5Mv8Q=; b=P36El2NEoJR+CBdrukKi7
	1Q1+uyt8JAfhe73enZ+ar4BmLrSKLKZ7iW0niUtKplGNzGOQ73kL6SM6fyfPnNyv
	RL89XgjLT6aojNJGazV+iAsCz9vzAU94wH7WdvRmyadQRA8mjfZ8ziIKgmPFEx7c
	xKW2mgXeUpTuaY27tNGj3+WtnmonK1lImF+hn8NGum2CygaIqN9xtdNkRRn/mXKz
	CGU6yyceG03yY1AEoegBHloT8sUhCKwQvdtb9E0GngE3P+Pq3WWdy38cQfTbaI65
	WJs03XdKAoJIvgmhzl+Ro/YwXHuMZnEVZUY37agpay5pmNa9oWrwJREzO9SUF2U0
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjf8cvys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 10:08:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62KE8s8E055452
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Mar 2026 10:08:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Mar
 2026 10:08:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Mar 2026 10:08:53 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62KE8V9K014859;
	Fri, 20 Mar 2026 10:08:45 -0400
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
Subject: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Date: Fri, 20 Mar 2026 22:08:17 +0800
Message-ID: <20260320140819.191700-2-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320140819.191700-1-carlosjr.jones@analog.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Rcidyltv c=1 sm=1 tr=0 ts=69bd54f7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=xt1Mke5GkH6e2Q2BLK4A:9
X-Proofpoint-ORIG-GUID: 1ECSoVKQzX5TzqqpHQymVXZV3m73yLn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExMiBTYWx0ZWRfXziiNhpbkRmKn
 ZH/DgQjxrmMY79CZQfCN+NWQTnSCwyjtpTquj3dHZZwlSCkOAHUP2JPJWu5nwnV0SjoU4fEs8Qz
 DtWBMAavSslKP6lrnZ1i8m9BCKJN9j8z57k5bA8ATUS187j+/3Wpjodi92PJ0dHaJ1iDmmNbRGN
 8vch04VBk7aBzUq7xA2J8gozs76uTjh2mzZNDX0Sgoq8ZfPEi/HzPzynxIMdbykuA0zDRYmGQx1
 Q2/MnUOzv4xFukoGy/oLFum5d+Twx99OATK3rZV/nPmDAA/Atrc+HQ1Kt1ya3rvxehGsU/YnV5s
 AU/PZTBUnV8BvZmFBe6S23vH1j4DsWpcuarhxnfDfhTov0khvZHZ5i+GVqYVrXCw8JxjrOxB7UA
 yZRdDhzM4p2KF38O7kWs7/ij2h550w5LVqK66/Bu1Pux2lwZStiR+7L9/YxugGJBVsjAkFEQ7X6
 sRMzWHPZXVrUTxBUJqQ==
X-Proofpoint-GUID: 1ECSoVKQzX5TzqqpHQymVXZV3m73yLn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200112

This is a preparatory patch that introduces a chip_info structure
to the LTC2309 driver to facilitate adding support for additional
chip variants with different channel configurations and timing
requirements.

The chip_info structure contains chip-specific data including
the channel specifications, number of channels, and read delay
timing. This change does not modify the existing LTC2309
functionality.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/ltc2309.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..4ea25873398c 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
@@ -26,18 +27,26 @@
 #define LTC2309_DIN_UNI		BIT(3)
 #define LTC2309_DIN_SLEEP	BIT(2)
 
+struct ltc2309_chip_info {
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int read_delay_us;
+};
+
 /**
  * struct ltc2309 - internal device data structure
  * @dev:	Device reference
  * @client:	I2C reference
  * @lock:	Lock to serialize data access
  * @vref_mv:	Internal voltage reference
+ * @chip_info:	Chip-specific configuration data
  */
 struct ltc2309 {
 	struct device		*dev;
 	struct i2c_client	*client;
 	struct mutex		lock; /* serialize data access */
 	int			vref_mv;
+	const struct ltc2309_chip_info *chip_info;
 };
 
 /* Order matches expected channel address, See datasheet Table 1. */
@@ -117,6 +126,10 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 		return ret;
 	}
 
+	if (ltc2309->chip_info->read_delay_us)
+		usleep_range(ltc2309->chip_info->read_delay_us,
+			     ltc2309->chip_info->read_delay_us * 2);
+
 	ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
 	if (ret < 0) {
 		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
@@ -156,6 +169,12 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
+static const struct ltc2309_chip_info ltc2309_chip_info = {
+	.channels = ltc2309_channels,
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+	.read_delay_us = 0,
+};
+
 static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -169,11 +188,12 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
+	ltc2309->chip_info = &ltc2309_chip_info;
 
 	indio_dev->name = "ltc2309";
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2309_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->channels = ltc2309->chip_info->channels;
+	indio_dev->num_channels = ltc2309->chip_info->num_channels;
 	indio_dev->info = &ltc2309_info;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
-- 
2.43.0

