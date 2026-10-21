Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547871;
	b=Fh3FCvhEk2bZzWevN86cHGaB9jU13lXl2AGxXSTBaUfdmVngxBxaVqzQS+9bI4pD74En
	 OIqVK+HPKx9Ye2iYQrT74ZpaueNRlBreK5e7ZFHw+Oxr2a+/cBiwroTiLqLjS6BjAKXKf
	 NGSztXAkBkZ5kKnPZfB2FRdDkyV8nPR+NOUMCPR1C8jOYyw/gFMq4LpSv/KYGx7cIkmik
	 FUa7R9GxDUri004aTfcjYWl/Fur5nIap/qOEmSqUwNw7bVtrZiIMImPfZgL4MNJUd0DTs
	 Twkjp/NgvAQwg5hTVA1LLygCa4Y/i0rDO0naIarBgUCwPuTSIMi/NIhbHntwuJg8q4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547871;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VpPBjtm/icfsEzzlnwCY4fFjIPjMlyR8wx6YdnnPlUw=;
	b=qKK3aQLqT+1ZX5Q2L5DxENC8UtCYkukxcysKPAHsO4j6ZFgwx8I3yD/Za+TR0mCrvAu4
	 XlBZ1dIYKsj32kfELPBbYs8ym+Z88TkyLHPuF26mVAk2RLodtKqLTId/RiCepsji+6mS6
	 a/bxtmcgcEy61DhByxOa8Bq65z4/se6OIaT/2vFe38dteIPqbXd/NGLo/HzeW9WxNOret
	 3qQBctZllpvyi/sFjoi2bVjNm9lS0GfnT9PL5xqc0zzAwuyq9ta5VtYEZ971vDd/gEFdR
	 /X2rYZL4NlJ4D5b6CdisFc7go95BDQgSzmR+eJj2l3x6kIuEId/RcBThtq/BZKzV9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=k9ao5zA6;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FG5IDPEb;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B27606A31A;
	Wed, 21 Oct 2026 01:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=k9ao5zA6;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FG5IDPEb
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L1CTrc2057951;
	Tue, 20 Oct 2026 21:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VpPBjtm/icfsEzzlnwCY4fFjIPjMlyR8wx6YdnnPlUw=; b=k9ao5zA
	6kr5Gqj/paH1mdcRzd/VaAfs6UBskfIO8xX3t/n63Cs63lwFBzj2PWcNfN7Jooqx
	CfQiOgo2fsTunczEW5h9viEE/vbOyL5iFT/Ky4LwhabZSdkSj8SVFWpVQtp2SlbF
	yIo2evl0PMPP+khsH4UWwgTu9+XWqzRw7W2WWfEVKHn42X+TrjQ2pdZlpumAWEn8
	0h3HGeMWvx3qt1XLbBIY7v9PQ+IRhUZklVVgXZ23wK1OFPiic2v0ncrRDDQAoKBN
	1FFpZo98IB463T3oon4/VkQK3kwh48MkDgn87gOp0TNC7cx72pIwQCGWetOB35gz
	/DA/5yhriEEBibA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VpPBj
	tm/icfsEzzlnwCY4fFjIPjMlyR8wx6YdnnPlUw=; b=FG5IDPEbXbvNvLI1nnQEB
	KV9fi+hLzsAtS5lAxKSKb32WkM7XGGNFMZqQeNH7eZ7b2Y1HrRBBQd8f6eKji2qi
	Tw74mMDyUgJY3+Em/0lW8De4Rcj2jYvIQLJyd4ZdiKsY6PX7TLmTLet5y6vqLVbS
	Q/DdI3Sso5jWr3Txc/jkmqG2duN4JB04cDYaxqp0xAZmheTtPpcu94fw4fXiSJiG
	YHhfqH03kA9cQMT+g0eU7vRO5592xopUM3NCk9SdI/wxQXAr52JtWBqj4LzxUFNV
	7z4iuDg00Tq/6/VRbHKkb0RbWhzBn2ElI76oRGRm7YYpoaHMJcAR9IYOfxYYvZv0
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hedgy21d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:57:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1vkCh062338
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:57:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:57:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:57:46 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1vXm5029075;
	Tue, 20 Oct 2026 21:57:36 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 4/9] spi: restrict CS logical values to a contiguous sequence
Date: Tue, 20 Oct 2026 22:57:28 -0300
Message-ID: <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EvBHPicA c=1 sm=1 tr=0 ts=6ad81c1b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=MWop9XgMyXJarCy_BgkA:9
X-Proofpoint-GUID: ekExe8gjanhPuDoNM4blT9VPN_4jFa1A
X-Proofpoint-ORIG-GUID: ekExe8gjanhPuDoNM4blT9VPN_4jFa1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX/5TWFl8ivJC/
 o3RoXgcDWN4Qe3J49TUC1VI0LKYWomVJlk85PyGES0S9FnodLyQomgQD5CdpV6ZYcD6l7dTAtOh
 BGDP33B+at+wHya/oo/medZQcFc4VKWUo/P1oObQvez8d8bsi1n2vLuP6zUMhCoL75kAVmaUWHX
 FOxRMU0Gc0TYNg6Lp8J4gf1Q5szjLFlVTHTXJ4j6w2f2uVjLQCnl+9MPlR8l9qTUzTlqqkunuhJ
 wvx5F98v9YxQ71x1/rSCVxcciaoUbjqJYiCwbxEdNJNiQXrGesOF7mPucYbEKeMf+yeW3a3bHQ2
 NcfsrlMjOarjKX6ixliEasnyCStXUsIjIVM+ErQuiX7+dw92rYgibzffvVJvfajkPY7s6C2a+b8
 pWz5xbMnscPNnPF1NUFZhX6ZJyfKUN0JIWNGDXDKIfK4MDwqpKiIcFOSynamwZt/M/c6012WO+e
 6cf61VJSFSR5q5rXTEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXzbJBwJVpnZR9
 QNTOzMM2ICHLBgtn9YBwG+SxZy20ThV5DAy8wu0UxcCklt3pY3ItX7rQIFeUH3Y628q2Pn41V/k
 OHrwVawxlavqw8/UIcimIzAw7AtDR2iDzX7wKufEkv+lOpWIifTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210007

When a device uses more than one chip select, require the logical CS
numbers to be consecutive (for example 2, 3, 4). If they aren't,
__spi_add_device() now fails with -EINVAL and logs which CS breaks
the sequence.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* New patch, suggested by Andy. I assume this might have impacts on
  existing users. Should we make something else to complement this?
---
 drivers/spi/spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7a0406ec200e..2b2eeaa4c15d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -902,6 +902,16 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 	for (idx = spi->num_chipselect; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
 		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
 
+	/* Restrict CS logical values to a contiguous sequence */
+	for (idx = 1; idx < spi->num_chipselect; idx++) {
+		if (spi_get_chipselect(spi, idx) != spi_get_chipselect(spi, idx - 1) + 1) {
+			dev_err(dev, "cs%d is not consecutive with cs%d\n",
+				spi_get_chipselect(spi, idx),
+				spi_get_chipselect(spi, idx - 1));
+			return -EINVAL;
+		}
+	}
+
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-- 
2.34.1

