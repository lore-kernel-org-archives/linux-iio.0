Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741737;
	b=JJtTTDjDyRBMUJhJREJYaACM2kU42NpCkGoSfEZc1803+U4qfF5Sr8N7xNg3NKXk/IXQ
	 e2CJGWNDvEI7YIVotsmjYyGUBqqhDtRYWZADJuDUKSo3HvPSpEU4Qmjt4ixsBMjxl1jcq
	 XhSzhuIGmlJrFvUudWH+5PZ6v3yZHuMcxdnCAG6Wkq1r/aqIuQsH/jFKqXtfkrM5aUnQP
	 6RcnGSZwFU1ZGFJbyVA4kB/+q73NJodC8lueEwMNmprBR/6VjXAm3bEa0970LFhnqAhRU
	 ahicczjosZ3AaZbcL18IgEISjm5Jz8CFyH5fNLR7EbUh/cVcQbjdspXT2xNOkS85M6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741737;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	b=Y2rSBZRCyXV/XyvCbMEvSJDARcxVuSzseV5dazNnDnKvEBvCbuqnBYd9hEdSvcl28hWM
	 U7+sKI2E6XL+wv1gvtAmAeBJe8IcjV5M1tuTB+xuIGW4BA1pmqpp4BMZvNRtZbv+vXm/3
	 Uz3wtN1maJfLuPv0v+lTzIRvWRfGmBC2PsUhPYAMqNNDQ1N8waZIHMPb0c6WhC0MT2Oq9
	 xzGcZbELtPvTQSMME1ynILwAr0TgTfEJwT/Qim80zlvhZMuxCGUk80mcc11QFMucsHe/C
	 d1Dofs0CW+AsIvdNEmFjjIICKj153rSetkIrGCuxTYoXz553gcz5kcF0oe8u85/uapQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="keOPfOo/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D865606A322;
	Fri, 23 Oct 2026 07:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D865606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=keOPfOo/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjjkVCC/l2d7bftCUe22YIoawhOOG63ytY1jgWGcVMlKyP4CZn34DOlzxL9p0+iPVteOKB+/VTTHQZAkcWvFpNCYXevwWkmK0e4imz+n9beoM/C75bygHaGDK5MRFL1yG93xsqeg9XtUbwhzqE7tG8h7SkZaHyaFPr21nux2TzfpcDP8m0vylfIRSh/Hj9v2ScTYv7m8P/03knvw94n9s1/VSsCz7furUhRC+3V5SfC/rFbLqHvFArYOOmbkqXI9JEiM4ZihCy+JuHA6pCWhaiXwE10FUN5sSqmsWnguF+tsHUVFxf8XKVF/jzGhqUQuF1ZevGoTGymvidOKTPBXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC3Ha/M5+HIbwT94jPcK00ZYzRTp+w1kerU2dGF23OE=;
 b=KS+nTGbfS7USEJILP9SHIUm0jbDHa4DzQX7MqK4RlXkGTp5OJMN7l1WN70lrmeSoSNXQY84xsK47Yo1nryUBo1UtX5J2POKHdnfKsZGgaFVHXE2nGcKWktXfGPLqFSCb9dDMfXob6VjJKVkTf9VkYUKnpeqwlOUsnj0grP9BBk/K5TUHYNItXh+iXZuOBQTTMQtkrEkFVkdyQ8ZT7ipN9DVD8+GjzMaDGQMSkP1Stn4NRRhq292+PLkSKUTthOkX8E5ZG/61HFRtkk/kDqNL/XRuqjePvjl3ei0yVTpAreIeph/O/B2guah0E11LKOQdQh2VBSLtrm9iYYZbocbHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC3Ha/M5+HIbwT94jPcK00ZYzRTp+w1kerU2dGF23OE=;
 b=keOPfOo/3hY1aIMgsAcwE3qX799DqicxOZJmhABt+g56Xjd9whfNEoeJzKdfvQ0bRZGhKiWBIW7sYVkmyWNc6cdD3MyK6Khd2D4HvWEwpKmP46FBoDqSPIc8lgLBq5G9Ar6IkIaHi1iY8OZSyJAKV6tPck4jnydbENgU5FTa1zQ=
Received: from DUZPR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::19) by PA6PR02MB10457.eurprd02.prod.outlook.com
 (2603:10a6:102:3ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 07:48:53 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::24) by DUZPR01CA0041.outlook.office365.com
 (2603:10a6:10:468::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 07:48:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 07:48:53 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 09:48:48 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 131BE3CD1;
	Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id 0D657584AC3E; Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 09:48:13 +0200
Subject: [PATCH 1/3] dt-bindings: iio: light: opt4001: add opt4041
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
Message-ID: <20261023-opt4041-v1-1-45227f82d05c@axis.com>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
In-Reply-To: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|PA6PR02MB10457:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e51fa9f-975a-451c-c2a8-08df30da1575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|18002099003|22082099003|261022105027099003|13003099007|3023799007|11063799006|261009223027099003|261021123027099003|10067099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J80IV6qkW15uLYevB3aXRj1NQ3fjQQT4e0lJma6f0Ptei8TEenL91sc1Gg+5H58QOb8L6qrcs18vgZryvzq5CpO8PH1jfqti1xMSutIdM328FjMWzWkO4RxcIuvBcn95o5vJjSbhCdFJEz1tqTOO1iRKTZBI3YB/z6ulJ8r+u5C5uJ1h7MQvhGjWA0VT5bZqNOYd9IaL/KOybOIiRpDzqFsoXbbz5IqoDUVENppehFFTGCVZCVtfSHu2J8rm269qbOt10KuXNgqLu63F3D0I6jtYv8R2DpByrHyJzjHE6DUF9XikADlZnrUrH3R9NZxdKd15ciTk4ofvhUihsZuIEElhH26Je8AQiyCW8eiK9s7SII/vpdG0LAnEPmuBKNWrgB6X08yAYyMrLjvnMCjEsuJZanUy6iUlqrNtNO3Aejz8LppWVYU45KmV6uUhpCbqjR0yrew3KR4EfHbzHL3bzXvzyjys0o3I1APPSk/hbyCaSaX19aeb8TwLp9k4iTKIk7m4vyHD29RYw2cFtJJNY6EEUdJ10ySzTvO1oAnVvpMcVM4dTjA8A/c2+XP+CAOyjN/+CpP3CmU+LaZUgDOVnk9n7k2eJ+RQ39y2c6QvZiC6yqi1P1djHptM+xF189Pr5E/ygonjo8U48Rp93XtYMg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261022105027099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OnuKnA3cDH16TVxbshuabKHfAda1wYLOb3Phr0q9kzXRPoO9k6rtOT8XqZSEjsZgvQxU9N74ChWdsWEMIAzhvcx/jR9JIE0UUbAmhFcYq8KmVh2ZppXYqBbVGGcRWY0zkN4Flp6/iZcqv0F/zFENXdxVEA0JyDQFoOitllad4SOxcUqRXkGmCL5+gEYNC1Z8TkGzMJX4Swt1VdhtJyCt9dkQesFX7YuidKyn6goyXUvEjxsnzCNcNbclKokXmt1bjkz5x6l/OA+voz3LzWcKwRTq6LgIoVDcvv85JCTvONMAwfwLabWs4F0S5GrtP+XPryoe0pGrXPb9LqICzClWklpCeD1ANjsN8aaJq+f18szO4DsoCYVCvaHMOIOpzCGkwGGO0bjDKZawOXICPnkM7p3cWtAHDuLJOolkjQmfN0MkygLFnfkLMbI1UyhDnuFh
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:48:53.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e51fa9f-975a-451c-c2a8-08df30da1575
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10457

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

