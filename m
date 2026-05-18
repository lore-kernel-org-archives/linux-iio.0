Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382152FF155;
	Mon, 18 May 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092361; cv=fail; b=u9TYH2iId2SIke62P5GkeRi59p4cQfvAFyp9t7BJMn3qojaH4XeYXdg9FNy0ncdkDZZ7C8PoCjOXR6ExM5mkKpGODnGQLpx0cQlme3DcF4glk8EQsD5Gd1ZcoAB90UEOxZspL6ldSUPVsK35a60Tu8DwZyysloutv9Fx15M7CqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092361; c=relaxed/simple;
	bh=avM1RIf++j79DYg73egp4ai/MvMsPTmL1PSVDbDzfkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFJDbU6b4tCsCgl+x0UgWhEhs+E81MdedimGh91Ot+Nf+wUXNkcqBmfNg1dJ3bqm8KxIxXTw80e0XDxwe5x5SItHNo3Ph3wO24FBnM0CWAD6ya8uOGBwggQgoPYPuHKTdTkdGcjAVhBxzs4Lm7k90nEFvdl1C7QPnpkg3vnGC38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao1qC/ktHkp79L+6EGXedG+u1ODb7+yK+TbM7DGYG/MwHFd65iJKXRVpP8n4hPt49cupVsiFUg9hDqP7l3DGUxqOMM9YLWKr+0Zs8nTDZNeHcA6wiYHTeL0KxZdtoHNpF4XuylZY8VcEVUVmpmSw3duI8RTY9fiPa4ZwvKUug0IN1Jl11sAwRBrX0xfwgZ5PZ4IBYDf+r5pKK0jQXAycYhfEqngENLarsY93sVpch2uAUA6yO1ybFlNl/Iqt1SAmepAPjfp5gWaAYRtmJB2rGtop/VnN/2U9r6XXIHAGxrrHyY4fmN6K0V/LGchPBA7h3VODGrRHZXUzSo7IJcTCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=246wiwKxGpc4pEv6Xw3nRSZQT0t8ZMUdaz7BSuKFU5w=;
 b=oX23IOri7RiDMw6CU3Elyy3hWHA6EbHguCaF0UY6RNgrpiN8vzxnIKZaAJIKsX2oLKYb/Qyw9XQN2rX051GwKwJ+Py3cjIfNv9IS27ZqxjSpKIe3xlgS5y+xldrqLhhl8X8CwXIYCDdJqO9Onow3kFxPKLIM3SnWmqajd7f4c4hrav1/UTta3bHvzeuRMHlPqVM6qKHToc7CjG662Xj242nVEsQ7uLdKda/WaivbIfBglNu5ur6FXqaR5Dq6kZ95PODRduypl5mhJkO9A9kxBA8pTaXiYS6qZYf6v5QJOex5CMBAUy2Lolx9IwPSdweLRSi6cbeSKtPY3O4nITHc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Mon, 18 May
 2026 08:19:01 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.20.9913.012; Mon, 18 May 2026 08:19:01 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Date: Mon, 18 May 2026 16:18:51 +0800
Message-Id: <20260518081852.116909-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::31) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1035:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bf02de-129a-4617-40f1-08deb4b61dd7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|18002099003|56012099003|22082099003|3023799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Kk8cI/laLDqDmAWl/G0QDK2Yv09fuK6NDIHsTdSngB9Jc0YdaXmRCF8mRfk0TSHO+ayx0N3CcgMfkuC3Rpl50n+XzhGUm7Mtqi6dRNyGv5YXZRlyk4SHg2Fa2iPxdrONUXaSeZgM+z3s69T6tw+vzy2qe62jm51rMxbFkdH3SDXy71qLbIPXEzNHap2kbi8v0M3iujhLtmMWk0Qw9Ebo17HRMx6MteRoRjmhDLhQYNBFtesXKD7bK46UPXMXZCnxOxc0wlgQ9GyqMTt5xenQKF5lvcEIR6pzfZLYSD1pUCrM+/PBCtG645R8AUTFUSWmhgkXp0J51RAFIaH4GfgQ8EJy9KFdZ1si3xUszzm2uUqfecFqILlTtYmL6RNWVtRxiAPtsrgDIVFOhCCRFmXwdFFTc8UonvVGezlX2grOPJ1B1w9ykIwiqlG7wuQUjfOLmNgIY7wFi40PB3GvKt8UUU5H3LAiXmwPZN1230dAiUgjindJtkNzoF21c/NODjVP9FJqPuFi7d3Ug9zGlomOtwxa/WB05ukTILuOOKLnDcfAVxOuewQjA3JSatN38tr2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(18002099003)(56012099003)(22082099003)(3023799003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4/8l1gMCekTzMgxBtwNn+9clrdC5/wij42e9E7vGPyt1OJH+b+YnrvgPUSl?=
 =?us-ascii?Q?sHhYdKq91FHJ22wC1Cu8aS8oDn46R4BOyyoXceDZ0JSEcFDggkNrbIXwMjm5?=
 =?us-ascii?Q?d3aX65+aFiSrvHRckb+0aTiMvmkzNfkrRqJ4Ldo1lDpfMgOnKQPwPazMPMBQ?=
 =?us-ascii?Q?XvNDKvLhNMJMlAuLj2he1N3fhNhIOicVilZ+duBvAk8mAP7UZYdB8V3zEsr6?=
 =?us-ascii?Q?O/kKB2Z5X4zWJa3vfRssb2pDOKmuIBBDlpEVqc1F3JD+obdMHdvsKBMYqbMD?=
 =?us-ascii?Q?wMqwdxt9CF0UrZIfeVViItMu5qM2ETZOiKPO1BzNHj2UWXLyg9s3uU0GRMd0?=
 =?us-ascii?Q?dSBBBgBS9jDhwU3KvXngYQl4AAlAsQ/RwfFieErI2rSKtKjLAFAblTnIL9Sp?=
 =?us-ascii?Q?r714m1jAQRHovvNfwuUTzS8VALmxtrxp5XD7S2vtjKD0i/vGBoB2Q4JESS8Z?=
 =?us-ascii?Q?0uSrXo5v5Kx7Juqz6edVcSn6usmJ2u3OOeB/NVT4OTvnDQFQiCaEbNqv8Xl+?=
 =?us-ascii?Q?4jeE1GqxB+0vGuMC39vIjoZQvGPZSOr7J/1s5w9SV2z4NzUSF0Y8+KAaKhPa?=
 =?us-ascii?Q?WR6fqWN1eLrDwb1IRt2kFfUTU6kq+Ut//oR9s5w5jL5wZ2WIIXp+njHupjDk?=
 =?us-ascii?Q?HcQ05jvmddqQX7BonyRnhxH+8bSb33K9sR9JkQvJOdK47FzXZwQCdHVDCec4?=
 =?us-ascii?Q?MuHmArYxH1medCMVVNQZCh9I3/FEGBxSoEkShIEHzHY9vcJixC7MGlEg3VFk?=
 =?us-ascii?Q?jnIVSexRaewGRoLH/CuVjjmbGpre6W2Y18XCHcjt6ld99QIS0p7yqV8MG504?=
 =?us-ascii?Q?CTgsQcswhCEM2k4A7QJl67gW0b8ZcAMPM+8nAdZP+U4pdNuVVcZnnK6Yv7vB?=
 =?us-ascii?Q?Nq3jXFVixETHEQ1W+aXrijnwiIv1u1vMcyDzCn+8/SzAoZkDE3LpinOO5np0?=
 =?us-ascii?Q?6PoB+ghUyl0GwNBE+OTwFTD3NHLeeChuU+v0SASiOII3FbmuRd+kJDzROgk9?=
 =?us-ascii?Q?QxNFxoBTbTEmbQ609WgNA5NfaAdnGua6Sdl5toZb+ntOx+hsz4Ycwd0/JQoe?=
 =?us-ascii?Q?AoaIA/i11RBEGNVfBVR6yVYDvwDTLQvGi+/G+NFqahMBfcChAIb5j81YHb/w?=
 =?us-ascii?Q?zbcW8lqXVyqH4mqjgsLYb/UNZycQo1hlDjPvjzH3G0Da7Vc1DR3pF1Nw50ZE?=
 =?us-ascii?Q?+EsKgRtv/qVQ/GQuYFblt9Xp1sLLsiGpzVhrnYWfSdzOFzM08DW9dFsnP44k?=
 =?us-ascii?Q?7OL+GBP0YYBx9sHOsVw7GoSKYlnHdwvXC1MPXletI/knIN+tbe9ZOOGsdI0b?=
 =?us-ascii?Q?o+PELlL2oT+gVZVL69iFwVjJMVj2a4+fiA1udN3MCdxKFBxFw7iw1qEt4crX?=
 =?us-ascii?Q?HLjmaLF3TOz4sb+pCHPomSDnbAjv1fn0YTAH7RkjlZl+Pk7g6yhsgI5A8/NH?=
 =?us-ascii?Q?eYNe7pFLEjEKguq72kg0hxX33xphot4BwxYzYy0cA6Sjmhqr5MvSmf7Y4pwM?=
 =?us-ascii?Q?ozTlncnShlBooFGTW5ARHfgZEVzeaMyRJryI2PM2SgW8MMwN9ugyfit8Intg?=
 =?us-ascii?Q?sKmoXBHEhtPlE8eYApSGu6g4Eu74Rz4/Jv3dO6Mdi66hcOEDo1otZVFXRuKI?=
 =?us-ascii?Q?Xp0OaZAOm4T5EoyMAPAj8MKmMnjJuQ24xArwx0aW2T81aeb7WHdnS9ldcdb4?=
 =?us-ascii?Q?d5vzkZ90aM09OOX+bQi8uDvGx/sKazo9ZqvXbizQWbU5tbRFoQPmhuXV2N6a?=
 =?us-ascii?Q?jgIORrMI2NOQm0uyr+pjHectanZWRVI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf02de-129a-4617-40f1-08deb4b61dd7
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:19:01.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRX1b+J+1AgFQF/Em/8a2yRALYxGT5ZGWFIr03krRPlLhxLC4im6Oa4jxmTl8GnZ2E6PHv08wmLISJkVD7UL9OBJS65zBGg4IymLUhBpLB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1035

Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
new file mode 100644
index 000000000000..ba8e19b72ad7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Successive Approximation Register (SAR) A/D converter for the StarFive JHB100 SoC
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-saradc
+
+  reg:
+    maxItem: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  "#io-channel-cells":
+    const: 1
+
+  upper-bound-mv:
+    description: The upper bound voltage value of the monitor.
+    $ref: /schemas/types.yaml#/definitions/uint16
+
+  lower-bound-mv:
+    description: The lower bound voltage value of the monitor.
+    $ref: /schemas/types.yaml#/definitions/uint16
+
+  scan-freq:
+    description: Number of the scan cycle interval.
+    $ref: /schemas/types.yaml#/definitions/uint16
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    adc@11be1400 {
+      compatible = "starfive,jhb100-saradc";
+      reg = <0x11be1400 0x400>;
+      interrupts = <172>;
+      clocks = <&per0crg 18>;
+      resets = <&per0crg 11>, <&per0crg 46>;
+      #io-channel-cells = <1>;
+      };
-- 
2.34.1

