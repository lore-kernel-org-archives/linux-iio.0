Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9B53ECE6;
	Thu, 17 Sep 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652325; cv=fail; b=dPPcUBzEtzWMqnX39HWT4+7UtO/DAZVSv0Zk+Rd9JQyHHtiC1NTdCrLwHwuRSaED3OVy7WFoXhAC7mImMHUICuufUvhh9hLhR+efAbOlqT1tiyMxGQXCJnmmEU2tpNJ2OOXBexp6gfpEdE7Lxz6g9qKL366/jxTgzPqsNmDRK0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652325; c=relaxed/simple;
	bh=RuAcuwz8SinYNo1kAV8kOtlLiGrTc+MN4uPp07m5PWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oS8t1QBqmXwqXhj9Zfg37BrmQ2AJf0jhvGWutFJziJFc+yRw98R2Wt7qW/ZqkPCoL3l5ku93tHWh62XeMBGVMH6StveXkc7TXSxJB3DrHZdEn+k07txH4N4AlaTTesGTLIJ9c9VvkcF1D4zvKbRTLLJZqNWrFMg6c7I0gkkmOFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Cl2FPN/q; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Cl2FPN/q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJthUzAbOkqcnKBEAiWFdSqpvdPKyMur3VvF+QQM8Dl4xyOTY4YJCBvL5wmQwqDRCNwYM3DctNtrLexlkDAjfTHc31Np3/H0zr3GuD0HZQ3j9rayJ8ipHBKe/nhE7KKXPTW5SgFQN2hcVneI9QJDOS2dHchaY+EQQ5fTQ40VsCQpNpOGrtFEsHaKvgxDUVc+5Kfl54DuqEvFZjPNz1OFrwcFUFT/yd++M/jd2HKL6QcyKrVsUciDws14YOddCgPId5WUvuDdFW1LTfyGrT1Jat7L04OD35v61kbgAV2Gy3B2elOkWfmzG4vZzdByQOyBD/1gWbnpq1/lXqwJ/UU16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOHJ3r/ViNiuirnadsigf3mPM7LbgfWUo84CVhVhaVM=;
 b=eiUFgtR36ZlMcxrvSI15B0xUwOLHn8Lv+Vf0mS7cp0lxx3iDe90bhTPptyLiBEflQRoFFA4OxxTDswK0l9UsHaeIW5Era79nhZ2iZ1rAjO8hpwAqBQr17sctWkh/4BWe9WnjsscOxQOUG6Su7nAD68jMGxLc+PY0JylI3PMiRAUnbuVgUPfpO7deBDma4dneviBy4GCIAtSgfleLS1uoH12ephCvoX8iRr1FdEiyLx9LOjvsQ52wtD82/lj/j76t/LejvoKyi3Je5w0tB33itbcNCvCay8PhlUzPZzCpmdMqZ9vmVLvk2c/++kcY5jm8VvWSQeUq5oza1rr+YdOt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOHJ3r/ViNiuirnadsigf3mPM7LbgfWUo84CVhVhaVM=;
 b=Cl2FPN/qHFCs/OBCp2HLXOQmwDIm7tLKpXUtgM3b7vuGU6rvUQH68GQP51Gro8ahD0ASxVWKLasIvNW7lJOTMnqBICXI4fdyr4lfNIqa4CBj401mVbTeX1Q/hiJTZg8C6pQpo5aivFPJLxRMS9Aaw6usM1r206+jvBFrzGjv9sQ=
Received: from AM8P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::18)
 by MI9PR02MB290967.eurprd02.prod.outlook.com (2603:10a6:290:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:38:31 +0000
Received: from AM2PEPF00070CF2.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::58) by AM8P190CA0013.outlook.office365.com
 (2603:10a6:20b:219::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 13:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF00070CF2.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:38:31 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 17 Sep
 2026 15:38:20 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 17 Sep
 2026 15:38:19 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 17 Sep 2026 15:38:19 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id DFCBD2792;
	Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id D305C305CB1A; Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 17 Sep 2026 15:38:17 +0200
Subject: [PATCH v4 2/5] iio: imu: inv_icm42607: Simplify IIO channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260917-b4-inv_icm42370p-v4-2-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=RuAcuwz8SinYNo1kAV8kOtlLiGrTc+MN4uPp07m5PWc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsha/da7tMIyrmJVTOkOoavcnj+zt9zsyrywwH6pzbv/u
 0VPnJHQ7ShlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJvHvJyHCl6XNBXLrBqR/N
 C3baX/eVqF92Leu544Kn5VslFp6ctvoXw/+ctJ9qwRqNu7dffXzuefBk45m3m11Tptxbx7s9rWr
 NfHY2AA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF2:EE_|MI9PR02MB290967:EE_
X-MS-Office365-Filtering-Correlation-Id: e5306208-a2ac-482f-fe88-08df14c0f693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|376014|7416014|1800799024|82310400026|23010399003|56012099006|11063799006|10067099003|921020|18002099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	uDGMSTemKzc6mmVDqJZBR+3AlHBTwym60qTowLxHnyqkB7Xs5DPaLXo9LlN/w/3yLUXzaQ+6ym7yhRBzvhO1hiQ4Q+REvPqSxG8vV5+XltYuFeKznakGTe2CtCnQo9Igbk0BYA7Bnr/voL3WEu4KLJ3bWlGBldcBV0gpstzSwFg242Z9A75sY5Ejc/HsuD6guU4kBgxUgJ6n3U3oQBLPqWjFanGqCZsVXZqBXVGVR+LVYTvia31VR5qcWHBYAFNzuGuL4uDWIOp03sn0e/QlPROHkmntsEs9wCRSWdVRMDxco8MT9zp9gCOsWl60ril0RAUQbFYEaSBcmQxds37ptYd0ICvubH/HJREDga2gKGc8C/aW00OHxNV3szfIVnNgKfeeTzYrOIVgENZXsJIgwZ/uBsoXXTN79MSbIFs4Tw5L1eQRS8u9IKi4AJAutkki7amHtxfvl/Jn9R1ip4oNdNBfiqa04IoAk8KIscVlLEzOhU/wy/oexngM64DaDtI30UHreCKhppO9YMNTGFzh2YhccN8y4wK/ntx9eQzT2loVPDpi9OT+JerwDnNzGyeEZvASNC4Awg9spIjyw4vdC6XerawfEyrlHf+bp83WngVWEPacjK+y7zs/QN9LJDeBORTRETT1SPrERuKTBpAqZzKIjVlHHH9l9RE6q7dSSm3ptLv1a9iYvdE8WE424PXh9rwHJqXKL2Mdb1AjAayNEcwGOqJES+EZfxQH13ybnrlbx+g6K3SGzp0LxzoPCHD9vyx+7dKfuggGUR6RyANI7g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(376014)(7416014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5LHBFIemVQtGXG1JcNuyBYKQ9thYd2WctKDwa5CcpFwmM0gaDC/34m5dtiMZCQUfVy7b3aEI4T+k5jQmCclZiiWofm5LH/Sf+TEnxOyH48xDiTPbtNX1Gml/OhfSlRkBA9LWsZS+/M6wZAOCkut5OxqyMVxCQ4W8ZdtgwK9HQygQ6h7cv2hVrznQPqk+ZX9GDMCTBp3elMmRAPM1Dor6Rt+5i74u1GC8VhWiEGCjGOGvxzhhiHYaMASTYEYIIb6Y202eocAs1GiseARM4BqglmVWR2lThe+P7+CoThByyqlYXYG6dWKn8u2otsQ+Nm9/uJ3/1REnKT37l+onZojw+dImnMc6EOCjy2aNfiLeb6BoMNOOMxwm3O/yHkvNjf5Hark+hBj8TE9o4cEsP6+utRYcK5aUzxEZ1d5fI1wiZ8Z3bTAtlaR9zQpbh0AXUMxy
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:38:31.2579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5306208-a2ac-482f-fe88-08df14c0f693
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR02MB290967

The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
parameter of _ext_info, drop it and just point the .ext_info field to
the respective inv_icm42607_*_ext_infos. This reduces the repetitive
calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
struct and makes the code more easy to follow.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 23 ++++++++++-------------
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 0b3f035c2da0c..8f61bc9014526 100644
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
@@ -34,9 +34,14 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_accel_ext_infos,				\
 }
 
+static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
 enum inv_icm42607_accel_scan {
 	INV_ICM42607_ACCEL_SCAN_X,
 	INV_ICM42607_ACCEL_SCAN_Y,
@@ -44,18 +49,10 @@ enum inv_icm42607_accel_scan {
 	INV_ICM42607_ACCEL_SCAN_TEMP,
 };
 
-static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
-	{ }
-};
-
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
index 5b4683c2dd1e4..8e8d36461e515 100644
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
@@ -34,9 +34,14 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_gyro_ext_infos,				\
 }
 
+static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
 enum inv_icm42607_gyro_scan {
 	INV_ICM42607_GYRO_SCAN_X,
 	INV_ICM42607_GYRO_SCAN_Y,
@@ -44,18 +49,10 @@ enum inv_icm42607_gyro_scan {
 	INV_ICM42607_GYRO_SCAN_TEMP,
 };
 
-static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
-	{ }
-};
-
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

