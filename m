Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010007.outbound.protection.outlook.com [52.101.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109144F55A;
	Fri, 11 Sep 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133840; cv=fail; b=Is8TQxQKRIDmzmq7UUsShl9B/rvbXMdfLcnNmxlnvi1EfzgrwUhvAUNIRtzFxk+6B/olf7a4iTCJtuFTo7sdlzfq4bkTqPj/8PWwoPTbo+2YYR51if7n7MzpAH5obuxRmGOU6qa7XJCcGwlR7aTRn+cBl0HP+4ruN7uH4bA0/2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133840; c=relaxed/simple;
	bh=lYos9OyG41ToPSyJOhSack+bQ5Oy0FiQvuOZ1x8xPog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeCWf2B0eOFrAhIfEAC87+l77PuRCO/KX+HBGJ//vTHHRRYquqG4uox9VUgo9ymn6hSwTosY98AHzvoI8cCWidi0dUmXgedf61+0qeHFvcwS9xOdRvjIIsHu2kRcDMYgVVcdLSJNf0AP1SbDa/JVthP0akUDExtWsJEmC+rqkFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=izk9HnCE; arc=fail smtp.client-ip=52.101.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="izk9HnCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkSKAA3tz0sLNBbWI/tAentWOdFap0YYFa4OxkYzfvPVIdFF6D/sdulMnPA+zzPn52uYjC0ROUd5FLLMnrhfLUZXyS8jzOxZSLo9/y/Fu8AgquLnxfIFSKFxzh5zlei5OB8iuARl3SN5VIyttjpLIHEL5Crj1mNIIcB35liBb7ad6MRWvlssG3h3ryc5peCCyve2GtZULKXFAfjptQRovJzI7DO1/vXgx4CLCEryFI+ybRotfpzXJ8QFLvyQnOgeraQ448RI77h7GO1VuRaZwXQLtQ6QzskD8U6Gg56Fi72nG36QIiIlzbqeqD34Te0LYD3LFtdJvipDhNgKxvRUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvM+0a4X0A64+9EfPC1t1Z34L/RUJ3B/gOVcXCkyH5Q=;
 b=HzZd5ohiNOzdJQohMRZIikgqApZuyTKq05L8xd9+VBdB3JcEZC3FqQKAkBnSisWueJJtiRbvSjnFQ9zdw9J1nTs/Bcgs9zJ7/un+UfeNbI/iiMKsFCCUVDIi4YbZbFuX8GJI7xaIGhI20z+1xpxM+Ej4nJxjCFuN8FzzPUXvVhvCRaW2524yG4jD5D0jsToz93kchQ+CbaC4D4Qk1v4lHjEF9qQMg+UOqRoBZuGNlhZ+OaxuwMcd5IbprwzEwot88bxL1n3+LuxyaJ5Fjv3I5WFDK0KmBSgg0g0WO3COKhFnaU5na+AgzAQ+eWzyWFJhIDHZ1QvpZD4EHBBpYA+y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvM+0a4X0A64+9EfPC1t1Z34L/RUJ3B/gOVcXCkyH5Q=;
 b=izk9HnCEAcRrAOW75odrWu8ib5ViiRXtYdNFhM2uYO3KxUMQ/lXQTI7cW8CiwearVrYK6ZATThVkehZZbZpiYj6iv0OZRaU5PUI6NfreM/PTaW4oBFc2zV2ot6bcVFhVOVOhUViLfKCKvkNlE8yR7UW1LyhI12TKvfgnS/fyM60=
Received: from TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::15)
 by OS3PR01MB8572.jpnprd01.prod.outlook.com (2603:1096:604:19d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:37:14 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:380:cafe::91) by TYCP301CA0032.outlook.office365.com
 (2603:1096:400:380::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 13:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:37:13 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 998963000228;
	Fri, 11 Sep 2026 22:37:05 +0900 (JST)
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
Subject: [PATCH 1/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells' required for R9A08G045
Date: Fri, 11 Sep 2026 14:36:44 +0100
Message-ID: <20260911133653.115553-2-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS3PR01MB8572:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 746bc251-c38c-4fe7-3075-08df1009c9ef
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|10067099003|3023799007|10063799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	duLDtFB1dPMU31e+BVErpZs2EsWHbQ4GNiedrHeHP6RpaPaKIew03ABsqTjHGfmLJFO/FaI+QrNtpuiZxnEScQJUy2hDOkuVyf/WD1r5Lf8RGyQSVGmOhxcOHl7I7c2D6p2fXDBzhpXUp9PQcb/qwL2I2sLRpC4m3Me00b9iA8SauWKQoxmmpNEanMhxE1/nS1mEzDS0iAlhU4ZegGlYEjlnLa0QnIJWp2ETZ93IdhGaW04j6BIeKZ8FBtGKMnLRd/a9kMNzzNbkrVWIwScGSpYCf9XXRmXQW+VZkgu5fTsUdAvo3mY+xeWJNRZX2iDMsi+rubOXYQ1dbx0IAfrdqVBy2a7MONor5UoqQMsulH8VMlE/IgtSqcG11AxgbKmuc65lld8LqJ/cudZQhHBoHWQ4WxUZ87vyIveI1CE5A6xrP5k2z251BwP0iJs64tPgYi8iLaLcZY6mB24f0KBsVlctGG3o9qReIsvcgVhOL4k2jgqNcx4t+qVq8hM27o/Z+OImn5YXZ+0uMnRE7MZfoCic4w+NWNlXOH89EcWJSTcYdBf2SXX9EYJ5Nhwsb9ZCz8RzHE6tZFodIziN4HejQnao/svhV1aeBcU10mQBKgkLofWoc8IzXdSfi5js0zf9/NIXWceJEloj2/Nw69w7yGeUNIiQzxLiwe7uPVuZQEnLmnuhOXRQFb1ZY3JwT4qcdDaMZtJLF6fngoazO42j7Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(10067099003)(3023799007)(10063799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N25uoAluBklF5MQOTbl0+q/OaaDxXodOqxMMwgcEmaS8XGR5a6FSRMez/iW0kDSlW3rWNPHooOhpfHEfyqCwFSxmUGfNkvA6BwAYJACLQgbK1BImRkRZfrpviY/okqXPDtbkcQvOaWV4w+reDgUpT1dblJwkdQ8Yoka4rVBuDdPGuMUTyqbAb4N/vyd36pbARWdqyVgU4FIs9HZi+CV1epQf8ubgdrPCq/XzePO3aTgLzM6iUIrPwHbzrQI/Vufs2A/tPLplLTjjU/3h761QX3XHoE/7ZG3xdiKhKvLPLXlhmlWZD/3xW93Aiyby8VODHTo7/MYLE0h1HbeAen6iSJObTUzn852ULssTcpPTHilU10I6825XxK+OLNV22BGmur6R5nwj9E+O+oR7sclKsxbEDwkGxf3kuc0iCjbJIgABP42ymYREi0KyWGYu3fmc
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:37:13.8053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746bc251-c38c-4fe7-3075-08df1009c9ef
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8572

Add a conditional schema constraint so that '#io-channel-cells' is
required when the compatible string is "renesas,r9a08g045-adc".

This is required because the R9A08G045 ADC serves as an IIO provider,
allowing external hardware consumer nodes (such as the TSU) to reference
its individual channels. The '#io-channel-cells' property must be present
so consumers can correctly specify the channel index in their 'io-channels'
phandle property.

Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 40341d541726..60fbc05acc1a 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -121,6 +121,15 @@ allOf:
             reg:
               maximum: 7
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-adc
+    then:
+      required:
+        - '#io-channel-cells'
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

