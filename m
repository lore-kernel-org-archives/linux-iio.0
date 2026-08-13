Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466613E51F4;
	Thu, 13 Aug 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623993; cv=fail; b=VpxMWsnL3mo812jjoRsl2tWCmjxQ3y0HsOAb1u9yH8rtgV6BGqarE3+xcckb+nMkdejAOJrh6gXxcOtBAwxzm7Cs6xbBEgb+HAxKhXbdb8EPRWpZG0lu77qzeMFyfwF7UuPw963GEdxRfe/ydfy88bQcOjtzdzM1ysNH25oVrbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623993; c=relaxed/simple;
	bh=MIJjb3Z2bFkC6bKCEVdaMPlv7LknEfhTlDWuNASSZws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EbOa2M/SR7YHMzU3WlJhkmQKpSKheyIZVPnC8qSrrey4TITXq2yvjLTfyPVLEWwLrvBWap7WBCWsiWrRj7l03eymCRh9nN6DPDQvjUk/KD/JbKMK1Ky7QLkRzNB4rg4kWEwbmlswYcofKSwlIwKe1Jdcc/WTp7nVwKgMYL726Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qj+WmSjT; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qj+WmSjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li06BpUOtL3gVnvQ3YlSUTQ+wgadd1XPLFLkZFU53nA5sIQTe64bgoXH/ityBHn+J0NZSWbrZvBLRjSu0hXUUEeEpnF7mgy1mYOPTsXAW2KYOQ6omYPPFqvMVASjAREtLXpFr+topGjJesFbPEvIr7EPynUVYfKzSpxIu5vAXkG/3SB8OHkKL478lKkTohTIQ/4mtCsuYp91C6FPXPFJEfP8+rHZLKk8I9fJ3BFUyuJjGYEgFCd0lU2q9JIfBhgFnItqq9ENTz/007BySwez6WSNWrZ/MNKSwW6siNvgEbxVQiBpY5XwI1wteKQf/ARil+qZLgIkrafVYIVuCCL10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v32omL7pUucYlSeys56rjx7N1sOUnBEB/LUWcwcYsrw=;
 b=LTiGfnoQkNwUGpsRQKWWbbN/36a/pFk5i3y/6Y5BEw3jiNO/6MmJWra6XAxMgzjSNCxxpoDqyvPtYZLkt98e6UKFWf+hK5ueUhMw8836vrr+civgprDyrlEUyOTLxQ3G28y3QNndtpZYMfuE8Piz6638vMVvWx3UdCGQzcWscSdS+1qbfvqVGl+jcKk84GHckFa6xYBnBafAH0thMJZAlpIyjLKafHQVDxcsbonrGxXV8lYkXW0NYFeAU3l0zu5g0F9VusOoC9jNAKsGZ8k7EZWegEFMkUe6WUFMHQyZvUghrMJEIjtWA+z9DNgU5vb2VzOKPwi6pDJ4A+ZLJ5rWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v32omL7pUucYlSeys56rjx7N1sOUnBEB/LUWcwcYsrw=;
 b=qj+WmSjTL764QdGhD4mPWScm4h4w8grdlS/8uYZ2iX9sHPZgPa3KcHKdrQuR/8HdbGHvnkTnCvFD76Bg0y0pXYASfLhf6OTSDX5sUQc97kqfd5X/Ul2+OGVLpOixi/D2cVht/lklS35fIScXlKI6m/0MDBx1TN/M8icKEzSzCk8=
Received: from DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) by DB9PR02MB9993.eurprd02.prod.outlook.com
 (2603:10a6:10:45c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:26:27 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::af) by DUZPR01CA0076.outlook.office365.com
 (2603:10a6:10:46a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 12:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 12:26:26 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 13 Aug
 2026 14:26:25 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 13 Aug 2026 14:26:25 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 035572DC7;
	Thu, 13 Aug 2026 14:26:25 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id E4CDF3069E13; Thu, 13 Aug 2026 14:26:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 13 Aug 2026 14:26:12 +0200
Subject: [PATCH v2 3/3] iio: accel: icm42370: Add FIFO buffer functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260813-b4-inv_icm42370p-v2-3-11aedfdf76d3@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
In-Reply-To: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=29098;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=MIJjb3Z2bFkC6bKCEVdaMPlv7LknEfhTlDWuNASSZws=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJqt3/wFv6cLZa+1KP+TqB936243y7WswSyM628Hnh93
 sm7L565o5SFQYyLQVZMkSUyp6Hafa1X0r2iqNMwc1iZQIYwcHEKwESm6DAy7K2Vv31Ks4YjkW3q
 m65Fy08Vm73cfd13QYvqwm2KuwSXrmVkmCjsuZpDZMmbb3XXORdc5TssFpJaN1+WlSkw5p4Ac58
 UHwA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|DB9PR02MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: b81c5ec5-c45b-4188-aac7-08def9361854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|56012099006|18002099003|22082099003|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZskxJti4i5CBWtgh6bxwUJ/CW7Ww0EN+sCoMLAc5ghzbyK1zoxwoE2rWjuJFPQPxR0NDjlMVQHHD63XX9oizb1EUNY8X/4fHpxpdIO+PRAOZwUtepDBfgCiIeJNWSgCb4LWhy9Gz8aMvP2iGNJXsKM7S0B9dWoMX70qmXreSt34gLp7wugw5CCaEmDey6ZiM/yBaQwKqFLREJbYJ5LfS91AXn7dqXKVq/JZMhBGXudzPGVdMjSqUnN31bxeD9Xh/dBt95VdLpGtL27b1fvqs9YL8rE7SvS3cTXdMPvlJ6v5jEka3pnwFcKgKRGhntOOEmDSMcZpdUmIEqfHFR1GjG6eJ8zvbEuirL15ds+3q7rOzXuoWPf+q5mKLKEOFLgzQLUtr9H7l/VeySsigRdvuHxLCvq9B/EkzyG/iF04LQGjQMl/nnu8rgDinOlEHsvi2W0KfOW/TECMT7EpYJndjfzp1JTQQBqx3JAxbES2WO1gsbZDSIjW7eJwjbnUOY7iQhJweeYlmw46DCIwk/IYoXqMJShVc5PyfnAXV7ToVENV6FZpRsfWHEFcnxW6fZh2GWEBKI3tMarzlP3KoL7Q8UFbw22MMfFylcX3FMy6nkB4xE+bh6AWb92fhIc2sRK+iF8K14GbcWyAsu5O4h1G7khWwWd+zBTWPDY7jtOoOXxe8BFjOlj7+Gk8tCuKTpEbvSifmquwBxcZ7M+AHD+TxfA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oFz5u5f60m8lzFI9RHIEEHiCNhJMbl/rtKXfWQ+AFM1UB6B9UuC4PH5YygzXBKEU4rel0t21dLO9JjrOuClWvcNRpi5RPsF+92j6bRW/onUtUTNNXgp9MyX2SlCTAmbUmCVZ0OWGmzRHpqrAJHvjBS7CuBurgl0wA2eafJBuDV6xv35SIFDJw8ZCN+o1N+noATBaIvZGAjZAjNHJ57yFMC9qaF0UIY7tAFtSGeskHkLYOShl0AkRT8Ps7oxWiJXv2sI4aPrBsXwnGMjiKF9O3vLuDZ63LMHBgag4053xZANRA459RmtLhyMZr2dqEX6MWHUrAvuvakZ0CstWKVtJTdCGnQAWbgOQAy1OYr2rLN+nNPoeZeuBuQyj/1GaYf9r4/HZN7UU11nqEwUdQ0qO0bEKB68HNxivPasUQby/r/NqcfxxjKPnnyIDLnDZH2XB
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:26:26.4430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81c5ec5-c45b-4188-aac7-08def9361854
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9993

Add support for the hardware FIFO buffer to support high data rate
capture. This includes necessary IIO buffer setup ops, watermark
management and FIFO packet decoding. The accelerometer has 2.25kB FIFO
size. The buffer can be handled via sysfs.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/accel/Kconfig               |   1 +
 drivers/iio/accel/Makefile              |   1 +
 drivers/iio/accel/inv_icm42370.h        |   6 +
 drivers/iio/accel/inv_icm42370_buffer.c | 496 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/inv_icm42370_buffer.h | 100 +++++++
 drivers/iio/accel/inv_icm42370_core.c   | 206 ++++++++++++-
 6 files changed, 809 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 3ac2534c1c76d..a8dc5692db9d9 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -491,6 +491,7 @@ config INV_ICM42370
 	tristate
 	select IIO_BUFFER
 	select IIO_INV_SENSORS_TIMESTAMP
+	select IIO_KFIFO_BUF
 
 config INV_ICM42370_I2C
 	tristate "InvenSense ICM-42370-P I2C driver"
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
index a4a822f04355f..5df5876169cc9 100644
--- a/drivers/iio/accel/inv_icm42370.h
+++ b/drivers/iio/accel/inv_icm42370.h
@@ -17,6 +17,7 @@
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 
+#include "inv_icm42370_buffer.h"
 
 #define INV_ICM42370_SENSOR_CONF_INIT { -1, -1, -1, -1 }
 
@@ -45,6 +46,8 @@
 #define INV_ICM42370_REG_INT_STATUS 0x3A
 #define INV_ICM42370_REG_TEMP_CONFIG0 0x34
 #define INV_ICM42370_REG_INTF_CONFIG0 0x35
+#define INV_ICM42370_REG_FIFO_COUNT 0x3D
+#define INV_ICM42370_REG_FIFO_DATA 0x3F
 #define INV_ICM42370_REG_WHO_AM_I 0x75
 #define INV_ICM42370_REG_BLK_SEL_W 0x79
 #define INV_ICM42370_REG_MADDR_W 0x7A
@@ -199,6 +202,7 @@ enum inv_icm42370_accel_scan {
 	INV_ICM42370_ACCEL_SCAN_Y,
 	INV_ICM42370_ACCEL_SCAN_Z,
 	INV_ICM42370_ACCEL_SCAN_TEMP,
+	INV_ICM42370_ACCEL_SCAN_TIMESTAMP,
 };
 
 enum inv_icm42370_sensor_mode {
@@ -286,6 +290,7 @@ struct inv_icm42370_conf {
  * @indio_accel:	accelerometer IIO device.
  * @timestamp:		interrupt timestamp.
  * @orientation:	sensor chip orientation relative to main hardware.
+ * @fifo:		FIFO state and configuration.
  * @chip:		chip identifier.
  * @conf:		chip sensors configurations.
  * @filter:		sensor filter.
@@ -303,6 +308,7 @@ struct inv_icm42370_data {
 	struct iio_dev *indio_accel;
 	s64 timestamp;
 	struct iio_mount_matrix orientation;
+	struct inv_icm42370_fifo fifo;
 	enum inv_icm42370_chip chip;
 	struct inv_icm42370_conf conf;
 	enum inv_icm42370_filter filter;
diff --git a/drivers/iio/accel/inv_icm42370_buffer.c b/drivers/iio/accel/inv_icm42370_buffer.c
new file mode 100644
index 0000000000000..c6a4d313c92c5
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_buffer.c
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+
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
+void inv_icm42370_buffer_update_fifo_period(struct inv_icm42370_data *data)
+{
+	u32 period_accel;
+
+	if (data->fifo.en & INV_ICM42370_SENSOR_ACCEL)
+		period_accel = inv_icm42370_odr_to_period(data->conf.odr);
+	else
+		period_accel = U32_MAX;
+
+	data->fifo.period = period_accel;
+}
+
+int inv_icm42370_buffer_set_fifo_en(struct inv_icm42370_data *data,
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
+	ret = inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_FIFO_CONFIG5, &regval);
+	if (ret)
+		return ret;
+
+	/* clear the mask bits and set the new values */
+	regval &= ~mask;
+	regval |= val;
+
+	ret = inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
+				      INV_ICM42370_REG_FIFO_CONFIG5, regval);
+	if (ret)
+		return ret;
+
+	data->fifo.en = fifo_en;
+	inv_icm42370_buffer_update_fifo_period(data);
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
+ * @data:	driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * FIFO watermark threshold is computed based on the required
+ * watermark values set for accel sensor.
+ */
+int inv_icm42370_buffer_update_watermark(struct inv_icm42370_data *data)
+{
+	size_t packet_size, wm_size;
+	unsigned int wm, watermark;
+	bool restore;
+	__le16 raw_wm;
+	int ret;
+
+	packet_size = inv_icm42370_get_packet_size(data->fifo.en);
+
+	/* compute sensors latency, depending on sensor watermark and odr */
+	wm = inv_icm42370_wm_truncate(data->fifo.watermark.accel, packet_size);
+
+	/* 0 value for watermark means that the sensor is turned off */
+	if (wm == 0)
+		return 0;
+
+	watermark = wm;
+	data->fifo.watermark.eff_accel = wm;
+
+	/* compute watermark value in bytes */
+	wm_size = watermark * packet_size;
+
+	/* changing FIFO watermark requires to turn off watermark interrupt */
+	ret = regmap_update_bits_check(
+		data->map, INV_ICM42370_REG_INT_SOURCE0,
+		INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN, 0, &restore);
+	if (ret)
+		return ret;
+
+	raw_wm = INV_ICM42370_FIFO_WATERMARK_VAL(wm_size);
+	memcpy(data->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(data->map, INV_ICM42370_REG_FIFO_WATERMARK,
+				data->buffer, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	/* restore watermark interrupt */
+	if (restore) {
+		ret = regmap_set_bits(
+			data->map, INV_ICM42370_REG_INT_SOURCE0,
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
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->map);
+	struct inv_sensors_timestamp *ts = &data->ts;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->lock);
+
+	inv_sensors_timestamp_reset(ts);
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Exit if FIFO is already on. */
+	if (data->fifo.on) {
+		data->fifo.on++;
+		return 0;
+	}
+
+	ret = regmap_write(data->map, INV_ICM42370_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->map, INV_ICM42370_REG_FIFO_CONFIG1,
+			   INV_ICM42370_FIFO_CONFIG_STREAM);
+	if (ret)
+		return ret;
+
+	/* when FIFO_CONFIG_STREAM bit is set FIFO is enabled, so
+	 * increase the count
+	 */
+	data->fifo.on++;
+
+	ret = regmap_bulk_read(data->map, INV_ICM42370_REG_FIFO_COUNT, data->buffer,
+			       2);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(data->map, INV_ICM42370_REG_INT_SOURCE0,
+			      INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Exit if there are several sensors using the FIFO. */
+	if (data->fifo.on > 1) {
+		data->fifo.on--;
+		return 0;
+	}
+
+	/* set FIFO in bypass mode */
+	ret = regmap_write(data->map, INV_ICM42370_REG_FIFO_CONFIG1,
+			   INV_ICM42370_FIFO_CONFIG_BYPASS);
+	if (ret)
+		return ret;
+
+	/* when FIFO is bypassed it gets disabled, so reduce the
+	 * count
+	 */
+	data->fifo.on--;
+
+	/* flush FIFO data */
+	ret = regmap_write(data->map, INV_ICM42370_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* disable FIFO threshold interrupt */
+	ret = regmap_clear_bits(data->map, INV_ICM42370_REG_INT_SOURCE0,
+				INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int inv_icm42370_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &data->ts;
+	struct device *dev = regmap_get_device(data->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_sensor = 0;
+	unsigned int sleep;
+	int ret;
+
+	if (indio_dev == data->indio_accel) {
+		sensor = INV_ICM42370_SENSOR_ACCEL;
+		watermark = &data->fifo.watermark.accel;
+	} else {
+		return -EINVAL;
+	}
+
+	guard(mutex)(&data->lock);
+
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
+	ret = inv_icm42370_buffer_set_fifo_en(data, data->fifo.en & ~sensor);
+	if (ret)
+		goto out_unlock;
+
+	*watermark = 0;
+	ret = inv_icm42370_buffer_update_watermark(data);
+	if (ret)
+		goto out_unlock;
+
+	conf.mode = INV_ICM42370_SENSOR_MODE_OFF;
+	ret = inv_icm42370_set_accel_conf(data, &conf, &sleep_sensor);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
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
+int inv_icm42370_buffer_fifo_read(struct inv_icm42370_data *data,
+				  unsigned int max)
+{
+	const ssize_t packet_size = sizeof(struct inv_icm42370_fifo_packet_1);
+	__be16 *raw_fifo_count;
+	size_t fifo_nb, i;
+	ssize_t size;
+	const void *accel, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	int ret;
+
+	/* reset all samples counters */
+	data->fifo.count = 0;
+	data->fifo.nb.accel = 0;
+	data->fifo.nb.total = 0;
+
+	raw_fifo_count = (__be16 *)data->buffer;
+	ret = regmap_bulk_read(data->map, INV_ICM42370_REG_FIFO_COUNT,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+
+	/* Check and limit number of samples if requested. */
+	fifo_nb = le16_to_cpup(raw_fifo_count);
+	if (fifo_nb == 0)
+		return 0;
+	if (max > 0 && fifo_nb > max)
+		fifo_nb = max;
+
+	/*
+	 * Read all FIFO data into the internal buffer, clamping the
+	 * device-reported count to the buffer capacity.
+	 */
+	data->fifo.count = min(fifo_nb * packet_size, INV_ICM42370_FIFO_SIZE_MAX);
+	ret = regmap_noinc_read(data->map, INV_ICM42370_REG_FIFO_DATA,
+				data->fifo.data, data->fifo.count);
+	if (ret == -EOPNOTSUPP || ret == -EFBIG) {
+		/* Read full fifo is not supported, read samples one by one. */
+		ret = 0;
+		for (i = 0; i < data->fifo.count && ret == 0; i += packet_size)
+			ret = regmap_noinc_read(data->map, INV_ICM42370_REG_FIFO_DATA,
+						&data->fifo.data[i], packet_size);
+	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < data->fifo.count; i += size) {
+		size = inv_icm42370_fifo_decode_packet(
+			&data->fifo.data[i], &accel, &temp, &timestamp, &odr);
+		if (size <= 0)
+			/* No more sample in buffer */
+			break;
+		if (accel && inv_icm42370_fifo_is_data_valid(accel))
+			data->fifo.nb.accel++;
+		data->fifo.nb.total++;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_fifo_parse(struct inv_icm42370_data *data)
+{
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (data->fifo.nb.total == 0)
+		return 0;
+
+	/* handle accelerometer timestamp and FIFO data parsing */
+	if (data->fifo.nb.accel > 0) {
+		ts = &data->ts;
+		inv_sensors_timestamp_interrupt(
+			ts, data->fifo.watermark.eff_accel, data->timestamp);
+		ret = inv_icm42370_accel_parse_fifo(data->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_hwfifo_flush(struct inv_icm42370_data *data,
+				     unsigned int count)
+{
+	struct inv_sensors_timestamp *ts;
+	s64 accel_ts;
+	int ret;
+
+	accel_ts = iio_get_time_ns(data->indio_accel);
+
+	ret = inv_icm42370_buffer_fifo_read(data, count);
+	if (ret)
+		return ret;
+
+	if (data->fifo.nb.total == 0)
+		return 0;
+
+	if (data->fifo.nb.accel > 0) {
+		ts = &data->ts;
+		inv_sensors_timestamp_interrupt(ts, data->fifo.nb.accel,
+						accel_ts);
+		ret = inv_icm42370_accel_parse_fifo(data->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm42370_buffer_init(struct inv_icm42370_data *data)
+{
+	unsigned int val;
+	u8 regval;
+	int ret;
+
+	data->fifo.watermark.eff_accel = 1;
+
+	/* watermark should be set to a non-zero value before enabling interrupts */
+	data->fifo.watermark.accel = 1;
+	ret = inv_icm42370_buffer_update_watermark(data);
+	if (ret)
+		return ret;
+
+	/*
+	 * Default FIFO configuration (bits 6 to 5)
+	 * - FIFO count in bytes
+	 * - FIFO count in big endian
+	 */
+	val = INV_ICM42370_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
+	ret = regmap_update_bits(data->map, INV_ICM42370_REG_INTF_CONFIG0,
+				 GENMASK(6, 5), val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable FIFO partial read interrupt.
+	 * Disable all FIFO EN bits.
+	 */
+	ret = inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_FIFO_CONFIG5, &regval);
+	if (ret)
+		return ret;
+
+	regval &= ~(GENMASK(6, 5) | GENMASK(3, 0));
+	regval |= INV_ICM42370_FIFO_CONFIG5_WM_GT_TH;
+	regval |= INV_ICM42370_FIFO_CONFIG5_RESUME_PARTIAL_RD;
+
+	return inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
+				       INV_ICM42370_REG_FIFO_CONFIG5, regval);
+}
diff --git a/drivers/iio/accel/inv_icm42370_buffer.h b/drivers/iio/accel/inv_icm42370_buffer.h
new file mode 100644
index 0000000000000..d43a4209a5640
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_buffer.h
@@ -0,0 +1,100 @@
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
+#define INV_ICM42370_SENSOR_ACCEL	BIT(1)
+#define INV_ICM42370_SENSOR_TEMP	BIT(2)
+
+/* 2.25kB buffer size */
+#define INV_ICM42370_FIFO_SIZE_MAX	0x900
+#define INV_ICM42370_FIFO_DATA_INVALID		-32768
+
+struct inv_icm42370_data;
+
+/**
+ * struct inv_icm42370_fifo - FIFO state variables
+ * @on:		reference counter for FIFO on.
+ * @en:		bits field of INV_ICM42370_SENSOR_* for FIFO EN bits.
+ * @period:	FIFO internal period.
+ * @watermark:	watermark configuration values for accel.
+ * @count:	number of bytes in the FIFO data buffer.
+ * @nb:		accel and total samples in the FIFO data buffer.
+ * @data:	FIFO data buffer aligned for DMA.
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
+	u32 period;
+	u8 *data __aligned(IIO_DMA_MINALIGN);
+};
+
+/* FIFO data packet */
+struct inv_icm42370_fifo_sensor_data {
+	__be16 x;
+	__be16 y;
+	__be16 z;
+} __packed;
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
+int inv_icm42370_buffer_init(struct inv_icm42370_data *data);
+
+void inv_icm42370_buffer_update_fifo_period(struct inv_icm42370_data *data);
+
+int inv_icm42370_buffer_set_fifo_en(struct inv_icm42370_data *data,
+				    unsigned int fifo_en);
+
+int inv_icm42370_buffer_update_watermark(struct inv_icm42370_data *data);
+
+int inv_icm42370_buffer_fifo_read(struct inv_icm42370_data *data,
+				  unsigned int max);
+
+int inv_icm42370_buffer_fifo_parse(struct inv_icm42370_data *data);
+
+int inv_icm42370_buffer_hwfifo_flush(struct inv_icm42370_data *data,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/inv_icm42370_core.c
index 6266362e83f6a..b1713a2f533c8 100644
--- a/drivers/iio/accel/inv_icm42370_core.c
+++ b/drivers/iio/accel/inv_icm42370_core.c
@@ -20,10 +20,25 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 
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
 
 #define INV_ICM42370_SUSPEND_DELAY_MS 2000
 
@@ -32,6 +47,7 @@ const struct regmap_config inv_icm42370_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x7E,
+	.readable_noinc_reg = inv_icm42370_is_noinc_reg,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42370_regmap_config, "IIO_ICM42370");
 
@@ -57,6 +73,7 @@ static const struct iio_chan_spec inv_icm42370_accel_channels[] = {
 	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42370_ACCEL_SCAN_Z,
 				inv_icm42370_accel_ext_infos),
 	INV_ICM42370_TEMP_CHAN(INV_ICM42370_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42370_ACCEL_SCAN_TIMESTAMP),
 };
 
 /* IIO format int + nano */
@@ -75,6 +92,18 @@ static const int inv_icm42370_accel_scale[] = {
 	[2 * INV_ICM42370_ACCEL_FS_2G + 1] = 598550,
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
  *
@@ -431,6 +460,7 @@ static irqreturn_t inv_icm42370_irq_timestamp(int irq, void *_data)
 static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
 {
 	struct inv_icm42370_data *data = _data;
+	struct device *dev = regmap_get_device(data->map);
 	unsigned int status;
 	int ret;
 
@@ -440,6 +470,21 @@ static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
 	if (ret)
 		return IRQ_HANDLED;
 
+	if (status & INV_ICM42370_INT_STATUS_FIFO_FULL)
+		dev_warn_ratelimited(dev, "FIFO full data lost!\n");
+
+	if (status & (INV_ICM42370_INT_STATUS_FIFO_THS |
+		      INV_ICM42370_INT_STATUS_FIFO_FULL)) {
+		ret = inv_icm42370_buffer_fifo_read(data, 0);
+		if (ret) {
+			dev_err_ratelimited(dev, "FIFO read error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+		ret = inv_icm42370_buffer_fifo_parse(data);
+		if (ret)
+			dev_err_ratelimited(dev, "FIFO parsing error %d\n", ret);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -505,6 +550,27 @@ static int inv_icm42370_irq_init(struct inv_icm42370_data *data, int irq,
 					 "inv_icm42370", data);
 }
 
+static int inv_icm42370_timestamp_setup(struct inv_icm42370_data *data)
+{
+	u8 val;
+	int ret;
+
+	ret = inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
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
+	return inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
+				       INV_ICM42370_REG_TMST_CONFIG1, val);
+}
+
 /*
  * Calibration bias values, IIO range format int + micro.
  * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
@@ -990,6 +1056,8 @@ static int inv_icm42370_accel_write_odr(struct iio_dev *indio_dev, int val,
 	if (ret)
 		return ret;
 
+	inv_icm42370_buffer_update_fifo_period(data);
+
 	return 0;
 }
 
@@ -1039,6 +1107,40 @@ static int inv_icm42370_accel_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm42370_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_accel = 0;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	if (*scan_mask & INV_ICM42370_SCAN_MASK_ACCEL_3AXIS) {
+		/* enable accel sensor */
+		conf.mode = st->conf.mode;
+		conf.filter = st->filter;
+
+		ret = inv_icm42370_set_accel_conf(st, &conf, &sleep_accel);
+		if (ret)
+			goto out;
+
+		fifo_en |= INV_ICM42370_SENSOR_ACCEL;
+	}
+
+	/* update data FIFO write */
+	ret = inv_icm42370_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+
+out:
+	if (sleep_accel)
+		msleep(sleep_accel);
+
+	return ret;
+}
+
 /**
  * inv_icm42370_accel_read_sensor() - internal function to read accelerometer sensor registers
  *
@@ -1161,15 +1263,54 @@ static int inv_icm42370_accel_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int inv_icm42370_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm42370_data *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	ret = inv_icm42370_buffer_update_watermark(st);
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
 					struct inv_icm42370_data *data)
 {
+	struct device *dev = regmap_get_device(data->map);
 	struct inv_sensors_timestamp_chip ts_chip;
+	int ret;
 
 	data->scales = inv_icm42370_accel_scale;
 	data->scales_len = ARRAY_SIZE(inv_icm42370_accel_scale);
@@ -1187,13 +1328,64 @@ struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
 
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
 	return indio_dev;
 }
 
+int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &data->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	s64 ts_val;
+	struct inv_icm42370_accel_buffer buffer = {};
+
+	for (i = 0, no = 0; i < data->fifo.count; i += size, ++no) {
+		size = inv_icm42370_fifo_decode_packet(&data->fifo.data[i],
+				&accel, &temp, &timestamp, &odr);
+		if (size <= 0)
+			return size;
+
+		if (accel == NULL || !inv_icm42370_fifo_is_data_valid(accel))
+			continue;
+
+		if (odr & INV_ICM42370_SENSOR_ACCEL)
+			inv_sensors_timestamp_apply_odr(ts, data->fifo.period,
+							data->fifo.nb.total, no);
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
@@ -1242,6 +1434,10 @@ int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
 
 	data = iio_priv(indio_dev);
 
+	data->fifo.data = devm_kzalloc(dev, INV_ICM42370_FIFO_SIZE_MAX, GFP_KERNEL);
+	if (!data->fifo.data)
+		return -ENOMEM;
+
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to initialize mutex\n");
@@ -1267,6 +1463,14 @@ int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
 		return ret;
 	}
 
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

