Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439C372B5C;
	Mon,  9 Feb 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638405; cv=none; b=PSjr2yZWOaWmFCBSZRMtmIaOz/9oYFs4fjVxbBtrVzZxd4RoVEQZJ9+CZvBFDgU7cu7MKysAk/rGHelKNbBVvrPxtsTrkzeO0n7ob2vtwc360vlX0C/1LSW3bMhBMi+uuyWfFBEGslgzFeSsQcSHMLnhfRFcniNZlGt984sANzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638405; c=relaxed/simple;
	bh=Rwm14yTxEsMelnb91pZl/kMu9GrrFrUnf77zQCpUHYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j++F16R/0KA3pnQ4OHIZG65wWm8ezLGfrGEbRykrVJuipVtz+FMIvKeyCgBM1OZfYGicMH2Us+IWBboA+0LY16s8L/BEZGUFdCZB6gyt53zOZ5BPI8CnyMoD6lI6J0NpmURYuelGhWdJm758V2dWnmB9uHcO6Ev7LOs3ak8Kvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DzwJwg9X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DzwJwg9X"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61995GJC2582297;
	Mon, 9 Feb 2026 06:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Wo4QL4JTmD8tAn29MIA05uTH6tn
	xaqmBm3Kl+QKn6h8=; b=DzwJwg9X/o/yzsUFF+eP5QJgrypbZ+EK/A/wxLhfUsK
	QP8D3MGFALVZWKYTy5ZBNOfUrt4hgM+w7jvyTVmJIwJf5Ytgmj1A0YllRBdtLDC3
	oufSXIy6y98OA58zyYXD1JeKVFYawGA0gL03u/CtXMr+WVFMIQSBHzgYwaVdhOX1
	BiTaLf31KQV1p+uDdfwvyVV+Gb6mECzlcRiyZO2QPT1xRjqBzlmabTf6c1fIJKtf
	mmg58K7B9cCttr8NqW+lYLEzkBu7NnZOmU2KvHoHo+l35J/J1yQoaQs5d9V1tJUD
	4oKxNMPlvoL03K5HHzW1t21tdYyDXSvq9GRydup8j9g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c6xgnk7tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 06:59:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 619BxkmM040615
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Feb 2026 06:59:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Feb
 2026 06:59:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Feb 2026 06:59:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 619BxXX3000606;
	Mon, 9 Feb 2026 06:59:35 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Date: Mon, 9 Feb 2026 13:33:02 +0200
Message-ID: <cover.1770636034.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ysmPJCLUz-6bs1QGAZBoD9vzM3Je6ouD
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=6989cc33 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=CeWmsC5L9xOtpM9ZM8oA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: ysmPJCLUz-6bs1QGAZBoD9vzM3Je6ouD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwMSBTYWx0ZWRfX0isup1tWl5BN
 haZHmiM3rp+pThbgzmsvgvpJTlIjkrVeIlut9N4ppkXoP4D5eIF0vCe71yugJ0o5Ieq9ak3V3hg
 CZ5efCVm96m2Vnj0U7buyS0KZAiQzFY75eZ+WX3kWsaeN2gIRvAdxgCODrlIuMGDUcVifW1NSjW
 uZGdtL9FLtpiyfvNbEN2N7J0e9+hX6yw9B/YEz2/2VnDZCvnYitE8lOiBxS4KfLOtrMNgG/KOwI
 z8LaJcNKe46g10T3x0qieTvPjdygVhBslYeEpWanwq2lEUBEO1nKLQaGvOo51NTyKZYE7/E55BK
 ai290txuLAyNSQUowI6IRosXbjyIniP42DnREUWVkadprjCluHdNhRgOtCSCLsHeQg3A0HAmZlK
 laiIG1TqrMvPPt5vEopK25aHDWwL3UayhBkPAmNUijd2gGsAar0UYlgj5KW+9k4ria60SMn/TqJ
 pIkbcXakV1TMeN/ymow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090101

Fix pm_runtime error handling across the mpu3050 driver. The existing
code uses pm_runtime_get_sync() without checking return values, allowing
operations to proceed even when the device fails to resume.

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
propagate errors appropriately. Unlike pm_runtime_get_sync(), the usage
count is not incremented on error.

Changes in v3:
- Rename patches to focus on fix rather than API change
- Add Fixes: tags
- Collect Reviewed-by

Antoniu Miclaus (2):
  iio: gyro: mpu3050-i2c: fix pm_runtime error handling in bypass_select
  iio: gyro: mpu3050-core: fix pm_runtime error handling

 drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
 drivers/iio/gyro/mpu3050-i2c.c  |  3 +--
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.43.0

