Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979725;
	b=0Px/MZ07rsh2alOdIoVisxJm2IFzxyd3sZueVVznK/xvEsT8NRNk6gJ5XbKic9Znyg2V
	 4zjC1Zu7QTt0rP1ZZCpkl81VhBIuMR/SMibh1paUtxC0sw3uCvvYV/V6C1lUulW210S9s
	 XGAe6vC4g95vIMJoZB8lTP+Y2g6R26W3yShxk3f7O0A32D/z1L6fykjgrw/cIVJnHqN3R
	 Dth3r1tL6OGHV+iManYV6QjaFFbzozzcH/tIdB2E5Cjl76HFmLLFIFQGYXcApYLXokt4+
	 VEz3zQI+peV02y2+tQlJZOuxBh8xE7MowRxKyc4RfxZjVOtaENNODwVDi9F+0E2ReUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979725;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
	b=YyIG1Sfeid2nd0L7129H6uvcmgYXxCBrGUHg/6hshQ7FvpC48DThJK+TdjSF5kPmq4Gg
	 2YC4wuSeeJBeHqVD6jR+/Bk/HKUp+h4gbIXk3ZQ1e2yo0ZGqosMYeoDS4BWZ5XIfZKry8
	 KXfikCVmXJdLH6/gvEIp977Dw6pJVTgSmmJJsmSkb2QuRzsyp+eS9W9VgB24OCZCIt07W
	 mDpqlerX2SWo73QtqKm9bIcwe0v962zR0F1lr9r4ucEdxkK+uFjYfC0Q2/Y0dRHNHwA1u
	 daKylAhd/t//Rd+o/GuWCoq5s4HZShSmH7W5BpO9dl8cil8YB9nwAqoQ1fa2FUayUxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VSMtff3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010020.outbound.protection.outlook.com [52.103.13.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A34606A33C;
	Fri,  6 Nov 2026 15:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A34606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VSMtff3F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNhbgV7hmA2ewYI9gGwqfQxCyFifA+OAVLOrbYK5qgjN3KoYh8u7ADcwZF0XRcDA/V1zTVeKbX1IAurvaH8X/mHMmC7glQOvHvbaXtTHewz6XN3wA+fX2kWOi/uJa8EQO3hAfFSl76jW2o16gosjgMmgIN+DWAKXY25RV0jL7hruQNAGPLK0o9/COoqorfEWufhNGenkRIp+NOCK3GDkW0hds8AxmGvWLZ56aI409WNs0eD7MyE5FZMEC7vY6QRbkphYNQ4wZDnPZAuG0H2ukL7p+BcePfQnVRmO57Q54wnexRxno+bvQpj/HP6x/G07BJ6FGrGK25OdL1JoHyW3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=N5uL4uauwb2g7mxKZNRlJWpAwmim59XUqQC08g1a5SUvfiglKjhYUp/WaulmrfSCleos0pYa7ZidmOIF99vwoiot9RpKBXKEEWHPSNXKzEeqlTB8RbpkQmTQNLtb86LJRvk3Qleza5/DFoJuZyfZcfKE0CzWFMclSVMOU6+Der83gtY4CnJCrABSBNH5TQmhjfzPQoxAp4n/f4kMVN76Rvd21wgV8LdInRu7dhkW7jiWUYcnK7STEpD/7w+bNUb4rwRJ/1ZvoYXj85aj9INhf1bVlM6AS8djsajIbRehTfqhpMpLgat29y0PLxF+F/YS2vR3+TKgusJ0h2kzDBf3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=VSMtff3FgLf1tjgIQS2ZcyTEu2rhfJVbTgNiNM4Tao6t3f1AmRD/8UTCIAGHN4nm5y5/86CPE5hiZwcmtFpYSiCX63rHosHMEmX9m+3yPKV520eDpYOJKQLMx9V1aMk3hLO+CCK3uOzIdjuSCQMfms3K7i3RFHO5btQTCcH91mAr7RE/hoMHnK47nSyk5ZWBOwkA0Q5mqmYXeMaRnosdVRuZFk83wqmJl4WYtHp4/UY+5r8f6+o4tIvcMCGHUmic79FjSoMTGf9aVymLdezaNKcb6yaxMvRy6Ayx/Q6L7skqW2l2WLQiUfp1nI8YOSZROwXdUI9AJDw4BrYH+BpwhA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:41:50 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:41:50 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Fri,  6 Nov 2026 09:40:28 -0600
Message-ID:
 <SN1PR12MB25285F5F9F21F0DB51E72634A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106154136.804370-4-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd89e3f-c7cc-4894-4d2c-08df3c1c7882
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|24121999003|22091999003|41001999006|24021099003|15080799012|260925184616899003|16041099003|8060799015|19110799012|4140399003|25010399006|440099028|3412199025|10035399007|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EI0YfcNs/FbTlVwB+vdDIZ7j6h1OJXugshd5EG1IJ3kWcfHkJdOLPwbXTfxU?=
 =?us-ascii?Q?gAeEepflDfUVyPAdkY3cEHBkmN4PdfZKeqmRs9erjzSajyMEBBjUxUXGyGAl?=
 =?us-ascii?Q?N5SyzlhkSmbvHq6RRHWfR00mfCsJyVtxSDJoZ0+YtTOnlVi5HRMvyLLDOybu?=
 =?us-ascii?Q?Tdx/66YrsGgq3+5giUS/qEwln8b6X3PMVADlbGK3KBb16FnDehs+ol7Hl29I?=
 =?us-ascii?Q?vMpbSA5SCUzWlggb82qAHaDGER+MTddHzTYOVODQ+HzmVeeJ5x7fq3ebaa0u?=
 =?us-ascii?Q?Z/39DTO8KUCLZ41QnfmEyH0l8JZwDGYsS4CEf+v9R/6a2w7mKuw1h/FgjZhw?=
 =?us-ascii?Q?dWDXz/k/qR32/avBS4HhyA3T6jkaLMPjpnGe5QLzUz7y2vqAN74UncmYiOB0?=
 =?us-ascii?Q?ug2CkgGo5ApzaMej+GUmjtqIdlsnqNErXx0hKT3KsTnrsnUVG+2vhFpt13iU?=
 =?us-ascii?Q?oqbJgD4WiuBMNBURXaK8eYv6W2aMNCzRxWmFyr8X/YEBLln4lN8OeHyuvVn2?=
 =?us-ascii?Q?l/IpgaErm2YnqR7JfT9qinni2SrzHP/Az5ohbCTW2MRsiQS5i2q9x47y/Wkq?=
 =?us-ascii?Q?2ICETyfoicut21IhBJ+JKeT/4QMbhp/C9spC16JcKL7HbbgT+ZZ7skhSCiLP?=
 =?us-ascii?Q?pQwUp+NrNL0Ui7TTKDXaY2K/frGGv5EsUhyu3VpdfhTbE/4ZBKlToL8zGhB7?=
 =?us-ascii?Q?8wLFP1faJMEZNmDLUnewlePAAgmzGz3ny4ERK8raMbhmaoTzYcj5/VwlEYwS?=
 =?us-ascii?Q?kCxW03rNvU37/c/s6b5udWVBLu2PMbG50ae/u+RgXtw8p0nBZVRHQRvJtSFa?=
 =?us-ascii?Q?56o6UwxwGJOfFFptcqYqc1oWenczhRnhjxxmsQxK9OeU1Bjo6nIWpY1IhAyO?=
 =?us-ascii?Q?PdQFwvUy6mvmaBgiW5zirsDy9CCwQ8Mgvtqc7bNp1sQQ4XYIW8zz5UnqOolz?=
 =?us-ascii?Q?kMwXb0djFA7KkDpHrH1uehIOPgvcBUwib1OVSimmoDY0834YDaphndkKh00G?=
 =?us-ascii?Q?1PmfjKVv1OFNZX0oavVUfewZZW3D80RwOvZTw9SVl07bmfQitvXpsUPGrWMp?=
 =?us-ascii?Q?bygqnl45TYPNsrAwTiLdWtRHF4GgSQuCdIUEYOmR9msI6cqbP+A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yngr0vg3YWEpe5TFkd9EJbDo09W8AXg89wtgcsPE5YDk93bKHGhy0CUgSwux?=
 =?us-ascii?Q?0gVYpZhUcdAJ9xQx9+J7npF3g7qARH5MPtbYu1o9f6+0b8/zqOyAienJTLiU?=
 =?us-ascii?Q?dIptNlD3pG2/QZjad+SzAUO354lNULNdJXGN88ykzVX6tHAuyPLNTrj23chx?=
 =?us-ascii?Q?z9PgZ072Lo8d+a4bNSrPUPahDTgVkAscs95z1ZEmZcRpZuQaeB/Z/2hpFLD0?=
 =?us-ascii?Q?0qBDq70w26LaGRruNOJWZzezM8dS93+Yn5NxXUz01eGYJeS9Q4v3w34Av8AJ?=
 =?us-ascii?Q?aUbxMcJPeynOIkZFqgQyfm11Lsc6n+CvOcK/LEZ11OnVtBpASbHmEXmfuBXI?=
 =?us-ascii?Q?BRBJmRHY7zepOFykUo6V+V7yYCBUSOsKgghAtMaGei9O+CHfYBg8nJmoue7i?=
 =?us-ascii?Q?lFekBwrrQkWZL0+or5+UHUJSbBGJonmeI+pV9y192pG8Zb6P2L6Ii0i8Ouu1?=
 =?us-ascii?Q?pQn5ztkyOzPsH131q8L9WVuio0CFwXTgXPaDWei6gJyPpaQqKO7PyfkY+Qkz?=
 =?us-ascii?Q?jG3StkOj2BkWUXccB7pW26Hu42XPRmKrFJnrXEzcyfBseQmwMfdthGFIMkK1?=
 =?us-ascii?Q?YqUEX6F30tJqcIbNUte7ccdzGKfXw138MDWHaUS6qfxeJNBw6huxjOio2+pr?=
 =?us-ascii?Q?mGZWF08MuM6Dy/g9SZzgdAn6gg3qdVccZp6c1OMWs0JCmxf3sRx58U3cOxrA?=
 =?us-ascii?Q?k0fOsDVq9hfEGe0aeOaTuX/u/KoOFctdxaZ/fTaxl/3JLa8oo9yHR7maB/2M?=
 =?us-ascii?Q?WYYJdQrVAN9eb2wcKI/MLdl3Kx12BRGEKV6JVW5rGSdxLmTaVmkzg8x7f9Q+?=
 =?us-ascii?Q?qIygHNytXHNOcAwhIQeR+rGepVpEotQf4hinKNJq25V2xJGRyTLDEUDA9kpV?=
 =?us-ascii?Q?IFowvdgx5n/Dcf2+r/xeIHYqDDsbfTzzy+GnldDKZXqiBdRQNX524/affheJ?=
 =?us-ascii?Q?ID/qM2aEDgLsbtgVSZRiMwxLwcPvxn7fgcaFzoRCtgw51uPjLFhmFjEUrAfd?=
 =?us-ascii?Q?SWtd8UnNKaL1sP4wHB06axIkVljwUxcQTHTPGDB/QYZ4rGwldshYT23NL261?=
 =?us-ascii?Q?YKA61Hhx8zvxptPcHAiw8NBIc3KEKRL5t5P/0bW0F9HqJw/HbrgdaN+6Sj+e?=
 =?us-ascii?Q?xSYZ75yYO3wRYflhD11akD1/RO1/cslpU9E8GMOD1qmnIaB2EA5gGgu1EZ6c?=
 =?us-ascii?Q?byNaxHRJvubKMMjNd37PjPQcGS6KA74R1/9yo9dtx/R8LfQg9pzce/LxFiiM?=
 =?us-ascii?Q?RQN0ITDOdrxkqBngre8YXNfaS56XKqbPL+I2QppDmYLUrWy0SCZmQxLHMYea?=
 =?us-ascii?Q?+uxWGWghiSwJKFPiwX04BI7h/gV22FJfMfXDWZWMEdYy8ehM7tdeQAPsNs32?=
 =?us-ascii?Q?uSygO6TlvgqUGoIHhzbh49MbxQ0gq/iayS+53h4aiQ9FEyDSZg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd89e3f-c7cc-4894-4d2c-08df3c1c7882
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:41:49.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

Add device tree bindings for the Texas Instruments FDC1004
capacitive sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 .../bindings/iio/cdc/ti,fdc1004.yaml          | 46 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
new file mode 100644
index 000000000000..8366afd025a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/ti,fdc1004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments FDC1004 capacitive sensor
+
+maintainers:
+  - Victor Chernyakin <chernyakin.victor.j@outlook.com>
+
+description: |
+  The FDC1004 is a high-resolution 4-channel capacitance to digital converter
+  that works over I2C.
+
+  https://www.ti.com/product/FDC1004
+
+properties:
+  compatible:
+    const: ti,fdc1004
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cdc@50 {
+            compatible = "ti,fdc1004";
+            reg = <0x50>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 360977678f70..69c23ae21016 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27388,6 +27388,11 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/cpsw*
 F:	drivers/net/ethernet/ti/davinci*
 
+TI FDC1004 DRIVER
+M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
-- 
2.53.0

