Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023128.outbound.protection.outlook.com [40.93.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB403BCD3D;
	Thu, 11 Jun 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170704; cv=fail; b=pkXzqEPd7aGmjRdhcAzhmtF+93ZUChZUcF60223yvwNZP5zv11naftlbdiUSL67+n+0U7auGtm4r17IHCkIt1Qm63AEXHvwV5np+evz1ODqoyoZKppCKMYtQsLi/okswvRpXxJ1kHDgT7W/kLVBZELYdPWxp+1abro1pdnVRPYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170704; c=relaxed/simple;
	bh=Ew66nKJhFNAmdvqu9iVmRMIwLOJEo8YdAdbb5syWQEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4BLhEigbnJUA5x5KkYkEzHrCF2RkztdpryZKZ5mEVeKzBgnWg3KXTgk8IY+Ox1j95r9BEsqjYxwj+E2o9MX7llbCkrA96fFhRN4SgeM33FGDFepzzbQRVJ8xq+RXmWWB71Kq5FOzM7/qLud3oPI9k6+plQ8mtj3Nshv27seDho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=SzX2KNYy; arc=fail smtp.client-ip=40.93.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="SzX2KNYy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu86YdwCWGwwoLk1M+TQD6K5mrKCMEQ5K6bSUCmYXG6XlI8NAe4vf7If7yALdI80yKX2+TFDhOqjb10awwe7CGnmzceCGQB+d6pY2Jf8FCoqGbwG34zOpjSsF+1LFiVpvrO0JFt6YCfZILHsI+dGL4R0TbH8e29ugt1vhG1hT7cDv7flfLce7bNL/42OxTisKsD8Lvh1b1SqDFdnKDWq58YXFND6L2Fe1XcbzNFdoOHU9Kzk8OfHYVROcQUdH/yj31Q1pvwWN9syMZjPWlYF1/GaYVlBe4zvR46T9+zJ6mvc2EWqCf9/9IIG6uXRAwdMJlbW2eVTT5K1use0lGq9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7PibXAcIGUzMHkMw4d52MV4Cue1riJ2jFkEYSXTQ0M=;
 b=f7O1jFY5StD1zn9El/ZmqbFbVL0OMQoToGCNCwAEoHAQqx1GX7Ml0971ahfBbYmyzyy0SGxn+xkv5Bk/JsP1DRfMl6LbKYhj+t5McS/e3tkcNjLr8lK2cbrtsJhra0xg1cZxbDeXbtS6IxBjLHkR6MbE2Bw+xL9m2+eoKOxQbRKceXa57LWNNanl4iY5/eSZ97tp1+qcRl1ET0H8xIUiSlRJCq42RsZqWgRSCgR3t92isGtnl3iPlcQT6nit7hZsKpyFHSBvNpjdZF0IkHz1xcMvqjq3oFK+V4erCcQvf7cErHl9AzQQvMqdiLdSYe3RGZwDm2pICvui8onz8IB6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7PibXAcIGUzMHkMw4d52MV4Cue1riJ2jFkEYSXTQ0M=;
 b=SzX2KNYyk311hr3tymy2OqeJZ6M3+eKOz2/RFVFHvy4/oC097ATrEb7eAEbjNJWoVVnCbDQt3mvSkT42m8Q9YGtTf+nevmfNNSccC+HUn30ZsEd2PVK5X3QjLxfTaUfzjXMKicV/cAJNv81CBRYtwkBUYHCEyDk+WOFIJck+aJReaBWPLM0BgkNWopI5vzTntVcZQCaZ00HqJvuGh32g/sMsi2Pqvi47eXZLElk9zuyhoonVbhDcx9J4JHGUnUzAmSFPlPQtmoOn3YngXYJpJmsQMGedxoNa3tHuZ2YZ2OvoKTvBn7FUx4L7DAndnnyr1qZSksPhzuX+RPl7Xg4nZA==
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by PH8PR18MB5292.namprd18.prod.outlook.com (2603:10b6:510:25c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 09:38:17 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::7d) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 09:38:16 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 18CFF4186B5A;
	Thu, 11 Jun 2026 02:35:43 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 11 Jun 2026 02:37:43 -0700
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add Axiado AX3000/AX3005
 SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-axiado-ax3000-ax3005-saradc-v2-1-913c9de7c64c@axiado.com>
References: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
In-Reply-To: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781170695; l=2930;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=Ew66nKJhFNAmdvqu9iVmRMIwLOJEo8YdAdbb5syWQEs=;
 b=FTDqt3xI/uHxhXhNWwq+GgXn7EeRGSbsrXP15vtKMxk197apAy4G0V3SUJufYmE5Y8D6ecLpQ
 FYi0yFJQ84vBktDZ2eZmy7+eXKHAo7VkiHrlx8z56kApmSPMk0vkNZy
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH8PR18MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: caa95dfb-9496-4dbe-ab6e-08dec79d2a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|3023799007|22082099003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	RnY78nlRf8PF0ITObfy4zkcySP2g73WfPKGNaKeSfL5jq1zovCMB7etTYTa9wsnGuCzjRYiJPZKuUmsRjCjAaP0JB+CkW+xVK9VDkoKOH0CsvGkFQQluul0VTqyTwvHWOd/5rJhc4/J4G0VPMchUP/q0PdCEFv7Um8EMOA/2KCALL2diRqnAlaaKo27mpad/GWMeg8fKA/CjLHmZ6ANriLsCznWDnJ7E2kiIigPSjNGMY54DEDYwp+7O9KhHg6JRDd4VpJx6c5BIhtasroi2CmuAss45LWWF2lb83CXReN/0o1+bMX2RYAR1i2xwkDXjr/3/XI7IgmKZfbyFsXhBlRpnGziAoFjfu3dFjmDy7ueNEx5EedmskRf+LBSHcqAgLyunS+v5NKktsK58Ap+bO8Cu+w5hanvhN/shRtCn8NJuNUtNHyKYVeaW+PUSW8J/P0RH62l9Vozwx3YVfrU+0FIFxtX/nNRp8os1OPTlNXckWgcsYNvHjzj1PjFJt/505ApwkZYmg78OFS99+EqljPLL5DDCaaO3CDCpaqmWR3l5RF2n/PBAngTmBIE4b816rrcYSLMS9M5IKLribZHQoVFszHLLID7y/Ykv2Hldkxr6WpoclRJmYelVIic/W9aev4e4THMqfUFIVl6B93t5KtqVmBhrw/O7rudCnSiXtA+6VsosXBw5SPOXi5DS6dyoxI/gW4tVqiwnYWSOOxPBaZREjoyemxDi9kmxn+xQvbM=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B+Yu/fO9JRn3PD05GnEEXysq5UMUODmICN1JxLPKWFFBRTO4C3MnJWQT2s1kZkTVjS86dFfX4NQkFMzJ+ZSNxfWNSGsnzh/BnzVPvo1geW4OtuVEwj4EUovgZAmfJrNXBXIsx1brrIl1jW+wAprSHnFjxfjfWTmf4+vgRwfy01ZKbABR2F5npJM03acJnS2cwWR8l7CRz50eWPgawUEgfMtCeqEj5feYkzy1nGnKgvMCCavJw32IQTwuCiMvNcX93LTHIVxAeW64uvd8qrdq8z9lUVpcus7yC0paaOCgQosP9Ge/lrIV6t2KqEuCDY/SgkaAv2YuwlN+LORIATi+tbLih07ELb05zIisgaS5j2io2oHRWgN/i+Azs72bXQneOU1V7hWZonWJHNmOJ2TZJ8zoZtKtxfoQUngJiUsEOq9Y7H3KhGohyT7rZtBtfEcI
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:38:16.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa95dfb-9496-4dbe-ab6e-08dec79d2a82
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5292

The Axiado AX3000 and AX3005 SoCs include a 10-bit SAR ADC controller.
AX3000 supports 16 input channels, while AX3005 supports 8 input
channels.

Document the compatible strings, register region, clock, reference
voltage supply, and IIO channel cells.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     | 63 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 70 insertions(+)

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
index b2040011a386..932bba890780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4312,6 +4312,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXIADO SARADC DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
+
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>

-- 
2.34.1

