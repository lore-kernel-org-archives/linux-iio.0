Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342364;
	b=ITuxO6aAB8/rrPMV1KDsFzEECiA6Whfz/OyTDK3/VxlhGdL6ZPztW0Hn1pId/uBf0W1A
	 AuoAWmxcSltyF+H6O4gf9AxHgicRxFgtlzPRNeH8RFNKSs3awgTclJWDqpP/6IafFAtSw
	 Ttem0//iZzJMs//yl9i4vPyybK6i7LBy+Z79rtSYW+fnQRfaUDvtUWBa2/04kxfgPE2QS
	 8o0XCfxsJmhGDyU4I3qWLdjUgtzwupiNLBRODR9MDZsndO5X4W4p734PNrjLZa8FDeLdK
	 3MPEH1mEXZmX/Lf9lXKVY7zWrKDQoJqtdK8ixr9Rm2CvosOS8cES3+l5WiCEN0B71lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342364;
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
	b=1Z03EoaWAQvEhnhvfrpGFPJs04YdVFBGhMsmwqWfRiJelmZe0V+2rT4B82WDs0afDICU
	 OuTGzSSL7lFTNaMs3ltSxNSGZwVm9BiP2A0pJ/FdvvgGbnOAuHxPnyK2k2LYkBwC6lbis
	 xVbEGekRkLiKpnOnr3V7HTe7gDctth30DLMk72kHRYfgpkuxKYpFqv3DWsJSyIGLKjvIC
	 gMVkEKFjdCv1DQ+apGi/mixfjYRPeu/2+9A7QMyb4G7ERDH70kBFI8+RX8U8W0/g1frfZ
	 ws8f985XLYNvuIuk7OXK5+GKQwxiH2d1tXp0cGClKBq+lZw1Od/zDc31+LWKxjZV9hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gin1Pl4o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.94
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013094.outbound.protection.outlook.com [52.103.20.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C38606A327;
	Tue, 10 Nov 2026 20:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C38606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gin1Pl4o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+pyu70rNq7yc4QDBqnA5DlD/UWPynQn5O5/jcUUcmW0qkQp88EWJI8o4H37sMso+c10uE3KerDNAlKtWDLDu+JpWY6IClucZAcK2OJzjQntBPLIeA5UfBVMku4AHn3f03U471xt5pcpg1Avb7JJYl0W4Np+1dNgErBN4c9aITpta1k64Ro+b7fuA1k89cbGEbhdAwqdTKqBdhfJRhFudXtZ8d4kUsgKS/cYUmmdWXiu8L5KmBhp3Aai9v0QKMiRRM+vDDattHbqUPKF8RUJnDPFm69OqTbtVDsaH1nmIlzXNT7+gtoI0/14rIxKl3erM2vExVZPszkjJ7AQbM0Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=vPyGJhzypqHug/fCZsbAKojJRUQtrCrRU4A2hJKNnk7mmVhsJDHXB2VuxYTDjNxs+Ew5DtsIkRa/baE0lpAJsDrIr707npb3tAMV9fSziSHplz4o1PWPDSPXGQJ+8H3jKTOhiLM4VelLuIUkUvo41dXd5oLgdtbh8Ez03/niFTDvZXioluhwoORA2dEOkISJrvyKj4xWhySVeSWNQ5rNJpcYqaGBS51bEAye48cppEBmBzT0Wo+u27Botwb25P8zx3hHBo8+8LUtrxXWOTu10+kNvRGgdtprqHdTBGeqAtOshtgaUyW4NWmfS7w30WDJbYhZfK3xirAMjbnJoKPoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=gin1Pl4o3CNPviHbAMhDLdxVqzLDeZoytka/l9Jsl8MwXv+YVnT2CtExGY0RygWQb0Orfg5Sr4uuSvzxMxjAPs+PHk3P4f/tKRziKo3kAuT/Xs9ocCYl3M1QV+mkV9uXPEpHHrpRXSTttwzkHkCCYJPGVYR4UpPxPJrXQ1c/3L2cj2+nAEoiYyml0aalDi0Xf9KxP9gtdMRKDHCjWR6/MpoMKJGSD0No7EBmLrrGrxz9JalPM8S2NPqXVSCXL9ZCBXP+V27dQhTGAqhxu/hcm+tm6l8W7isxAX6z4PX36M+xyvfxmDFKZyk8FXLjINpmztR4VOByRlL8EhLsrKubxQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:24:39 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 20:24:39 +0000
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
Subject: [PATCH v8 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Tue, 10 Nov 2026 14:24:21 -0600
Message-ID:
 <SN1PR12MB2528559BC6A7A34582DE05BDA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:8:44d::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110202424.1100154-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b97f6841-60df-4011-18d6-08df3f68a379
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|15080799012|24121999003|22091999003|16041099003|41001999006|19110799012|8060799015|25010399006|260925184616899003|4140399003|24021099003|440099028|3412199025|10035399007|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6UbIPdDvh++QD1J1q3+YtX+xI/Zcz79j02OgdXabbkz+kc5GXbXJ+yBHbgcT?=
 =?us-ascii?Q?bm10yLBSvE3gW80SUVOxQeAe6obMIx6aPWpsfM44XXjhMiIM71DUUN2DdEuq?=
 =?us-ascii?Q?s4n4MNGfO6XXfdy9rD5wqqqi/YOo5zwVOk8wP9rJY2QPU4IoFn3/LlL/7QQW?=
 =?us-ascii?Q?e7n2X9/eQRSG3jpDLi5WPIXfvnCNU/aPhaz/FS0sgW/aZt/JxyqJvX3HriZk?=
 =?us-ascii?Q?pQsgL/w1BEmqIfe+jwIvn3L0wg4G1hQRpQCO2Jq1gfK1UTZG13Gh1j/MZec4?=
 =?us-ascii?Q?FiDbf5koGBKwHjxwacF45n7o6rcogv4rnmCUrMa22n5n4HVf8ZI9DhFhfQLO?=
 =?us-ascii?Q?FpJle1alNo5IS9YrB5OQXgD2u/Cju2Tfqc8MSh7Op9R+qo3bPZgrxDTITMFM?=
 =?us-ascii?Q?w+C3iiNADjr72GD9XauWGs+ktOUQ2u5tWVh/VhNKbrNj9cpv/7JsdfgFXcL/?=
 =?us-ascii?Q?msdd0mO4ghYCs5IUMB31Y6wcZUSbz16nCb+Y65vJOLKZWey4HhqhC1s4oO26?=
 =?us-ascii?Q?pMqthJWjbRvKPqAZ61qpbdswnx+2AJ57VDt3PXapy2gjYn94fGs2WqR+xO7A?=
 =?us-ascii?Q?aPeXbWjkhFOBtewXgxt2Mp2XyAnbbZMaJTZI5A3JwSPhRBmO5UZuyGDunOVd?=
 =?us-ascii?Q?9Hk90nUjqeke6KlFqSa577QRKSe0QjJCsxbdRqJN4tu9muVSq+iJYrKHsjib?=
 =?us-ascii?Q?UKe8Ef2QmpJ5rUTZhN2Cj74YmEepVUxzECiudLafftEumCHsIzr4VT0WXFpt?=
 =?us-ascii?Q?r9OHpseuKF0Eq91aimEfjmmPS7yCanLkA9na3ZacRqXcTlCu3aRWYmHWyD+N?=
 =?us-ascii?Q?kTVERRZ+5NMdLDGMVGqaaEpzpCDw5C9IGnVrjqLnhqPu7Rd+aMNtp+7ECIk3?=
 =?us-ascii?Q?6TIZ6M5ayDoLrFC4b+P9zcXsrCrKO7IoOQpTOLGdi4RRnHElt0kbKJJ4KSrN?=
 =?us-ascii?Q?wnOM5WnIrePj2/5h2IwWpK59Wno9qMADWHTSr6Ygoywx/I9eWI91TG2D+Mmf?=
 =?us-ascii?Q?xvqN6YAbt0fo1QrRE74ZXbBZdZWxcch0KSm1P3mU7Eh9g0tdAHkKxOeBUI3G?=
 =?us-ascii?Q?74ad9BFfa5jB3t58X9A9VVXwb3LKRdep1/3GS883ZOK3AHJsDYo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTnDx9NQfJM/zykS3m1aXhShRVjpFST2MIVdICNpEnOHTVfTFkze32GIHtdE?=
 =?us-ascii?Q?hlZWTbvfmpETZ+F/kjoG/WVXRdsOS/zhjHRtUdtL4T/3ZkWoyuIWKPs7czqG?=
 =?us-ascii?Q?p4U1qGJSgqcY0r0RY6E6FCzQcXllJWdzmV6QVkxQUUjcNDffE3RjZIOeilE4?=
 =?us-ascii?Q?Dop0oM331p0m+tzVFp1kSw0ui+BTNAmYhhnWjuj0b0qJGnY9mAixDvNE1pz7?=
 =?us-ascii?Q?1pFxMmxHwdjtleRmmHqwr1Nt/mylbdGuwQKdf1UYftZ518ITaGpH8wjt37sg?=
 =?us-ascii?Q?B+fRROolorg0pFVlxIvJ+K63ThK4FhLeOEEFz3jX/qT44t3iBDKO1NNWFwjw?=
 =?us-ascii?Q?vjE/P+4srzpy62CcbGNLMA1o1l+eE2vAFRxTs84ddgjs2gZXYtz5zg2eGwhG?=
 =?us-ascii?Q?/Ptkx+MoW6auc11BJj9Sa6cxrlzH+B+yzCKKGmIP7+OIr+ZDprmigZVCh+Bo?=
 =?us-ascii?Q?xXPqoYB2hPGZNod7bxEHnCUgzsktfOMZBYAbsjKd74XxoKaRJz9qXj5WtnrQ?=
 =?us-ascii?Q?LpQil5ZeD9pjmrG1Q1TXJMOdlnWvdeqPms3x9ReU/K3NKaWGbEjTb4CT1+4l?=
 =?us-ascii?Q?1G6quUKG+nLk/+E0I+6oanXFhdskfnn8HwqrLxwHii6Xq+XkXocKsqb9FPh3?=
 =?us-ascii?Q?Q/QVHWsMpnH1QqnNDcNsukYpABod7vjvTGI5x6rK4NQJ3tGuNiQo3oUxmFkD?=
 =?us-ascii?Q?Jec4L4ciQm4Yr0yDMkyImWTySJxcNaCNkjSCRQHcVmZCfrm6k6cf1YMC6/9h?=
 =?us-ascii?Q?skYV4wXto2mKKV9jJmRYpceslxwN0l/qEMsUHp1NOwKQ5PcjmsMBaGyLQgJN?=
 =?us-ascii?Q?XmVHcQ+nlwwUBqIKRhTkdtbzQVF3O7NCQqRu6xviSFkRqOEty9+jiB4ERjbs?=
 =?us-ascii?Q?zdXy5j5GGWRCBqA9giiabjyfRKrME4HCONc9nKqTrF15iR3KRl+pw6QPi3Yy?=
 =?us-ascii?Q?VL9P+I9zteD0dHYLVMEFj7e4cr1dp2bZ0V47ks7m1qHw3gikLEX/wbl6oYHp?=
 =?us-ascii?Q?oWecfCZQmJCNSyqqqkPWBNblii+YhDkD34SXYXHMA4dcb/IXon/rb4lsmh5x?=
 =?us-ascii?Q?DesksVSEuHN2arBT14ImlFjls+j9ioT8w0NwbqyW04wNYOXudSrrNmBUsZcw?=
 =?us-ascii?Q?WieAjl3BGaHbx1LSN8ZbGln15oMSNVYaEgO3crAJ7OHBB8qksiTPYRhUKNsm?=
 =?us-ascii?Q?L5YZDBRVQ98TIFdLzWvMTzS/8Juim6Ot+4lA90or3TAoGLSrWS8YxXDVKQcC?=
 =?us-ascii?Q?R84BXqTiXY/HSnYGZAHVVxy/HYaZo3qfyyZZpv/3hw6FbVZsyC/sTh/cl0ZT?=
 =?us-ascii?Q?BiVe9PifeKdEM3BdWnx+JNC7cSjYWbaRDcm7iLEIuN+BPLLp/0bbaKbLpEm5?=
 =?us-ascii?Q?sydXSqoQjBizkJTw35m038kTUMXznFLuqu+QI8GNfQof0ozl1g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f6841-60df-4011-18d6-08df3f68a379
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:24:36.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

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

