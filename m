Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F23B5303;
	Fri,  9 Oct 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555157; cv=fail; b=eCHHpiRNa8R8l+KDxquYWnQejVazZs32blLFUgw8ImR7fSY3ujQrCuIRdWwJzxWDrFHbCNjkGnz+sh1WQ3MGS7DPPKeUbPs26k8v7IUmCC+E64pBeKIk7mkxfpNEW07ATt6K5OipPXmBNkYXKrh4tfmeZKPjWXPNzfla7hICbCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555157; c=relaxed/simple;
	bh=rYb6gZbvPRTXWOZLE7kveUo+PQT0BxlXmRqMb7i3iIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rxksx7cFoBoUm4AL+ZTNI1F7+SMRGfEWt16cIlOyEL6DoCgJZRkFUEeS0V+/Nt0P8jby8Hrvcs+XsaEEKz1Jk3rJP7cjrsRPyc8a906B581GuG+g9PjOorniiV2URwLZlPxiyfT5wd3ecRWNHzNld0rglQgpq23QvF5zG11JJ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fpBLW66E; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fpBLW66E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHvedehltd2Dl4LVF+0UK0h4d+dBhHPWd9NI3LaItQsbfa8rwq2Fflvdh9zOtR47lkI/UWKyVCXO8Gztl8NCplVuoI4anG0nagzmoYFQ4H6GHKrlcB6wlLFdOEUOYlkYAeclp/v8bM3NbsZXoNh1zuzMRh2t9OzNn/jWtA1UCNHgbtgFHx7c9Hra4qHTmu7U2/oM7iyDpnSLySFnfmeB4CAKPxTg/aE9iGmDOHuKLc+cFNvvYmrPq2qU2Q6xw1gDd7BiEkARv6RstoxPNjz1wCZoSgh0Pf6qz4pnNo9T59ABeSjtfrKWyuNC8maqtPhrRiBeyipbaKrmEnrPFofD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbs1AteOUo72ZbCfOsAS14L56P1IQpczx1cvga2HplI=;
 b=PcJUb/X+0HbSYLwnuDl/07tX1sVt50C5giagKMwHbUeyVC6JW1ThAWqsszVE5lu90DHgbREdB08I57USaVJibKmDlQMgtbFc1TTTnYmCH3HMR9YCT4Ro3yUJvnLZgCZ0TsHChokp79WFE6XTU1C6ZCgZHOekxzgKNUaK8UHIpqzsQk2vn/AD2JkiIG+GdM07gjmXkoC6+cOYSHWi9boHheDzZWzeY9+PFTTx2L8zUNEHzFYq0rLiLejayR0jo2tpHfpATEdGMZMMbkj8/t6g+qe5aY46WLR1nuHFxJGUAGp79GHm03DezJSeTbwysQjsVkSFmidod33XvCRWKtHsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbs1AteOUo72ZbCfOsAS14L56P1IQpczx1cvga2HplI=;
 b=fpBLW66E4Pzrp8AuClLyOVxq34MWzvGGzhzTV9ga1L8Odjj4NvVAp3m+z7FwuLkHDiMq+W+mSW6y2BWQf3GLK2/tFNl7MxIdtLIAxCCMTpvpJxSBTgpsguIKwzhSh11HRpXtTnoHp1qtMcOfTGxFsAZZu2DfwgoNT0F1AdMmv4o=
Received: from DUZPR01CA0230.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::7) by DB4PR02MB8775.eurprd02.prod.outlook.com
 (2603:10a6:10:37a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 14:12:31 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::74) by DUZPR01CA0230.outlook.office365.com
 (2603:10a6:10:4b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 14:12:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:30 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 352701DD6;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 27B3B30604F0; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:06 +0200
Subject: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
In-Reply-To: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
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
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=rYb6gZbvPRTXWOZLE7kveUo+PQT0BxlXmRqMb7i3iIg=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c3de6/450e8UXKxF4QEb+kwxV/uYT9447tpnlP6a
 5XQ4C65jlIWBjEuBlkxRZZzRtuj9yf/050j7XQJZg4rE8gQBi5OAZhIsjvDP40Ct6SsgPOL+R1L
 eSVyPNdnbNxp+aN/gbT9Yokid6NPogz/7JIbuxzZkhJMZKdz3kl1muuStPvESgVpJ4lFSSo3/jz
 mAwA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|DB4PR02MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e0cfa4-4d45-40b2-aa8f-08df260f5af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|1800799024|82310400026|376014|7416014|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	SCM7/wUFawo5voEHiJIDdOQ5CJJrmAlHQJUqUPT4vpp916YdNGk5nohLHjBrZc/fz1SyrVwuD861MRVLmvZ93lt+WCE5yadmPMU96HKUKCkMKau0YWGLj8142Xu2aMj9QlAN8sL3pXCwOEcGg0wmSWSNjPKD4FvDIII33+2GPkm+Tw3FtXNsXXCorp/zRqvKwOkfYbxklt7mcHqeUGZsK98Hcl2OXm5pd0RPZ6St3y394xn/PyyA7HvcsUJrfkI/gGZ3JsafxdxVzgLUzPi0/QXLhLPCYTn3f7wlaGqejwI1504yl7aYbFyJC9WT4/8mrNZ1BSyH3MChlP+97q0h1fQUyF3HyBvQyRtkd7Td2bsO0eF7zwpJpo+Cz5pABB3EixKMnZDsMh6KFDduKRR1QDzCt9R2R5leQGShjo8X373eIpJQfVuwfg6XZpw6czfPI9j/9QF+XVgI6mm8PZGzFiRXpI5OfS+L62oxIkls5rsUOdXeUa7hTai9oC++Ch6rFGElzEip8fViqoUnV8TFJXHb/Y93OCiwqUp7B4SCS1bPcsmKthUlp5hdiY2nVWVxnyrhshRby19hwEliYmZaLjREAvOAoBO0+ITrCARs82Ll9KzHlF/8hPFQKVWfbKDgjogtymLAuq1MNFG/1pI4crMPgvoqNjSInFh5SmX92MRWebRbuwYTKlYfDU2iCViX2RRTaSmKzEXx0cc76xgLqHrRyopp90hnlrOCcu41X6EPYPm8lys5XsVgFYnFdAPp
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2bFZmL8RnGgdQibk/FbEwpuO0tegeHM5E+FLaQI5rIQJlS+wqpWbfvWlzWYCN1LXzbZMB+HQlu1XlJ4FTyTgD81lpYCUAbo+aJ/SYQ4IGEe/cmwIVG+gOCajh6czLtlQPc7WfQY4d9tYqxA9uxWz3Xwqlg9VGc4aE/kcNkje+zu0qiX0l7/29jMKDOhtSWuPaGWDUkthoVl7wB22+v314i60200iApsWky/BMJY+ZGhEhVFXwci7rd3uP0KJzylZqdmh/fi4Jf1j/LV09QfPDzAhmNJOWtayvyJxjJiuYfN7wodWvVsCBLzK+/C4vjcfhop9rBPIEiFgnm2Pyc55EMmbX6FeyAj318GJ3BgaBBEVlMWlM7tq09JwZWJLtXHtzvgozeOc2+6ewK3YS79eZ2cd5Xes8MIEIE8ts48weQQnEI1dtcYL9Zuc8ku4zXHW
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:30.1463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e0cfa4-4d45-40b2-aa8f-08df260f5af5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8775

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
index 9e22b603d47fb..7d7ae093fcc96 100644
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

