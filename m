Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6746279DC2;
	Wed, 25 Mar 2026 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417426; cv=none; b=NJ32j2Fns6bf3jfvc0ArdcSgZuszUnOxw+2cx1GOtmZvRwKTwvDBhsMCAUzdsPqEUPyRhGkb/bqbS4FZ/cYcrINtkDiel9euH0LGC2rudYWih0ndg4jtooVEW2wSXicjz6IMLBeOonG/IGiIEMcH3GmJcbwddu3YNgoRzuxl2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417426; c=relaxed/simple;
	bh=bYikgk+vQUQlqxCaN3q7Io2ssK/VGSv9sCZHj2fQ7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXdo2+rYdWzYvajxKBfnMCBmZSVVp1SxnvssN7iGmUW8tDSRn9jtmsT3HLVLWvCJ+A4wWLkSbwkl/tzZ2LYfhYoeuh7bJk9yIdmi1YM7TRRwdLhHxwurpnh8JI+g4riKfz2uzbRol+xImf2ebNcArhnJZdilHhiZ/Oi96u2qsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sC2ha+sR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sC2ha+sR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OMBwV82579160;
	Wed, 25 Mar 2026 05:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=j8Iv0nFixpzCQj4i
	di0jKx5N99bawBqJjOIv6r515Wo=; b=sC2ha+sRhsp1HomluSPDdUtUs+U3KtmY
	IoA8XZscg/vDgayo9qKR5lPwHEESjFElptLmhg9FjQdNdEScgnFA6AWc5pYRzh8j
	LwKIo9sr6ySyIeEcG2hyfx9FG3C1A2HZaRcXyFeaKouZ3HAEmHtfuSRpnBT5lCCb
	BREODp4z++u4j8FsOG1FAAnYXUQT77XjG92tQooKxbZij5vaxOYUDN84kErniZEF
	NMSNXnsx9Y5a6+lfLBuagiEhSRIeAUDUhL+eCDwoirY2xmP6ldittcc79/yU1RY+
	4NKn97VGQzlhZDb0GyvQEpqkxi/EF34zIwcE4tR8BwCItduzNFniKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja5ppa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:43:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62P5QwVq000671;
	Wed, 25 Mar 2026 05:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsaxj9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 05:43:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62P5hafC007031;
	Wed, 25 Mar 2026 05:43:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsaxj45-1;
	Wed, 25 Mar 2026 05:43:36 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Marc Titinger <mtitinger@baylibre.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: ina2xx-adc: fix regmap max_register off-by-one
Date: Tue, 24 Mar 2026 22:43:09 -0700
Message-ID: <20260325054313.868261-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzNyBTYWx0ZWRfX8j3BTZn3OeZ0
 6gHpDb8T0Qd8RHpwYTQRiQEd5tccRouzXaRQvMI5BK0YVEyH5f7GeJW17IEqHElPEl4BJ6JL8JS
 qU3ByunEv/Rpfhvqfj3cRTWLPYX90NtbP4lyOl2GGiZbnQuQJgpdP6L0EamU7hWP1eUAxVtbxk+
 gNUAvIqx5OlFA94u3Bpcwai7LGzoqivCNy+FU6yqJmtacy2+7xRemadjVJyxzmBiU+ciBk0pWzW
 Xc5lyH5vKrS1WIYAk81t3sVSOdcpkRpFSR8ycFzR9b6escAXUPsXmMfiq2K8CpMjiGhK7vxkflt
 uCYc9H64eFWz5z2NX0WFo5w2hHHJm7NQBwvCCSzcVG7I5xGB53BMfd7G5Y1nJKMwz94r7FNOYg2
 jWu9vrzqFw2+eRdQxC39AagVvT8gboHUd8uCt/gqSyVI/Ndi5kGtpBkO++rljS+Er0P6xl1rbpI
 /YHi/hQ8Z5v+1jUzgAA==
X-Proofpoint-GUID: seFQ5tEEOOWtJS_RQMlodnPGe0_z3_Vv
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c3760b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=UEHRISqDphSmfm_4Y50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: seFQ5tEEOOWtJS_RQMlodnPGe0_z3_Vv

regmap_config.max_register is supposed to store the highest valid
register but this driver assigns the number of registers
INA2XX_MAX_REGISTERS is 8, the highest valid register address is 7.

Fix this by subtracting 1 so max_register is inclusive.

Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Found by static analysis using smatch, code review and guess work.
NOT TESTED.  Please review carefully!
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 857e1b69d6cd..d200b8e87839 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -116,7 +116,7 @@ static inline bool is_signed_reg(unsigned int reg)
 static const struct regmap_config ina2xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.max_register = INA2XX_MAX_REGISTERS,
+	.max_register = INA2XX_MAX_REGISTERS - 1,
 	.writeable_reg = ina2xx_is_writeable_reg,
 	.volatile_reg = ina2xx_is_volatile_reg,
 };
-- 
2.50.1

