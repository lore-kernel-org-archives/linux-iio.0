Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893761;
	b=zjQe9PUs3ORN528B7JeCQ12MFyJLMJmCBFqXED/H5B1xOUd1ob+sot+LHud47ByPLy/+
	 byGlesLwJ3JGiC0UYOZo/GA8fmMGqQB6rgcqKd2YDODxJExft2gW46f+3lTig8lfZsQtn
	 6pVO6rHuSt9LTMTAz26xVOTcVOjyX9UlT4j/GnVoCZXpAh/Ij5PYGJ6BuB+7opPHdfOtU
	 KS3GtaIlCFSjj2DRBLtHY+9F4ue6V2XfVPmhOqs7SjXxeBHFvZbKjQyfADgyTL2MSQjbN
	 OyP80xAjZo4qfWyTw4CtQBwPpg4R2hRU+p5M+2wW/HxwJPHRsDpRKdyu/h06LDU5PrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893761;
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
	bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
	b=0PFuoshebOLhWdBdvqfYZ2ZFWiM8vGLG/DxAMz2gUFpZidkHOS7TtDyC+o47GI41zgkd
	 LkIyV+b+CbCLFQL2TTrUwWk592zCf6vC81ts5DZUSnS7luuIMA9TwkbCk70uyNh+nW7lf
	 VuTUjiTjTsfbkOyJu73pxJStvzsnHuKOyRNIQTh1dJ16EVOlGavSWuLq2CeFNMI/j4L2q
	 j/XUH7pW88JcbgX9Q/Yxqfjlc/3iGrPde3zQmmIigkLu6tcCEnGofO5+cpDdsmFy7Qz/9
	 DLMBBAFRBsfsX6TItlFH2d4XvHIGIdfENSfivB7ArJCp5D39tGVxgcheQZkE6nKir0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=NLnvKSqJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1C606EE8E;
	Thu,  5 Nov 2026 15:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C1C606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=NLnvKSqJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpWqgj9X8qjMvfZx1LTS+cRbC8Dw9EGfl1l1uK9dPPCK56knE9G3G3pWMu+96m4HikqEVnBYtQ/v0FkiyEP/4QHa0XaxJmiUuP0Vgrv4qCLGrH7S/b9VPyyQQIF0TteZALkLGN4/lRukYa53WTVfx+KB2LeSrGEbUmu/Yv6J1K18OfKod8mqy5MImSHZlBjbOrk7yJRjJzdAUazBrTyW6MNodCmSISWE2Gxa5D1v70NbOeU2uxkrIiyVhl3pUxJ8ACv2Q3KQGRQlU60rwKlrCFy9d1WTDUKkq/+g0i6R7KZsr53G1FEcpAlpHs/fYvYHROhUs7B08bdZYP+ASa3PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
 b=ZFO+XeKp342aZCfIbZloGpHM3WCp2VoCzJN6E4wpduZ6rhHX0re3/0GufkwxZJYJ62B0C/JB8M+N2HVWfgy4e87x+4+PyxYkcxXewoF89rWDLS+oppdW+I6M/jvp/iBh2T56H5j5M/moRb7WvUbIVPuiJmQV8RJBInfb1l62zb8fZJlJEo3r8gFnbWIpO0ggrKUtcTuHy6K+Wzzd9A0ah8+tnKHl1qGGs3gZyz2DHFsouV6xp3H4Qc37sRD5mhUwPtUAjlawYCcCd1pOmbjSFPQDp/2I/Du2jDgCjPXOIcXmoWqIAPvch6czKhV4eMz6M6tU7Gxhxl3vg9EArdwx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
 b=NLnvKSqJnBaOwMGV632u+WOa9y/Q1cI2YQSqOIKJo2TuV8tcPh+LCb2jxe8PtmC/PQpvM899q1GllAQ+cbz+JiEzKmV4B5uoRWkXjkbiwRnRJR4bzVYoxcF17kxDQa3MpEgtOWMiixie75perqpHwFlNFD9mqvnbeBTzrMoxp4g=
Received: from DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) by DBBPR02MB10842.eurprd02.prod.outlook.com
 (2603:10a6:10:53d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:49:11 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::89) by DUZPR01CA0200.outlook.office365.com
 (2603:10a6:10:4b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:11 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:04 +0100
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A115F1BF2;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 7BAD6305D287; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:55 +0100
Subject: [PATCH v8 7/7] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
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
Content-Transfer-Encoding: 8bit
Message-ID: <20261105-b4-inv_icm42370p-v8-7-b44eb96020b6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10043;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=l808AswoX/yWQRxeloPsn2Um2SJOV8hSSsSyupfITZ4=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szR/2VTH/QFWe/bGRO5Sc/i6S6e3RM+i/a/z1nzXm
 +++7Elh6yhlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJfPjK8N/5l0LrprNXfzr6
 nTW1cdpX3HFM32nSupr0cs9rH1/lrW9n+CtSvGqS0/pn+5q7XNU8zUuuhO3wcPkw6T93wYaV1zY
 4KDICAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|DBBPR02MB10842:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e909b1-4006-4d9d-d026-08df3b545618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|32650700020|82310400026|3613699012|921020|261028144727099003|11063799006|261022113327099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|56012099006|261022075727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9Q6i1qEiGX4gzn4KDvLDe6YALaN7i2SUhPcFriN4vNAH181UVZAcf1kM8I8nRTivqZJB/3hrWqIYo5mxFQPFdjr4hcyUkK1aJpUKHM0Xuy+zAEpCy6Z5Sm+VAWr6Z4S/ufgeMXgSsDL5ugNM/A0034/aOSxzcY8OWy0tZr7fgQ+zMjJVVdedwbFNS+Av0JYz48j69C/X4af3ePm1perLX7t7WGXx0dXijABPU9iUZMi73y5Xr3ssJTQ/oweoOZ81LMGArVi7gLygJkHxjzYPwyELMN/h0ycWc15XAhRpAG2qeYy5rB63bPtoK7v8bSOjvB8F8ABch5tjy3oW53OQGYlPOCBrNCuSgNRE8mN33TrqU953BGDkOI3A+LQjLX5Zdy10wmFYVL2o651Zb96YCNl0D/4H6Ku1/36ZqQjWme/7rFOeehPG42gQG8C3LkvPeFq4pUIppqTTPWBnResz+tzmTncXcZPeyy7qABuyO+cRqcNHGB5im/wumJjXibna3vDzsDSBzrYuz9dZjYK5iUoJRGPLaCxp/whfad2VTZhzXYla9czHLo2kvJgNtwqOx6BNmQgGDOUkzA1E/UxdnndCgzHlHEZnksgXyIs+lCvsCL3/md6jBWEdsgo/Jxw8i552WBx/8wxjVhVjRgMz4JCDEeh/bPSb+XVA4C+mqoSBa9Nf/rzdlmtUZ4h+9GyeoP8p93sfsiv0RQOv8hYyigh61kmFI8P2fiTXaC1DjNM=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(32650700020)(82310400026)(3613699012)(921020)(261028144727099003)(11063799006)(261022113327099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z1fDV+6RGNzuHp65rFYFdr9tiLfWEDriOwWiczx9so7FjzGz4vs8BKT+3eL+2jEtoYbqjmRBzQmexE+lnJrnCJ3S3aT3C4y/5B7/o9r2TVYW3e1aGC+GdXXQe4S11f4m32xVQYLxlRdIlB+ciU7ynFE8nHiy381MmbNyGNNdzDRx1tZX/VW6G+imBGH1+Me+hOBOcQlyHO8mac9BI1ipmXqhud4IenwiStQLVvcUbVV6//f7vZ9HvARFaqMkecZPPAk+AH2j55xX7xVzTC+p3ygLnONGBN8kra68ZW5Dyfdt7fgudWpiW6aYyWSky4IAQdF37MKV6pziZXGPpQhgemc6hAE8GD66ZyeGoQCvAbaf6B8+DTBuKj/MA/EDCfzTDeQ/bZTXNMb0ZL3Sm/HflI27gFGRFzcqLIwmVoXAj+k+do9HCmXULdcRTEw4VGA4
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:11.7154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e909b1-4006-4d9d-d026-08df3b545618
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10842

Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
registers are stored in MREG1. The calibration bias is written to
OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
limit calibbias values instead of clamping it.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Note: The accelerometer functionality is tested with Invensense,
ICM42370-P development board.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h       |   8 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 189 +++++++++++++++++++++-
 2 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index eecf4c46cbdb0..f4b46597a2bc5 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -437,6 +437,14 @@ struct inv_icm42607_sensor_state {
  */
 #define INV_ICM42607_SUSPEND_DELAY_MS			(2 * MSEC_PER_SEC)
 
+/* OFFSET_USERx shared registers two 4-bit MSB fields */
+#define INV_ICM42607_OFFSET_USER_NIBBLE_HI	GENMASK(7, 4)
+#define INV_ICM42607_OFFSET_USER_NIBBLE_LO	GENMASK(3, 0)
+
+/* 12-bit signed offset value split across two registers */
+#define INV_ICM42607_OFFSET_MSB			GENMASK(11, 8)
+#define INV_ICM42607_OFFSET_LSB			GENMASK(7, 0)
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 9a3ace3e7fcf9..be1b62e8fd224 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/device/devres.h>
@@ -13,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
@@ -22,9 +24,11 @@
 	.type = IIO_ACCEL,							\
 	.modified = 1,								\
 	.channel2 = _modifier,							\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |	\
+					      BIT(IIO_CHAN_INFO_CALIBBIAS),	\
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = _index,							\
@@ -56,6 +60,16 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static const int inv_icm42607_accel_calibbias[] = {
+	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
+	  0,  4903, /* Step: 0.0005 * 9.80665		   = 0.004903 m/s²	*/
+	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
+};
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -176,6 +190,166 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
 }
 
+static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
+		struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int msb_reg, lsb_reg, nib, byte;
+	int offset;
+	s64 val64;
+	s32 bias;
+	int ret;
+	u32 raw;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER4;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER5;
+		break;
+	case IIO_MOD_Y:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->map, msb_reg, &nib);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, lsb_reg, &byte);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	if (chan->channel2 == IIO_MOD_Y)
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_LO, nib));
+	else
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_HI, nib));
+
+	raw |= FIELD_PREP(INV_ICM42607_OFFSET_LSB, byte);
+	offset = sign_extend32(raw, 11);
+
+	/*
+	 * Convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * Result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (s64)offset * 5LL * 9806650LL;
+	/* For rounding, add + or - divisor (10000) divided by 2 */
+	bias = DIV_S64_ROUND_CLOSEST(val64, 10000L);
+	*val = bias / (long)MEGA;
+	*val2 = bias % (long)MEGA;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	s32 min, max;
+	u8 msb, lsb;
+	s16 offset;
+	s64 val64;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	/* inv_icm42607_accel_calibbias: min - step - max in micro */
+	min = inv_icm42607_accel_calibbias[0] * (long)MEGA -
+	      inv_icm42607_accel_calibbias[1];
+	max = inv_icm42607_accel_calibbias[4] * (long)MEGA +
+	      inv_icm42607_accel_calibbias[5];
+
+	val64 = val * (s64)MEGA;
+	if (val >= 0)
+		val64 += val2;
+	else
+		val64 -= val2;
+
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * Convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
+	 * val in micro (1000000)
+	 * val * 10000 / (9.806650 * 1000000 * 5)
+	 */
+	val64 *= 10000LL;
+	offset = DIV_S64_ROUND_CLOSEST(val64, 9806650 * 5);
+
+	/* Value is limited to 12 bits signed, return -EINVAL if out of range */
+	if (offset < -2048 || offset > 2047)
+		return -EINVAL;
+
+	msb = FIELD_GET(INV_ICM42607_OFFSET_MSB, offset);
+	lsb = FIELD_GET(INV_ICM42607_OFFSET_LSB, offset);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		/* OFFSET_USER4 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER4,
+					 INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+					 FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER5, lsb);
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 lower nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+					 INV_ICM42607_OFFSET_USER_NIBBLE_LO,
+					 FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_LO, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER6, lsb);
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+					 INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+					 FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER8, lsb);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -207,6 +381,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -231,6 +407,12 @@ static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
 		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) -
 			   INV_ICM42607_ODR_1600HZ) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		*vals = inv_icm42607_accel_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -250,6 +432,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -265,6 +449,7 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;

-- 
2.43.0

