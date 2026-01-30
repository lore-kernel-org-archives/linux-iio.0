Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4D330D22;
	Fri, 30 Jan 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787279; cv=none; b=gd94pyCkadarzpEgQjlnBliKnEhtu3A8iVfOYFwzIZmqEYZXEVcK5lf4U4ckkQUKjxIKotUSHmSPri8ZGbVjYvS1cRhR7TvXnIrezB5x2P+yWJIg9IpfuYZLRJohqJzqxRvNQeX0gdQiOzVV6npWHuItPhn02BQJ8sZ17n3WS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787279; c=relaxed/simple;
	bh=ANb3Umk1/2O6XsXSJeDnRbmMtgmhN8kYMgN+ExwLbmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd0LdcAi0sS/gycjjjXZJOwasxgaa7VQrIs36ZjlRH/8fT8DSYdSxgv7+SH8GILMGEH/NxxzVaEDWU4Vo/DUu5h5cYKgmbkb/toE0mEQ78bglwT7xzVniweZgXGRkrzhs5yfu2YLgDBGX+csTiYWk88DffQ/VGeiuNhTRo7qF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lIAQ2OfN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lIAQ2OfN"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UEAr84009025;
	Fri, 30 Jan 2026 10:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y1Q7R
	tr1HlMLakfOTHlqHUG1vin0ooUqTvaEfK1SF6Q=; b=lIAQ2OfNjxORAslXP7uvC
	14iPzRQurQfiCBGq+z8DuPR2+DHsoYIGhqgAnOU/ZLwGhZIiuXbMq3A9sns1KB40
	rvldJnqNhFUZRL5cRdTu6PNBJp8zTVemfBuJNURmE4/iG+BpqyRsxK47gbgP+KNZ
	Wa2GKaDbq01FBa9tMhtG2kTpzY9oCKTwZ4TOMBkHuKzpHZNU/awABQKuKNnMF8Jj
	rvcwkh7/M12D5lp6z7mpXVuzQAVrub744WOVRLJECz9XkPUfNeJUEMdDVbf7AUEC
	xcW7XZh/XekgZdD1PeBEmGrGNFB0x//JKtqpkt94rtr0ccr9dLvI5vaoHnauTrxe
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08sud9kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 10:34:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UFYRWM006749
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 10:34:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Jan
 2026 10:34:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 10:34:27 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UFYFlS003671;
	Fri, 30 Jan 2026 10:34:21 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: gyro: mpu3050-core: use pm_runtime_resume_and_get()
Date: Fri, 30 Jan 2026 17:32:27 +0200
Message-ID: <20260130153227.213413-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130153227.213413-1-antoniu.miclaus@analog.com>
References: <20260130153227.213413-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: i3npikOMIgO_da64C_ASmXaV7faexes1
X-Proofpoint-GUID: i3npikOMIgO_da64C_ASmXaV7faexes1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNiBTYWx0ZWRfX8f225s4swfUh
 rdEHL8oQIxVLCAKpn9HLJG46I0TSnyl5x1BymfSmw8MG3PNlnnrNH/oA/l64k+tAxzSOn+Wq5aI
 K51BK2k38exgZ4T0bLBUZo8tEeREL/G6pI47QxOJ8vRpyv8RJmAnlgUtIoQyO1rSUZCYMNtz2bz
 Sag082DB8YC5xz3g5COSOC6CNRzH3/Gq+nQT/WQ0oceAWnGWEy3ppgGtFb/xzM9xeDfgYBXiKco
 vANWj0F2OvgUZsd/HA/c7YU4Z4tc8sj5vLV2X3iLj+AksLoBrjk/JE6yF7/19hfWwgIY0mVBz6F
 XCxwG850TlXbnxLdZNEEgeaw9dlrVaBJm8oHBP+dhweIpWz9oi3Ll7ZIxRtW0cNf60yPyIImuhc
 BXMyyu0ub2A/ARoT/ZwNE5Ovn4ICy+BFCZNim0bu3+kKnGUmulmEiqAcseccN8jwz1hqmcpi1ne
 +7rHaau0plTdd+5h6cQ==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697ccf84 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1nRI0XoE8ny3qFPSncEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300126

Use pm_runtime_resume_and_get() in mpu3050_read_raw() and
mpu3050_buffer_preenable(), adding proper error handling. In
preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
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

