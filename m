Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D865330B3F;
	Tue, 31 Mar 2026 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920338; cv=none; b=N7UN/tkXqtr5z98FS1maUVxW1nI67SRWb6P346vM+EnhUT4eo8Ik0Zopual2xdRhKbPl8wWkjWv2RwfmewT5kK4wHIhvEOCyHG0a2QqVLPhXDTUR4hglfhOngtHEFsysGYxxTiAj6USnldntooLLNl4tFyYKUYdSc5mM2HSCN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920338; c=relaxed/simple;
	bh=HyXpjHz/GFInnXaPhZwX0ikxua2pFD/ze7kG4bHhysk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS5qi0GTBgmmrYMl/UumZAapDPz62dVI3RlCtEAxT1c+FrYceTKQ6dAoBFZPUSphoenrTq/LwM7z2bYORpfunYLo6lLMzNllpp2f3BE34ylPKy1NYycHCsEv7LiNrbu152KWOppVPodaNzTvG5ThvC0wfhLb4rvlWXg+J4ciJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oqzVgR7T; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oqzVgR7T"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V0cShq1955193;
	Mon, 30 Mar 2026 21:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hlu5b
	ztsUdbHdDGx2iRpQkCgxCm6Drv27KSMmfJLoXc=; b=oqzVgR7TMwoJqkI01AxNe
	YeOmNVSqMJ/u01Biuy/9jONd3nB4rCNJYtr/H+FQEGj/AOWi9I8i9aC05FSN7gJS
	XXJ4sVQ5rAN5yFV7aPDArQqdQvrPx2j2pVy6BIC9H3wijZ0CmLqyjPtlJSjtc66h
	eMj4jVdkephkhSUAaseWNVwN5y2P2ixDKkWZrEqOusf8efyZ27WCBXnIGQEiZOIf
	CziH92s5Phuuz9iQlhwAiiq5nfS2JC/594ywIKhwSQgbiWquLlw9NZrErqvPKaH/
	tvu49pI8I6FhTjhwrROXH6Q80Y8Z/gJgzno2LDMbJvOFXtxWW/DMjORCt02NOzYc
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d740yejxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 21:25:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62V1PW3G061218
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 21:25:32 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 21:25:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 21:25:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 21:25:32 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62V1P8RU006886;
	Mon, 30 Mar 2026 21:25:24 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ltc2309: Optimize chip_info structure layout
Date: Tue, 31 Mar 2026 09:24:57 +0800
Message-ID: <20260331012457.9324-3-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331012457.9324-1-carlosjr.jones@analog.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=69cb228d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=jloxm63QuxvzzrIBTskA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAxMSBTYWx0ZWRfX1eAycNjygVja
 wakFmd+Y7wO08GiGLY6sw+iYOQIgoUaGr331elI7W5foCEdJbcBcy9LiUv5c7wEUHyjWxGrFhtX
 c8I+vZK/Z+xudZasS2vdW8mLKN2IV5TtiAzr1FM+ip54DEc21nvSmTDysI8mbanBgjtzXv3Hlx1
 2Ni4DH5cw+KzYpjDsYyzTXZ2+tLkNshAUDixfsWD35e8Y5IQxiOnOgYZBycr+ub2KVVv7aXlAZL
 qyiK+vub64tuFs84Ik83Ms+ed/sW3ciQhGdOu+x4c6SW8lz+tx1hZkLhlVMjevdb4nzR2kI/IK8
 fNR2yhgMJPYxHv3na/xfgnoDwJ2dI+qHXU+aPacXK5fnMxF5MmYT11UtG7hCXnrr+KaAZDYnePq
 zRraNAzk7cBLEEjtWxPCFnjbp7SbZqghr9BOml4dPeRZnwTa9B/1Mf4vYD7SbmoOf6RCqAsA0o4
 urXcYLRu8K7xB+MXfTA==
X-Proofpoint-ORIG-GUID: MsPVm3PZ7orHTf2Qk_NSXABcza3FsPah
X-Proofpoint-GUID: MsPVm3PZ7orHTf2Qk_NSXABcza3FsPah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310011

Improve the ltc2309_chip_info structure with better type safety and
memory efficiency:

- Add __counted_by_ptr() annotation to the channels pointer, linking
  it to num_channels for improved bounds checking and kernel hardening
- Reorder structure fields to minimize padding:
  * Place read_delay_us before num_channels
  * This reduces struct size and eliminates internal gaps
- Reorder field initialization to match the structure definition order

The __counted_by_ptr() attribute enables compile-time and runtime
verification that array accesses to channels[] stay within the bounds
specified by num_channels, improving memory safety.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/ltc2309.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 094966289922..87b78d0353f1 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -121,22 +121,22 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 
 struct ltc2309_chip_info {
 	const char *name;
-	const struct iio_chan_spec *channels;
 	unsigned int read_delay_us;
 	int num_channels;
+	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
 };
 
 static const struct ltc2309_chip_info ltc2305_chip_info = {
 	.name = "ltc2305",
-	.channels = ltc2305_channels,
 	.read_delay_us = 2,
 	.num_channels = ARRAY_SIZE(ltc2305_channels),
+	.channels = ltc2305_channels,
 };
 
 static const struct ltc2309_chip_info ltc2309_chip_info = {
 	.name = "ltc2309",
-	.channels = ltc2309_channels,
 	.num_channels = ARRAY_SIZE(ltc2309_channels),
+	.channels = ltc2309_channels,
 };
 
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
-- 
2.43.0

