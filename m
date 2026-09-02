Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E303D9DDF;
	Wed,  2 Sep 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369810; cv=none; b=gwAXhlNE4el8Swol+/rtK6GMyTULQZMSyKQgt9XwBLoBrxJcG/C2meptg7EzEA5nmeiadx6WIPq3+N9EoVcW6DSQLq3nzWohWuPCIdj2WaOtS/IbN1kDLa+O5IpQZZsCKh2dn+nvk4cxJnC2WMakh/DRTeB134yfaJWiMOHTo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369810; c=relaxed/simple;
	bh=SDYg04BwrnJtHOAhFhP8hpz49gxqSgMHSvq2v2xbfkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2nbXG13qphHcYVG77JnqyoqyxvOT30h3iDRG4z2fxmTg0YgKqNzbL+9KWIf+9ZKIAM5szRpjOwpDx3BcPzQ6RrAzL9PUUzdcOtJ9AgM31UVsFAfj3qAFvbg2ARCladB6OVgodLm07fswGGkOufuGse65gEYlPZ0KL7qfRHCmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QVVHOVUF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QVVHOVUF"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDHPM3087761;
	Wed, 2 Sep 2026 13:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0/2gE
	pKAH29DYlEckZxj4owI/A6j2xPDTGVVNE80P/0=; b=QVVHOVUFW3v7OpzVV7/v2
	AZBu4uX62km4jpk/du4LkQRb91DVnjEaZ8DjI86M5awOiC8Te39HfcmP76yKnGrT
	6LgHHA0XEVtbUKA0Jf7uqBDpP0BzBNt3UJ3gIabT5Xi5wEgOszv2Q/HfAEnFUrsC
	MZfwhf4NN7wgjBYZRvtKajL0q9uCdN1Jrn7cQdqRUjdZ+yrSrpg9iEEzcOkx88DR
	7jG7O/KDVxGXaGK74JY6o6eLYc+aKiHzJexvyrX+MHNzcgRlXbBcG1RdTbcyQ8M0
	fdJFh6ZKiyQGH4UX4p4rOGSzNSWBuMbnGmDxdJx3EJFFerUDrvzIj18oEje6Xcub
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubsxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:23:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HNMOJ041309
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:23:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:23:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:23:21 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HN7SJ004229;
	Wed, 2 Sep 2026 13:23:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 05/13] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Wed, 2 Sep 2026 14:23:02 -0300
Message-ID: <e7f106f7cfae15675a3c04a57d486b478b182705.1788368334.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX5wHvWPx1TcZI
 KaU3/YoGvdnAPIMvRJPUP0n3+i9JMV2UiIgCGcQdkLisbIheCGXulX5cUSAM9Lt4qCGZ5tpHq6r
 yoHjBbSqePETDyycphphYYNv+I3+i8JZXeAj/JSFDv07cAHYk6DDNprm9XCyNrhF81N10df3Va3
 qEChj12sCx5rO6SBJRL3RUcZw/7DLvofQH3B5DLLQJUjsf3NUDQMvQCPAhPtm8LvCH64VPnZwQB
 c2lCX1rKXp5qzX10IWU6cIxtrL+6xNbbuenzuvhtunksneB04zcTHNCOtjWffKcyYljpxFz146v
 7PwJOS5VsHXAF0BSJjv6gR/MyfMQJDN/bwVlAt1A8dVNq4c2AegDbuwq/InsLS8TqhuN78Ic/xU
 YsK57LOIMMMKYYXL9x0Tzq6Ml1HszgqCi0LQuj41d5gZoq/+bFvT8yZP0ynK0GGq9+ZvX0LknkJ
 LvwF7lMcytK01YXJtUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfXzlHDZ8GVRZJc
 /R9V2eNgp642P8pDdhK/WYd2ZvZx+kOvw4enRRB9SDYd/gYMkfg9R4kmq+YuMjUp3LkTYZ6pLEm
 vxtjmoN56VhR45ZRGuz1a+RQRx3K4HPtIIMYl/budyIoR0YqjPRS
X-Proofpoint-GUID: sULPtR1Z_uMvBaKDbUqgy-0pW9YnB6e4
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985b8b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=oleLBB3xA4KM-oybjuwA:9
X-Proofpoint-ORIG-GUID: sULPtR1Z_uMvBaKDbUqgy-0pW9YnB6e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 3460ecf4cafd..7da6734d4609 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -102,6 +102,7 @@ struct ad4134_state {
 	unsigned long sys_clk_hz;
 	struct gpio_desc *odr_gpio;
 	int refin_mv;
+	bool crc_en;
 	/*
 	 * Synchronize access to members the of driver state, and ensure
 	 * atomicity of consecutive register access operations.
@@ -160,7 +161,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	int ret;
 
@@ -170,7 +171,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	if (ret)
 		return ret;
 
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
 
 	return 0;
@@ -216,7 +217,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	unsigned int inst;
 	int ret;
@@ -231,7 +232,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	*val = st->rx_buf[1];
 
 	/* Check CRC */
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
 
 	return 0;
@@ -310,6 +311,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
 	struct device *dev = &st->spi->dev;
 	int ret;
 
+	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
 	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
 	if (IS_ERR(st->odr_gpio))
 		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-- 
2.53.0

