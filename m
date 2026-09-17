Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38A48E0F6;
	Thu, 17 Sep 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652324; cv=fail; b=rPLEzYKHbtSqRt+kEXf2DbXsOT2lpezTOUf1T0sBYzML86SCjUGPm2atdtO86d07d6PD5/YL97PjfkVvreJyRTvadgIi5HxjW1bcs0PWTrWjPEX1bvIzZjQ5rsJPojWHvdBZzACqXLlI6QnJvRSZcfxfHZTN/sJG8aq/GS0daEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652324; c=relaxed/simple;
	bh=LQa4Hrl5ozbdR5xFxvdiajsXoPeCgg/gETRFjJgjnHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NhhzpaG6RMfmQZM5RkRcqoYJYYueLYpF8rDrdY7pI2NGpN8t1+8iyF70qKiSWSYtduyB8V4eMpwNmeQaYgNYmIWsDfKK1vuMOhc8s/+wxcnFAbWXHRyltSTp9vCRMsmqRckKMPz5uXZ0KuQDjwFLL3QFElTfLbtow2OqKp1vX0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=l6TvdUWc; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="l6TvdUWc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzWVOy+DGRM3oZ3qhjODjtge8kUKzybzD1BYZj1h5mz5deDfSEWRP5Y+bkB+82BzZJuSs9NGsktF6ZrKie3mid1zEPTKSuAWGX7RXEquVWr3larMsCMvVKjQY8wMnxixOJSIOfgKBCb8w82knppU46MwJ/KLO9U84S5aUoxGkmdKv65rFpyY8QGJnh62ByEuNmXgb3FjCzWwC0wT4tdDBCKzYc5Y6mVbMDm25veOHJXzzPqhzYRYlbRgm2dlKnkmOQfn8ayb4rHUVniyCXwDIpjM3vpkCM4NKJITMTREtWbbDvKFDNv1u+NgmRRsSY6R/SrtbGS93LU1V0U2tqUEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0QSIzsmsQkHIDusWNnb6eIjZ1HV9zq2v3x7kgM9m7w=;
 b=dSno1/NVr8ZkbB1bBLrMso5UdwX9o3EK/bkYaoWfo+S1cNhULT9oKa4z2rvUV4cSmOygOeGr1oHgUCtR3d3Itdj/mZ9HMzXAiHHPGF3+Rd3TyfC3gvOap9MIc54dxXeDqDIulFt25HouWfr5mAOQJlSpsN5+wAq23faQ01rMjMmSc2HJC9GzBRdzsIy+dJ57PtkSiWHMeRGEPXMQYd7iz/JzpkOd8aMunh0D5ZjvOBXBRtzs8Y3jN7J8mbSL91ZZscx66Rw8A99mdwUnIOMaxcrL9EPvPyNm0UJRDtVpt6duqm+dxOa8p1DrBDciP+poNDWncZ6lmGP9RU6YHKloRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0QSIzsmsQkHIDusWNnb6eIjZ1HV9zq2v3x7kgM9m7w=;
 b=l6TvdUWcfx+C+JU0QwmnYWdKScWwlgef8+kAZ+2YPzylKdYSwTKLWCXChUubq1wsy1tMr6R7wCXO/L3PzSviADluTTqK8bf08h8YcnJuinEGlpVtLqaKSvUz1aP+7rzRKbyEWLf0GiY/8bg26QwsnXR5xhj+ncqmDhfxfDB1JM0=
Received: from AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13)
 by DU5PR02MB10920.eurprd02.prod.outlook.com (2603:10a6:10:522::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:38:28 +0000
Received: from AM2PEPF00070CF2.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::7) by AM8P190CA0008.outlook.office365.com
 (2603:10a6:20b:219::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF00070CF2.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:38:27 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 17 Sep
 2026 15:38:19 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 17 Sep 2026 15:38:19 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id DE7721E7F;
	Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id D222B305CB16; Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 17 Sep 2026 15:38:16 +0200
Subject: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=LQa4Hrl5ozbdR5xFxvdiajsXoPeCgg/gETRFjJgjnHU=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsha/dZ7g4n/3idHzd9JnJ+7XHziVe0pjjGX6k67zmU0n
 2azlreEpaOUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmcmQJI8PhD+VzHvd9kjJ9
 EJF2ONJ+mfbdWYvsf60qed8u8mz21qsJDH+FtCeWuYdYXXxx5WO9ddb74OjXoU+Ot3C8dt7uvrq
 +pYMHAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF2:EE_|DU5PR02MB10920:EE_
X-MS-Office365-Filtering-Correlation-Id: e60bc0b3-c2c3-4dba-848e-08df14c0f499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|7416014|32650700020|22082099003|10067099003|3023799007|11063799006|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	JdqAsYpkIENjwK+lKezZ4NsUTiF5QciWJUvo8akqdnqPc4yINnLrHiGJtChYcPtVab5lTbPwCKcVAOXWggGWpgGQtjVkHy+ayieH4cCapOdl84YmqFQcNbMmy1q1IRKKDuKGzjpgUSrrZG58CPm47RdufW8Jj+WRQorrxNsgEONLSOuVJ5psfXHAJmXdDwlkQVfDKdakK0zWzH3F9zz+0wLSvInDuTLThBTyg7z1lKTc7NYBUCaYb//ZU2nit9crMFKLRHjMaON2/tIwW9qwRhzZVzGk1rEVP4w6YPekl/Hl8dyT1Ht8eJc2HliDHYt0jMGP8MPmEyMDunkrWEXSZi1Bwt/6+df1OT67ROd4na9V+XyAWkbrfKcpfbsp0F+X1BRixC0qYWJsAkLhxbr7/OXiSgcMKmwc8D4SiyLQaiYSuVQTRs125oVM6jjbRJIoOifl9gzlGHX+wDxCByad01XiqpipWGY47aEiaIlqDP95ldWHm1Q0VjHpW9ja4tRqryrSCxd+pzD63GsTo3KiZPZhrntrAMhKMu38quQO5Y1vY0VD4DNR6hFOL7spqDzRkSmYwffj7lxErkMQocAZzM1wr+GLpRxjQ4Nt4oq/ZePEaWgBKJx1skTLeSa8zVe3NJ6Fzbxy2D7q2/iD0mURDak/tb0x7cnFR+eM4j/FmPto1XpYNcV0v+wqC76Bjd7//wehKt4mgpgg33iDSmyJVw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(7416014)(32650700020)(22082099003)(10067099003)(3023799007)(11063799006)(18002099003)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZhyZCkrtLIB91+zS1L19A+CpV7dp7uTSVrCGaUpmIMt2gKQe38qkpirh8atUVmq7QREqeO8/E8MyiuKxhyUZv5P4GYTIstkQB5m64wtcT90/PQnI1lL9bhZlAizpM9rm+F1W3jM7rs1Q2YPBQscs0fa+m2uDLiTr+yvyNxHuK8uLH42o2KGoAecdGiu99cJ6IZHHNGWMmTZDROBZdCTuE7Z3srfVw9zFgPh4KnL75MVJ2wHssnRKwmQw1rBFkOJyK4Og2GftMAHfJAA4U+IoFtpLrbQcqJljh7MUYcH7IeC5jSnvkkUD+0x8zqdKXKv0OrJMvOSRKIWRSifUFMkdleaVR5Xmpp/1507VzpI2Uiyi5p1aCyqugoa5rDHKmyeERzathhPEUTeM3GuzOcItVNB+Pq95svwbUHjJ2ARfW6E4FAHdv+Sb04yY8tymM/yB
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:38:27.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60bc0b3-c2c3-4dba-848e-08df14c0f499
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10920

ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
and I3C. Add the supporting devicetree documentation for the device.
The device supports VDD and VDDIO operating range of 1.71V to 3.6V.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 .../bindings/iio/accel/invensense,icm42370p.yaml   | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
new file mode 100644
index 0000000000000..d519dc7e63dd0
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

-- 
2.43.0

