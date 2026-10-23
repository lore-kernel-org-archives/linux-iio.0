Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794899;
	b=LN31/n2x2KEJYFusXNATqbXUav7p+Ago2x2M/Jp7A3mPWbpEriEDDACWms3FDeV/b4az
	 jaGUBE/wvbfBzrl0T+Pad+XTf5xSaiN9ooTGpqpZCwnUGyAiCcGtpmUcHrSP+ZaRbOkCd
	 WSt98x2xxxIcepJuCdqUdkrS380vfytNevk7gFS4STWiFNUIZt9xfLUdEm9YKg1dGU4HM
	 mWQMWNa0nPVXFuQw/V8V6ALvXc9ibrB8/eRzjLiljT6y50HYx4Y6NdWAnjs5CpJnGpY77
	 6oS9WN4/pzUSVE1Xw+MvLPgzM8geJNk/NUkOPrBGf8sojiwD8TVhAVym4awpNjpdw2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794899;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/UxoBcBcXpHUvvcGYpt29hr/fJKoTUajG4fdx7kBAWo=;
	b=YyA82FTPrIaGG8ctkdCF5n17zoTdERbNlirCCsUL/CUXyOPu6Kjsx2I1sF1a2p53pTuS
	 evmeIdkoPdGwp8S2AwQnvbXULMqRFXOLGRY/vqSgKmiJ39Pin2bbHluHI7jszbajFr44j
	 rdwWbVgL+YUGZSnJDB3ZQYvxpCj49wsSIszgxSuqXFqEbim6FnOEkBTVDTAFGxG3DSk06
	 cK9h50y1j1rJNMXgyf5Q6vpQqiLNeLmxlWGzBcuB+vSzM+fYjCULPOhRreN698AnMmoB2
	 BcaTYBF7bS22chyHwwlBWJCKnoXkC8prCS7rxsypIhgP5WePePkAPTKSaMEgx8ohNMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pRmoJJ4E;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PlRCdWfB;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660A606A31A;
	Fri, 23 Oct 2026 22:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5660A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pRmoJJ4E;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PlRCdWfB
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwZ833009146;
	Fri, 23 Oct 2026 18:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/UxoBcBcXpHUvvcGYpt29hr/fJKoTUajG4fdx7kBAWo=; b=pRmoJJ4
	EDr3EtrDsKYvxK4OabNrPSEtgcdW/G/wJ5DOCLrRpbkgGbQyfp5R6jAgAUhBmSuG
	/GPZvx8zAZ2Dgw8LUXAE5BZLAOAxyEEs9jXVBkHWrgFz8W84Wi6SyY5085JQzkEx
	144aBjR/0Ad4bEX1Lc3e9e6Qu+wdELUB0a7Uc53YUHGXKBjDjFnHDqbhlqrc1KpG
	PXjpnYCY0YNkWsgFHtKcEWvbpY1TOpoU9i3IdVFMIc94Gr1iR7E0y07h/YvxH6oA
	FrRJt/r8LtkcPi7OcSBahnfbp2RaiR7UVVPrC9twVXrYQWmCOgR2zm/54+zS4v4J
	ft5dgbv9ppIlh4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/UxoB
	cBcXpHUvvcGYpt29hr/fJKoTUajG4fdx7kBAWo=; b=PlRCdWfBGER4d58tSXZ9F
	ep9Dz9FiZGlTgNtbrySzO7temHPkMcTtKjDNI1k2/P2T68J3iqVPsp8FLlI5eQ2c
	MmqrphlEsMbyluokQ4MisIYq9t7F+/ulCvA18pXwxyZLjT7/W2E9UM3JbwCIrukv
	FGp/toM+nSWLiQfhhWWe9xqVHHJtvMgo2TsF1h1XgugPD1hwVNInG8TguoCChc6w
	llV+mD5855k4cvRMgw1HeaoQGelnk8ikOYkRvX7OgrKFOj7pzDX3NSDP1NphG7TX
	WSLunk4LwCwuL+dlqD2/GgPV3nsZjvNFWwqW3PNFzWWGT9wKj1BZYdNbsmMLlLWy
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg3574bms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:34:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMYqbK017554
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:34:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:34:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:34:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:34:52 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMYaIa005825;
	Fri, 23 Oct 2026 18:34:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v6 05/16] iio: adc: ad4134: Serialize single-read operations
Date: Fri, 23 Oct 2026 19:34:31 -0300
Message-ID: <1f124914d7fee13c88e8f7b576dc9b6da9caee0c.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BVWhkXVCtELnnBW8AUbiIUCvkrxVQQKf
X-Proofpoint-GUID: BVWhkXVCtELnnBW8AUbiIUCvkrxVQQKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX8p8O8f2DElZW
 qhpT7xZli+81HkIg6eDnwd5eOFSBqtGeKg+hOPooXLCgI2G+QYLWVWd1Pe+xWCtBIotcDfonP8Z
 a3D13iarI6NpzctXr8f7rH55Eu1y0SjmKM8BPz2aJzxIE3/OvCt+dQd8n/wZC6afG0GoRlmMXFE
 AhVlqsa2fakai5RTIQXqe8WyfWhY/tV0ZO58HT5hZNd5nW0/JjxMNSkFxOSzRQFF2jqUh3i/uKq
 KVd6/dAzFZUtt6omJXB51qP/DqIQkERu32e/L+zz6yB6bshneEvLD9MF+l9j2YWWDuTj+ieea0q
 HfzDsg1DVPuEKxAa5AK9mPCpEGib4RHBvrWyeFC4EMhByJUpBYhCdLen4EQ8E2mbESpfugrYk1A
 JvhJyQcyDtinRyeLAs1LPcaoxbBqtvfUJxQ7l+pp2KQ5sxWT678758fv9Y6b0Ce0Gn77tqJV1zQ
 NeknAjOD9SAZZiJWB+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX6Eg9as6QsIed
 o8Ix/pjqrB493PhoASGr71tQsXE2ICpIkhf+FvoPNhnReytFiG87btBBHhkl93Ecs3A/yUYbS1U
 vtyG758STBzY0rLQH+X7I0mhN3acn+3moB2hw2iK6priQaU3KVZp
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adbe10e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=lQRJhboXyqThIMNCO80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230088

Protect single-sample read operations from going wrong if two or more of
them run concurrently. Serialize the data read operation so to avoid
single-sample read requests disrupting each other.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Added Fixes tag.

 drivers/iio/adc/ad4134.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index fbf89497321a..1cfa8066f13f 100644
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

