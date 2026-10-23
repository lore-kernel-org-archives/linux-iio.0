Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758649;
	b=hqDtNFx9nxJGielcC//QrmgNFV3zcX4tlgI+CRtDBBn/lzKsiFf9KoVU9OX6kN+4sbzB
	 AikU0+QXp+d9d2QryqrV0/JSHOHL9FSM9IrgHAj18Po04pVWx52UZ7GXfDignwn8nLF1u
	 lqnOZHLzZqLPVug8+LcpGw1plK6IuYXFh1gQ3vbjdvpMP40prkFq5MxRyzq7Q0TE89OxN
	 miEzqXXOR6YY7KZZG3rYGBk9Mhcoa8HKIJELB1J08O5IW+jhv0E1rbd1C5L7hXukrIRPX
	 Yrzn6dRTuZTmI4Rj8VnrNHgADt/KP9f4REG6BGmdLEryX1pMv5wLK3xTJhi1Kks08yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758649;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cC3Ha/M5+HIbwT94jPcK00ZYzRTp+w1kerU2dGF23OE=;
	b=lqMK5kk6r4GOxgrVa8/LaWnO6+lrCHPLTJ2uxwYD/58yJuA42HSnpNF1iLSRI482cI3S
	 9teZsMnULdnj79c4np1oCPNNRFu6dFBW9wtgTFsZJ6RoFvpsblHDUNchSl3ZI4uTLu6pl
	 n9isriMGEGn9sqdosUSvz+YQ2bGO+jtafNlmznDOLF6cKdCbSjQDJJs+i2gWd31LaDvaD
	 MbZyTl2ZORSbsMROgewDfnX+o+TPSbzm1uvLNcdfbbCQJTRBejCrR8Mrz/9/DCLDAomG8
	 4TlP5epaLELIbhmDuC8NSFzBq+mbMn74MbOWiV4JgvTSwxG0ftJryhpjcQgoDuKyYkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jeTmUx4D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A1606A322;
	Fri, 23 Oct 2026 12:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56A1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jeTmUx4D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxRC71f20WB5hKRpuqFIOLEtqOp1+WyoKZDhLQN3DY4DO521iUYGtBKDB/JMLh+waISYRodBJjHvx/A+8BplHyEMz328shamMo1pCXTVZjFVavtQswKOzszZpX8XrOZ0YCqOzViBnQLy/AX/U6zrd5MAB3OO/oSCWud49jZPacXKYKlSol75UZ9jsG87Kl3YxdzbAY5mYEyeO2mKYqmBXgFNM/otBOVTZEuEytBz9TVsh28+FKEsBZ1efLxracC8+9eZaR92fMXaKOZe4Q/CXX2NreDNMGPFqiZFoZeSILVM30Q+IlI4qKQw0pAfCUgzrsprui7+2+f4L0jmrjpG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC3Ha/M5+HIbwT94jPcK00ZYzRTp+w1kerU2dGF23OE=;
 b=BhJq90ckdrD7g8vg6xQVSrrlW/fjWwskPpcVI1I86XdVqeFzCjcNfky1pwhEZ0ep5afS1PL2yWGhIM/IlbtaORQpihbFqFGEBrfYm39bGgFn0haJyvcerNhtGuA+PYZULe1R9CLoJaH6Tl0fYW44k23vjUnnqCfCHNKdEJTCWxNI/VSyq3d1F/Efo660ke/+oMTeWOwGXHOS4VHLnluHpU6dKcIOhMRftAHcYU7AgDzcRYsO0e160BS/6nJCX3Aan6PiK2Ii68OkLmcZPG33xejUBY8b+2aYigDjCT8Ex8dpFYA+FurRcaiXMzgD+LKMbJyM3dgmhv57jy5qUOg15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC3Ha/M5+HIbwT94jPcK00ZYzRTp+w1kerU2dGF23OE=;
 b=jeTmUx4DUm0LuvVzA4Wai/RBJk6PjLUQ2XxAGMkUU7cI1qG+JwygJX0srpNR47lphabZRxrrRkVy51MnkkV/t0SJj02VFGEY4PNN30qklTt30bCgC2TbRt3fijYjm7Xjn/ysPuDTBLt52YygWvRNtc9VInHn0NYhMbObXHWE8f4=
Received: from AS9PR06CA0353.eurprd06.prod.outlook.com (2603:10a6:20b:466::30)
 by DU0PR02MB7972.eurprd02.prod.outlook.com (2603:10a6:10:328::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 12:30:40 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:466::4) by AS9PR06CA0353.outlook.office365.com
 (2603:10a6:20b:466::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:30:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 12:30:38 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 14:30:37 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id AD6F32CF2;
	Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id A4A08584AC3E; Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 14:30:28 +0200
Subject: [PATCH v2 1/4] dt-bindings: iio: light: opt4001: add opt4041
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261023-opt4041-v2-1-ee320812804c@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
In-Reply-To: <20261023-opt4041-v2-0-ee320812804c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008F:EE_|DU0PR02MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: dec70b1a-36d0-43fc-ca21-08df3101722c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	+G+A2kgBxClWLAR4VhHrBukIKO+iXi7qjYVH/muWCfhu+1/c+Mv3dA56oMCdWWxacIeVcGKiQ8f01TKIHYuO4NzEUXDuAeaz3azrzcS/d4BGKZcop+wlw26UvITT2IJU5j+DSVq1RnWUqpLm0YpsllhAeHT3R08CiLbKCDYQ5VS7TGvNWfo1+NnC8h83K55Y3OTMzgI8dt9dolNt8uCEDpfZF7M8rQA2OL541cAPw7aXmr0FYBh4JsQaXnnhPHfLZCGWmzHJoTk2mCiukapIrHmaoBlE+NqdUoVLAE/NQlEAqp/IKplQOUqItu7Y+FS0go3HoApLEnPuThCt0aQ/OnlCaTpOMfgyD5b+3psOQX7RDfDERJlkWkebsv/W9WoEvH12/ZK3haOUvgx6jFW8Zb5XqdndMf9BsMgLppFd19rCf+z3Df1sJky0DihhR5yHrRMcyAKC6Dzqitjt3tP6A8k9yl3m6cPOsEui1VMGfSPxxbaKlRSRBisfp+JxvR4vAXfFznpw044ffJtuXidcUh99KNZuHnjlpVO/chkT4rHvhj5qPDltVaIP4bOL5LBh/TOPVCwcm4T8UAyCGl3xUU+ciYMBDPCrGeAdVFp1I/yemE+mb9PitYs6eabyAWnE8YuPn5Z0Smi/v10r6XlVbA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VmEQryaM+LGRliiooIVAQcJrl3di/mesZvEaQ7tG3/ohWeDu4FHSkU2LwJ4iFLDS6UPH4hwpdVPUYWlpCMAhq32B9ekLm9ywv/qlLMcILiktB0fkCV95uP+yFq/L8wBt+BOJeCl4YAM+9lKk4mAZk7FFhPvAQcH4p+LE/nfyp5yE+RAHsb0se8DNEiXlUIVHzcFvwecg93OFzmhBUWmYpCx54JM6mtxt9aERmmo1uNj9RZswiXnXqBSEP/Q/xYVkUSR2gzNaT3acuUptjOZgL+kowCdcpm8pXM85KU84IsQ4FwtO+kVPig5onBs0mVFQsuRJLdV8O0Oz9i/QcfCErx9+thgzQFrMYykTo5AudBiv0tGfPx0YBztnfZM8sAwlKkV58DSYuoseJvQJ9DJuVGwrbDF8hmH57bUWsY8kjYnTBB0n4uUDrJOOQ31E89Nc
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:30:38.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec70b1a-36d0-43fc-ca21-08df3101722c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7972

Add a new compatible for opt4041. The opt4041 is only available in the
SOT-5X3 package. The device is pin compatible with the opt4001-sot-5x3
and shares the same properties. The opt4041 has one additional channel
compared to opt4001, the extra channel has a wide spectral bandwidth
ranging from 380nm to 1000nm.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
index 12b0c7ed5d72..35e9b0deb944 100644
--- a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments OPT4001 Ambient Light Sensor
+title: Texas Instruments OPT4001/OPT4041 Ambient Light Sensor
 
 maintainers:
   - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
@@ -13,13 +13,16 @@ description:
   Ambient light sensor with an i2c interface.
   Last part of compatible is for the packaging used.
   Picostar is a 4 pinned SMT and sot-5x3 is a 8 pinned SOT.
+  OPT4041 is only available as sot-5x3 and adds a wide band channel.
   https://www.ti.com/lit/gpn/opt4001
+  https://www.ti.com/lit/gpn/opt4041
 
 properties:
   compatible:
     enum:
       - ti,opt4001-picostar
       - ti,opt4001-sot-5x3
+      - ti,opt4041-sot-5x3
 
   reg:
     maxItems: 1
@@ -39,7 +42,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: ti,opt4001-sot-5x3
+            enum:
+              - ti,opt4001-sot-5x3
+              - ti,opt4041-sot-5x3
     then:
       properties:
         interrupts:

-- 
2.43.0

