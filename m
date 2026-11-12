Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493875;
	b=k8BcpILeVyzNLnSPb2b3mJFpTDWekYksMWDfX3Hbi3gBwZ7tRdHOqx+A8WxHolmw6+Lq
	 zzowiuZwQ6B/qe+rcRi2RaaRpLbKG253hpDzOColuVTlfN4reH6uXySiUkrYtZ90iErM5
	 P7YQxm7cz15H4kuNOMAj5MatOkG3JswkfWMblRx3oLMpupiC+zPHnAjRWsdnH3pw9lu3t
	 y/YGEAboJiSm08uFyZYI5KOGBfRymq7Eo6sl6T8Gwzkq0khPYtTbrOgUz7q4/Dq6yMdQs
	 YiqGh3XskcYRbyF2/dMb2DJ4IV1Jl0QYKsfl9SiPB8PV6a+bCL2pa+ofnGleITsA4/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493875;
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
	bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
	b=tc3D5YuYD34fuvcZSbohn14CYSR23tAeiIYq9qkr4Cf6wZGx9OgjUFPcX9Hn9YXCowoG
	 Sk9BdvizOA8uVP9oVqe9yY+dDV6WpDgXVb4RZ5+y9ugEKKXos3ykQpFHR0jSexdpBSqqy
	 Tj9xVHqNGmAICyLGFjLQ+4Ip4To/IlTxJvp63iAUJ23vp6x8uLZueebEYoGT3k5+aqJgt
	 5Uuo6qsoRRThA9MnV4ukpmfGvz4APTJ1aWSWUUnFP9mr1tOFIpU9SVNVDWuYTUk/kbhhp
	 FkSmEq+qWv+P1BoMuG5YUBejVE9pqvajzlgP4eNqI4XrsU/tOHiiHSIRPQopdqv8ikg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YLVfvFM6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.50
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B8606B2C4;
	Thu, 12 Nov 2026 14:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194B8606B2C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YLVfvFM6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqy2DY+yvEHY5Qntwxk8Gdg2qqteLmO0i5Ud9z/XsMLuLnfzjbCx66GNZwAvPHmyoROtF6mBg3r5rPoH43equyHQyY/w4m+Q1ZWFFdf6Yb0DyFLAcfKtyDvEc3esElADOoaOp6oGFalCGjg9lD2BfdRPnQSs4QSD9IG71A+5mRZOlaBef+Izo4HACs3lWrYLapSPfL0iMKkkaS28mckZm3D7/4fBFkcFm2kDEEYLDdd52pWFlzSbKem8sNp5xrcWUKfNsUELA2qQsyeyIZKkP8YmbesKv+Hao2Zi3SeTSAxo777y3eO1c14viQYvy/DSXiEb8YOoq0Cvheam2TGfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=l4bVtHaL9+rnPPX1m48GabupYdiQQ7ksFMCA4lMp2emHMoGSbe8QlgbsSrIY5126tn256jIYjlogHQPAECJRNFC0uAn0Shg/jcaD7BGIK9greb/WN6UmZwzJqG1Th1lB2iTE4CmLxmXiDBuGi0TCzLir+mb6jRxK2aMvCqN5W2eo4JbnSVVcNiAD+fBWIZkvxNihgCGvFjvxz+D1CZZYx3k0hYYg1vb/WTw/kGno3VKZgw/vXdNlU6Z+MjskPIZ6WiJlO8/yUbHbUb+bFDwnIk/iLJorFoyGyHoxbaNGQtFcF1kLn9191KXp/wp/uOdOpXBBXNMa+wznllBBMGplyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=YLVfvFM6m4BWNTyIfQBStY0cidoatzOPWRYteTIHXsBG9vxtt+4l95V+uLM1WepNr460RzxUAbavqXitOyxGQdfivtC/e5kThqoJLVoOQOLuQOUjiHR9WyumtpIr812hich0T9MYpZgAPSf+SwgSK4Xp0PFilZd32fFwhGuM6fM=
Received: from FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f1::19)
 by DU7PPF2E7E1C26F.eurprd02.prod.outlook.com (2603:10a6:18:3::cca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:10 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:d10:f1:cafe::9c) by FR5P281CA0020.outlook.office365.com
 (2603:10a6:d10:f1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Thu, 12
 Nov 2026 14:31:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:09 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:08 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:07 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D6BDC2772;
	Thu, 12 Nov 2026 15:31:07 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DDA983061555; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:29 +0100
Subject: [PATCH v9 3/7] iio: imu: inv_icm42607: Simplify IIO channel macros
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
Message-ID: <20261112-b4-inv_icm42370p-v9-3-875c828a281e@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=lPbqmw97WHqi9a7JRElEt72C+UI1eV2jc6uPxGQ2Eqc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enaVfpHqwm0ex9T3zdb+evj7kUvOFtkr/eOrY7k+r
 4r3E1cy6yhlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJfD3PyDB3zfxJnjwa+wNV
 d/imOKkFXd825dA5I/2JGVzhaqXF5gsZ/uctUrBwcFg2pap52r+d3DsF701U5ssMrRTIS1g/S/N
 TGjMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|DU7PPF2E7E1C26F:EE_
X-MS-Office365-Filtering-Correlation-Id: adc95bde-5104-4106-b776-08df40c997e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|32650700020|1800799024|23010399003|82310400026|3613699012|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qhftz++X8/XYS9AUNP9N1l0Hx8sRVgcoChEkC9+DG93yWcUxABioYFlzTZF2DF/Zd4p48T1OG8MO1StiddkEFkPO5BJKWUYeg3Cx4qY3GGOQu5Crj43SI4vCGpYOWd1dBeZouVaIuOp5LfC66qP5c6MQFsvH+fAFUOc1nlY97kRnvf01j+GPNFwUjQV+YVOH1iS3KrK4ZLiSKpHU1JbwpFxYk1XN8M29UYr0BeNMe6yPiTrOWG+NDGRuIXbOutXlYkJU+Dr5veGY9G8V0gKf/0+jlvFJiW2VJcXhtP0aKDG6Jr1vHHbZzEUmnQVeotSRYu/zYKVmBRMB7CYIaBAhKXX1JZeNTOJH3qJH0Q5xXc7e7L0bGeDy5jyWgNP1UNu7+amNMPQh9PsWqneIICnWyCgN4nI6Nk4pSYTHqvDY9eHPm1XSSF+FcMObzHWoiNlVFF/wa4mJbcaWZFWqZmYzGV6XNeQILfXWp9pyaSVwOqRzsFsiu8PMU0RCq2pWJgz5jCDPsFnHx/j9LUBEXqLNdeYTN121VAv+o/tz8vzYgrSClNxxEVtGZDezxyE2/UAdtbsau5H9DLpioaFiRQ+uNnpc+zhIckcL6l0A+D6elFhT2ECF7kNJ3MpIngyWRomHDJUWcMsGv0uldNKR5XXZ85v5DEnTpR9NGsadqR/uodcQDGgl4ykzu0nSdTpC8vKbEMS2yFyhvWQsVdtYQ0D56yMwtdoIFRPRvkLB81jEUpk7RQN3vJX/PBMf4TlsXoCihYymN2Dx95D2uhFjBd4XYA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(32650700020)(1800799024)(23010399003)(82310400026)(3613699012)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/fdUP23kjTFZYGQN6R2sw/z2sHRNdSrNF7CQKFclxh8rOBMf16USBR3hnstzLWbhazTa+c3tKqJm7E+vm55OuiFIItjU/fj/tAFRJfC2gmMWa6CNdarTh1+wUz0oyjEF853V4eB+WZrDGcKkRlXzEcXHEO9ucQEJm6nRKk8yUCIBPnukJTGftsO2FPY3HbfQocE9bS3nMX4WPNcmlfgeAI1P1MXx+B92QL17y83dKivr23frqKE6pyWa+logAjxBWoVm7qbRlU3Ugej6ybppNbGaqDllRy99mn5XaxVzUrIOMgUP8G81FDVMnzSRe9OPz/lgwLnYa49yO0Hl16nzfr2i+r4qsl/dBItrpdZp5HRuFHQDelYZbX+fnH8HkPUXFRR/ACGIkGFfil9frvhVh0HuY/AGdcxq0GVQmrYWAs353nWOZ3SmyPPNVVA3e4z
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:09.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc95bde-5104-4106-b776-08df40c997e9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF2E7E1C26F

The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
parameter of _ext_info, drop it and just point the .ext_info field to
the respective inv_icm42607_*_ext_infos. This reduces the repetitive
calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
struct and makes the code more easy to follow.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 13 +++++--------
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 0b3f035c2da0c..9a3ace3e7fcf9 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -17,7 +17,7 @@
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
 
-#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index)				\
 {										\
 	.type = IIO_ACCEL,							\
 	.modified = 1,								\
@@ -34,7 +34,7 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_accel_ext_infos,				\
 }
 
 enum inv_icm42607_accel_scan {
@@ -50,12 +50,9 @@ static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
 };
 
 static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
-				inv_icm42607_accel_ext_infos),
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
-				inv_icm42607_accel_ext_infos),
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
-				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index 5b4683c2dd1e4..a3bad6fbc1981 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -17,7 +17,7 @@
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
 
-#define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
+#define INV_ICM42607_GYRO_CHAN(_modifier, _index)				\
 {										\
 	.type = IIO_ANGL_VEL,							\
 	.modified = 1,								\
@@ -34,7 +34,7 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_gyro_ext_infos,				\
 }
 
 enum inv_icm42607_gyro_scan {
@@ -50,12 +50,9 @@ static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
 };
 
 static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X,
-			       inv_icm42607_gyro_ext_infos),
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y,
-			       inv_icm42607_gyro_ext_infos),
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
-			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
 };
 

-- 
2.43.0

