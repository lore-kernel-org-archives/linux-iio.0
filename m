Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033499;
	b=qW/hxzB6rRn32IekDREa8wn6e6vXWi4nOy8v62LZMpC6TAfJWEwrDsyLvJg3wDRRq7v6
	 eCz5HtQOuDgPiVgYP/cmLT8Ap3eZix7X2y3h8jFPYWzZi2LsLVB2MjGdHGn0zrPbvc/Qp
	 1FVCyR9EjjPPzu2J5+ISgpOOzLoMd2TjvkuKMehVI8X0+7qLTx34mwjBAREZh81SjsqUt
	 X5XF6aEgR8S6P3dnwc7MpYKKekfAB23TcyXXucldPhYdmeAXYTrFaFMOflsxDC42zOWR6
	 uJmRTmShJ1mKc+cdbOynqqGlLDHStJvC/bN2oHjZ3qbsEAdloTcg2k1uVXW5NuLH16A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033499;
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
	b=mw2diroR2oOsjXLmYF/vvU9Pd+eIVJGQxWCeQS7aXT3uXglDydPxTyKKKu8DgqmHkoTV
	 e74k0agnWi/ghgqK6NHULqsCQu5ySFMDj8MhvB7cgm6IYIA6BMseS8m2mugVcY5t2hFj2
	 CElDNrLMm3p59r1fRhs+wU/cPcvP3KHhF4B7ZRJx8MCz6KafWzq0VQzhvPVIHGDW7DQMD
	 EoJHTmAbdmoCjDtTkhEydS2Yna6+jCXLiGN9/V9RFFPtq9zZTgpBc5BBT0tNJhtIq84Az
	 GzVwQOrK9tbQ2qjfvCaJHdtqf/mEHCoIAgo6q9ajhpsOs+UN969rHxSTPjxS669aKxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jn3GZcEH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.16
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012016.outbound.protection.outlook.com [52.103.10.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2A606A323;
	Mon, 26 Oct 2026 16:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF2A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jn3GZcEH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2YISvo8LzmrNhjpLFLDsr8YV4af0WMS/46daSEi3kFuUYfatoYtrjLdmEXCqvWZI0EuSa1G8Aqv9YxEcxu1whsZgkhPHxwx6hLm3KM3sVckFQNv7bagnOE6AYByE7zWqMgsmsd9OXEbkr5f74gIbn+kuH88s1vmg6qVm2ngREb1Dbb6LAH0wf+9idZpJQP4ZYAIHBZec9YGq1yfZUMGbDqK0tpImt1zkLEIhQd+z8rSSnC81jr4CmsJjOaKgCe60zXPkE7a+rzhNJ4VpkXcFbAkDOzg8d4IVmx1VrXKB5qk/iJNz3v/YLnPE2SbMpAPK32UQMz3m9iEA8NKEi37gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=X/ZW6U7TM9Cha76ZODw2lks1rTc+WDf9n/jCbtZL9AVe0DCI/vFueo6EfJv/uG1MePDpXGv9NvR32qI0sGFRMPvUI/zXtAbGq1FsDskVmgPsb2J1i7C+NhFcSLr8Co0VNk6LHsTE4M0KUSeLO8jk6e0UR9gafnkEILLkU5DqioFERFhsoaeDDAa0R+6TW8pYXvZwGkN2PWrfXmiE/O4WMx18f0hVPLqAiZ6aNvTPml4sHCpfa2AaQVOnlChlO2t31D9gMA0DNnQKl6x2MCoMw3hy6SjZFGi47188agxQhOz5jMMddM0XWHZBM2wbwl88hl8LcXWekX2zOtgcc8yw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn5e4Ech3d6klTQ9EJpYJxMHSOHb0r/AlrwBsKAm4MU=;
 b=jn3GZcEHLBtbEgroyCToAaTgfCCHm8B0297+tNCeuLyFujdvwyoK0rq944l45qUl8xiCg9B0UqrwbW6VFAZRa/fPs+xvziG7ct5Jv3RFJUv1WhlMUyHl61/u4iIisUqwPUJ7gx3fBi9DJIxa3ogy9A4qElbpjvb06u1G+dXg2Ek1zSP+R9DFz2HVZWiWG5MAe8DKRHQMBz6xfieB28rQJX3aYbe8AQWqtivfH/a8gRjTAj63FVCQhFUobizaUCYSLk9D6Lk6koLZbEsMslhSAOFhvhlTqmHGUNJTVUEYUVlg8G2DMUWKTm4Flb+3woCeIRUk50OSA6A1X0rOGNSJdw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA3PR12MB389676.namprd12.prod.outlook.com (2603:10b6:208:713::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:51:36 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:51:36 +0000
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
Subject: [PATCH v3 3/4] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Date: Mon, 26 Oct 2026 11:51:13 -0500
Message-ID:
 <SN1PR12MB252830BF288E61EBB262FD18A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165124.119890-4-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA3PR12MB389676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0694f35f-fa54-430a-bab8-08df3381656e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|20031999006|22091999003|23021999003|24071999003|15080799012|24121999003|39105399006|5072599009|41001999006|19110799012|8060799015|260925184616899003|4140399003|25010399006|3412199025|440099028|41105399003|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCTgsWo4+E02MRi0STORBeukY4vUOdyzTS+ga2IGy9BQ/ti4PpZgY/g2FOHZ?=
 =?us-ascii?Q?sr3ikQ4ZvtuoyKbOBMSZGAGtoie50okFCQf6Cx15XE2NYWeHvBDeUbKLaRpu?=
 =?us-ascii?Q?SkP8cw8pDs/q99GpHqlva+y7hOKui51JoJhEyOCxAgvoOp8JJvS5HP0eWGUj?=
 =?us-ascii?Q?5h54juik0Ue1HgbC2nX9xHAMh4Zg58fOlOe4tGj5ZYDsFCGj3sPBILA/R1T7?=
 =?us-ascii?Q?G6S/GSNRhV6nYKfsLsoUChkFqTdtyh0TVetDs3C6TumW/v3YXKInC2KsK0se?=
 =?us-ascii?Q?95PMCGGH+oUxwYl0Vwm2h3kkpJAigl1JLTw56NuavTrjnidyQqFq8cGQlXzi?=
 =?us-ascii?Q?hSy6oMReqEC6I4/XurH2ona2hPfBfMbf8eoxOMwSQGnfpK88hX0BJqelXgFE?=
 =?us-ascii?Q?sB3m/xaIlx7e66nSVpPO1vcDUrQrbgWMU8CvR2EbtLAO1/BkUj9kIYbaH2EL?=
 =?us-ascii?Q?XwQmYRqJWoNVG70gUbZGzU+3fpP67EaXjfHG5qsu30TYvWtsmy27YygJzo67?=
 =?us-ascii?Q?4ln8V9lqI1vSlq7NkkgLQ4WuFUJRf7C4TTsq9henBXdNgvgJDsGmmuG8wd4b?=
 =?us-ascii?Q?oD6X67SepeqPERc10MWOB3M3KbQ7MCyNsvNyIrmk1+y0TidbzE6NHwMeDhNd?=
 =?us-ascii?Q?eKWQKYxv8SBn+ZkZQziGVKMuE0e2m0PCw8Y2IIyRkCdvfHWP+wGV3Kgk+jEQ?=
 =?us-ascii?Q?oEzpk37y9F9QozWXLy6cfK3zwJGHiPABoeIrrh9zzXu/2QKyVFMFRFo623Ch?=
 =?us-ascii?Q?VO9boR8dMyg+ss+2gBjI0tmaL3Xc6iSxI5f965E81mzVLh3oHdZb8N9inRff?=
 =?us-ascii?Q?xCBpeOXz5g82fK9R/tARNelQxJfWXWITiQW1ExPSKIuncGmC8BwluOJVpNtM?=
 =?us-ascii?Q?xxgleca4mQ9GU2hfNFVRZAzMS2syGPRwbRTN4bAUtczHtwkR+py/9Bf8qH35?=
 =?us-ascii?Q?Nw/CtBYwwgLxTJb3PnsL12Ep/2lujhazjmvg0M79vs7eQggmGHErJaMZ4iH7?=
 =?us-ascii?Q?7nJlyzMIhm1AvdE5As32hs/4+AajoLizzLi2oPeLRtF5AhBAto2AQf55xnUQ?=
 =?us-ascii?Q?/T+oI7VXU68xPiFCdbj2anZlsaFqp4ZChg6i4gxN68+lqqvK6HPJENd7C/Hs?=
 =?us-ascii?Q?IODWg88p5l4+vPJuwymEHY9q4ydeahbS4RfVoLdtWeEeyLwDFpW7QIGMZBGx?=
 =?us-ascii?Q?jAQ4M9M5IU0dzf4neGILbHZigSjrOL8DKusd9w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Efj080scUx1RjenXdN647n9AHJYfVU1F+GPB5D7nRqKOO9kfUpilcL867Iz5?=
 =?us-ascii?Q?s/XRdItDjEDX2e9WcsUTKBpCAbKsnRu0hiXuu9LoByCPqPcc+wYnHS+9L00a?=
 =?us-ascii?Q?n+wBnh5gl98H7g9ivijgs6eb1Cu5Q9QIltO8NN9VjofEL3nwdNoO0oHNln23?=
 =?us-ascii?Q?iAjRSKuv67cyymD1fa5ty+7qqyh4zR8cltF6o+Aga2NoRszXHBTDU45/evp+?=
 =?us-ascii?Q?dGMFei9ylyE5hxEhZRT/7XH/36dcpr8nvMPzz8SG6qGAFMicuQqKKu9NIhlv?=
 =?us-ascii?Q?LUuSfyk9K1PKd4oqB8nDHN/0W97jPKbDKwOzq4HAFm3rdK4k0xWriPecHhNR?=
 =?us-ascii?Q?PWxSBxoA1T0DEjk3DSOEuzwumtLS5TWvBnVCUTvgKDaMOmnkf/04d39LwOmt?=
 =?us-ascii?Q?OMZtHN5CL0TI80OVC+yTXkopzVNs05bdL0GWsAjvrsDcyEVr6PBHpVd2YiTG?=
 =?us-ascii?Q?NbYy8Uy1YvBlWoC7wtbchG5SzRDQgsgs74UfEZ/JUBf2RRRD1PFmpxcTcNrb?=
 =?us-ascii?Q?2YDEbeUk7nbMXRTQ5q33qMcr/jVBUBPrbH586Upx1SlKkvfkArrxeIDmRmt7?=
 =?us-ascii?Q?7R+0bjtXLqvRC1hb+dYvN7/hIvPJRDigtq/vh5Df/3SIjBl4Dm9k6tt8YTti?=
 =?us-ascii?Q?ZPCB7WcCaXyfZUGpZo5Og/YwKpBqdlt5UnGD3H6/aRDpXeMrjiJ7ONqjnYFA?=
 =?us-ascii?Q?QzspVEiVCqmiAS4lPqNPgvc4idhQUObgRPLe+wZ2RXqrX0qFNMFKFCyPLS2j?=
 =?us-ascii?Q?byYKa1HMG6825m2kcFhHdsoG4IUqSMIFbGg+53GS7YT/rv7bn2gwNZAuXJ05?=
 =?us-ascii?Q?WlTBHmuF+jS5hYYB/E6VCDOtIX1EZHA1FocIMC10jIYxaN9XirPiDvQGthNk?=
 =?us-ascii?Q?GY7MqK1t3vc7LJy1urXIPz8aWb5WzmaWKHU5QhBhqoNvuX7f96mE5kGHME25?=
 =?us-ascii?Q?NOm5YhxHVLbBDMWQagpxw9lTHv6TdyLntCAyqiAz54tvsI6BTSy3GDp9S6Nk?=
 =?us-ascii?Q?Ts/ZqmdNa7P3jOHVYRV3IBj48t7OQdw+63NScFnujZINCZW+F2OSWRSN2qPK?=
 =?us-ascii?Q?HOPSBcv1FOPf/A6h8SEUzxQY/kaZba/JPTTddnKzZDCfbOEmnl187C97KGN+?=
 =?us-ascii?Q?nlj+PQWBQyFDwTrcCgCj/TQwU5h48WDwfmtNtfF5btFfqESdKOpr4cEbglBC?=
 =?us-ascii?Q?CagBuPdrgDqBkISSSIBt66cDNvxXqiyJL3+MQFTkTXC/1nZnrUcbM2fSivL4?=
 =?us-ascii?Q?B+JSMpCtuCVtcF9sT+QVUPwnIkqzIHvmke62mullE2f53hd1Ed1p6Ayr274r?=
 =?us-ascii?Q?gjpCGO2dV0k3g0Q5qR/T6DJ2DmtJPUMPuWDz/VwV88oDvWUhmk7/qjwC4OHn?=
 =?us-ascii?Q?oi5F5mM0+XB7dTkFz1TDnyHIIedFuSPGG5C6GscnEPLlLLlv8Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0694f35f-fa54-430a-bab8-08df3381656e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:51:35.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB389676

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

