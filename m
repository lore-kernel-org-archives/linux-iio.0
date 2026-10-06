Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EC395AC0;
	Tue,  6 Oct 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310679; cv=none; b=urEaxfH9SAnKssnThbeEST9xQGAQac9b8Oj5phdhLiXYTMM/SSJcTKgG4+vD4u5ynGwK7JowBgr283T2WBKtqKpvbTHHHe7i1wM2IF2FgJz7lmv9huS91/kXfrFBGECaNjklopjSfjLh/8+7wR6fkaXyoP2IvGHjAfpTI4kSl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310679; c=relaxed/simple;
	bh=1f4b/GQUJmRcglKfmRSdkai/lbesXPzVQjuhRPAjQBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF7gvbSTcmhpJcg/M82Sev0kCMkskrQ+0jygAnb1KoasajDyDkZCKVHKafB4lZvcrgXHgyjooT5HtjWonRSMUq/kNZ7/g1CQ0STYMwB0ojTqea1m45ZrV3o5QqvzwfUFDmI3mUVFJVWhhJXIKUgOXUldG2jNAROUhcDTzpeCnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=E7hVPivq; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L62SAsx+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="E7hVPivq";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L62SAsx+"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Hhc0h2853161;
	Tue, 6 Oct 2026 14:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=TesKnqx5989VJvr2Q/R5vOWS/BHRYeFNz+NTe2Pn15M=; b=E7hVPiv
	qLGov5vRul38VtkzwS1CK0qsRJXu3CWpgpQSU/WS8mL9V0yEQWrUSmVknmAMVdsh
	SQf/wgyg9+XwMXmG6LfpZdK/4y/1sCMNRk8hmdolz6HM5O3y76d1czeGBrQ8CLo1
	ofATLxgP+ZXbH6Sf47TLpKHaVXGg2A9LEyR6K+O2IcwBjSK/7ZqlR6ZwV1Re2b4K
	hHBapyq/ri+vSf+Cxz+mnhcOtfXjhg79w5CzKgwG7vkCjdXM07Pu6oaQT1091Sv/
	OmaaGUJIr2NaEkiabVbJiFmdItthm41VsiQUXgQBgbXZHIDCzkeZ6cxcRTzNwRjG
	56EyQqEKhtqdQ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TesKn
	qx5989VJvr2Q/R5vOWS/BHRYeFNz+NTe2Pn15M=; b=L62SAsx+8zFUwCXTxYhbj
	uJ3T9bFlF/k+1ozBq1lUNLPpsOuECFOPvgcQwIzqNRL2i69XwvUei0P40v4VGUsj
	TyRsd99cXe6vwFmChu/YEf+dOQy9BW5Zs380p/eFhfXVaNmComu+rALqRFWSQsLm
	XCpJ7b0PCQw0J0iJW3GsaZ8VZiM/c0BdRJOQL5DoSH681eIdeDarOzBux2Hi3/SS
	2PXjJRPVMZaJEwtOoREQsjm1PI1Iy7fLSIL1rkjZJzsfX8Si7Xb4Vk4I9pKetfSR
	VLIWRiU8WESg9TlmX5MsqHEqUbrO2pIBywKQZUIOem8Er93wevV79lz5Ie6iU0P1
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4j2extya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:17:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 696IHb05021642
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:17:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:17:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:17:37 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IHObK001003;
	Tue, 6 Oct 2026 14:17:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 05/13] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Tue, 6 Oct 2026 15:17:19 -0300
Message-ID: <e46fd2f9b11ff2b690483bc2ea6489b6d145c773.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7bINg5Bacj1L4TPyItcCMKfVZyu5O-5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX7t6BuoDlkoi7
 pTiVfRjoShHnpK0FPD9u/gRaEjns+d3Y/Wya4w48jjLj1xaXOl3wq9y0sTzhsdk03FFWbrQebRC
 KUIEtHi4WMoR0PAfOw9tfg6z287/l0QNgkX43aaX2A4Hl1oHK48utS4OdRw/LbqsQYHMtOZWLQO
 mtQHcEBkMjsFPmpux3xFgOakamgraM1TFXOs2a0WfMgJ8qv759XHTAGX8bTqu8viQUVf8dzVGpa
 9RZSxlSAvdp5X+A6wKoBgXnyVJobEGf2CWRBIXBLpNljr7e/fRGCNGWybXrGoSfKcXgVggTjIl6
 pEE6zXr7wHsqn0RKJMbp8yb+L+fKjXTQYipuw/1fiU+HKoLSIsrF/wBuJlY2hMOSEv4r2Xouxrh
 oTNcoG5JF9hhuIkDdL4Y4ScB2/eC4cnqi5g8qc4lZJEf7/MlZINZGJrKuuEHdxWbySam1yvxmws
 ym2Fwo1M4fGvH5pOUXw==
X-Authority-Analysis: v=2.4 cv=JvtkP84C c=1 sm=1 tr=0 ts=6ac53b43 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=oleLBB3xA4KM-oybjuwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXxC6cmrSYI/Lt
 uDzJcLL/2mF+3Uh+6ALPP/Qd1HpeAN90F0m9p5wI8S2qf0e5yanALkhuU8ODpYZsgi9ZqQfbx1m
 eJu3dNFBfhT3K0dyHYlheFnrdHgME22ZGVCKExxW4CbQetMzCR3S
X-Proofpoint-GUID: 7bINg5Bacj1L4TPyItcCMKfVZyu5O-5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060072

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index a0113fff4b71..85fa16321d74 100644
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

