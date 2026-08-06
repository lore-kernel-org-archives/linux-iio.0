Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF02BEFFD;
	Thu,  6 Aug 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020419; cv=fail; b=oIcZ+NbrL1vQ6KTo6vaU8c/VSK8xuZH+cCYCzUa7S1gG1DIpW1NmAL7u6aYrRKJrYE+otB85crIMb9r3jX4Qr+lclcuXS1wU3XKCqgnqcEhKf4nJY6h3QRaSiMfU9b5YhhUsmOVlaQjUoLqWu6eVpOj8D5QGoYDjH+dMmYB7gGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020419; c=relaxed/simple;
	bh=83fsUsu5QTSy82xVT4rdOjRRnxZLQ/wxji56k2BhtPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fvdS8wgQHhIa7J9j2H03jV/BMqQQwoeHlDDj74J7FF4ACfTkgsqmWXyBC7+OFdQUIFhqcHYp/Uk8KsEBRulxb9fnm3cnL/C5W8TnPS36AYULZNads22Pq2BUi3HDGKt90MRmcsVq0v+gFIXTafS90WdK213MTa40jQ3/touyE5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ef/B72yP; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ef/B72yP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6SXIrLcLT+DJlQ7mnGCToXlY9zKaMeTwl3Wa2Z9Bp3pnWfVIUz9UO1EX9K9uM2cWx965iHbYbSg/P9lF1a8Qs1NB0pVbKHW9idR9jOHY9ptLHsg6YRsOwCXgopbOFnwulqnibOxM5AwHmgAT7tiQByi4oS6q8lzTgmXUgJREyEOQbz/XH5OhKvC1gtz6QmfHmKFDcMknYl4h+evYp2w2KcVixLiXDehOh0JZakmapbR6bw/CeM5bnA3jKOqEsRZX1BF9494QzLlhpQY5OfCvQyRAF1WtEbvqLdblaqsxrzf7AyB6HDJkdqdxBlXva3dbYtIh7Px+W9eERGH6Gjk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0fb5HzrkGdrj/9NKY71hij4NQhebYG2iz8Exz701K0=;
 b=RYXtFlu/suUgyhpPShhkARPATlkk4CwiF2Mq9XV71ONYzfIQfpHRFTbBaX3hU8wcleQDMk16keUeQA1n0gbXf0Fn2e3QT4qviUDJ5qxH2xTzSbDBwaoYKo9r4+t2LsuB5fAmVqbOxWwtabMH/H5t13OEfrl3LieB17RiEPePEDOgfY2QfjE88kZZKXLsbVD85cy3k/aasovxlgq9SORNTY9twJ+XttWjF5FhHRc6yiGs8UfemXMaEyBU5iZx3i4gWIYmWZGzQDtMJ+t4JazrIcqyo2ZoYLuz7AzoAPRH3MzCKO7tAklFT8jaQGXJZcTL/S/sf1k+j4pE0C9FndxxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0fb5HzrkGdrj/9NKY71hij4NQhebYG2iz8Exz701K0=;
 b=Ef/B72yP+G8pX4a0Qx90FHMapSzcsXL482riqlR6tCqtho+EVZ/Q5YPgtxXit6EJtiDrJ6Ik8lOHDzi2Q+lJfLHScTU0SijZrrbR39Vka34GRHEkH0sT6cO5GERUUUWN9PsRZCpZGqKzPlU1LOXMPCGbn7E0+9TDXxZbz6gMBEo=
Received: from AS4P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::28)
 by DB9PR02MB6892.eurprd02.prod.outlook.com (2603:10a6:10:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 12:46:52 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::56) by AS4P191CA0045.outlook.office365.com
 (2603:10a6:20b:657::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 12:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 12:46:52 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 6 Aug
 2026 14:46:49 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 6 Aug
 2026 14:46:48 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 6 Aug 2026 14:46:48 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id B91221A0D;
	Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id ADFFE3061974; Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 6 Aug 2026 14:46:27 +0200
Subject: [PATCH 1/3] dt-bindings: Add InvenSense ICM-42370-p accelerometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
In-Reply-To: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Henrik
 Grimler" <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Kanak Shilledar
	<kanak.shilledar@axis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=83fsUsu5QTSy82xVT4rdOjRRnxZLQ/wxji56k2BhtPM=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJKmsz3ebOE7Op663SR58bZibFf8//0dZYlLZeUiltx4
 7xKv21cRykLgxgXg6yYIktkTkO1+1qvpHtFUadh5rAygQxh4OIUgIkUBDMyLN4QX/ot6cf+k8v/
 SbN/ObAu/+63TQ/bD7J09HxbaZNln8jI8MH4Usz22nOMJ+u7tmatmtkcvoFfavZqG+0DV5WeJnC
 F8QMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|DB9PR02MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f9ceb0-3450-44cb-2584-08def3b8ca3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|13003099007|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Vd9H42a2hiETfToEG2W3JcQna0k5ghNKkKR4XMuhMXKzIqI6NBBxh0JKsjXQnPh7McuP0XozpG+cKCpww///vheJ6+MDcY35Wq0r8X5TyRUtj+sctJkx7X/zpCr0J3ivzeegHTQW8PGev83apPEImGe2+trRViI/tk8+scWMpGNfqXcr9iYa+/cBjcYlfIPblpr/HomIfS0D1Of0/AzTTRyVKA5cqqSMODow0wCAokVkJfdFgDDDoOdo4IpIetu8mSZFKeOIo82BOBfSt1JQLJ3gJ7MzugwwiDNoYU8HisfBa4IsmCNu+FNQqDYbHiVywfmae/JGB6/Rr8YGKN+azxXhz8I0FyoMx2ZXxs9MPWjbxoXNADaYN+fOEldENobM26jfTKBv/ZTEeMffoXlnEEIaC0QzPT1NIc8Y7r8L1caB72fJUVkXGoEB+P2kfWMnG5Flvfe17UnMwmDc3ZdFw0J9tVRy7iQj+gj7Li49RlA+YLj/SI4DQMUc6k0EcFaCEjGvacxfBfNHtWMVz0tqrfJGrhRM00faGgyBsm7S2yo19DTYfZXSHlO2SmWJZp9S/MfXrhSa/P1cR9VadpXwx9yDium7kKbJbfSwbrmVxSM2vWRw373NSkL/4xUYEsQws6OeuKfau5YlROJpNSp3Zw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x0ja4MeMmM6NgVp0N8Cy/gEH2HDPUX3iaUBJK2ZSe57RiUPsncLqjEiwfoqAK9F3e7CZWa4PWQva2m1GLoc241O1N3VrfxYvnEkm3xASHbkSOl9Q33GcyVsseiyaOv8lqVe8mvr3264x+BkJ7OjPeFPYiPYNkEsG0vtRq/xi7bjaL7SFyQgnFOQ9QVSET5oag+hYOwj5/aUDR6aoicuo8+WqK+ewxHWXiAFe2Qhc+5mOH/hV1jb+kU0It9OKrHPn5g3wsEu3JEpq8FnypzHzM+75of0tmKcZknQr4OcLrFu0d+6WouXXny1pfi6dhJEEETNjLqjoL4/dUisDHSn/CnhVf4+Z1WF791bOLbrNBhTnYm92s/UnCB2YF++FOZyYrnR1RIR7EfskPeAzSJM1q8f/dt9VH3NYmdzhFM9NULJxTm1NiGAsXm/0p8g/tZBn
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:46:52.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f9ceb0-3450-44cb-2584-08def3b8ca3d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6892

ICM42370P is a 3-axis accelerometer. The device can support
I2C, SPI and I3C. Add the supporting devicetree documentation for I2C as
we have only tested using I2C protocol and leave the reset for future
work.

The device supports VDD and VDDIO operating range of 1.71V to 3.6V.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 .../bindings/iio/accel/invensense,icm42370.yaml    | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
new file mode 100644
index 0000000000000..561e798b911ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/invensense,icm42370.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-42370 Accelerometer
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
+  https://uat.invensense.com/en-us/products/3-axis/icm-42370-p
+
+properties:
+  compatible:
+    const: invensense,icm42370
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  drive-open-drain:
+    type: boolean
+
+  vdd-supply:
+    description: Regulator operating range between 1.71V to 3.6V.
+
+  vddio-supply:
+    description: Regulator operating range between 1.71V to 3.6V.
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        icm42370@69 {
+            compatible = "invensense,icm42370";
+            reg = <0x69>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa5322d9f74..f7039df58bb0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13561,6 +13561,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
+INVENSENSE ICM-42370P ACCELEROMETER
+M:	Kanak Shilledar <kanak.shilledar@axis.com>
+M:	Henrik Grimler <henrik.grimler@axis.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

