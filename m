Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5D34D912;
	Mon,  9 Feb 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638576; cv=none; b=d7RR8W0a5PV9CwGhf+GA85L+ZCcL/bhMxLFaLJvxyBqOIYdfRXjHd0C5jTDgOFpvmXlyLi/br2izYy8dfiqyX9YhCu4e2Hn+lqN/PyUbwDriQMMpTc+DZ7Yn05ek4K2W38hM/AQpDlRO/LdGwC5uS67Rlzd1e4FQH9FQofuCo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638576; c=relaxed/simple;
	bh=Rwm14yTxEsMelnb91pZl/kMu9GrrFrUnf77zQCpUHYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QH9y/GrLAj2QrN2d2s4IKuGe7gHICYjFSU9HJCPDsvYMZ4WVic4b8MpQGV1DISz9KoIixZCN0xDdbNGSnOlWHBUhliCW7zOtAC0KhtkFjfCRcbCwoUvNMtpnvt04y4DuvE9W5jOkOtpZhpkfA1CiygNXA7mcGDb1sCiVKumCGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GR5bukij; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GR5bukij"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619AF8qP3275264;
	Mon, 9 Feb 2026 07:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Wo4QL4JTmD8tAn29MIA05uTH6tn
	xaqmBm3Kl+QKn6h8=; b=GR5bukijCqU0vJk/v7DSBbFqSwmP7OCn8OmxrQ+3t7M
	9eOZD76PRU3c7b+7NkcAURv1YF97OwJnIRMQbKiGpDgpTmUbgFnN3ZHlAToCWqTG
	1qdvFIWDxnrfdHiZdrU/H5B81rUP1hdzVDY6qx83p71q102IWN7ORUE7Ppsql/cP
	cMYaIzNyi+RoswY2haHXSTeAcWFToHU9oeAy+tEMoY9OksjSbvCbZ5M2AoHaGiNI
	razg7FD8iehqez8Mgoov3FktKK4bicSRxp3KccTnQOWr93wSzavmg4sif1aG5q9c
	FxzKoWHLrFdilL8g+DsvPbnYiuqAzxJhVweDAMtmfZQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6042pxn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 07:02:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 619C2lVe041201
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Feb 2026 07:02:47 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Feb 2026 07:02:47 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Feb 2026 07:02:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Feb 2026 07:02:47 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 619C2aTc001481;
	Mon, 9 Feb 2026 07:02:39 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Date: Mon, 9 Feb 2026 14:02:14 +0200
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
X-Proofpoint-ORIG-GUID: qvFNBaJBJYx2-Ae8cvJUPIYQ8wIHejaf
X-Authority-Analysis: v=2.4 cv=ENILElZC c=1 sm=1 tr=0 ts=6989cce8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=CeWmsC5L9xOtpM9ZM8oA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwMSBTYWx0ZWRfX/8GuuLzgHrT5
 WvWrTkSWj+ZLBBxHS0yOElMzIhna3RKJYFrU66SbTEqOFDBI7jNgpOPTz7z2gdAk0/oi3LGYadx
 TpXiNoncLRKPJmR06PxNxLCVu3FphUJ9ijO4uM0sxQJ6DmoCRCdFnTGd0r+jPs0KB4I8gqhbK2g
 2oz2VfBCcffqBkk1sQeBQ8+DxvDtkbEdAMTsRooeFCvKfH5GBvEYT8w6b/IdlQMQZpaNLuPkw/g
 huLMdkglB22XW8V0Z0t511iCGfdosdVWUsSam7wqBy1tcQBqkY+yuXBr5ywvrCbp7BSqOXAJjzz
 QpRvCCDel7+J2P7sX1bq+NiCXlVL7+nKQPVaUvHwtcBnuXA5Fly/dR+oTLAl1KLLdA29qBXAJKW
 hIo5iUY9RxQ1vRWsTQv0w7JqWPtJ4l6JPWxx9hLlweFV1H6U0nNgTGvH54x4x0aJtzvY+08n+iK
 9Y1tUBK6alULIRfYFAQ==
X-Proofpoint-GUID: qvFNBaJBJYx2-Ae8cvJUPIYQ8wIHejaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090101
Message-ID: <20260209120214.6Dq6NgCQ_EQOsRlJzI5uopiN7RckgNdiE4bJGVtJyeY@z>

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

