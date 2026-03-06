Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F931813A;
	Fri,  6 Mar 2026 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792756; cv=none; b=mTC62UVMu9XqBpec0BC93smfY2Dfte+Wl/+H2ZCWgnQIqiG7mI5LcLswMaPIXM4NnzbIe5NFfFkbEWFROmCNawG1x1j6R1+Y5n9zT0N2FOCK9+wZhYcALnH90IwvoQpaG2FnSF67sBwFcDUUUdbN4IS2Ig6VVQuQzDpeoIVB4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792756; c=relaxed/simple;
	bh=BEDENE93mr/O/VlY4Fg81J2lwWMSVmdiHr5oDfS62FY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9iULCkQnB8fz2yj1iDFujRccUgIVtJa1gq7cLl6WoqaEbArlBctTKvjGzMdkTc7LlEikrVV/Kuyl5PUnHmMRsi/W3ThyMV7rJ8ZmoDomg//IgGaW++hHmIFZDDnEL9oHFVw/xjHab7izU+CPwJshskhp6a6yTneh7akwQoyZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E/8IaSUs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E/8IaSUs"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267Xxwn3363772;
	Fri, 6 Mar 2026 05:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7p0fV
	yXk8LTSEupQnzHnoAo9i+YCR5ECDHM7vi9lyXM=; b=E/8IaSUsyw6ZMA2/WjHLD
	K+A/ywJRxL0u7N+pBJw0T2+qrV3rW9qG90N5QX5N0VYaSPljOUaN7+xvsNPoq8mv
	s56r9uj7pHeDseHgghJMPS8TUtIM2ShfcFRKevvSNDBc1Hp1YcYeFR3XeoGU1QQl
	0ghxUt9Bp9dyGW6kmneXLWIE5ufjoCpoGpFUucxEfpEViFTKHv5qBymzt2/fz34D
	4rYu1q7Lmc932RbPknsMkdRwE1bqTXXLeMzV0Hj5EZKHYB41iMXuKaeH4x4Y804P
	ASsoDy4L813mNMmHfXXdVmjfQvAvBwWsCm19cnpXMmSQdW/rIBOHWAKL8hism121
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpdyx2pwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:25:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626APebl007793
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 05:25:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Mar
 2026 05:25:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 05:25:39 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626APG2W003684;
	Fri, 6 Mar 2026 05:25:36 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 4/4] iio: frequency: ad9523: use dev_err_probe
Date: Fri, 6 Mar 2026 12:24:48 +0200
Message-ID: <20260306102504.42395-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306102504.42395-1-antoniu.miclaus@analog.com>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Mc9hep/f c=1 sm=1 tr=0 ts=69aaaba5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=sjRy_tYu0K-qpKjFe64A:9
X-Proofpoint-ORIG-GUID: -GwOLAorVbY5JGoGnJpNVW6VyCgGbSFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfXxUHEhpNvuosM
 3iVwefw9nJ/knNDhFpE0gZgmtiuMRUXbLErxrCwUdaEvLVouIlgkGY8y3clO4lPjhMyXDG7dJIO
 mC5w6/zjwiFjwYvgsg0kRz3+YO2Sred2J9G1M/0JCkOQ9rtBNqq8pSEHITBPlQFn9XpL+tNL/n3
 AtT4i/ZVWiewjUWcPE5y/OuUmui4h7EcllB48cAFbMgES1tZwvM4VGgH4y9aXAgVVxDfMkKq14l
 1CyWu1Oq1V985squhOLuOPx0l1adrQd0FAiZbipWNUQ5ALVwruQL7VbcyPNapuAok72tm3YyNst
 lBi4txQ8yghI1fpiz/AqNJ2siTPr/Hxa4SrquWYRo5BxBt/e5Yog/TLTxB86nCc0cjL4TprL2vR
 5anBGAGcDclhu7gJ3UqcjftJ23a+CmM1ydwWtYiD7PhGHaaeuZz3/Ieg/S2P3vH1Z0M8e294iLP
 8IgZcqFa9+7eLcLCqhg==
X-Proofpoint-GUID: -GwOLAorVbY5JGoGnJpNVW6VyCgGbSFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 6d15ec648280..f29a45837565 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -954,10 +954,8 @@ static int ad9523_probe(struct spi_device *spi)
 	struct ad9523_state *st;
 	int ret;
 
-	if (!pdata) {
-		dev_err(dev, "no platform data?\n");
-		return -EINVAL;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "no platform data?\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
-- 
2.43.0

