Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B372B48;
	Mon,  9 Feb 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638580; cv=none; b=SSG9HfCjUksmSfb3HAHGDVGamvZjrcz1NvVtOAvpZl3rqKXSEmKlKUN7KugMsSFlnm07lnkB20Tqwq8QblnrN1pu1UsbAI77QUD2OUJEv9GYPJbim5yJtBAlhbJgKN8q/QQjEmKuc6ooNr9PYgkvqk6PvZLXTO/nNdnmqmiSOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638580; c=relaxed/simple;
	bh=/q09s4465rXQf3ol4HkoHVjPrlnmDB/Z3p44EqSKyEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUaFlPfZovC6A+tuDsoyoK18osfqpKLJrchVc1EOu0htfg4xsEwCyVZtGrXDNQFq/WPFDh8/aozVFCT7KHRc/+FhnuJuqhAkerhNKTnqEqNbyPKOg3YVhXul5n9d7Rt6KXpW2FaEgv1MnFFfcr+rHjqvSiaDAT3SbRgjL8gJDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iiKSIeXg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iiKSIeXg"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619AXctT638889;
	Mon, 9 Feb 2026 07:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3A0/E
	jzNwfuWELsT++ZlYO334+xE+C7UQorE8H3lsHE=; b=iiKSIeXg68G+BRxtV4cnZ
	K+uuON1BxWijJMWP95rDgue6VnC5+ZOM2EAiRzd/tLSBxF6e2Y1m/8psUEYZiTbg
	nYxMMXXtDVPkfJXWp4nr+/I+XR94SJH0JVnO2p7biUbM2LSPEZAJLxR9iBEGgxLC
	GOVRVnfgy7QHSW8RT/yNHcMLe/PS1xZyBJ4dEXca35GDwStrhLO+YGANdnWAQJeS
	4N/UPfdclAaGA149iTIUcJv1M/pyfeO6dYYxAfiU2WILWWAd2ctuwgDS4kWy+kKv
	6AKT5GkeQwKSajK6pjOBL+thOyP1YMVpbSyzXkXaW/g1lpo4bacq+ikJZucMcvCG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c6qkgkxyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 07:02:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 619C2ojq041207
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Feb 2026 07:02:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Feb
 2026 07:02:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Feb 2026 07:02:50 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 619C2aTe001481;
	Mon, 9 Feb 2026 07:02:44 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/2] iio: gyro: mpu3050-core: fix pm_runtime error handling
Date: Mon, 9 Feb 2026 14:02:16 +0200
Message-ID: <0309164453650011ec4d72276c8386edf1bbb88d.1770636034.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEwMSBTYWx0ZWRfX+J7HfpimiCNW
 6xokJ5tyZj1kqDFe3JYmeKIzG9xd9FGqagei0RIvI1ZwXdhT3SkFFHhYCv6AT+H3DcAjghf1iQG
 yATasl6HXSMqr06G5FnV+oCI9I6NmxX63yrBpK1VdGXyVSOMzB29EupScW6WMSDO94oh6vLUAa2
 rM/X1uenxq9uSatU6uRei+VfjfaRv8IJ5EGXDmS+9X3fE9gYgeGiKvzm1RORtk0TznL6rbVlTGy
 mhi+CVNf9Kb7EloIFqEHdm9slEInmv2F2RS7veAa1vRra0wohErwtPiaNVbsTyjTq6pq9SfIxsy
 ZBXTjVlBSqKXLXMxN6sSuaojlBXN0vcctr8eUvQpbyx65pbOGIGwPDCK7s0QZ694LCJfS+7u9m8
 dbcGcNPnMNG7A+lrMqZ4g/o0iZ7Brj8QFn01bMIXDrSNho06XiE2xSTZujTNznvxjp3PkXjgPHj
 kPBkHdY5enfNGLcClJA==
X-Authority-Analysis: v=2.4 cv=GfMaXAXL c=1 sm=1 tr=0 ts=6989cceb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=fZHtz6r67ZLlzgsKBeEA:9
X-Proofpoint-GUID: FHroiRrwlQcNCC3YrwqGl_4pMubOYdWc
X-Proofpoint-ORIG-GUID: FHroiRrwlQcNCC3YrwqGl_4pMubOYdWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090101

pm_runtime_get_sync() does not check its return value, allowing the
driver to access hardware that may fail to resume. Use
pm_runtime_resume_and_get() which propagates errors and avoids
incrementing the usage count on failure.

In preenable, add pm_runtime_put_autosuspend() on set_8khz_samplerate()
failure since postdisable does not run when preenable fails.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
- Rename patch to focus on fix rather than API change
- Reword commit message
- Add Fixes: tag

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

