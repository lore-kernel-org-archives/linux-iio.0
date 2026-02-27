Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90E314A82;
	Fri, 27 Feb 2026 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194890; cv=none; b=Eqije7Qn/Om4mJuCGZNXIgIz/TP77GBgnRikhkAy3k+cxpZiK9zQSsfos5S6crmF2Y8hebli5vHqEUN753GGonQ3EQdr8+fMhTLKk2K6ExOOv3qrKuT0Gk+8y/EvA0XnSnQc3cdSPOjjSjA7NY7zMMzZYVosjG0KJ+zDosLtMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194890; c=relaxed/simple;
	bh=4M4QoEikVLllGcEPx73uc8xFYmfraEWHqCWTlgVC6pk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aCtxHX8tywt0hcgfNXDsER6fgGQvDrRKbb0WTzkm2eM5DbQM9kWa5rIj6Qlk1f+9euAJ6UBnNx6eQ1qJ9+T4Kqt+gbM1QSQFq8PJYJndfqhTA171ZhxwLolwawmPTg3SPEQR2M72VUckMuMXirKbn5WpqdkEuueDDFi2MIAcUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O8BLO/ze; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O8BLO/ze"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R6IusS1382467;
	Fri, 27 Feb 2026 07:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pl+i3l6LNyLAnEoQsQ1UvcXBCoN
	YK3hVK36FBNtExrg=; b=O8BLO/zes3oJf2PGjMWr/p0pZFnhQhgU/oks56n7Hy+
	yM4twGcIvYt+sMbGhIq4/hrpC53LosHBb9thv4B0US0hIjWH0cRv5te+Vh6DnBfq
	D7Wt6SkMZLEdcWU4UY/ktT20mAI4Ss2oyLercmH/4demx+2IioCfZ8vlypJUbB63
	8y2bAw5Uretkrd4tdNNZTQjJnR5059TEWv9Dr9u5Uw1sIXednKpbQ00+xcCYAIeo
	uSgdCoF+f3v+3Ee7GdJ3ni9wyMcQxkgDYtiPXf7dNKfn/Yq6yXAABs1U78JQx1Xr
	HXwwppzkGBLZMOp8fwmFSRU8HA+W5y6kEq6z+wek+lA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cja98qrb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 07:21:12 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RCLBBg053863
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 07:21:11 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 07:21:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 07:21:11 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RCL1Mr012698;
	Fri, 27 Feb 2026 07:21:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Robert Budai
	<robert.budai@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ramona Gradinariu <ramona.gradinariu@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter functions
Date: Fri, 27 Feb 2026 14:20:46 +0200
Message-ID: <20260227122046.46710-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEwNyBTYWx0ZWRfXz410KLKwnk8M
 zdbZxa4yj9kjFIly8Fzl/RPsyDW5NDt1RGFNmyQWnByjiSK5cFp+CW/FtHCNIatvSFquQw71fCd
 AnysSA4xI1MmRFd7K+NRdSsk5ACPkvAPo/fL8kJpq5SSQNd45SrGf8w1nAiCeRB5z0a8LjCQR8v
 ArtuUAkOnOAEHppP/BkR4Kv3TeisV5UqUzoULO5ivtq38UGR4uZdmxSnpmtYGJCQWPw1v4Tl6ot
 Ech3lWV2r6iII8WCi18aCipbSSPSVPtRYILmnOu4bttdFqv3vZ8JliutALJ7KDul3s6LIyiPsGp
 71b0fGopMFIBPh5qaJ+gX66T/y1aE6Y83D3QeF9DTuoGiqNeFcjltLDVbugkpW/FQswXyTLUoeR
 /uslFdT9OSEXJU4d/fT0O726dGPYTiQIM+7a40D+b2g4ZWcMDTPRgABjuS6frDPAgwtByBI1+Pd
 msJiESZjV9gZhIoxgIw==
X-Authority-Analysis: v=2.4 cv=a+A9NESF c=1 sm=1 tr=0 ts=69a18c38 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=QJip6Lzfc5DKhiJoJVsA:9
X-Proofpoint-ORIG-GUID: gmP9pdKTRRGAxZKvdhM5RZsahflJnirZ
X-Proofpoint-GUID: gmP9pdKTRRGAxZKvdhM5RZsahflJnirZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270107

The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
other's filter functions in both read_raw and write_raw. Swap them so
each channel type uses its correct filter accessor.

Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/imu/adis16550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 28f0dbd0226c..1f2af506f4bd 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -643,12 +643,12 @@ static int adis16550_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			ret = adis16550_get_accl_filter_freq(st, val);
+			ret = adis16550_get_gyro_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
 		case IIO_ACCEL:
-			ret = adis16550_get_gyro_filter_freq(st, val);
+			ret = adis16550_get_accl_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
@@ -681,9 +681,9 @@ static int adis16550_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			return adis16550_set_accl_filter_freq(st, val);
-		case IIO_ACCEL:
 			return adis16550_set_gyro_filter_freq(st, val);
+		case IIO_ACCEL:
+			return adis16550_set_accl_filter_freq(st, val);
 		default:
 			return -EINVAL;
 		}
-- 
2.43.0

