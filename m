Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559604CDA09;
	Tue, 15 Sep 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499617; cv=none; b=KHZeHyLE2QWdPDIAs1zMNZKsE2bRCPWcIQxPREOaC2S7lDM0VPF8hMBeM9A7zp/8zyVC7ScNGkFEBfbQoLTJrq2Kbi9W+62l9aGWqBIy/T5LoIF6XYI46olG+NHeN6qvfwJ1uJ908wjfXMxwAsM7ADYYT948JmVo6ZnqVFhhQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499617; c=relaxed/simple;
	bh=wdY4/fpBJRMV0A2CjOI3dBVS5wEba123BVCqc6ZY6z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpAOzRj/BtQsWLlqKPNIklEzHSEmwlSJAjnzmEfL9szDtkDlJAHPXACwipXqloqLHD1cjHedooCllHGkBsmHGbEinRD5UWyrcmJ1dt5fKod/phA9L7o2m82K+JVGl5t+0tPU87h/dmFmRM9nTUz5xazZRKmuIydevqMIXWMbm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ieNJUo5c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ieNJUo5c"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsIIi2052584;
	Tue, 15 Sep 2026 15:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zlm3k
	FtDVpPgobjbkG93EO7jU7SWo3whTE9je3DIoeQ=; b=ieNJUo5co/upbIwOIDJbb
	G7sqJc3+Yl5NwtEgEAvnjSMdeXkQB/YnCbQ0YIt3zJhCmWBeHE2r3DBSjlziI4IR
	9xtjCtAJMKjeIx4sbvh6hgxosU4ekOII4Mt0x134Q3LTfRb9w2JOCJFweuNZjbm1
	5N+kc9XCNZoJqt/LZtCzRBWXiE69/j5LtYJhAvvBMHG0PTJK+72CFTJWG5iA0L25
	GCncYiK/frpN7QaIZrhkpZenvOaNrJhJeubz6XS/qQyKUCMimZc+foLbLYeNrm3+
	yFCiwkqMRskTez+8YjVBH50Wc90DfurhkUGhQfZNYYTPF7WoWRX1KFPuLlxehPg0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ead18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:13:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJDSdN019139
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:13:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:13:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:13:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:13:28 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJDC0D028133;
	Tue, 15 Sep 2026 15:13:14 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 04/15] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Tue, 15 Sep 2026 16:13:06 -0300
Message-ID: <051b56eec727b0bbb05be6a154efdf57497a95ae.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ApVEzS7ef5Sed-iu66o8oamXfdX3tC62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXxiR/qkaLD+9p
 zvd0bV9Jb+NGsXiStnq59nwGIN28ykEI3+ZM8Ps/iRi9nzPzq1Srh2NSpiinoiHsoFRHchqPg23
 7DeBPNMiwJjIGg5XaVCpxqyVZowj3ATlCN+JzKaE+1Esb25KQecJ8tblBFeeRbE/vAgNEt7i+ma
 rf57DmB2f1b9l3g2thBwcbXwGJ5S8aEYc1VRTeiPbk0tGxCXXeIJc0ksPTluR41KHLKHFyNYAGg
 bxfm4FuYtXdXJfaOF2CnvYjwV4YLlzYL6ygN2WRxV5es03tXb23Yx77DUfl8ZMcwTom7VTeeovG
 4YWu08/JaEktcKM0vqRZo+503oMRXaYiqVB/fXAQ69MYDP1Hphmyc1QfN/eIqWr3mVjXGrn00Ev
 8F22Wcn7ecXr+5CrNSinyBbRp3z3da3Zrwa+Y08adoUvDjksYJfPEMD9OHbm8nmDp+drLMDtUyD
 d8sAqjS5jxGwC9BJfbg==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aa998d9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=gWXB6eRzw52pz-VW4roA:9
X-Proofpoint-ORIG-GUID: ApVEzS7ef5Sed-iu66o8oamXfdX3tC62
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX/1/5X6NxX7OY
 xWQLmMLZTvZyYqenTGZDOCAYD5LtdG5NMCMeITksIpbUeRp/0mSeDX1iIIPqqqvseZ/KY9D3g6S
 XcYiBfZk3+vPRTbo6lwAjn778gWO+GIt/wDx7982rEPbf3dG4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

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
Change log v1 -> v2:
- bits.h is implied by bitops.h so not adding that to the include list.

 drivers/iio/adc/ad4134.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 3c759b89d331..7400bd145d8a 100644
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

