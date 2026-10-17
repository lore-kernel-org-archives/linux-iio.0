Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9B3822A6;
	Sat, 17 Oct 2026 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202331; cv=none; b=jXwDXu2PCjXhxJFRighc0jkliEuyWAO7LkHbx6q3pKrW5bJzS+MZK3C0/Dy7iUL09VcIdHxjVUWbLAIXeRbWJf656TOY80F1PQAVYrTkyISwZa1Euv3ybXaWfbIeRozWTJ9F8A5CB6N7WOjnAHsYZx/hq+2/kwkGhE5PlRkBTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202331; c=relaxed/simple;
	bh=5o8qyae6KMUGHtpjcgPPYbB9gi5Eyoi6PawqaI70FX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNfq4yCzH/5FQWtyDmBCFHX4DOjN7IXfNuWy5nFJ+d25fBEJp2df+0M4+xD9cyzQHy8+r7gOuXlC0WvC/vfIr8furikvPJPXxXmetuAOArewCLVEfhehSk9AytODEKbpR9LqGYNpTnd5qogAzEbiXc9Gjbap6rBh5cDKUqRGaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=jJ8uBpp2; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oftSV0SL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="jJ8uBpp2";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oftSV0SL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHCWT2042830;
	Fri, 16 Oct 2026 21:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=w6Ajh/3KzHWGk9Ii8EkVDYON/hmTjXZ2q+6lmopyVnk=; b=jJ8uBpp
	2fHlBjKIAhMA3cWrYJH9mgtrvN7POM3GMh3CARNHcDOLiF0S5JULpl6S/diQf9+e
	rf+jckctxP6i1AmJHCJHmKUeI0j5m2ELKLrJMkzmfg4j+tBopCjZltKyf/tYudbx
	uMOhkEH0feR4S7VuP0+W2NrFWi3mLNAXj3vIoaJpE0vMY5NHRrEy3yji6fcPyxOT
	vRLx9t1DrBDOaI1YXlDVAOohBlCuLnVo9eqmi7pBHZNNU8sE8/p0D5XWmJzy6i+H
	IcS841Zy39qRGyRSNxrfX6e2nN1Z3/PdO8u6CmuMfGgq2OG4jg9DA1oM6cgJb2aU
	Xz6R4LP/0G0N2YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w6Ajh
	/3KzHWGk9Ii8EkVDYON/hmTjXZ2q+6lmopyVnk=; b=oftSV0SLZH42uhZ+5nz9w
	t4j5XXPtd7oYPevQj8aV3CN5HTPdHGOmLvDZJ+iciofruc+3IAPMRuA2uYsSznSm
	C9LT1S8toKiiM32VbIbhee9ZqhqS4NCpvbK8A7OhWPqSzrRhz+cZCJkxShL/caVw
	RDwLc4e9BXiMrhB76JXt+PSrmz2HocqcrhTr35gkm575R0J30DVPV6wEFebpNqKo
	VVHEMfbyjDIOqmdmWz8vV+4QDli21qVrIM6ycnFR4dubNVebZ5yDE9CuWKuf4+FG
	0EABOh+DtHujfD/ucaeoGAT1DPXqxlPLOhJMT7UE7mKylFNeIqVg+f+kQSE/aT6z
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk6m2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:58:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1widg061743
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:58:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:58:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:58:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:58:44 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1wVJx004329;
	Fri, 16 Oct 2026 21:58:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 07/15] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Fri, 16 Oct 2026 22:58:24 -0300
Message-ID: <9273caf43de3489b125b1ac8597e7584a3c0f160.1792200021.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXwy3YAvpQfU6e
 YGIYoSRYxAUZ6kLYMlJ/0ZhbNK5nFYBkwPii5adLBF6hZhJhCCVDjD9muGexYYOvtQ9HvGjOf3R
 Jp/hBAGq+aP76blEWDFMk8HbaGvPurVSyfnTd1IxuZK525GwJWtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXzBesXIg1RBH2
 i9Dejq/sEvGrc0ikL25kvFc2sqAAH5Dp9Y/FLXcPEg/T/Ik2gBlkafiPSaPqxNwWTNE+z7AKLEv
 tq3CQAqdY5rhuw8qqi5quISphTcjs8KtfhtJuzuLj9EE89FjHXdfWxYWzALr/EzbQFd4REjeGK9
 mCUjLzCNPyOwu6Tnsq4+8ocOA73X5JgmCXb1ZT9BvZm+pkv/CW5crNp/p6PL7L1SBTR/EPcyEYZ
 qnrfSyfd9iuDBCM2ynIhkNL0hpvmkXEuCLXk3TfryEr4qZUM01DG7ZKOcf8IhksxKRMGzwx591p
 cBhWlYfAMxXdpWzQGUw0TqE0ux+ndq7hOA1O5ii2dhvSONpgCnPYVrnPqqGhLoExFPnuFuYdRZB
 ReSJibkYxDqF2Uy7ASuHAKkWdfHNEaVpgL+/kJT1TxMCbKTHW2MDccU3ntqec1U177o2jy7WH2n
 tAm/tAvLZmHHJ2d7amQ==
X-Proofpoint-GUID: r1n8uSkCEdOK4c_k5c-kTtbbIRG5eHSV
X-Proofpoint-ORIG-GUID: r1n8uSkCEdOK4c_k5c-kTtbbIRG5eHSV
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad2d655 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=oleLBB3xA4KM-oybjuwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170007

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 42a1272c2894..91a7c2107770 100644
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
@@ -319,6 +320,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
 	struct device *dev = &st->spi->dev;
 	int ret;
 
+	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
 	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
 	if (IS_ERR(st->odr_gpio))
 		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-- 
2.53.0

