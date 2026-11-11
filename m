Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407054;
	b=niVnWNi5L6XutwOQaH7jEbCCDG3grrhEMK3wHvFAfACyvYIQyqD3aR4rZAbYHO/9j5T9
	 KQhHaqsKiWFRaZc9HyQcg8p2/ozTX6IDilJFRBR/MjC2JvTpY5LHQJnS5kxKGfasxVOJ4
	 7n20+mHX/YuMXi6tNcsWnbedCkxhmy517kuXDxuWblpZCMmc1/Wbq/aBgsK5q6DH07Bnr
	 PkO99ozohS+ptkn7DQqAMwO5nYfcYQXgX4YbHebbxADsYaZHsGhiHFnJ4ZtU5f+Sy8Pf6
	 h7zMgj7IprI5wWEvZiUrlvW1cMZGDVtGznYy9qmA4T7lYRrCbWm32gQhTSJPEOrd7uA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407054;
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
	b=ANZ623S5JFHueAB+6cNVgzvUDWnusb1wSopx4TJ3pPmakSz/nKlaTFgwYY1Y0V1BGye3
	 YfTMv/KTfClTOAS16jC78eZedekKP4rlnB5ryeBBqV6doCb3zp3LTRXw/2+/1xkOuzD0r
	 gd+GEmWhmTuS1b+KV5Qi7AhRljLZAnPf0yNziQoONCSc/RI1m+9Zsb+A09KU67AiyZgdN
	 KjnMW8LjswNiLuE+6I5jn0g6miB+R4/mBM2Pql8z+dyXk9HD23taP8wpgKIlS/nTqEwCJ
	 3OrLQu2+pCsRFrhoRx1A19/cD2kAnpL5oowPgBdQap670/VaV8vufRzp9TbLp6STcKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HnstlSlo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012022.outbound.protection.outlook.com [52.103.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154AE606A895;
	Wed, 11 Nov 2026 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 154AE606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HnstlSlo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk0f7rAZJ65KPG+Q7P7GovJ7p7C5ejE/lYzW1FEbAQJrgVIHuICb7klEafcCZO4KW4HOnMuJV2RXBd9lCMdrLTTc+UKSgblBHCOYr7GNr0jnPNIbdZq7qM76Stl/A0e4fZBHq0laAUug51IGu6fGcc6onF3DUSr2W08zJMT2A5JwOFtvm/bEfTYUFKujAFAEZjGpyrw8gx3BMZa9Mf5gu+3WNycA32ARGJZhZ6BjWTcJFkDWerBdxIEFMpzg4lfu/65YsaBE4MzVN9wT/O68AF4g3+p6txQk85RjYsm3oCNvt2d68XIcsH8u4o6NqzeqwGlFAL8eHHFUGHog3t7O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=oezssgM0fR2QqS5y8YacTqM3y4V0YxEb5/h0TqDeHFneo24gOLzIDtBr4fGsdyBliCaqi09vR6Z0ZoeGWYNWr+/fUmwbY0P5uEvKBVxOjGkLoZOK2HrJu8cyynZpdn6jduOTsRHKtnuzddHnBV2KPRxmmsFeq6PDriMakeBueImLf7GnxkCvG06la0/5JUIiGptxFAEygdsnTwmx62sGgnKNic5QQZg/LBsglKhnqDCJ+67/s59+vMnz/+YtXu9xnmONtHeMuIGYv5Uc0DhcnBt6pF5Pw0aNAQGl9n+9X5GDESrQRodkSj9600ZHLewX7XV+mGbawQBTo9ugr0F25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=HnstlSlo4nPmht2GaqL7IURckyT+vcwOSiVF/zoGsaPJ7ZPHNd3oyyFQsI9zPQdcgPpmvwHTUZNKRmmjcRxo9E8vPqMXDUT/T7kVOh77ANEM/5mjO/frl5Pprhn318ZemiejGHkcbY3nmI79reRRsHTVU8T6+DglyCx0N7jYIqdZlBGj4HSHW/QkqmYCrXtseXVhW087WxcuhwrH8JhJ503CvkHLEo5T0BYVkZ13MYB293OH2OiwKEluM2UewDmGtfydxnXq2wUAhCV6j4R6nU/66xn+LwZjrm0XSoWoWO2ElMnuDlv2h7lD2TiYm+ATPmSIr1tsO/lLoXQYX8v0NQ==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:24:11 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:24:11 +0000
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
Subject: [PATCH v9 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Wed, 11 Nov 2026 08:23:56 -0600
Message-ID:
 <MW2PR12MB252333CDA1957B269CC13F16A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111142358.22099-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 239d5e50-6e9d-423c-c051-08df3fff73a4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|5072599009|25010399006|260925184616899003|24121999003|24021099003|22091999003|23021999003|15080799012|39105399006|19110799012|41001999006|8060799015|10035399007|40105399003|41105399003|440099028|3412199025|18071099003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?depKs+7ML8b2jmbJpFIcJLooSBYH1uxcEuwR4g1hRxJ/rqvRBZd730htlPw1?=
 =?us-ascii?Q?DQVZwwm+g18m3BnyxgzZUk0cOLcw2ggTCZjU5f+nl+lFOg4CYtEmBT8NmPRn?=
 =?us-ascii?Q?TYQR7inD9b0vliGVabqn/nhsJwE1vLN/Zt+Uc9b4DC6ZtdxpatcVV5814/zx?=
 =?us-ascii?Q?HzWRl7uLprcTKvx4oyt5PriR2Y8cdjIEQAlXvQv4lkF2xeeW8L7MIB7AVUvx?=
 =?us-ascii?Q?ZWU+xfrfWGGAOC8IePfbo9JVWo104XDF5tqrBBjZrou2cXnkhBDd31T3Ptuh?=
 =?us-ascii?Q?bnqkb+9tB2DQDLdIIGEFl8I0FgLPeNmRgkPmNmzzpJa4Gql+jDXlujUCJcCG?=
 =?us-ascii?Q?FCmUYfQhQOGS2DuFNp/k+Ni0/9EGxgVCPj51WfoqlFWYSaPha6REk/RsFmXN?=
 =?us-ascii?Q?TvKCukd5q11lhJ4/x/P9ji3XubS06Zms+DoU9GKZ8xPQj3MOZ1kXlthjo07m?=
 =?us-ascii?Q?sjLJH66Q1+lFvxT0C7SPJ1bVwVlhHwvqDeyEM4XBHA+Gvc5gi4f7FSjptDQG?=
 =?us-ascii?Q?luURZIqD4Fr2qA0xcP59gcH3ybfiUT3K7XPqK2vQeSgyxc0/JhxuVu/H5xwu?=
 =?us-ascii?Q?vnpP3APsJalWYS0sf7ZIuuHwxbstjI475+lP/fw2Xa3099uQrVq+RLYw9PK4?=
 =?us-ascii?Q?1Ccd6+p6Oy97kGcx7rsyuvBeC+ymzTwryeOHrJLamjrXTsz6VOjeFWxmBvb0?=
 =?us-ascii?Q?dI3ysvWmlhB5EskrhMau6r7ar9bDKNsj0NFsREKO+/2a/Xg4NFdl6moOx1B1?=
 =?us-ascii?Q?VvFM44zgU7K1k+tCkyFOLv4xb+NzLjxXJb90QgeYoK+nevUvnAU40F0BtJhj?=
 =?us-ascii?Q?6zl3or9jXXljuQEYzlsyKswEIpyZd+azvPc2relSh1VCahg7jtC+BEBJiVwL?=
 =?us-ascii?Q?WYKecreB8lfRQpnrZM6/Ge6Z2dJP/QakrykuhumOFojSWwfcRjSAqHrmlXdb?=
 =?us-ascii?Q?PufHSOvtckKhkfswopNTnyUzX13pgJZKyJ+2MqylG+G0huhyz6EFSdVW4+ep?=
 =?us-ascii?Q?57KLsIXph8ZmhAds1T9siY1yX73Vbv1ImeolpAhbH0DI3+KQObnug02JiHtf?=
 =?us-ascii?Q?+9D1nTgpruTEI88MQ/fU2ekn/3M64I8VeZr6EHia+R1r4t4sAYWa5OSHggi6?=
 =?us-ascii?Q?O3moNDMFh4c4ZS1kcCghR2QS25bYjNbyzQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6d5kxFZ0Pt9GAtmgrgTq9PteBdkbUBMQ1Hg+ZMhvT8uheVVe+872mdjGunm?=
 =?us-ascii?Q?YvrO7tck3mGn82GgMHMokfG+B63i6iq3HsNVfJLoIwR9fmfZ1CI88AW72mZM?=
 =?us-ascii?Q?r1cOOQyEfnSmsep0vJXgGsMNPhmBMSPgzFzJO+m4Ofpi5aKa2g1vID29Rv1B?=
 =?us-ascii?Q?F1vHa3eKAjbYc/lja7F0J3k/fikEyuL1OAA9AMq4P9yZkXKUcwW3PV1xugbE?=
 =?us-ascii?Q?Qy54zqa3WFQPmXnAscnHOXtFZ3K35sNgS1cylBGwTA3HDE3E+4EjrSFS7uUU?=
 =?us-ascii?Q?bPQLcr7D5RAd0N6LaiUMl46P+geTe2BZNKqgjvz/BpEbRURpijX2K3P9I1Wv?=
 =?us-ascii?Q?/16o/sCZ3iIcOqpcfjbSpNGS926Oj4PvLulrDgxCNt9RfT27hMRaYdBjP+lq?=
 =?us-ascii?Q?GGiAT9DBOc9y//ASyVIgj5uMb+4GSvaKY69OkKEcnT0lOUQaMoEtCCtTQFAi?=
 =?us-ascii?Q?zd0rEGdZQ//L7R6M5ZxuNiIYZKqA4GCYKyHsEyYelCH4b/YvxfRTgxdpPSio?=
 =?us-ascii?Q?pT6ScTz7ZNyfPgTGECfJ7VUatkdDKGfzaKjlMfFDYuq4wgPn4HBh7WpaayFG?=
 =?us-ascii?Q?3RMd+4GKZNfFZ6cKsC1bndLT/U2HQCRB4bHRuAm1bibh0plgdTa1L6jFO0Bt?=
 =?us-ascii?Q?by04ylUARlHzVbaJbbEItvOICYltpfZBfDAghVaWD0VDybb2ByvpBstH0W9I?=
 =?us-ascii?Q?Eop9keEw0JWLPKC0we/aLk5Z36elW+X/GGv0Ks01pUnlOam7OXfMx/WO31qg?=
 =?us-ascii?Q?vVnOffnpk6tKvpT1bKyr7Z4GvEP+/8Qw4tx6yqlcP2AfX1b5swFvuJm3VslA?=
 =?us-ascii?Q?Rb4+ty7Oo4TQPdbdVawBNShD+WQEPoBSeRceCM7sK/UhfEkFtugnkvb7DOkP?=
 =?us-ascii?Q?Myj3al2cvJbUGEpiGlHDiHdqUytU6UL0Acp2gznsolvCi8/ex/CV0EMjYZ/6?=
 =?us-ascii?Q?R+I6AdkwpJRoKPfxH1W8RCidK4mb2bNB/zykTFeyeeqFKl+cLvsZUsWYsHKx?=
 =?us-ascii?Q?UTwvl/LLfekS3AOeU+tN9C3ozs/ZshDf1BQdUsMmwYXdNXOrIeyN3BYqZPKI?=
 =?us-ascii?Q?5dmpBOUX1IbuI+yZ02lPD7EeS7FPiw+rGJBgZi3vZGT/3oe06t7QYlHLv/G9?=
 =?us-ascii?Q?gd9CLA5yD7VcUPfE0cAXMLtj4OEfVZLjwPy56pqada0R0vo7wwn1fop1f5jx?=
 =?us-ascii?Q?cTOFRWm7Uh7G2cmvtCxuHeohupe6/c1GUw00QZctXVLu5IkJSwcYWb4tEgAp?=
 =?us-ascii?Q?utw06H9pMtekx0IM2yMrdqLJbdmVBfePW9eldHdjW5jjgHwv5a/1bdoegziN?=
 =?us-ascii?Q?uRpXten+VJtkUEIpnRINVmab5OqJ1KXHYRtxY0XvvTIWrlYgGXCyoRyQ16HY?=
 =?us-ascii?Q?I435gk3rWJiuvAdNreblAUbKqexE1heHdb6+NRTTq9tQFdL8/A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239d5e50-6e9d-423c-c051-08df3fff73a4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:24:10.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343

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

