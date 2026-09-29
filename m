Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF83E00A0;
	Tue, 29 Sep 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721797; cv=none; b=bos1u4Oj3Hav+LXvEz91nMUN1unesZOp9TLpA617zjSkp6raAm8xF+ea6+NH/fx7DgQIoi+PuwYZtdszBjbDykVylO7jNnhSIjRkwK0wWwc8uinDoUU2AflS8JpTQdeLB8keg+INp3a8iv4mv9VxouCrXnX8et36LGODhEG6Ij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721797; c=relaxed/simple;
	bh=4R00wTQ96YDP1y3kkYM553WuJfnVbGJUlkCOhcdhKEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7RAA3Y/Iv/22UVbMmFT2a3nPgbr/l3pwpp3Um0rvZnpyKrVAef9lEnjyPcWGXdrff4bBlhfUwGRJ2MT1ZFVoKS3NA2Zh8zdLnEJrRSQYl1yrIguW5N2dTxfuOLwdiyrSitzMxYAFWksMIpT/6LmqnbpcEBUnZGYs364jG4g1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q211xtVh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q211xtVh"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TJrj2W2453169;
	Tue, 29 Sep 2026 18:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w+J9Q
	e1zmGuU9in5ld7y63WE7cU3DSi2zwvBe1eehpA=; b=q211xtVh3Nd1G04tvMpzj
	pJZT52bhg/YMsAG1Y8aQSEODd94jv9JN/VrWwWFJ81fpKs/x2IlG3kGEVAwrPQhw
	5RONwKAmg49KSLm7oLkviFxaOcl++6MAQAbbwb3SaGSbl4u7BKHZVXMbszo/338Z
	Vgog6n+AKLr9sLDfQ2RqXrfLzjpdO5Ymm84SGbod1F3I5cEH2WrRsEKcxTYNlik9
	zSjffY6I2Dv1Mk9Wmv3XFLdOEOEwnYFtTw5pt2o3BwqMOHx/UAfeasjPOHr5Lq+j
	lEI3h4GgT0jxrmd7CUuOMDa0m+pDMQYxHJigQtjy5ZL/LnVB7dKWDDhnRMVuJ5By
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyt4g9cv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:43:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68TMh97h030149
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:43:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:43:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:43:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:43:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMgrE9008179;
	Tue, 29 Sep 2026 18:42:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v3 03/13] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Tue, 29 Sep 2026 19:42:47 -0300
Message-ID: <33a62b04836dd78346816df5364c535403de1028.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FG72mhgV7TRgXNJN3o5M5rCSusYRGf9O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX6hXpbBPjd1ep
 pwFonIYtZLVyXATsc155EemGEJTzac/rEMZ/AGm8QHwkx4EQoEHG9Kyu5maCYQvEKc9tVfEL2iA
 sq5lwRi08kfHWVP+6UG+LcR5PDGAIInRbW+GOxpZbwWs1nk9XsaZ
X-Proofpoint-ORIG-GUID: FG72mhgV7TRgXNJN3o5M5rCSusYRGf9O
X-Authority-Analysis: v=2.4 cv=YMkKWhGx c=1 sm=1 tr=0 ts=6abc3efe cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=gWXB6eRzw52pz-VW4roA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfXw2t8FHon6RFR
 tu1tIQOi1eiGfaT1d0XtREoc3irgMOu88qV1SbxBGuWlBYjw3ZzYMRUSClF4V0yWLHmMFkNo1Tb
 dqmdrBtHPn0O1zeV2Bpp3yzkcxdpjikEMB5jUVsjScZS873LnUN0Ec5OomuMSW27gg93tnFJWtG
 Fpxlugb1fdrk41HesMFPNEw5piFGtx4rtnWjeeDyBIER3YbsPaBIj4AsR6afVCge0lv9piclf1M
 VPTby8Z7OL0o4/MWq8YYgwcr8gn8O1dGvb11kKaMSiSzNC2zQyatfA6c7IFrUBfgEnVj4oV4ldd
 xhX9ISRyAlYmjmlg3G0AC/r8VqMdFieorZMkJ+hKlFD9mtP+P6ylQlUhXp+8ylx2Ktgtk4Hhiad
 0/dxpkdXWkj/akRLyn5y1rXxyaZDMXPE30C/mS34vL9QzZDjyXdxCGeYphQB5pfW50STMTMjecc
 OrkeEzDRedl1ym5maIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

Add includes that were missing (according to include-what-you-use tool)
to comply with include what is used principles. Namely, add time64.h for
USEC_PER_SEC.

Remove time.h which is covered by time64.h and iio/types.h which is
covered by iio/iio.h.

While updating the list, organize it to follow current IIO include list
convention.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v3.

 drivers/iio/adc/ad4134.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 6fdeb27d7a42..4c8adb8efe4e 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -14,18 +14,18 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/time.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <linux/iio/iio.h>
+
 #define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
 
 #define AD4134_REG_READ_MASK			BIT(7)
-- 
2.53.0

