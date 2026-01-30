Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FE3783B6;
	Fri, 30 Jan 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775806; cv=none; b=NY2JEp8gIYTYGJtX2z4j6tBKva3naZnuA6s14/NTzcPPEhixsf3+Z+b8unTEPQFr2AwsPKGb8Dfp+K4Vc75sDAH0opSCFIussDRvypNiM4V+V0E4dpPJTlyy/ISC+Rs6jy7/Oe+nZRu3uwrbXTyRWN93MQ4TKrYRsfnZmZDrPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775806; c=relaxed/simple;
	bh=AfwFDmy6MGnM2nhPGo039gbYthqtrtO+TrrM03UXRmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZlkN2y08rI6tnL2BFTBArLiaz+31D/mTWnFeYlQ/0t9ZGdvCRBLPkzBrqTcHR/ASccrY2MaMgHBRheNrlDGTrGHc4XNuC9kbqPry+uWNvZ715q1+zVyRw6Bqs8pVAxe/zjySiqdrzOmCrti1LxCa+1dLQJVXOLK3uhzBmFr2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T6zZRxX5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T6zZRxX5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U6VbhF2946649;
	Fri, 30 Jan 2026 07:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=yFO2cUdPn7eGZ8UbQ4bQLPvTsnE
	LiXvA9gyByfFWk9Y=; b=T6zZRxX53nlswXHpJESrvz2NPiQ5zTcd1hubk37GRkd
	yWFkVCDM6jE0/Qx9xTUoyTZPzbg3gGuwMwQJvduE017mlvvYneNXJ9pkSbMBmrI0
	Q1UAUYERpa8WnSEtMYPOwEyqDNfMF90vbUsvf8iQw+9LTA1KDA5f6XTOx6DB9ePL
	Xomty3g67CHzRS2hfpAJnkRkinHf7gLoqf4n0K+XNeGfaOMTt+1zdi5kBnw0+e3j
	F1mNMySV2ljUewuJ3JtI+fc/xM1rVEMzWfNfeMV5Vz1OpReNJ285njteytP9nxfJ
	QhnlL++MxqhAdYpxUUYqRYywvUWJDhj3n/NRwc6Y1VA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c0c8a3j01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 07:23:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UCNKsH051505
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 07:23:20 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 07:23:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 07:23:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 07:23:20 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UCNA70010740;
	Fri, 30 Jan 2026 07:23:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <jic23@kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: add entry for ADL8113 driver
Date: Fri, 30 Jan 2026 14:23:08 +0200
Message-ID: <20260130122308.87935-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=LPJrgZW9 c=1 sm=1 tr=0 ts=697ca2b9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=iNWud8tueSu1nfbozfIA:9
X-Proofpoint-GUID: 5wXkTYTWBee0NdVvArhtmPJ8ZTXJNhqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwMSBTYWx0ZWRfX6314+7JIov9V
 51Tiqs3yaqWNNJeEIL00ZyCyrw3UwzZLO+Rgrz9hDRJujpVx5jK0w7d2pxFbWoj7AHkhR01GxFy
 pCtLZ37EyDjsAiaTnz22AlzqGXH/ml7G3ZTX89NrEaGIDzdyHudho0kCtCL2kEG/A1oPNd11esR
 zauRmaV7yyNZoQGLO/SEPReDMLl9eOQpLkXsuRLFI+k3Iqyau+srWMAklT8+RS3wKSGFox3CsHz
 wkILY1kzJmoXxiQCwdhCLhwKzWfexi8EGQr13XUUR0d75S0EqWEu0iq2Z16JYuW+q+dSiFnqRQ0
 4gfce+GwRGsWrmsw+3Bumu0MU5mXxUO8f3mHAnbD8FTnqsZufA0PvmYpfiUq93HnhWIyq/86kFQ
 xEDCVTTicgZmVqntHhLLZeaV7vYHHlOdqNs8+bOhSiDLRGyRnesXHR55j8wYSHfABjdCgT0dDDx
 EpB03I8SMWbOmORT6IA==
X-Proofpoint-ORIG-GUID: 5wXkTYTWBee0NdVvArhtmPJ8ZTXJNhqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300101

Add MAINTAINERS entry for the ADL8113 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bd..04b918b07ea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1691,6 +1691,14 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 
+ANALOG DEVICES INC ADL8113 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
+F:	drivers/iio/amplifiers/adl8113.c
+
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.0

