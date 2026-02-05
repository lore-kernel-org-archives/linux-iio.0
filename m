Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2B425CC1;
	Thu,  5 Feb 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310121; cv=none; b=Dn8ksHmlliZClW9y2rvMPuLi3e9MdJzJxe8mzKMbMLDiTFr2so5gkeiTYFfnT50Mb7pkIPqvqQc9pjE1pooIuYAE/v2msRWSrdVAkwSGNJ308tKCdH36nj6mvhqX0bAl2X3z2k3XtfKbGs+I4jGitkFQUS8tTT72vjLqJrwc7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310121; c=relaxed/simple;
	bh=V4yaKPsP9CSEAqqeAJfKX7rlN03RIpLVwOC7YfDS57E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaMp5Fn8xayK+2+0jmMvcdQc2nYKI725pj/PlGjPz8WveRm2rxQJ0aGnmNvFM87+f15DhaFprwN4gwmZhMWBEWwgcYvLzMFZ9ciTLcc31NHnsNnZ5644lSzQO2mdkxtkA3abwOGuE32In3vyxFxV89K933UrjgaDmjlpUDZk36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nd4cm9Q9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nd4cm9Q9"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615GPlHP430772;
	Thu, 5 Feb 2026 11:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mLq9p
	uK+wBQbesredddGLdinAXG4E90U5prWfm9eQWk=; b=nd4cm9Q9+glzaFc7vt3W0
	2cEmMUIrQVG5SNuvRY3rN2nb9UkOdWxFcp51E6qGvocZpc8OeWgZilqWXOdN1o5q
	eI7XgQXvJq81IJcVopWQiU90LmvwFQOX8NERcSh6/pFCKXUt7lEruL8yL96Mw5+8
	QpbCFc5En93OijWd8O/IF/+kJUlmi9VRw9plStsgsT/WTXuWTN45cgz0e0Hfzbtl
	HIFEGHgXHBGHVVWCx+4JnOaeg7DZk7ajfpTMdZPyZPRLvP35CB5AqQcVmC0T7qTk
	ZS34mb7MNobPMgJIq5C3dwS/oAqNc5DO4JCL22maWt2GWO6Y/sn7M3eHhRjxj/1h
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vybg3sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:48:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GmZ3w045262
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:48:35 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:48:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:48:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:48:35 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615GmJPJ000465;
	Thu, 5 Feb 2026 11:48:22 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v7 4/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Thu, 5 Feb 2026 13:48:19 -0300
Message-ID: <ded44627458ceac33407f5a0bb0eb77419d60d48.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kLQY9TXIpo9i6v4LR-yplBdjVV7Qgp9A
X-Authority-Analysis: v=2.4 cv=XLI9iAhE c=1 sm=1 tr=0 ts=6984c9e4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=HwBGVG7bte8kWS4IyKsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: kLQY9TXIpo9i6v4LR-yplBdjVV7Qgp9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfXxF9OlGf/OSH8
 ZM1aYZOu9e5Oapuwgs3hksVssSn4Ur6LmVEtyd2MsP4k+oNg4WPAUpLsDxpBeaT8NTQ6Y46d4Da
 qqbTB7JqSw+6GtcVUAZ/XD8/uxFzRXa1P8xFgHr1LcAMYU9DQ+mHAUDM7UkBOcTZhVI3guxDO4Q
 OuGgQcrMsr9IKXbgHt2uX3xki2GrU3hWJo6LO2gGnFNmjRiEleyNyUbb0Uj2DBF2ZXqd0mzhp5q
 b1r61Brx/AxoQVLYafc5+OfiiYP7UTeAvTDcuwaxP7rwFXZ42MfQC08Lvr+npRlM8marXpeoQ1H
 Tjef4AFJGdxvh0I1N6AL21jRw+Zzs0myItWtpj3g0eJdsJMn1Y3mFpElNAaAAo7SKMgNWIkxpAl
 rIIgEnpGKrH07A1J8KecGMWJF+rKdiF90+LCN6vDOu/9c6SBC5zozxJ9PsGN+gsDDdTkqP0uyq4
 gRSs5MayZyH9OJZIczQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050127

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 drivers/iio/adc/ad4030.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 68446db9bef1..d39da4884e1d 100644
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
+	BIT(0),
+	BIT(1), BIT(2), BIT(3), BIT(4),
+	BIT(5), BIT(6), BIT(7), BIT(8),
+	BIT(9), BIT(10), BIT(11), BIT(12),
+	BIT(13), BIT(14), BIT(15), BIT(16),
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.39.2

