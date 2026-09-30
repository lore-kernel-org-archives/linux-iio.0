Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645251CF74;
	Wed, 30 Sep 2026 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777967; cv=fail; b=iafwLCCiHHEGpXTfpNHgovvTjU98lhFwnhpWNpiBgRuw0xtgXpvhKl6zHT6IwOh9UYncUzTTpvK2S3SoBkHf4b3y1HkM8iQHbK29/T8+g5QF2vEyCsEX6NjnzqvQAVH+Afgtq3nugFMGY6lZ9Q6VSmn1scpUV1YpPYyUk4APl14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777967; c=relaxed/simple;
	bh=ZmD7qIcJpHxEn3+/61ipahgAIeApBqgICIKmygCBD2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YCIWjgiNLs2NGphcyJswujDR3oiZQMjOuxTX8zdWVI60jK01fOvQ/7O657R+DEjMv3RIM0BmlUrySdvJkyr9d1V80euw4EWWWqUjNJU0h+R/fHOU1mrxheILU//t6GZkaEBlz4gFjJW+mUcK7M3883SjK6N4RBECpM5myzAZjsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gmT07wT0; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gmT07wT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwikKTytnhSROjU1HcjTQFAbQorwP+nmDUywftdrSLeXKhS5y0K0GLa+z8AVRP3pB7JrcCX8PjHoKy5bU5uddF/1VpypSSYG1ZbMRZsR5KThRmcTKSfg3n35Axx9fAbUXU+sDT+4b5wDwP7AQMEeM6ls0waDU3mh1dunbmZyGojVy8AWWnhEHpeqnDWVt5JPiuXNduGJBEEYc6jF+dMJaPddSXsPL9VIPJcVQzoPV5d4rCD1C/SeoP0YWYGTq0O57RPenRHAmSb/JupxLvHZV/a9vi8Xguo528I9Jt56PM6IG5wq3pVJUcXIWBMOgn6YFEGdpKcJCQKqy1ihxso+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7tIvJgD2x09GrLWHzpho0MO1qmTrLP/91niW6izk2g=;
 b=l2wx5P9zTIxLwppAxYuTUXvtgFvQBaKLjGXodOz9Vd3cZ9DB08glReHS+ge3I0NPhWwqvhDGnt1LqAu6GlyDxjysvHXN6wEYNBDwV+BQXaYopYhRbyFMhE3doFgUoo+etb506VAMrOHsEotPGRKpjNzI4bz0hV6lqNxH7PRTXgDMceacDCuAyIGt48MZE6rPLKV7PIiSRtXUWxKVP16JQ7vPLXY5l3ysohPZXiMz1fGr5KnTcdG185HwCTehzD8W3nSv3gsqQYUeGl3ax5tIb21ZFL3SGDXtivs+K584TJlRvsiqPCbeCRSb+HNntkfkna2ESl5YXvUA5736odvb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7tIvJgD2x09GrLWHzpho0MO1qmTrLP/91niW6izk2g=;
 b=gmT07wT0/Gu3LQSlbmAGmkVpi9G2F75RS+n4H6Gsmx6mFy1yyOJuGF1n4X4JyLo7zxA/m1G4QmNDk5sdHANUVUP6HwPZPj0o1vKhx8jidXML/bKK+/TWQsP80Xu7orWXidBgHwYnSBJfdtVFaDnfoLhz6m8jxFLfjZkzksemUKoOX03T9K3AYwsArvnnsvWd5xvWlV7t0SJbWziBwnhaac4Xe34FPiCbUGqtjIhAkpOyGyNQQJaIe5AIe94zooyvpUoMgBn7dtZnWXkc4lHZ1SyE4RcdaV9by1yFIgRz2ElmLjoirpn+DXPZE7zqKeURPNV0LRN8VrY4BLyXv1CkZg==
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by DB8PR10MB3724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:11 +0000
Received: from AMS1EPF00000091.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::78) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:19:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000091.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:11 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:04 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:10 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:22 +0200
Subject: [PATCH v3 01/15] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-1-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000091:EE_|DB8PR10MB3724:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db25c75-9887-4f7a-38d2-08df1efdcc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JpsfeM9w/Mq0+8+oErDoGq2Akzrrm0FFhg09VJAnbJh5HCLmY3/BEBEveCShqrd83Jf7PikhymY2WZR5UX92Z3Ierz2831tU+7zx0GOvE7CVSaXQpJo9QD5P04U9Ud2CEYBKRB21Xc4f1YsWfrc99VnxNKCI4uoDasmL1nY6ZDG03yi/3dMHLbZhreFlmaioKS9IGBbr8XG6RY/k3qxUyfFY0ZpfNs09JAhZe8vpDv/c4dhheB1zcfffn8AC2+9koBk824oV7U2r4ES0Zx+Bw4WKixKDSjN4iImUVQpvf6rp4T4r9k+8B558PpcNOfbCWxhnelyROm7yvqsxbrLO3vahqz7i3/HGCpBzF8EssXVjYGmzfq34Gb2zUH9sWyERE94gT6lslXLC4AepG+fgmL0lXQe2BD64HgLP6GedN7k4yiV4RPiKVQBhRzXh5yGnCbvADw+pr8vnmNGXCD7nJ+LNRbtZ0El1o8FQlDIPr61C70J1Hzt3c+LhNixeN7iCPfQXGBkl5orGq/usNDMTiV8L+3DuBI73XZw2BRfcWaXIS50PS2+76GxDR2EBETbftSuu2YZuRN7ECARTff86fENkvxVddJ8TmA5YtuNtzu742MPLrpR/k91BkjO7NcsYI1p8Gk3QzSUhmDfbvYYc8zOmM5m9VyGA+TlIgwB/8rr4cT8rw2cinQnfXiBSRwOTyhMeWDNhmRRiYOyeV31hYQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WxhGVYexFF1JKRj8aIE508/HhSyj9YR+zI6tSX1IFhPuYcbP5BV3NYUZzpNmZI7wNPBvppQqdMM8PtLyCvR2ShfI2m2S+i6CIXB32NDNHUf40LzB78xZqOJGz7MDubjorcAFiY7yY6dfBAueUt70V5XQWV0MRSNmQ/01reAd3JXb6FZOKy1fikmrSSZK7bIvuqDHrdZI/qL9JQP4fg2YkwjWAsrd3jDtiSdHr8eRBOHWH0AAjRMPN7B8JM3mJ8LGuKqSptONgf0C+tvI7xygqlRR/WFl9JGtPGRie1XpBX23TTgcVl4i+lvYNaui4Fwx/qNPcZuCWdosvIn/6F3C9ltTaEDTOaam5gZbPxDP+8SPRASnSMB7zCXTdYB7c4tiWAgbGg/3UYqafrxvVfWBFP0LUgYHJmcEvFf4PYACcX2l9pOFmp8oBk6lc7j9ivhb
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:11.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db25c75-9887-4f7a-38d2-08df1efdcc70
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3724

Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
these SoCs, split into two blocks:
- ADC1 and ADC2 are tightly coupled (common registers).
- ADC3 is managed independently.

Each ADC has:
- 12-bits successive approximation analog-to-digital converter
- up to 20 single ended or differential multiplexed channels
- different trigger list, or internal channels interconnects, hence
  add a dedicated compatible for each ADC1, ADC2 and ADC3.

The trigger list varies in between the two SoCs. So add a compatible for
each SoC/ADC child.

STM32 ADC may be in a power domain: allow a single 'power-domains'.

Restrict the last channel (19), as it is wired directly to ADC Vref+.
It's meaningless to have direct measurement. Internal Vref with
calibration data from bsec (nvmem) must be used instead e.g. vrefint.

Restrict deprecated properties (st,adc-channels, st,adc-diff-channels,
st,min-sample-time-nsecs).

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Drop st,adc-trigger-sel: as discussed with Jonathan, better to
  describe each ADC child with a dedicated compatible. It is robust
  approach to distinguish variations in trigger list and internal
  channels interconnects.
- Drop unused fallback compatible.
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index c4c4575d3fa9..e7e92fd4959a 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -28,6 +28,8 @@ properties:
       - st,stm32h7-adc-core
       - st,stm32mp1-adc-core
       - st,stm32mp13-adc-core
+      - st,stm32mp23-adc-core
+      - st,stm32mp25-adc-core
 
   reg:
     maxItems: 1
@@ -78,6 +80,9 @@ properties:
       Phandle to the vdd input voltage. It can be used to supply ADC analog
       input switches on stm32mp1.
 
+  power-domains:
+    maxItems: 1
+
   st,syscfg:
     description:
       Phandle to system configuration controller. It can be used to control the
@@ -215,6 +220,33 @@ allOf:
           maximum: 75000000
           default: 75000000
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp23-adc-core
+              - st,stm32mp25-adc-core
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: adc
+
+        interrupts:
+          items:
+            - description: interrupt line for ADC1 or ADC3
+            - description: interrupt line for ADC2
+          minItems: 1
+
+        st,max-clk-rate-hz:
+          minimum: 700000
+          maximum: 70000000
+          default: 70000000
+
 additionalProperties: false
 
 required:
@@ -244,6 +276,12 @@ patternProperties:
           - st,stm32h7-adc
           - st,stm32mp1-adc
           - st,stm32mp13-adc
+          - st,stm32mp23-adc1
+          - st,stm32mp23-adc2
+          - st,stm32mp23-adc3
+          - st,stm32mp25-adc1
+          - st,stm32mp25-adc2
+          - st,stm32mp25-adc3
 
       reg:
         description: |
@@ -486,6 +524,39 @@ patternProperties:
               maxItems: 19
               items:
                 minimum: 40
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - st,stm32mp23-adc1
+                  - st,stm32mp23-adc2
+                  - st,stm32mp23-adc3
+                  - st,stm32mp25-adc1
+                  - st,stm32mp25-adc2
+                  - st,stm32mp25-adc3
+
+        then:
+          properties:
+            reg:
+              enum:
+                - 0x0
+                - 0x100
+
+            interrupts:
+              minimum: 0
+              maximum: 1
+
+            assigned-resolution-bits:
+              enum: [6, 8, 10, 12]
+              default: 12
+
+            channel@19: false
+            st,adc-channels: false
+            st,adc-diff-channels: false
+            st,min-sample-time-nsecs: false
+
     additionalProperties: false
 
     required:

-- 
2.43.0

