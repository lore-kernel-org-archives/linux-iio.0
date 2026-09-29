Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581F4E3248;
	Tue, 29 Sep 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721833; cv=none; b=CsoH8y3C+kWETeZ8A/WTvGts4saQwl6JaWZqlJIJxUoyn7qLvXtZ9xDL3YBqdIsrdxssD1L0eR2u9SEKByJtHZCzeIUZIoEf6TUZ9QMdRzRT7AZoU1x+C4XHgcI99lfuHF+Q46tvgJvWa61InZJyiZb72aPiJR81Gi121nOfJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721833; c=relaxed/simple;
	bh=1jcs6S7y5FHwP85D4Bm8utq4PGggQXmTD+R9E+mfnag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnSXWX4Y3bUuNALcMk29GcqFg0EaoTwwrYfPtv5imEJxMgZECPRtPwBNa0LSCcH+mWGa+jyIT5xEUq9BnPGyUW+x4OFG9zSGNL7dgwR6p6/XpPtdP/VkeQN+ls0PLQeJtBKbsPaV5JowgXv/rn/wEw4hKRZz2CVv6uynrOsbJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uf3d1rTO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uf3d1rTO"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TKPGBx2453164;
	Tue, 29 Sep 2026 18:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bGL1r
	SveRm9R7ZhiPyYyrJUerm/MO6pIR1h8+z2XfVM=; b=uf3d1rTO89vdrj0hjvOTh
	ZyIbSiMBzLpNWn8hx3KWyxGad65Q1hPbzZq4sCPmogY3qIGov5qVwQI9PzVyDQug
	FnIM/kHeF2CUFWdG791R0cauaM3PMW2jX3T1Nn05kelvr3ZMbKhf1Fm9Mua+g43c
	DNtfzhjWR2Drf8PjrA3dLax0r3ONmcnjbrJcaJzxO9/aN9SFdFK+RqD0ku0YQoig
	vun/miXFkJtRDct4qi4Rvvtu7nBUqQvMuvvpejD5uEfYbKmEtHpWYvP/i6nRl+Ly
	07iUN4BQISM/jjIx2KjueJFpPEP2dQEhvFiU/rD0b5sflXzik60HTCfaCeymKEwG
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyt4g9d0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:43:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68TMhkqE030190
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:43:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 18:43:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:43:46 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMhWxP008191;
	Tue, 29 Sep 2026 18:43:35 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 05/13] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Tue, 29 Sep 2026 19:43:27 -0300
Message-ID: <1b0189124925e5f3c81a715b185dd285141a8262.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: CQwrMMxU4YOywUtFZK-UpVBkv36d15L4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX4aXt2XnAWLCG
 33R4E9zT6rXtDw8Q3McQ0lihNflCnhjzDd/0CDGrOlS3v3ZEY0PRSknHo1IWq6ywF8U4wtqi2f6
 tsrOqqRGfuexPN52E31dXdxd90whGYRbdRjPnTZIQ8rfeOJpWe23
X-Proofpoint-ORIG-GUID: CQwrMMxU4YOywUtFZK-UpVBkv36d15L4
X-Authority-Analysis: v=2.4 cv=YMkKWhGx c=1 sm=1 tr=0 ts=6abc3f23 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=oleLBB3xA4KM-oybjuwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX1qwajMjlr85z
 fZKYC5Awmd/GpRRAE3imqS4+/da2sYsa1gxZDAYbK12mkYenVCnwKa7WX6r7wj5Nsi6wBLC2l8m
 pXVeDwt7IScgJxKzoUuQzglRP1S5+/IW1VBusEiFhPLrGwymcasa8JTMJPmP4IJQsA5uI4X8q3X
 srWXGUGA5mBNpnzukiFP+lnjOTxpvQ9dwHSuQTdv2dJR2jnn07rr5w5kwyEkJ0TMBovDFHEUmUr
 1scnv1dGVwC+IQyEa0VSorvdJqnhJx425aiTE73Tdyj2pKUX3+ng0V34UlV0vmIauV2MzFYmQ/7
 +E/96eOVS5KJD7ScWNc0wUidoPKbg9kea2eiB3Z+o+8RqeoBrvGkAuMF/AVRg0qmISLUnAOsXRo
 9F9Dsz9hXmSoYqymType9PlWN3LJUPXPjfqF2oKSwj4pH6PShY4JaGWCOpYeTgA05iji5mywTj8
 3khEBj0t3PY1RVtoAjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v3.

 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index db3cf69401f6..ce077aef2d2a 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -106,6 +106,7 @@ struct ad4134_state {
 	 */
 	struct mutex sync_lock;
 	int refin_mv;
+	bool crc_en;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -159,7 +160,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	int ret;
 
@@ -169,7 +170,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	if (ret)
 		return ret;
 
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
 
 	return 0;
@@ -217,7 +218,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	unsigned int inst;
 	int ret;
@@ -232,7 +233,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	*val = st->rx_buf[1];
 
 	/* Check CRC */
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
 
 	return 0;
@@ -313,6 +314,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
 	struct device *dev = &st->spi->dev;
 	int ret;
 
+	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
 	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
 	if (IS_ERR(st->odr_gpio))
 		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-- 
2.53.0

