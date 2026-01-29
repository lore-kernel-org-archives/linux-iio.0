Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852834B682;
	Thu, 29 Jan 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707543; cv=none; b=VR5cQr9T9Gqwps7LdFJXaYk6lnKB5NEjRFnG8I1Z7pgqlyV5NepsH8Xil2KoVTZptp7tTL8KEbGWuxZKOHy+1kFkOemOsZow6CpSxWDLYhY9iLpBGL83iTF8sEfjzd2thK0OZUUs1BjjWU5JlZR0qypQv1JLymG+7S66/vJCmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707543; c=relaxed/simple;
	bh=q2im5Texm2wqBPAgnjfh0xdBey0theibdw7gyPoi9AY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCCjemRQYFGhx8fQy7Qx7c6hFEv7RDeetRPVoWRqVSeOHcmb0gGHm0E/m45Wb5NdDB6ypmENLKSHp9IrL377/zKrPeo7O2HHCeu0Lb0b+Lkbu9Fw2Gr3KfKoyhnN/ZJJ1z9gNzEaSNnRDKCgYTyUAsinAyLGNso5OZW6cx+2w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hK9+zaxm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hK9+zaxm"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TGXVo13441980;
	Thu, 29 Jan 2026 12:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5Sg20
	o0DUtakFHTvHrjDTFNZG20Ewu5VN+LpV/K2Nbk=; b=hK9+zaxmuQsb9C1zt2QZB
	daqq3e/dKul5zrWeOKVyNzCGBKW46RVIXtQfHZOJ0yUXsyuAqM0raBTkm55cn+RU
	biFBS8nosUVvy7peG9fjD6NC+cDA8YDFK8TstsRxdpc+yxHM4lWEeJjvryC+Yn8n
	A5zZ7zqzTziWC/R8GeMWZpZi8FoFpJqt7op7v5g9mXTHY2fSMN1aChp+NeTx1K6X
	SDflnhYpn5XLW57dRL/9gI8CNHNWDK8e2Quz+8FFfQLhDxdfjqIM+qudTdh3+hWu
	SQP27Kpi9Xu9on2tqETSK81xn2iasNV3+RGEXwpqn4KDKuUWhSO03CLwTSBy6PRM
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdpnnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:25:24 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THPNPM055998
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:25:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:25:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:25:23 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rr008516;
	Thu, 29 Jan 2026 12:25:17 -0500
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
	<andy@kernel.org>, Fabio Estevam <festevam@denx.de>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: nau7802: remove unused min_conversions field
Date: Thu, 29 Jan 2026 19:22:03 +0200
Message-ID: <20260129172340.34216-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX4vnu9+5meKms
 z2lBCJ7nO8T4Isk1Hh0YUSJC3GlZwPt9Y3+Kfep0r7j/R/4b6ezjaF3hEX/FXNCZEGWDCMFphWp
 IUIEdpb0qtbOusvG66ZpF2IuuHwtQIknicHbYmcxqJ+/D8GhduAI52gfEfiB8+ziQEUA/e7n15G
 G4ef4aanWnM5GMMl5CDMGmwJRiWYXBflgiKYeR3cQ3QzeKL3XgfxGj/1PM1mA+SKRJQeox6jyFG
 TpBE/kVi9kkCSL8LOItpBlrLJOA6lKyw+ru09prMUUPZg/hp+W0ln8yTIyqlZEFKmdGcRs5TEBL
 C+PkrAdvzzfsKMdkJ/uErrvbGREV6T+7mz2PT2eRqtRWGv3qpy6jyySqCyGwAs/avBlP+PCtD/O
 vWQvhD8h8XqWXi2NCpiuAeLA/CXOTV8qUvHlLBFedSl6dnZcI46WWMjpIiinNTnlByi5HmTgl86
 mBEyiWwgNugtrPjSxgg==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b9804 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=WVJFjqiBz9fkplPIqEAA:9
X-Proofpoint-ORIG-GUID: RYRqyAW2YRwi8MdF9tVDahl7dNRWFP3p
X-Proofpoint-GUID: RYRqyAW2YRwi8MdF9tVDahl7dNRWFP3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused min_conversions field from nau7802_state
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/nau7802.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 458544cb8ee4..97e92c0427e9 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -55,7 +55,6 @@ struct nau7802_state {
 	struct mutex		data_lock;
 	u32			vref_mv;
 	u32			conversion_count;
-	u32			min_conversions;
 	u8			sample_rate;
 	u32			scale_avail[8];
 	struct completion	value_ok;
-- 
2.43.0

