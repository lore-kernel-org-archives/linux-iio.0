Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241272737F2;
	Fri, 30 Jan 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809418; cv=none; b=LgiMIoX0B4gnRwI5w7+/93KLDbZNDXs8Ix4n3OGdUKLYpD4Iv6UiqcDLu8LaBmQFEg9+wDy56WU5BJsQgAU5xEO6U7tSUxVMLHpPdVkreyviskKwu3Ouqg5z3MU/QrpTUxSkDjGLJyRhtOjvjzlFPATJj50uEdF//Z/PItmGaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809418; c=relaxed/simple;
	bh=s1duCevx9ED8cwFST775ZmvAyciLKSI/4LpNZCByZU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzoZrMAoqQ862Ga3tw2PV2vyZR01KJ+GH74GwwBqdBUZR/DlyxBE0KXiqxmgiHNUJxGF0qOg5H4RLdTSLnRvi781xffK4hH0Ga5sHT7W7p3QA7VIv4SLaMu69CzfDsffyc0kGNTwMPIK2MVm+vG81+Lmb3gXIR4NBVokVgtdVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nQaCULKs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQaCULKs"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UKDKPV3538474;
	Fri, 30 Jan 2026 21:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ZnG6cFf1MkU1zbeE4QVhjFikCIte1
	JZeHq5RQwlUEgo=; b=nQaCULKsA7vOqFX+73pOFwApMf8MxEpz3uPFZNLQWg6a5
	c3up8bA+9Q0V2bBrSobHZXwJ/VxBs+ZrDxbsKlf50VRhFwu6wmyrzUJkNXaBH72x
	VzF0ezaPmYpvUByBTjjBslWndt5BJgKklRJMEbsJ40TPVBYXMnffzfJABKg2W4UK
	a8ZN0hDGbHiYDgK0UHXOonl76dlojVqm+0tJ9uI+0vevXukhMOBYvlbemxu/UPdj
	NYZmdMCnYuOUgV9xkG83/jGP1UygrtCRN2DcuTqr2HmskFRgjHFv/LtYUQPqU2an
	qCajW4wSBeepZGJJPXthtfsJCEdldtGRtTYSbERcA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c10b2reex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UJKVCa036073;
	Fri, 30 Jan 2026 21:43:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhtg535-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:28 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ULhRte035490;
	Fri, 30 Jan 2026 21:43:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhtg52e-1;
	Fri, 30 Jan 2026 21:43:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH next 0/4] IIO: sca3000: devm resource management
Date: Fri, 30 Jan 2026 13:43:07 -0800
Message-ID: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=933 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601300178
X-Proofpoint-GUID: 24OWVxKle8S6t0pyqbVEUZctbceB6oBS
X-Authority-Analysis: v=2.4 cv=BLK+bVQG c=1 sm=1 tr=0 ts=697d2601 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u4Q87A9SPbUeVB_4iAEA:9 cc=ntf
 awl=host:12104
X-Proofpoint-ORIG-GUID: 24OWVxKle8S6t0pyqbVEUZctbceB6oBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE3OCBTYWx0ZWRfX9DxeOTGdmxcN
 q32cXj9VY2iZqnKibdGWmFssZolIdT2DvuScdnaG2KOs09PHELmyaUORssqGnKjAAmy9sp6evKC
 w9WFyEPibnS72ov337PuZYDDwnjfmBzqBupb1ycA7Ld6P61G5yITW59APFaHDWp58GGpm+fzw3f
 r6bHVFjD0h2eLu2jq7AahEAs1vxTAR7xbO864e09fMX/oao3GJ6Z3SajX7sR55/mwpcQnJM6l8f
 sOCj49O06737RzKgxn/8ktURJRGTBBXSy+fCc2JfKvNv0lbAN8uMSbX2hLqMC++XQKmOyPFO8y+
 boZsOfVEoV2P9tqHy7HqZt2b/+TnqaJxAlXVMYBsShxXRrGEpge8Gvdrh//O05PGXxD7OQldgZ1
 cbYjSUCKoyerepnAv2zOs+x4kq9TIN3xrNPL5LXZIjQGmkT3Mta1qhR5a7/57CaiR0FvzNbQlQT
 o3MpIW14ChT8aymd0ePmxw/KxMEaPOGulP17uxpc=

Hi,

This is an attempt to update sca3000 accelerometer driver to make use
of devm_ based helpers where needed. I have split it into 4 patches.

Patch 1 does some refactoring and simplification.
Patch 2 switches request_threaded_irq() over to the devm helper.
Patch 3 converts iio_device_register() to its managed counterpart.
Patch 4 replaces the remove() callback with devm_add_action_or_reset()
        while preserving the existing iio_device_unregister() ->
        disable interrupts sequence. I would welcome an extra look at
	this patch.

The series builds cleanly and I have performed static analysis with
smatch checker and haven't tested on actual hardware.

Thanks for your time.

Regards,
Harshit

Harshit Mogalapalli (4):
  iio: sca3000: cache SPI device ID in probe
  iio: sca3000: switch IRQ handling to devm helpers
  iio: sca3000: manage device registration with devm helper
  iio: sca3000: stop interrupts via devm_add_action_or_reset()

 drivers/iio/accel/sca3000.c | 92 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 50 deletions(-)

-- 
2.50.1

