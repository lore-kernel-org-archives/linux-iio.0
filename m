Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459631;
	b=Hi0fHadQoGwAwR1+yMcbosiZD5qScCYp+fItcvDzujpzEupHPcNzQXIwNE25a4Qp6g0q
	 S/Uorsudb7RUZDmorQhRF8536wIzGEP5TEfthbwgZQ+MgweAQooGiQg2MMBjQ9sbZI15j
	 lhgYl27d4F6JO3ojcfZKFbWCT+m/o4BFqWay161nAmsc8yj0nD/dkyOFAXHcTZchq/1yq
	 yv+9a1MuGb6Ld+cEQa7iFR4QHbCdf2KFsgEtJtnoITVtqWRN5q0csfuSxnqljA9Lphy5N
	 51BJ0VQzTAxUkg59Rk90aBSvqNhVrQCPHNyzUmJ4cKQ2A1eEAd5VDRVkAr/8/GfkKuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459631;
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
	b=q5a1X8y/f+84F23Pi7i3B3BLQ18Hpnaocr4ytOiUXaT9aN/6YulsgL18YRZhb0GED3Jn
	 YLVxVmHLcLbZX/iOEi4RFQKTHr+foPx3c4Ul7SBWkSPacFd4asuBgxmy/oC7d2z4jeADP
	 h3x0ZdsClmhvUGVSnj3yT9gIDHEUMf40EqJZe0hqcDvGVF4KPPsRB8YAHGlLZVtL8nyXn
	 rNClb0zKyQoUGrBIFAYZ5t1e5DpGQJp4EhCw3GHoHU9PaGslPWlcR4Rnn5mOjvi2Wv6OO
	 jrkrM+hbOZsNSQrSy1DUbexJyeu9sw9tk0/8NwKxYGXGBAX7XG3E48lG3wKH2fm4qKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VuJDPF9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.16
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010016.outbound.protection.outlook.com [52.103.13.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614E606A31C;
	Sat, 31 Oct 2026 15:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3614E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VuJDPF9A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqWLjJrGiPGO3hUOiPVwibhesXIm89bZazZUm6K6brb+qSn2U+OgmXsln8Awxk6zzgHXZfNQxEhxEgohgxikgWUMUJ/9janc4fgIMbQfE9lw8OZ3D8C/6MLKHGSc7c3LX2HxjNCG+9+isYOwqdrAoLDArUTRoibpP/E9EKugXuVmzyFtgJxOxQifi6ZYcnyREXScIH6LY9HNdO11dJXg7v3M7YT4xnvL8f7Zp304W1K4aFV5lBzmWCloc4UoEUwd6hkiMEw0HZcFakuxwMvngbiUOdcgNHAEsg1b3YaipflGbSsidzEgVE8u8icrXdCEc+gArkomFmoJi6GgYmV8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=RFRWpuzP1DgeknlQWgpIolJnQ1CTO2ZUT6NjTTP6pIm2vjqrhZuYy+SOY72CVYqaTaUL9cCLQzMb7uh3vJlKw0rQuUIcTocf+/PKa91sVtIJ2AdZCE9DQKhQXpFViHDzvfmv7ceXbmxuSKQIsNa4hf7Miqdy1BjEqGIAElRrCWnJDwE/7IM+OYieuhAX6eDLxdkFXoHlVwjzJbFEnSug21olXAr12SYbZfU8wp0FcvgE/PrP/5bWDkGwo8aM8bzepcsemS5Bv/fh6NcjuJgSD1RRr+c+FEb3KVAkBODMmyMZHfYT8snBm8WDWtS2FUiG/GUUC0NzX3vNMIW5ibPogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=VuJDPF9AR2LzSZ126rCqazXdgGUxb0NUTObX71ZrJ223aPYKPRQBHrvdyQ3mkjfphIzLJVxfgn1I3hXvfQ/+RTMqLTtmPpV6jQNhFOwT6urjsZ6Z3wDPp5bZclPTr0aXiKm5sD12BQ4e2qrZkRgBOGalRJY+OK/A2wZptSGbirFkCYjmPIy+2ON9aiPsqiL0SilxAIz0sOs2yoR2AWIv+S7u5PSKNZM/3x9TDUlgDczz+en4z4/zVko/bhsr4D42hIKkYJi5M6x7Lc1/L6819gNXaCBPpi8boZL3CzGsr63qskbLC91EEBGYfuRcqC1OsNldW83dgW+KuYZSkvMPmA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:13:48 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:13:48 +0000
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
Subject: [PATCH v4 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Sat, 31 Oct 2026 10:13:29 -0500
Message-ID:
 <SN1PR12MB25284663657E8F1507BD7791A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031151331.140654-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 79424328-2f31-454a-0b99-08df37619021
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|260925184616899003|25010399006|4140399003|24021099003|15080799012|23021999003|41001999006|5072599009|22091999003|24121999003|16041099003|53005399003|40105399003|10035399007|26121999007|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2tX0LREWghPM98JiAwtPLWLdUbrKWKmsqoGcdp2zaRzdkSyo6YGmo8Ayk/2?=
 =?us-ascii?Q?Wpwe9CqBSp/i/8WyQZeLHDxEcdX9vX64FjYvctgKWurlIaZT727jYHoAxZMQ?=
 =?us-ascii?Q?5X6WLX44n7QwHRmO7uQa0O077zftNRhba9kk4uZe5sa5pEE/z5FqILv4wYlJ?=
 =?us-ascii?Q?ITlRkKx5YAUCuOzmMvej4EN+sYJupXecT2bMC7TihvWPv2iZJjHufD1kNI9j?=
 =?us-ascii?Q?gIMsW8qDW0CNmzmKtyt9HWb3lsFPP10LHMPFuYlCCykmV4xnwrijZtz/wRIX?=
 =?us-ascii?Q?l2hUDosX0J2lalaY0Bf0fA91tHyl6jDT0MaF9CPvceyw2K/m+gatsAUo4UwS?=
 =?us-ascii?Q?fubCdO4jlIsiZ6OKAAaKjTdsqQP/Srqq1jwqLnnAubFZTS3CHpMInbijX/Lz?=
 =?us-ascii?Q?cRd6LahHCDZCirANoEXdBjHJuttwQ4/GSq3WjNZ4HR2KM5GuHEE9pbQag/4/?=
 =?us-ascii?Q?kK0QxaaztFEYWrxoKRn+4KmRAdOBk6nNw44jYonADEIm6vEh3LwkndfBlj9F?=
 =?us-ascii?Q?yB//wEm3mpTJGjlz3JrgxkEiIQ+8dv7E7dXpem8ijyrAFhBiV1B3IrA9VGLr?=
 =?us-ascii?Q?IEbnZsnpj/V6+Kiqawb38J/3zPO4KUXV/HqpiR00pmx6AZNkkp6M2OR/Np5S?=
 =?us-ascii?Q?2Hj+oRDZ74TogCSEG3bJTxWd3OOQzyXNiRMJMtRcdA/B4Mmt2GTaxDtJcrCq?=
 =?us-ascii?Q?5sBxHmK6df4iT3f/1qQC6nEdq4KGTwIAKU4tildX6AvsDIvEL05hYrU7Rvai?=
 =?us-ascii?Q?CHsMPrZqcW11WHfOUqLSZZxt+XWsO54c/0K0e7AreyrjwtZZAOCKF8Farn07?=
 =?us-ascii?Q?LG30MRLPoatlYPyBHQWQN0Ge3+TpLX1ck8Hjm3aOokeP9gFavyV9pW+KJ0B0?=
 =?us-ascii?Q?BxMzXE6cLfUwUvKEWLOa4jCnr92XVmyE5exU4309g35debXPl2/0zHNxoQb2?=
 =?us-ascii?Q?xHpI8dCUF5emiLHfzp98YI7oHWnp9T6KCypQIFs5zb5qLSa2fU1WWVPXixTE?=
 =?us-ascii?Q?8QdJBjgOg0FUZwbveATdEEKitS+Inz8HJjIk3/qCgJ52XXHwRsTjK5Mr1dju?=
 =?us-ascii?Q?wIXdmycY/lfsoCjTlOtWd82psEh5KKp6M1nCziL/UKHltZ+/768=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w5r3VgiRaVmPrSEa1tH9AE/N0XFZiCpaQHGK334Q3qo42OI41FRpsZt/K6QI?=
 =?us-ascii?Q?U/jQpiBObGxV4Uy+3NLdfMnBKsvKjBTeGETBiHVfoHK8Jpx3qn+ZOkbjJ/sd?=
 =?us-ascii?Q?/bytH/H0bh3MDMgdH+4vRd+psDpJv0RWlUPhw22LGa1PXxj65FbVrkmZeMwc?=
 =?us-ascii?Q?Nk8VcZu54A+aGDFwUOgm665p/g3IkbQ49KUzTM9jd82dRZg2LysvHgUK60b4?=
 =?us-ascii?Q?mqTClm0w8jZ6CazDtUvQySPFsOknhXmxTnWy94go7CXNiiTSrDwYGq/NKeEv?=
 =?us-ascii?Q?DfTq42wbnIWCq0u+fLHjpB+rl+539viIEq27vsclypgcJtaOe/sKkFRCSWNy?=
 =?us-ascii?Q?b5+/JxSgpOzW+MMGGrXyuOz36UFdk8KRvVeZZxDp/xbwWXia8YXFQSCK/GZR?=
 =?us-ascii?Q?58O+9JhdD6zDQ/PL85RzdrNPp/S5rb1gPjjV5KY3z8m2Lzl4O4gQjMAyAT3J?=
 =?us-ascii?Q?FxpPXtv7IIuqAquPmD8OPDiNM8TiaF5Y59QEUT/rCCX0N8LVXZI2MGCap89C?=
 =?us-ascii?Q?nVFbaeGfnI5o/FxdHbqqFxmJW6ck65DGcnGAooGXe+rGsNz318P5oJ3g/ksq?=
 =?us-ascii?Q?7BWxBuasyYJECgvB1YFoiv9qFZH6fA2WNXumNOwnxhaYj0b8OfyyzjLcZRrm?=
 =?us-ascii?Q?3EdUd+BXL0MMxSYfo07xkhtOU5AoIWb8X0/uQ/unIiMonXunJFu3LbBKGkwr?=
 =?us-ascii?Q?CRYJvYwPQJqN/GciyUfVfgV1KRcFkOTWmGOXp+uDxMD4UEBOA2e456xnGPIX?=
 =?us-ascii?Q?PidCIj+bOD3hNCVoBc77Jlxj8aLeVF2hidQ4aqJpST9JWuHK7fy385ZyBM/K?=
 =?us-ascii?Q?DNpQ3jFQtLkX8s06ft02ZD89qnkXH8a2kOxW+4dOJGvlvUb29Z31bPFpdtK1?=
 =?us-ascii?Q?w4H5OGk5Oz/Ibi3AcXpc5X6miwCYlmO8xQv8T2Taou2nwGBj1dpHzpMA0f9y?=
 =?us-ascii?Q?ssDpFh/j5I+/EteLCIkfh/tqlw8/Wb3QhKKjIQw5Lzd6gDXKq7x5LN3KFpBV?=
 =?us-ascii?Q?wykiTXdOgFPSvxvZQEensGpOZ8cZ+rXf3WiJyPFfBJ6nbUeRKOR0cly9fuWB?=
 =?us-ascii?Q?TQ/bYcPUk/mzjpDaNiMYnm457cHjVbeg++DBjGoSr/N9Q1fNL7xOlcsOfaTB?=
 =?us-ascii?Q?6gKaKyDJGmCGRsAWt4MVLo7eJtudFkW0/SKoxYK7HRsIWO3eZej1fes4Fnwg?=
 =?us-ascii?Q?CLp2RrLUBp/Ah52kdB0H0nMxYSNcnIKrIViyI1zlPD3W9jroijYVaHChCRey?=
 =?us-ascii?Q?YF/Q5fEjVVaJ3JB3TVy+oTwinNfnFNmZcMamMKvOFrDrgzQeMIUU9u3s7Dty?=
 =?us-ascii?Q?p5kALehHJQsKqg6iKYoohP3vhWTtJNtzHm8QOHuz2+LvTnDA6Dy0Mdp21uGB?=
 =?us-ascii?Q?kdhfBCRHjmVPo2yTNXWsnU2sLCggcxsIwoGUR4hhu54a5PoikA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79424328-2f31-454a-0b99-08df37619021
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:13:48.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

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

