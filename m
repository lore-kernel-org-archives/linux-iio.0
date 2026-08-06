Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED132C11FA;
	Thu,  6 Aug 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020421; cv=fail; b=U7NYbA2JXPOHnY4k71C12d58ah9tHnXZHHsF5TYhjymuZO7rruIPVZS67R4qtwMTYulq1CEDAqANOD3h1ynVMAkShvFgwvS0/FmUqjNWArWPYioJSI4VQbBVP6y4tCvaSJmtAqk//uB5lx4R1tfahaTL9Xtma/92mVzynjuHOTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020421; c=relaxed/simple;
	bh=gySQov9om97Gv3kUpuJo7Jo2fG/C5iA4nzhIzPQmf9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UP6WqkhemmaGw8kzGwKX1qZR75gwkPUD/X9qF22QDvTRYOOjnWxVr/F2UTE+FTSo3eX4Ga5TcJmTAX6R8EXR+fDspu8YSZZwGPhGAEmLReNm0//6pKnKKBhCv564ZCQqiCrvgpA9nXGspcCBhW3wlVHTgxshBAylOG4CZM+zxPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aBFfOgLL; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aBFfOgLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9kzBz04mJVgOiV/ftT9bNF4D3o0Za+FJMvnQaKN/glGwL7rKMf2CeQL816DCvQGU4t/eEO2U9LfHXOb/LDQRSuAU8i0alRAqs3llZbKE806J+smrC/lFb3BFFr9VqQyrgWVTdntLZeB295/UErpv47h1WDf8UxSBEi+BZdvjMntbW70WBAYx3yLTiJEUjeSt6Re1eYx7AyHnV2tZ+yxhppIg5iIL3fDfew6z7oHtF02nCQhAm08FNyhpIZS4K6sWjZ0iTcVZroONqwRQ/wA04X0YQCcsTG4YnVFE5CLk9bOGt6uYw8PJ9vXUU78GAw+1oj/YCimd0wgae8/g/Qyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rbhXgRQ8kkrWGEHfn9/8ra8aPJHWWjS2x2b5QTP5VA=;
 b=VmMJxuZcVjY1c+nlHRhmBBRzsgmE3pGHaKXo9W74ecTPtd23OFwo82dH16xSSSaFmbyQJ8rILnjckxCF+tkRAR+FMa4zt+J3i/0doVQzpsQgY/dIV4KGTxOkqNV7sSlX11a7vcnVj24tTYHmeFR3i9cXUQdXn7hIXLzWdfYBqgknuF8+67mlA25GWmml7X0+diss6t6fBBAR2UAag3hdGHZhFq5ecPBkhmJGqYw6otm8OR+H9i3xkVNicVbekYtk3Sn5HEuvJJ83Jlpi4WGddB72IH27O2IL//D3d9sfhgO+7ihxlUuVeZ8s8kY4abuMoKPYJbfkKlIYm+VxAssGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rbhXgRQ8kkrWGEHfn9/8ra8aPJHWWjS2x2b5QTP5VA=;
 b=aBFfOgLLo/W/ilVUghj/mnsamOlCvY4lAhU6npF9Q1W1JtzD6UGLfnxn10/FuH2YfuSveZo6Ep/npQN+HOBRag2YAGlRBqdPNKBJHGIZZJCM1DxNii9YNTQshsesv/7BaXJR0ugeGL7hypXlzK2jcT5tGZ/8Bei9w5eu4Lbe/j8=
Received: from AS4P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::27)
 by VI1PR02MB5949.eurprd02.prod.outlook.com (2603:10a6:803:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 12:46:50 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::1b) by AS4P191CA0034.outlook.office365.com
 (2603:10a6:20b:657::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 12:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 12:46:49 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 6 Aug
 2026 14:46:48 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 6 Aug 2026 14:46:48 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id BECD32B36;
	Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id B02B9306AE9C; Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 6 Aug 2026 14:46:29 +0200
Subject: [PATCH 3/3] iio: accel: icm42370: Add FIFO buffer functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260806-b4-inv_icm42370p-v1-3-670837f5842f@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
In-Reply-To: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Henrik
 Grimler" <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Kanak Shilledar
	<kanak.shilledar@axis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=29678;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=gySQov9om97Gv3kUpuJo7Jo2fG/C5iA4nzhIzPQmf9w=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJKmizuf9i8cwGjsJlV6pN1b78kLr7w/cOp53sMU79cE
 3o1V/v62o5SFgYxLgZZMUWWyJyGave1Xkn3iqJOw8xhZQIZwsDFKQATWfWX4Q//iS8Mj4/Ev3lY
 E8ZT81Pr/uOP/974Gj6aEP6RJ3cSe3gtwz9V41SXN3walRmN2kycSQ1LIpLlFF9aX414Oln3Ydy
 nr9wA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|VI1PR02MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e533c9-61ec-44fa-8b1b-08def3b8c88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lgYgJ5nbmQ5Kc8S2i2hv25szL9eh1ho0yYn8Bo634Ubh53cKSz7IItmtLeSe32WHDxn7+GvxY7zoY3mqG98z/Xjlb78XX0JKYerBaWqcvL2n3xkEvnnStmpMpySJ1Sa3C6bN88J1JJ6bLGe3wMbQ8ezH1OYABtvZcNMn4NfQKvRS1RKYzYPBOBN4HWnmtvK1wdhEBxr5SNfRpJiWoUSHqRt0QGdZGQCu5kVS/klb3PM2PHSy25SCRGVQIfstYqWuB5+yPIXcIg+i7RybPVsxK+/RP/5qvQLPofaHjNs5RIfSG4Jmpr3AP0mSPk+pCrze3/gCMlGBUUBFeMuhul7+cSVU1ONRI6ceKFYR4ScQFjgEkYGQcujs9JPJxdO5Ciyg6266TumwL3M2k04JnWGdLAW3ugtUgrLj/iTte9BdYUl03vbzpEmm/kFup2QsIBydWHGS8H/ZKjPhM1dqb7RAsPxUlpynRszj6sRxIIWfJ5uCHP1HXbUci6S3dZj5nZlF+cFnNKLwlVZCLWHPYTTVVbmZgCNsYny7R0yc8yEO+bDkJ6W+qpTclAOgleZDR9JTLkfPAyMf9TjrN/SJ0y5lcvCU1307Ivo9uUgu3I/qUU92DdFyXWT75Ftr6QNMOAA/ldwsLNbHMYEeUXI8jRCeN9RI72sRf6cjPIBRFVPe2i8KeEEGhNFn/e1Afqc1Aak9NGjKtN33vLsolRn4H3Mb0A==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lvKN/KAe8y5uNHxRldfha4LeIjnDaShgNnqOZyufnsqgTNWalQsUMQ+QR6AStciGomai/F7JifZ8Els3vxEFkJQJGbegrMC2/xSvVn/M9vPbp9qHYUNTlEVD1etdV9AzqsyBwI7HrpJxqQLxPzAh3L4k5OSPLicfRQ0Rg+FO9hb7wwunb2skKVBPwCC0z5bxqAMFL9VOSCStlsc9/SZ+RjPvffip8njXcHKnDC6D/6pYEWl13qdDE1Jc2tQNCkeCe80MiCQFiqWolgy4f1GQBXvD8Ik7hpsmxmPEM8WX9V/yBAE8H26iuU5nKt8wfi8cbz48WJyVSu1YGieMWGn4tn0r+YgqGuAaaOP+kyqsgFgPK7tzMZcKAc3nButdReXt7SlWFrhbED3T5gb4h++WX3m2t5ANbmufvABuP8IZjOqjkoApk88HMgtme7GP6Y71
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:46:49.6920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e533c9-61ec-44fa-8b1b-08def3b8c88b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5949

Add support for the hardware FIFO buffer to support high data rate
capture. This includes necessary IIO buffersetup ops, watermark
management and FIFO packet decoding. The accelerometer has 2.25kB FIFO
size. The buffer can be handled via sysfs.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/accel/Kconfig               |   1 +
 drivers/iio/accel/Makefile              |   1 +
 drivers/iio/accel/inv_icm42370.h        |  10 +-
 drivers/iio/accel/inv_icm42370_buffer.c | 504 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/inv_icm42370_buffer.h |  97 ++++++
 drivers/iio/accel/inv_icm42370_core.c   | 209 ++++++++++++-
 6 files changed, 817 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index cef3462e4c79a..ea037134a3ce1 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -491,6 +491,7 @@ config INV_ICM42370
 	tristate
 	select IIO_BUFFER
 	select IIO_INV_SENSORS_TIMESTAMP
+	select IIO_KFIFO_BUF
 
 config INV_ICM42370_I2C
 	tristate "InvenSense ICM-42370 I2C driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 6750b03edf518..939a23793735e 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_IIO_KX022A_SPI)	+= kionix-kx022a-spi.o
 
 obj-$(CONFIG_INV_ICM42370) += inv-icm42370.o
 inv-icm42370-y += inv_icm42370_core.o
+inv-icm42370-y += inv_icm42370_buffer.o
 obj-$(CONFIG_INV_ICM42370_I2C) += inv_icm42370_i2c.o
 
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
diff --git a/drivers/iio/accel/inv_icm42370.h b/drivers/iio/accel/inv_icm42370.h
index 9866a5e970dcd..bd512ebecc3df 100644
--- a/drivers/iio/accel/inv_icm42370.h
+++ b/drivers/iio/accel/inv_icm42370.h
@@ -15,6 +15,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
+#include "inv_icm42370_buffer.h"
+
 enum inv_icm42370_chip {
 	INV_CHIP_INVALID,
 	INV_CHIP_ICM42370,
@@ -252,6 +254,8 @@ static const int inv_icm42370_accel_odr[] = {
 #define INV_ICM42370_REG_INT_STATUS 0x3A
 #define INV_ICM42370_REG_TEMP_CONFIG0 0x34
 #define INV_ICM42370_REG_INTF_CONFIG0 0x35
+#define INV_ICM42370_REG_FIFO_COUNT 0x3D
+#define INV_ICM42370_REG_FIFO_DATA 0x3F
 #define INV_ICM42370_REG_WHO_AM_I 0x75
 #define INV_ICM42370_REG_BLK_SEL_W 0x79
 #define INV_ICM42370_REG_MADDR_W 0x7A
@@ -275,8 +279,8 @@ static const int inv_icm42370_accel_odr[] = {
 	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG3_SPI_MASK, (_rate))
 
 #define INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH BIT(2)
-#define INV_ICM42370_FIFO_CONFIG_MODE_MASK BIT(0)
-#define INV_ICM42370_FIFO_CONFIG_BYPASS_MASK BIT(1)
+#define INV_ICM42370_FIFO_CONFIG_MODE_MASK BIT(1)
+#define INV_ICM42370_FIFO_CONFIG_BYPASS_MASK BIT(0)
 #define INV_ICM42370_FIFO_CONFIG_STREAM \
 	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_MODE_MASK, 0)
 #define INV_ICM42370_FIFO_CONFIG_STOP_ON_FULL \
@@ -361,5 +365,7 @@ int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
 				unsigned int *sleep_ms);
 
 int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev);
+int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr, u8 val);
+int inv_icm42370_mreg_read(struct regmap *map, u8 bank, u8 addr, u8 *val);
 
 #endif
diff --git a/drivers/iio/accel/inv_icm42370_buffer.c b/drivers/iio/accel/inv_icm42370_buffer.c
new file mode 100644
index 0000000000000..a39b8aa4dd9bf
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_buffer.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42370.h"
+#include "inv_icm42370_buffer.h"
+
+/* FIFO header: 1 byte */
+#define INV_ICM42370_FIFO_HEADER_MSG BIT(7)
+#define INV_ICM42370_FIFO_HEADER_ACCEL BIT(6)
+#define INV_ICM42370_FIFO_HEADER_ODR_ACCEL BIT(1)
+
+struct inv_icm42370_fifo_packet_1 {
+	u8 header;
+	struct inv_icm42370_fifo_sensor_data data;
+	s8 temp;
+} __packed;
+
+#define INV_ICM42370_FIFO_PACKET_1_SIZE 8
+
+ssize_t inv_icm42370_fifo_decode_packet(const void *packet, const void **accel,
+					const s8 **temp, const void **timestamp,
+					unsigned int *odr)
+{
+	const struct inv_icm42370_fifo_packet_1 *pack1 = packet;
+	u8 header = *((const u8 *)packet);
+
+	/* FIFO empty */
+	if (header & INV_ICM42370_FIFO_HEADER_MSG) {
+		*accel = NULL;
+		*temp = NULL;
+		*timestamp = NULL;
+		*odr = 0;
+		return 0;
+	}
+
+	/* ODR change flag */
+	*odr = 0;
+	if (header & INV_ICM42370_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM42370_SENSOR_ACCEL;
+
+	/* With TMST_EN disabled, all packets are Packet 1 (8 bytes) */
+	if (header & INV_ICM42370_FIFO_HEADER_ACCEL) {
+		*accel = &pack1->data;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM42370_FIFO_PACKET_1_SIZE;
+	}
+
+	/* invalid or unsupported packet format */
+	return -EINVAL;
+}
+
+void inv_icm42370_buffer_update_fifo_period(struct inv_icm42370_data *st)
+{
+	u32 period_accel;
+
+	if (st->fifo.en & INV_ICM42370_SENSOR_ACCEL)
+		period_accel = inv_icm42370_odr_to_period(st->conf.odr);
+	else
+		period_accel = U32_MAX;
+
+	st->fifo.period = period_accel;
+}
+
+int inv_icm42370_buffer_set_fifo_en(struct inv_icm42370_data *st,
+				    unsigned int fifo_en)
+{
+	u8 mask, val, regval;
+	int ret;
+
+	/* update only FIFO EN bits */
+	mask = INV_ICM42370_FIFO_CONFIG5_ACCEL_EN;
+
+	val = 0;
+	if (fifo_en & INV_ICM42370_SENSOR_ACCEL)
+		val |= INV_ICM42370_FIFO_CONFIG5_ACCEL_EN;
+
+	ret = inv_icm42370_mreg_read(st->map, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_FIFO_CONFIG5, &regval);
+	if (ret)
+		return ret;
+
+	/* clear the mask bits and set the new values */
+	regval &= ~mask;
+	regval |= val;
+
+	ret = inv_icm42370_mreg_write(st->map, INV_ICM42370_MREG1,
+				      INV_ICM42370_REG_FIFO_CONFIG5, regval);
+	if (ret)
+		return ret;
+
+	st->fifo.en = fifo_en;
+	inv_icm42370_buffer_update_fifo_period(st);
+
+	return 0;
+}
+
+static size_t inv_icm42370_get_packet_size(unsigned int fifo_en)
+{
+	/*
+	 * With TMST_EN disabled, the device always produces Packet 1
+	 * (8 bytes: 1 header + 6 accel + 1 temp).
+	 */
+	return INV_ICM42370_FIFO_PACKET_1_SIZE;
+}
+
+static unsigned int inv_icm42370_wm_truncate(unsigned int watermark,
+					     size_t packet_size)
+{
+	size_t wm_size;
+	unsigned int wm;
+
+	wm_size = watermark * packet_size;
+	if (wm_size > INV_ICM42370_FIFO_WATERMARK_MAX)
+		wm_size = INV_ICM42370_FIFO_WATERMARK_MAX;
+
+	wm = wm_size / packet_size;
+
+	return wm;
+}
+
+/**
+ * inv_icm42370_buffer_update_watermark - update watermark FIFO threshold
+ * @st:	driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * FIFO watermark threshold is computed based on the required
+ * watermark values set for accel sensor.
+ */
+int inv_icm42370_buffer_update_watermark(struct inv_icm42370_data *st)
+{
+	size_t packet_size, wm_size;
+	unsigned int wm_accel, watermark;
+	bool restore;
+	__le16 raw_wm;
+	int ret;
+
+	packet_size = inv_icm42370_get_packet_size(st->fifo.en);
+
+	/* compute sensors latency, depending on sensor watermark and odr */
+	wm_accel =
+		inv_icm42370_wm_truncate(st->fifo.watermark.accel, packet_size);
+
+	/* 0 value for watermark means that the sensor is turned off */
+	if (wm_accel == 0)
+		return 0;
+
+	watermark = wm_accel;
+	st->fifo.watermark.eff_accel = wm_accel;
+
+	/* compute watermark value in bytes */
+	wm_size = watermark * packet_size;
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	ret = regmap_update_bits_check(
+		st->map, INV_ICM42370_REG_INT_SOURCE0,
+		INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN, 0, &restore);
+	if (ret)
+		return ret;
+
+	raw_wm = INV_ICM42370_FIFO_WATERMARK_VAL(wm_size);
+	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(st->map, INV_ICM42370_REG_FIFO_WATERMARK,
+				st->buffer, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	/* restore watermark interrupt */
+	if (restore) {
+		ret = regmap_set_bits(
+			st->map, INV_ICM42370_REG_INT_SOURCE0,
+			INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42370_sensor_state *sensor_st = st->sensor_state;
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+
+	pm_runtime_get_sync(dev);
+
+	guard(mutex)
+		(&st->lock);
+	inv_sensors_timestamp_reset(ts);
+
+	return 0;
+}
+
+/**
+ * update_scan_mode callback - turn sensor on and set data FIFO enable bits
+ * @indio_dev: pointer to the industrial io struct
+ *
+ * Return 0 on success, negative errno on error
+ */
+static int inv_icm42370_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)
+		(&st->lock);
+
+	if (st->fifo.on) {
+		st->fifo.on++;
+		return 0;
+	}
+
+	ret = regmap_write(st->map, INV_ICM42370_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42370_REG_FIFO_CONFIG1,
+			   INV_ICM42370_FIFO_CONFIG_STREAM);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(st->map, INV_ICM42370_REG_FIFO_COUNT, st->buffer,
+			       2);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->map, INV_ICM42370_REG_INT_SOURCE0,
+			      INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		return ret;
+
+	st->fifo.on++;
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)
+		(&st->lock);
+
+	if (st->fifo.on > 1) {
+		st->fifo.on--;
+		return 0;
+	}
+
+	/* set FIFO in bypass mode */
+	ret = regmap_write(st->map, INV_ICM42370_REG_FIFO_CONFIG1,
+			   INV_ICM42370_FIFO_CONFIG_BYPASS);
+	if (ret)
+		return ret;
+
+	/* flush FIFO data */
+	ret = regmap_write(st->map, INV_ICM42370_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* disable FIFO threshold interrupt */
+	ret = regmap_clear_bits(st->map, INV_ICM42370_REG_INT_SOURCE0,
+				INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		return ret;
+
+	st->fifo.on--;
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	struct inv_icm42370_sensor_state *sensor_st = st->sensor_state;
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_sensor = 0;
+	unsigned int sleep;
+	int ret;
+
+	if (indio_dev == st->indio_accel) {
+		sensor = INV_ICM42370_SENSOR_ACCEL;
+		watermark = &st->fifo.watermark.accel;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(&st->lock);
+
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
+	ret = inv_icm42370_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
+	if (ret)
+		goto out_unlock;
+
+	*watermark = 0;
+	ret = inv_icm42370_buffer_update_watermark(st);
+	if (ret)
+		goto out_unlock;
+
+	conf.mode = INV_ICM42370_SENSOR_MODE_OFF;
+	ret = inv_icm42370_set_accel_conf(st, &conf, &sleep_sensor);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+
+	/* sleep maximum required time */
+	sleep = max(sleep_sensor, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+const struct iio_buffer_setup_ops inv_icm42370_buffer_ops = {
+	.preenable = inv_icm42370_buffer_preenable,
+	.postenable = inv_icm42370_buffer_postenable,
+	.predisable = inv_icm42370_buffer_predisable,
+	.postdisable = inv_icm42370_buffer_postdisable,
+};
+
+static int inv_icm42370_fifo_read_data(struct inv_icm42370_data *st,
+				       size_t count)
+{
+	return regmap_noinc_read(st->map, INV_ICM42370_REG_FIFO_DATA,
+				 st->fifo.data, count);
+}
+
+int inv_icm42370_buffer_fifo_read(struct inv_icm42370_data *st,
+				  unsigned int max)
+{
+	size_t max_count;
+	__be16 *raw_fifo_count;
+	ssize_t i, size;
+	const void *accel, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	int ret;
+
+	/* reset all samples counters */
+	st->fifo.count = 0;
+	st->fifo.nb.accel = 0;
+	st->fifo.nb.total = 0;
+
+	/* compute maximum FIFO read size */
+	if (max == 0)
+		max_count = sizeof(st->fifo.data);
+	else
+		max_count = max * inv_icm42370_get_packet_size(st->fifo.en);
+
+	/* read FIFO count value */
+	raw_fifo_count = (__be16 *)st->buffer;
+	ret = regmap_bulk_read(st->map, INV_ICM42370_REG_FIFO_COUNT,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+	st->fifo.count = be16_to_cpup(raw_fifo_count);
+
+	/* check and clamp FIFO count value */
+	if (st->fifo.count == 0)
+		return 0;
+	if (st->fifo.count > max_count)
+		st->fifo.count = max_count;
+
+	/* read all FIFO data in internal buffer */
+	ret = inv_icm42370_fifo_read_data(st, st->fifo.count);
+	if (ret)
+		return ret;
+
+	/* compute number of samples for each sensor */
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm42370_fifo_decode_packet(
+			&st->fifo.data[i], &accel, &temp, &timestamp, &odr);
+		if (size <= 0)
+			break;
+		if (accel != NULL && inv_icm42370_fifo_is_data_valid(accel))
+			st->fifo.nb.accel++;
+		st->fifo.nb.total++;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_fifo_parse(struct inv_icm42370_data *st)
+{
+	struct inv_icm42370_sensor_state *accel_st = st->sensor_state;
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	/* handle accelerometer timestamp and FIFO data parsing */
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(
+			ts, st->fifo.watermark.eff_accel, st->timestamp);
+		ret = inv_icm42370_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_hwfifo_flush(struct inv_icm42370_data *st,
+				     unsigned int count)
+{
+	struct inv_icm42370_sensor_state *accel_st = st->sensor_state;
+	struct inv_sensors_timestamp *ts;
+	s64 accel_ts;
+	int ret;
+
+	accel_ts = iio_get_time_ns(st->indio_accel);
+
+	ret = inv_icm42370_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+						accel_ts);
+		ret = inv_icm42370_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_init(struct inv_icm42370_data *st)
+{
+	unsigned int val;
+	u8 regval;
+	int ret;
+
+	st->fifo.watermark.eff_accel = 1;
+
+	/* watermark should be set to a non-zero value before enabling interrupts */
+	st->fifo.watermark.accel = 1;
+	ret = inv_icm42370_buffer_update_watermark(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Default FIFO configuration (bits 6 to 5)
+	 * - FIFO count in bytes
+	 * - FIFO count in big endian
+	 */
+	val = INV_ICM42370_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
+	ret = regmap_update_bits(st->map, INV_ICM42370_REG_INTF_CONFIG0,
+				 GENMASK(6, 5), val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable FIFO partial read interrupt.
+	 * Disable all FIFO EN bits.
+	 */
+	ret = inv_icm42370_mreg_read(st->map, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_FIFO_CONFIG5, &regval);
+	if (ret)
+		return ret;
+
+	regval &= ~(GENMASK(6, 5) | GENMASK(3, 0));
+	regval |= INV_ICM42370_FIFO_CONFIG5_WM_GT_TH;
+	regval |= INV_ICM42370_FIFO_CONFIG5_RESUME_PARTIAL_RD;
+
+	return inv_icm42370_mreg_write(st->map, INV_ICM42370_MREG1,
+				       INV_ICM42370_REG_FIFO_CONFIG5, regval);
+}
diff --git a/drivers/iio/accel/inv_icm42370_buffer.h b/drivers/iio/accel/inv_icm42370_buffer.h
new file mode 100644
index 0000000000000..fb4e002c0067f
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_buffer.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#ifndef INV_ICM42370_BUFFER_H_
+#define INV_ICM42370_BUFFER_H_
+
+#include <linux/kernel.h>
+#include <linux/bits.h>
+
+struct inv_icm42370_data;
+
+#define INV_ICM42370_SENSOR_ACCEL	BIT(1)
+#define INV_ICM42370_SENSOR_TEMP	BIT(2)
+
+/**
+ * struct inv_icm42370_fifo - FIFO state variables
+ * @on:		reference counter for FIFO on.
+ * @en:		bits field of INV_ICM42370_SENSOR_* for FIFO EN bits.
+ * @period:	FIFO internal period.
+ * @watermark:	watermark configuration values for accel.
+ * @count:	number of bytes in the FIFO data buffer.
+ * @nb:		accel and total samples in the FIFO data buffer.
+ * @data:	FIFO data buffer aligned for DMA (2kB + 32 bytes of read cache).
+ */
+struct inv_icm42370_fifo {
+	struct {
+		size_t accel;
+		size_t total;
+	} nb;
+	struct {
+		unsigned int accel;
+		unsigned int eff_accel;
+	} watermark;
+	unsigned int on;
+	unsigned int en;
+	size_t count;
+	u8 data[2080] __aligned(IIO_DMA_MINALIGN);
+	u32 period;
+};
+
+/* FIFO data packet */
+struct inv_icm42370_fifo_sensor_data {
+	__be16 x;
+	__be16 y;
+	__be16 z;
+} __packed;
+#define INV_ICM42370_FIFO_DATA_INVALID		-32768
+
+static inline s16 inv_icm42370_fifo_get_sensor_data(__be16 d)
+{
+	return be16_to_cpu(d);
+}
+
+static inline bool
+inv_icm42370_fifo_is_data_valid(const struct inv_icm42370_fifo_sensor_data *s)
+{
+	s16 x, y, z;
+
+	x = inv_icm42370_fifo_get_sensor_data(s->x);
+	y = inv_icm42370_fifo_get_sensor_data(s->y);
+	z = inv_icm42370_fifo_get_sensor_data(s->z);
+
+	if (x == INV_ICM42370_FIFO_DATA_INVALID &&
+	    y == INV_ICM42370_FIFO_DATA_INVALID &&
+	    z == INV_ICM42370_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+ssize_t inv_icm42370_fifo_decode_packet(const void *packet, const void **accel,
+					const s8 **temp, const void **timestamp,
+					unsigned int *odr);
+
+extern const struct iio_buffer_setup_ops inv_icm42370_buffer_ops;
+
+int inv_icm42370_buffer_init(struct inv_icm42370_data *st);
+
+void inv_icm42370_buffer_update_fifo_period(struct inv_icm42370_data *st);
+
+int inv_icm42370_buffer_set_fifo_en(struct inv_icm42370_data *st,
+				    unsigned int fifo_en);
+
+int inv_icm42370_buffer_update_watermark(struct inv_icm42370_data *st);
+
+int inv_icm42370_buffer_fifo_read(struct inv_icm42370_data *st,
+				  unsigned int max);
+
+int inv_icm42370_buffer_fifo_parse(struct inv_icm42370_data *st);
+
+int inv_icm42370_buffer_hwfifo_flush(struct inv_icm42370_data *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/inv_icm42370_core.c
index 9f6c302e6f331..7107fc7a682dd 100644
--- a/drivers/iio/accel/inv_icm42370_core.c
+++ b/drivers/iio/accel/inv_icm42370_core.c
@@ -15,17 +15,33 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
 
 #include "inv_icm42370.h"
+#include "inv_icm42370_buffer.h"
+
+#define INV_ICM42370_SCAN_MASK_ACCEL_3AXIS				\
+	(BIT(INV_ICM42370_ACCEL_SCAN_X) |				\
+	BIT(INV_ICM42370_ACCEL_SCAN_Y) |				\
+	BIT(INV_ICM42370_ACCEL_SCAN_Z))
+
+#define INV_ICM42370_SCAN_MASK_TEMP	BIT(INV_ICM42370_ACCEL_SCAN_TEMP)
+
+static bool inv_icm42370_is_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return reg == INV_ICM42370_REG_FIFO_DATA;
+}
 
 const struct regmap_config inv_icm42370_regmap_config = {
 	.name = "inv_icm42370",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x7E,
+	.readable_noinc_reg = inv_icm42370_is_noinc_reg,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42370_regmap_config, "IIO_ICM42370");
 
@@ -59,6 +75,18 @@ static const int inv_icm42370_accel_scale[] = {
 	[2 * INV_ICM42370_ACCEL_FS_2G + 1] = 1197101,
 };
 
+/*
+ * IIO buffer layout: must match channel scan types.
+ * Accel: 3 x s16 BE (6 bytes), Temp: 1 x s16 native (2 bytes) = 8 bytes data.
+ * Timestamp: s64 at 8-byte aligned offset.
+ */
+struct inv_icm42370_accel_buffer {
+	struct inv_icm42370_fifo_sensor_data accel;
+	s16 temp;
+
+	s64 timestamp __aligned(8);
+};
+
 /**
  *  inv_icm42370_odr_to_period() - map ODR to Period
  *  @odr - enum of ODR value
@@ -142,7 +170,7 @@ static int inv_icm42370_mreg_check(struct regmap *map)
  *
  * Returns 0 on success, negative errno on error
  */
-static int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr, u8 val)
+int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr, u8 val)
 {
 	int ret;
 
@@ -176,7 +204,7 @@ static int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr, u8 val)
  *
  * Returns 0 on success, negative errno on error
  */
-static int inv_icm42370_mreg_read(struct regmap *map, u8 bank, u8 addr, u8 *val)
+int inv_icm42370_mreg_read(struct regmap *map, u8 bank, u8 addr, u8 *val)
 {
 	int ret;
 	unsigned int read_val;
@@ -424,6 +452,7 @@ static irqreturn_t inv_icm42370_irq_timestamp(int irq, void *_data)
 static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
 {
 	struct inv_icm42370_data *dev_data = _data;
+	struct device *dev = regmap_get_device(dev_data->map);
 	unsigned int status;
 	int ret;
 
@@ -433,6 +462,21 @@ static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
 	if (ret)
 		goto out_unlock;
 
+	if (status & INV_ICM42370_INT_STATUS_FIFO_FULL)
+		dev_warn_ratelimited(dev, "FIFO full data lost!\n");
+
+	if (status & (INV_ICM42370_INT_STATUS_FIFO_THS |
+		      INV_ICM42370_INT_STATUS_FIFO_FULL)) {
+		ret = inv_icm42370_buffer_fifo_read(dev_data, 0);
+		if (ret) {
+			dev_err_ratelimited(dev, "FIFO read error %d\n", ret);
+			goto out_unlock;
+		}
+		ret = inv_icm42370_buffer_fifo_parse(dev_data);
+		if (ret)
+			dev_err_ratelimited(dev, "FIFO parsing error %d\n", ret);
+	}
+
 out_unlock:
 	mutex_unlock(&dev_data->lock);
 	return IRQ_HANDLED;
@@ -499,6 +543,27 @@ static int inv_icm42370_irq_init(struct inv_icm42370_data *data, int irq,
 					 "inv_icm42370", data);
 }
 
+static int inv_icm42370_timestamp_setup(struct inv_icm42370_data *data)
+{
+	u8 val;
+	int ret;
+
+	ret = inv_icm42370_mreg_read(data->map, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_TMST_CONFIG1, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable FIFO timestamp to produce 8-byte Packet 1.
+	 * Host-side timestamps are interpolated from the IRQ timestamp
+	 * and ODR period via inv_sensors_timestamp.
+	 */
+	val &= ~INV_ICM42370_TMST_CONFIG_TMST_EN;
+
+	return inv_icm42370_mreg_write(data->map, INV_ICM42370_MREG1,
+				       INV_ICM42370_REG_TMST_CONFIG1, val);
+}
+
 /*
  * Calibration bias values, IIO range format int + micro.
  * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
@@ -1009,6 +1074,43 @@ static int inv_icm42370_accel_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm42370_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	struct inv_icm42370_sensor_state *accel_st = st->sensor_state;
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_accel = 0;
+	unsigned int sleep;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (*scan_mask & INV_ICM42370_SCAN_MASK_ACCEL_3AXIS) {
+		/* enable accel sensor */
+		conf.mode = st->conf.mode;
+		conf.filter = accel_st->filter;
+		ret = inv_icm42370_set_accel_conf(st, &conf, &sleep_accel);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42370_SENSOR_ACCEL;
+	}
+
+	/* update data FIFO write */
+	ret = inv_icm42370_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/* sleep maximum required time */
+	sleep = max(sleep_accel, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
 /**
  * inv_icm42370_accel_read_sensor() - internal function to read accelerometer sensor registers
  *
@@ -1117,9 +1219,48 @@ static int inv_icm42370_accel_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int inv_icm42370_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	ret = inv_icm42370_buffer_update_watermark(st);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int inv_icm42370_accel_hwfifo_flush(struct iio_dev *indio_dev,
+					   unsigned int count)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42370_buffer_hwfifo_flush(st, count);
+	if (!ret)
+		ret = st->fifo.nb.accel;
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42370_info = {
 	.read_raw = inv_icm42370_accel_read_raw,
 	.write_raw = inv_icm42370_accel_write_raw,
+	.update_scan_mode = inv_icm42370_accel_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42370_accel_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42370_accel_hwfifo_flush,
 };
 
 struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
@@ -1131,6 +1272,8 @@ struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
 
 	data->sensor_state->scales = inv_icm42370_accel_scale;
 	data->sensor_state->scales_len = ARRAY_SIZE(inv_icm42370_accel_scale);
+	data->sensor_state->filter = data->conf.filter;
+	data->sensor_state->power_mode = data->conf.mode;
 
 	/*
 	 * clock period is 32kHz (31250ns)
@@ -1143,10 +1286,15 @@ struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
 
 	indio_dev->name = "inv_icm42370";
 	indio_dev->info = &inv_icm42370_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_ALL_BUFFER_MODES;
 	indio_dev->channels = inv_icm42370_accel_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42370_accel_channels);
 
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  &inv_icm42370_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ERR_PTR(ret);
@@ -1154,6 +1302,53 @@ struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
 	return indio_dev;
 }
 
+int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	struct inv_icm42370_sensor_state *accel_st = st->sensor_state;
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	s64 ts_val;
+	struct inv_icm42370_accel_buffer buffer = {};
+
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm42370_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &temp, &timestamp, &odr);
+		if (size <= 0)
+			return size;
+
+		if (accel == NULL || !inv_icm42370_fifo_is_data_valid(accel))
+			continue;
+
+		if (odr & INV_ICM42370_SENSOR_ACCEL)
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
+
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+
+		/*
+		 * FIFO 8-bit temp has sensitivity ~2 LSB/°C.
+		 * Register 16-bit temp has sensitivity 128 LSB/°C.
+		 * Scale factor: 128 / 2 = 64.
+		 * This lets the IIO scale (1000/128) and offset (3200) work
+		 * correctly for both register reads and FIFO data.
+		 */
+		if (temp)
+			buffer.temp = (s16)*temp * 64;
+		else
+			buffer.temp = (s16)INV_ICM42370_DATA_INVALID;
+
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+	}
+
+	return 0;
+}
+
 /**
  * inv_icm42370_core_probe() - initialize and register the ICM-42370 device
  * @regmap:	register map for accessing the device's registers.
@@ -1222,6 +1417,14 @@ int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
 	if (ret)
 		return dev_err_probe(dev, ret, "Setup failed\n");
 
+	ret = inv_icm42370_timestamp_setup(data);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42370_buffer_init(data);
+	if (ret)
+		return ret;
+
 	data->indio_accel = inv_icm42370_accel_init(indio_dev, data);
 	if (IS_ERR(data->indio_accel))
 		return PTR_ERR(data->indio_accel);

-- 
2.43.0

