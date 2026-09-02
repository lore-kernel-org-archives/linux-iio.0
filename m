Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497684AC17C;
	Wed,  2 Sep 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369789; cv=none; b=BzjXKglHJwM0lIUdpOClNpFkKkBP5QQuBTsSProsRX5Lz6dmGtxbvOED8pPp++viRTpYkkmVuRHF4vN0ktaJlqdQbXbIqLzzHH6tSdsn5Iv94Z8YHjWHeIfyOxB1E8VAm2tY3eeaknSUtXjTbcSupYaFgT3DM4Qo6zZrUiARSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369789; c=relaxed/simple;
	bh=ICmI3F3FOYsE5xQNODkcQAWr8LeLokuVswR65Ngkx+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLgLlqGh5B9PWNd8PNUJD5WSKfXJ6VaW1eJY+L4cMq2ADEnsW5FIYE46nShYY1izkXKrtOoCHnnirMQ6zfD+luTrjDxs9Mr+4g/K6l57S/iv82VsdlW4A3oMxyVQz2apBOmjAuZqc5xu/UxfogO5/YMZVIlTmzqQmCJBcpb0eoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JzSZ1EHS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JzSZ1EHS"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HCwBe3525540;
	Wed, 2 Sep 2026 13:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HCO/N
	3/MUq47GZXuCAwDiY0XO5tGlWqo0yXODO9PyxM=; b=JzSZ1EHSr8Dt4aHZ26fqP
	4aEYgP4xl1XK7mkeLeujgMITrAFq2TMoxb8Dm4R5UvPhOKMMMbL1JjfqefpI2wUN
	F94AiYB2mXqpry2pp8Z5VAeo83Ew0z3iarOO7Rsrii7+BmduvLfHY4RDQ3vW+NpM
	xOhmKL0bEnaFsD00AO+TK7frkeKfPik72KLK8PyxlKf1ds3t6Fuk/u5kNsOCbXZo
	zBUx0EVg+tfIHqr+HwNUbxpkIPjoM5LFUXKnp9ltOCv9ObYV9NqqZiOH8YsV+JYH
	EkaOzgMKp4p98jifinO5yTr6KtjCKxAfNByTjv/2MJEa4trw8rKoXB3A46kut0Sn
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge0yqp6qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:23:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HN02v041257
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:23:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:23:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:23:00 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HMkHA004223;
	Wed, 2 Sep 2026 13:22:49 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 04/13] iio: adc: ad4134: Serialize single-read operations
Date: Wed, 2 Sep 2026 14:22:41 -0300
Message-ID: <4e136d116b2eda46fc36f3a3ded3990972c012c4.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Wd87TxqfKmsKjSAqTmkfEW34j9660jGz
X-Authority-Analysis: v=2.4 cv=S93pBosP c=1 sm=1 tr=0 ts=6a985b76 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=8PuyNXegNDdYRkMgdKAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX1mi/sxZN7Y21
 oG6lHynhuLzoE6E2VdPpp428BC12FVaUrShA8PRC8Fdmk8M2D0tOYVZwO2l/CbTqFGqXS2RzgaR
 4pIAaMKbC40aL5lfoZEc1F3zT7qLdpuvJ0QUXS+JcCRSzFGr1PcRxx7rEyx0ixQFeBBK1bFkBc9
 qGCUvVPM8fED0/U3No9XadgryjJPcZppQ13DlT5XyOZU3oxdFDn8Vb1I/Cygw/iFYTH9tO4VHry
 87ZvtFXOP8H00QWFDN5y8G7PlgC8HwcTQjWWWLsi+wNb2nbCcUHu4Cz6ywsmVVEjYUZ5sgMfuc0
 wnpyM2yz2KIZe6D4D3PKpX2CHSWvoQK0spA/D5bb8N5Kj8zLHkfhrmRGXniXiPSziwPD7/siinE
 tM8R4lfsmpd4dQChn1qSBb6blXCs/cznudQ16rI+R4sGlIW7hjXV0J4xzPoOQuZayyOrjktQS5O
 /MmHGsBQgdEWMHNGHtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX3xRV2X7tlqPA
 pwyHKsX8d1jDe1F1Dwb4vqpRAalJMoJa4ht6/DVsEt9LSud6NxAetJRSnJ66OpZFWXAVPqe7U7U
 Ly0UQerGtk6FKwDVm8HSLYRlobPeiOSs5jZINzEH+Geo0f0tcdgQ
X-Proofpoint-ORIG-GUID: Wd87TxqfKmsKjSAqTmkfEW34j9660jGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Protect single-sample read operations from going wrong if two or more of
them run concurrently. Serialize the data read operation so to avoid
single-sample read requests disrupting each other.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7a3b05aacc74..3460ecf4cafd 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -16,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -100,6 +102,11 @@ struct ad4134_state {
 	unsigned long sys_clk_hz;
 	struct gpio_desc *odr_gpio;
 	int refin_mv;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive register access operations.
+	 */
+	struct mutex lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -257,6 +264,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		guard(mutex)(&st->lock);
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
 		/*
 		 * For slave mode gated DCLK (data sheet page 11), the minimum
@@ -443,6 +451,10 @@ static int ad4134_probe(struct spi_device *spi)
 
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
-- 
2.53.0

