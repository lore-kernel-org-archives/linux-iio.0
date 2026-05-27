Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566553FCB29;
	Wed, 27 May 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882161; cv=fail; b=B/bQ1cMIGFVezwE1GoZcA9/sZyEQUYeiMrIrhn6+QsAsxESkGVY91nfzcT7Mvw5UMaTUkSaAHx7QVRjw1/0QmfAK4tg9VLIu7V7dxZo91vAgMcHxefyKkxRn3PXJtrK8QqkaudPI4pfHQDiRyh74VltID7MO7DxWVK5JybkTb0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882161; c=relaxed/simple;
	bh=7mi0EZvuj2Z2ICHRz0GTA48zk5dfiTKg3H+7qjVEe4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKF/tmSNxgYEIlWKQwFG/PhcYFrrp+2ouRhkOwh/9V6bmAav7VP8xcqqOkehZ7p5qf/oVLPFyzF7L/zZfpMk+PiKUpHC9aRiFw84E28MFk9ydwzWvS8nRRgRyKix5Ycghb4wNyzGywZGkmXYQQ+Mlue0yUsERYNJHx7zBfuk6aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eznfO8de; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eznfO8de"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSLx5/oqSu5OYp2XKYrZb9NMQgsesFVKOG7lOOTA8kfV4ESQKeuba7Z3Ilshzo4NLJ6TIyYCGnvKrFuAHs3I1mIFS31lDiLDPUiTuge+F3KVEcI163M1FiXSKUQ8Q7DgAhV2GFX9qA/d/sY2Te1LeQE3HFKsSv8QrezkwYx/VDJ/82/j1zi8VaQWEUBCtW6bzJ9Qh05x0YM85nQFiMCdbzNjUZKpqCm6F1Qko76/VIghanJW3Gh/i2/En9EF5AeQPE4ayO9xihAHbHf/HrNU5oRo2GArdl8r0eIaHvBXT/nmQJ5R9nMmXxvcz2bAmnVjthMViJinYr8OwY9MPhbwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzPJ4MEtvgzPDI78YRVtZJGvYNk87spX+XvgJxraTko=;
 b=lv1X96MiHoKHpLOzYqjn65AggF6N2mfy1MawWbcsr0xZ9T/NqPwISmbFqBf3AWdsbb7OHF2ylhTMPR8Nk6Lj4IntB9dIUVqI4Bis/NzsepSHAeIM1EYhFKIckbpMmiRFkTo0vtxp1j9M3Co3bGpYy1WE2q/D8tCSoBFM+y5qdZYgli+3JneO5gSjvSAKzsfhi0dthSf6I/GurUWY776OBfM0QxKzooJXIJaIOCK0fz5vHMQD+6O4Y8i7r7BYHiN2yQL1oSJByHvcy8dHE8N670UFRg5JBxlPKAOhz5ClogrIwyugzJAzda03uJ0FmWNdWs1CKX5vLYehl7EstFqNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzPJ4MEtvgzPDI78YRVtZJGvYNk87spX+XvgJxraTko=;
 b=eznfO8de4xI35WAbPvls4SZRTlTRdzD63Bwfe8B0SOYLwbvO4U309vPTNOu5hm8WXCQG2JxANiWv8tExXmEadJ1lJkYNU8FMckz/4UegK0ht3X1RAhz/W71Yhcz97+CEuSy8Ueh9K1QYTAXyM7+WOYanym13LAYU8Scq3sy+Z1c=
Received: from BY3PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:39a::34)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:42:27 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::5a) by BY3PR03CA0029.outlook.office365.com
 (2603:10b6:a03:39a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 11:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 11:42:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 06:42:26 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 06:42:24 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v3 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Wed, 27 May 2026 12:42:10 +0100
Message-ID: <20260527114211.174288-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527114211.174288-1-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b59c63-5d83-455b-4dc8-08debbe5070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|11063799006|3023799007|22082099003|18092099006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OFU/ErVgr+sMc6N2S562fOR+JJHwZLY+U3r/hnatwMa8gpDMyVVDSEotpZTpxE6HWKbOathCeOwLDtS7L92b/oHRI7okhAPjJ0QnybmkbIXRPndsL+atm5IJWRSuxRF2SDSFg0zYv4usbEuEsd+AoUHodigwSwYqp8QIL6hRBs73+jJLpshL1XVtDyBG0Jo56onnVJhb3XsU+e93X799lf+PMq5y3tz5X8kexuXpTOzX0szBYoUP/Wd6BGg38WMn+dKuc++24kBzW0MTHbw6P1m6kuwGZCwpDxomU4RrTRcxt5bIRm9aDe7I3NVk+6fJr9MNDRBx4W1IbYrMlnQDAavx3UCl4SF/fWABaLtqV7tcSwY1U2sg1ldtzKs9vh61hDKTLJnxSYaG1XJeP/GkEgtdLPxB8L6lwzUvDosFy5BnTBeFLJJXxxBnaYq2OL84qTYN23ujV8py6XxIQOZ/WOtg38QW98ppiKR1J19u6H6j3SVNRHrTnA0Pb6GnTYOMad5GsBVKdny58bLL29z89iFvN4Uc3J5ozT6f1gFYiBdzrTdX/8zHxD67bjzRVEg2p90900l0Iu2zWggjiahJPHGPPB1ILP2L+zBpi7yZkLvys5SttPytzGKItkQD+cxL39RgfN7eRwOfbYyNvdiMUmnXsadsvctCzHKRj5NkzPjPiucAJRzYBnAR0bCPGi+o2yJ/41BwuXs4kHOjzQ7nURO0sTpVDPFTbczRUEkih3s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(11063799006)(3023799007)(22082099003)(18092099006)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LRtn6FsLeIxfGdz0SIfbr7qOp1GN/GRoASzbVFUu9ihnVikpYpg048BMnDPa6LQ58sjF+kpvvzhcm6rZnOeXRV7YjqZbwPs8feuLotWoQnlH8taE1ghJHWoceZcDydXKsxKZvwNsHmEMXlThLOasbuA3snCGMsNU/gGWSHpV3q7YKv5HnlI4sboaeWgAn22lKq3qJr8msPYEky6tIlKq7iU0GGZuNI2ej+vqTlo6nCohBn4PpC3mRgA9TDbp3leYup7pTRlSS72L3lq2dHhbQk7qgtbjXrPIGIqL3JnysKJ0WdRmVx+bpWQEoCbCEePqkN6lezQtPhpCSVnakv8V1bYcRbnojIttWqXUcdEF8yl481tSgVEWOG+dLvF3fEaLyHHfb2D3JrLy4j664PVKwMD/b3UVzMMVvuv0TtqIDI/ewEGwHL5ftbrr9Bo5IVsK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:42:27.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b59c63-5d83-455b-4dc8-08debbe5070b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

Add threshold event support for temperature and supply voltage
channels.

Temperature events:
  - Rising threshold with configurable value
  - Over-temperature (OT) alarm with separate threshold
  - Per-channel hysteresis as a millicelsius value
  - Event direction is IIO_EV_DIR_RISING (hysteresis mode)

Supply voltage events:
  - Rising/falling threshold per supply channel
  - Per-channel alarm enable via alarm configuration registers

The hardware supports both window and hysteresis alarm modes for
temperature. This driver uses hysteresis mode, where the upper
threshold triggers the alarm and the lower threshold clears it
(re-arm point). The hardware has a single ISR bit per temperature
channel with no indication of which threshold was crossed, so
hysteresis mode is the natural fit. The lower threshold register
is computed internally as (upper - hysteresis).

Hysteresis is stored in the driver as a millicelsius value,
initialized from the hardware registers at probe. Writing the
rising threshold or hysteresis recomputes the lower register.
ALARM_CONFIG is hard-coded to hysteresis mode during init.

The interrupt handler masks active threshold interrupts (which are
level-sensitive) and schedules a delayed worker to poll for condition
clear before unmasking. When no hardware IRQ is available, event
channels are not created and interrupt init is skipped, since the
I2C regmap backend cannot be called from atomic context.

When disabling a supply channel alarm, the group interrupt remains
active if any other channel in the same alarm group still has an
alarm enabled.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
Changes in v3:
  - IWYU: add new includes, group iio headers with blank line (Andy)
  - Reduce casts in millicelsius_to_q8p7, consistent style with
    q8p7_to_millicelsius (Andy)
  - Use clamp_t with typed constants, remove tmp & U16_MAX (Andy)
  - Use !! to return 0/1 from read_alarm_config (Andy)
  - Use regmap_set_bits/clear_bits in write_alarm_config (Andy)
  - Add comment explaining spinlock is safe (I2C never reaches
    event code path) (Andy)
  - Add comment explaining IMR negation logic (Andy)
  - Split read_event_value/write_event_value parameters logically
    across lines (Andy)
  - Move mask/shift after regmap_read error check (Andy)
  - Remove redundant else in read_event_value and
    write_event_value (Andy)
  - Use named constant for hysteresis bit, if-else not ternary
    (Andy)
  - Loop variable declared in for() scope (Andy)
  - Add error checks in sysmon_handle_event (Andy)
  - Use IRQ_RETVAL() macro (Andy)
  - Use devm_delayed_work_autocancel instead of manual INIT +
    devm_add_action (Andy)
  - Use FIELD_GET/FIELD_PREP for hysteresis register bits
    (Jonathan)
  - Split OT vs TEMP handling with FIELD_GET (Jonathan)
  - Rework hysteresis: store as millicelsius value, hardcode
    ALARM_CONFIG to hysteresis mode, compute lower threshold
    from (upper - hysteresis), initialize from HW at probe
    (Jonathan)
  - Remove falling threshold for temperature; single event
    spec per channel with IIO_EV_DIR_RISING (Jonathan)
  - Push IIO_EV_DIR_RISING events for temperature,
    IIO_EV_DIR_EITHER for voltage (Jonathan)

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

 drivers/iio/adc/versal-sysmon-core.c | 655 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  48 +-
 2 files changed, 697 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index ebe052f6982..04977c9c887 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -11,6 +11,8 @@
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -18,10 +20,19 @@
 #include <linux/sysfs.h>
 #include <linux/units.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #include "versal-sysmon.h"
 
+/* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
+#define SYSMON_OT_HYST_MASK		BIT(0)
+#define SYSMON_TEMP_HYST_MASK		BIT(1)
+
+/* Compute alarm register offset from a channel address */
+#define SYSMON_ALARM_OFFSET(addr) \
+	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
+
 /*
  * Both RAW and PROCESSED are exposed: RAW is needed for event thresholds
  * (which operate in hardware register format), PROCESSED gives userspace
@@ -44,6 +55,62 @@
 	.datasheet_name = _name,				\
 }
 
+#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\
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
+	.datasheet_name = _name,				\
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
+/* Temperature event specification: rising threshold + hysteresis only */
+static const struct iio_event_spec sysmon_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE) |
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
@@ -52,11 +119,24 @@ static const struct iio_chan_spec temp_channels[] = {
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
 static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
 {
 	*val = (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;
 }
 
+static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
+{
+	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / (int)MILLI;
+}
+
 static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
 {
 	int mantissa, format, exponent;
@@ -74,6 +154,49 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
 	*val = (mantissa * (int)MILLI) >> exponent;
 }
 
+static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
+{
+	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
+	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
+	int scale, tmp;
+
+	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
+	tmp = (val * scale) / (int)MILLI;
+
+	if (format)
+		tmp = clamp_t(int, tmp, S16_MIN, S16_MAX);
+	else
+		tmp = clamp_t(int, tmp, 0, U16_MAX);
+
+	*raw_data = (u16)tmp;
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
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -115,6 +238,258 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
+	return !!(reg_val & BIT(shift));
+}
+
+static int sysmon_write_alarm_config(struct sysmon *sysmon,
+				     unsigned long address, bool enable)
+{
+	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
+	u32 offset = SYSMON_ALARM_OFFSET(address);
+
+	if (enable)
+		return regmap_set_bits(sysmon->regmap, offset, BIT(shift));
+
+	return regmap_clear_bits(sysmon->regmap, offset, BIT(shift));
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
+
+	/* IMR bits are 1=masked, invert to get 1=enabled */
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
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
+	u32 ier = sysmon_get_event_mask(chan->address);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int alarm_config;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
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
+
+		return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
+	}
+
+	if (chan->type == IIO_TEMP) {
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
+/*
+ * Recompute the lower threshold register from upper threshold and
+ * cached hysteresis. Called when either upper threshold or hysteresis
+ * is written.
+ */
+static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
+{
+	unsigned int upper_reg;
+	int upper_mc, lower_mc, hysteresis;
+	u32 raw_val;
+	int upper_off, lower_off, ret;
+
+	upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
+	if (upper_off < 0)
+		return upper_off;
+	lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
+	if (lower_off < 0)
+		return lower_off;
+
+	if (address == SYSMON_ADDR_OT_EVENT)
+		hysteresis = sysmon->ot_hysteresis;
+	else
+		hysteresis = sysmon->temp_hysteresis;
+
+	ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
+	if (ret)
+		return ret;
+	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
+
+	lower_mc = upper_mc - hysteresis;
+	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
+
+	return regmap_write(sysmon->regmap, lower_off, raw_val);
+}
+
+static int sysmon_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int offset;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			/* Only rising threshold is exposed */
+			offset = sysmon_temp_thresh_offset(chan->address,
+							   IIO_EV_DIR_RISING);
+			if (offset < 0)
+				return offset;
+			ret = regmap_read(sysmon->regmap, offset, &reg_val);
+			if (ret)
+				return ret;
+			sysmon_q8p7_to_millicelsius(reg_val, val);
+			return IIO_VAL_INT;
+		}
+		if (info == IIO_EV_INFO_HYSTERESIS) {
+			if (chan->address == SYSMON_ADDR_OT_EVENT)
+				*val = sysmon->ot_hysteresis;
+			else
+				*val = sysmon->temp_hysteresis;
+			return IIO_VAL_INT;
+		}
+	}
+
+	if (chan->type == IIO_VOLTAGE) {
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
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int reg_val;
+	u32 raw_val;
+	int offset;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			/* Only rising threshold is exposed */
+			offset = sysmon_temp_thresh_offset(chan->address,
+							   IIO_EV_DIR_RISING);
+			if (offset < 0)
+				return offset;
+			sysmon_millicelsius_to_q8p7(&raw_val, val);
+			ret = regmap_write(sysmon->regmap, offset, raw_val);
+			if (ret)
+				return ret;
+			/* Recompute lower = upper - hysteresis */
+			return sysmon_update_temp_lower(sysmon,
+							chan->address);
+		}
+		if (info == IIO_EV_INFO_HYSTERESIS) {
+			if (val < 0)
+				return -EINVAL;
+			if (chan->address == SYSMON_ADDR_OT_EVENT)
+				sysmon->ot_hysteresis = val;
+			else
+				sysmon->temp_hysteresis = val;
+			return sysmon_update_temp_lower(sysmon,
+							chan->address);
+		}
+	}
+
+	if (chan->type == IIO_VOLTAGE) {
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
@@ -128,20 +503,248 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
+	enum iio_event_direction dir;
+
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].address != address)
+			continue;
+
+		chan = &indio_dev->channels[i];
+		/* Temp uses hysteresis mode (rising only), voltage uses window */
+		dir = (chan->type == IIO_TEMP) ? IIO_EV_DIR_RISING :
+						 IIO_EV_DIR_EITHER;
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type,
+						    chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    dir),
+			       iio_get_time_ns(indio_dev));
+	}
+}
+
+static int sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
+	u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned long alarm_flag_reg;
+	unsigned int reg_val;
+	u32 address, bit;
+	int ret;
+
+	switch (event) {
+	case SYSMON_BIT_TEMP:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR,
+				   BIT(SYSMON_BIT_TEMP));
+		if (ret)
+			return ret;
+		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
+		break;
+
+	case SYSMON_BIT_OT:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR,
+				   BIT(SYSMON_BIT_OT));
+		if (ret)
+			return ret;
+		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
+		break;
+
+	case SYSMON_BIT_ALARM0:
+	case SYSMON_BIT_ALARM1:
+	case SYSMON_BIT_ALARM2:
+	case SYSMON_BIT_ALARM3:
+	case SYSMON_BIT_ALARM4:
+		ret = regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
+		if (ret)
+			return ret;
+		alarm_flag_reg = reg_val;
+
+		for_each_set_bit(bit, &alarm_flag_reg,
+				 SYSMON_ALARM_BITS_PER_REG) {
+			address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
+			sysmon_push_event(indio_dev, address);
+			ret = regmap_update_bits(sysmon->regmap,
+						 alarm_reg_offset,
+						 BIT(bit), 0);
+			if (ret)
+				return ret;
+		}
+		ret = regmap_write(sysmon->regmap, alarm_flag_offset,
+				   alarm_flag_reg);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
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
+	return IRQ_RETVAL(isr);
+}
+
+static int sysmon_init_interrupt(struct sysmon *sysmon,
+				 struct device *dev,
+				 struct iio_dev *indio_dev,
+				 int irq)
+{
+	unsigned int imr;
+	int ret;
+
+	/* Events not supported without IRQ (e.g. I2C path) */
+	if (!irq)
+		return 0;
+
+	ret = devm_delayed_work_autocancel(dev, &sysmon->sysmon_unmask_work,
+					   sysmon_unmask_worker);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+	if (ret)
+		return ret;
+	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
+
+	return devm_request_irq(dev, irq, sysmon_iio_irq, 0,
+				"sysmon-irq", indio_dev);
+}
+
+/*
+ * Initialize the cached hysteresis for a temperature channel from the
+ * current hardware threshold registers: hysteresis = upper - lower.
+ */
+static int sysmon_init_hysteresis(struct sysmon *sysmon, int address,
+				  int *hysteresis)
+{
+	unsigned int upper_reg, lower_reg;
+	int upper_mc, lower_mc;
+	int upper_off, lower_off;
+	int ret;
+
+	upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
+	if (upper_off < 0)
+		return upper_off;
+	lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
+	if (lower_off < 0)
+		return lower_off;
+
+	ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
+	if (ret)
+		return ret;
+	ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
+	if (ret)
+		return ret;
+
+	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
+	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
+	*hysteresis = upper_mc - lower_mc;
+
+	return 0;
+}
+
 /**
  * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
  * @indio_dev: IIO device instance
  * @dev: Parent device
+ * @has_irq: true if an IRQ is available (enables event channels)
  *
  * Reads voltage-channels and temperature-channels container nodes from
  * firmware and builds the IIO channel array. Static temperature channels
- * are prepended, followed by supply and satellite channels from DT.
+ * and event channels are prepended, followed by supply and satellite
+ * channels from DT.
+ *
+ * Event channels and per-channel event specs are only added when the
+ * device has an IRQ. I2C devices have no interrupt line, and the I2C
+ * regmap cannot be called from atomic context, so events are not
+ * supported on that path.
  *
  * Return: 0 on success, negative errno on failure.
  */
-static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
+static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
+			   bool has_irq)
 {
 	struct fwnode_handle *supply_node __free(fwnode_handle) =
 		device_get_named_child_node(dev, "voltage-channels");
@@ -150,6 +753,7 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	unsigned int num_supply = 0, num_temp = 0;
 	unsigned int idx, temp_chan_idx, volt_chan_idx;
 	struct iio_chan_spec *sysmon_channels;
+	unsigned int num_events;
 	const char *label;
 	u32 reg;
 	int ret;
@@ -159,8 +763,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	if (temp_node)
 		num_temp = fwnode_get_child_node_count(temp_node);
 
+	num_events = has_irq ? ARRAY_SIZE(temp_event_channels) : 0;
+
 	sysmon_channels = devm_kcalloc(dev,
-				       size_add(ARRAY_SIZE(temp_channels),
+				       size_add(ARRAY_SIZE(temp_channels) +
+						num_events,
 						num_supply + num_temp),
 				       sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels)
@@ -171,6 +778,13 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
 	idx += ARRAY_SIZE(temp_channels);
 
+	/* Temperature event channels (only when IRQ is available) */
+	if (has_irq) {
+		memcpy(sysmon_channels + idx, temp_event_channels,
+		       sizeof(temp_event_channels));
+		idx += ARRAY_SIZE(temp_event_channels);
+	}
+
 	/* Supply channels from DT */
 	fwnode_for_each_child_node_scoped(supply_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
@@ -195,6 +809,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.event_spec = has_irq ?
+				sysmon_supply_events : NULL,
+			.num_event_specs = has_irq ?
+				ARRAY_SIZE(sysmon_supply_events) : 0,
 			.scan_type = {
 				.realbits = 19,
 				.storagebits = 32,
@@ -274,6 +892,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 {
 	struct iio_dev *indio_dev;
 	struct sysmon *sysmon;
+	bool has_irq;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
@@ -286,6 +906,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -295,13 +916,39 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ret;
 
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	has_irq = irq > 0;
+
 	indio_dev->name = "versal-sysmon";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = sysmon_parse_fw(indio_dev, dev);
+	ret = sysmon_parse_fw(indio_dev, dev, has_irq);
 	if (ret)
 		return ret;
 
+	if (has_irq) {
+		/* Set hysteresis mode for both temperature channels */
+		ret = regmap_set_bits(sysmon->regmap, SYSMON_TEMP_EV_CFG,
+				      SYSMON_OT_HYST_MASK |
+				      SYSMON_TEMP_HYST_MASK);
+		if (ret)
+			return ret;
+
+		/* Initialize cached hysteresis from hardware registers */
+		ret = sysmon_init_hysteresis(sysmon, SYSMON_ADDR_TEMP_EVENT,
+					     &sysmon->temp_hysteresis);
+		if (ret)
+			return ret;
+		ret = sysmon_init_hysteresis(sysmon, SYSMON_ADDR_OT_EVENT,
+					     &sysmon->ot_hysteresis);
+		if (ret)
+			return ret;
+
+		ret = sysmon_init_interrupt(sysmon, dev, indio_dev, irq);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(sysmon_core_probe);
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index d24d2481915..a78362f95e6 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -11,7 +11,9 @@
 
 #include <linux/bits.h>
 #include <linux/mutex.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct iio_dev;
@@ -20,12 +22,24 @@ struct regmap;
 /* Register offsets (sorted by address) */
 #define SYSMON_NPI_LOCK			0x000C
 #define SYSMON_ISR			0x0044
+#define SYSMON_IMR			0x0048
+#define SYSMON_IER			0x004C
 #define SYSMON_IDR			0x0050
 #define SYSMON_TEMP_MAX			0x1030
 #define SYSMON_TEMP_MIN			0x1034
 #define SYSMON_SUPPLY_BASE		0x1040
+#define SYSMON_ALARM_FLAG		0x1018
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
 
@@ -37,8 +51,12 @@ struct regmap;
 
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
@@ -48,15 +66,41 @@ struct regmap;
 #define SYSMON_FRACTIONAL_SHIFT		7U
 #define SYSMON_SUPPLY_MANTISSA_BITS	16
 
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
  * @regmap: register map for hardware access
- * @lock: protects regmap access
+ * @lock: protects regmap access and cached state
+ * @irq_lock: protects interrupt mask register updates (MMIO path only)
+ * @masked_temp: currently masked temperature alarm bits
+ * @temp_mask: temperature interrupt configuration mask
+ * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
+ * @ot_hysteresis: cached OT hysteresis in millicelsius
+ * @sysmon_unmask_work: re-enables events after alarm condition clears
  */
 struct sysmon {
 	struct regmap *regmap;
-	/* Protects regmap access */
+	/* Protects regmap access and cached state */
 	struct mutex lock;
+	/*
+	 * Protects interrupt mask register updates.  Only used on the
+	 * MMIO path (fast_io regmap); I2C has no IRQ and never reaches
+	 * the event code that takes this lock.
+	 */
+	spinlock_t irq_lock;
+	unsigned int masked_temp;
+	unsigned int temp_mask;
+	int temp_hysteresis;
+	int ot_hysteresis;
+	struct delayed_work sysmon_unmask_work;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

