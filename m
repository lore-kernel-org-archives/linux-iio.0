Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3535F8A5;
	Mon,  2 Feb 2026 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031793; cv=none; b=r2e8tS/3jCxbm+tOIAwF307BAlvjr8EP/WMFdEYQI8oIgXEStDb2UxxfhjPJcNgzFlOYqUAvCKaZEoERfmXz5MAmcM8iHodSHUgNMdb51DX4oqoIaWxDOtm4jf2mK5xSn6xSSUhCI6hpGJprXzcdMysfJjcxtzQXDduLGPp+ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031793; c=relaxed/simple;
	bh=e32mG9lTNVxxP64B9Z6kQO1yjl+PTuE5GZsYTWijVJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvYyPbwnjUTEoRaFx7phoNfSfKieDPURYchb4ti2oGB8b6hE8PBnZqiHB5cbXjItpSMzqOTBaUN86pErd5N4JlbkxPQW3QTefV7ktmpUhZ3gvBvOMKKN7trzA5L8jYxCGzi0lXq5eznF1+W7vSg7u5IkXt8BUp3zuWs14KO0tgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l4D+93iy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l4D+93iy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B1Naw2221475;
	Mon, 2 Feb 2026 06:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Or1f6
	yVUEqvUPvzmjcHCisz5+ifJVO/+m3OG0IuAJOw=; b=l4D+93iyqJpvMvlfLzlmR
	nvrxkrzzchLZj+k7hBfVNA6BT3s3IUFro5cYnMypXrAML5MPAFgmCXrc4+PxUVNQ
	hbCR44pXYXVDS8MAQwejdfMJXysmMa9EyK4VvGXWqYZySBntevRMs3Seyk4HFaZ0
	ZjrfkAyJRxq7XnuH6ZQPB4k2NB2cdRCAsGwv23kCpuAnBcv06gNjaY0VZ/xCX/O5
	ZJqpIQCRI5SXt9LEGUKikhCIUm9uhGL+jRWMh2PHimlSb86L332czvEM4F/e1XEn
	F7rGFi1TCcR4b0qzbSM6dnr2RmOEB7vHEFSfVIhda4FseG2/ASAY3DF0IuKleR5L
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:29:28 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BTRGD050145
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:29:27 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:29:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:29:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:29:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4C004681;
	Mon, 2 Feb 2026 06:29:17 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Fabio Estevam <festevam@denx.de>,
        "Matti
 Vaittinen" <mazziesaccount@gmail.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov
	<ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/13] iio: adc: ad9467: remove unused output_mode field
Date: Mon, 2 Feb 2026 13:25:54 +0200
Message-ID: <4303fac3a1cdbe7e94c7c8c5f8a4601cb2d3526a.1770030812.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770030812.git.antoniu.miclaus@analog.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808a98 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: KmpqOYhHdNqr_mKU90oHGXoQ7hIAl7X2
X-Proofpoint-ORIG-GUID: KmpqOYhHdNqr_mKU90oHGXoQ7hIAl7X2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX450igCHsaCN2
 Al4kcrbXpv/W+uxC/ZgwhbQ1LyiFRT0aYHIr27931RfarpSj2/itUWwoRE8rLSUH965VA+3egkN
 8OrAI06dei7oRu5TkkJy8mVzMpl7bOSvNHfdxOaIaYjkHomkKwxsorcAEWb/sWt6488vY3Zw1yT
 +mAWKWPnkH+l5GbLIUWSUQSo7Ri5zcT6R9WYzsys1LtF7kaoZ7BLrewP1KdhkE7MUW9p0aEZG88
 HmaXdJRtAaeQNYO3FwUbaH0gm5Hf8/vs7i/PbcDS1MwV4/zUJwUzPu6t/H3li96EQ+UbuA7bgjA
 hsqYmWjVLpzRBzkuA+zkO1nUgjjIt7/xf2U/ry/iDpfhqtSsUduawPM3ftzTpEnpWcTk5k2QTeT
 Ok+bDqzoK8/21ChIjVDJTjIE5de4OAadnsObzgNGSQFwF5DPdVb8s9CYf9tW7mSfpXm21uYGsZQ
 a2gTJYQOr0jswRUSjiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused output_mode field from ad9467_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad9467.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 9cfe66425d4e..df0c05e7c60f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -176,7 +176,6 @@ struct ad9467_state {
 	struct clk *clk;
 	/* used for debugfs */
 	struct ad9467_chan_test_mode *chan_test;
-	unsigned int output_mode;
 	unsigned int (*scales)[2];
 	/*
 	 * Times 2 because we may also invert the signal polarity and run the
-- 
2.43.0

