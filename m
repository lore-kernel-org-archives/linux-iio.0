Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E71EA7DB;
	Fri, 30 Jan 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787278; cv=none; b=ERDRhRhDUW1saXtATXLo5DVGEDdYc7eNgi3Zc45drpM8RKbB8nQMRxPIIR3r1+qJx6hJfxKO6As/vRsHIIBKSXlvUHgZe180mWVaJv4DX/Mhcaq93wRd1Z3xDUeaw4r2zr+yiUox/Ngq1X3jWhjgFEjwSi+AMbLkSf60jMpcWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787278; c=relaxed/simple;
	bh=cjfi2j/WsvJOvCgT9zQlapTb/dqb0N0cYnaz68RGpGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYklOsNkH7jggPYf6UjRasndhFFmQVQstKsbNpYq7Hi+lURYMXqnIi5cAoZD/M1L0Ix2x1ORQCtIa8nZWBTOqTyBqpLYlbCWCKSGNlOoZmTy8ICnaqOCjsSi6oImN2eFmZVFdpED7j7WmjM1RxpQDX0dCV111+J3cC48EcGmHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FkQl0y0w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FkQl0y0w"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCRKSh2947192;
	Fri, 30 Jan 2026 10:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=rNCptr3ORDQEhHJHonUxfFuWLPy
	HpBF58iNctraRhTs=; b=FkQl0y0w0hCE9vIoKU5yZ2V9CKY4qgZoKMAjI5qCH0D
	tYpwedpm81GB7yqSefNWDp0FR0FsRNB5EcsGl92rtUBvBV0R2q5KoVE1s6QHSgat
	zpNFhXwD/3eLWQZ7EL6E5KRnWpzGQMe+BdsRsJdErQPZJLuJqOIEEAxDWsDPlDwI
	+ydk/N+oQPTya5v/cbduuFYyjd8UcbXMnK+hZ7gS4ACCEwC3U3Lgc5wFnAYg2HCf
	SaSUYEU9stb36/dloYElDE6hv4PuSfebW97+eOKXfbXIxHdP3P+UtPtle0wnmdUZ
	5a58rEYcQNRZG4YMXzvpLX6Zm0t7KIbsaLgNJ93LhtA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c0c8a47ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 10:34:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UFYQOw006743
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 10:34:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 10:34:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 10:34:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 10:34:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UFYFlR003671;
	Fri, 30 Jan 2026 10:34:18 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
Date: Fri, 30 Jan 2026 17:32:26 +0200
Message-ID: <20260130153227.213413-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=LPJrgZW9 c=1 sm=1 tr=0 ts=697ccf83 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=UCxzk7dh-OpefKUEql8A:9
X-Proofpoint-GUID: D683KpnuPYIjeE5HJOpEuwAy6JNfdl9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNiBTYWx0ZWRfXyISX7bXVz9kx
 /wkEYaBzQMlNjJT98+UgqrJrJBzvuSj/UPvcJRfeM+ud4l1nStpPMzgZwLhWw/M41iQ0zkBBFY/
 qGMXzNtZwkJ6QctoCuOEPha2OsBxMGSKePB6hyFSRlbHxVlxX6N+nmdXrPibWp7HM41ynDiswZQ
 OzEY8ePBAv/cmSQzOcWouVejBZsuaW+4/pQAgJV8h3gkA0viMQ2bKPkHXLDDw81QFnVSRwBhL3U
 wCicizZ0nZSZ7TGbXvhAq4xYpZxEPV4IGji+hYiXsxbY5G2wkEevdoEEKG3HNcL5RCdj00yLWG+
 55RFoXRAviyBggkpIaTZbcgreIDqQAsei/SCZ3clVlPk094k2URSg09d477zkdviNuP/7X2duGz
 xPB68qnwKOReCsTyydBdtB6HktaeNZ32w49afDKp4pc49sDGGrHutNejiBztXKEeDF0kH2ne0ae
 iDusqeCQhMQ4edVAxuw==
X-Proofpoint-ORIG-GUID: D683KpnuPYIjeE5HJOpEuwAy6JNfdl9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300126

Use pm_runtime_resume_and_get() in bypass_select() and return its
result directly. Unlike pm_runtime_get_sync(), it doesn't increment
the refcount on failure.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/gyro/mpu3050-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 092878f2c886..6549b22e643d 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -19,8 +19,7 @@ static int mpu3050_i2c_bypass_select(struct i2c_mux_core *mux, u32 chan_id)
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
 	/* Just power up the device, that is all that is needed */
-	pm_runtime_get_sync(mpu3050->dev);
-	return 0;
+	return pm_runtime_resume_and_get(mpu3050->dev);
 }
 
 static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
-- 
2.43.0

