Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13E3264E7;
	Mon,  8 Jun 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943899; cv=fail; b=UM7IHC61N+Mn5hShvSVfiVhZgxC/qROyGwcn8+7tVwm89GRuA+Dz4D/BTxQdlBRAW2zoHdZGcwLzbdE3RPViv/aJmXWbr9l/XRYgvY9ZrW1guyuu2lqvPWz11SakGErKJmlMd/jQchSMaf4QidpshhaZvI12lFIgil5Org/xVqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943899; c=relaxed/simple;
	bh=tXBDS05QlYxx6StDFCWrvxf2IaSxGPgWFcucpm/IZy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQr7x/gvEZq6QcS8rapnMphffXml+ySmTvd4aRTa73wc+yjjAM7HiazdtdB+WVHo49hYsJS/89DbtMHpYqtQco66u57DiXVPH45XD0wKzxHJQn8a3b9mxW3+sdZuRbFnq0dFT+GP41eLY1iNddA+EgH/WKwnEONFitYrL9mMN5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=piuVNOZ7; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="piuVNOZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx9IrqAuDQNs3okPB4yovNC7urQjazTjxwlpm/zru7DX46XBh58qyJrv2AfBbYVRXx8pysMKOm0JAzv8sSDBYW/eAIrm77oA2/jg8niZ55IMcRQy+7gt+u+/hXp2kT0yrBz/xN3hwwXH16QBmXQsU6c1EQPE+thI0V22RHqyXeU7dj9i3aMiZxouNkt3gIlPRsHJMDhFGqIm/nimGrr9cyPUcGkcbHF0eTIFSHBHJe0YUUhGbC+cHknpSYbkBcrA7m6HBda3hqYQ+9KJcm5wzNyX63maICbwxtsyvrC1y024fG9u2l7yLLJ4fKbWJ80Zl67ltNUME5ohPKmhPBMBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbKDqTdMUkdeuFIOLsVPNxEPlzZRNOnFW1AHqBWDDLY=;
 b=MPOWu2neSa2yBf3sJ5mDZ4Fwvh/YHjvzAbHDUT55h8YRN9jSCvqudvh8PEHvqQ5hfvj7pGhPyyCMsdkOIXif24YL4ENkLuBlpCZTKGMCD6A4pjOKD9cz6AqIw1da8vkaJqVwW2411y+dughfQlJObyEVbUV5UCItIDYifU6fXvresXZmVT5A0fwwaAR7OBqltHJwq3x7qw20bSWi+WaNZx6TOwdVnFDZMNcmoSrPEelSe/EqNGL0bq2Iq7LZjfHMujjI+7u/rTIFd13vTJZhp3bWUFsPAKdyJDlJm9Q3qS4KP+lf36VtTyUEqvbTss+GZnXQOUO+m7gEdX9aRDM/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbKDqTdMUkdeuFIOLsVPNxEPlzZRNOnFW1AHqBWDDLY=;
 b=piuVNOZ7K3N6lzeqBmA6nJNuZZoa1X2QKh3qw7FbPef8tqGT/ION+CcMPownjjC1vxrs53ShS4P83FPSGCWolBJAtw0mslAv4aSqMyMjfh7wW//OwW6FM/sRA+VcxplnnVzIOu3xMLlLT9wN8H42qeDrUFhN9okmwgQCq1zs6vY=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 18:38:12 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::1e) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 18:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:38:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 13:38:10 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 13:38:09 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v5 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Mon, 8 Jun 2026 19:38:00 +0100
Message-ID: <20260608183801.1257051-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608183801.1257051-1-salih.erim@amd.com>
References: <20260608183801.1257051-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5220f8aa-fd26-4bd2-f38b-08dec58d1846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|18092099006|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BDjWWkbe9V0hPkF8DlvTR1Qu1qe4rf5RFbtrL6a4QREfmDW4z1erww8ZYefyEPfV3N/y/7HSWdABDQ+LpPaPo4LvKThHR1GQt1o1hM1naM4ECgZY8qvuYi/tvsSjGR8bM7HzrPrkMKxY5k/1aeOUIgvP5r/R5b+cWzNh1xcOkFQqYXry/84Uiom24+EC0xWox1LVllH9KcePm8N3XwSHPcyH/BKlwTwiWHjS6MtSzVSbYovGGWefAZRTRYfwaOFaaPWyd9bO1y5eKRV29mag+UvB7DmUb/rw8Kwf1LdmpDP8sV8QHToceDY3s1tACBol7LAFsPT1yBDVb9u1Pf3vhym5E+RU39EaFotMX/oAHRtIHtFAEhZpGAmV1ugP0orggzP6M+NyhHa7QlSEFlCTZuYkeMAjnTbqStaLYEVyljeUrLP9yhND3qsZxOoK3qGxw/J8LlYOla6IGqrxr7Sxo8zFAYrTztCgnAYuVKqVydHoJxxfw1k+X8g0xzvKD8xESHNPFjDXv1QrdvQLGa6AlvcckXRmlYEjqy9TIDPP2eeIfe7WNoKwpuCGuy8LvdpVc+mtK7wLnyoUECGsET+n8S1M7uM/Q1RnRuVXAErqND8yjHvAzeH6uNbLDFJSbdbT+Idr6Jq0xAPAh+10KP6RDbLyc2Q3ZpLhZIjNkjE5A8bHAtL+rR8CXROtvZ3ZRpJAYRPtlr2vm+T4OIrIWXOV3+UGdYeLbBEib1NWugAehyw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(18092099006)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oBKTbWOAjexl5RMmZmeM50gW9iRO09x0MrnQm5n+0ThOJaoUF9rvfrXUvfuBgT7BMInbtTcFg9qVcohfV5UNUEzPYykuU2d7uyZXoED6++orZvSAab+DhRzHVK56HmZ1sHnaW8bPpo1WYbIW8uosx9DRpqlaMs4ca/uVwx1UYB3Z541HDhvskouNtFO5Kn5bfAHbYmmETeyYaEL6yWRd3XZLLZuaWvJyKcrfWynmuI6lSkZpjOwk6as4EV9n6/9kfwqUQgKZQ+ati0ADfaUX7qR3eNOoGBkxMh0AJRvXZXVKjna4sYbAso4DuRMEC5oToXCC3H+TzlRxRuFug0HRfkDVe+aKVYsOUO6MCicNCbnlRM/9/T8d/1XBQK8wFhn0WH6hL7WaIEvfs1DvnnaAtNqkkl1wZMoXGWcL7KWHn+MkiGDtSe0NsKTvLXYIEKMC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:38:12.0788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5220f8aa-fd26-4bd2-f38b-08dec58d1846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

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
Changes in v5:
  - clamp() instead of clamp_t() (Andy)
  - regmap_assign_bits() instead of separate set/clear (Andy)
  - Remove unneeded parentheses (2 places) (Andy)
  - for_each_set_bit on single line (Andy)
  - regmap_clear_bits() instead of regmap_update_bits() (Andy)
  - Simplify unmask XOR to ~status & masked_temp (Andy)
  - Add comment explaining unmask &= ~temp_mask logic (Andy)
  - Split container_of across two lines (Andy)
  - Move ISR write after !isr check to avoid writing 0 (Andy)
  - unsigned int for init_hysteresis address param (Andy)
  - Add comment explaining error check policy in worker/IRQ (Andy)
  - Nested size_add() for overflow-safe allocation (Andy)
  - Propagate negative from fwnode_irq_get() for
    EPROBE_DEFER (Andy)
  - Pass irq instead of has_irq to sysmon_parse_fw (Andy)

Changes in v4:
  - Merge event channels into static temp array; two arrays
    (with/without events) selected by has_irq (Jonathan)
  - Event-only channels have no info_mask; their addresses are
    logical identifiers, not readable registers
  - Drop RAW for voltage events, keep PROCESSED only (Jonathan)
  - Drop scan_type from event channel macro (Jonathan)
  - Blank lines between call+error-check blocks (Jonathan)
  - Fit under 80 chars on one line where possible (Jonathan)
  - default case returns -EINVAL instead of break (Jonathan)
  - sysmon_handle_event: return early in each case (Jonathan)
  - guard(spinlock) in sysmon_iio_irq, return IRQ_NONE/IRQ_HANDLED
    directly (Jonathan)
  - Take irq_lock in write_event_config for temp_mask updates to
    synchronize with unmask worker (Sashiko)

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
 drivers/iio/adc/versal-sysmon-core.c | 680 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  45 ++
 2 files changed, 716 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index c7b5eecc93c..5fbd509089b 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -11,7 +11,9 @@
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -19,10 +21,19 @@
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
 #define SYSMON_CHAN_TEMP(_chan, _address, _name) {		\
 	.type = IIO_TEMP,					\
 	.indexed = 1,						\
@@ -33,14 +44,86 @@
 	.datasheet_name = _name,				\
 }
 
+#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\
+	.type = IIO_TEMP,					\
+	.indexed = 1,						\
+	.address = _address,					\
+	.channel = _chan,					\
+	.event_spec = _events,					\
+	.num_event_specs = ARRAY_SIZE(_events),			\
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
-static const struct iio_chan_spec temp_channels[] = {
+static const struct iio_chan_spec temp_channels_no_events[] = {
+	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
+	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
+	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
+	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
+};
+
+/* Static temperature channels with event support (when IRQ available) */
+static const struct iio_chan_spec temp_channels_with_events[] = {
 	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
 	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
 	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
 	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
+	SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
+			      sysmon_temp_events),
+	SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",
+			      sysmon_temp_events),
 };
 
+static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
+{
+	*val = (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;
+}
+
+static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
+{
+	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / (int)MILLI;
+}
+
 static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
 {
 	int mantissa, format, exponent;
@@ -58,6 +141,49 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
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
+		tmp = clamp(tmp, S16_MIN, S16_MAX);
+	else
+		tmp = clamp(tmp, 0, U16_MAX);
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
@@ -104,6 +230,272 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
+	return regmap_assign_bits(sysmon->regmap, offset, BIT(shift), enable);
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
+
+			scoped_guard(spinlock_irq, &sysmon->irq_lock)
+				sysmon->temp_mask &= ~ier;
+		} else {
+			ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
+			if (ret)
+				return ret;
+
+			scoped_guard(spinlock_irq, &sysmon->irq_lock)
+				sysmon->temp_mask |= ier;
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
+
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
+
+			ret = regmap_read(sysmon->regmap, offset, &reg_val);
+			if (ret)
+				return ret;
+
+			sysmon_q8p7_to_millicelsius(reg_val, val);
+
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
+
+		ret = regmap_read(sysmon->regmap, offset, &reg_val);
+		if (ret)
+			return ret;
+
+		sysmon_supply_rawtoprocessed(reg_val, val);
+
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
+
+			sysmon_millicelsius_to_q8p7(&raw_val, val);
+
+			ret = regmap_write(sysmon->regmap, offset, raw_val);
+			if (ret)
+				return ret;
+
+			/* Recompute lower = upper - hysteresis */
+			return sysmon_update_temp_lower(sysmon, chan->address);
+		}
+		if (info == IIO_EV_INFO_HYSTERESIS) {
+			if (val < 0)
+				return -EINVAL;
+
+			if (chan->address == SYSMON_ADDR_OT_EVENT)
+				sysmon->ot_hysteresis = val;
+			else
+				sysmon->temp_hysteresis = val;
+
+			return sysmon_update_temp_lower(sysmon, chan->address);
+		}
+	}
+
+	if (chan->type == IIO_VOLTAGE) {
+		offset = sysmon_supply_thresh_offset(chan->address, dir);
+		if (offset < 0)
+			return offset;
+
+		ret = regmap_read(sysmon->regmap, offset, &reg_val);
+		if (ret)
+			return ret;
+
+		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
+
+		return regmap_write(sysmon->regmap, offset, raw_val);
+	}
+
+	return -EINVAL;
+}
+
 static int sysmon_read_label(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     char *label)
@@ -117,23 +509,252 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
+	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + event * SYSMON_REG_STRIDE;
+	u32 alarm_reg_offset = SYSMON_ALARM_REG + event * SYSMON_REG_STRIDE;
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned long alarm_flag_reg;
+	unsigned int reg_val;
+	u32 address, bit;
+	int ret;
+
+	switch (event) {
+	case SYSMON_BIT_TEMP:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
+
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
+		if (ret)
+			return ret;
+
+		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
+		return 0;
+
+	case SYSMON_BIT_OT:
+		sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
+
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_OT));
+		if (ret)
+			return ret;
+
+		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
+		return 0;
+
+	case SYSMON_BIT_ALARM0:
+	case SYSMON_BIT_ALARM1:
+	case SYSMON_BIT_ALARM2:
+	case SYSMON_BIT_ALARM3:
+	case SYSMON_BIT_ALARM4:
+		ret = regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
+		if (ret)
+			return ret;
+
+		alarm_flag_reg = reg_val;
+
+		for_each_set_bit(bit, &alarm_flag_reg, SYSMON_ALARM_BITS_PER_REG) {
+			address = bit + SYSMON_ALARM_BITS_PER_REG * event;
+			sysmon_push_event(indio_dev, address);
+			ret = regmap_clear_bits(sysmon->regmap, alarm_reg_offset, BIT(bit));
+			if (ret)
+				return ret;
+		}
+
+		return regmap_write(sysmon->regmap, alarm_flag_offset, alarm_flag_reg);
+
+	default:
+		return -EINVAL;
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
+	unmask = ~status & sysmon->masked_temp;
+	sysmon->masked_temp &= status;
+
+	/* Only unmask if not administratively disabled by userspace */
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
+	struct sysmon *sysmon =
+		container_of(work, struct sysmon, sysmon_unmask_work.work);
+	unsigned int isr;
+
+	/*
+	 * regmap errors are not checked here because the worker and IRQ
+	 * handler cannot propagate errors. The MMIO regmap uses fast_io
+	 * with direct readl/writel which cannot fail.
+	 */
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
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int isr, imr;
+
+	guard(spinlock)(&sysmon->irq_lock);
+
+	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
+	regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+
+	isr &= ~imr;
+	if (!isr)
+		return IRQ_NONE;
+
+	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
+
+	sysmon_handle_events(indio_dev, isr);
+	schedule_delayed_work(&sysmon->sysmon_unmask_work,
+			      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+
+	return IRQ_HANDLED;
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
+static int sysmon_init_hysteresis(struct sysmon *sysmon, unsigned int address,
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
+
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
+ * @irq: IRQ number (positive enables event channels, 0 disables)
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
+			   int irq)
 {
+	const struct iio_chan_spec *temp_chans;
 	unsigned int num_supply = 0, num_temp = 0;
-	unsigned int idx, temp_chan_idx, volt_chan_idx;
+	unsigned int num_static, idx, temp_chan_idx, volt_chan_idx;
 	struct iio_chan_spec *sysmon_channels;
 	const char *label;
 	u32 reg;
@@ -147,17 +768,25 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 		device_get_named_child_node(dev, "temperature-channels");
 	num_temp = fwnode_get_child_node_count(temp_node);
 
+	if (irq > 0) {
+		temp_chans = temp_channels_with_events;
+		num_static = ARRAY_SIZE(temp_channels_with_events);
+	} else {
+		temp_chans = temp_channels_no_events;
+		num_static = ARRAY_SIZE(temp_channels_no_events);
+	}
+
 	sysmon_channels = devm_kcalloc(dev,
-				       size_add(size_add(ARRAY_SIZE(temp_channels),
+				       size_add(size_add(num_static,
 						  num_supply), num_temp),
 				       sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels)
 		return -ENOMEM;
 
-	/* Static temperature channels first (fixed indices) */
+	/* Static temperature channels (with or without events) */
 	idx = 0;
-	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
-	idx += ARRAY_SIZE(temp_channels);
+	memcpy(sysmon_channels, temp_chans, num_static * sizeof(*temp_chans));
+	idx += num_static;
 
 	/* Supply channels from DT */
 	fwnode_for_each_child_node_scoped(supply_node, child) {
@@ -182,6 +811,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 			.address = reg,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.event_spec = irq > 0 ?
+				sysmon_supply_events : NULL,
+			.num_event_specs = irq > 0 ?
+				ARRAY_SIZE(sysmon_supply_events) : 0,
 			.datasheet_name = label,
 		};
 	}
@@ -248,6 +881,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 {
 	struct iio_dev *indio_dev;
 	struct sysmon *sysmon;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
@@ -260,6 +894,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -269,13 +904,40 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ret;
 
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "failed to get IRQ\n");
+
 	indio_dev->name = "versal-sysmon";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = sysmon_parse_fw(indio_dev, dev);
+	ret = sysmon_parse_fw(indio_dev, dev, irq);
 	if (ret)
 		return ret;
 
+	if (irq > 0) {
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
index 0c0c89f6e0c..b5861f7e882 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -11,6 +11,9 @@
 
 #include <linux/bits.h>
 #include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct regmap;
@@ -18,12 +21,24 @@ struct regmap;
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
 
@@ -35,8 +50,12 @@ struct regmap;
 
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
@@ -46,11 +65,26 @@ struct regmap;
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
  * @lock: protects read-modify-write sequences on threshold registers
  *        and cached state that spans multiple regmap calls
+ * @irq_lock: protects interrupt mask register updates (MMIO path only)
+ * @masked_temp: currently masked temperature alarm bits
+ * @temp_mask: temperature interrupt configuration mask
+ * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
+ * @ot_hysteresis: cached OT hysteresis in millicelsius
+ * @sysmon_unmask_work: re-enables events after alarm condition clears
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -60,6 +94,17 @@ struct sysmon {
 	 * that spans multiple regmap calls.
 	 */
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

