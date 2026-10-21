Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547824;
	b=fzctIVShrUA71fujY/a5CQbwJgH9MKXIaT7dQ4DmpfVk2tn3NlUl7UoLlv3buc1N0uoB
	 hX1s/AmN4dOfnd4zz+dFkcsmpctbWso5qLGSpjgm2mnIIQOgcta6L6H9dR6aymrVcasqV
	 cAaa1bY6v9iXfjh0ZqNBSwcE0yPsvf+S+vw5gkSwQjQdbQV3WkIqyTkDTIzlEph5DsCBs
	 y4FmdgigxdIeQXz9Q02A8+HZAAfzWYi1xyppxIUYcUIchgQSkkxuArhHNCv7z4pAsrBr/
	 Wwm9guS7yyMcKvu9Tb/n6LZQupMeAyL/o+QL3vqUpnh0UuRz57KF/mNyoHv1XFnCpFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547824;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=okU0egVJSVBXaUIVgyHITHfjOCPNZZES0UJCFmE5WtU=;
	b=dsJs8Aj2w89quKRH6v363X3W11Ii9A2RFaAu8OkCSBH5PsWfAVdawPewJ/ElxEsKHk3r
	 s5levdEW8Kz84pNhGlfENJbUhB4xJ2j9CAdDkCUInxHPa9Hdh5eLUZC5tvWe5SVHuMnYc
	 LVETfZiIkEWtXlRDaN8eSgApZ+vD/4s4huAyZecyZoguDxH35xiik0yTr9Pfy5oKgBiQS
	 FsFyy+kokdNRLNth13mvtat/94qKFslG5do8iOq+Eak8g3bmSdk8GmaCBIYcAZhW2JMPV
	 jy7ZpsWtBvsbvZ38ID6cLsb8PpsuP2Y8aDRjix0kgIb5MHtCrk0zZH72SAoHVmXXeow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nApKR4mn;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WCSdpZSm;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98486606A31B;
	Wed, 21 Oct 2026 01:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98486606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nApKR4mn;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WCSdpZSm
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L0jpLZ2442086;
	Tue, 20 Oct 2026 21:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=okU0egVJSVBXaUIVgyHITHfjOCPNZZES0UJCFmE5WtU=; b=nApKR4m
	ntHsy2LNdpmznVpVS7elzXd+mpAeq5trGLFdo/6FKlrRzc40zvfVmG5Ju6GosWGB
	586KIfGepHLgoo2NvU3nyPJhcZYS6IGtsyET7DY4/X34h31jvyk1lC/u86HBmw9p
	uKTSVDaX5qMfIqKnKxwfBbwAW/9sQR2fkLWIMCL3AEx2Fn++F6b2bbRUeGALjoxI
	kl8HqpgzJP6DK4kEk81YmIt+CFom39pQR8i9XMrcD9UD++3lEkoA1TqrymyTmOkU
	agUrYhHe/6wbCF4Xm5h2Ki6CjzdvIgS2fPz0HAKp3fJIsGLtwqqp7JsMDcv3IIJj
	GRv7Nm2KnIsb+OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=okU0e
	gVJSVBXaUIVgyHITHfjOCPNZZES0UJCFmE5WtU=; b=WCSdpZSmbayF+FN+KheMx
	hZGRptU/DvrEqGC6ATLzIYhxkntxi3M9SEjyyX9KsItyi47JLyrbFCDRCQcilQm/
	abLlZeMYHFtOMVL0rzvgxMjwAdTw/y7e0bsVHVXeQ0GLWvn8Gam8Q9v2SHCOZHYE
	9iMp30PDPK+EPyP5A/Gbb4ZWKag8B/JYDVUjZVw9OwhPGQqUVYfT91apGrW8s3bl
	pcqcwFgcK6i8YF+kn+EP9Q+9M1PNJpicgu8ckD2USO5jd1mWEiSLPL64QWdm9wJa
	oo2LM3cfrUrDTCTqMCn4tAO/BlTf3Mm0jjXCbYGMDVbrJPzCg2qXpBS3uW2WZWe1
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hef2khjfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:57:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1ux8c062281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:56:59 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 20 Oct 2026 21:56:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 20 Oct 2026 21:56:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:56:58 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1ukIT029045;
	Tue, 20 Oct 2026 21:56:48 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 1/9] spi: dt-bindings: Add spi-cs-composite property
Date: Tue, 20 Oct 2026 22:56:41 -0300
Message-ID: <e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX1DBYkdYc+qCy
 AWsKvOJu6jYJoSuJ2xTpxXL6GXXJ1efX522HQmLJ4I4uaj+eKcfOZdKDc2KrXr+8kMy9qvaBeA9
 hFOToS4ZRc1GHMkd6muYFoR8pS8IuqhQN/apbFJByw7IWuy1mmDPVD0jSHNz4sajh5BVbOitSyo
 zvE0HUvxubnEmuIDD95D8oDwz62IP3V6cB5/O7Z1Uc7V0+UssvTmcqxBdvMVfAe3W0yfF+Apewi
 Dx3r/YaZLpl+UL0ob4onuGYfI0xpng34RDQfgbWZYJwIRxq+Kw06JJAbR3Xl7u0g+LPJPo4qi8I
 iacFWQuOvI8a3AyJtYIAulzH/RFHwdxtQ7l4lTtbjRte5uUH/XeNysL7v38+xyqICwqrt2mXjbZ
 +BqP5gx6uAvzwGmMNGdsqnCT2N6RBih9OZK/Wx5MDrGIWY9w7pua+bFfp2uau2qlanPF61nFEJi
 bkxxYK1EG1CfZTZeVxg==
X-Proofpoint-GUID: Aj5ZPDt2mb-2oCfk-ceEr7PMwQWA_raQ
X-Authority-Analysis: v=2.4 cv=KIHPn1Fo c=1 sm=1 tr=0 ts=6ad81bec cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=Nsxvo0O3_Z_9E4ZUgYQA:9
X-Proofpoint-ORIG-GUID: Aj5ZPDt2mb-2oCfk-ceEr7PMwQWA_raQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX+26lqo1BQH0n
 Gf+6gd0w11WPiyG8ssKDxfa+/T2PsSpP2FdpPMFHDaMLxwMurfMwXwbusmpv59wr1hZMxdYsBwt
 7phhDuPEgRebAiodgfoS0voqE47Pa+a/xKIV47nO+QyWiq6mjdVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210007

Some setups combine several SPI devices into one logical device, with
each chip on its own CS line. All of those CS lines must be asserted at
the same time, so that one transfer reaches every chip.

Add the 'spi-cs-composite' boolean property. When it is set, every chip
select listed in 'reg' is asserted together on each transfer.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* New patch. This has been included because without an explicit property,
  every device with more than one 'reg' entry would have all its chip
  selects asserted together. That breaks devices that use ancillary
  devices for the extra CS lines, so the composite behavior is now opt-in.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 4894196c8f9c..456cb9095632 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -60,6 +60,14 @@ properties:
       Delay in nanoseconds to be introduced by the controller after CS is
       de-asserted.
 
+  spi-cs-composite:
+    description: Some SPI devices can be aggregated into a single logical
+      device by asserting all their chip selects simultaneously. When this
+      property is present, all chip selects listed in the 'reg' property are
+      asserted together on every transfer, treating the group as one composite
+      device.
+    type: boolean
+
   spi-rx-bus-width:
     description:
       Bus width to the SPI bus used for read transfers.
-- 
2.34.1

