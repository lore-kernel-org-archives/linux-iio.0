Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023133.outbound.protection.outlook.com [52.101.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BC36402C;
	Wed, 25 Mar 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422398; cv=fail; b=op8dqpHc789sN1ui48djWT7fii+Tb3G7XgZ5OyLsG5WIzxfMkAWwtcZVqTtLpmQj3UxvaTqEhyuvlCE+TPGVu+ojNlqFxKUUw3fxvts9Ja3lwCMjUKNKosTO0Oe/cE7U1JvCImlLZJKRCEGHjKoGTFAbUc12o22jN0VxHFaKp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422398; c=relaxed/simple;
	bh=bUxk5nPdQUHWC6I0mbA6HEGwUYdMkZJBslpWlUb2x70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSVNixlJXoepeYM9F88fLIA7vKKG5M0mlXV0yhrS6pEhTyNQw3516DHmG00K2hoDb42Dd2PqxNsvXvTEi7YS6ea0zhYOMfUUeFXMy86pT64Dmto6sUt02I9dbGK6XHacVm1qmxTZhRWG+TulQOQ53SONdbC8H6j/C18Ds01XMys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLKzlq2RFT4NdlebIziP1sDjqforlOuBIunIZJcduaFEIUvPSX5YVqPB5L1VXvGtzdK5s0XZyHVtOO0OHorWc/ur8cPbY8ZDwEIfmjghWOXH/17yJQ4cK2MeELXW/1E99nE4LH1fl9ozj+x9BaBKjR0WemI4zQ0i8P1on/QGq5qmnI+q8xLw8N0Dlb7TNhOAzMp1WuuwihZYLytW3ZB8VSTZry51jbPh9eLNkMzKCy6owbnXDeF+OEBRlCbAhsL9CmYYHmCkZnifdJsrSwYBAI7/FbjT77C/vbnJHM00YXZxG+xA63O4VTW8ZWUYDIvxZkNxpmNLvVURadgNpc5faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcFvxRsy2jL/Vzt9dKJgGSrkf77OXnYcie3/yNNmJMQ=;
 b=HwyhbbZumlqeJdGnQqsLMgNz1JEUKJlL8tX8fo5GDksiBaFTb0aFomiFadbFx0sMnK5NZ3VyQ9OkGzsAB3aEFd8Nl43cyA47rVrTXgP0eBkZXgruNbft8LrSQ2lDoRwrKEWjBEPC4i4nM/Y11tWPsbeiTqe8JkX5eq6rqdkrWoCRa1FoS5RHMpNEY2R8lGpHqKAaJLYBHkkbQ6T2w+mreUVR8wTU0wj0JRxoQ7frCQNrgzkce7dmSvAWL9BK/n2DuUCu9y0nPG+L6sG0CfdIZCmj5SdZ1HQN18HPihHpwkdO5zGUvOygFR+RzJsZkCE+nfc8VZiltTcxDAueFZY3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:06:34 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:06:34 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
Date: Wed, 25 Mar 2026 15:06:15 +0800
Message-Id: <20260325070618.81955-2-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325070618.81955-1-nick@khadas.com>
References: <20260325070618.81955-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|JH0PR03MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db9a336-1f9b-45aa-d08e-08de8a3d0c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eCw/PFwAL8QmV+AnxmFNM3PkOLg9Cb3JXyrIPiElaCPS3fb1EZgPoV9HsZbNonk22QkdOXuPXjFw9cuK/Xen9VgQ4dxudx3cul87BjS0NGM/gBI4/T9ide88Ll/DUZALl+onoboX+FT3TMjTpN4a1bvOJIHv7LtYSDS25nO4ghLH2I0VG9slPo2NO59zUQUGhQda/AZmcLzCatq6WdJXRVs5ZfDaAgv1lphRXfqjCDieiz8d9GDUD7a2vuKYqczOHJwwBgmKh84mgUpj/3vQIM3UTEl5ZRJo3nzo2GhK0SV8G4p9stcXh386QW9qA1cCYdMRir4gC3j6CcxokmJcKH1D3Yo0eTj2wA1qx7Sbt2mzE5MHnIOEN9E40MPSdi0UJQdC/HGE8N0EEcBo/J2X4+SHjBVW76ZEwKTq8TX1nk/wHTJSKwMjsX9h4o7j3Ipe2p0b5aKOCGQsV6iilBKD45f6tki1u07R0fTKhXBE+goG4A34Uv24gzd/R29cVr4mfMQFUEVKLTxp+OcfhaU/uFrdyUS1nf6S/NOqc1IjHUVKITiCnIZDydagkq9dKlAqfBdzwe5RpOEHOGf930iDPaozQJvpP1Q4meRyh8cHkVH1NjmVZkaX/HX8cKemEQ8wOxfQpokMG2yb/9FVSWgHwDjSiTMtkQuwhMMSVzo+hV2zLkGC66CFFLoUyzSeHiq6r3qSR0621eJzbidqfRoPzFH5zBotUm7kEnnSjgKrBv7xbphMyHW6VJXSDUBacd2xhbM88cy0QMOMMvteQaBtwwIbkPWZMmik1gq2HWgEnxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PkF9fR0lmperWgilwIVy28AA+32iHw0r37gXeQzdeLpf5UHgixg0cEajZdgZ?=
 =?us-ascii?Q?/mmMcA7Cc5JQloqm5ioW7F+OG/P2oL2BBVTSoAlgPncr3W+c8WhRHEjA+9Cr?=
 =?us-ascii?Q?NQgNV8hNBmSCQ1FkVhqB6TfbLJiPCVBUiAaAn05SsSgQY05nkSGf/flNydsY?=
 =?us-ascii?Q?I8kcJ2SU/j/HFvrxZbGxhA6MKVn1Gs9VTJU71JAjiGGhR+fNi7OiCoSK4iRJ?=
 =?us-ascii?Q?nE0IYzx4Bq/rSefbPfOoJ39zGEarY+yP6oySX/1XUQilEdnz9A4KPMc6PjHa?=
 =?us-ascii?Q?JRxF1U9QfmAIJvBTZNGwJinbKeUcw9wjzAx64LbmzL0OoGE4rpgtHGH7DFvf?=
 =?us-ascii?Q?Ln0QcXt3gu6aQWhlWt80k6dU2rCbISuAYRtBLj/DDfL5axebHzM2isqTIPA4?=
 =?us-ascii?Q?cBJ2LY4wYSHOHjm0FhZahDOmB5jtnOaKglcEQAP4IjI4g6Z191f6SdP7bx4b?=
 =?us-ascii?Q?7nvLv6cQ9D3s2b7OiVdsbfRxYYzYORGyi2cQDt8dHigpiSpAp6grR7w9Yv3f?=
 =?us-ascii?Q?dODTbLYepLxhO7OCZtmmyh6tT0uRBTYAOrQmxd52kcSQMd0rqgVeoYS5Y0Ez?=
 =?us-ascii?Q?7n2HZK5y+zc/HV1AVn+iHm1qrfV1oEEUE/NzGFIOOxVdz3kjuaxJYWBRbK2c?=
 =?us-ascii?Q?7XRffB8k2ddvoImnVS7zyeyREKyuX1oTwvoKMbD3nfSEQ2jBm/BIYq4hXY3X?=
 =?us-ascii?Q?DqHoKKloBnuHl9tKSrq8e0HTl7LTjFfqJnlCQv0o8N3iAMR2tjoc3RLaQ+mC?=
 =?us-ascii?Q?fL1FkX2sIUiBhfGo1nuw7elT3Rn+wpPijWXhHTpz00FxQBrMyo8WUvUxWf9u?=
 =?us-ascii?Q?WUYvQ0Q8CLFmXzdlq1OqX9c+PuiXpwvnkntiQjl55eT+NsnFvBwFQT5ORlp1?=
 =?us-ascii?Q?V6bW22wA32syOz9eyNwM30pnC7EErgfkLNJYxPtzR5Kqj0cbt2OQOWQfvc4/?=
 =?us-ascii?Q?cSOdVZ+066FlpszzOd+5tQ6ocovO1wqCgc4t+zUyEFcz9LtfTHlh94X++UES?=
 =?us-ascii?Q?/u1ZtLLB2I0EBIFUboHCXP5nFwVsi2GKx7X9I4wLQdepg9zFEYZVTHpvewlR?=
 =?us-ascii?Q?1UwQSGswcHpaMzfdlIhO6gjjTDqyowcYOS5ZZRt+qCCdfPZIOKKp34zUeMRm?=
 =?us-ascii?Q?hl2yos0QYxRhWZ0nu0YX3x9bl7LIGnxNPhRptQUjoEkmYxyHEAWSlDWTk696?=
 =?us-ascii?Q?vDCpHVrvbQLT46kPfX2GKOjNID0TvXJnWqmQE1wfL4cMIio1pzmkpaPGa8Lq?=
 =?us-ascii?Q?6xLuwppj2B/B4Yv2EMhF/PblCoO2wjsNHl/lO9RhrPUQQZhBEeWjNb6oI7UK?=
 =?us-ascii?Q?hgG/DP4Vsdgaa0aXR9SoKt8mI3MGVlTbxHBdHWO8tlkl8DKwsjXNNRupTtee?=
 =?us-ascii?Q?zXIpzUvSoktLj4P7N5jhPyYejJsDfqstf1AAE2S9IobKUf6WYWBABppP0UrH?=
 =?us-ascii?Q?6MCIuEj2z3XKjWgc7JNKWO2MdQlsYksJtzOqlaDwP2wdfJFFvxHcyBSGE9ef?=
 =?us-ascii?Q?tHEA5YAQzzuXT30Re/STSx46frI0HHI9QVeJxZDRBVljgO3uRxz7iWG/SLJ1?=
 =?us-ascii?Q?uq758dU8A6C1t557IU0kYgKqx4pudXSMWwts6DbVWjZ1sSVWdwcYW94Ixczl?=
 =?us-ascii?Q?0aDQAW7gQolgVBWI8hoJEcF7gSjHUMu00JEtqZ1vkUsceSMvKq1YY0n7X1Fw?=
 =?us-ascii?Q?7r65T325cGcGcSGZcgq7ffiQ2WdNoMTNQMk4yQdFTqJR5lRI?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db9a336-1f9b-45aa-d08e-08de8a3d0c8a
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:06:34.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adNp/zFqPnTWs2+J/NBkh/m03FhYWDdQLEZZfiELUL0ieNYIW+n7CswkkfbIUvFb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

Add the compatible string for the SARADC (Successive Approximation
Register ADC) IP block found in the Amlogic Meson S4 SoC.

There are no known differences between the SARADC on S4 and the one
on G12A. Therefore, it uses "amlogic,meson-g12a-saradc" as a proper
specific fallback.

Also add a comment indicating that "amlogic,meson-saradc" must not be
used for new devices. It's a made up compatible string that does not
correspond to a specific hardware generation and is not used to match
any driver. For old devices we keep it as it's part of the ABI.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index bb9825e7346dd..70ab4e140e71b 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -27,7 +27,11 @@ properties:
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
+          # Usage of this generic fallback is not allowed for new devices
           - const: amlogic,meson-saradc
+      - items:
+          - const: amlogic,meson-s4-saradc
+          - const: amlogic,meson-g12a-saradc
 
   reg:
     maxItems: 1
-- 
2.34.1

