Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AC37474E;
	Mon,  2 Feb 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044219; cv=none; b=Y9XOUtzFFtfPdK5cQJ7c0sm0sb5uw4w+2zQ9WY2lcs/XgyD8lOUtHIL0HpuckW71pcYXztul+5jHj63zWGuyXL6cZ1cRTCWyt0y3x26eBlJgshNrAuVd6ZSt+q/mDsw7t1qLTzRX2bAid5gWoi3a2/cE2UqAg4pdLzPWOTrNrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044219; c=relaxed/simple;
	bh=0Nj9KsqB2IKG51QkdA0MYXPLYPSw220AjBbWtV6C+OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhFlgIMhRafL/uplWW0/CxEseyuGNWpqAIVJO/6jzLpyFY2Ri/igrQlm4FdEsuISkfCGl1oDzkXF/2ihFBX783qyBURMbwmRhuvZ9tayE1kV7IF/SeS6vaqoxVF5nN27sExJi8Kej6/rIylY+oT8A944q3BPiNfSe7h+wpvJel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v8LFCmBR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v8LFCmBR"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AVMPN2221316;
	Mon, 2 Feb 2026 09:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tPZ0Q
	CrO1yw7AOEFdck5HV5uLnlajHoeLEePIm/QUio=; b=v8LFCmBR3Py5SOG8/pLcl
	oKt59zE6Te8fcsfw1Y7ciLgN3MVehAh5OagG4xPZhduvwzM2e4OVTHe5QRqGl1TO
	cf9iSFSjriATkL77vohm2V28TFhQywvcTNW9+g3i92DdOaEQZ5sqV6h+cM8fp7id
	dUMZxkQ52l/flarfKeabxXutzALxEmQUkbr/Lk+hkiQgdvtpDILxEu811V8SO/3W
	AlF4LWyFSi39YtVNRVZIcmPZlziWan30kOIPt9psSmEnqJYBzLRsCg+1ANn2/9II
	s4qDspOc3+7K40e8ns9Oq158Gwwumz2Lo8v5fhznmn0PCK3RbCWiO47ofRhAOc+x
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgmagq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 09:56:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612Eug71007139
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 09:56:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 09:56:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 09:56:41 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612EuT8u030448;
	Mon, 2 Feb 2026 09:56:37 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/2] iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
Date: Mon, 2 Feb 2026 16:56:26 +0200
Message-ID: <efd9d9c1e3e5b50ed01986a950a1960687274026.1770039759.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=6980bb2b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=UCxzk7dh-OpefKUEql8A:9
X-Proofpoint-GUID: 1aDN3qFhQ4pqZRwrTZOghN6mkzNKRQDm
X-Proofpoint-ORIG-GUID: 1aDN3qFhQ4pqZRwrTZOghN6mkzNKRQDm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfX/s54r5oRtdBT
 4UrAB7TgCaVtJZg5RqP0FZskrfag+jjCTYcKX2zBCJvrBmE0n6VSDlXxXq7zvXWsu0ouAURBt4A
 sM5a2Dva6zWh96G0xyfSrgCR3JJkXI7gpbaD0CEgdyQQyWxrUw56oReWG3LR/WXTUuhLWOJvxRl
 jmUXiOkZxWZnfvf7ditfzihagMOKTxqQfMmmNrw8YjCVhXGxHfb7cGfneTA+Ypgjh/98/VeFXnj
 Gl8GUbYhyCfyYMBo1dTWmfK2XsPWsLIeoo3k0fElFHKzwEcdtlvLatZfifkAYFAcB3JHl/O2ddx
 x2jdgR/Plbz5qMikbCfAkKmvT91n0+G47Y/F8WuCBHfUg8YFfw4yf2Di3aVuvf5HcwJG59nhZkk
 qhMkIJLrsU9BuYp+B+hHo3vWBNX9+Hls60dlIqSQwKy7Tow8oal4OPhox2I42vBlfKvRpiwutQy
 3zKFscgaBuBwqogRyXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020117

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
bypass_select() and return its result directly. Unlike
pm_runtime_get_sync(), the usage count is not incremented on error.

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

