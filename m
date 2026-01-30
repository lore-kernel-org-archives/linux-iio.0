Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A0364049;
	Fri, 30 Jan 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772684; cv=none; b=FeViAA8Ap1t5rld+fkW1PCkzgI25z9tLd4FkC8d5EX45wtUsCBKx2SWDEn6Md6HEZuIotPVKt5Usdt7pauVRFn9gQ6t+QPdJC1Ra9+WMqMljBxJSaQAjJaREwmvbAIDPeuA0IJz5s3TIBOPmKOtEyQqeef+tHseDfZjmE7uZg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772684; c=relaxed/simple;
	bh=/orU3OG733fTGyQiyMR1oxR5F3EKmRpGhrzW/6HH14E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUkayO3JacfGrDFLiK2qZXotjaJ4SwCY2+Aa8gpi1RdixTt7YNX/GbwyyeaCLX3r7RPFVii859TavMFdgc01vKvm2/Io71CNo4cHPQZtRbVOhDDALy/Qt8I5iZ7QN8NU5xs/CUwn5RYSu0GetMESC+smjnf65QKrLckowkQixuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y2SLL57D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y2SLL57D"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U6gBZU2946344;
	Fri, 30 Jan 2026 06:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=RHEYAC/dmnXDL+LRL025f7riW2d
	bxV2ZTtDfxF8C2ko=; b=Y2SLL57DW4zbU6vODVHbn9LFzksOOZXpbC60EA9S0dL
	oGXSzQL/IsyoEp0zJgCSIjIeS7RlL4E9o9OocUeaisvJFiwhs2rzgd4JITjp1CYU
	On3c2pm7BKceEXDQNT3/4x0i0SYqVPLf/XE52RtYbk1LTfppKdQ0bw+Lx4TqKacM
	LAfE64UE/LBqVsH7hmUJdnukNZQc7orfbzAcOrPVchyFfEXZkw8k49+wZB2uEd0C
	qEHlHHvHGVIg/O3KgL1qDgOdcfZo2tAhIYZlh4XAN6/DQYJqQX/0ZCDqqm4gxD20
	hBGh6ss3c04xQhmw8Ff9G158QVcFmokQkk86ZIC2gfw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c0c8a3deh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:31:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UBVEBK046233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 06:31:14 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 06:31:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Jan 2026 06:31:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 06:31:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UBV0Xf008160;
	Fri, 30 Jan 2026 06:31:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: light: bh1780: fix PM runtime leak on error path
Date: Fri, 30 Jan 2026 13:30:20 +0200
Message-ID: <20260130113041.50978-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=LPJrgZW9 c=1 sm=1 tr=0 ts=697c9683 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=Lr-ZVr02NuIHx6mKuE4A:9
X-Proofpoint-GUID: fM6EPvv5aB4rML6j0MUHsieysoAdsAH0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5MyBTYWx0ZWRfX41VTCn2HCCCf
 4JqMny7uT7f4/+0UEhoP0oCYVv0MYgsRl8PWBVrO+0wUHUe6Ugnqk43V9FFKP/wZo5hWVNx4nnH
 Tj85ap1R4heuY9EzvPFNLwYWPesWvlSUj2E8t0O+5i7q+IBeQjRvZQ9xDpCrX3dGXroUn9AkRfx
 vg/lRhPvseXIt6c+zeVkIZxSf8UTH0yGZDQLHsz9OyT7xDfahlNkAX/3Ib+3yNNOK1FksMk0BJ2
 4m24y6wS89+mgGwQVi72Ik0zbsrBYqniWxujcTm6nMIhx4dQjVtGsHiLtPOOR+UWnf+j4H+rAle
 clQn31hvzzU6KCC1wVkEzlgOwkUI9oJrgJTCPW2o+Q0eoKvN+11luB0qCuW5oV6zCirhnUGyWXP
 0qRZCYqmYN7qqpgiMzpx/Dz9YYAk8KgVpjc7UWPTZt4xHCehzaM3LGJT6SOpcjQRa1fnbfE4Czc
 J7FH6tmwjWTi+62HUOQ==
X-Proofpoint-ORIG-GUID: fM6EPvv5aB4rML6j0MUHsieysoAdsAH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300093

Move pm_runtime_put_autosuspend() before the error check to ensure
the PM runtime reference count is always decremented after
pm_runtime_get_sync(), regardless of whether the read operation
succeeds or fails.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/bh1780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 5d3c6d5276ba..a740d1f992a8 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -109,9 +109,9 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			pm_runtime_get_sync(&bh1780->client->dev);
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
+			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			if (value < 0)
 				return value;
-			pm_runtime_put_autosuspend(&bh1780->client->dev);
 			*val = value;
 
 			return IIO_VAL_INT;
-- 
2.43.0

