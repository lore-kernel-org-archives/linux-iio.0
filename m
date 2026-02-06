Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E255426D0B;
	Fri,  6 Feb 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404522; cv=none; b=H6Pwrf0YDYVzSps3C6gQVcVkmkm/echOTfnG9Q/ejMTFYQy2j9e2dR3awqyG99yr0/zD5wH5HwhyNGNKMP+1XPy/jPQEWXkp+ZOre5FhO3RRJ77hmgl27U171EAD1NyBDUuhxbTlKRT+hyF01kYMkiFq0QBznPxCStjslCfSVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404522; c=relaxed/simple;
	bh=DHmWundTSxcWzwJxHA32hKXxHl7YYLhamWTRaVyqnfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7WgGDCOQ9llueGIw13WjRQhiEG9qxbtCpJhygcMLAndQkr/BEFjpK7yx05YC1BF/7oHFc/6AhAvsy7xk6b6aSc2GQXRRlBPPXfdIWdcablGt/aHbZaBBXDm5xCvjDYxYoht8WrdBGZROvvT3u1qu+36ZPK2johb1whqRBAr8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S2+xTDul; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S2+xTDul"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLmng1708723;
	Fri, 6 Feb 2026 14:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3h4bm
	Xnr76A55wzBt3DWeNJu8vwb3IMAtasO5q91v+I=; b=S2+xTDulGlm7tx3DGpSgi
	aF5RM8ZXMO86TcPhkaPgnja6c80rWy04IffEEgO/dy/iqX4lndWHYF6XjRb9seQX
	fLRUGUdzoZu4HzWeZCY6XyniGMCWGTtR4EH9O4VpcMSdQDp0pIdVYD2qdd9vkrF/
	UiIR3ALHXr6fdfRM0/mjIY6vpkzz+EbncnxCOwS7BzsgBX9vk2/IzFdC2h4gTxxi
	FFos9OiXDJwJVVCxeGiPerMjk53z1a/TOOem4d6iauCuoNEhRLEKirvQtIqh4mSW
	Xy6WlYIXvyDm8WlBucs0wYxdcy3l1jeq3EevfHMQEJ7Gd/koK5auOR3QJufqsBdY
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4q2fex1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:01:56 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J1TUC012810
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:01:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 14:01:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:01:28 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J1ElQ009012;
	Fri, 6 Feb 2026 14:01:17 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v8 4/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Fri, 6 Feb 2026 16:01:14 -0300
Message-ID: <416b1087ea1572206238b8fabebbed738998f816.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: MFCZ6FWXBhBCv-0cz5EKS3mXC3C6GGVY
X-Proofpoint-GUID: MFCZ6FWXBhBCv-0cz5EKS3mXC3C6GGVY
X-Authority-Analysis: v=2.4 cv=MpVfKmae c=1 sm=1 tr=0 ts=69863aa4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=HwBGVG7bte8kWS4IyKsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX5jx7nCDB/dTK
 zbmZkY2OGiI16A5BulcOKb5/VP6jdktg/ZWIh+CtU5buekejOXJYHhMevkbkaWij78jMy5lMzb2
 wcjQphfPOZQ9gimkS37u/vXB7NiaYT4BxhhfIvYBvs2W6MMNSTA2qtUGKUB4okWGtv8oZKDUkCd
 jlaFq5teAfE4CM3frZ+B7Jr9ROn5byUaRQCsQ5Xwy/iQG7EcrmfyOvvl8uFxG9afyZdti6JjHyI
 Y9FG9hdAM/NwqIV6xhPu9i1AEog/Ql1PL6GLUeH09hG+v3aGwfzDi65RBMYvPC2PsTnrARO+TYn
 tYrgtlRzycpdE8qDXQRMFgo4wwguaKrA8Dq9SML6Mp5qCWBPAonjbaVt8PJZ/N+jhZEThK8qIsG
 7ndolMxG9G1b3pPDfS1Romy1o4C3Kp6abt0kjWd1KoYr6lP6W/NXxONN7fzUSIYlqfBcwg4ks7P
 sjBo9CW0i1bStCKZxxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060140

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- Added comment in the list of available average modes to prevent regrouping in the future.

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

