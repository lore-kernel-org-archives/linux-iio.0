Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CB4772A7;
	Wed, 16 Sep 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557329; cv=none; b=DUjnrRDIpvLRPIEtU9Fxqae/mK06C1sI7PQ68HwYAuVC/a73HHkeGneks4Rblz8PFnQKettx/j5fH+v1fiHMkl3h+jGXHPnGm9GHDmH0GBJFqC4dDmr94xlyJnITajsobbItKitAI3bAFOHWdn7SRB5OsfC5JHe94SK0NHdNJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557329; c=relaxed/simple;
	bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BhpcYzSf2DjyfvwM4ZJvieDhoQA2Xf+GdDtBBwJJTKyNUS1ds7hJLfYIPfnBk5PAuTENk7Arz0/vDwg4/4gCyrUlhO5seqShFI2hBQbAnnm23k+XvVWdgnQfYdIUZK7FKHLyHdNaXerWKjWT6Tg0h3gCyJYezzntYBfmNsDt7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YmS0yIM7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YmS0yIM7"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6M7BX1591671;
	Wed, 16 Sep 2026 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rxmPy
	wnjcLCbFsxSJFUDwnHHA1K7/8xkNzN+tJwpQgI=; b=YmS0yIM7TCumd78ujF69v
	mx68d6xNFnePhILvx3oGxiOTvl/rTUB+Ig47rUfPgcuowL1tWrQXoQYNw1bdkl42
	DT3joPWoFLDa0P9UwNZ0iLbq3dGtAHHe1HKO/8tzmu3n4JBOElE4fytx8KvMK3G2
	s2Uyz5bEPpa/GgR7wNGEW/LT2ov7Cgby2IMmyqtUwWoGNv4UwOwibrZ9LEIs40w9
	hPhLqhtIEkuJKXDyS3A6Ocs6ZQ42KNX5nyxJT4rUeU8WbpYzYth4zGAuf9lwlNXE
	1zUsJBu6kVIniOE9NL/kCLScoXyNyacQYoMzfo57PbFG+1hrrvhW6ZYLW6pwJEAB
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:14:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBEnc2047080
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:14:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:14:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:14:49 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENDr004263;
	Wed, 16 Sep 2026 07:14:44 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:50 +0200
Subject: [PATCH v8 01/17] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-1-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=1021;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=FGQG3DmM+7X/giTmbo/iKtzgJp69jhePuib7JGtlpCY=;
 b=3NF9YSr1uhZXTI4uhTPVd140uuoMhVOj4hBi1tp7xzc3JZQ5JPYKVF+vvUsOImB1juWqdjEc0
 qdZMxEG6YSPBKtJiJRBaMYc0PKKg9ZcjF9J9Rl/Z8mDNLrEvukmQlbz
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX+yTo8+eBL/cI
 wRKQ9DYFt17/XemTFHmWecTcD+L04v3Gte0zvyHhx4pzCew2PMs8Y9jXeyjTeQS6LKLELUtiqCb
 YJbhASRX58F5aoJ/bdF49IUD6VJc5KN85ywRqetWozOiSvK02cJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX4HGhHnQGNp7+
 lnrh8eKR1Alg43OArVvQR5Y8a+jnSBKJDoN5bdtXaIZhkTQ6oYJo8iN7u4ydI6LN6OZLz/AcZJ/
 9+43JxB1kZffYtDB5YfFo33V18p6MegKtriAi3M5sRrutq/N6BQGgCZNcH94xsPQtSQiSakPGut
 nizvwH6mTqQzqNAsMa0iTQcXVwmGElSUfQh/aiYHwr/rWo0dqPMOFyGrp4DgG8JkJuqQyDkRYdn
 SUt/01o3dgCYLzkT7B22zw8Q+R96fThdVnwE89u2tp8xi2rV9QQOfgvXWb0C1BVniFEpHU5a3w3
 wvCnP+XgCXK+zaEaB9NIBKqn4dElBoxEbCnJMBkc3rhMBmBDIm9MJjAr7z9vbTUT0NziCMnRdPe
 h2ujPwoeB8SBAN51jVz38tQOeZ1n+p5/6pHxvdbyIR5Nr/ydSZfeEhMsX/80mIILdLhfTIzWCVZ
 2vTVBr474AUdlyka2mg==
X-Proofpoint-GUID: 6GAPAxElF6rPkokv2DrLVlHo5P8zqyr5
X-Proofpoint-ORIG-GUID: 6GAPAxElF6rPkokv2DrLVlHo5P8zqyr5
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a2b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

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

