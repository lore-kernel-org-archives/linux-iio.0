Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166784;
	b=NnHNatTZpyuL4kM+ecq7TCdSqMAwJb/13l7FF++P2Q02GRZ7liFJSmd2svFSxOJ/O6NC
	 4IJYe3FoNcMT8gXTz7ZNkk+RP2INLWUxEEilmjd2++V1UgPcgqsEfC2LNO8HxcyxsgYpE
	 DAlQhFRGFfCmbXAQjU4xXBOXsAa6Sl68D2wQAcHKyqf0sfBY2O99V9OMSCGwJ7qizxxUW
	 KNpTlVU2Z0D64fxNJjZisC2p0g/Kwdlogg4cscKzmlYUoXmBikHomgM6H62afWzn2D1s9
	 rA5mbofyukoiZ+vFlUEs9VIZ9Z+24zgZy2t8MwzNdE9NDWCiqYPeqKzGs396UFT3O2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166784;
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
	b=3LKUi2uGEro8DMyhIrDBdscaMd8niFM49byWumunLov9le3l6NxYXDuGy3wGUyvCNGgp
	 g+PCvmU1zo+Q1RPVpEoeh8Nr+yF70ifMPUzuXRilQ9qQiqbHlsiZPsyNJ2ytxC3+ozbY/
	 /Oaq7XbD6jEC0Wtcg1PSobSmk1LKRXaxKE9n49EDhK2wAV9U3v4x1S7ZjsUvkLqz16FHL
	 I71VAOhgZ7RCoBbf0OvKbRtrqJfAmwGxQD8gVMrN/TNNTUK9SOyQP2n5qBs8MncDnKmj+
	 t69H1gTQQD6oQv3+KYWlMdEDDzGRXsfuyb+gMwpqcWkAeZ4UIHXO1I+4+RqAZLkGaZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fKhFuaDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E73606A323;
	Sun,  8 Nov 2026 19:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E73606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fKhFuaDG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAx2kLhHxQzt514Tu2lvkTRf8Ja1Q8XPnAxjN6we1S9ViAFZnTH6TnOLa8+54/gUKGwsfJVI8QfqbyYzyUIl5L42LQ3mFbRd7f8I5j+lO5Flc3Ftvge/AuSmmHVGjGPdKG905zEaQnewsednfLNq5U9imhk5OzGSgwFNLFUv+WuZvnPtraAowoim94AVyrF/5piheNYi7lvwEVIMfNn1VrEcyRy/Tw1JK/uv+7sRzAXE+tRILWw59b2Wbl64wDZFxFNqSxC3zBv8g/7L4gUcVfMXTZMjnn8LzNMSz/TaJ2NI+j2n3LNVibVoP4ozI9imLgk/OPyJoMzGLcEvlO+org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=Eh3N1y9PzgnXANLKfxWA6fzNAKbeBNYTcn0MvcwhGVWmIW4YtBvHnHcb/aQi+4m8AR7MmnPwklWMK8oR9dsW5Z+8Pk594GGlDGHOGUaYJu0H3HzKGrc8vIYroqIHVYLL22xJPPaxa7L0nNZAZAxZmCsK9VjvKSnQsgXOF9JSLQc7KixnK26H/L7exxgkWOhND4EvdKCxR5JJg+AkC6DUCE7CQ+NhMgkJdXPFcw0b6dBQgmeXrf8aJ8cEkHhjf0fCZDyIYzjttabR8fUOgfpJoodvxHFCO/ojoM3lJayJBSKoc7no5yGF/4cdDBYU66Uo77os77FfjaJDR234Rh3WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=fKhFuaDGXmblnewxYnXkcDcm2NK0PqxeZQCqUtIlF46sea69VHesJu/a6jpcMsY+wMLuvE3SbmvU+eHTlQefdd9fOtM/HHlOUMUt49+BH3eZBqAR8x3U1k8+RxhtQKc2Uvdhgy7vxDrRy/YhllUo2/l6hk7DJNxjuZFblncJvbyF3x6+fzT5RZRKzsIJrAlZ8ixRrjlHFwWIEb4ZAcKV1mA/bsfw+GGivXlXOCiBmPAQXLQHYHPfyzNH3oVHC7f8alGYSAga9HS3LKg8Q4We1lZEmPzB37pjk8PU0odGUkBYjKgUQEVYvGqyD/acxDqqVF1B8V7iimJDpDw0g75Zog==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:39:37 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:39:36 +0000
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
Subject: [PATCH v6 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Sun,  8 Nov 2026 13:39:22 -0600
Message-ID:
 <SN1PR12MB25289ACAEC7DB10B66944741A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108193925.977273-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deab810-9d6f-475a-6c82-08df3dd00565
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|41001999006|24121999003|22091999003|260925184616899003|16041099003|4140399003|24021099003|25010399006|3412199025|440099028|10035399007|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESEPbGKrf8sosgcJm9e1kSjfZqxq0iEvP6s1q2+Ro4kh8bv6NU/AMuWpY5Ys?=
 =?us-ascii?Q?nltRufNm2WS1tXQ9N1TZ7/j1k4DMS0D/J/WJ1burta1GparB694bZnSYsSty?=
 =?us-ascii?Q?3OWODOUVDF3iigdhLEUAGid4K97JEnwAnp9qsloiSjCfqfnI/kApF8rzZHW6?=
 =?us-ascii?Q?eTR56rBI/MSC+gecVo6ErA7BLJ6rTL6CGzNb9SoB4XdJ/2+0A4cUJ0HrKXpN?=
 =?us-ascii?Q?MByNarjJqtzNRCoYtCTtdhygXGEzADc9Oy/sfWRSmLOt60wxMCtqyS6EKoWY?=
 =?us-ascii?Q?DptbE5hjC4uYCAbZkRNvHXheUOXjH8aLVuAJlV0igkSJYYgIupZYPY301x7a?=
 =?us-ascii?Q?TCORZU9lH2Mbs39Fsf/njADSmYncwgv/XoZcC66OqCJ2a4vK71Yhfbhh00fK?=
 =?us-ascii?Q?ipjYKRMQrZG3uUZ+VhW+cYQc2A25nQvlXNB08XvUbYwdOHw/Fgi4JvhGF4MA?=
 =?us-ascii?Q?cHPYXUwD1iMZNxSdthN3xY86drqfh13LSScgIvS7c8gNMVRN/CUL33RaAqgA?=
 =?us-ascii?Q?5jhbEvD2rhiMGuIV6EQpXmUAe2h7r1jkMAyb9WG1DeskHpm1b0nfiQnlAT5V?=
 =?us-ascii?Q?DhC5DFcTW5xSq0UMy7CeQWzinvDId61wvgveQcf1zyl6bEFK662dtmrpDya+?=
 =?us-ascii?Q?n7F9rDVYY5hvIGhxUvxEpMbiBYKW8nWGsxmMthVc+5/b90g9ihpLHbkyCECo?=
 =?us-ascii?Q?IChs60dE1S4D8bOXkfJvZNe13UHNMgt2KXj1NNqLAykkI/kLQIUtT2sG/ZzQ?=
 =?us-ascii?Q?1J15jbxj+sjdIxqD3G4Z2y/RbGmGERAN/+JBKPzxmRanmy4UzO+3bKvOghJt?=
 =?us-ascii?Q?qYRqPlOqBxkgcBfoN97AivzfwBzgBYB9xd+AKK2SMXyjQrlkr94uAhhJsXk2?=
 =?us-ascii?Q?ZAKL9L87rUALpaM/GL4UScJnIb9d4c6BITilYueDa+3DSo5lKJGs76rS2Iyy?=
 =?us-ascii?Q?AMNK9vv3z5NkvN7j3oZorGOyfjDE4iZnlhIxjT4ZBzBhnQmiE0KPQlJsQX/j?=
 =?us-ascii?Q?DEez95XMGU3+ustoxgVxCmUQMJ00jdT3y2aU7djAs8HcfPmzTcFjafIKOY5/?=
 =?us-ascii?Q?dxAyACXWZ/DGXZrEPIbNJhMcR7S7qIqr24foU6dWoTu3gE2k1a8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iypo+Zx4xQJhX7DfsVZ9ooXyr2f25Mjaa6TICeyLzcuGfT5ple+fZ1s+f9qR?=
 =?us-ascii?Q?iAq3R30vTRHIqP0HWAz7P4qW6nB333V1EoDttATDiCshMMQChUrdghZxosse?=
 =?us-ascii?Q?oV92sfgyn3Rea740N9WnFUl9ohLUXhbL+N9NTRVvd1BLf2Md0zxXyfvl+qWe?=
 =?us-ascii?Q?RBO6QoV1SphtDFHzWg9DLPvK5JWo6slXXqGRq9k6IO2xEoxPaBtmAb1kAtXO?=
 =?us-ascii?Q?Jrb862c4vzppX8TeQExl+bvaECXmxfQJfGnyLFWGkQ5z8Fgo0e+PBsmm51wJ?=
 =?us-ascii?Q?obxt6RQhdJLaoKUjqW0kyCnQQAs42JdzDg3mqBdNNXnAtmYVB4U+gf4978JI?=
 =?us-ascii?Q?kJvZVmbW3hqS/BSWpZ5BHuiIJ/8ibSBElBRTggXTbnHBkmUGdyUzemhw8GY8?=
 =?us-ascii?Q?vfb9S5odOy5aM/k6vTQJcQbHsLbtQiUP9AaB7fof03PKo2SzdYNQc/QrmJpT?=
 =?us-ascii?Q?k1SySfbxfpm9kth3i3Fp1n/jaGlcBhji5ufXdA3YyBLzlL6G4I56QOrMDYQm?=
 =?us-ascii?Q?nfL3HTn1ifff/41rcafRMNdA+3Gxm0Vas4VOz+QeggYPtKAjJjPWtRc6SuDT?=
 =?us-ascii?Q?k8yTAe95v7E1p0xuKePVLrONuXMenPLrYj7cI1fdljexhxJ7i69DkRMQIPrq?=
 =?us-ascii?Q?Q7RYBCXSyU8UttjmTI2286Z69t8unzRSn5MQ3c4WcjjOu7jDMhZBdi/kLJHQ?=
 =?us-ascii?Q?hXEYSZCk90JvTtXF1QzgcG4VdgYRjX+eDHDRkfLL8xZG/VAHYkEeTWGorcb+?=
 =?us-ascii?Q?LirlVxIuKwdG2dRarPVRo94swPB8uYltNea/NnNp31tS6ZSmSE9ZevXhaEF0?=
 =?us-ascii?Q?T7GoQ0Agq0RbyKt8lRCKpYrhMLzEgJQyHF3/mhMPhSNJr/ZMQHo25ZhJO/I7?=
 =?us-ascii?Q?HYw3mXVs9M3vdGyy3bLcBlxnvHskmjo4/wvoLnye45PS9ZaRIXWaEUjMBj6p?=
 =?us-ascii?Q?SkbEpyaT93csccdcmyVDIFbwDjBIwLft6lwTZuhHZhA3QZ3B1DeMwq65LAAk?=
 =?us-ascii?Q?Ksa43EzGZqXYDU/d5zR45+NZDlWGJJm5QDTnFCdpLNJYkfAgFRs6ZC4701OX?=
 =?us-ascii?Q?MfcSC+ZnRD6No7uO1rjn7iIaQH34hQei8pLRETuzSzaASovWiTB+kDUD3oNc?=
 =?us-ascii?Q?4W9ZgbtrRMJ6zDuyuE4Gb6LiRFSA8DZ61AJ4Y6UdJGPt27RGFSEoZA3pgTD9?=
 =?us-ascii?Q?HH6xdJ+/CXQ9FXYfhVsOUuspDD3JZyp8kRf1V5kmkVo1+5+UPZJ3M7FL1/yN?=
 =?us-ascii?Q?//YSntCqDCJiWVsPO9D7v+jmhGxrcvAX0227IGoj9uKumO4QZ0+VHmb264xM?=
 =?us-ascii?Q?/fPrkimLDujZO+GuhZ42p4pHeyxckucjHodVBx24HZ/a5zHAINrLMk+enJpu?=
 =?us-ascii?Q?/hfMaYOphlcBYluSJMMnq88fmJa2rS4QkeBy/1ypNLLLAj6E3g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deab810-9d6f-475a-6c82-08df3dd00565
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:39:36.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

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

