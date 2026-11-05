Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893752;
	b=Od5xBJwi8/Dm0bdUiJeDPJ60WKoFs5lnf02Cdkq9sTc4GcPIr1EM+X4NOW6hUZGL9cq4
	 +pePSA+avS+3vBSb0aBe+Tsntp3fjdgfNBmd9x2LTKyg05hbQNStvMAtCSV0XFQLXwQIe
	 dfvEkU42l/l25fT41AOhQOzYmRfM2+ltk898YD1VeEd+Ev7GZXquJfmRwbjCuBmdxL43m
	 tbuGmoD46YEy38zEiT1cPx3aaqvrdxYhtD29tavOBzwDmy8mAEDr8zppPppJ724QJZp/y
	 LMlbYyvKkZztV2zotgaKgVjZh283lvIm5bAeqoa/Zw+EM4PANrt01gXXBla3vmZmqNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893752;
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
	bh=cir2iGw1unTRB3cP/gB2cjCrkLV2S7xV1hDo/GuTvvg=;
	b=2KAHaIxC1ez77V8INoXhVpqq9ZXhPXfaMT0bPvFno79vAbcYAkw3IYlzBr7pmmKRk79f
	 D4gAOwo2jEjt/LRXlsqTMMLrjO61TJ73mIPoiymAJ/I8LJNDtK4bIDeYXloQB4ThR9rvo
	 lhny5H0GR3b2bUVMfsXFeJip0Me/YdelvWCC47xhBlR1WPKKjbB0y/DNXtymK4EYZO4N4
	 CuwqzkfC6UQGqgujQhmVohxh62FDty5ls0SaTltb5Zm4I21H8yoc/zVF+ZBab1OQE21Nc
	 1XOJsKm6sygvZQLZSemnsNfdi5UrkurT+HpXr4pfuq1QNkrBwbRCf1TvT7Tth/JiSxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Z0yS9nSF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.15
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F0606A330;
	Thu,  5 Nov 2026 15:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08F0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Z0yS9nSF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saCH7EkPXPUf0EV92qGG9L1gTVHxsuMVrI+QvPWBWo+ZiqdL45/VXj6zIxvwOrYNV1E2qzralUtniY8+uNSP9qYjHlP5ChkF4ewbQ1BEJgwou918zknfDxm5yxjhTIvzUk4iHCrdOz+qkUe1fdQ5PyaJXn3AlORZKLFIFnJ8CzeeKm7dqkokGj5FQIOc1W8LbQKZZy9OB4I1UXqQVf8H+A6hOrA7EnkNHhVZXOSrtf6ss+vxCugF4szvOupjbqPygBqxrihzpnZz1Jcf4tz+7LboYqFu74jRQZd4qFbAeNgqkVJB4SFCo0cUSQRI6zF0rJ9F2Dzdb+wvNjgOWxoxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cir2iGw1unTRB3cP/gB2cjCrkLV2S7xV1hDo/GuTvvg=;
 b=tQdKDuu6LTIYe7jTPJeb+NLy/D5YSYOHYL8Ts6B2jKaR8VTJI77oUPRE6ySSxSTjv7pZapyP620ocNUmQuqdmH25YuMKLUcga4MIkHAV2zv08LfVQEZRnNYuturNHY08wAss/MXe1tNeXLiarT+MH5oTym+oLvumVccQM+sPWLUwi/US7M+2QyKmwO2lKybyHNLaBC1tY81fL3BNeJm9XhMzMA/HFpOvuY2TtnAV1aXxInVbD5JKrxF5op7GJeE55EbXN5NtfnpFUOuX/GfmvXFe5aOn0hivA65pT5mfe61p4zuOUvt3/1Vt3/UAT/dAbqedbPGwsVeX40isFDV6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cir2iGw1unTRB3cP/gB2cjCrkLV2S7xV1hDo/GuTvvg=;
 b=Z0yS9nSFqL4xCE/Slm3+2vBkLq98tjmweMDB5G1pTb8dXSvak/GdvTshQkZd4GBcXmBuiwjik7TCyMAT+uDPioG4adYx0lBEFVhAa0i7zQSNCjXV+EjLm4gNrvMinCFLzhvkGkfSfGjaRJ8lsIeEJ/aXbbth2j9muaZTR9gJFQU=
Received: from DUZPR01CA0206.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::21) by PA6PR02MB10740.eurprd02.prod.outlook.com
 (2603:10a6:102:3c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:49:06 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::6d) by DUZPR01CA0206.outlook.office365.com
 (2603:10a6:10:4b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:05 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 81EA718DF;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 752D5305D5AB; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:49 +0100
Subject: [PATCH v8 1/7] dt-bindings: iio: imu: icm42600: Drop interrupt
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
Message-ID: <20261105-b4-inv_icm42370p-v8-1-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=NpyTF589htG7SvRt7jrt9ePKXuaFTCJ8VcyVkjFXNeI=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szTvdVXk1GuzDjBITRCb++vQvlNu8tUfvq52nloSz
 7d8V1Xg845SFgYxLgZZMUWWc0bbo/cn/9OdI+10CWYOKxPIEAYuTgGYyJvPDH8l9Z6bneVlSQ/5
 t7x8ytYvJ31EZt3QuMjl+bZedEJu0v3rDH84v7c6J8X/Lfws6n6o6ktqVUz/+ZtCfsX/fz3hMLi
 nIMkMAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|PA6PR02MB10740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c983987-3028-4fc3-bc42-08df3b5452a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|32650700020|36860700016|921020|261026140227099003|11063799006|56012099006|261102123227099003|261009223027099003|261021123027099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|18002099003|22082099003|10067099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	bUscP6657sLJU4Gm5pUb9wps3LoQNcwKwM9108iNAZG/Y1fiQ51yM8WsjzuLAml5NzgWEEC6sTVQGpGaazMwYBasAkV+zfR3OyvYgAFbNvuxClmmnxvzAEl6clpNyQ6erm0OdfFhttuAClQLdapVbbKdGhsm9OYO+KmXJh2Bzx4RwBKwcAWUNc3MiI64wAjfh1c57j4bL9IxdvkuBOg68Au4bXBgVw9VJ+CHe4nsjUj/PfcRaKH/5dCARAWD678MmyUXCyKFBzp62ovDlvXMVmsK/L/9mYns0IBQOB59m2t3pHKckQTWePt0hb/dG1L75NZ+mw/OOYHXzwYKozsT3ihc1WP/TvsM3uBmJjd69ON0c8SbUVoRjsE4OtWVo1jHN8fW0Rs062SJaj9HRs2IcCP8dYLVSFzH2ZcPI3KfraW4kL8LvgBFBGMF+zg4L6pDpr56AZtufihoy6ksAZF/gbKT8Kon4UNKNJac6xco4u5cwOFbtmpabHA2rH2v7PTz30PKhKK3VuOd3+ea/yosvhrSReYXwKiwfOc+OVzz8ExRBGT4i5T638JY9nPQv9uzbQlFp0p8etg2U6cBTHIWEvuGYDH9FN7LB5ULLUv0qnZ5ZjrHMerzktGGMY2cPl8kaERm5Zew7Mmu3jXGHN6vbqJDoz6d7SUdH0aNej+Nl0QP41odmbenW0mIbxVM8ePaNcODQ+gSGFW7XK4EuybzaQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(32650700020)(36860700016)(921020)(261026140227099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261021123027099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(18002099003)(22082099003)(10067099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M0EddlJdvUUNV7eFnwmBpqcCfTdbkZXljOwafcnzJfM/1sOovgyGlBhY3yomduQw9t992Bb/usHkfQdtDy9+Sq9oKMxmo0ajD5/d6h6MJtTf5q9EVNsIXhVXLPir/2dgLDhMyMVWXa7p1LYfq85Z5OqidRGWVuW3MKUipXVp5fi/IX73mELTmGQXuxIs/uhbh36fIP9eo8kxOPjYmr2oVaqgmF/Dn4i+XUCXoW1e3cEzk3qV9atvjHfG2bLthOPJONroMJlSD2vQb4nfgzD98kyV2duoBJs6hBLNZoToRfF6ukN2j4DzPHH2dL+sjlhOJk7y1tKZKoPtasqQz9dVp24qyTTXFMBJjpvHQQEJbkLfKGNdxtDzMpuO7Jehag2AgvWWGGLiiW/0SwxK4vA/AGQxZwKsVSxCGFOGPMC5wap9OOO794BdrFD6wZU/qTxa
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:05.8943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c983987-3028-4fc3-bc42-08df3b5452a0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10740

The devicetree documentation for the invensense,icm426xx devices was
documented wrongly. As per the discussion in the thread[1], the IMUs can
work in polling mode, making the interrupts as not required.

Fix the dt-binding to not have interrupt property as mandatory. The
driver will need to be fixed to not fail if interrupts are missing from
the device tree. This will be done in a separate patch.

Link: https://lore.kernel.org/linux-iio/20261018034134.2bf170a0@jic23-hlaptop/ [1]
Fixes: 22addefdabdf ("dt-bindings: iio: imu: icm42600: Add icm42607")
Change-Id: I91ec65f6c00cbd6a48273ccd8cc476ee5266b995
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

