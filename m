Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012612;
	b=a2iPnITOPbAzNrjnuPLy9fQrpjgMxK2YiCIFQ/nRGpPPEQ9LMxiGTh+OYaVqHpbhqAHe
	 NBLtqOIzrEt39IQ6cQTjcJn99nZb6w31l+6UFxW7R23c2hxbLOwurWXID56RSiZl3wQX8
	 vIPieMAQvaAe1uMlW3cp/dikWuwjRfZn+63oLp3IF/xbAoJ/Ro/5MY0IVLqeTIcmcJyCN
	 Jl95ZA24bN3PrI7eFyEmwP1AHh2O4dLZ9oTWvkn8poAU1XCRzFvoVFFZWhW6uHjJayHbd
	 vfz+MHa9VMXI1IEHFdKgh72nSCMXHwM1ip4hSGO2AXOvefxuCfOX6hscRVRd5ZvAsXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	bh=pjfW0zPfsamn+3Sc+7QTCg0ZTcADNZXInqLtGAhc6uA=;
	b=A7y3eF9SrKdKyM1txd4Z28D59N/G2ChEOncZElKea9inkysYfZW1I7EAY2piSHFn2g3Q
	 BDefeQoZx/2t+ZM+kVEwJ3YV7K9RA0hkyF32SfNpxtt0+HUWfeuTBj1CTk5gE1PjnN3OO
	 aD8jqROMbzyDWXlsknxSYa+jYATgbzgW9BPlFETxi/pB8xcVLTcBEwi7WprkDJpxB5Ckq
	 twDkxqlHLlXZoE1Kug/qQdHecdA2vzsHjJzVKDAXk7Wh3GAS+IA9Qd5Dsx1gfeUG7TTtw
	 MGHi0UH8dLaR+35G2lo3OPhBl/0e2Y6yQwZBMLlnR5JkG3KvXRttQ8NMrK41Zkzyrxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="r/IITXr1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.54
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF9606A334;
	Mon, 26 Oct 2026 11:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DF9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=r/IITXr1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keofnYPP1upGZRJJcr7ijqGuDEOTL5Am0AzVOgZ5wTk2ytWmaEDoRgFr1GiBc1heHXsObfNgfXAvonkq+A8jMudOPDexfkWWq4Vs9ZYcDMBvh0H5R65ZKn5y+HfW/bgfiHyjSOr3rAJoCbT87PFEqZKxhVbpTHkct9CU9rV8xQnAFRirxTLqL9MM5U/riggxMS5K6IbMz+EbB85azJlqVjW7WgiPCBEqjRwl5tHNxogbIMYEzYNQPdogauY6m/1UdKjnT3/aBEtzfxdYFqNOl1U8hGufS/UQMbaxJ8SHtNF0PSnUfZkR8UqZo4UI+B4ao+4ImGFlQIFMWnX43o2Efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjfW0zPfsamn+3Sc+7QTCg0ZTcADNZXInqLtGAhc6uA=;
 b=zSA6WOIbxOVkdqBDDHyheWFij9P2FVDlHgVvQJDUuQ2Yx9HwUI8Ve0/4A2wq8cNoGeF3t89qil82q8Wq9jR07T8PJX2EuxYZDbPtbAwEPRrr6Vwd+ui/8DAMOJsRQZUP7HkOTrKIbJ9o62A5G1XVkhCjELnqAmbnrpc1ueafVsUaTgYubM0RYf8w4ooYed7ueqflrbNCxQz1YSu/XAUGceqTGakS3oBkM9VIkilV1D9E+J1RMCcyJuO6oXL7gnvUZ9VJ1ITwJ6GmTDCLc/Vy5GjjDCJGuXLWmbPuBNmYyr31HNKK8T0KLbWH2oYPwkitTQFvgsNLdeyTdrqewRvosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjfW0zPfsamn+3Sc+7QTCg0ZTcADNZXInqLtGAhc6uA=;
 b=r/IITXr1ubrTyN5n7jLhA0XUy/Ga79s0eTen2V+HR6EfXlYe9+r6M4eTbNlA7fIv/xRLjZ0WMAYNImD76Um9cZ2pJkOJfjAAiE4hBvBCuog6Iqz+iYeTTLv9KRmOBCe/AciU28KY3Q2MqRt3fP4L3WdbesCPYwqDKtGbK4epoBk=
Received: from GV3PEPF0001DDA5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6cc) by MIYPR02MB12377.eurprd02.prod.outlook.com
 (2603:10a6:290:7c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:27 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DDA5.outlook.office365.com (2603:10a6:158:401::6cc) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.11 via Frontend Transport; Mon, 26 Oct 2026 11:03:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:26 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2357140E0;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 3FEE2304BA12; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:49 +0100
Subject: [PATCH v7 1/7] dt-bindings: iio: imu: icm42600: Drop interrupt
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
Message-ID: <20261026-b4-inv_icm42370p-v7-1-222e296ac1e0@axis.com>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
In-Reply-To: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=ldVle/V6V3PdVTlMkHWPuJJIq744MhSvIFeXo/xfx0g=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1yy1HrFL4/7hzxO2txgqZum+rp0875b59w5fxq0e
 G2TCZwi3lHKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQATeXeO4Z/Cj+Yex8QjEw4I
 xwrweH7s8oyS2bUjKk9LbXf9Sq9ZOe8ZGeYFfXeWF44TvrtNjFH/QtENp5rDGfouf697pBQ++vM
 nlgkA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|MIYPR02MB12377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b34a635-0315-4b68-4bde-08df3350c2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|1800799024|36860700016|32650700020|921020|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Y5D7kiLrBbG/u+T/iNO6Ob0ol4bMCtjqG8P6wf0x6OBiE4jThRCbHrXZVBlvrq4o0dZDKv/+xy+wdZvZ9+VPKvIlFbPfwm/BIUPZ/FnLe7kth7Khpj7zx3VEwD2WbhjWhDCx0YuVHcLPHp5FC5nNdWT9zALnurNfATLxNd4KZPqnkIYh7PGb64eKmmiWAmgcdYGjPzNNl5nJdG7SuA4/YYwoMVALRXR+YVZAhiPZ2jR0arlERfckvLn9SiR98dGqNUQSNxMiAY7BxXudoeoLaIO2eCpY36kmzJkjIX0wcmOZCcBFQsHxBK6njuqV+hZeQjB5haCf/HEtTAByKm1NOE3QWKZv0e4QvUmD0it6SKnN90nDzci7d5h+pkdl+NcbSAv4iEKsXNhHS3zurudu6ngtuYz2REpANi+JSVR2Np2/LPaqxuwVKMoL3Gab+2Tm5LCJG6o7MgMRttdluhvrbaWSeP8fKDuc8EPXShOKFj2CmTWDdfAT31CsE2FaXyLkj5G3KxbTAfFts2jzYNklqRrW2/CQXLBNmYil6lMC0t/ob9g/9tXEdzhQ8Jk/wa+DZT18ag4PIobJWUDUdn+qNbHIpaLFP7JWs+GTNSRU5sZ+Ulo8EKLW7WH+E6ON9uT6SlsmA5E5GMJKunHoP0DDLoReEBd6/L20lq0wVFNyID1T1MMmcgVE0ljtSh4hKY6+zhxo7AcDWJFNTYyFytjgrg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(1800799024)(36860700016)(32650700020)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h7KXw9c71fFXPNrZ6uh/eJo7DdQRquUiPqH+5JMLJjUpp0not2/nIyBO7DsTf9RguQXj3noix13kjX+dw4S1vDwLUXXJrydTG4JeGvg3cB4+4ovVs1RnZc1sa7/JOABmrwtYoxwlQIQaROqBMO17rlBSowwgGMiNTyc76YR3GpI7xjT/gDzzyifNS0YtuxARH0/ys25acvko+BMWThsExyiTNl6Rs4voKiuyoH0cMT7g03cQ/5YP0i4tnOHszLoNfDBmhRGURyV6JL/bMxvMeUFJlDADDo1HYY98517PzhANONLVNP1Sgakolbv7LuVjigqDYI/Ra5lIq8aWrOPbUvRhGb2qYql2AuoukwA10NXQoPAjvY0lwHSgBJSUx28nGemvTopvomfIkOhE1jTrhjIYy+ADIVr3kMOdr0zlx04RzAEYDLJEgFZfnHjF1I6f
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:26.9915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b34a635-0315-4b68-4bde-08df3350c2e5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR02MB12377

The devicetree documentation for the invensense,icm426xx devices was
documented wrongly. As per the discussion in the thread[1], the IMUs can
work in polling mode, making the interrupts as not required.

Fix the dt-binding to not have interrupt property as mandatory. The
driver will need to be fixed to not fail if interrupts are missing from
the device tree. This will be done in a separate patch.

Link: https://lore.kernel.org/linux-iio/20261018034134.2bf170a0@jic23-hlaptop/ [1]
Link: https://lore.kernel.org/linux-iio/BE1P281MB142642474354814F0785CB97CE9E2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM/ [2]
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

