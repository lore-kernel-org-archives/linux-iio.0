Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A22DC792;
	Tue,  6 Oct 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310643; cv=none; b=oXspSbEzWPjWfHYqk+IXq4cqdJ71/TDPovptodsnS3hj4wL7JYOnVhWLKLsLgA0TxnHqeXqtaxUdhBigQb4y08Doo7768NpXP+J5DHg5PPf6ue3AzlwwKnPzX9Dnl4UTWECZUG/Tre4IfRrNMmMWS1QaUqmYOmjHpblp7mG3oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310643; c=relaxed/simple;
	bh=e13bO8TgLcOyP6MJ8XKNKKTwZvPtqMvtEydec8nPThQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf0avgU5vPaFRcNnEralJ0TxTx77vWFchHFU1ftR3KOHSbdFlqHfJg15hFlEJ78SWtrCJUchZCoCODcX+w5A+D2qVHBNGBy+HcCBn1dm5PwYQqFPWzxyJdDz86D3f6GKJgNLz+cGqLev8mpVkInUEvDwY0lA9VXDrRsucJRWfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=hQIV9DXh; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xoRaZr7e; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="hQIV9DXh";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xoRaZr7e"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhGQe2187655;
	Tue, 6 Oct 2026 14:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=pdU8u9MXRDSCsEWeqcozFqWCpg0QoSDNMet45Tqkvdw=; b=hQIV9DX
	h9BJ6NTujn9izjaRbtK//EFGMxMC28IeTwvVz5bewat4eEuZcE7N39MQQO1t7b5m
	5rwN5pxrfk8SXB2OIQpJa3n4JPWS6bDZPNyPgewen/HKAeTfdSc4Q54HCeWKUQi3
	4Z6f+akGj161bqoNvGc4aBD3BRPdLzg20kXvrN/Yl7AZSLFv25OOOf3fFGej826d
	PdKR+zvZyWgoXACceVb5ZFOXqRxJnPWom7VkAY+lhEhsoRd+4jqr2J5a6/JCMQlo
	AvblQZuw+OR8xc1m13xfiIhH16LwSE/lzzFI4DquqNMv5zseKEiuqochLM/R+LPY
	9ljZ/c/fp0KyeBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pdU8u
	9MXRDSCsEWeqcozFqWCpg0QoSDNMet45Tqkvdw=; b=xoRaZr7e/f25FgcrFdtiv
	TE+tVvc7oemAUDhWiqWUnU5FgMBypBpJAqksxiiErtkkc9vZ6PEiPxgxHb4dvoqz
	792xF81YbqSOjikxA5L3g0pstn7PkH4iZcod8cZMMxr5AWP2xZp8BNbm/ZHO0jEs
	QPGbwRpcfuLTY3B0I/EdtlXtwze4xgbeI6lImdsvvhb3hDJM4cjoLQWpXiin69WD
	KSeZ+JceU5/H1f4gQbbtcLrqUBjPerBi75d1l/GqA50RzLksFT1qqDJQP+jVrQDG
	w7b3AjJy53QBnwT2FsueavVBa6EgvzZd61t2nw2S+oJ+M1nLEYzt7pLxocNQc5wl
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4en5fapf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:16:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IGheH009978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:16:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:16:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:16:43 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IGTOe000986;
	Tue, 6 Oct 2026 14:16:31 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>
Subject: [PATCH v4 02/13] iio: adc: ad4134: Sign extend sample data
Date: Tue, 6 Oct 2026 15:16:24 -0300
Message-ID: <8f22f48cd830338d801342a52fb454607e8b06c0.1791309733.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX/CNE6pR3HQdX
 l0nnRSLdj5uwQVsFpGSCakNJo5E5b3fu0VBG5eTY/kHxcGzYZ+GBMqGhmwFuVKt65ACjwnloG4p
 86YyXx1Jie7SKXsUVzWZfa7RKyp6s3GlsX/CMsB9s6nPRHljM2nF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX3loV8jp/xMe+
 AZgsfTu1K1hKH74YYOQUMRm/VcICfGePW82myGpX/+XAK0D/aBK612qWqEuqUM0r8jAp3WSiPKO
 AwWcII9YSykFuY43K/ndIGFCZ0SPvB7Mur6DH6yckr/i1+mLJwef14Qz4gK9OSIWMy44lcbA2IY
 KP00AzST523ZdlZS56U8Xj8V00AQrPPNzEmuKANoyUZ7c0wEIXA397t4P1Qe2vmIAW1/pkHUlAN
 dY/jEKN/0HYmMx+S8LVPivXD7cf0hWzjvESlJXreG6HWMYcCfzIrzosaPumQawgsEP0yTLcZdVt
 mpx3D8LgDOm8M0yIkNF/7jmtpcd2/i0OhU1Fr5j8vsCFpFl9Ruy/btQ0be/5u9QPwcoJBhfXv3D
 1qwaxrJMJFujrf+ALcCwAiF65RsIU54PURx5bzJFjEPCCpB81ufMJjPM2Y1NaajtyJiTXhKRxc8
 q/H9xr5XZbiae89lbjg==
X-Proofpoint-GUID: 1Yo8T1HH9XcUbRPrX8xgLYhsTrg6HqlM
X-Authority-Analysis: v=2.4 cv=DdCCOftW c=1 sm=1 tr=0 ts=6ac53b0c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=TOduCJ2NwqVHWOW4apYA:9
X-Proofpoint-ORIG-GUID: 1Yo8T1HH9XcUbRPrX8xgLYhsTrg6HqlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

Sign extend ADC sample data for correct delivery of negative ADC input
difference.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v4.

 drivers/iio/adc/ad4134.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index e53c10b9a44a..6fdeb27d7a42 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -172,6 +172,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 			    unsigned int *val)
 {
 	unsigned int i;
+	u32 sample;
 	int ret;
 
 	/*
@@ -196,8 +197,9 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		 * Clock out data from all channels to avoid that.
 		 */
 		if (i == AD4134_VREG_CH(reg))
-			*val = get_unaligned_be24(st->rx_buf);
+			sample = get_unaligned_be24(st->rx_buf);
 	}
+	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);
 
 	return 0;
 }
-- 
2.53.0

