Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55C283FE3;
	Mon, 16 Feb 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235894; cv=none; b=prciINB3EE6GbRF7/Jac9lVcWyZ56Qg8CGsusXlg4pAa0n+L32Dfvol3VEh9XwOao6SQHu48Jfpja1OxrrtWj7P6GHQZhU9ciwFx7Ua6Y0H1kd0f0q2MzRier0BWsG85puRw9C1S+6bKo4pbq4KvbYvST1av6f/UaT71TvLhLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235894; c=relaxed/simple;
	bh=T+YA9CNteuvdPZtiekpS6U+obA8pOETrKAcN3a+Jpy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cVzZTrfytGPy88NfsVMTbxNELBY817WcKYPEW4e0i4pY37tK/U7FjwUVnm8Do7BLmdIqL4tmGwZRKDGdWFkOoFHOZzhjq3QrorEgn6c1Hb7leUp0fPn5u9r1j9Xvt3+2mLzyXeI7t7n5OShYpImbyhjvaTCCsQ23UKBhKwDtYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kvhubcq0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kvhubcq0"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G48KaA3569098;
	Mon, 16 Feb 2026 04:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=4cD4t/VCUBR6n9pT+ZykYxgHScw
	m7yPsqvhoA0SFvXc=; b=Kvhubcq0/4+I5IWfmwjKAMHmLsJ+4l2pnvhu+pUswNp
	1D4UHZ3aXT4sbvfKSrx6pX8tlVkLSXVrLHLLszsOwwd/nQ1lFmA7AW8SIgH7weNK
	E4SLvb2BFU9TZIE6/wAvT8D6VZ6VEya/PL7XbKgY3CqLKFBMJrkPO8qOkwgkTF1Y
	bxxBnJCqig4jnkiWCopEF5M3MmD9AV8DPsZsXlRsJiP+YvzVSU9+dbVKcBYtoDJC
	+D7s39k+tOdwGGZCKel2iybagmt8XD3B5Dv79qugGfg3p0Iccqv5+bWkfwdzTcHK
	pRS9Y4xspYQymb31ppNAZ2/mqBuewBbQ7DN0Ews8xyQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cb88hm13y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 04:58:09 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61G9w8Yh045722
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 04:58:08 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 04:58:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 04:58:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 04:58:08 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61G9vwKb017405;
	Mon, 16 Feb 2026 04:58:00 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Date: Mon, 16 Feb 2026 11:57:54 +0200
Message-ID: <cover.1771233915.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MyBTYWx0ZWRfX39V9+1tDl3St
 zcNo/ihXaVg6DjlyIu1hJXiK4/u2CbtIMEG5grxM/V5jAPluzknuDPzQMaiFF8GE4iTYkw1mZor
 sd9dr6XblO2vmGLTfTip1EE1YKG/UUUDR+XW97d/aXjJW80J3w/HOAOY9Vhz3Hm8pDz0pEG5prG
 CK16zByvvpLuelAIZd7nIx4kAFIOSbRxgoAE4uEbquw8xNRXW5UYzDObJhjkABfXbYhhF1Ny0sf
 4+Mp+Rc5pDedIYiLXmNIdO7+7D+5PqrBMtPj14FhCEPatSfehJT4I5NJAzs2qUpDgOUo1ed7p/4
 3hMkyrL436/DL4xLKL9ZEYcoGlD0Ec6zt2oihcszQH1p0MaMpezUTjuJJDNQi1ZNvk10OZPHZeU
 ggU/fqULr5QCDIjNei5rkAFVcWfHiKtENeGXzecjc6v65m0c8qYPjWrQrODDdcjb/ez2GbgvPAi
 E03BRG4rbP8EXuzBwyA==
X-Proofpoint-GUID: HfulgtG543NWZ7xP1VWRk7d54akm_GVV
X-Authority-Analysis: v=2.4 cv=TeubdBQh c=1 sm=1 tr=0 ts=6992ea31 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=qMukpJIgz0f2LLvR2MMA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: HfulgtG543NWZ7xP1VWRk7d54akm_GVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160083

Fix pm_runtime error handling across the mpu3050 driver. The existing
code uses pm_runtime_get_sync() without checking return values, allowing
operations to proceed even when the device fails to resume.

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
propagate errors appropriately. Unlike pm_runtime_get_sync(), the usage
count is not incremented on error.

Changes in v4:
- Reword commit messages to correctly attribute the unchecked return
  value to the caller rather than pm_runtime_get_sync() itself
- Simplify preenable by collapsing the trailing return statements

Antoniu Miclaus (2):
  iio: gyro: mpu3050-i2c: fix pm_runtime error handling
  iio: gyro: mpu3050-core: fix pm_runtime error handling

 drivers/iio/gyro/mpu3050-core.c | 18 +++++++++++++-----
 drivers/iio/gyro/mpu3050-i2c.c  |  3 +--
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.43.0

