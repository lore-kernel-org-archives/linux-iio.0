Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2846C4D0;
	Wed, 23 Sep 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177977; cv=fail; b=mcBJ0ePAyLQUNPiKcwVvUkLBRjL6V+nmthMUlv1rywT9mkOB3TsKGTauhk+l95WgRExjhpCYVPk6OwF76RsOtDQY8F5OcwLANCBUQxQyWMccIEmVEd7g0Q6qJ2HMGyamDpcHz4GK/OSbaR9n89BWm8tTaKe16PInnyv2X+kyVf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177977; c=relaxed/simple;
	bh=ZmD7qIcJpHxEn3+/61ipahgAIeApBqgICIKmygCBD2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oL7+vZzh7VJHnPu0mAFxBdTq5t8T/ZSSevUlg8P1C/2+I6OlAcwNMI75pk2vwHBRY1nT20F+RcWkrHeXJ+C4UBNt/tbvH22uogtCXYZwG2hrrVhqrKiwKVT6KU76wYepn/yoGo7UFBfWCkiXRw2UMFSj1R+yU7ffhRU+BXk4rhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=farif1eA; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="farif1eA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK3xEvEtTCZ5syOOfp9dj15u0wIwArNXCJtlkM9pwt0VcWghZD0loZsQW3aK2u4xE8Q8SgewenCwpaQMTaiT1RqoTOdwMYvEtujz1LaqZBzgYret41DwYeMib+xXcMyAY5E58hxTfddOtGnkgaiU4/lEUtWMiP6escMtpPBGI5Dwft4fBs1XYNPSLrNEbw3YqL9j8IitOcYcDSB+ccNetQpz1k1BZVYefylv1c8mqOsdwnL+Kc3zCkRcWIUPdL1RtpdFqb/gHmBqXjdHgyulOaHpcpZRIaOfAwYUdQBr1X4KB+0Pqm5TFuVVVBJ546C+Ma8XeeWFvT1jse+5IYxSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7tIvJgD2x09GrLWHzpho0MO1qmTrLP/91niW6izk2g=;
 b=y7jvuF62hUdIDiMAf708BD0TNsaerHPatDei7XrWQw3gwzprrLij3oaIXVOOb274xOMC68xGpBHSqHgUpPA/Dbbvv+7Eb8DNl9aFytt4LpGiV+dr+OcbsbbmAwmdcDhWGF4yamwcOmYts9TWLo7fSP0DnJEcJKSszFrk9fWtM9lMaax8y3MNBBNuOnSgL5Efe1a4PCVihW5/Hcnhyui7xI7y7SWiP6eUnJooW0lejeJJ6qXrOEup2hKbpPzRszA1EYWM+XuMaS7gRKPdbsi0am2II+G1EBzVIB7c0bucHM2+llCG+93ljohQGzDSv1vRwkTtEs9Zj6NeVnnXPQMtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7tIvJgD2x09GrLWHzpho0MO1qmTrLP/91niW6izk2g=;
 b=farif1eA1/ycKkCTAjGee/Rp47gqOWzk2WStlWuTekwEJ1zLMj4wtikXX384dyCXmB6aWBlHbW72ARnex2yT2f5bLzKF3Cv+fYYq7RL0er6FFqMHKkriHWQqkyyYALYl8A/1kiiKeTnOGWfTYkd4sVeRrohJGL4NlzQVqKUg8yGhrpbwyyDXBWTwx4rdeQ6K996y0CJDGiiPMrFL5YFq2Wf54UCr+BFVntyOrDbciX7UnnxV8H3dG/CzcOq1nDxAE2yqBbChgiDkKxBpWJH108kPWwNQSFCAVksBgFQr5FoRcwmHSYMOqfU45NomU/eh6+U55+UBQ5arJJOdjUssog==
Received: from OL1P279CA0045.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::14)
 by PAVPR10MB7036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:30 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com
 (2603:10a6:e10:14:cafe::2e) by OL1P279CA0045.outlook.office365.com
 (2603:10a6:e10:14::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:29 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:17 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:27 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:04 +0200
Subject: [PATCH v2 01/14] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-1-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|PAVPR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fad786-b74f-405f-9dec-08df1988db69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tLMEP2f4ftFtuvqm6C93gjzJNAyqt/PB2PKNxa/HNNK9shmT7uDyiuXcwrC+xKAHLQdAlVwh6yhZgWYL0IklKi4vsjK/O7LM+aoTqcYfjekELDQmKm43lthHXJf6gyVV4l/L/20DhwUEqE5bxTZ3NbfQtt6wSmd/CW10E13BArtViExqf/E6Emym5d/EfqVW7993ZDgRVY6A8BDCizk6/M17V9ukm88+6wLsuBKO5ldvD/4hnyrk8T5j8VMBoR9MyXO6GE44rEgnpLVhbq/rHPusf8s7bTd1pIqKMm/TTUU1VY7mST3G4oPuCLkZ9TYhhcaQU3YD30Oz0VAeDEp+/P7WC/eo65Z+dfGXfpkz1VOTPSW9zDtWnVHoLHGTHwoQHf7QD9VihWECOcL/7DX004sl5olSnxqUCQUvdi6zPnWo/cYQNlNprkZJnW5aHVy8mixPRnm/lKBIrC3/E15WGEgJzxBl6MV4yWrwC/kWhO4SDT4cI7Z1v7LJps2yDucUNijehz5bcBYKKrupIbAiWB9Hjo7xisgHqjJU0onbjzUA+Q4E7p8J5vo7fyypndnlsTZeuSHjUSkCrUMVgV/sUuMfkYqHzeyAdsoMqtdO9RWuFvaXjwczvTHiqDZ7ZAmgRNHg4K9HPg47IZgkEw4M3zH6qnR2PIl6u085qXWMoCoc01NnEYkEU6zeRs5YFfx3RjDRrZd0HJtn/1AhxvS+AQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u6uTE80zxqjf6++sfRiu1N9ntW3QR9sEGlkm3dlCG7D6DY29MXwOKPz7vHJAT0G58g20dQjCEeTOQLBjnqai/73ZvKEY+h0EvNW1qGyQOZ/saphQGABSPc/bIPNEMxFppggQWCGw6aDu/IsAh6/VO78B4FwphuhQyKvWtK6A332soi4CvjTVBzKJt4NWUZfoqeWX2VwsYFfTL5Wo/3QkO5ZgZJ5nNGmS0c3o3RejayFKrdTtpeX+uDtiv7guwRHKT9RJftLje6mLOBmz0outPcGaxKj/wbeZrm2yiPZscdIRgVdDvGu2z9+Irf5OtRFgR1WY1lS+0LJNThhsHauBIJiFv5j7oslDh212GeCmsZEkWd9kDyaB7U8zUo8PgbiJAxnZ7vUYKsBthhVwd1OsW11Zp7r0Lrmuh1rmeKx6OXfPdBd+8JVXnHYi72Lvg+PL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:29.6165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fad786-b74f-405f-9dec-08df1988db69
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7036

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

