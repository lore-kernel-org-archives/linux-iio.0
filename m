Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD22326939;
	Fri, 28 Aug 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931071; cv=none; b=mrnaDl+1Qb76bbNUMkR879gTYkxrkssgN+8/FxV4FSXiC3d6qF58YhontI+Vq1N7ZE0c2XOBYZqfPI+q0fgd9zAE6fSr5s9mqBPu+bKRuj32pQlk7foaHWroHv7E+reuqSnfS9cj6/TXcsK1cLSImMIqXn7B8fEx3tQcIs91ZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931071; c=relaxed/simple;
	bh=ve7OXVMFVFw2xFHjlWoene6tb7Ty6JXZOSYOaiwxrLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tw0f2zt4SSCHmbYaY5Q/NUYe7SeB3Fbcw1Fs4ZwOACM/ls+kzIfRV65BFXCbassgjBi7K2xkxJ0zzw8FlDK92FZMeUfi1+g3zOWidDP/VxKRrgg2RVErw1m3SX++39i3t5++157L2dw332GxQwaY7IKtKU6NnT95aSoQZ22E0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RjO/C7Fy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RjO/C7Fy"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVgvR1142294;
	Fri, 28 Aug 2026 11:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NDlT5
	gWP/1+ftO/1MnwMDib5N9jKL2+bqbtj1iGL1Fk=; b=RjO/C7Fyk9GNWiF3VolYF
	HU+sWvZbE4aqPvcPOziun5prEXduig09bOh/BWFVFCaJ8d/A4ngnOawLp+nOZD4p
	qP8cuoEDsMS+VXYZFS3jODGFjKGUZZAzzA7msXQZscEt6XMlKKPtghIMVTBHRG85
	E0pJBcxm/20PnmwDhpaGMRGooLV12lQ1QNzPdbzD6nHsa2708Oqy+hjnErrkcGcp
	IZdJVVhG5uD45HZDi+Tb5qOzDlGEygFlf4sSs25YaqxQ+qvaC1XOTGIOcOiuI6dY
	grgXJcqCDTVaEZvLkBe3dc4yhJxHkhBpGcTZOIpMAmsh5M4Xw/yo5JsKgQoG0ZGI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:30:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFUv9o012855
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:30:57 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:30:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:30:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:30:56 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3g031424;
	Fri, 28 Aug 2026 11:30:51 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:24 +0200
Subject: [PATCH v5 01/20] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-1-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=1021;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ve7OXVMFVFw2xFHjlWoene6tb7Ty6JXZOSYOaiwxrLM=;
 b=7s4G5ZsT3SdTk5ffaMyzvjH6tEmYXyhp0XumQ4VY5T1RoBviowI+KzXS3Nam+3maJ5l10I82g
 qTNiMK41uYhBeGOwSHtjL1CEo2cNYrZYBWUE4AhRtQ9xmlyHubGcF1F
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yP0h9tgD11Qx_XxciJiVLDOiwodT6ih0
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9b2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: yP0h9tgD11Qx_XxciJiVLDOiwodT6ih0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX9PmqXWoxJ/Eo
 Y49/FKnGLKOt+vsa3DqVDy5uOebUuDOr60k69uB1CbsG7JHoeUH1OjC97BAeUizSHNfuyz3vTEJ
 YC9a0pETB27S4j1X9hcjmRVnyMXp8zz784BkzhsuDKN9JuWmKfPhWfIKTOgjxQurQfu4ofZAdb8
 5j0/flSY//ZNowk8apgFAAgGC5XS0+h9xiueFfKOIK7Hqss0qLrw6AT/sjT7eMVyeJkI365SEdP
 BT8tQple77v3E4wMKNvrCKneVG82HLQrRxXkSiFmRJR+9Maz/87Eo0gJjxIjxmG7TqHtjibjoGu
 a2iW7n15fYRaS8E2bCesJ78banTX15DhkFPR5aJfk13u9lXwXwBNeiF7d07gm7ybdUjc1eoeRn6
 nWuAAcfqvRGE470yGGaKMYZD1qsqUJ0jXyPhyOGRIL4k4rUGIQatEExjGZOZ+3V/5WJ3XF/ikjF
 ck4SmCcBg6j7x+VsCPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX/vjYhUc5wheX
 wN7M34h3DfIlX3DGj0XEq3ScS/1E/DOt1wFhP1++9pN15DUoZ5L15GFrKcaQouS54/t821txIZF
 QdPbWYuUAZTYdd4NQkhzykBwqPFA4Uuq85EeSrxJJGLRlVrfA9ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

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
index 26b9c75bd4d8..b5e59b1871b6 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
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

