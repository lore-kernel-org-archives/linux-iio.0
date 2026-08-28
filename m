Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023120.outbound.protection.outlook.com [40.93.196.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3A2652B2;
	Fri, 28 Aug 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920141; cv=fail; b=shfddyVApj9HSng59YJBb+Sojs08e5ZSCr+dqZkJgiAzgZiEue9NJaMTTxX5jJcTLZnBXQ3OBdqUogOsacmIMJ31y6PqYHUfjK5QJwh9XGFfpr4GLTb49z/iTpacSu5eZYaAFWUe08ArQyb5hA59dJyOTAFVgYR0KpPbhdMqBHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920141; c=relaxed/simple;
	bh=vkAKsJ2m95gzrXwsGVTAt+RuWciSLhwK1Ha1FjbN7G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVmnbhw/6wpR6vMJhJjDu9NnCaGTAZo9dPllFYzfylu4Qre5E/nMF6lsVxgD0CXs989fU4AbExJETAtdgL4HJ1CKtmTRlKu4VXALpKp1nCzG8jol+XisaZ4HTV7k0KkGR5nI3IJ375ydPxEU6E8jFp8wPHcK5BHSBS2mifH5i0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=vJCVNBk5; arc=fail smtp.client-ip=40.93.196.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="vJCVNBk5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqazEviKgo2b/tsASk4IvI2zBdprxeE8GzjJskJnG9lepIm6x+IUyjMufQeAS78xaSnVhB0rL/AjO0qBnI6FGMANuF1jNF5Bw8jI7brbpz2vUyhAhi4562BacjvYD4nv1uBqora1Us5knZtkyQE+aJwXdKpNkauNsr/r7d6XB68z9bmJ7y3S1jgsRK/+y9OgxeuELyZGFdJZ7/cXDVshTS/VLhjVWPKPYKNVyhRt3ydt75qZg7p1OBUA9QvLznGlWMw/gA+7qc61vd7dezMighhzdFgvtD8n0rblc4ex3AqrleUT+GrUn1Le71cj9i1FKhk8KzzFJltx+2zMr3pGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+52g/0eepX9Ma7LUQ65DCe5CMz6aX+KN5W9QaXaWHo=;
 b=qrXauXKH0KC3DipsL9vOc2DGPvfdLzJK/ByfQmrYasyasGbLi2HV+9PalPBjtN+wYSvcGohgOAghk7oxk7nOuO1g8+PPps+FHGJz/FtWXKH2TjKgeqGEqeuGoSM+6qaB8XcKLxjk4GKqRtdmcHE/hBeMzHGa50P4qO/MpeALe2yO0FDYJQkoB80/hMA0Yks1hHqZl3HQGkaWhu9Hc3qxJHKfuKdHNm69vwaa0NoB4CGVtGSNYt/WVbDeiODxcL0g6arUJ5NOArT2ktNn/SSQloaaSJT8tGIuHxXQc29Jup7BzUUHvkDjVietde7F9SyFAoeAX8/w56O6TZw8jaxoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+52g/0eepX9Ma7LUQ65DCe5CMz6aX+KN5W9QaXaWHo=;
 b=vJCVNBk55yO03lzFcJ+8gHJV7aquKyLEhlDoSVnZXKdVdamZIvaqMMzkaiIW3krjFyJTdpLcTCQ1UBV2cwTvxGRsxy8OuEgap2CbiCu8ddxMMpay1xuqPHHNBqnVZqgC2hkn0WRGowdfCcdvh+qdeKJ7oLWjZ2O7sCdUQ5ObP+PdhzSsZ0Tw8r0IwpYri7wZ1tcpXRAsHFD0uB2/fUWwhPS7Ke/hY4QK9mmd3rNcquo+0XQy6iSpedceVA8o3l0rvQIlfeFTOovlM75Xjun8bLPBLgIprKOaipZE76u90yCupPXyZUNfGZiy1pI/jvolYHkk++C4v1goFKZgpOQmLQ==
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by LV3PR18MB5664.namprd18.prod.outlook.com (2603:10b6:408:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:28:41 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::af) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 12:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 12:28:41 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id B90954186B5D;
	Fri, 28 Aug 2026 05:28:40 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Fri, 28 Aug 2026 05:28:28 -0700
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: add Axiado AX3000/AX3005
 SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-axiado-ax3000-ax3005-saradc-v6-1-4cea467e4167@axiado.com>
References: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
In-Reply-To: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787920120; l=2961;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=vkAKsJ2m95gzrXwsGVTAt+RuWciSLhwK1Ha1FjbN7G8=;
 b=pZEHgFDas/wRVYG1Vbl0fUQOU7Zwyh/iAAU99RzfcEC032EdsgB53i0lkrpD459NokZ9+2zG2
 mm3DnXmihAGCDkgXaRBNPy3AuraBB7hZNlKq+Xgp6kLWKbmJEDhnnxp
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|LV3PR18MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: b58b1fce-ff3e-48c0-b492-08df04ffe50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|13003099007|921020|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a0sHOGg4ULl8/QkzaOzh9tPEm1pxQ/pirvOd/un2OSsP3C1ra7hoDhEKoeUAlJmErKf3WZovTHyu+/tAHMwwK5BAgDaUHkHFURCBOiyNkSbxJwIGetwCMBAfyddpGzt6s7dz7k6UkKmkHI7V13XTGSEpCPdmsbt38utJXWSdDQ4UBRPGVcFAmFpbFnvaAOEE8kUXpVEL2bXLsyd6RTXlSfz5rlDQ0a2S07xddExBAePdK6TOmN5+MMbDpERQoo2Mub1WC8kKwWNeSm0hyahljGFSqTX2v9SDPdYhLLhdeOypqV3dXh3zJCjm2khDzN4FzQEGktyikT9yIOiEi8oPgsU2RxQulf5gPB/WjBJJlFTEIUAUDAv8/0uMXa/PlDL0xibJqlyjhr0brT2SU6uzOU4TcvIT5DABviyuwxfHC7gDM4anvECZ+CLpnJ8KMV5gb6lsRyks87ZUaPtexywsVLPTMRwqetLtN+N60XAAmLvmNusLwk+vPlz8oY7i4/uqkCHP9MpcqEBwQ/nhGC2BcxLPrqCEJMjb/yVDD6uKpfbkdBPGX9shl5TokFlnmJOD05MqRqqCOPp7JIZhYK1COD/kXms78YMhmC7Iy8bZrE6feF/z8dZpYsl/ikiSunvRX7a72h6hz6e717Rphyovv+6dtffaM0vO7/Pkv8meFrmRtslQWiFf5XX7UY0oQNYL
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(13003099007)(921020)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FIsEdjqM83AeWE25liuQY0gsGatoM1tihg493KzI6MfGtKtVbdV13K1KrhD7tdDV7Ab/2AtqgYa8hIzS7piE6zDEAsWr5Dscm7KnKmzQfFMvo0OtRIyo+za1/lewmuqiME4garCvGA5SeBYrmcpsj/D78kJSF8S1N2pl9XvzPHb4ivwfbSGRhxUGd0ghaANcN2GdQmJCwchVdU6bgiJGnf58a8UE56/w0pcR9lpq61rOcCBDJ27x4S5iq5uI/2dy9CvdnIfgdbMDpj0eFmlP0neOry59mMW58fOM6OQXX79pmClhK2cck2eS/IKACuS+pPY3mMVCRXUfUfqSzFubm/VO7M0n7O5N75xJsVm7JxPjBoc6qIrXSFlGddiVyHvhaA8Ia/QZvwxesJoC4Y036bdOyGoP8sMkC2kznPA5Xrz3uokvJ6U3nzzQBRTo4Me6
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:28:41.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58b1fce-ff3e-48c0-b492-08df04ffe50e
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5664

The Axiado AX3000 and AX3005 SoCs include a 10-bit SAR ADC controller.
AX3000 supports 16 input channels, while AX3005 supports 8 input
channels.

Document the compatible strings, register region, clock, reference
voltage supply, and IIO channel cells.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     | 63 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
new file mode 100644
index 000000000000..b910852aa56f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/axiado,ax3000-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000/AX3005 Successive Approximation Register ADC
+
+description:
+  The Axiado AX3000/AX3005 SAR ADC is a 10-bit ADC with sixteen input
+  channels on AX3000 and eight input channels on AX3005.
+
+maintainers:
+  - Petar Stepanovic <pstepanovic@axiado.com>
+  - Akhila Kavi <akavi@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+properties:
+  compatible:
+    enum:
+      - axiado,ax3000-saradc
+      - axiado,ax3005-saradc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: saradc
+
+  '#io-channel-cells':
+    const: 1
+
+  vref-supply:
+    description: Reference voltage regulator supplying the ADC
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#io-channel-cells'
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      adc@806a0000 {
+        compatible = "axiado,ax3000-saradc";
+        reg = <0x0 0x806a0000 0x0 0x400>;
+        clocks = <&pclk>;
+        clock-names = "saradc";
+        vref-supply = <&vref_reg>;
+        #io-channel-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..d6f4febfe4fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4312,6 +4312,14 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXIADO SARADC DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
+
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>

-- 
2.34.1

