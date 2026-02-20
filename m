Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422B34A3A5;
	Fri, 20 Feb 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593216; cv=none; b=FEXFzO3piYTkLKeQpfMlgNXKoRmsx0HJiHYiBgYzHOc5Kzxh5QkG2nU8mFUB9rQaCXb1JPRGsapom4QBB83YIBeWFqSiIuRh2ie9sm2D0RPRAAXOOjZqINOSMzJBIRdeXriPkkiO2wxbfC+jUQm1aDV3QA/6XdixpxjjUo8eKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593216; c=relaxed/simple;
	bh=j0xWNF4QuGkz4EMB56wwLbUkQRdsAeGbI9ybj/DkxL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiPnUSC+2C+CJphEXkY3NxvHGbsIIJkTM3vu50I7QBWvl3IZy6RWlSBgp6pkz+ViAtv7oBg8hxzKdbj3EoZ7Z5vabptcrpJv2XYRXyi4Tp3rzuAfMHviI/0Z4yArIsD/5P9DDKCLFIMyvVAw+Yf4t++drxZ8nqdvu3ncmYxONbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=W3bSc1tA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="W3bSc1tA"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87FRS631909;
	Fri, 20 Feb 2026 08:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pdhUq
	drGdZlRhafi8KemCaiqOW8/LF6dZRoWJGJGU24=; b=W3bSc1tAJ9vTXXcfTxA/x
	W+/mXEcxnwhkm8RZ3bgmhwwPiMrR3FnTyBcX04dZtxyUHX+l720y4YXH9VyIpihT
	SffvDauzAZfGP+xAhk73qPU93a7Di5dMqrZmy/9+Ty377mFtqZDGFc61st6WzmFF
	Zr1Yz7x2+zhspxWjRD2EeNi4CH7HDTbcrgRC6Wjjo84Bvjva59mH+PrxJA/KhaLC
	RX/y9Fd63AL2uuWD65NQ3KeJmRE7JRDvnHBiyWv19L3DquG5KyDzVC/hXzynoMIq
	tPTE8xDMJQVOfby0mC7UTdXMi0/YxUNPY5InCGpu6awM8jJZ8rKILOy+jAKRA1yt
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6fa77m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDDKsH064766
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:13:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:20 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHX009613;
	Fri, 20 Feb 2026 08:13:14 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] iio: dac: ad7293: use dev_err_probe in probe path
Date: Fri, 20 Feb 2026 15:11:44 +0200
Message-ID: <20260220131151.74329-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220131151.74329-1-antoniu.miclaus@analog.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rtIC7A5adKF0bGcl2Qci5WYgyVWEo0Jp
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=69985df1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=x5IjUgJfq7T6UiCw_XoA:9
X-Proofpoint-GUID: rtIC7A5adKF0bGcl2Qci5WYgyVWEo0Jp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfX/770e2Akj992
 6xfCjILzgayv0JS0H9QkgTCNixUqR5eiCNtEJZDXzD874KU+DGfIQ8X/aRa1CSTiZDbatJXwW8G
 7FG2DGzC5Ky7fwrrTm3+fxx4QtBeptInm/M3hLm/9dYtVuihqNyQf9Qx9BeXP3cCAxeHc+mCEh5
 NqLD7MWyharOs+jvbOhCS2wS3/6uwl2l+8/r6NPIu/doz0T8IC9FpYoGjSKNpGJYnXXOlZDw2WL
 RgqFfifO9/FTJM+GFT2KPEVRHf7k7S9XbaYxy/ow4O9utzidB7VEc1ug6v1zPx6U+FVp4QqYr+a
 mWCTf44sUkxaKHGDn3shdRhYUCjSy8fwWXH/rfVgXKm+BEdrQIubpJ+RlKtznTGUI8KIVVENwut
 8GIUq/atoPHUPihivLIhK/yQYzLrRrWxI50/W1Ga3rqh6WCqkE1GTM4/BKjzcGeSEYeuoC3ri+/
 kI8LYTtJu1axgqqn7rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200115

Replace dev_err() + return with dev_err_probe() in ad7293_init(),
which is called during probe. This simplifies error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad7293.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index c3797e40cdd9..acee565d5bb7 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -821,10 +821,9 @@ static int ad7293_init(struct ad7293_state *st)
 	if (ret)
 		return ret;
 
-	if (chip_id != AD7293_CHIP_ID) {
-		dev_err(&spi->dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != AD7293_CHIP_ID)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Invalid Chip ID.\n");
 
 	if (!st->vrefin_en)
 		return __ad7293_spi_update_bits(st, AD7293_REG_GENERAL,
-- 
2.43.0

