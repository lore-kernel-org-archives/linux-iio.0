Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4B372B48;
	Mon,  9 Feb 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638577; cv=none; b=kbCyvNsbqa/oqNjt0yqc8rHIsk7ZpHJMjcayNNtIdCgz9/kjvqvtLETQ2NhATsMPu5+1fm2RKrdhD22sQc3+zn142h10YPJD+JMLB4d2At7UsgJwKgS+doqPimIRebNW2DF8imdeorZ48cSVm0rOS8sKTPkvRUTkz+ZK9qrNkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638577; c=relaxed/simple;
	bh=4aNs98Jp71NtBwp/T2Tf6YPGntaAyyhSJyLvScK1roY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdHZLP8xddmGfyc9I3InX6nIfdFLE5MEIWt3Gc2HUSs1rbIU7tyCDFWyMKCDyW21ZpvObP+Ukqb+7IKQvmIwX49S+lYc97iHCmpmHrFEeumvcoc7P514ok6ZJ2KvoPoMJYV0DPoHwvoMGcfiuAdTWn9drCBvjFfrMsAM55fXY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aXqVec3/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aXqVec3/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619A9Jel3275710;
	Mon, 9 Feb 2026 07:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CC/bi
	MVNCfHMVUoSIwpkTUyo3+XNVPBXTOUwQ7BAXR4=; b=aXqVec3/E6jBJ8JMSC+LN
	VeI7iQ51xOGOmeP843uHdXJNAFrbiIi4nuI6s8EhvbXuOQwEwCagZJddD8Yi2nYX
	5ZXYeBDznLhKEix16y7+5oNwRplXLGSkbC/whaotghiM4XiPMquV3UEXE3w02cwb
	K+7EifAT80SFlePsDFVHY3pUoOd3x16UNbBVztHRyOOatRrLpUbOZjxcUvSu1kBb
	25TFofIXODo9hvtW0E9N94WXqGOBthgilOjpD997RzZRKURTaTA2hSFBN+L14faK
	DqO5Pogc20/JdmUiAicfVr4zH6BNp803FL5P/vC9IzFgNw7vqHanESMUeyCRKUYI
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6042pxn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 07:02:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 619C2nUS041204
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Feb 2026 07:02:49 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Feb 2026 07:02:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Feb 2026 07:02:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Feb 2026 07:02:48 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 619C2aTd001481;
	Mon, 9 Feb 2026 07:02:42 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/2] iio: gyro: mpu3050-i2c: fix pm_runtime error handling
Date: Mon, 9 Feb 2026 14:02:15 +0200
Message-ID: <7d7f0ddbf4b52e1522fbec24b4909d20af9a447a.1770636034.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770636034.git.antoniu.miclaus@analog.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 81h4iAXpV3R_ik_QzMr32eIfEVMgt0Ig
X-Authority-Analysis: v=2.4 cv=ENILElZC c=1 sm=1 tr=0 ts=6989ccea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=pDhQm6m3o-9xxzphXXkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwMSBTYWx0ZWRfX7TVrtuNQ750D
 Th3B7BJ/JpQL+2VWQEXTcYyttKav1Rohc5oVgShlni3TtB7maD+czD3L3qG3PZsHt7ib6+MtEe+
 OcvC4jPBGI4C+sbv17ny1G5nmt9oboKuIQTQdDYrfinOStvBZjKDjrxLpSByf45Oq9fVD8Co0mQ
 62djkPzBlcEYJoqFLWAmycmrmaLETptGnKEpCW4uh6dErkxh5if29EtDgWy0Fts8N9xS7lEsWKr
 l3Te7/Ze2Bq/SRQox31pO6Wfy/qjGFHTtrk+zpmdVCv+tPAuVPHz1X2jZrb+UksKwfLQRhwPh73
 1UYCAu8/oD3LY4xYN3tsj3E62WvtfWCEhfP7JYl8tuWsTynAP6vqS9NtIQoyZhSbay/W60QhmmB
 wrnrPa3qAuj9dBA+KRNpcrYm+Jwp+xn2MZJEcFucgxF36FpitCXRFt+ksCrk+ffbwTFYaK0Y9nL
 ie9Gj9ixjs/AzF2nhFw==
X-Proofpoint-GUID: 81h4iAXpV3R_ik_QzMr32eIfEVMgt0Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090101

pm_runtime_get_sync() does not check its return value, and the
function always returns success. This allows I2C mux operations to
proceed even when the device fails to resume.

Use pm_runtime_resume_and_get() and propagate its return value to
properly handle resume failures.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
- Rename patch to focus on fix rather than API change
- Reword commit message
- Add Fixes: tag
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

