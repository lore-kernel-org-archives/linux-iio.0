Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020122.outbound.protection.outlook.com [52.101.56.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1413164B5;
	Thu, 28 May 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955843; cv=fail; b=ViEcdyH0hx4I5pqfT5oi/NX9PpdQCSHG3fbM1hiG6J2DPtI7kdn7fvjY2gweb3l6IEL0+6D4B8SnR0Noo4+eAKxncExrbsqa5dPuT3Ixa1VexM+D+j3yayP7trCX7epynrfehY5BV455XloDPk+bMayUwSLKXMktTiw4aahgSZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955843; c=relaxed/simple;
	bh=8sPBQnpbJniz/OxJFq/qGmznSCxzC2gecWBYK8QeSRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3VdyYEv1qTReGG+WdmdFmemvfrVAuyPYEkOH5S73jhief9RwADP8ZMkVkUUuKDhEXkavrhRNFbo7XqKmqLZX0l+1grCsIXGc/6z8tvAsfg9qXsgVBQK2WZA43seWEYsn2Mev4UuRFyuXk4hqXpS8jXGpUfu32AeKUuy3/fISzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=WzIl0XgN; arc=fail smtp.client-ip=52.101.56.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="WzIl0XgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nscNSXAlivUxsaOic+iU4J5DgjBDuHOmRSSc/FMMjVLPpFP/af/3xvahOx8sEuVhNxvq3L527Pdw04BEHaS8zolCt5+GIAfUG1HLlCJVhqfNojy3+2uuCcIjS3Iit4GfTGn7siw2NKc1xbYoaCD8iPAFBejB8DKVnO8QxczcOaE8EjPGiOTk1gsLpk9Wo6DJce7xj2aPcoH91chvUmTsgir1alx6ydgVaqcT+lM9Sz/5woyY/poP/BxanOoWdEFufanH2gDFrSNMP5nNd1y6zsTWZPpm54VZfKG+XfPbXH173anE+f+tkIG2qVhR81mO4mMWpGMaAqoPJYRPCvpPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VxlYAdiVH7SvabkzpUxf02YaH413N+/O0KiQsPtRbY=;
 b=SH5d+DVPVyk25vm48OrvaVjIz5HRp7B+n3jDZifNx0U+rJOrG6lA7Hb+Ue/lgoQDokxaRWNYFB0yOdeehPMsh+U8pPv7VPHErruPwFfF0qDfAVVRqfiVKz5gRsWUP7QQanW/4lmyy80suio+AcOya6cPw90X5GHx4U0T5HqgH/RSKlyzrwY72ihWM30NbTIQFVTxizc9bbhQHdRPuNOaj/MGZXI07m+lq1vnxm5PvY0UQb0pHWfTfa3Fz2U5TYWH4XgIhAYpo3DrCfL/dYYWPOFHUzkFsW/+UVTDfUBef4o0klUluUmMYHU2YjCYZ6g+D+M67gJZg0qUR8YMe8n3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VxlYAdiVH7SvabkzpUxf02YaH413N+/O0KiQsPtRbY=;
 b=WzIl0XgNpO9IJQ7ECY7Z82qlYAwGQZ+Hibd3blgSaazr3PpstHF898Oy6R79Ixu4N7cCA9szSV2Lv9Cc0P9mkTNk6ttqbspahoY3J1jGf/3w/Z9tpwmayImU88e8exleZtH1NqFcWu7zpsZ6NacJDVx9XTWwW2vi0P9uhD6nfhpFksxg8OBTEDhSzK5pYwv70PP1jNNx+Zn4UZ0cZtUrFo+3WHtAyMTLKF3GnPUEAx3J7eWx+2tYYOWAUBSrTrg+GJLMelBFN4Tzie9rK+Ivdcd7cHi5jt8VpFJPNqmRWkolLKgSUX1rL1GVY+JV+E+a4AYAUZnNPXzOtNTs6wgtyA==
Received: from SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6)
 by SA1PR18MB5926.namprd18.prod.outlook.com (2603:10b6:806:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:10:37 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::50) by SJ0PR03CA0241.outlook.office365.com
 (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:10:36 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 74AA34186B5A;
	Thu, 28 May 2026 01:08:17 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 28 May 2026 01:10:23 -0700
Subject: [PATCH 1/3] dt-bindings: iio: adc: add Axiado AX3000/AX3005 SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-axiado-ax3000-ax3005-saradc-v1-1-345dd5f6608a@axiado.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779955836; l=2112;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=8sPBQnpbJniz/OxJFq/qGmznSCxzC2gecWBYK8QeSRw=;
 b=sCzN20NxcvjevgKaf30raDTO1O+rIPDLyqFB1NFl0ZD5ffQYivbXwQchcQfYSFrlOnZS1NXpi
 lReYCfK94zBDMRo/1LMjK+mZxgGtGtHeMd9/bLCGuVhrtql+6JxhE6y
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR18MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2b9722-223e-4aed-67e4-08debc909980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|921020|13003099007|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DYVe6BOP8pK9vjU2mGGULGndh9XBezcCBID9w0y8b3ZQrsKkShfqzrs7EtUAvV5kcgrHCh8mveEsxlTE8GytNjNEHcwxpJn0V/Qg1dFqJkklDDjRAhwVpk0MeBYAVloFJFZE0/l4ngzGUSi3fzjWK7OFHfOS6MbZDF6D5XNZMa0n/0z1YULFPF1Ws91exuxggF93biNpMGveq5Y2PR5LL4YQVK3YAG3DwJq23DRxuv4hFKyfxsLdTxA3de8Gyqonqg11w7ktt1AbONTdFk/vx2TKGa296JYfqFAcU0woEqtwpUocww5VRwd9yFWNpfLvKAT0+K0PvD4u0YjypLi6Yyap57p+XkGt3zfjdHDzskOXVoQPu05+1xv2K77G5pefb2jiXRC98lJboHaX5HLSPsjJTrGpFmXAXYdSLH9oCbKwam1Yy5Lu/0YIw+6eC/WRSG/NVhjTPBgaCY5ZaS48u39mkzga/ugIMiDBt29WR0Axtwsg8D/2cGwxs3AC9PMu+vHtJZrqM0y6FD4hNcKHqXLhGA/A+Aa7XrP0Md3E04eRzhO1vUw+nMt0fmdmw1l/c0hQJ+0O5Bc7D+PJFwokT+uMy1vX7Qzzyy/RpP8gKGdH1qZk0bYrjyDTOkqB+Ta5W2ULPuoTC4X3aO43Buv6AcyT68G8kKHSLIJFMCm3ClZuW7GwivE779l5bOyOqHLcl04Mz6wjNQV06MAI68C3Ow/h8/Mnbjt2Fly8JQmlJXk=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(921020)(13003099007)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oBSqA9SpJ+res+e/ZPT8LFl7DIa9Ajmrf8Mk7q6v/m9VJRydoQ2RoTIDPXlOMHdCdRcpx2hdBXkeTPmR3wGLwQNWl7TaA3r9MWNHCYoUjnhC4zSbgRJ+Bw+SV6lbXOiO/TVJgbCVzkpw/BnOKr6F8GhYTxOomKIBT1YGpecN67BZcfRNeT8aNqyHz+KNknM6ETvryHRaTY6DYflX+X61MqZf2F6jUdKt+2XQ3le5TEUOhKSVj06jaWXVLPPiQaKjuyD8C861/E5di5tIbjTLoHSMiymd5yfeKn6alGOkGv1bVjcQqoZdCd50R2lJCyDixzyUuh/ulRV59Rv9sNb1+3hzK6rNiC+F9GzO4n9/LJlL7EFzXO+iLGgwwBrn1SOklFsIjuckG+HdKb8q8HNJp7U6ys88iZOQkR2VxniUFuYWNZJHrJdOsi6I5TslAGle
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:10:36.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b9722-223e-4aed-67e4-08debc909980
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5926

The Axiado AX3000 and AX3005 SoCs include a 10-bit SAR ADC controller.
AX3000 supports 16 input channels, while AX3005 supports 8 input
channels.

Document the compatible strings, register region, clock, reference
voltage supply, and IIO channel cells.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
new file mode 100644
index 000000000000..54592353a7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
@@ -0,0 +1,58 @@
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
+      saradc@806a0000 {
+        compatible = "axiado,ax3000-saradc";
+        reg = <0x0 0x806a0000 0x0 0x400>;
+        clocks = <&pclk>;
+        vref-supply = <&vref_reg>;
+        #io-channel-cells = <1>;
+      };
+    };

-- 
2.34.1

