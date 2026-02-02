Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADB376492;
	Mon,  2 Feb 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044221; cv=none; b=FDsVkTo/8QXkiPrUIzT/GfiTANX9X7z5zck5mgmvh0bkPXXjWoL1BeMpJDN0gD77Uc048gB4I+v3EhknUIvRX9oRGiqqTMLHl1evdzvLYx2ezsJA68reHtd4005/lswpC6QXwIo8cM8kY4KBGjxFSShfDAXSli8sCVePTmkcxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044221; c=relaxed/simple;
	bh=cZz8Ot17PXe0YeUW0pwrPMVgKRLBu2pDbpGZY/1hH3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Plcq/AfbPFoqn231J/w8ixjD8Z+6G0hjtdHPCKgNzJ/kmv35+TuOYDsKfNo61zan+kcds99Ux+ffVy+gV++aLUEizTxkmG6xDaEfhOtPpfU7oAjkkc8mQhq5rlaXyu3CUoSdl1ObUBkKb3jcSEaR1qYRjW5ug7CE+sWX7AlItbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=udb6UpVj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="udb6UpVj"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612EsPPZ002476;
	Mon, 2 Feb 2026 09:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/ZyTC
	aCgqzzFLYg4bTSS1FJOng2GEYap70cm9SAZ+HA=; b=udb6UpVjrSJo7YgrTZNAR
	Akfg5uXvj5UGy3oCbQfL3MBPi96jGb4Xy7omtUkcAi+eHXr+cKXbVncbAYwmGXRO
	412o03HuEo1paDIAI6hrYjDRumWFTNraulFBX3YcSaNobkRyQlieyxuuvyWsRlEA
	hXs2OQPz860Oz/1tQVzW6RY8za0PPwClMUGOxRjQPkOwe4nVuQVHgV/Ys9Mq91tj
	ZKrzy+exC6FtyW/VTSmu2PPkk5z1g1P/WBINpztYvJCNMr1FPPVgEVpLPUPh2A0Q
	uc14Xhl7R+BQGnicltuh7pFVbZwEQCi2nLgsTbYbE5cv0TmlobGtVpHRZNKERrlQ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8vuckg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 09:56:45 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612EuiE6007142
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 09:56:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 09:56:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 09:56:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 09:56:43 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612EuT8v030448;
	Mon, 2 Feb 2026 09:56:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/2] iio: gyro: mpu3050-core: use pm_runtime_resume_and_get()
Date: Mon, 2 Feb 2026 16:56:27 +0200
Message-ID: <3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770039759.git.antoniu.miclaus@analog.com>
References: <cover.1770039759.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfX1yW6ghcsCqVn
 rfrHXPRbMV3CzRABulqOJit9xkCmlI24LKjjVfu7vnQkvaDYhfcZlMvPSvwG1ZO8s3zq8DgCIIe
 TELCF5QaeUW3ns6f3lqxyLJ+GKEYkHF8D/jIAYZqhXRLlWtgIm2oWJRLnOKhAw6jm+R8TQ3oVnM
 RVLe4oUsxooopBcFgfe/WovzZ5v6yrD+MbyPtCqbo3W6USvTQziEl7QoNsX0D+oQhrI8re0n+Vz
 DuTBHyl3tmPz78ZhWbCUXNpfYog/cj6K8O9VRwgyjudSIlMc5nGgcwXWrj9hQlXFb8uGZaD8WBm
 NUsnjDzBewA/XblTSjU/wAE9N43o7peB2zLfPdkDRiHvVK9nrlt9oyEjLCUEkG/gvitEKOVPdQp
 gGCY5pXoDY3Kz520vvFLG+g8OoY/lJKmt9YeAl9vS/8DCrGebwvg/HQ3TdPwdiJx2Vn7kUTvo3o
 KcYlPrXEt/aPPfYy/ZA==
X-Proofpoint-ORIG-GUID: ApkY0jtJJuldxzIK8mHZ8pPZWEuue9xW
X-Authority-Analysis: v=2.4 cv=QptTHFyd c=1 sm=1 tr=0 ts=6980bb2d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=B_UmCIpZy9mFkB8-czMA:9
X-Proofpoint-GUID: ApkY0jtJJuldxzIK8mHZ8pPZWEuue9xW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020117

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
mpu3050_read_raw() and mpu3050_buffer_preenable(). Unlike
pm_runtime_get_sync(), the usage count is not incremented on error.

In preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
fails since postdisable won't be called on preenable failure.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ee2fcd20545d..1cc421eb4782 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -322,7 +322,9 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_RAW:
 		/* Resume device */
-		pm_runtime_get_sync(mpu3050->dev);
+		ret = pm_runtime_resume_and_get(mpu3050->dev);
+		if (ret)
+			return ret;
 		mutex_lock(&mpu3050->lock);
 
 		ret = mpu3050_set_8khz_samplerate(mpu3050);
@@ -647,12 +649,19 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 static int mpu3050_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(mpu3050->dev);
+	ret = pm_runtime_resume_and_get(mpu3050->dev);
+	if (ret)
+		return ret;
 
 	/* Unless we have OUR trigger active, run at full speed */
-	if (!mpu3050->hw_irq_trigger)
-		return mpu3050_set_8khz_samplerate(mpu3050);
+	if (!mpu3050->hw_irq_trigger) {
+		ret = mpu3050_set_8khz_samplerate(mpu3050);
+		if (ret)
+			pm_runtime_put_autosuspend(mpu3050->dev);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0

