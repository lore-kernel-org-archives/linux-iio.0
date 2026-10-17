Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2A38F630;
	Sat, 17 Oct 2026 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202281; cv=none; b=ckKkrzqQFlfueYEyDIMvtTIKoN/rdsFrgEE+jiXBt161khSAsrSKd1qEZP56GcM590iryhLB0STj4TifwIyrV3IiSKDmSGFx35Qz5QBSouC5cQ7f1kcVVFlMeFBrFJAUrgvQEuOl3BzUDjna+IfKIR1XONGJKW52wgcJK5duqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202281; c=relaxed/simple;
	bh=pAw2j7svszOiB9Gl0wd0O+arfxdaiYOZ5GjVsrbKt1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgTDvYe4WOXRTmxGlsY6FxbxO4VHvyuESEV92ewRMta1A/FUtSdRn8fiPMPeDwuUgeV1agLyl2v9gRgbQM/yFdJ9aQ/qmP3866AytQ6v5hxNsQFX/+xchCw6Sfe/oOOHoYg5qLdGlfGOXeAYZQ83q0SHLquSddAQ9Y2KEMpY+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=hSFw1BMC; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0XfK9Pv6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="hSFw1BMC";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0XfK9Pv6"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNH3FB3829652;
	Fri, 16 Oct 2026 21:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=kSMDYp+uGU8NpgOZzHsoCCwAZTkA+4vOuVV3fUkp5xw=; b=hSFw1BM
	CMEQqzk8PZaA7SA+D+I3EMCo2MMDZf1SAI5+H48cQD1yvlZFgEcHDjZv777hW0Sw
	eTB0AqITWG9P8aBkkfYkGGe6szcLUEqjTQWaV9t0yx1hJkfawf8feovXVPWY7Q8H
	ebFxHQYRxtc7qu/jB7LYG2VzbC5YfgmG0d+QjnR+SUMLbE5AecvPOwt79i33cT8u
	NlTP6RrjA/Eiaespx2ydqjd59iCB3Rap0IwMSGCxvcDRF06951P/5/dGB5hKWB0/
	9lPAZ4E4bOiJgP0QX+/uOmOAvpvuAeZogUu+i10hE51VJLXIEVA4Et0qGbD94URT
	4DfvUwH+3Pf8eCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kSMDY
	p+uGU8NpgOZzHsoCCwAZTkA+4vOuVV3fUkp5xw=; b=0XfK9Pv6ZuG9pJnwPMMDw
	/BxPSfVSi1iCDlR2OXfXSRHN2HBcZBHn5MtX2HnW3idZsxoyPdXPmS2I5amlzarK
	pxw/3feXeK6moTBXVyIhVU6s0YQkgXory3gcHrSMFusshkaJQIzAlgnzT8hvjZm4
	KHvZNTCfo3BQxRRmz1tK9PldpBi3r5u5Fu4IC8juBHD3z+y6VvmejE6nY/c0oH3L
	dYV8HjjYmCdwXxIhoZbbmCXLG5p7EDLTCw0qC9Ulmc6GfKww1dMMeEVAXQTjzj8y
	xcZO/su7AA8uplPtkgh9aoF2F1v8zrFEt/hr+EgGa/0SuM6ZkDcRB63rJd+dmkJS
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbj1748p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:57:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1vpY2061589
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:57:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:57:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:57:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:57:50 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1vZnu004312;
	Fri, 16 Oct 2026 21:57:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v5 04/15] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Fri, 16 Oct 2026 22:57:28 -0300
Message-ID: <00e29677c41bcc1d5ffc34100c0966bc027cf138.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXyghoqu5EmJty
 9NQeieykmYMiUPRuLcLP+TfoPa+H573hxhWBduaNneqTZps3D0VRDOvky4mS8AlkXcT6Qy7U4BM
 Ez87FFyY1Iy5qTOiLaLmYmydrQCCLpgxbApKeBxOhVhYPFH9Mu35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX0U6YZoL5Kigg
 NfFllUBDu5Nxo1PQlKH9cMVoLHDed/VvTiBDChxTVkkasDMc9EbbJz/D41clc+mBiaCrAmwewz1
 AEm/LyxTyB3IZGQBWcdxsZpgkWtJYeG8bgc1dMylXTqIVdj4OEJvJhWy4ASY5MIb1f8y8WbHjRJ
 WqoQ6ySxTby2SOFWDuIUcrDyPuNjqHg4Oqsyu+XNj2hXJWlEVCwHuSFGdUdolbfZIX0ebaaloq2
 EoEF5FYUVtERmcMyUjHL4PSqTt4Ll9bv8YsLE6at6oteHueVQ5YhpoKAVQHjpBKof0yHC3X7cTa
 v0maKRFMwffwydxz/1SNDvtXFe+4Ft2JRteys/6TfBeKYwyrFknccVI1z0cM4cgK59owiNUk57n
 10cBNq1JNyYIKJZ8qbhoTqMv6PHh0Thd+EBUnNsxhN8UeQ/qICHy8EmZxDf/3K8268R7gx6S9ss
 zI3vIwc4VQVMNWYhyZQ==
X-Authority-Analysis: v=2.4 cv=Wd6Z+EhX c=1 sm=1 tr=0 ts=6ad2d620 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=gWXB6eRzw52pz-VW4roA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5501WLO87sWChm8F12LDMOh6ccJbYz6u
X-Proofpoint-GUID: 5501WLO87sWChm8F12LDMOh6ccJbYz6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Add includes that were missing (according to include-what-you-use tool)
to comply with include what is used principles. Namely, add time64.h for
USEC_PER_SEC.

Remove time.h which is covered by time64.h and iio/types.h which is
covered by iio/iio.h.

While updating the list, organize it to follow current IIO include list
convention.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index d555874b4959..dc2b32c73a3a 100644
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

