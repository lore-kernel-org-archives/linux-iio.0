Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D502F39C2;
	Mon, 16 Feb 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235899; cv=none; b=EbhUVxe56uakgCZzTId2zYnQAz8+ixKV5YQB6troT6/P6HZcbFAL3F/5XF+iDTRgOzA1giWdzgKUjDgyXzslGSF++yehx4h6vje/d4hRI4WUIPrYe9TCncxsLsNs218ETdQ82g7GYvTBCbkbe/AosgKZb8RWwisIkW80SizqpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235899; c=relaxed/simple;
	bh=m2xdO1VEKLyz+5HJyoTZqSFCdJfQqbFkWxgDhOFH4RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al4oBUvnDBX1i4b3F0O7nLYD/POlypyUzmwGpcJAWyOZ9TAXiT6xOGhCPlRdjRfbeQ73WKPtGqnWIh7d1oOSMHJeySGOe7WnscrPdXnXeg0sXopyTLlkxqCyqs7kWcM+dJxuyXj+gARP3eNEt3LydfPzaM4hTIDLV/3Gzyn3O1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Yp7gdMJx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Yp7gdMJx"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G8QvwR3758382;
	Mon, 16 Feb 2026 04:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JQd3w
	NEaV+z8my1ewW1gKu4j1Xd6gZJxNxdUMe5wC+A=; b=Yp7gdMJx2vMDaO8I98RjF
	6CstWV0Q+t3Fd4ehR3PfasiKsnCyE7sniX6z8VFJzy5b1c+bhJp4d/woy/FkKlTv
	AVNmYZOpuIhmjAwwvFJFIHUrMv8pJcuFncARBmOt99p5/I0v4RtXsgAkBOwVr5ZM
	R6lteI6hiS4mEG2vhiaxwdLxD79aLhGi7V1bypXqFV52AIh2A63qD7xXB24wkiXO
	gNuEfAMqdXr6JeUfRZc6R0iHlm9VFjYBOA/C00Af3yEEVxzxtvEljX6DwFiasv3L
	ZrhRIE6SI343qR7WguKriMRGCFgHLVf9rIwUCAJo6jvBlDvkhY4MEKIO04pkeFjC
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4edn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 04:58:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61G9wDnf045731
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 04:58:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 04:58:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 04:58:13 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61G9vwKd017405;
	Mon, 16 Feb 2026 04:58:05 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/2] iio: gyro: mpu3050-core: fix pm_runtime error handling
Date: Mon, 16 Feb 2026 11:57:56 +0200
Message-ID: <ec7d6fc505ed578d2f4224e14a86201becad07b6.1771233915.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771233915.git.antoniu.miclaus@analog.com>
References: <cover.1771233915.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MyBTYWx0ZWRfX1jb15EShM0t+
 u4zMMgj8ABPIOpY7/6OqbJIgcSyhrr/XQvn3P8qL/kxmLBc+4uhGC1mrG4idQz8G/NmYYhoqW2q
 cxXALO5avHe3bobHRGu6QseJfjK3UH54oCnZgVm2DfKXqUDTuWM/3fnXBSReohV3zneH0ZlOABc
 Rknzu2qQdfpPm0RoJA4oeXeeqYVN8/uvCKlamZWNu5834cV2yuWTXv7Y9aD2xTzwK9n3ewbB20q
 qjJ9BeVJxs6t9uVEh5jZDriPNgJ3+67hUiV2P9Iv1vQGUHdz1W1ajk/cfuZb5LVhIf0c8RsB2ti
 u5jO+VAVIsmfENAs1wBQJpgN9wVgBc8ykvwIBr3ue4FHcDuuSru7n7cBqaFGpwLDMS0PM6vajHN
 KUXFmGP4UboSD7K+JOaRMYAX2I3Huz+HkXBfjSyy7uw/VHeDGqzRTeYKwajf/cY4v3OLulorAoP
 8COfekC/hyDyCbXfnjw==
X-Proofpoint-ORIG-GUID: rJgqsa1fSgTwvCiRo6SD8szEfXpztDZc
X-Proofpoint-GUID: rJgqsa1fSgTwvCiRo6SD8szEfXpztDZc
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=6992ea36 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=Wf9GkAJNdAa6ZYPL-EsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160083

The return value of pm_runtime_get_sync() is not checked, allowing
the driver to access hardware that may fail to resume. The device
usage count is also unconditionally incremented. Use
pm_runtime_resume_and_get() which propagates errors and avoids
incrementing the usage count on failure.

In preenable, add pm_runtime_put_autosuspend() on set_8khz_samplerate()
failure since postdisable does not run when preenable fails.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
- Reword commit message
- Simplify preenable by collapsing the trailing return statements

 drivers/iio/gyro/mpu3050-core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ee2fcd20545d..317e7b217ec6 100644
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
@@ -647,14 +649,20 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
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
+	}
 
-	return 0;
+	return ret;
 }
 
 static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
-- 
2.43.0

