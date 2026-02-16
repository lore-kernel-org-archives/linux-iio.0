Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77757314B61;
	Mon, 16 Feb 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254044; cv=none; b=E/Iz0PHWBEweGJeiiP3cJhgaq9Lr/l6wAZ7J4nQaaur+4vINwJjfml5Fxcg98ySAeYNSGvAeylZaxep39UylnyujAILARFaTEmNAF8bYgONTbXbyv3JAI3aag7sXS5bxHZlp4n/8676Jo3F6dOSvV9zwOjQiEGv6gEwQ/AktTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254044; c=relaxed/simple;
	bh=ajAVqf0lGd0nqFz4YpPhX/+64fAlMYYUEdFj6mgOoKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQo150LWVIqjnfWGG+15qaJgcUyluLAfm0Nv7oqXN0FvLOfalYRcW2mO/f7+8DcymGwZ+CdkaGL2YvoP55UcomO07l3p2U87zpfXlQgr3UAwvCk/hwsrRm1rQPoWzYkTyeS1qFb+zZt2U0juoNI+CP+ef4g7hyxUSQ02xvx5cPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T/mW4lEW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T/mW4lEW"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G9fWgF3758125;
	Mon, 16 Feb 2026 10:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A4lYl
	diTSOtT2/pl5wB3HEgs/EW82CFc0w7Bzp2cRsQ=; b=T/mW4lEW31J3xAuqvOJXf
	huqI7I78VsTTI64qiS+o4GAkpqHiLDaDCX0jmfozH1naJGHIlRxlcGRN/9CsvrB1
	thr7+dqOxAqGFxNy8fDubScwOzcyBFLjPDmSahxqA2ou+akbr9teRCTt/aN8FRVG
	tWNZhFmz6ChlD7e6tZop5htPpqJMj0wdU8d1w3t+6nox4/GhAgjorBXNFjpKqbqn
	g/aHzHeB0bWaUKUM34mlMeufIMoPN2FYW/5z31UOO2q7ujuYcYyzIP5TufV3on2q
	vJZUVzRI86ICVmuC3mJicVgPgwC08OK1lBxx2nX5pzr0tO8kfI435z/iQz7f1ZN5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4fb4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:00:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GF0aPb019958
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:00:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:00:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:00:36 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GF0NdN016843;
	Mon, 16 Feb 2026 10:00:25 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v9 4/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Mon, 16 Feb 2026 12:00:22 -0300
Message-ID: <5f62866d5c8d4a0ea80e24ba009a2d35b9cf902d.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfXwDHpEv9JWqPM
 LN8Tj5PGfy5GXm/imRYPk6aE3PN0JnkPmwfxQzGFQETdh1nyXISIP/IHzVG/0SiCPrJ5gP7L4/o
 Y8mfE4F/9BleNwm1/TGWEbR1Y5bHRd5Fx6TcvYph09aI4WwK7LkJIOd0nqzYwuSuh2XhBUmQdCi
 C5/61DbpojDYlUogBk66atx50FKd5inMxoPVoh9LJ5qxOhalrBvjqyVc3qcvkdde4KH0jlQ0UvW
 4XMpF7n6h7Bb1B5IIQB5R7KlH/GKpfOf1OP1RxE6F18Zeq3UvUzOH8rTtHWQ9xcs81/rfJ9XvTT
 7OiuzoV/hejIpqnud0pCbTPJSjqoBh67VwRfK0i5rcpVlIpCtbrJ9BPbElHbG4IoDc75R6f8nGE
 RVhaTXc7xUGx31vm084i4k+f3Un+6OvbFNg8yjEwtNRb3KRgfAp4cuyyhUYazwta3gXis5ifrP8
 lTfS+V3vsLbvYF55MdQ==
X-Proofpoint-ORIG-GUID: ZsO22YvRhMZ-RfDRoabJwSFYChNI3aXS
X-Proofpoint-GUID: ZsO22YvRhMZ-RfDRoabJwSFYChNI3aXS
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=69933115 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=HwBGVG7bte8kWS4IyKsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160128

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v9.

 drivers/iio/adc/ad4030.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 68446db9bef1..def3e1d01ceb 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -232,10 +232,16 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+/*
+ * AD4030 can average over 2^N samples, where N = 1, 2, 3, ..., 16.
+ * We use N = 0 to mean no sample averaging.
+ */
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),					/* No sampling average */
+	BIT(1), BIT(2), BIT(3), BIT(4),
+	BIT(5), BIT(6), BIT(7), BIT(8),
+	BIT(9), BIT(10), BIT(11), BIT(12),
+	BIT(13), BIT(14), BIT(15), BIT(16),
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.39.2

