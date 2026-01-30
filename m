Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82F2DEA70;
	Fri, 30 Jan 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781187; cv=none; b=lbNewetcNm5ah/DdedcwW3QmHc4l87Z2HWvBQs5cGCvdig5ohlZR+ymP1ohT5atmbA+fgnPWvmOyRIySxNaCYdZNZ2r5etzzSn+mXV4sEc2Iu4iWLCNDfv0+cuz2TG1InskjH3ibtLYHWu65mBY2A6s3B8MKeyEUukhPXsRe+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781187; c=relaxed/simple;
	bh=pJaxOz4lf3EntM8QQKM4vejB0GkndqQiyDz2MWvs3IE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kkm2teCZdaAJYsGXrBMrwCtg7bqNAADK4ouJIL6dIj+b6JuRQYCVt1PUtgWQvkq49Rds4tHTHhBrnCKLUwfTNOD8xKkmAMmLPwvn45aomOYU43eNEjUWc4Ge7JJugiwd/o7FOIvHLcE/gC73jGL/xF6t+rMTLpPXCAQd/+TXtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LrX3E8KW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LrX3E8KW"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCEE8s3783271;
	Fri, 30 Jan 2026 08:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=d3Gt1w3OuLYsBCywg9I97uEGs3I
	UBvH/8NQWvSzaD3c=; b=LrX3E8KWxfuKhGmJ0GrvxXIZ+hdcGry6GxT5DcaDezR
	zLX4GCPxuDz7e62od+zykFOcM0GMggmL9HkVXrhy4lAU9+Q+8UgjXGAhwGqJyi9P
	Zz+RbXIH58bPbakyLEjz0yB7i6rxCtUjO6h6Z8xOoJw8IFvRjOFAyHwRuiRR55LW
	+u3+lgIQNrw2pTob3C4MFwtpWsOExN/G01v1wthMDAFpu//kSr61Pt4Y5WKK0XS7
	ZYwD9BTbwc+eSitRV2bOdKoFn8z8uMQGhS5AnAFPNB7q+bZLz07CghI8ytbDXznh
	DuDB8EdtUJyMZ7VOfbGZyInOCL9lp85IGPcoAQJEhXw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bpgy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 08:52:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UDqug8061057
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 08:52:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Jan
 2026 08:52:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 08:52:56 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UDqiQn030917;
	Fri, 30 Jan 2026 08:52:46 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Waqar Hameed <waqar.hameed@axis.com>,
        chuguangqing <chuguangqing@inspur.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: light: ltr501: return proper error code from ltr501_get_gain_index()
Date: Fri, 30 Jan 2026 15:52:38 +0200
Message-ID: <20260130135241.137353-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697cb7ba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=vKmvfb8VVfuddhqaccoA:9
X-Proofpoint-GUID: AcNulTTbxq8fQzZH0nXoz_3RvoIgki_X
X-Proofpoint-ORIG-GUID: AcNulTTbxq8fQzZH0nXoz_3RvoIgki_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExMyBTYWx0ZWRfX9J5fQhWl8s61
 2MSnhCcoIzi7lPiivinn5cCOVbGU95Vl7ConYgsWeuvxXu437hWQIp57Dl0lGx5Pt3YSRuMprX1
 eu5YGlztH9jTMo7gUSyUYwasO+rtsYmDivimk6uAPCrI/ysrzpJkn4aFt/UIK85/VgSpruPHeVq
 WVlrYGzycJus/vTmJj27dqHpHd8Dgoe+KS1lCueU++SvK19St1SwsPoq+1YxVOmcQyZE5W+yAhI
 W/6c2Xijk+b5+qSAGN+ZxnZPU1yCGkZcejfZHEoVQUeb1J8mlqE5MlEaZaEvHe7yJxGNFT3GHWs
 QrzbMxyu1Lo4AuM2xBPhaz++uwLk4UIkv1FXore2cuzK91APOO6//OYT83vuGCaKV69uvUcfy9s
 Wa8z7X/ZI5DEJF7M+aQ4Hlr9Y7Pv4ARdx+oCcLBYwBl7rNcEmb04V/15NUieaxc0Bw/BqkRsKtb
 C7+qjPocrfc9VpBMkwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300113

Return -EINVAL instead of -1 when no matching gain value is found
in the gain table. Using standard kernel error codes ensures
consistency and proper error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 022e0693983b..29e93986dea6 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -754,7 +754,7 @@ static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
 		if (val == gain[i].scale && val2 == gain[i].uscale)
 			return i;
 
-	return -1;
+	return -EINVAL;
 }
 
 static int __ltr501_write_raw(struct iio_dev *indio_dev,
-- 
2.43.0

