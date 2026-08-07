Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6444A405;
	Fri,  7 Aug 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093132; cv=none; b=PIiH4YsG83bat+0SWz2R7S3CMexEiLqbBvUtDg6h5tkWbxxDvZxE1UzOeBYtip7FaZCD2Y0DcX62wPM3pY4gxjrBdBANSm0oMhzVY9VNLLB7yTVgHEsTy2KtvClXPkpaYE9XOLrQZ5Cl0zg0lATFECG4XR57H8yUxclPskiLyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093132; c=relaxed/simple;
	bh=JlluY2uE8EHlEQYiRRzkcS5lBK7CzIo/sHuwZzVSLSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBg1wSsUxdjNiZr8/zUkxTI8zyFWYQXvzlyxjpnVU0aXOYIUpdtT4EI3vckqyQ150bFkjv5e3yxfykjJCglq1mfYUaEeTvciOUMMXOQdgEMMe2gUQnxTCAtonSdwnh62IEFepR5bgnOin+nd3OXscd2QMFkCcv4YlL9b19vTFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XibMwzZi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XibMwzZi"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776DH70752751;
	Fri, 7 Aug 2026 04:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NynlL
	gL1mG/IpKy5w3uCJ1X/G5sIhauQ8T6QodqCiM0=; b=XibMwzZiS/Ke3jY3rGBCY
	9vOr1rnurPfaHOWKbXop9cmsNlcW3d7t7uHCbl7djKa2l44EaadPWdig49M3uduz
	tVv3mtLay9oLXozc0BniNSGrLIda/S9EWuk1gy6Eecrtlixg5pd91KulBoz8es1e
	dS1pPcON/jvGeVxFjqBIR2EHHK3hm0qj0AQQ0k7pf3rO2Vg4Pk8vBkM3pTRRxIOM
	X5I2K2J93TtMq/B1KDRAlAIye3FXlEAvldGtGqmtgg3J9iaPkofk1f6HHJC8U8KD
	wq5p130qBE7sngtWMnkPOjFV/i72QeCZAbM2ZBVLHYt98TxKo+YRP1OvPpPWuta9
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpwq8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 04:58:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6778wlt1059726
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Aug 2026 04:58:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 7 Aug 2026 04:58:46 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6778wTrD022705;
	Fri, 7 Aug 2026 04:58:40 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] iio: adc: ade9000: handle Phase C dip events in IRQ1 handler
Date: Fri, 7 Aug 2026 11:56:43 +0300
Message-ID: <20260807085643.5502-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807085643.5502-1-antoniu.miclaus@analog.com>
References: <20260807085643.5502-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9ancmQcuONAD-l-GMnFxMo9hASgkEJhM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfX3760uo2UT2YK
 MOZzp6CeB96/tEHorrpMDf/XRZFzx8EPgmnTqHqXAmIQunpSjjl/qyK+onvHXs7HRhM8ejDf68h
 y3XXTJh/BhWwNWDQ4ZdhBUTpkB3Du8XleDRSoF2cRsVZF0coPKxG
X-Proofpoint-ORIG-GUID: 9ancmQcuONAD-l-GMnFxMo9hASgkEJhM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfX2erZKsODROT5
 h0xvkDLggkNb9BEtORPs20+nfAWsScMJ2a5efs9W2Y6IhHYGL5E4zo8PKNS/vo/7H8ziXj6owxD
 OhV/NzVAOYLLM35F/AHQFsGJsUGe+YUaoIKXp8AR3mDoEbeout2Pmwa0maI3R9QIq+ytlXGKgWk
 sKl5WFCKpFa9GUlv5lNbNIcQqtawiGZxOxmSJ/SuDg1RxgTblOCHR3Ntnwg0phMlMyrj56NxwId
 aZjoGpgv93feFauUAd0jtk2cQmnu5hLJoaxjIrttPEVRUZGYC694iYjLHxQUAKf+bRMx+Va9gVz
 LX0js6dQG7HvhZW/sRpaJEEqg6tt2wVayYkbKZdSY7XsYRGIEw9JFWQKXviIgIM00djVInyd/An
 ywBq3bz28sJWbcrp5A90QehwTDctaqOQ+mnD8ltVtK+JQqFe3orp6bJkDxrNLes8t8oj5LGN187
 H/GTMu0ADhjmeiN2AuA==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a759e48 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=83ESzPC_P5AoS1xzAO4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070066

ADE9000_ST1_CROSSING_DEPTH is the exclusive upper bound for scanning the
STATUS1 event bits, so a value of 25 left out the highest event bit,
ADE9000_ST1_DIPC_BIT (bit 25). Phase C dip events were never reported.

Bump the value to 26 so bit 25 is scanned.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 167b1f4d6279..da6caabfe2a4 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -219,7 +219,7 @@
 #define ADE9000_ST1_ERROR2_BIT		BIT(30)
 #define ADE9000_ST1_ERROR3_BIT		BIT(31)
 #define ADE9000_ST1_CROSSING_FIRST	6
-#define ADE9000_ST1_CROSSING_DEPTH	25
+#define ADE9000_ST1_CROSSING_DEPTH	26
 
 #define ADE9000_WFB_TRG_DIP_BIT		BIT(0)
 #define ADE9000_WFB_TRG_SWELL_BIT	BIT(1)
-- 
2.43.0

