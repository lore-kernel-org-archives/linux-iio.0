Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493882;
	b=hddZ6Nuo2oFpnyBYhiN2YOoFsHTzNCNktyAjOYeVMXWvWpSZRTXBjF+7/zcwLCqLbEj5
	 Gat/wXuL4xHD3NjedH6hqlR2mE2WDzH6386Zl4W0hIcSuPET+LVSkOEiOEQXOpwpTshuK
	 UG+McKver9utBPhrlm9vXocRJdcOn9VJ69Gkk/qNPTzRImbYvltHKqv2E9msW1HpKRq1Z
	 1X/ql6vuMpwzye/QL2MYAI/Yhj85XuaDIChCGDJKTcDjy/NdL474uBIriPh9WjQrltUsq
	 b/l3xWaBYk4CLZhZTshB2bJ0sF2kGbC2dBzgDjhJe0hGpn7FvNn/ZblgrAPPdJ6/24g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493882;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dhJGCHanhxj8qxYIvY1irfLAxHDj8Ldo1ss/0D+a5nI=;
	b=u4hTUOgL4qMHTrXQPtXUdfhxOKn8LNKQjIYR6oJ4tnNNmxEHy9mOFEn9Od+SaMEwAdqI
	 mmgEhg+FD5S4pe1RN3zunV3r0Ro2LK9Wk6CUkp3YDOUYsyob46/kTo0PeiOoctPGqmTyz
	 FBgsbD6OSTnmXcuLhOgUJBaxix7qPJ2kUeoCaGerpTNYWNwxY5aWJMJUG0Z7Z4Yvp26IL
	 NDToygQnWkwNMP8rd+MX/HCPSapsjoFBWtTTMrAqA24umhiBuwDtALGlxLubJ+mIYLvbM
	 ncJwV88gWF1riPOWi/E3dSfv/S1zJYrmRxhz2OIcAdrvDL7CJPh12hpUjpjdJKVyPpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=NIt0dGSw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.67
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50F6070392;
	Thu, 12 Nov 2026 14:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D50F6070392
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=NIt0dGSw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk1sIs4yOsVFEiuKg5+xUhHpQBt2HWGnBO/eF8vWOjnMs3JXnzs5ilV5SQPX5ZJkdt44akz1SlDnafKGs+hi7J2hIf1d/7mgMT6AVxJbzeTqlgeIFKBzfDywAG9pDGUL2iNguZICSy1VQD1J8ywKlSwQLzkCizlg6VnEOy8G7pDB6nBUPK97Z1rKzFCQ7df1i/+o+2AASj3CKPYMrqW3kVgjQxq3nhZGJFJbo3k1iZMQT2yeR3mHPajf+2RAJHz+n99pDSNQL/Oni27saUeselp/cd62REOEp5NgDNEwaPun2GsESqBkJlSEpz9YXEChnsHIoNBKATLNxOXZQPY2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhJGCHanhxj8qxYIvY1irfLAxHDj8Ldo1ss/0D+a5nI=;
 b=ELAu0NURSNc5q48tEJpadrI+1s75T9/vREuSSA2S4iYx8kjp/SWyn0VQEAyXgyyzgeJHegL2kpZaJ5hCrU70lc09ipfJTHC1ZRSjNMENwWg2QEYsRGM4FUm8rLSbl5MwP3ZUfbMDJz6WfXz9FhtieaondqCKnvfQHyMcCDxGHNU2kDtQpWsJ47X7ROs1qTMa3537gdqA+RVo/r5kjM8MbkzaPqRbPjFVZviglpiZE1HVznNocIPyWRUDCK235U1AnjZ3OJTXMLzB5FyD0+nxTFq8sr6HqBpM7J3rOgZMxLISUmrIpJsuUcy+ZLeHJ0sAPc6qQlRDy9jhLIxX9HS9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhJGCHanhxj8qxYIvY1irfLAxHDj8Ldo1ss/0D+a5nI=;
 b=NIt0dGSwUqmb1QCdI5OAj1oEuKWhEPksxjZVEnC4CVItbXUAZpXjkA8nNdnVSd2Ob9Sm8UhK3t02r9gEEGYdTEIX4i/1gRdoJdFe11kWWRY5OAHDKwF90/+J+cpynJEX8fkWa+NbecYK8xPpKIoF5096+3v7yBzfH9bAQXa/wRM=
Received: from DU2PR04CA0257.eurprd04.prod.outlook.com (2603:10a6:10:28e::22)
 by GV2PR02MB303302.eurprd02.prod.outlook.com (2603:10a6:150:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:11 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:28e:cafe::63) by DU2PR04CA0257.outlook.office365.com
 (2603:10a6:10:28e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:31:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:10 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:07 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D569925E7;
	Thu, 12 Nov 2026 15:31:07 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DD2AD3061553; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:27 +0100
Subject: [PATCH v9 1/7] dt-bindings: iio: imu: icm42600: Drop interrupt
 requirement
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-b4-inv_icm42370p-v9-1-875c828a281e@axis.com>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
In-Reply-To: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, "Joshua
 Crofts" <crofts@kernel.org>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=jkSrZWEn7MaHBc3Flm6YTE+LpkAlp6k66/H862A2dA4=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enbVK8mkV78mlpqukzDMO/vmuaLIvG9an7s3y+w3n
 F6TJMwv0FHKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQATeRjAyPAu7Fvw9k1cUkw9
 WSYLeSyztXMTH6hELDbT2/MyRlD3YAXDPxV1090FG6V5F23bcbvvpxDrPkWvhc+9Qus8eD7kXI6
 sZgcA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|GV2PR02MB303302:EE_
X-MS-Office365-Filtering-Correlation-Id: d26c9d5c-3490-4ae7-4a89-08df40c998dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|32650700020|921020|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7Tks6Vqo9ntFEJ/tESHGrYM0NfFrN+q3c8lhn7tnKJ51utDCyXMej6gid6G9CzRbrD7GLFGqfUYV8jrLbz1M94gfVptUZYOFzg9VUzfNcsUOONoVQYtywj15Y2+6WTdBB8Hd32hVEyT3tDamdNLe94UJgjgR+TqwCbNpwkYc2D67WD6E6O/jXyY6P8hxfTJNYju1fLNX3bGF6jSZ5tN+YN6yQSdkjhjODTPanv8d0UIKGN+8zynWb7xATP1/gi+JGReSPsMPxVkrbYd1JGf1SUTX0xbQT5knQG6tJEDkqN5M4zZmDetzillfKt0metZlR6UH6Xk5GRLqKm5ian1UgzSbBCV5v2NEpFapUPe31nhnXx7p98FLIpZfS8GfVosvOQBK29C3yltORfGU+cLBIT086S5uxupKMYNxkEvqmqcuPzLiR1YCjFmhxW20gC8Nyw0I/i5OWkcemiCj7D/64lG/E4IrpbaNPLAkK6addZcsRruV5OcQC2oQDiM5FO4vhdi+Z6ct5plSFvVXcTALzjAvZgTjOVLoFyGeD02vojB2qFvPEO+KIRpPZTNCGc01uFYksdHBX/HQ1bDpZisPzyBQtVRlbgISAmNwKLnWYbUWBzwxCUtVHG+oCox4lY/VcyCwH9dZP3nGm+VEuP2M2kGEQjevEGtO40fQGQk86oT+T2btfmLZt0tsgg7v8VvH+rU7Nw1b9eFvdQQz/C1fBg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(32650700020)(921020)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x2WJHvD4A3Usj9HHuDXP0BDyelGPGn9c3znmxRWlIllqLF32TLiBckWISwpd3nbIxU/ZkP9rnUSPPME5mVaq7McZrnVoa9165ElqOR5jJYoizp9w2pFHTdbG8C20gjccgexASeutd9eAhEDqVxrYNuCbp5gyC24TdxSIYrnoIPT54VEV3XNoP8xN2R0ndrwrtyVfyDMFo4JviyTLH6d4OqqVU3wuEOy+sQ78au4481ONbJiwrW5e8YLwCmG6J+P2S4RMp2FEqof5f8GE5J32mLWx8xOi9CVlVZUiE/L1xDbvSKf+lCbOjdgvxkq/nO/er9DTGH68HTNZXOIB8Yb6x0+ypaOz7U1kU/jnJsW5MkKwlSfGoMSrFER/kVL0y7m0IH5Q6V8ERu+CsgFxyfWUWiYXaw9nUd44S9V+c+2TpMAUouT+J3MLcJjP4CWcj2ry
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:10.6220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c9d5c-3490-4ae7-4a89-08df40c998dc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB303302

The devicetree documentation for the invensense,icm426xx devices was
documented wrongly. As per the discussion in the thread[1], the IMUs can
work in polling mode, making the interrupts as not required.

Fix the dt-binding to not have interrupt property as mandatory. The
driver will need to be fixed to not fail if interrupts are missing from
the device tree. This will be done in a separate patch.

Link: https://lore.kernel.org/linux-iio/20261018034134.2bf170a0@jic23-hlaptop/ [1]
Fixes: 22addefdabdf ("dt-bindings: iio: imu: icm42600: Add icm42607")
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml  | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9e22b603d47fb..8d16421c6f82e 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -76,21 +76,6 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - invensense,icm42600
-              - invensense,icm42602
-              - invensense,icm42605
-              - invensense,icm42622
-              - invensense,icm42631
-              - invensense,icm42686
-              - invensense,icm42688
-    then:
-      required:
-        - interrupts
 
 unevaluatedProperties: false
 

-- 
2.43.0

