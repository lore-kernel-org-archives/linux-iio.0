Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC544825DC;
	Fri, 11 Sep 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133848; cv=fail; b=t/DzziodY8HGqAYP6ziJIOvcTUG2Y6EbP5WJWOMRJ7k07RfhZrsyCOzbNgl06k8uzbwcY1AIKQ1cIG7KnJofH8C1RXm9A4Rr6NL5AQjCv8XlEMZrwzEDH1uNCXjZdwxaX02jas+jIpLWW7Htaa4mgwgt6ruOkjwak60QNKw+Sy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133848; c=relaxed/simple;
	bh=r9DJYP5I0zd0NIyway+rLtx98rihdJ+CPWxOLbWrsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1zNB6y5010MCQxcESTDcQgvQYnJgpowOB8N1isRFZ37TuYwYW5phlhcPoVSQxaHKufMdZrtqyIyNqFqqX7rLGkpyMfVcHVUclru+BDWiHkpWiWTx1wzS6q9Q3RHNDICcjsRLDGu3E9JTNx9SKCGiyXdpFncBTw3Jh3zwxKY0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vXUbI2n8; arc=fail smtp.client-ip=52.101.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vXUbI2n8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAc1DYDnmkDEZ5hyGIrnjE6ehfsNJW7qhIrZu1vtuSuGoC91lXz6yKQzo1yqPlHTk+x4u+bXA4n6/hpH/vhUG3HjT7bWFM2q6oH+JjtfVhY2M5oVl1Nzq/ZOhXy923ISAcDfkTGmOm6hSylEs9wASvRyCn50smXcFbhcMrcsjlWkAyth/Xox7adU6nLWVRRAj1xDgRYuk0ob8HrV2Blw5g4fl6ySGyy8cQjEFefSJ7I4E5Gyn13SYrE4oXWMwjaagnUjWNW1HLXE/W1RpOwXQDG8t7B9IcY0p2TesrJgslBdkgbDUCmtTFgAhdsbg0/uLQE/W+PHvdJxPCYtxzhtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayT4XKuIRN4sfKK46FCPmuprQDl5AOMMFXUG3V+JS2U=;
 b=xAzNvvVv+q7uDW2oDixQAiQwpwq/2AQM8SBMcMRxjeLCTx3m3L4smb2igTmC80AU/JZTFD9ILv72b5WFXRXQBf21PhU3qADaLd7ff1i/c2PFpQjX0BEUyEowLQDdjJFIaYy0KGGKVtFwBrxXJRy+Dze1yO3P1WGRQqOwIApk6Hd0DazLwqiwy1DsTfGGwUma3kr21hBQLUVQpjN28IDA1HHU2C9yN3PT76MiA6Qmubpmx6zcT71F0eyicj6c/5amSlauKAb8fsXbOxTw5NYJtiWeP/Ebm368fLrUZGmTRJ1cxxKx9N4AbxGbcHOEFYT7G223au5ZWNB9B3h3KsqWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayT4XKuIRN4sfKK46FCPmuprQDl5AOMMFXUG3V+JS2U=;
 b=vXUbI2n8QWhFZEGPdSHLnqTJPrdvPHxZ+MBqRI6Jv1RWWTKaF6brsLDwsJQK9w4+Z8ADgP3MdTmTSoKtovRFCSWtkL0fQmZw8qG+4CMTptyDu/mRgPugmXkWDXmN7kWCG569UeBC9zan/TG8aN2O6rD9VcW4/em9k/GsppR7+rM=
Received: from TY4P286CA0063.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:371::14)
 by TYTPR01MB10989.jpnprd01.prod.outlook.com (2603:1096:400:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:37:24 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371:cafe::23) by TY4P286CA0063.outlook.office365.com
 (2603:1096:405:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 13:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:37:23 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9599830083DF;
	Fri, 11 Sep 2026 22:37:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 2/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
Date: Fri, 11 Sep 2026 14:36:45 +0100
Message-ID: <20260911133653.115553-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|TYTPR01MB10989:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2325aa7d-c3f2-404f-38bd-08df1009cf6d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Wxc37EYJbZxn0ihuSZC2oJj7Ej9klfgR8pQHW3+X0k/rYeVlXb2GseZpcwMTaLm2gR6IrO/RQwgnHMhZxJjfQHYTPxBwZUhJsdCevL72cVRkegTAL9aHMABNtBNrGeGqwkw2isV7NvSjj8uVnPOATNdZ4ZxEK30fXVDmM0PGVwQTDrlkz9TYkYY+do+dP+qhzdiZDuWfe7vg+j4y8r6RVIslVKBa0hKcfyGFHV3ogAPpzudJOPTaxdGYDTAD6jRqzUx+ym3uWZjRreCcxjeubw52dgB9sYMsaP4sLkRn9iYmbVPVO1lZGm/opwDnkQp2yvPbFfQvIxlFUwR5dllsQ8Xw6+f68bwsRoNywH3/8dmi+rcHwW41YSlMkfmK05WhM1Ms8kDu7NcJIf6DFDOp0/gpMND6GrG3S1Vvg073aIGimED+XEAXKXGajD7rCWSRsKDMVzKqxyW9sTW0+Q5Okd6Kk82kIg0aErN8HcE9CvS30BFV7EDMkOc8WxNDSaBt2/7/f21Nn9uNmG5OAbkamyLFf2Q4q6RQ0FVPjj/xRzEQZw4mObqmISjIRPh3AFJeXn6UTPlRhHBm+tog08r3Mu25Roe/FtbK001XZHgZBt5Y7780mjfzDeE9HHc0U9TSAWwD5qhwFBJLpQf4l2jOU/M2ycxt0GfhkKSTod9Ar4lsRJrYIELXrZZ+ZZEjUo/xCN8tpKlt+/OfG3GDWfO81w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K4/Xb+iDL3OVg0US70mofL8c0GBN0i9064186JAkCYyscIx/vL1tWzfkLTsxXUJ01x19/ArsJO7+exYcJ9t7MiDENOwTFHM7QMzmNOqZ8XrxDA2ElYdp7ODsvnMTATk7/GefMM4+ZiFXiNEHkI5jTO0zFf4kPkvELndsm6DH7W09Vxj2OPEhOwGTJHMRKVlp6iI0TdxnqeTF3KZlc+Tm0pjVgAq+JskArH2CZ412bZic7w2KzBHH7hr9Na0uxUv494GhwWTZAJTi/41ekznPWBSsc8dLmKg7Lt6DJbvIa9uYT6P5iNOqUemV7qTmCuXMxtndQKRz6lPYr5cGRGKmU6vUciAYu9H6yStqmnLI1rwbi0R7CiDkDnNcUXptk7HervJP4h96BAwdJzCB5ANGp9ZRwKv/iso2zGqaUoknNM0G89PXeH0sJO2c1zGMwSzz
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:37:23.0183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2325aa7d-c3f2-404f-38bd-08df1009cf6d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10989

Add the renesas,r9a08g046-adc1 compatible string for the ADC1
instance on RZ/G3L, which is dedicated to the on-chip TSU (thermal
sensor unit). Unlike the other ADC instances, this one only exposes
a single channel (channel@8), so restrict the allowed channel nodes
accordingly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 60fbc05acc1a..f4705d5ca543 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -25,7 +25,9 @@ properties:
               - renesas,r9a07g054-adc   # RZ/V2L
           - const: renesas,rzg2l-adc
       - items:
-          - const: renesas,r9a08g045-adc  # RZ/G3S
+          - enum:
+              - renesas,r9a08g045-adc   # RZ/G3S
+              - renesas,r9a08g046-adc1  # RZ/G3L ADC for TSU
 
   reg:
     maxItems: 1
@@ -125,7 +127,22 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a08g045-adc
+            const: renesas,r9a08g046-adc1
+    then:
+      patternProperties:
+        "^channel@[0-7]$": false
+        "^channel@[8]$":
+          properties:
+            reg:
+              const: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a08g045-adc
+              - renesas,r9a08g046-adc1
     then:
       required:
         - '#io-channel-cells'
-- 
2.43.0

