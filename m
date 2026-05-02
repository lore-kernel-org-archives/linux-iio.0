Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547A339705;
	Sat,  2 May 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720828; cv=fail; b=sYH+w7Sxn9ojZ0ZzzBRxhLCOiaSkqlXc3un13RddUvF2/fkNjQEptlG33okKmh4+NoqKst+NwQJnTAS739vVso9mgRXUXrKglnSlh487D/uotsABLo/pxNLL64QE0B5dPBIOfuc5nl+416XcQ8rJ1enIslQNm2Fw4FQju8Cx8iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720828; c=relaxed/simple;
	bh=Z4EomQrwkKsrAS7nJafMARpjsaGQfSJK0/t+ks3+7TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiMMTpv2ZVJsp8UoV1EpL0YjXaC9SQWfE1E/OiCMtpMB2LH6g7sht1JcQbhMXPHX8tdFgl/NBMJf2zQcWzDPWVHKNMPPyzfwR/8+PTa/rdC8kbFRiUoFzPfokej0FEKIh1OfjF3AtaQ4KzH5b13QJiYlld5EatGlX7DFT9zGLZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u+O16P7E; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u+O16P7E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTjA8qHc6Oy31TX4GH7zeWCvhNGexougrZJJUWDULjqKaSdFhy1KPgp2SQ5bSYFf4oaZwN6HGBeOUX8qSb1owltPoI8NWNDzfN2k1YpW+MsYry9SKN5vAXalyhkX6f62VCTmohozodpzvEn21Z47kwADvxdL1l0yc5zebKDZYlx/Cwixry1YlKVo7VfDjBs/uwsigSPuLZMt2fmxP0DwHrBK2ng1cdiaknx4BAASVtKTR5AKGWisijGwD+SMH4A7E2Z4OqQW2v37YmmfNldSU66fx04EseMsK12n39H3mogbZ+Fg9xfh9PYpdnbr1WF+e4OmDSNB14f5rT8gCEZS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28GyzQ+m1ozd/eaBkBcuCjwhyFQay2rjbqrIh6Dyqwk=;
 b=k2wesWuDdhVKN9uKsxLEDQYdxtOD8o/ZtkK2wHPVPUNkJ9UwKbSGeLxHr0yfcMeErve6OfP4aqdovnSxWQPVNi6DjgEp8Rgy7QRIyQchTeI21p7tgaqPfXZ28zZ6xrUnrclvHberOjhiikS08F4ohdS4DrTkYXWdMO3Rl4ls6XRAg1QqkkJeuSQR0nfRTYuQoNhu5K19+SErAb91rfQAWjsSRdhChT24RnzpNyePPHs/1OAhyyZCZFqbtdebVtgeJE+Z7f0IhULcEg3si5gKrl84o4imWuarOxARA4jgWPN1+C9ez6r7draaM9kown8Q/Wp+45BcHMjAinIE3iwzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28GyzQ+m1ozd/eaBkBcuCjwhyFQay2rjbqrIh6Dyqwk=;
 b=u+O16P7EtKbGyuXujJxNVuBfIwS8mabqQQ7ncBaEBw4FLKnORPDqudi4vJ3nshzh/D1VmzvId5Kg9NgxI5f9nkmgZvzrQ3oRWL+kxLwJ+x9ceHUjZuHpiaUM0XaXLmq4sgELkRJ7vnxu7fnRUm/Y/1bHacfKiZL1pEQFVJfD+zU=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.24; Sat, 2 May
 2026 11:20:18 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ec) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 11:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 11:20:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:13 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:12 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Sat, 2 May 2026 12:19:50 +0100
Message-ID: <20260502111951.538488-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260502111951.538488-1-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: db56efc8-194f-4232-b514-08dea83ccad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1IGyXkJL5BN0eGGNZF72xsXI6GMfXAIf/654EgGDWVz5fOXtw7oCIhKr0kRLbKxUHICjqDWK2U6GOKQYE8F/QBbJIk8Lnady1IuhcgYVMf5MP7M7sRkk25sY9hlnoqAwhWgPceGF8/oTd4wVv3arhRNgEauVRWPSRZ9CiFY/U4RGDJB3s0F9I2y3qQIDZP0l7u9wmIX5++xjP/JRpiu2OCZ8KiJFvJYwmhXUgIm1BCnjhSZwK9K0w4TVDy1SzHLzmaw6kRlsVF34M3/fI4Xqtk8l8HBtwfoEl2zbynUpcVkhuU/TxRExLbF3vVU1GYLrzQ86JXQ0/ZZOIL9Liih17NP/9I6iV6e5w0FmRpdDWRD5MORA02IxjQnz56uqgf4jvrcGWchM6QpBlQ2ehKFzUcHFo1FcFwrOFHW4z58HgFVXnnYDe6nutZXZjifqSkjUiPKOKIzOLSAkv2ec44mhAfq8aPJPQed6BNpCIKFHHbC42Y4wmSX2wjdTN+Peq1BzggCfnQee0JzudWEoOMmv2QDwnUD/tFqpFaKScy/zcQT3+yfVkJ67czswauliWwO9RNTTBM38MHPz6F+vex5ucHOeg+7ylQ5lByN8RYSkyEQLqPY/wFYZlM2MVu4LntZ59GWzjzA2dZgPVFfmcxq1X/BjmR0SWtm2mtwady9uUJaygZN7PS0z5GoIbf2dDo0/PVWevqyPETin9BLt4PdXvo7UrcXvagPBKrEpPFppcNs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bHxih09xdyb19G3d4lwCWShY6PeEZNx2OA8ZSc1dboMEO0tpnMXP7EbR0YPO1XUzJPLRA1b+uJ1Vlo/1p/kmHuYxhJcPduomsSQofAIaQvqse03SwIaHFczXWyWiqxeDln5ZAXLUtu16XI/z7otg8WpseX750iw5R506Mdssra/ORTYuIOUxlBEBJ8sbhrfF6EoSPk3VBMxxdWRPU2ct3M43NUcufrXMGUC+ZEIisQrUdqjS/6kRwiSuFBpcMZ6tGpJPILzpYb3BDeh4kEdTbYGs+PiDvYnHZfMwMd9FuWuLV3CCupVnWhYeTWg0lK6YXHIXNSZopIQGaum1b9HBzQG/pAo//9EoA5JOPbTWfMXLhh59piIq2+vhhxbZ0xi03AwZIkeFkDIG//hMFMVJErp7uAYabJtYW+xxSG/3fXyMDRbSinpkveGMhgeW20t0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:20:18.6610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db56efc8-194f-4232-b514-08dea83ccad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

Add threshold event support for temperature and supply voltage
channels.

Temperature events:
  - Rising/falling threshold with configurable values
  - Over-temperature (OT) alarm with separate thresholds
  - Per-channel hysteresis configuration

Supply voltage events:
  - Rising/falling threshold per supply channel
  - Per-channel alarm enable via alarm configuration registers

The interrupt handler masks active threshold interrupts (which are
level-sensitive) and schedules a delayed worker to poll for condition
clear before unmasking. When no hardware IRQ is available (irq <= 0),
event channels are not created and interrupt init is skipped, since
the I2C regmap backend cannot be called from atomic context.

When disabling a supply channel alarm, the group interrupt remains
active if any other channel in the same alarm group still has an
alarm enabled.

Named constants replace magic numbers for hysteresis bit positions
(SYSMON_OT_HYST_BIT, SYSMON_TEMP_HYST_BIT) and alarm register width
(SYSMON_ALARM_BITS_PER_REG).

Hysteresis values are validated to single-bit range (0 or 1) before
writing to the hardware register.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
Changes in v2:
  - Reverse Christmas Tree variable ordering in all functions
  - Named constants for hysteresis bits: SYSMON_OT_HYST_BIT,
    SYSMON_TEMP_HYST_BIT instead of magic 0x1/0x2
  - SYSMON_ALARM_BITS_PER_REG replaces magic number 32
  - SYSMON_ALARM_OFFSET() helper macro deduplicates alarm register
    offset computation
  - BIT() macro for shift expressions in conversion functions
  - Hysteresis input validated to single-bit range (0 or 1)
  - Event channels only created when irq > 0 (I2C safety)
  - Group alarm interrupt stays active while any channel in the
    group has an alarm enabled
  - write_event_value returns -EINVAL for unhandled types
  - IRQ_NONE returned for spurious interrupts
  - Q8.7 write path uses multiplication instead of left-shift
    to avoid undefined behavior with negative temperatures
  - (u16) mask prevents garbage in reserved register bits
  - regmap_write return values checked for IER/IDR writes
  - devm cleanup ordering: cancel_work before request_irq
 drivers/iio/adc/versal-sysmon-core.c | 539 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  36 ++
 2 files changed, 574 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 37736c2900b..857fe21db7a 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -9,13 +9,24 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "versal-sysmon.h"
 
+/* OT and TEMP hysteresis bit positions in SYSMON_TEMP_EV_CFG */
+#define SYSMON_OT_HYST_BIT		BIT(0)
+#define SYSMON_TEMP_HYST_BIT		BIT(1)
+
+/* Compute alarm register offset from a channel address */
+#define SYSMON_ALARM_OFFSET(addr) \
+	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
+
 #define SYSMON_CHAN_TEMP(_chan, _address, _ext) {		\
 	.type = IIO_TEMP,					\
 	.indexed = 1,						\
@@ -32,6 +43,71 @@
 	.datasheet_name = _ext,					\
 }
 
+#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _ext, _events) {	\
+	.type = IIO_TEMP,					\
+	.indexed = 1,						\
+	.address = _address,					\
+	.channel = _chan,					\
+	.event_spec = _events,					\
+	.num_event_specs = ARRAY_SIZE(_events),			\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 15,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.datasheet_name = _ext,					\
+}
+
+enum sysmon_alarm_bit {
+	SYSMON_BIT_ALARM0 = 0,
+	SYSMON_BIT_ALARM1 = 1,
+	SYSMON_BIT_ALARM2 = 2,
+	SYSMON_BIT_ALARM3 = 3,
+	SYSMON_BIT_ALARM4 = 4,
+	SYSMON_BIT_OT = 8,
+	SYSMON_BIT_TEMP = 9,
+};
+
+/* Temperature event specifications */
+static const struct iio_event_spec sysmon_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
+/* Supply event specifications */
+static const struct iio_event_spec sysmon_supply_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 /* Static temperature channels (always present) */
 static const struct iio_chan_spec temp_channels[] = {
 	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
@@ -40,11 +116,24 @@ static const struct iio_chan_spec temp_channels[] = {
 	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
 };
 
+/* Temperature event channels (threshold alarms) */
+static const struct iio_chan_spec temp_event_channels[] = {
+	SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
+			      sysmon_temp_events),
+	SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",
+			      sysmon_temp_events),
+};
+
 static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
 {
 	*val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
 }
 
+static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
+{
+	*raw_data = (u16)((val * (int)BIT(SYSMON_FRACTIONAL_SHIFT)) / SYSMON_MILLI);
+}
+
 static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
 {
 	int mantissa, format, exponent;
@@ -62,6 +151,49 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
 	*val = (mantissa * SYSMON_MILLI) >> exponent;
 }
 
+static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
+{
+	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
+	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
+	int scale, tmp;
+
+	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
+	tmp = (val * scale) / SYSMON_MILLI;
+
+	if (format)
+		tmp = clamp(tmp, (int)S16_MIN, (int)S16_MAX);
+	else
+		tmp = clamp(tmp, 0, (int)U16_MAX);
+
+	*raw_data = tmp & U16_MAX;
+}
+
+static int sysmon_temp_thresh_offset(int address,
+				     enum iio_event_direction dir)
+{
+	switch (address) {
+	case SYSMON_ADDR_TEMP_EVENT:
+		return (dir == IIO_EV_DIR_RISING) ? SYSMON_TEMP_TH_UP :
+						    SYSMON_TEMP_TH_LOW;
+	case SYSMON_ADDR_OT_EVENT:
+		return (dir == IIO_EV_DIR_RISING) ? SYSMON_OT_TH_UP :
+						    SYSMON_OT_TH_LOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sysmon_supply_thresh_offset(int address,
+				       enum iio_event_direction dir)
+{
+	if (dir == IIO_EV_DIR_RISING)
+		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_UP;
+	if (dir == IIO_EV_DIR_FALLING)
+		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_LOW;
+
+	return -EINVAL;
+}
+
 static int sysmon_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -103,6 +235,209 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int sysmon_get_event_mask(unsigned long address)
+{
+	if (address == SYSMON_ADDR_TEMP_EVENT)
+		return BIT(SYSMON_BIT_TEMP);
+	if (address == SYSMON_ADDR_OT_EVENT)
+		return BIT(SYSMON_BIT_OT);
+
+	return BIT(address / SYSMON_ALARM_BITS_PER_REG);
+}
+
+static int sysmon_read_alarm_config(struct sysmon *sysmon,
+				    unsigned long address)
+{
+	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
+	u32 offset = SYSMON_ALARM_OFFSET(address);
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(sysmon->regmap, offset, &reg_val);
+	if (ret)
+		return ret;
+
+	return reg_val & BIT(shift);
+}
+
+static int sysmon_write_alarm_config(struct sysmon *sysmon,
+				     unsigned long address, u32 val)
+{
+	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
+	u32 offset = SYSMON_ALARM_OFFSET(address);
+
+	return regmap_update_bits(sysmon->regmap, offset,
+				  BIT(shift), val << shift);
+}
+
+static int sysmon_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int imr;
+	int config_value;
+	int ret;
+
+	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+	if (ret)
+		return ret;
+	imr = ~imr;
+
+	if (chan->type == IIO_VOLTAGE) {
+		config_value = sysmon_read_alarm_config(sysmon, chan->address);
+		if (config_value < 0)
+			return config_value;
+		return config_value && (imr & alarm_event_mask);
+	}
+
+	return !!(imr & alarm_event_mask);
+}
+
+static int sysmon_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, bool state)
+{
+	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
+	u32 ier = sysmon_get_event_mask(chan->address);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int alarm_config;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+	guard(spinlock_irqsave)(&sysmon->irq_lock);
+
+	if (chan->type == IIO_VOLTAGE) {
+		ret = sysmon_write_alarm_config(sysmon, chan->address, state);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(sysmon->regmap, offset, &alarm_config);
+		if (ret)
+			return ret;
+
+		if (alarm_config)
+			return regmap_write(sysmon->regmap, SYSMON_IER, ier);
+		else
+			return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
+	} else if (chan->type == IIO_TEMP) {
+		if (state) {
+			ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
+			if (ret)
+				return ret;
+			sysmon->temp_mask &= ~ier;
+		} else {
+			ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
+			if (ret)
+				return ret;
+			sysmon->temp_mask |= ier;
+		}
+	}
+
+	return 0;
+}
+
+static int sysmon_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int reg_val;
+	u32 mask, shift;
+	int offset;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			offset = sysmon_temp_thresh_offset(chan->address, dir);
+			if (offset < 0)
+				return offset;
+			ret = regmap_read(sysmon->regmap, offset, &reg_val);
+			if (ret)
+				return ret;
+			sysmon_q8p7_to_millicelsius(reg_val, val);
+			return IIO_VAL_INT;
+		}
+		if (info == IIO_EV_INFO_HYSTERESIS) {
+			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
+				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
+			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
+			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
+					  &reg_val);
+			if (ret)
+				return ret;
+			*val = (reg_val & mask) >> shift;
+			return IIO_VAL_INT;
+		}
+	} else if (chan->type == IIO_VOLTAGE) {
+		offset = sysmon_supply_thresh_offset(chan->address, dir);
+		if (offset < 0)
+			return offset;
+		ret = regmap_read(sysmon->regmap, offset, &reg_val);
+		if (ret)
+			return ret;
+		sysmon_supply_rawtoprocessed(reg_val, val);
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int sysmon_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val, int val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int reg_val;
+	u32 mask, shift;
+	u32 raw_val;
+	int offset;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			offset = sysmon_temp_thresh_offset(chan->address, dir);
+			if (offset < 0)
+				return offset;
+			sysmon_millicelsius_to_q8p7(&raw_val, val);
+			return regmap_write(sysmon->regmap, offset, raw_val);
+		}
+		if (info == IIO_EV_INFO_HYSTERESIS) {
+			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
+				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
+			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
+			if (val & ~1)
+				return -EINVAL;
+			return regmap_update_bits(sysmon->regmap,
+						  SYSMON_TEMP_EV_CFG,
+						  mask, val << shift);
+		}
+	} else if (chan->type == IIO_VOLTAGE) {
+		offset = sysmon_supply_thresh_offset(chan->address, dir);
+		if (offset < 0)
+			return offset;
+		ret = regmap_read(sysmon->regmap, offset, &reg_val);
+		if (ret)
+			return ret;
+		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
+		return regmap_write(sysmon->regmap, offset, raw_val);
+	}
+
+	return -EINVAL;
+}
+
 static int sysmon_read_label(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     char *label)
@@ -116,8 +451,182 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
 	.read_label = sysmon_read_label,
+	.read_event_config = sysmon_read_event_config,
+	.write_event_config = sysmon_write_event_config,
+	.read_event_value = sysmon_read_event_value,
+	.write_event_value = sysmon_write_event_value,
 };
 
+static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
+{
+	const struct iio_chan_spec *chan;
+	unsigned int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].address != address)
+			continue;
+
+		chan = &indio_dev->channels[i];
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type,
+						    chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+	}
+}
+
+static void sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
+	u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned long alarm_flag_reg;
+	unsigned int reg_val;
+	u32 address, bit;
+
+	switch (event) {
+	case SYSMON_BIT_TEMP:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
+		regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
+		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
+		break;
+
+	case SYSMON_BIT_OT:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
+		regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_OT));
+		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
+		break;
+
+	case SYSMON_BIT_ALARM0:
+	case SYSMON_BIT_ALARM1:
+	case SYSMON_BIT_ALARM2:
+	case SYSMON_BIT_ALARM3:
+	case SYSMON_BIT_ALARM4:
+		regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
+		alarm_flag_reg = (unsigned long)reg_val;
+
+		for_each_set_bit(bit, &alarm_flag_reg,
+				 SYSMON_ALARM_BITS_PER_REG) {
+			address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
+			sysmon_push_event(indio_dev, address);
+			regmap_update_bits(sysmon->regmap, alarm_reg_offset,
+					   BIT(bit), 0);
+		}
+		regmap_write(sysmon->regmap, alarm_flag_offset, alarm_flag_reg);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void sysmon_handle_events(struct iio_dev *indio_dev,
+				 unsigned long events)
+{
+	unsigned int bit;
+
+	for_each_set_bit(bit, &events, SYSMON_NO_OF_EVENTS)
+		sysmon_handle_event(indio_dev, bit);
+}
+
+static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
+{
+	unsigned int unmask, status;
+
+	status = isr & SYSMON_TEMP_INTR_MASK;
+
+	unmask = (sysmon->masked_temp ^ status) & sysmon->masked_temp;
+	sysmon->masked_temp &= status;
+
+	unmask &= ~sysmon->temp_mask;
+
+	regmap_write(sysmon->regmap, SYSMON_IER, unmask);
+}
+
+/*
+ * Versal threshold interrupts are level-sensitive. Active threshold
+ * interrupts are masked in the handler and polled via delayed work
+ * until the condition clears, then unmasked.
+ */
+static void sysmon_unmask_worker(struct work_struct *work)
+{
+	struct sysmon *sysmon = container_of(work, struct sysmon,
+					     sysmon_unmask_work.work);
+	unsigned int isr;
+
+	spin_lock_irq(&sysmon->irq_lock);
+	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
+	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
+	sysmon_unmask_temp(sysmon, isr);
+	spin_unlock_irq(&sysmon->irq_lock);
+
+	if (sysmon->masked_temp)
+		schedule_delayed_work(&sysmon->sysmon_unmask_work,
+				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+	else
+		regmap_write(sysmon->regmap, SYSMON_STATUS_RESET, 1);
+}
+
+static irqreturn_t sysmon_iio_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct sysmon *sysmon;
+	unsigned int isr, imr;
+
+	sysmon = iio_priv(indio_dev);
+	spin_lock(&sysmon->irq_lock);
+
+	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
+	regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+
+	isr &= ~imr;
+	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
+
+	if (isr) {
+		sysmon_handle_events(indio_dev, isr);
+		schedule_delayed_work(&sysmon->sysmon_unmask_work,
+				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+	}
+
+	spin_unlock(&sysmon->irq_lock);
+
+	return isr ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static void sysmon_cancel_work(void *data)
+{
+	struct sysmon *sysmon = data;
+
+	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
+}
+
+static int sysmon_init_interrupt(struct sysmon *sysmon)
+{
+	unsigned int imr;
+	int ret;
+
+	/* Events not supported without IRQ (e.g. I2C path) */
+	if (sysmon->irq <= 0)
+		return 0;
+
+	INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work, sysmon_unmask_worker);
+
+	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+	if (ret)
+		return ret;
+	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
+
+	ret = devm_add_action_or_reset(sysmon->dev, sysmon_cancel_work,
+				       sysmon);
+	if (ret)
+		return ret;
+
+	return devm_request_irq(sysmon->dev, sysmon->irq,
+				sysmon_iio_irq, 0, "sysmon-irq",
+				sysmon->indio_dev);
+}
+
 /**
  * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
  * @indio_dev: IIO device instance
@@ -125,7 +634,13 @@ static const struct iio_info sysmon_iio_info = {
  *
  * Reads supply-channels and temperature-channels container nodes from
  * firmware and builds the IIO channel array. Static temperature channels
- * are prepended, followed by supply and satellite channels from DT.
+ * and event channels are prepended, followed by supply and satellite
+ * channels from DT.
+ *
+ * Event channels and per-channel event specs are only added when the
+ * device has an IRQ (irq > 0). I2C devices have no interrupt line,
+ * and the I2C regmap cannot be called from atomic context, so events
+ * are not supported on that path.
  *
  * Return: 0 on success, negative errno on failure.
  */
@@ -133,8 +648,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 {
 	unsigned int idx, temp_chan_idx, volt_chan_idx;
 	struct fwnode_handle *supply_node, *temp_node;
+	struct sysmon *sysmon = iio_priv(indio_dev);
 	unsigned int num_supply = 0, num_temp = 0;
 	struct iio_chan_spec *sysmon_channels;
+	bool has_events = sysmon->irq > 0;
+	unsigned int num_events;
 	const char *label;
 	u32 reg;
 	int ret;
@@ -147,8 +665,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	if (temp_node)
 		num_temp = fwnode_get_child_node_count(temp_node);
 
+	num_events = has_events ? ARRAY_SIZE(temp_event_channels) : 0;
+
 	sysmon_channels = devm_kcalloc(dev,
 				       ARRAY_SIZE(temp_channels) +
+				       num_events +
 				       num_supply + num_temp,
 				       sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels) {
@@ -161,6 +682,13 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
 	idx += ARRAY_SIZE(temp_channels);
 
+	/* Temperature event channels (only when IRQ is available) */
+	if (has_events) {
+		memcpy(sysmon_channels + idx, temp_event_channels,
+		       sizeof(temp_event_channels));
+		idx += ARRAY_SIZE(temp_event_channels);
+	}
+
 	/* Supply channels from DT */
 	if (supply_node) {
 		fwnode_for_each_child_node_scoped(supply_node, child) {
@@ -187,6 +715,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 				.info_mask_separate =
 					BIT(IIO_CHAN_INFO_RAW) |
 					BIT(IIO_CHAN_INFO_PROCESSED),
+				.event_spec = has_events ?
+					sysmon_supply_events : NULL,
+				.num_event_specs = has_events ?
+					ARRAY_SIZE(sysmon_supply_events) : 0,
 				.scan_type = {
 					.realbits = 19,
 					.storagebits = 32,
@@ -295,6 +827,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -311,6 +844,10 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
+	ret = sysmon_init_interrupt(sysmon);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(sysmon_core_probe);
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index fc4d2338328..4f20173de77 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -12,16 +12,30 @@
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 /* Register offsets (sorted by address) */
 #define SYSMON_NPI_LOCK			0x000C
 #define SYSMON_ISR			0x0044
+#define SYSMON_IMR			0x0048
+#define SYSMON_IER			0x004C
 #define SYSMON_IDR			0x0050
+#define SYSMON_ALARM_FLAG		0x1018
 #define SYSMON_TEMP_MAX			0x1030
 #define SYSMON_TEMP_MIN			0x1034
 #define SYSMON_SUPPLY_BASE		0x1040
+#define SYSMON_ALARM_REG		0x1940
+#define SYSMON_TEMP_TH_LOW		0x1970
+#define SYSMON_TEMP_TH_UP		0x1974
+#define SYSMON_OT_TH_LOW		0x1978
+#define SYSMON_OT_TH_UP		0x197C
+#define SYSMON_SUPPLY_TH_LOW		0x1980
+#define SYSMON_SUPPLY_TH_UP		0x1C80
+#define SYSMON_TEMP_EV_CFG		0x1F84
 #define SYSMON_TEMP_MIN_MIN		0x1F8C
 #define SYSMON_TEMP_MAX_MAX		0x1F90
+#define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
 #define SYSMON_MAX_REG			0x24C0
 
@@ -33,8 +47,12 @@
 
 #define SYSMON_SUPPLY_IDX_MAX		159
 #define SYSMON_TEMP_SAT_MAX		64
+#define SYSMON_NO_OF_EVENTS		32
 #define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
 
+/* ISR/IMR temperature and OT alarm mask (bits 9:8) */
+#define SYSMON_TEMP_INTR_MASK		GENMASK(9, 8)
+
 /* Supply voltage conversion register fields */
 #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
 #define SYSMON_FMT_MASK			BIT(16)
@@ -47,13 +65,26 @@
 /* Signed milli scale (MILLI from linux/units.h is unsigned long) */
 #define SYSMON_MILLI			1000
 
+/* Event address IDs for temp event channels */
+#define SYSMON_ADDR_TEMP_EVENT		160
+#define SYSMON_ADDR_OT_EVENT		161
+
+/* Bits per alarm register */
+#define SYSMON_ALARM_BITS_PER_REG	32
+
+#define SYSMON_UNMASK_WORK_DELAY_MS	500
+
 /**
  * struct sysmon - Driver data for Versal SysMon
  * @dev: pointer to device struct
  * @indio_dev: pointer to the iio device (needed for work callbacks)
  * @regmap: register map for hardware access
  * @lock: mutex for serializing user-space access
+ * @irq_lock: spinlock for interrupt register access
  * @irq: interrupt number
+ * @masked_temp: currently masked temperature alarm bits
+ * @temp_mask: temperature interrupt configuration mask
+ * @sysmon_unmask_work: re-enables events after alarm condition clears
  */
 struct sysmon {
 	struct device *dev;
@@ -61,7 +92,12 @@ struct sysmon {
 	struct regmap *regmap;
 	/* Serializes access to device registers and state */
 	struct mutex lock;
+	/* Protects interrupt mask register updates */
+	spinlock_t irq_lock;
 	int irq;
+	unsigned int masked_temp;
+	unsigned int temp_mask;
+	struct delayed_work sysmon_unmask_work;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq);
-- 
2.48.1

