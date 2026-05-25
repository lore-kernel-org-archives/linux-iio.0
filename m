Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3C3F166E;
	Mon, 25 May 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727283; cv=none; b=LiPE4f+Xg4i9SJGoUh/fTm6jhEx4VDpnFw1pXcmPGYejE26u+O4Eb2WvW92PZMH9ZF8QTe9j0l33Y/pBX7cm9AxPdneBtNuR1VmTpI/CJbpC7ws36xuUWQzLzYeqgG7LtO6Z3G3OQtsJc3G0NJoo/wY8E/eGxnZMvgkF38IWEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727283; c=relaxed/simple;
	bh=N//smexeu78k7VZNjF9eKlSOg1vGTW525zJL46EXc6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u24mZI/U+D03q1fBHG7jluIvstbwJbXQizfgRx7qH7oP5y29nbyw9xlLK4+3kEjStYBC/NTj4JEqVDJ75CSASFn2yB72bT1XqCKfqhLUoKNRlYTOVw601DcqyNojbi0s+lo5spu3/WwkW2i4cAtoN9h/K5qAhGIcN8L0cMTCvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GvmFr1hM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GvmFr1hM"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PAkB673473357;
	Mon, 25 May 2026 12:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=udgKC
	8VDB9Z4eEpgdoi5mYURlLA8Sr56G9Xh5wsuDF8=; b=GvmFr1hMhuORn+w6rLvE8
	59wkeOgBsAOPQyqHzKGY1p1PAG0ody6GeQa1IptPhZKqE0GZ5pXC5SLzscxjoQFW
	pzNcE0KMBEPU8pFFEnBYLIiuB11UMxcCiWgjWXrDnon0+OMo4hQP+ovIk58yelPn
	ivAEJ3JJnE37EqjVSyDZxrylHg9/mGujfLv7mDNmDoZKrU3nI0q9zcANsY2BiWRg
	oU8zqOlueaXHLQCvcjFLmBRG5jNsT6kFUlgAc8jW/8Kiu9RTZ7Swv1iqRs7sXc1k
	X68b8TuxehdMQOGggUmjTpAe8F9yhxdB0cbwypuAQbaT9opFlzQBDmBuHujRvIsf
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ebwje53uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfHNm022268
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 25 May
 2026 12:41:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:17 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH0028845;
	Mon, 25 May 2026 12:41:07 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/9] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Mon, 25 May 2026 19:39:28 +0300
Message-ID: <20260525164013.118614-2-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-1-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfXx3s64c3LmOyL
 lrUjI4QEt4ViDhoaOh3I1mFNdc1zykiDoREqvKaFTYu/Xl9Fq1WxHGTyeZQA24wzD2QkzHdhpKj
 I8Jrh8DCy7+sZttirAFngId/zjJKWnFya04fE1tfFKAEqvigQs6zURqxScNV4w9cBV428HYG9Og
 FK6uMPK3969wLT8ru0uG8SKhhKCFt40eClUrTdQ7BmC/mNeDnwNM6A4AAsyXwwSmV/YEfHi17BR
 9gJ0rhVrROhNUKD9PlHdaQTBiYU7CJ3L+PygJTSudGhucCZyZRaa5VoEu3RyH0AfFSTggGUqvaG
 AKr4YTOTNKxl+Q72nK8D3Vosm4wfV9PzDIQIvGZsiHs2zO4pXx1nbCOTcwzqFfzx4r21Cvwv3G7
 CX+gy0VazPHtoyEdLOirYYWjtQ2QIIUhogRc2ZJexle6pbgGeX/yKY6btC91LmuX8BpZa+ktfwZ
 9XEBaHvtYmuGvzP9oyA==
X-Proofpoint-GUID: W4b3fOW9-56MJvBqmNUPcoOdWXbhQl4B
X-Proofpoint-ORIG-GUID: W4b3fOW9-56MJvBqmNUPcoOdWXbhQl4B
X-Authority-Analysis: v=2.4 cv=fKEJG5ae c=1 sm=1 tr=0 ts=6a147bae cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250168

When adi,number-of-wires is absent, n_wires is left at 0. The binding
documents a default of 2 wires, matching the hardware default. However
the current-rotate validation checks n_wires == 2 || n_wires == 3, so
with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
for a 2-wire RTD.

Initialize n_wires = 2 to match the binding default and ensure the
rotation check fires correctly when the property is absent.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- Moved to the front of the series

 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..1f835e326b93 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -741,7 +741,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.43.0

