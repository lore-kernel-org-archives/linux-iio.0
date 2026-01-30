Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD01FC101;
	Fri, 30 Jan 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781143; cv=none; b=nBBPVQ1k+dpjTf76vObbd1K92QunZ5fXG4oU4ZW6OZyXFl55nilxsK4u46BVyPRC48fQ7nRsaMcvedfaeMxIdBW73P5wvXK7FcOLyKgfws3+ppy8+X1GacCZs/281zAme6qRQ+EhQBOABzyolDz5YEuO55Q6jluK+rJ3imGpLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781143; c=relaxed/simple;
	bh=NqZtXhNuLcK4esNVM3AUdN2mtn5jdz+gYZUdv/UujCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZcWj3vXZLipPUU4OvdrsX7pRqzgiPuKrU4fygD1jWoboA9f6tR/DVok/WE6nxi6BCJJ6fpMYErEPqyhgqx1RozTUc6iIlgGEDrOuM1ubJmA3vkgH2Xr6oBzwwNDReCzBRGCgN3Qq4JUjO+KhoqKOnonVGljwssi7vKLbn/ewgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y1z36DQf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y1z36DQf"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCmf9E3783141;
	Fri, 30 Jan 2026 08:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=htVtV+gfszWhRbxqS8vnuE8jI2m
	mCYCWJafPHujAB08=; b=Y1z36DQfrSFHZfPY8zAe+aq8nvdOC5CeJBHj/ZYktVR
	OcOhO4RqFiOggAG7oZnEwcnhV3tZZTEjeP3YDlT5weGrvRQT/66tRtU4QY/SBhbF
	WxDzJkCV0zL6NCDvecLvX67/n3alxolY6YJK3O8Nna2DKHwfhfXsuQvGdTcjCoF3
	e0eq/EBvL/Ltn7j07rOkjLZJS4iWeHKUHHAPnBXRSzybLyKOmwwjmHHxNXEmRxX8
	euiLDdPMUmbq805SQr7qlbqxRCvJybTfSGa7c+SaMgjYgyUwtQzBzeFQ168WClJQ
	R9t25T5TzM5GcVpgryLjBCiI+BFIbxFLwWLpQrCdP2A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bpgwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 08:52:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60UDq5oB060985
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Jan 2026 08:52:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Jan
 2026 08:52:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Jan 2026 08:52:05 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60UDpobw030904;
	Fri, 30 Jan 2026 08:51:52 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Nicolas Ferre
	<nicolas.ferre@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: at91_adc: return proper error code from at91_ts_sample()
Date: Fri, 30 Jan 2026 15:51:22 +0200
Message-ID: <20260130135126.136861-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697cb786 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=jKp_zFM9SaRc-WSlGVUA:9
X-Proofpoint-GUID: SQi6aPJGQlGkv1BV_BBdqCFs8RCGUfo2
X-Proofpoint-ORIG-GUID: SQi6aPJGQlGkv1BV_BBdqCFs8RCGUfo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExMyBTYWx0ZWRfX3qu90cEdYTjm
 ZcfS3bl/zWomni0bYijCrDlTethAMaWA+ZPGSnK3iK7XHcUdzV0QfJv7TQKszWMew8CI3sNJeWb
 vpgjW2Hjgbqwlygq3rRpt+xkQ6rjKHsyeFbFkidamJeP82hgPhjAjzwItcl12ky042378ywHHUL
 fXsoov7cpkGTY+1B2ifx7PxrsU62iiH3iuN2xDq3VhqgliT3/lOSgI/n7m6ml4pphieNDM31AvU
 HvarQs5WfTffH+cPFW84Wd9qIL0tLgnL3gNlCIcgwiQ4nm/Zss36Zni5KgKAe74lwutPRQqrrh7
 QGr+R6MeZSiNQ0Vg+R2kks+Gkp/KRdzKOyXpYhZC6soPnu2ua6cGHm64JuhFKBRy8S6JijpnX4X
 VqiXRCgQ+I6vkr2MYhK8rXTi457LG3y7JBEsew3j75BED4BS4dTRr4OO5gZCr3lduEf+TqM33u1
 zx7JRiGvh/N/XoRZBpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300113

Return -EIO instead of -1 when xscale or yscale read from hardware
registers is zero. Using -EIO since this indicates unexpected data
from the hardware rather than an invalid argument.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 920dd9ffd27a..5e8719d5ac01 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -323,7 +323,7 @@ static int at91_ts_sample(struct iio_dev *idev)
 	xscale = (reg >> 16) & xyz_mask;
 	if (xscale == 0) {
 		dev_err(&idev->dev, "Error: xscale == 0!\n");
-		return -1;
+		return -EIO;
 	}
 	x /= xscale;
 
@@ -334,7 +334,7 @@ static int at91_ts_sample(struct iio_dev *idev)
 	yscale = (reg >> 16) & xyz_mask;
 	if (yscale == 0) {
 		dev_err(&idev->dev, "Error: yscale == 0!\n");
-		return -1;
+		return -EIO;
 	}
 	y /= yscale;
 
-- 
2.43.0

