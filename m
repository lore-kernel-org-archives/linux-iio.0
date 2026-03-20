Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD473A0B11;
	Fri, 20 Mar 2026 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015767; cv=none; b=JvhKsw/v8eLULRbC/ulP24Sw6tMjNK/AcWkb5R86ud0wk9D5NP9042ZL+OdQpMPNMUH1lJKTh1fjcFrE5CO/13lkxCxqhjTROpK6jZtXIGNBtH+MGF+ozw/g7Pby1jOTatUJRF6iXxutVPoKqbm0vgqjlLdquYz600LxjdZxSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015767; c=relaxed/simple;
	bh=jOyEMeGG8W4nfIX/w9V4QO3XOyng7QpZxderLQQFMu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H90SL8dyPLuXL8yi32Cdqu7+ZbxQx1BZCZLM4ylNILmrBqo6xstsPc4YVc+ZvUfTOno/BJ6XySZcz48Db6kWOpK/7xgJpALOl1RfKXi9TmP/6PZRewDPeSLtP5TwZXmvHbB5P4MFcMaqgMIYRbTEt9ytvPdTQFJWWShJrlGHfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=begJwiLF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="begJwiLF"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KCfWh7634493;
	Fri, 20 Mar 2026 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qJ3MQ
	d6Y/zeX6JtpzFNsZfcp1W5Ac5b1CSVxchvzoN4=; b=begJwiLFjwgmVyo6IHcJ6
	KdoZS7wW32X2PtL/lNrWB8ZBCxZwPrQy2PgphRfeXg+uVjAcSHBk9V3jNw210hUa
	HSlhu1cbK4zZDCw3H17hnYOgDVoFtNcka++r0ueYTXeZjlpntoyqlvHKp0k2dEBN
	wr5Nx2YareiNiQ3fYzZ5yU1vkHsE2nkKs+KRN6keBlVob3Ub+Wal1L0SdfLX738C
	vI+8Tr/wYrsWSyZNoWrjkX1Qnhxm8Mu4qRZzsr7JNC0zssoOC1ug3TJDCIsQVf1B
	e8H4hp+Z3xf9vmkVXze9E+EFfek4GvU1/uk3CYEknQMP/JAzKv6TxDhkM+iTJ59r
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyx8m1dym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 10:08:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62KE8v3G055457
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Mar 2026 10:08:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Mar 2026 10:08:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Mar 2026 10:08:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Mar 2026 10:08:56 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62KE8V9L014859;
	Fri, 20 Mar 2026 10:08:50 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2305 support
Date: Fri, 20 Mar 2026 22:08:18 +0800
Message-ID: <20260320140819.191700-3-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320140819.191700-1-carlosjr.jones@analog.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5aM47TiPdZb0NfjiKUH5fj9hyX-Dvr3R
X-Proofpoint-GUID: 5aM47TiPdZb0NfjiKUH5fj9hyX-Dvr3R
X-Authority-Analysis: v=2.4 cv=WfoBqkhX c=1 sm=1 tr=0 ts=69bd54fa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=7uckrkT8fFrKzxKFu3wA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExMiBTYWx0ZWRfX8BhcRCiBSk0t
 x6f6FHDc8d2IwWImDsBgGNG4Xc2WmPSREesC/v+9TkLg9qdomhcEMKwvr4DqwmpgiYeMaFwFtHa
 AQJxugOGO1r0RSn6abOuhtyxnOH+AtFYbd4LO2TQ+8LxqezLPAEWpUh445kko4pKBSixOVyfM52
 NhIIsw22s3nt3bQv+a420f97+zvE3/5iKVdPGmIn7NLEI8PILois7Qrs+8goHCKwmtygmLy0IjY
 TxVlAdOKfhEc3WDnOyTd3liNoXq/knF5Tg0E10jYQnD/HnDQgcVTA0+whr2sISFLVOp+DT8IB2m
 MwGWdU70XdaJFstmq92ygAQIWU+OYEVvG8306O2P89lT6P03Ki2Duv27uMnMU6u8vtuGQ29O3qW
 HRfWOonni0z0Os0dqrwXhHWCSCsr48cXjnLySEseU1vFcBe0KHX3LHnK/YE87JP+PKdHdL9QCTp
 c8/0602N19nKE2SGTlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200112

Add support for the LTC2305 2-channel, 12-bit ADC to the existing
LTC2497 device tree bindings. The LTC2305 is compatible with the
LTC2309 driver implementation.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml        | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..b246d492950e 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,13 +4,19 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497 and similar ADCs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2305fa.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499
-- 
2.43.0

