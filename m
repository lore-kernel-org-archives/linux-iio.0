Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F9391835;
	Thu, 13 Aug 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623993; cv=fail; b=pQhs90398G4AYKkRnN5f8ndqMBYppYpniYCjJexJHr2dfgaPvmfWkFgRM13umVOSgQ9n9h9Bqxmruhzo2zWQjop+oprawjSwUq+b5M7+L70rMpilD9OCnRv0/C6wYGQyvF/l9ic8W7/jcUEYnRWhAiqArndgeU1sa9qPXzD231g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623993; c=relaxed/simple;
	bh=3xVj99C7tXYdmrrYmHWCsaf4jGqWcWp8FjOEeDX+VWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JTnojkv86zpGHosO6tJdEgN369VZQOaXn09I31gNeuVeAuv7ioxajsYBJ/tOVhv+vDHEY29PTYd4Wej6zlba1hL3b1Uh1CfZ8zAPWeL/+VFW89oScTTibJFAEUhQjtBlnth3BBEdfilRCA4F65ntHlNbxqT1L3g4yLECuaHd79k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bRTlKyqE; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bRTlKyqE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLrCPtyGbJjCnGD2KvFJt9IjNi54o1dKD6qg35cZh/+NTsKaGCc22PATUt9eTW/Vt5fgoT07TnwK1UqdYxrNPdS2ERzUFsNtkhaGtyZB0S9J3oWMSSK+ZYJBH5eWquo8McpgOCzcRAgs+tmrQd3Lv1NhbxUHvxUWwWCbHtNvqDbqLq6e2Hy+bcjFTQvZ04ABGYjyOLuxgfdyN0kIOF0uGdst0C/W/rWS3+kFD+446cEb4wyusDJsYOOY0HONriGGVw7AyN/Ocv2FYkrnE7jnczD8Ok2FidE0V5eNMLStuQ/f/8fmWWsjsjU456i+JhKHHZwd9JfkayZC7w+OGMOnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaWCSF2ooHOYixRNVn+nKTXNOW13mBOl1SAwKW2nS1w=;
 b=kvTpRoLqp0sFZ36bj6sFC0WGfvchsS6I7OeZOup27slrdnMSQiZMXpBZin9T5ycL60iEXk4w1Q7Qhsr9Db0LpJTwWGbvAHmIXvrZgdIaWvhBIuHpy8G3GHxDlWY/eWzl0c0w/DIBqfjzLJxOLWYOlypk0rJP/bjMLZCF9SYO0L3er/Rtejahswck48B5iKPOKYwPS7gM5JzkHPgxWNPsrv8GCk64+2nhBzf9gRaBabde1SFXcQqM3B3lDxRLP3hp53CPvmIuY/7xaBN+8mCFDs2yW34FA8NAFvBMJRkuJ1r2hpQC8mfaJCJwx+axTskRc6uKvsisjMsnLs2l2AHuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaWCSF2ooHOYixRNVn+nKTXNOW13mBOl1SAwKW2nS1w=;
 b=bRTlKyqEw8AvqAPjX8FgLKmAy3GL1citByvaFLVF0t3c0+oNIO0gWJoMy0P6kJ75myVTj1ndQpkSuWusUOWQE+wUZAfP7YD6R6pIyKi1L172jAHtXSvWagOIQEyJJxMgBvkEuofb+PSoVNQb71ogfn3eZDpw9Qb1ngGsyuI0EGc=
Received: from DUZPR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::11) by PA6PR02MB10852.eurprd02.prod.outlook.com
 (2603:10a6:102:3d9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:26:26 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::5a) by DUZPR01CA0112.outlook.office365.com
 (2603:10a6:10:4bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 12:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 13 Aug 2026 12:26:26 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 13 Aug
 2026 14:26:25 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 13 Aug 2026 14:26:25 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id EEA061D8B;
	Thu, 13 Aug 2026 14:26:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id E29773069220; Thu, 13 Aug 2026 14:26:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 13 Aug 2026 14:26:10 +0200
Subject: [PATCH v2 1/3] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-b4-inv_icm42370p-v2-1-11aedfdf76d3@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
In-Reply-To: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=3xVj99C7tXYdmrrYmHWCsaf4jGqWcWp8FjOEeDX+VWQ=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJqt3+4Z8YSJ3FnyQ/W192Js3d3NDqVnVr/kMslxV3L3
 WnH/SmJHaUsDGJcDLJiiiyROQ3V7mu9ku4VRZ2GmcPKBDKEgYtTACay9wIjw5cFF/vvPHXT3fbB
 4sIrizdNUTf7xQ+x5Jw/LzNXNyv0WwrD/7qI/XaXNNdwcT1ctDaG12T+a9vCzR9KpY55PeuYe6A
 8iQMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|PA6PR02MB10852:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a86c57d-d4b2-49c0-8425-08def9361812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|11063799006|10067099003|56012099006|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	aZr7p+bUpbyV8dhyRm30oMRTo+iV4EHaNGaJgEI8cfIUP0V50bdl0RxtlDmrhSgTD5c2qcb6QTGO/L1cMVOUggwPfo/0+hOki2Pah6rWwphfObfwE/rn4UqUHvCYzI12nlSgef1UcGSRE7blB3A8FlrPS21VvolihwsBoKozfgdLYmX1XeyZJbA4Ps4etbr2xEA/CQKwCzwDJoo22OLDla7XbL5T4gVCh5WMXNL6Ro9B6vm5t7DeNRYd8kih14A69hpDzjrOcJY3TFCjaOgAwJkl5I/K5YFPUatH55LQAhFYyhA52SycN8fC+U2ciIiW+zV8YQ+Ny0jPZWRchyq5yVpoUgT4bixiSPPdtQ9wmYVmuJAwXHD8Oe7v4isbh9oUxtduk1jFhI3wf75+mHxSG15VebICO8YeFCZ1YOufWLr2IrWB76mVNf7WsK+EEWWG0oYOfAQbW6VNCqHrYiAxQWb336mqsjGrnUbhx8jIYwKOXF2PgyUa4NU+rVULZoRyiKUfsjK7JdA22M/rzadEI3nSzJI4EdLenxa3gJWqQBxuhREGNqd4mSp93ae35RBgH8G+lQwDq6WGb1U0W6F0NUwzGHxYFgD2cdU6l2nq8uSjv+V2rQ3dizpa3PK5b1nj3ZCBrIm3PGPKYTxJyJg1kA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(11063799006)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QDrrey0oeHdgO+dNDQ+1XRHxQlCSq3Rk2gKU5EJs2AQY1C974be0F3jjHb1Hhuqf+qVs5KL95IIp4F4t5UspXTct8V3je05XZnbcT9dNBsPzGlpCR08C3g5FUEs2UVKMDmVSzhdd/soMJuHOvksNkt+NoC5MzytNHTublmCIvYvQRRo5yCg72LFGpfdZbKvIeG5j9tzQ44XBQxiEWQXGSn26BrmT4tApEfHQgkFzlJXgLrNAiVGxNaklT/C3xBMW3FNyj6+GyZzlLmeDX79LZ4M47hWVJwGHTLOFU+rHrT3oZ3QljjCP7qW7iIUTd/+iqFHdj4DVkBGyAwEE47vDZfMNXWgUKllajKCJAw0FU/4eiyr2p70nSDEXbur1fBv1HpuZgyMjD+XRBQEq4QBCOxnlsF5mhJepe7lwUbR9DYXyEaNbIkd2HC3tx80xWOfX
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:26:26.0122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a86c57d-d4b2-49c0-8425-08def9361812
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10852

ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
and I3C. Add the supporting devicetree documentation for I2C as we
have only tested using I2C protocol and leave the reset for future
work.

The device supports VDD and VDDIO operating range of 1.71V to 3.6V.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 .../bindings/iio/accel/invensense,icm42370p.yaml   | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
new file mode 100644
index 0000000000000..df23406921a51
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
@@ -0,0 +1,84 @@
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
+dependencies:
+  interrupt-names: [ interrupts ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vddio-supply
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
index 04fa5322d9f74..e4764489ea971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13561,6 +13561,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
+INVENSENSE ICM-42370-P ACCELEROMETER
+M:	Kanak Shilledar <kanak.shilledar@axis.com>
+M:	Henrik Grimler <henrik.grimler@axis.com>
+L:	kernel@axis.com
+S:	Maintained
+W:	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

