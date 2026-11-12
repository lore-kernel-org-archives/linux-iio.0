Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493882;
	b=P0kiPbsSnKOZnUztxWlddmoRLvSvpVLDTRAuHi0DbHD26QM5X8GCzJjSOEKO6M+7TRSa
	 RwS295/yrxwqG3NZBM7rGIaqgwUVga+NEI46ZXwHQLvdCEPyGnKaW0p4f5k3q2bLyxK//
	 TuPpFRV96Dmu1vBFNT3WxXt1k2PrCN2a4fmj009sdKfXGpBcxQP9pC9+e5ShKziTTwyw5
	 HhBMdBPB9nyLrQIE/GwWMOVasUBtHBPSWrm2oD02JDkz5EWVGdudNqVg1/MN3wVbU7C8h
	 C4ENbn99yqXJbt1TogfxtxpC5T6h/uK1stSuOjcfeqX+utFAstdo1vi9KmbV0TM8zXQ==
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
	bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
	b=eXlwe/UVDD/UQpp8Gw9gy+Dr0oeX1N7xdKK9UmhoPN9OxHTL5LwFQhXqNjf8t9A/wWlg
	 EvJDokBZ8r/uSHl9wlPV4CGI/x5OwqeyHnBDwkZoebXw6wqXIZz73rnISbuEc/8tELaWz
	 kuaQXXD7pztO3fR/9+Fin4Pvf9kJieLDxPsXpHbh/Fndrwco7yWWPZEEP2dCh7OASeCEL
	 rDCI7cRzOrkZWPSFwXKOz5NN/O8qrQ8LIyi1sElTwOpQGFbt9TxWWDiuEsWgB0rNu2jJm
	 iMxgCT/8f/xNVgIv7iC0YMzzT2JvJ2hMP7GZiGR02RlwyxchI4zmXnF5x3nt5s1es9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=qN6Jb3cU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2E606B2EA;
	Thu, 12 Nov 2026 14:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE2E606B2EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=qN6Jb3cU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNxvSdMDLI34O8Xum2p8BgeC1kBfbgzOpffEAqny1yKe056FsxpLtb8GhrM1fIuIDpeHb0pyrzi6sSkVp2Vi6+FneyTFLXhkftYV0Zs77KcHmEOQHmIg+MKX9YTbvboxVRdaLDR+Ok8bxyLwrxOwC3NLI8qY2PfoMSjlh2fmCAbBK2kFdwTeNWI+3Sr7PLWr2TWTvBaXK90S8SiX233pHMb5/TGBeJuIB4HvugFJjjSqMAm/njf/dG7NPCOsoexWNsacvr2i/CPW2s2GGje53qQk3prxGJq2KR0BarfywXW3r6YQMp0LgDYr9Xl9vH7EoEa4MheLLMT/e4oLImdx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
 b=PbXCX+BsxYvmzLf6Mfqtsb8qch+fgzqSH6V9LKNkor4yM5+HjluEMxDJ2+TGBXdwLHbzrrw0p4EklIgePKDgVuUr1ao10BizKqUSsfDPTZDslaY93YW/KpO2NoORE8Rzgvb0aLpu4jMWAGmz9NjKW+lxofNmE7wjoFrKQk4DzU7h4HF5UTDFiOB8H8FXPELt3xcUwwN4DZJUSLeR5D4PVzOGwDDz8hnyfzpO7Wnf8LZ4GC1NiP1skA1hMnKYhnOlpiK90cddUqDgvK8H7woHBx2rbb/wW6EukiDoX2sBIHZOx/xE9z/rfS0DdjR6C+IEFh1RSYou5oWlHrf9G4gl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwmR+EVtjENqkGc0OlZ4wD1fMTShg7VuU9RXSsxOVA0=;
 b=qN6Jb3cUO2+x6uDPA12CNDuL9AYnCVXYEuIxVmWk3qHioVEexwp6VhFV0Xm5jyW8Y6uAVHe2AeGhCtcR5pRLagUGmjdpicy5N8mN3Lpp8LeKMKpCjBZImt96XhWXerIslyYRPOjKUwXG28XdICCvHixqLpixrOK4V1A0u7ox67M=
Received: from FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f1::16)
 by DB9PR02MB7273.eurprd02.prod.outlook.com (2603:10a6:10:240::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:13 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:d10:f1:cafe::58) by FR5P281CA0024.outlook.office365.com
 (2603:10a6:d10:f1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Thu, 12
 Nov 2026 14:31:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:12 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:08 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:08 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 152F42A1F;
	Thu, 12 Nov 2026 15:31:08 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DE8FB3061559; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:33 +0100
Subject: [PATCH v9 7/7] iio: imu: inv_icm42607: Add accelerometer calibbias
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
Message-ID: <20261112-b4-inv_icm42370p-v9-7-875c828a281e@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10043;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=l808AswoX/yWQRxeloPsn2Um2SJOV8hSSsSyupfITZ4=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enb1nsQ8++LfLT/Kpi/P/rlxU3fzrWjGuJAigx3cC
 32cbUyWdpSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBEUh0YGU7MiPZ60NpY7pVz
 o63TVN7048Is/Xr+VM3ViQ++XOgTXszI8Gxja87mZZXcjLVpz1ZzxiWFBeQ17/j5++iUpiC3i7s
 U+AE=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|DB9PR02MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: e21841f5-7577-4f9c-7080-08df40c99a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|32650700020|36860700016|376014|7416014|1800799024|82310400026|3613699012|921020|11063799006|56012099006|10067099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	LJsgOvfMxNVEbAPZ+ACFPcCLNd5AObl2EL5WxkgxsfbQFiTk/AjAkJZsNgxRxfBcrXwb66uT4WdTCcjgC8TMoFUTqj+mA8V76RG2oLvkHP5BoQ+zzFxFhIYdEAPvxGN3EpVFoAr6u7TO4t9hGdkL6LkDEeOU0xegNY0zu/4cZJzbaICXUzwYwCb5XPZG1asJZyKCldXeJh7vD/irZ3D7rWK78GDOdS4/DqsdMVUC7w7pfYRa1ipNEpiLvlSkqxFA5Um8u1L3+S0St+nKmmohSuyUCS4Sz8NO3wFiYLnVC7h5wkFep43ZYSm+ZqdZzd+enei/ZjAD086Dz473WqG/vTcpproJfsJd1Pym5FEA9mYwydFN5zxqBgWPtYNnAhVnzO5ZoaGyuS/NUDywz5pMpnHZBIdb1hhMLwUpTAtOzpUTwTGTRRFIJHWT2CJ17J4KpghVbe+1fPAytqLwv/Z+EY21ZGcZWE1p61j+6Cz5TAzuiidPRSpk1J6xfVFfu69kqoYiXfC5dgeiawIZTqNOrUMJAfG3AuzM6vtOX/jW0b7rjbv42G5Va0Fx5cnlSTRI7OLnlIVFU8mM43f0DSVLnh90d/lYr28tBV0U6//rLNHhuCQTrctHj7ZX1eZmUunFw6KZYvzs4dzgbm+CghDXyRCB9vwT91OvOfttKELhh5Hv8ghpI0hnyE5gJPYX4iT1osLC3/lxtjwlysXAklFmP4OCyOAOUjTs1QrvRQHJs2U=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(32650700020)(36860700016)(376014)(7416014)(1800799024)(82310400026)(3613699012)(921020)(11063799006)(56012099006)(10067099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8q8qtiSk7ckpYvggL23taOZZu6yrf4YVG6Qs7VENf/MhatJqmkHQ4el1Kitu6blq0PkPPnMRHtJpGEAbCSOG7JcHtKwdF4JPawoLSHDAUcCqZ2btTlXgkQP14e4xj1N+J/nuDE/jlHiUuZEo69HHXz1VxOVFAXSMzs/JeLFV9wDdkabzSpMBqbnYyVug7C/kXpb0GRWIc3qXJNQ/kSPWJvz4GMaBDgG3hBXA2xGWS+cPo7xqL1VXkTi2Uu7HGUfjtAyG/7VcZ05b7VAiYDu7OsMIDIAlwFL2Tj3Z4UgjPRCFLFsv/9iBlXoE7s2HUwvJ5h+kEhifdcOx7AvGoD6Yt/3MG3Tnc8jx5r5vO1H6WBtxiKfZjQW9jus5wl1RytOyESMNvTlBqA2eFCD7WJ4JYhCXzLem9FUZxigYer8wt4URKpieg5Hjr8z2R9CTCqYu
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:12.9621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21841f5-7577-4f9c-7080-08df40c99a3d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7273

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

