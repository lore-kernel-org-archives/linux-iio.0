Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8D4AC17F;
	Wed,  2 Sep 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369764; cv=none; b=HBEsjmbWAnDt28lhgF/WXyiv5OQXagPXIIlNtX8PAosobnB/XIWzAtwJKVo26dVkqRIFLz++rxT4cib6/t2C/nABeqG4XjjIeoyJQkEdkmYGhYKxVk7Gr+WUnQzpJ0pAtiU77dE7X4PU02wML55JaeB3S7TjD/lW5tqUlRdgxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369764; c=relaxed/simple;
	bh=dIBJPu9TBH0t1rrHfWCp7mPumddm97DD0rugpLtdRVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj6T1XX44zM4bZup2KlyuIrQn7/wt1Lt+Cc08wawqRawnOJqDfyLz3YFMdoicNlzfZssrkHEuL8aeI/UOXiiCAYuDuDF6DYIWpJHumao2y5hvvlPmoG8JoR0KJA142WBMAqUOLlpNPg4T3az+b5xVZdz1eeeVE3M86prvW7pxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qgrQxB+h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qgrQxB+h"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDZ1A3088782;
	Wed, 2 Sep 2026 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rQDnB
	prYSSIww1OAxfxrMrKgxbvHh3Ym8+OuNNzs6LQ=; b=qgrQxB+heZOnbReXFtnv6
	JMeiIccROsII3BkE/HqZohLEHQ/WUX5mpj6f+rZjadKewRE6Yxx6lgpyAszC+0Ib
	MruyFpKjh/b48DVFT4Wfb6hkGTvJL2xGD2EprBfaRcC7h3NhPq777vN0BSuNONfG
	rDvfDjqgWUJnb8cRm2rw0VGrmGrLXAdeAhfdMCVJLTchktukOU/itSMrKNlDPQ3W
	t9YlhTzVZqNO4FBO8cufm1dQvMgZ7SvoBVgVqwV3zchekciR3NO2uiilChtGuI26
	2wnZbwqKBnlS3sVvMwWf+u9y7hOFh/TFWYe5oCcxFiVpjw0XSV+yD78p+Ssa62BR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubsw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:22:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HMaTJ041230
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:22:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:22:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:22:36 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HMM1H004216;
	Wed, 2 Sep 2026 13:22:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 03/13] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Wed, 2 Sep 2026 14:22:16 -0300
Message-ID: <22e82ed7b6d6c04f6347f8cdd0c675ea35fcc22f.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX1UY5QnsE06vX
 Eh2NwjNBhDmz8vKU15SVEHU6F5KUNW2l9U3am5AGv9Yb0cH7DEGE8MPbDgBDNC11VMTQjhoTJiw
 JgL9DKLwQQ2Kj1L7R1d2z3xZeeieHJL+2A7GDYIDiWXnnp4+b3kPCVB7A97CDUO/SqID96r2hU0
 YdXO6yXfvdYQMRRfWi42My7CKjVTuzXbDCXutkOSObDNDm1QAD2A8TepORyrOlBWTgZXJwfGf63
 2/GHatqox1TTujQj9iTB02yl+l/R3YOqcgXUOrkMwStgDRCY6ovUZ4HCVYTeAtxibuh9KCkPVRD
 mdIQqnzLxenyjLS1kIadKHiiLd6Sml55JTrigJ5nxiHpLiPyqA4BAAtmZmL8k9nzifwmIoF4mQw
 wILy+41gMri9ppnKw0ezsRJ8IsPFzrFqIk/80zoiIZPS5OR9qUq8GwQivobc/kNVEHIYDgPMHev
 L53dmS3yk2RhsLRr/Hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfXyNRhmsTzkiYf
 Z1rzoGUU94DvrYv3ILo2erFiyCg1KsgXcvHIWmA/TAzcryZHHbBXHiBlwboXP3nCMO96of2eDLU
 JN7xwhETZfXWzrayrES8ZaFkuHoqwiOklAGIODSR9LVlSOIAZLz1
X-Proofpoint-GUID: Um8LMVTiSkronLGH8YXB88gmsrUz0fP1
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985b5d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=gWXB6eRzw52pz-VW4roA:9
X-Proofpoint-ORIG-GUID: Um8LMVTiSkronLGH8YXB88gmsrUz0fP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Add includes that were missing (according to include-what-you-use tool)
to comply with include what is used principles. Namely, add bits.h for
BIT and GENMASK, and time64.h for USEC_PER_SEC.

Remove time.h which is covered by time64.h and iio/types.h which is
covered by iio/iio.h.

While updating the list, organize it to follow current IIO include list
convention.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 70f80bf1825f..7a3b05aacc74 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -7,6 +7,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -14,18 +15,18 @@
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

