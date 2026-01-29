Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464E34B183;
	Thu, 29 Jan 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707531; cv=none; b=cHmIqu6eCv4CwCqCncAxa6o3xk7HeIkSiHvBcJMQ5dDtuZJijR9MLAD9x8NWazNEcbJ71az922rLTcF870H3J9kMTbKP06P1GIF6EuwpGjzXfVsEecSaf7fay9eIP4uhUVxdRdaZGMUHujSvSC2t5/H10xzLlsA6YKs15tcve08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707531; c=relaxed/simple;
	bh=Xd4/Vbvw+DemSs498Rv7TkiehUN2T4vuTZAQkgk8/00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqVu4ed7EcG0kTFiae7SiWVhAAdtrNib7GXcYLPE2uCnaeBgE3xKFK9H2XHw5QYUSu50In6kqLX8HFHGN3Az52N2rMhZfAKkwJoQYKWamItTRpfMYQY1k1qmxkx5ZhEApu/3plZrlx+S0XtNz6lhQpsM7DZuGHLWk+rIxTPevKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IDWTbXRI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IDWTbXRI"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TFEl2p2649162;
	Thu, 29 Jan 2026 12:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0H2iE
	1hy6X/cSEgcOBely9+xLaipfJoG/oktjmJuHjg=; b=IDWTbXRIGtMxcBYSKabrP
	61vLtpAX1zuZ4LqT6FnoKsCUvGNYU5kMhJTUyZo+HrAEPXui9ytEM8zTUW7nfxNd
	qJ8RU+kyi68C5W+MFdudOJAipiR1dfMvtQrVxQImk1dFNgpgSN+cKl/WTFqgifrj
	w8VceIgNAjuJQo9Dz16/l9kkGmq17+Zhl5zpcdGsa5ixqUvqPNfdIctD1ufPo27V
	YTYrhkQkmUdrGDLjnOFWQp7seha+MBtsAP4b4CxWxM0rUf7+3xenC65vnqAOocvZ
	WxBIzFjD+aYP2OO+fMsnf5cW7u2d5U0/7/peQVm5rzId4CZn0DEaBRUEy0DEP6id
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04891vxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:25:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THPCMJ055972
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:25:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:25:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:25:11 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rq008516;
	Thu, 29 Jan 2026 12:25:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Fabio Estevam <festevam@denx.de>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: max1363: remove unused requestedmask field
Date: Thu, 29 Jan 2026 19:22:02 +0200
Message-ID: <20260129172340.34216-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfXzN0zFJkZq2oK
 9jidjHkpVmeRiTEf56XrvLN8Okl28gkvoRuvBw20x6jYQcjaatkBiWJ9Rxrn0ynufCfVPCjtqIF
 1zpWZD4K6URUvnGAc8aQ2s2+NpXXfO17BteQ7NsaRLeuVkfdo5aYh0N071oJMg8XpAT0a5uNJjg
 LXMseH/nSYTKlbd8tXcEDKIlQKfCdDBTqSotnlx3U82G7zPkGQKbVmR0r1BtuXZcN/HKSZNNovO
 zMrdejEo4jfykVvfueMTOUDg8Kk8YSiUYjra/KyZy0bh9HI9BfksYKxf0HS4t7cySJDiomoY141
 o63EziKEO3uvrPdDNE8eI3h1I99jk26qIh6df3cN4WhlKCuv8uhG7QX2KjdUPiHU+n7Tt1trmwt
 nCBX+4+SsnC4RjB5sgIhy92C+XqACTK6FogsBbUIk39knQGxOSS3vthKt/czp/ooE0aXTLSpqtM
 F9+NeAyn6rQFJtwqgiA==
X-Proofpoint-GUID: fQWFkRElgqAWqgDr-MjSWu2wxR6ChsNL
X-Proofpoint-ORIG-GUID: fQWFkRElgqAWqgDr-MjSWu2wxR6ChsNL
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b97f9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=t8eYkzJG07i2O4O3lM8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused requestedmask field from max1363_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/max1363.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9dd547e62b6c..5e0666343fcb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -149,7 +149,6 @@ struct max1363_chip_info {
  * @configbyte:		cache of current device config byte
  * @chip_info:		chip model specific constants, available modes, etc.
  * @current_mode:	the scan mode of this chip
- * @requestedmask:	a valid requested set of channels
  * @lock:		lock to ensure state is consistent
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
@@ -169,7 +168,6 @@ struct max1363_state {
 	u8				configbyte;
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
-	u32				requestedmask;
 	struct mutex			lock;
 
 	/* Using monitor modes and buffer at the same time is
-- 
2.43.0

