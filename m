Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C01372B51;
	Mon,  2 Feb 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044217; cv=none; b=qDwjKS9FkWAXPmnOzjgrx3bLovpU6HDK7kG5T4KkfJSK3xeNZKx/y3x0nkXOyKDEs7EcdJ7x3CHcsp7AB4hrNPIlFxKbIsszsFhvFx+/ZqK9RQuiDxc0ANqVhB70QAmDfJvyjXfeHamqNQGwMJQi7/Aa6Ij/vWGmBJliTWtKcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044217; c=relaxed/simple;
	bh=/41u/N/TzVR+wT3pnA8a0+JQiliXXyqZJ/e8znDRxuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxTY4+lSHbMHiNWJ4uoeCKypR9uNMtYoRtZacK4phhlEvQVQb13VK8aJ3onlKhAB0gcU9ZWFF2FkKCbnS6RmHzMxHP1fniDMDvwUfrHfz/itRmsH0rz1cQCVLLkKXgdcKyyAwrOk+N8QDAx7uEoaxuy+c5j29U8lTaa+TID5MX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JQN3ZFAR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JQN3ZFAR"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612BF5Vl2221441;
	Mon, 2 Feb 2026 09:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+uk4EQmgF5293pQsT0sNSDGHdAr
	n6HDceTq0DtYvU6I=; b=JQN3ZFARcqPMMho0zhoO1q6b1JuAV6w5WjtijTsEibp
	Ql9avXzctkKPjjwYPl4RpuLvdHVRUTcUOirO+rUSsQQuf9yvXert5L94dI1oDYJf
	FR7bm34eOHGY85tv1QrgIhXTrRGcAZndqjSZcwjsw/qCRIPgntQyOyelzQ3rdWTq
	qQbaeTF5Mn4IuFKtg/FHYijW6qW1MD5NL5+VGTZG2f+dSbNRfH8vF3ffSwTDtCUu
	Irs5h00vZHnOEwhCLkY2Qbr87jY7Xh4WhV5v3Tjcn3E5GdzRUKhcmIivkmXWCt/z
	OztqQD6ecbMkKW7oB8NQAKJW4MW6lFyHM8Uv9YW2A1w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgmagn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 09:56:40 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612EudMD007130
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 09:56:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 09:56:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 09:56:39 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612EuT8t030448;
	Mon, 2 Feb 2026 09:56:31 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 0/2] iio: gyro: mpu3050: use pm_runtime_resume_and_get()
Date: Mon, 2 Feb 2026 16:56:25 +0200
Message-ID: <cover.1770039759.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=6980bb28 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=CeWmsC5L9xOtpM9ZM8oA:9
X-Proofpoint-GUID: sA-N64qhHtfxQZ-kf5fsUtPQ2b5cbl_9
X-Proofpoint-ORIG-GUID: sA-N64qhHtfxQZ-kf5fsUtPQ2b5cbl_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfX20diW68rme6b
 WFcTkaN2Bs1CF7yNFbX4qYeYIZxWv0xVyIKdzggsVVPX3a7bq04HjlsoQDSVGUoIsh+YmdFVjqB
 QuleaTQ5xUT2PZmdclf/IAJP58Y6QBVbxawojTJVWGXKFHIxqVjGc1p84qL4NElj/y8a7ytvZtQ
 NhHS67UW+TufvFuu6f6Jew4QSXuGn1P2c90XN4VmUR6nyAoIqzpKb4VJRbhdz28iUYK7Hmannib
 /yGfm4IOJoiqbssp6Rj+lHLcVR2Nh81KMeQr6NwoBBgTvRAhV1Gsw/aBLCzhOArFY+1YmUdUNZ8
 //8aKREQPPr0QqjfgqoQ7IzvemVwTDRMfivD7XA1fMbwRxrkI6A570nQeVB/1yaqSacL/MYy3R9
 UhjrDJEBzfX7VuyOJNDGuqcuoA54yZdytx/pmDxvfXZ90KzDKTtrYt2TGV8/5y1N97npln/Fvmz
 h+GnCAj7g2LJX1GVo6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020117

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() across
the mpu3050 driver. Unlike pm_runtime_get_sync(), the usage count is
not incremented on error.

Changes in v2:
- Add cover letter
- Reword commit messages

Antoniu Miclaus (2):
  iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
  iio: gyro: mpu3050-core: use pm_runtime_resume_and_get()

 drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
 drivers/iio/gyro/mpu3050-i2c.c  |  3 +--
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.43.0

