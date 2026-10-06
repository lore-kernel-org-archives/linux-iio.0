Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7B3BFE47;
	Tue,  6 Oct 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273497; cv=fail; b=ginbBgoc6OGRgBSrpX9uaihYT/b2B3zudFhsmvcdybSiJeS2XJWI8lkkYNyHKoSz9HtcJ3GXvKpSvcy9RhS6jEUDiZo6BWqPAT0LswzgsZGMgDEyxz5nPlSL8u5OaEr+rivzlGtTZmeXPBszI7CwF3R6G1XVSg9NZ77Pj9NOwtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273497; c=relaxed/simple;
	bh=mei6vO5jFLb501ouj/EdIGGaYPLm+NHbpDrlxsa/cEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VbSZew+DSl/ldgBMFjsTasig7C5mzc0ow3pKxsW5QPFpGb12JMErlhYwXXKan0OtU8sm3u0aBuEjRamUXuLVpjlYDZg3MjdoGJp3n1dqdYYWFu+Ho1FR8mwnehAw3tNgxMvkaI1rZGPvdXBb3sPuPBulNTPi9HbVj7HaOVrvax4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oXlboHB6; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oXlboHB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKXp6gjbY3a0Bm/ayYmv6gVSTOqXVs2CuANgtavmaow8TjXi3CnijXpSVhwFDsTDc/uqlgh4YxwWFi4O1SePepSD6G9qHEacT5syIug4ubQMGDv6B3dg+lJw12Nwb7yuVBobX0CMa/vZqwIrSLErUH7XFbax+59biwdzmIfmdrKsCrTmBflWhDRI+8Sj6yuvI9mF4s7xFed8PVy8oGSbm+MskjrvcKJU94FLSaYJJp+GGkH8c4gh2FnxisQiO1YWEPZfDVf2XI67LCofaT/ufcaGi20XobEp5kCgs1rSGhbACsdlHcBtrPEUH06Gl8jB4riwQO1UY9AMxzgrQ974Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH2mrMy3rHuWy6kJ2BiImzM59FdRpli3KNzfD62FcWo=;
 b=wjXodWXJYRoMUsSmWb8iuMPR4q3MgPckuzyTrd9unZncNphy7Emy+Yv1pqh3HrEeKw4eVR8WwLBOkExBxoXcdWYi9HqGU8Ib3HpMvGNROowFBsBMPeoKvlI/q24iyxbjshWrRBbCebpGdwvJtJjCumdyVjXEugcq2UhtCT+xolIkONeqYHkMd2PvJdm+LW6xThpGa+0gHZlV+sytMJgvMIgURejXjfO4PnflmZJiggujPSqVa+mwOPKqwpZfpPJht+qhLxf+sUdaiL/UkGesXMvPewQzU4512Vr2ZDZX5cj6kgW0iGIpTP6MljZxrVFoZalDqlrFS8KQFkIHgD5HYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH2mrMy3rHuWy6kJ2BiImzM59FdRpli3KNzfD62FcWo=;
 b=oXlboHB67EILD3I4NRqUekINyVaT7F/AB1dZP3Cpb/5eWd7xFzHFpKCQz448wy2yAwyAHks9a2nEdFuCQDOoV4Z9qnl0JxQURKKdAbxA21h7Gc9y7qRhr4zQprFAgegb1NwwdTmZBqLuUxNdOZsMqCeFTXxEehL9ZPorDtbDs5uy7mh/2nNf6Beunji/rxpZ37X5RzeilWGxeEHaGgDG63JoBRyC/NFheANzKQIIiinNnZsOcnjowFLT7d1psZhxcIU9lcC5oUNUK4H3TaU1w6SV2YTfFEkY94MmfvLrOaegEmtNaatebv0Dhpg+mhwkNrz9tzfmTnEkceJOvGjTFg==
Received: from OS6P279CA0153.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:39::13)
 by PR3PR10MB3852.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:08 +0000
Received: from WA1PEPF000099CD.eurprd04.prod.outlook.com
 (2603:10a6:e10:39:cafe::33) by OS6P279CA0153.outlook.office365.com
 (2603:10a6:e10:39::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CD.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:52 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:06 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:32 +0200
Subject: [PATCH v4 01/15] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-1-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Conor Dooley
	<conor.dooley@microchip.com>, Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CD:EE_|PR3PR10MB3852:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fbf7b8-dc10-43a3-ebdc-08df237f8f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|11063799006|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WV5pZDV2dSkf7sh1WkA6AY5GkpCXUR2tL4hag3eNu67X2ky9Fsz/ZWDa3wAp+3Kf2Z1MLrfmpGcvW6msvbp1OwYeX+EsA0GYevB/0aT67U53MKFMG19ncQHWS3vxATgB2UVyDxESvs4J2uh5beRbYDnKcbsTNYLcOQrqdkBoS6aSav9pkzGH0/jDe7sYNaOo5ZyrXfGb5fjsz9d/TEqzSnbaTJEIOIqxtvcCxH5/9ghWrgLS/Tlqq7cgWf6vyOJRPFk4i7OEwozdl2E4/srbSbaVTwk0MxeRApJnAl8Ue4vDTx0paDBA8GhFS3kqfEubF+3hSTGJ+cnM9X7RUOgtYnI+Q3CJrUyYJ/OkaJRxiu3nvb2Wc8Gn3Ro1/EHKiy7an6C1KVIoosS9+2FpWKNs+DRV+WLjt38D5TFrl1URKBILsqJ+pUEvtta2uTBKd1ynyv5fGoGlKKCnZHsqCcB3CFL5MR4Lp2Pd8EJqWYxPzBf/HZnfzKO2hGOirLUDncycUEaxRZa54bvp81pAIbzAMlweLZHWVPj1oKW194SSauFrBILL1qVOg9C4Qpl1ULgo0EAfAfhTVJKXKKpudaxL2yZz/zqZqQ7NuAswAitlShIElN8rqedP6qrowVELfxYPoVEaWBFw3oCyg09XV739icrPr350RreudKoQ3VaM6y9nrV07A/Wl2/z1Qz8z3sxGszgO/bwqphTETrWDa57/jg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YUVRXfbM95khWfOPUw36UJCdIyv5pSLfaYOKS+tbViV/RVFYlTfKzwydGEh/lMRqkhPTrvzybL+DiajI4qkmKzcNHQK/bIi5dNk0/GFmFN24SIjgY4mfsX4Xdgo1ImD69yrGWNYwKSKBE3kcjywJkSqdaPFTi3J7WqGm9CflP70c0iRRh7aE/h3jTixkS6Mg3plPyhdu8RTQJvuZP7AJp9xsJpW6FKuWZbZm56d/EX/TbzUjUOoXmsnMBT9V2795hH7yrkJoBsEXXKNiyrmt1N2Td7UPbA+RXCz+l3VrXfD6/SyW1+X+IyxWoxrpxwpQkpvCqivo3akRwPCdDq6HhuEioZ+Bi+Z0G8wVIcREC6bMoez1KESZI2/nU6ns0n4xve8mQ790oIHUxc6oYMkHqyyqLsOW+YK6ONpkm1xoVfa7GXfB7Juy6tjQ/jWqt51x
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:07.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fbf7b8-dc10-43a3-ebdc-08df237f8f1a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3852

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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

