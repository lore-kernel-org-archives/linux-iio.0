Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40543D47BF;
	Tue,  1 Sep 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273380; cv=fail; b=pjoF6lHoWa+CuFClq0ab/wuhYaxoysCVBm7Vy8x3sAXsIHXWhFQGHBekGU0EOkS44/R/NuaabarbV+o/AMTV1829SyR2PFwJSv5fB2vtDC4kidFBeYYiIsXdDjZuwwx8V6PcZNz8PfKRO/l9oz5XL0B0jLNn/Y+AJaPuC1VC3tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273380; c=relaxed/simple;
	bh=dpxFdZ+y3B4h660eFs0fV7oB49YXbbYwsdvq2Q1IRQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dAYsBRLFNgQWYsIDoOmYmEmJNMqEjV5pT6t3fDz5HBJfp+1WcDR8AuYgk3WCOBEInEO32PUx299N5FbjALAkjrWQOd4Etpg/S+OJYbeTpJi4SPCDHgGnaJ9+ip78oKpmIbEBOujayAHr0D7WhKUJFUl1GV4f+8BVtfC7XZ0m9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=deKbfdxk; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="deKbfdxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfGqEq6wTFTnnRqRPVDWzp8jRLj5c4iWnXNmAmu4KSouNY/++kN69QfU/uWVxZVVJ+bh/H6+8+uCqLk3s3wyA6S0ZVn0UiYYW0gGjSaOw6t6bL8YuZ1dAGzTSgKn6X4YI+GpdXUDSXv6ChHWrdzBxTH/ISuCMn/+mZrnSvsvfkfDkGUlIQQvMOMTfEZwp+QIZfzhlfrSowgTqUpeOksFWaKEA/e6ni0A9qHFZ+30rO2HhJ3J3ZrAeqjiyX/CbgM6f5kF8mgd4OQ0v3VFVhqkteSwJPIJP+y4Dc2PL6ir0DhlVeBMn7q1w5kiFG23Q9XtPy9/QpA/i8aptvxJa8eLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0dL1jfWdBqWSQIftLeCEpHddgvEWrTHx+Ny/qN3zpc=;
 b=r6RfaR61x6+CCfjUBdmsRBBsL8ZAcrCEXOVUN2ab462amZH3x8A9PsmgxETRrsEmUADpD7l+xjN5hQil0cgISsv5rLmbPPl2PxY2iwmVfwrInscrINoKFVwEI61z+S1eNmivikooyhesz/nxr4A+vvsh6PT/t7pviQ3KhvoI2Al/zkbz23/E+06OSPBXKHONEQNyjem5h7XwowkSOqqX5Jf75D/yDymIl9K1amZc544z4FAUBl58zOXjn+ITQXRwfs41b/+S8EP1XW4eyChetVN29CXSQo7nhqnF9Nhe5dkKFnwCKVw3YrosZWhcrgUOPoHoE8t+PE9Cyp9qS661IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0dL1jfWdBqWSQIftLeCEpHddgvEWrTHx+Ny/qN3zpc=;
 b=deKbfdxkBvbae6v9LZKa6ZVbt9RxNgcQiaw0GCLeZko4/bdomljrO5kALx6PzJzDydvMZCIW/mD1obL4RtYaOsNe6zJMCp+FmV94l1rn6vexStI3YuT6BvT3llzn8t7nitFW8dN7xcf6IrzdsCCyXYtCHB4ZxlsswdxgRicRrfg=
Received: from AS9PR06CA0317.eurprd06.prod.outlook.com (2603:10a6:20b:45b::27)
 by DU0PR02MB8524.eurprd02.prod.outlook.com (2603:10a6:10:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:14 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::16) by AS9PR06CA0317.outlook.office365.com
 (2603:10a6:20b:45b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 14:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:13 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:05 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 82BB31427;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 73E98305CBC1; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:54 +0200
Subject: [PATCH v3 1/8] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-1-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=dpxFdZ+y3B4h660eFs0fV7oB49YXbbYwsdvq2Q1IRQk=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9ujybL+uWL+7S3kFdP7rfrA66/3JxO60D9Mui22F6
 tcmz9M42lHKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQATWXaEkaFjzXr+gMb+7EUJ
 m874Bx0Jj3BZ/eLl1+b454lf6l+5zl3M8E+rzm22JPsZ8T0yveXW+9kv2qksvM50/zDbj22a/XW
 VD7kA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DU0PR02MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4e56b7-20ea-4984-d7cb-08df08365fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|36860700016|376014|7416014|1800799024|23010399003|82310400026|13003099007|921020|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oozMzWO7ZOTH1L98oRRfO4d6dR4IDHZImtXK/f929RhnbA4j2s/w0p9eoGIOulCVTcWjUsUkj6xR8ACdgfREsZUrcu/D/EVN1tdVrrgxpLRxfxZyEgBqEPcUhu5HGp81FMeu0IEuYckLajWZldUHKOembiiS9EIVJmU6aGba9gtmayJKEIjoHfGuDNqGb9gFfr7l6i5EDoWK9N9CbraxFKwcxb282DJvBTG7mDOMG3f25EI5s//VHlbIn/xDRelGSPL1ASWgltsTG5Xjdr7Iy0gndShvwuAZhLMJccnBZnsfPYjp7iqYy7U/ID3vglzq5v+LgSlTPAOw4qktIcVDMkosVwnfLCP0EiK9gmf+kHTPk8NKzVs8XHuPFXKamC/5CHduUxo0CUd2WkXNPrcrwjuO4BPbJt0O4c7PR05hss9sXB30pa4CL/z9say6PiYM/WGNwNMVlywYdpFA3SWcFUqDhpd6cVhaPMtGNJ8TfAJ6PikJY7kt38CPfaNQu5uG1sTmKTSORnkrCvSYaAJLGfK6Y72I4CoJTHMnEQYtBoaXNNOcMUsOV58LDBtiRA7/Cci0jbJMlc1QsFE+E1n7tYeW2LMw5DK0b5EpdrEU7bqAkQ+bs8+PVFdQscn6Os/c8yLEYpryUs0tn9bwyZfaAPwaf44h8o45X//WEidb/5nSSVhHyfy92MnS8xyhf4p4crqCyNJTXXyEi7+IrQuzSQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(13003099007)(921020)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	koZBQpcEtYf1h4A8Oi1nOvirlHgy9yO6UMxEkFY9bshulXdBlvfbdleA3Kii3k2OrnOld5NKNFShV2VS+vASUK+zJtaKEjhvWAHN1YrkbX+52H0CTcDXSoicASpNSsaxZZ53Z4Fa+HM4s/azvRWNF2psAD2jDZA965Yg9+kNwkqAnZD8Lt5jGjJoUSO3Ep7fH+6q0+YqU96WlzujnLRKd/emVPDo6KshKNhjtaXAUaonyfCfFZLdpWTUZFP4F2awopdcxXfAXtvdAzMN4XGOraG69bQOP/DWS6fiVSt8ykoeDyZlUxGl4ytm7KF7jwPeGWX3qLaw4+XPu0/FLPs6JKyCDkT9GzCXYMT/zqFbv2Lz5qogMKkDZcS9Y1k4++AMqx+XbCdHhJjoUVqft3iCoPD5r622jHK72/eHGFdUj2SGRl9PHyVv4jVisk7gePVS
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:13.8454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4e56b7-20ea-4984-d7cb-08df08365fd2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8524

ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
and I3C. Add the supporting devicetree documentation for I2C as we
have only tested using I2C protocol and leave the rest for future
work.

The device supports VDD and VDDIO operating range of 1.71V to 3.6V.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 .../bindings/iio/accel/invensense,icm42370p.yaml   | 87 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
new file mode 100644
index 000000000000..d519dc7e63dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/invensense,icm42370p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-42370-P Accelerometer
+
+maintainers:
+  - Kanak Shilledar <kanak.shilledar@axis.com>
+  - Henrik Grimler <henrik.grimler@axis.com>
+
+description: |
+  3-axis accelerometer MotionTracking device.
+
+  It supports I3C, I2C and SPI serial communication, has a 2.25kB FIFO
+  and 2 programmable interrupts with low-power wake-on-motion support.
+
+  It also has programmable filters and an embedded temperature sensor.
+
+  https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
+
+properties:
+  compatible:
+    const: invensense,icm42370p
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      Whether irq is in open-drain mode. False means push-pull mode.
+
+  mount-matrix: true
+
+  vdd-supply:
+    description: Regulator operating range between 1.71V to 3.6V.
+
+  vddio-supply:
+    description: Regulator operating range between 1.71V to 3.6V.
+
+  spi-cpha: true
+  spi-cpol: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@69 {
+            compatible = "invensense,icm42370p";
+            reg = <0x69>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 48dcb8b10743..177bcad75884 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13662,6 +13662,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
+INVENSENSE ICM-42370-P ACCELEROMETER
+M:	Kanak Shilledar <kanak.shilledar@axis.com>
+M:	Henrik Grimler <henrik.grimler@axis.com>
+L:	kernel@axis.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

