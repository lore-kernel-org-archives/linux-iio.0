Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30638490BE8;
	Fri, 11 Sep 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141910; cv=fail; b=gQPEFCEDWJGAzgAV+XyVuiKMHL+9GclCdoZtgFVWsWeHpK9CbXDnRZ3e1i8cxEEIDC0CBy+NkA7pgr9Wi0IUgbhghhjCPHIC8JP27ewSwcEoUJwoFbJI2+sSC0CkRmkZHFbBW/yjncbVIwIX50/ZYG9gh7+3T/EKqrA6dwnOcXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141910; c=relaxed/simple;
	bh=f+wOGawaNi06B9Ip/YWWJqZEMxZInTLpB4tvsOetvC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IhZAlfoq+nUTilfc/xpQFrW94q6psON4LrPgt7o8pOBT72mM6eZd8i5/UoM0sYFf5ihaa/OZ3gkyQJtTA73j0AbN+d7ccLSSZCmQ09dWFIlfHXPn2CkIvB+MenFnH6SQ4Uo3XJRJ7q5uNBkhptobgLwLZZf53rBLE5QIwaFLI0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YDzibOwB; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YDzibOwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0AKnU4K3w+TwaGa1cvdeZS1HEAOuKesIluFiNo5x9IbsgYICG5Yj634MglW0UfN05OWF/4MZSEd5/fyYhIt23CZUcVqhpuNr6Gs68r99lG5122sRIlqYvHJS5iwbvMpCq5haJjbAbTYXgagbfALGUjrS5MGVe+3yAwhquzgac828+LUmKissuD3BjfO5+dHI9b0HQ3/VsouvDzfOwMCllkYnQPF2+1gVB8TtLaZpS88XmlbpggSICSAMDRd79yV9wVl5oeBmKW+tuZHoX6uFdfMKrq4XO5KlAwl10lnNlO7CeXuH1DHoaxw0q3Qfcb3YOB+yjAyVk6xMyP3dbWfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oatJG2Ox+GjRP4iNMIlHjHHGE+vv45zsRlQBIh26KX8=;
 b=KtpKfWhVTGM5vo4B7CsBRfBuEPV2QeLkbLtxIbcfCbzIqS+kdamebtttJbo4e6XGRi9EN8wEuHtBwYHvM5ea2XHs6+0wo0MCjGDxB4lFxtMjPdbpbO3/tKvkYg3yyLePHiuSlPg0Eb18ONnfNFcnO2tJAnfW4qqnU2JJkoXpMt1v7WsB8bTt3vxTq0VbS7kHFA9seaS9QchNxLzeO8Bb3MKSC1IwuwFQUIwbJBwab7EumJS+oEJs9wbUD2e5PyAw3N1sDkCofV3yX/hm/w5dWRPdf7zGoyPLJ16Ms56g3HcnlU0mjLG1Y7k2+Ysj4YG/fZgRzyO/Z9FqXdYtpoRsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oatJG2Ox+GjRP4iNMIlHjHHGE+vv45zsRlQBIh26KX8=;
 b=YDzibOwBZT2VTHHtBYrgn0Huaau28WOd+6/uqzWZ7Xk9jtWWTR9vH6ZNnFdH+2FHznCdA3SrEUt/xcEcFMdJHPRBKsanJhkxXbFDhUpvByYMPMeyCw0AGqs0c41iZcx1BnOD+fuGYU2X0uB8zUjkuWWxk+dsz4JgGEP+FTAgvvOXX/nlInBP+RrpzS0VbLz2b81WK65opJeaPtYeruY78c108/IaZben6Eo5RI54bbPXinXY5RISKP2W4Bu5xsJZ+clO45TsPFLnflOcsVXbWhNFm9U58uCkxiwXf+N3UZrTAGwnsduZnv9iAcDjGBLCbuyHLum9JdlUNWyuMfbd1g==
Received: from PA7P264CA0157.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::10)
 by PR3PR10MB4062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:43 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:102:36c:cafe::79) by PA7P264CA0157.outlook.office365.com
 (2603:10a6:102:36c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:42 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:44 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:42 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:23 +0200
Subject: [PATCH 1/8] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008482:EE_|PR3PR10MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7013d8d2-b5a9-4469-ca4b-08df101c937c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|6133799003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qoqF6FrBaotiJkYCcwDIMHn+cDvdRVcvMqypgqAK9lwLaX1CtgFlGuz7ZWuo1LdGLt+XlvM8Lq+VgR3/bN/b6o7BEbIEpquzczuh/8NuNhTpO17QTQqpQ/mG/IC2q1RMXbbO/zfZVKmKn0tprIYlXh5Y7hsFqVBD1avSAhsRHVyyCV6O7IItH1wsf5lJH0cX2FtE8tHczAlFJqi7YaB9CUHgkg7RZ3YL9TfZgPsGJYWCSqMKBzCvt/1lDOrlmLgYUIGIXUfJNrNzS6QYBOGpEXaGqD5Iwr+L8NoE/rOorU4Z42YOIddR5ZuGb1UlI9ub/cjZWgZ8Q5vb09dMNqCuSJYA/Vb5VbnE1gK6sQFuLGtZBVbbCbSSOMPOXGM8yT8bp9uIdZw8W8bQ4MCy6h0zaveRR7Zr8ZDp63FTFFmsE0vGEz03XahTpPXJdyKoaBafv5QsPEmxvsnEOScf/DsPZ3GWO7y++iINq287IhDIsXHXcePjPaGnfCa1ZCJuyiolHGrxAHQCtMQlC24BtA7d0B73LWzUPKvuIVmQRNXaug3CEWqeHAYc8TUoVZEBtk2h/LhNW4kRr7GSKyL23xMufMUimyfFsbcg3Lu3B3gSWhSMbq+csuqdFZMxelKleScKTtPcq8vArbyLBWBR4tBZvc/6mQtEjPjkLJGNpp2HV1Kw4DUrPWsqykLHprcsabAdm31r5XoxLoqM8ucMtHAq7A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TqlU6FoSZyZpxTHvpwHY0w6oLvlXPeU0ituoNofBFOut61QeHtA7o7TPXLalyOKF/SNp6UQFqATnZuRehfH/jq5Z4a7ZQwna+c4E4eeK6ySvwTQ3OKHsqa553nC1RwfFomw1SsKgtf7ALPoLV9hFypPyqOJ7kxtBVhM5aewo35FAUypqDxua6OYbkG5KHMQnPJJYxTugrYGIjfGPsXMKc2tPQ5fdbdaENKJqq4+qnNo5j9jSowqE2YBVPqgXupSYcTJLo3ot2SnrigC8hc5s1PZNOIea4sJN6EdPf26J5+T2xwCN5HqePJ9equMuCAOuIcVWPTfQYWV/GvnztgiSKw3MjfZZOBEEOejqyXpginT0kSNyIpHe3/P1zO0NZKQi1/+irQDNcd/ZtEvcVFsfa54KDNTPYzG3W2A4eTUJoWUMT7qKNvSEsEZF7O9XXQ/3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:42.8598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7013d8d2-b5a9-4469-ca4b-08df101c937c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4062

Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
these SoCs, split into two blocks:
- ADC12 are tightly coupled (common registers).
- ADC3 is managed independently.
Each ADC is a 12-bits successive approximation analog-to-digital converter,
with up to 20 multiplexed channels that can be configured as single ended
or differential.

New property "st,adc-trigger-sel " allow to make the difference between
the ADCs and to apply the correct trigger configuration.

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
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++++++++++++++++---
 1 file changed, 94 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index c4c4575d3fa9..0e0ceaa3d8d6 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -23,11 +23,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - st,stm32f4-adc-core
-      - st,stm32h7-adc-core
-      - st,stm32mp1-adc-core
-      - st,stm32mp13-adc-core
+    oneOf:
+      - items:
+          - enum:
+              - st,stm32f4-adc-core
+              - st,stm32h7-adc-core
+              - st,stm32mp1-adc-core
+              - st,stm32mp13-adc-core
+      - items:
+          - enum:
+              - st,stm32mp23-adc-core
+              - st,stm32mp25-adc-core
+          - const: st,stm32-adc-core
 
   reg:
     maxItems: 1
@@ -78,6 +85,9 @@ properties:
       Phandle to the vdd input voltage. It can be used to supply ADC analog
       input switches on stm32mp1.
 
+  power-domains:
+    maxItems: 1
+
   st,syscfg:
     description:
       Phandle to system configuration controller. It can be used to control the
@@ -215,6 +225,33 @@ allOf:
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
@@ -239,11 +276,18 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - st,stm32f4-adc
-          - st,stm32h7-adc
-          - st,stm32mp1-adc
-          - st,stm32mp13-adc
+        oneOf:
+          - items:
+              - enum:
+                  - st,stm32f4-adc
+                  - st,stm32h7-adc
+                  - st,stm32mp1-adc
+                  - st,stm32mp13-adc
+          - items:
+              - enum:
+                  - st,stm32mp23-adc
+                  - st,stm32mp25-adc
+              - const: st,stm32-adc
 
       reg:
         description: |
@@ -294,8 +338,8 @@ patternProperties:
           List of single-ended channels muxed for this ADC. It can have up to:
             - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
             - 19 channels, numbered from 0 to 18 (for in0..in18) on stm32mp13.
-            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
-              stm32mp1.
+            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7,
+              stm32mp1, stm32mp23 and stm32mp25.
         $ref: /schemas/types.yaml#/definitions/uint32-array
         deprecated: true
 
@@ -344,6 +388,12 @@ patternProperties:
         items:
           - const: vrefint
 
+      st,adc-trigger-sel:
+        description: Selects the HW trigger configuration available on this ADC
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        default: 0
+
     patternProperties:
       "^channel@([0-9]|1[0-9])$":
         type: object
@@ -486,6 +536,38 @@ patternProperties:
               maxItems: 19
               items:
                 minimum: 40
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - st,stm32mp23-adc
+                  - st,stm32mp25-adc
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
+          required:
+            - st,adc-trigger-sel
+
     additionalProperties: false
 
     required:

-- 
2.43.0

