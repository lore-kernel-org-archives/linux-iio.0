Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39B367B97;
	Fri,  2 Oct 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942089; cv=fail; b=ujLH55ntvkgY3vgVDZUVooOdnyAWQ2A7CzlH6RjYkz6/O4bNH+vSRKY5m9PvJpN9cDsiwjffffAYJPJY7U8EiMu/ozVkRJElrVO15nGPNv/bNXpq9WBZGbOA5eZIhpOm3kNfy+Fs+sdgQhNl1B9ySqN6Tgzgs+Tgej4nRnWIQHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942089; c=relaxed/simple;
	bh=LIXzc2Rc3LUeBTVm7TQuk+ziLhtrnSjX+oQ9pXgOHVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ROaX+Et9xnCnt+OZ83ujtvYZwcH5m8BK8H0/8ebO854vJCBfAx7wWEDFzviuKwg2LJK48SUwAQYBkAQFsywZG7p3hKJzjutT0VfXLiZVUVXMtnzr47COvkRAGTWPQacwWkr86yBvoHCt50HXWAe78Ioma/TSGJD7EEsm93qKXIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OaZBsSKo; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OaZBsSKo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0qCoRhXC8RKKp80KBCkG0IgpvjlHj7drkczOMj9tm9P0QqL+TL8gr7KW7KoPjg+ULj2zFBn7VZaMpAOSQzslLnIbNdnuimpJJDPq3NpRGcYOzESGkLyEKYy10o5jzCzcPvGGi8i47bHLya2MvZJAitT8rzWzxLl12SPbDpFjGZSA4hNJye9ud0oNU0sKVtFizkVQ0GK5u2DJAiBR08N5zAdtD19dCoHa2VS6KIv56MwByVrPWZrN8PRcrMFSwGSKYLWugjGTWgfc4/VYuGyp3gZspfi/5atwl35cY63aZkTENYJNCzltuZdcx3/nGyXEZM5i/+e1gDeLL6ZYY9GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TF8tOLU3RocDefiGYZuWbKX3/9IPjEZ84jThQ2TcV0=;
 b=UeTiYTbU17QF1Tc6VSc4G2ykXJ+ir9c8zSZ/0MgWnq3Dp2DmmI7WlYYHREI8KLGw+LwOie+WwYb8gpki73rq0foYKaTFSXW5JOduEkXFgSzd8+73/YJa9e88A2CJjzr2Z8eZ9F8xQdXygiVjFJ1nBZd3LMd72aW4cdvQOfXRrdrPLTWoS1bOhzxb9fVErrqabc5vp9DQf6LETj93hyXvECxZt6Rk1hwu4vgmzB1YlCU9Pexj6R8KLxe+sifC6bGEetwX3AH6EkxlXv4789Vp5XFi+C9bLXDvOqabNWRTMtpwKp9NI5U8/Vla8Tw17hO0jcBBUsrf/e+4yKf3hRtxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TF8tOLU3RocDefiGYZuWbKX3/9IPjEZ84jThQ2TcV0=;
 b=OaZBsSKoCkbvfPYXzQt6XLTeV6a7oJMcoSRsqXTla49aFGMU/5s1gjGQCXytwfx+kevnwBY+n1zPew6yMoa9rIcIHjtKxlBTVFdDgDqWvTVGcpWRucK1GebU2buq5e+q7QUtA2rlawC2p5dp+//tHA0ZQ6wOXCiXc9+ONtjar7o=
Received: from PAZP264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::12)
 by AS4PR02MB8083.eurprd02.prod.outlook.com (2603:10a6:20b:4fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 2 Oct
 2026 11:54:43 +0000
Received: from AM7PEPF00000056.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fb:cafe::60) by PAZP264CA0101.outlook.office365.com
 (2603:10a6:102:1fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:54:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM7PEPF00000056.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 11:54:41 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5EF5319E7;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 537F3305CE80; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 2 Oct 2026 13:54:26 +0200
Subject: [PATCH v5 2/6] iio: imu: inv_icm42607: Simplify IIO channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-inv_icm42370p-v5-2-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=LIXzc2Rc3LUeBTVm7TQuk+ziLhtrnSjX+oQ9pXgOHVM=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7t+T8BHq68yVQFLz/B3dl9e6qmjdqE9Laz0+rNkW
 WG3VP32jlIWBjEuBlkxRZZzRtuj9yf/050j7XQJZg4rE8gQBi5OAZgI3zmG/9Uz+34u59vSa7Rj
 uiRnpZfylz3XpaecC51oNllmu4+P4jFGhp27P33R/K726fAEA4Vnpz4WGBfmrlPJv/Xe8veV44E
 5k9gA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000056:EE_|AS4PR02MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: b968e789-82e0-4449-58c2-08df207bf1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|7416014|32650700020|921020|3613699012|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AYTbLAWLKJjNz6b5GSVqknIonmKsTiFuoE06mzMbScYEfEjNIGp8IZAnE7DainjjKPf103fM8mtYsfa1psLVDMOFUeAJRkXNG9x+Qd5uWMXMQhrRurB5nEpveYrXfkHDmNHbtwbFULOtI/pqukt9lxLjI7qbPcXKR9XcRKaNz3ACmPfso6IqfppTDnQNgWeyMdajfLW41JLikaRquDYKUyeVHBt9+mIcBuYqyBxLs7z7v29lwj2YLvSbKW/vjlaSap7g/7xaEPoZrjLOUzPq1+w8BkS/6d1V22WHbaqeyEJZ6PVcleYNhqC3z78Zd6tWI1J5sEwMYA0C1C3UK0el5jbrsNhl/g0AhC3fdaY6ISbiN8g8HxHBpT9ATGJ0fZIHPnD0hLTFlXXa7EhYuPl+DqXazntbYZpok0PmHE+HV/u1kBrFmV8gWARjjyjCs8EGk+sHq89Wq/iV6pIu1n4fSwBJ9P1witePQnngIAqkKCOxYmf/jKxxRzOeCsqk5jL5QytaH7jbSKaWnWY/XIsqWfz/j4yrEhjCdkd5pLTG9Bxv+BbGUr195mXwo72abIqCNWHqkVV1j4uYtTQpoq8Fnq86KcJgmwKncvun+p0uOKmZJbpFWGjhUEUrJHKZqMkSMDMya8QvOh9WREM5e5Na73XoQn9ayYVH94pGQ3SGJm3prBmt+Ku8cyagAdV+oNHGXzlnFd2/OqfkxVMyDiFnyE4jPKyF3Ecid0LGFVDuDHFHaGJNNyfVy8tDtyarfDEPZ8TpMVGyXgINaxk2HJ4ofg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(32650700020)(921020)(3613699012)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cyz9zCJLMSfBAsZ7c5OAI3YH2OTsz4w2WHoxuJ21UnkMzQkPCktc0tA70mtKE3Ny7u7vRVXFbRXYLloKtFcest8ZA+jZWi6gRIwlD10IVbt6Z03ymMYAmoIUSnFx3bgV40KBmvRxVQ41m1JvwugezlyVQyOr7fOHiO896ZETDGhj7OOCs4D3vYT/YrBiH1w0OXIQRKbsCyGvUU/VpDnGKXIxE2GgrC4GoPlArUnZEXtKuK9yuRgnn+HxEhjqxgnlpDvi2bfTvp8AtiT3kwRQYGL2T1DFYvpYn2BF9xQk986xfAKjmcT21RalyR4HkKKCEFt7WCFWGr+bd2grGvF7a3kE6pa8pyWOLZrtwFq43wi+kWrBq94yjIWu0MaN1qJ47wihvTxtIqi376MX/gpJZMkzvmc2Td6lcaa6DDUkQUgUL3QLDhi4f5PlJNMfvdme
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:41.9923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b968e789-82e0-4449-58c2-08df207bf1d6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8083

The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
parameter of _ext_info, drop it and just point the .ext_info field to
the respective inv_icm42607_*_ext_infos. This reduces the repetitive
calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
struct and makes the code more easy to follow.

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

