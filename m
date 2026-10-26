Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012609;
	b=mVM4UKMr0xdFZTAxggEBEVE1rtp5NyY/jtCw0+UVZep6EaFbWsIMB/9aL/r0dasjqg95
	 Qc6uJBRkacgFSFo1WfpgVxkC0C/2O6OzFXj2uJvBfUmiJIvaRXn1UKqzCuZjoACfB3wY0
	 +lbLQIJmppBYbAjvuam3GALn5QT2SnJvSGN82PRibQiG2czhREPXh/iSXgpfxBdK+ZDkU
	 4zGoxDYU6mgJDZFnv7pYswX5gA43rj7JJDMCfEfXpRNKo9iN2OSlswFQOPtymEVzV91km
	 96gqMkyUL2BA/mXh8i8x7EF8dGn47OYm3FFZv16RD8awIGHMd1D9klpBXNhlUM1SvDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012609;
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
	bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
	b=5LLililoKtuHmYTvvbGrMD0ANfaNmNuc6xihZxEgASIELArkEXjljM1xEZ1fm5U+VGXk
	 3dSzjvbBS9V53gzBk0MlWNOQ1BroxZ8hAtNcFPNMnvznx9cq0IfTtEcgxPk9HRAjiTmK9
	 etaO8v1LoqQQ5Z3keYQ2GWFmegee8bHvOnvNynJ2agJu1fiYjiUYOfDf5MzmFf1kNIsHX
	 nsUkqK+jTGHaWzI/lBwP/2lwByoyVhpW6+Jz2iwdJsd5knordCQslb6Bl15txS5gOiutH
	 eJRSsQTLpq4Q09C8IwSrB8lWjIb8UpCt0H+d/cAH+y5nBSIiT7WBIMuJkOXgf3BxFMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Miz5PRKH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.27
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA606A327;
	Mon, 26 Oct 2026 11:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CBAA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Miz5PRKH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilBVNKJ3lbi3yJMtoqAuftUMV6MAelaktYazGl7EkTrn3lzNdC/UIqkw4V4zF8oougZUcrSz9Cq7sZciVq2PlPz/HClRQcXksb6fGZyvSZa6vDe5k2C++KGBBL81LzoGl85A+L8uXp6xVmN8kOPW0EOCalMRr17I7as/uizyybE+JUeoJhLDVh3tjJGaKY8NBUGe3/iI4jGYIiOVIj2itzqZxHNdIeWoUr1U4EHBTS4hwpZJMrR9ANo6e8cs1Qif9CFIxINjX8A8rKm5ZjD7HyBtGBLcz2lWxfGGLO3UAB3YhzrYZD22HpT7FQbBGAKNRl9SYc9lzTFeKY+fTyjRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=J3yx23cqQJ17bzTodVGE647EvVLycwL3SDN4nunmMyF6Bf8nLkGObSRVJRdmJt95ko387TIcTmFBFlKJ2Y18jWDjaoIeVU6xr4rZarTLFtsV/CfrDGrAP5I/76n0xDd8woNqJnvdvpvulp5rGrghxKpRm0Fuqbj5KZzcxmd1NOCffk4tYdKLZvCxmd/vdEqn6tncDHporwn0YPIXxFPVQfJOap6fu90hamvBRf66grOejV3YO6vmHC6NrxcqRzJlAdnIL1Q8pqiMpwr1FRlTldc1UQr/03aWfg1XM0hEg/kbOKCNUQMaV3F1drB3oRpZLAcr+2dMTPXI7RQ3yT3fJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=Miz5PRKH2GR+WWL3ZQfSlNNOZyDbaN5jNk4DoSHQ+dpIWaMHbmaVyOBmOA10pXSwFp6jzNiwlJwh9kbvwk7XIl39G0GjOAfIYrBMOL8k8d0cJfiPctBpUBtVFmvkrpuTxWEw0bkMziXTbW7rH3tu2HBJrWTlVORTWW7dQ82WN1k=
Received: from GV3PEPF0001DDA1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c8) by DU0PR02MB8831.eurprd02.prod.outlook.com
 (2603:10a6:10:410::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:23 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DDA1.outlook.office365.com (2603:10a6:158:401::6c8) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.546.22 via Frontend Transport; Mon, 26 Oct 2026 11:03:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:23 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2FA3840F2;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 40327304150D; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:50 +0100
Subject: [PATCH v7 2/7] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
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
Message-ID: <20261026-b4-inv_icm42370p-v7-2-222e296ac1e0@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=PsgyAn2iUnCnZGLPXCZum8Q5tUlwLB/PSjOL3PJAjjY=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1yiHTznk1+N1sbfamfS1bqe8Lha/9T1/Br/42z3x
 a5d7woVO0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiPU8Z/tdvSwhNWnJZwDf/
 q6dU16MdignMdpP5LU7O4+Ute54luZGR4byP4VFWeVflzRu9/2Y46byxKj6vdlKYi8esscVZwCu
 BGwA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|DU0PR02MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f07870-e214-43cf-769d-08df3350c0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|32650700020|23010399003|376014|7416014|1800799024|18002099003|22082099003|13003099007|921020|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261021135927099003|261022075727099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	YrIKnz7tpYCWXmwBlau2PutEV4xJJCNBFgANIfAiyBWb8pwYTkUyk4kREGuPcf7VQEtEIchODm5VfafDuMeAtGMX+ZeibDX2f3N0tQUU/jmgitACcLybqK+LLzbGevFHTzxIo8ySrG0JDW7deoAd29YnJGqaqLmoMGHo1s0j0VhqiQT0zhHECNajIFR/so27w5bHDAYd4TybxFwMZW4lqP4EA1zA6RtXo5eS8xykA+xf0wOs+fio+EjzlqXyOr4+97YhIKJu3Yg1LRC2YUUEOonHxu0iaQkgdHZo6pMziwztvF9vM479pUpxg3iNnhhWsipa3LkOmNEUKT4mhJPgtkRSe4qPqF4eW7sKK1DAl657AljDIrBWiMAZF8U9IbXs/7VFH5gMAjavtqhNZHxaPIrRXBioHzSa16xYJq2Y4hDGea91je2JMpFG/BC2Qc8754HskGFng1P+pbYr62ecawFNvQ6aH+axO8Ayb61O8A1aU1m+HxQF/aDaafCbMPLJHu6fTL7l879xvNRS1JJt2ulqfOUZIFWHpzUZ+uvY1TExe+vLlmZYwX5umxOh50BJtP12ad7Ur67IQXIBtRxyvBCIfX3ihZ4cH1QOhsT9hG3ECPa33PetYRlWldCZSZg2YdGSC3mHVYxdz8iw16RItw/dJdm1zgcoDXoCttrk7P4xywcE3YpeZTgvUwW+LAwwBIYETOyPvPZh08zN9vDLug==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(32650700020)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(13003099007)(921020)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261021135927099003)(261022075727099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U7pV/XftzZ+i9B2C0qbGcVj+/n6UhWEGSbaKvd/6nbIDd2Km0Emlt8xa2xqb7Kl+3aYmzCQwKARy77iPe5cBloi8eXmDOpJNz1iRvWHlpux5JX4lMvzscagC5Hp6Bqqrvc59QsbFAbM33Yhcm1XQ+4nstB+pGu9oHscgvvvWJAN5C4R+PH913oGvdDzkjPEAiMVRSrHrfmgSr1kmZqabNOYnQGucNWE3l1qRXBGAE0dXQ3fsHcIz3bysLccyROJHet2VX4qxaIW3IgFCSVg/T6Nf0UV5t0RlYrhWhzopn77fK75/jdAwIdORd+G6LVc997b0w+4Z2rbRE48hkcoskdL7u5FWvDJAWcDl5wqLLeXVLZgJqs0Im3ufTeVBdqpJDg2B/w5lTYPUbwMn+tcdZ9QqqeubfVh3g90e+t7INNi1F3IOZTzUCokV5C3i2Egn
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:23.3352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f07870-e214-43cf-769d-08df3350c0b7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8831

TDK Invensense, ICM-42370-P is a 3-axis accelerometer. The device can
support I2C, SPI and I3C. This device only has an accelerometer and
lacks gyroscope and it has very similar properties as that of the
icm42607/p the gyroscope feature is controlled via the driver depending
on the device. Add this device to the existing dt-binding and update the
description to match the devices.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 8d16421c6f82e..7c5f42f384672 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -11,10 +11,11 @@ maintainers:
 
 description: |
   6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
-  accelerometer.
+  accelerometer. Some devices such as the Invensense, ICM-42370-P only has a
+  3-axis accelerometer.
 
   It has a configurable host interface that supports I3C, I2C and SPI serial
-  communication, features a 2kB FIFO and 2 programmable interrupts with
+  communication, features up to 2.25kB FIFO and 2 programmable interrupts with
   ultra-low-power wake-on-motion support to minimize system power consumption.
 
   Other industry-leading features include InvenSense on-chip APEX Motion
@@ -28,6 +29,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - invensense,icm42370p
           - invensense,icm42600
           - invensense,icm42602
           - invensense,icm42605

-- 
2.43.0

