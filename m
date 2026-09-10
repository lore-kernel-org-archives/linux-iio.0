Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E33ADBAC;
	Thu, 10 Sep 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061849; cv=none; b=V8H4zFzvic8LIm6dvnU0fsP0YkXWz28SFnx/Yey+TTI8Jf6znDyL63TN71X+t/vg81veSyRxLEZmj1Mdzyp8RlMNumTb7w2Gfgum+V2DRjTb9WgZWVLhsy/Ga4EbPjw07nonC2mgKIfGQjaH/R751mKt1EqDZqV1zZ8DBFAFNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061849; c=relaxed/simple;
	bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uhrAhgHk208SikNbx0VJzeoAxpoofYbchqn9Lukr1BAYCHsO0tgDti31rwmq5Uozces0V18SLVDUlGwAZtqkkJ4eIB8q53cty+HIMwPwPi8T7BLCAAWlCaHnEszQUgNv5AxNAlAzURHJGaHMdlc8TFedcFvCL9R6CdOa0F2FyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=krKuU1jQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="krKuU1jQ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7Qqc343094;
	Thu, 10 Sep 2026 13:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rxmPy
	wnjcLCbFsxSJFUDwnHHA1K7/8xkNzN+tJwpQgI=; b=krKuU1jQuTQHwIxyyTp8o
	/iQvMUZSKMoMjXuADw17L9ZJAu+iCqXLRgCuANx3++3+PQ0bJN8DgY8hdWobK+Lg
	kOvA2t/fYjctaveO3SIchsZfbaVcfuIRYcfVK6TKKekUsBdCbAcppzp62QSeKdJP
	EFPNXR2WW1RGC9CoGyfCAYHtDCH9l8xNxHALifxGfwwWbf8Ey/QTBKT3/YDAEm9T
	iK1vkqoL5OiVzMSx8icXzszRIK0pKplE/3jwMsvwnAKQ2YVW5AY1i9OEixcLX6Ut
	BA+8zgo2jztm63aQ6bbCY6Rf7K2LgBDUOg/2pFyyVS4rvHqkQjdoLGxmtxbWMkh4
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx95208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHaxee038715
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:36:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:36:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:36:58 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSX018832;
	Thu, 10 Sep 2026 13:36:52 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:19 +0200
Subject: [PATCH v7 01/17] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-1-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=1021;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
 b=ikdrHkLi7LigpgtvEANLNAzH3UjvZSeMxDQadwXUSUmoSoN2srISV75UUdPaJrv/gHAKIXFFd
 Z6YHPrBLRhtBHvbBnFcILjE301mNcLJ9/SznKBhb6RwnZLkMeTYW/Ft
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX7AZbYrIMQ0Y5
 dC8/8p8oXKpQ/cQctWdPpG2FZd1a+m37AASC4b/I8JY2LxQxdU2br+LXt9tKhE/MNRnVKYIcaWJ
 AGeFhmWwJuMp1xnrgUNkopy1joY6titkUfO4LHic/Tt1gEH2ye16
X-Proofpoint-GUID: aAFZ89kUa_HfB6yo4fCbFgJkjEPtb-VX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX+vL5uyYpWjOx
 8a3riQyAZ+Zt7HuzGWypzpqu3acjXKiSbw1OCApm+VK7b/mltnIfzI0VI9BR2/S0m9ndNblCwqa
 v8nrPABMRqT9tPROBvbkLH7vWDQUDdvp/nA+5VA8yJKQR4ujowLZe0x6o+SlxTUGb286rHNLTgm
 of2izkRiE2UUU9unJmkalG1C42Dia6mI1EGSiYHEN1CohOkhYkgxRRskLcUWKWeGWJoHtHzb8k6
 Oxf5eY+rTOqXIf8kZ8aB40P85UmwDQX6rvQISHV6o0h41AbjUubT04biwFeUCMyFN9TNLBzwHRA
 L/Xka0nC1sllcc4PcnzGadYy/KKt3E27HvhfqoJupYLZGl4M4IXFNcaIbmi2EoJTtocqBA3ohOd
 lnJsiqBfNmCl4j8YPwmaOQeR3wciJzGclYIVHJMQaynJTUwL9pUYgZ29hE3yoH5bMjkkR8b4h1K
 a0S9Nu2h09hWwsKUlgQ==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2eabc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: aAFZ89kUa_HfB6yo4fCbFgJkjEPtb-VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
This patch is already queued in the IIO fixes-togreg branch as commit
040c2514b25b ("iio: adc: adi-axi-adc: Initialize state mutex").
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 589f03618ecf..fc7cc92b35f0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -714,6 +714,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.43.0

