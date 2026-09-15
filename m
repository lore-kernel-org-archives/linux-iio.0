Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F164CDA35;
	Tue, 15 Sep 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499657; cv=none; b=oxu5CWM3kyXZTVLpNXMBFIYiOtMBP1vzMGMyJH+/v9K2w30yCVZqmCoVpI/4/3car/s0n1tpwO/TXq7lCSBi+v5UaiqSA6umjKhBNkroNc5JD5NTRIVSXA9/Ql0GzidOfvmG4Y4qFFhb8HYBi1pEimlxMaKNkLpaOdW1Z6n2jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499657; c=relaxed/simple;
	bh=yTS3YHxIrqB0FTK5hh0K9SX0v6Xl7xg6JbJTLAqi6eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozZtjVS4dQl1D1DAT5xm3fH0y/2kAjDSBPtYetZb4gUs+4o8Trm0MqyS5eiZfBIVZIWiaPM4xpWFEm8rtblrGxDx/bV5nKn9x5zQJaug5MygtOdbl8qdzVfIGetnH4pm0ucQgMZyS2f3z8027JenxzBXURxeUYtgHxcpbQzjKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0pqGASFi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0pqGASFi"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsTG11279425;
	Tue, 15 Sep 2026 15:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xt1Ep
	LU3HquXk1aVcfC7E1DHsiA25IQXrJhg3msO/D4=; b=0pqGASFiNCIZdfBGWfqGL
	UqS2VmB3AQ3RaIrSztuP7Yzl9eUmQrNXAIJ5PzboEfk12LljaSOQZFSN8csaQEFA
	KnJdZszR/CvpzvgFi0AnQWqhYlErUSitQuTGO1nsKHbxQ/l8gp6lsBQQfHz0i7xf
	59aYjIUjxEQleFUqd6zbFVExPlg+PqAh99IqokxZshA3nzopUrXoUc5mydUKvbvN
	9DNCgSgDpbrmqwyFt+66zGRBQZS6gRLpFJe+Hgw3bAC0pAaPVwpzl/sLbsYBrvax
	sT0v4WAKpAvjsYxeRFLFtboNLq1SO/SF612kh+bttTJrbvwP0GXp/Ofs2xrCtGu6
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c0u4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:14:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJE8FT019215
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:14:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:14:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:14:08 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJDqYq028146;
	Tue, 15 Sep 2026 15:13:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 06/15] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Tue, 15 Sep 2026 16:13:47 -0300
Message-ID: <5522b7295a995855bef4a20b32dff1ab6c75010b.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX+ejIaEuJXo9a
 MMvfxDlriuy69RapqRXA0Pow1uLB40gQQ01pmNuwkdZn3JYNDJNXuUpK5IJyJ+xZthL6sLAzBth
 LO/lEY/4/Wec4AeF6SINogoB43LHXc98+A8aGNMyyhlbmGRxmlq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXzPHS5iZKI/gb
 aAyL86151E+50Cjss/HbpVccLvtO6zDtBKRR+pK9Enp/QBHjqhG17jL/oOaGry3L4cutoiqRtm1
 jNUkACKTWYWwFU6gCErY7lfKi+5gbME4B40/Ft/HlrtcljaTAO43Yhvxadgsu3daFCOFbjv6ej5
 9t0FEoSdiqPcR+Yg9+Ll4NXabqsbN6aTTR5aT1JMHeQGMhH/P/E1VuVm66AiRUrhRugb2I1KjQZ
 E84Ou8Jgf/j+B46d3tuGg65yXLgm5gT7P/m39YizGwuty4oEGJELQUW93izsZV0u5O1YI/neObU
 CsqKAwnMZuq+w3E5Y89F78d+XsrmIi6SM0XOE4pBM9JEfnPco+8NquJHwrBWK2h04gCaz2iWBPa
 QI4yk6Fzwmo5i1LyXTqDa6OiKPcGKsTpJj/klKumGkVT/Mny6DREoW/1mYNwZSqSkZBw2wbGasu
 fxImsbBg6TJgd9yIFNA==
X-Proofpoint-GUID: PSKbzI9c73DpuZ2JXyVK0UCqs7KpyebH
X-Proofpoint-ORIG-GUID: PSKbzI9c73DpuZ2JXyVK0UCqs7KpyebH
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aa99902 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=oleLBB3xA4KM-oybjuwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v1.

 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7773b7af349b..b4db20b80c44 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -106,6 +106,7 @@ struct ad4134_state {
 	 */
 	struct mutex lock;
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

