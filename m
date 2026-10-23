Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794880;
	b=KJ5lqB7ka6d00lGgN9Z6PRaLqik1g8P9Z9TVXjiDGOCO4jvWbMdcHEARRhdrxzz1AHrK
	 HKV2YGSEZrAsEztPRBJdc0qpNRjTC6ac+3AIPBDdP6ZJuETHqkf5bETawuHZOvCeP5ceY
	 Q6p7pR0u1D68a5S+yolpvpFbeeQ1Hma6stbfDareSI5qEVggQNNlYR6+nt8PdoWFfc/VJ
	 u7enUGcQ7A64NGMxUj8RwUgOSLoqjfXhJaCjqYvfylOIvrzWD2D2Ns1rOsNbUjDkdTXFu
	 g86nIhNou/YaNUinyDbA96JT14Se3F2pD3tFMViKC6QRLuVWYfZF1ybY8SQo7OIzGkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794880;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SwjfaCWWi+SK1XGM+jwiNDQhb1zxwjf7gtYn7gkcP+c=;
	b=FK33XbLmwEl0LjfUR7U9gK4iWQ1wf6vLNfnNfxm4bOzOlWD7pf5sR1ZOsb1G91aJouPO
	 myL3uwPVC7Ayl5HDC5mwea28NobXr8HJoNdne2TAy3EdqwQChnRMPQLZaqURr32l4FqbW
	 iAD16uxilKd36lqusFKllrg0vZVzKftKgj7GlYnSclTsW00rOKLiAMsq6C4EC1ANAQTKf
	 4G2LDkyC5as1eBCdoWEptF0+MlIhuHBgl/F3KZyHgnWcvOHDvpTMcbB0kZ7kbQUgd9tBF
	 aBFq7ook1IH1JRWMHrSSsJ7tekCCQ7rRncajhbWnzplBxV5+oCFTEfC5TvFL26UXg3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MPPTBQBz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zqs8Jxcz;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B202606A31A;
	Fri, 23 Oct 2026 22:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B202606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MPPTBQBz;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zqs8Jxcz
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwjRn3009226;
	Fri, 23 Oct 2026 18:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=SwjfaCWWi+SK1XGM+jwiNDQhb1zxwjf7gtYn7gkcP+c=; b=MPPTBQB
	zy4djb6YsHuYnF26gBxjGInoYIisWWK1hJxmuBt5YUZzfyNV2WmD6O13IEi6+bRQ
	OglTrmKmJ395qGMeZ+tlN0Zh6kWGkUvL4PIMvQN+m+AaHE7VQnF98PqUSpaehP1Y
	eJpkS5JCqgJvm9hNaOqUq9JXXSjbrxuwuI3UISmvQaQGU0BuBLeCj/ZCk0zteq3z
	w7pQuXA4LIcKEZBdE/H+EDHgD4FiSELC2fVpoleYv1uFx3jsFwMAUAz/BD/jW+oN
	C6XUcd8MibTNEZs8bSxE8NpBVO3+zXGGa6JLFNziRe1/Y0qKdp+squdmF4g3XrBy
	ts0pxaC1Izx9vRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Swjfa
	CWWi+SK1XGM+jwiNDQhb1zxwjf7gtYn7gkcP+c=; b=Zqs8JxczdssLq2sUx8p5R
	NddLFc8Vfxsdf3duHGMkBVNe+5MRTDE6LGfXP7UQsVQYJ7orSMnwIO+PDhSCc+yT
	OOdQca7rTSuKXnuWPccLOgkrmI3K+ddu6JprsmQA6WelhaqKqN1jLOEHA3zstZvd
	+hP4hB6icGZzsHk5+v2qVfPfeZByJeVWvk+gznaKPrjaWIQ+ng5qVf+zm5uH7BL4
	aivSQUZtj1MSzWDczuAWm8qdqNqICwSQt5QuvenpQsX49T9/rvCR3Pf2Wcf5WtgZ
	wZq+surq7yLq7RWdGSInKjnhYui26zfhC0Vdm7sdHU2cgB22nQwI1Jsn9k0Derz1
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg3574bkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:34:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMYX0x017528
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:34:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:34:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:34:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:34:33 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMYIvI005819;
	Fri, 23 Oct 2026 18:34:20 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v6 04/16] iio: adc: ad4134: Update include list to comply with IWYU principles
Date: Fri, 23 Oct 2026 19:34:12 -0300
Message-ID: <3d2da721c0ff13633e560c2b6492ce4f163b79cb.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6eOLckGfMWfGTAm0y-A-qiW5CXKLJ7Hm
X-Proofpoint-GUID: 6eOLckGfMWfGTAm0y-A-qiW5CXKLJ7Hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXwEc3ngylRWFu
 vttG+7Xb1XVXEvePST7ExyQV4RgzJanEIz5JKD2YXY4ogHXFfZn+KnjxtuVTWAplcV8Vf06RJGa
 3D796dwAQ6TkZ2pTO4bWU3dl4KvDpKhC03Id0W42Lm3X+bvLnduf4CZ3K74wg/4Fqml12YsdDsV
 sGDeXiz3fgkly16TxBFCGQISf699Qk8Vd5cmhSAzxTmQESwfke8l5buzZBVgYSIphfFJ/TKHduU
 VqzRFEyaCx7xscgM69pJjoxxJCEzMNekv++EPqJHgqmKqiB734So3DuwS/XrokAvHGc52lvHe//
 PXe4k4NrUUwgqOcCZSHheoL+37oupWaZmVBoEvG+UAK5Pk2j+4qyfcPu1k9EgNsFIZXsUFxy8He
 LV4OFI94dP/USiC/AMxoywWgdIu7PiSHEO54dyVwLti9vI4jIvU9rNywYnKf73KsnmVY3+B85MG
 fWyN7/3rYCmRzk+4pbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX+PvUfh7JZoUO
 vBOiG+JwToGewk983KWT87IQAH/x+NPrqaYry9kIn1ruc9AALy3pNB0Lkx8bNXrrlpHi/flLgSY
 PGgKvVTy8X3AVyipMXng/iw+7/mC/vGfc1Vvjd1/9BBRh6uVhHtP
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adbe0fa cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=gWXB6eRzw52pz-VW4roA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230088

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
No changes in v6.

 drivers/iio/adc/ad4134.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7d9e0706bea4..fbf89497321a 100644
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
 #define AD4134_RESET_TIME_US			10
 
 #define AD4134_REG_READ_MASK			BIT(7)
-- 
2.53.0

