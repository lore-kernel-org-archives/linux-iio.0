Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784626AF4;
	Sat,  6 Jun 2026 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723063; cv=fail; b=PHanzMfyCKDg9uM0wKHbE0mABCOeNbwSlKNAHqD7x9mLSmDWA5lgnQFxAVC9X3LooytDNdF8dbZRP0ZSRU5juLmIxAoBjmMytPTXYb9TuW9uq6ROBWbtO4BIpyq6+ZMez05sy9ihk1rAxPhcFjZPt7BG0rB/PJCRdSQNHbDpzMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723063; c=relaxed/simple;
	bh=+B0Ywr+gi5/DBEWvM6DJsvOG21DzA1zGthCQtc6CEIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBwhEXvrtTPsYm0O/sxRxGGC4N38MzowlBZb3hCF9dcvEUXgQ2NBZefJyaqg1+xD3Jo7QVbWojMzA0NkbArs6mcloHPxcR9u9ltLV1L0fG5udUzopj5MSzjObCikNrUCYXwrNyrcdMtSIl8W6mARUJRYfYKbVsy5SaqdMc0vNCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TFN71wjN; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TFN71wjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGK1pcZqZYLoJF1YbbKK9+ocGchstxEcOZuQKWe2jyUxlhRDgSl3co6/JZdnjFLe4t+3lDYpJnhWRkIi5R9xR5gyNNoF7ICKuThGAPVbrPV3Eq8gmkFv4zVKMAUJoHi6zp1dEkOqGdm5KVyvkWapFH6pEaLUiISB6M/o/CTUJuFIcJeOgmacfKcLeGa9Svow9NWNilNKKMGlKtTCWPn96xebOGbVIAdbC5yTxagvCoQjcqASOuHgMOtYLnc2eeQ8MFbl/evMF8i6Bddmba21T71PfcVMSSyj/e7AeJjf0n0zqLaDpa+rPluwnlXPzGdIPYpTuaXSayVLjovNOvN3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzGsyTZk6ZjS/+FhTRYUIDZ7sjdDQnutlmJ8ySEziEE=;
 b=Z8SAGOC7TlZ4ZF/8WHwuKAVLTGLDJniAEnYG5w0o2VSHJWmWbLjoqeP1ESQsGFPRCn6jHpCsYTp+9TetzZUbZv7nZvQjyI6x6g6HbdMdiRbiVPgll7/Rqe5f5NeL0xzOcKOmtk2hdE6Db/gPa7emWlNQiBdEx7I1Itrnqsayujs0uT8sBOOqLkOR3eceMlJfsaGGWT7Owk61AaiPg7BvATNoQpfSTv3sc5NHvBBrRgybEvaR7n3qaqIq72qik5BgqITqXCFkPfzFGoqwieN1WjRtV7My4q2PjGZ3eNV06yKGO/VozombukjQohUKvlYb2QKHQnPZu4b7AiVyXHIKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzGsyTZk6ZjS/+FhTRYUIDZ7sjdDQnutlmJ8ySEziEE=;
 b=TFN71wjNwl/hAAJ/e2e7kEblAbq9BdjmQSHFSkh/gcSXQuQDAxECWVqQYJthxdbFnNvq9gZiDKhDDAM7GI/Bbh6Y9q3rK0TMwspq3zlAg0gnih1lBKSa/sQYk/CUOZqi5Q1Hwa7YHMW+DU3BHk6y7f3/VrgaM1Jw2rF4gVc2+68=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Sat, 6 Jun 2026
 05:17:34 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::f9) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:17:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:32 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:17:31 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v4 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Sat, 6 Jun 2026 06:17:06 +0100
Message-ID: <20260606051707.535281-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20260606051707.535281-1-salih.erim@amd.com>
References: <20260606051707.535281-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad11bf4-1e13-4011-33bd-08dec38aea71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|18092099006|22082099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	Nz/LiKjcg17uszGs7rwcVtjrvXuUEhzSQrbxK7UT8kKieVZkRd7BILK/3Kkayodi8aN4cn1/ld0/NU6rqMqHrbq1efcZjCh9ZHrovmk9TSq2emQLvUAVDrW5CxnnflWiO2fjvkdTMIIZQiV0wzCHPgw9DK7mxkR5OKYD1Yrlz55B8u26q7CCKmaCB6sXTdt8weTfUhkGDPDJPt+X8beuJZvPhBXyGoUmbSQrzm0lNdNFWSe2OsXP78TsYL9naqyMIc3FjrhnPEmNXSEXBYra2EeRuol0hq1r6NAzXcOkfUPxkW/LHY3SsW36XVzvAo7WpX83L52S2DBLnI5S/4zopu9tUdWdSIc5Tjv0YnwH+OnGR+9XuoWDBl/aQlqw4A24nnvTkXcfkC3l86IkOng/tnG1c7VG5cx8rgflW/TbeT25IXPj0gmiJYxjazRHL4EbW+Dw/J47bwx1xpkwfNeAiAA2v0ebVcWQQ6Bu4K3c1yxwE47xH19uOPnU9ybx5zZJL5ImPMrCGGRlslPec8BHx1uORUl60MZGxTrOVKwEp7tXjSlFERvr09dxo7N6YNDpJA2G6N3N4AJM67NxiVxA0hncp010a16rOVO6E1ZsAflW3viG/8exkvdweuV6i7AR7ShvOBAc6ryLN5oA59b2+nIHZ2/XGvFjmQBS1wBW9hdsJcOM227yJ4eeIAKFeLUfLfC9yYX3NJcsW/+AcwH3lnzq2LUWf2ufWGnKziZKOWg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(18092099006)(22082099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gK8YtQBoMOfUzs/CXD5pczgkLfLbfOu4LIM1nimU9yaFVl9pfJQhaOkXAOrfuGvfNh9iRZG/TlF47Cp3RA69Tpi46pvyy/eYXaq5NXKrHsW01y7lScdrROL3uEVu9sHRowgrCkGKC6W7Lv3aSkRlnKRzH/fWZ8k4LnRZ6LeOVsTpqE6oJS89ixFiB68rZnHSaGhKVxKHi5JUJWtctQ0TyaHLAel+MjCWBvxU6wpnfJIXI8Mo3kXwKfiWXBY9GedgpCnmH2br5PX07Y1YmcCJb86cHskbTkU/OqtwbvZeUnXon7qqMJzuBqDGTChBw+M9V2FGt0jQjSUm6FzX7h0UAztaOEreIiVaiFTkJFS0JVh4ZXB6mBk7n76W7d/xrnQOQBojMQdjbmO2dviWz/HS6sDPJQQ4rB4WmU/7DJA0oVyE+vWVYhNLC5+xuLj2CCQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:17:33.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad11bf4-1e13-4011-33bd-08dec38aea71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808

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

 drivers/iio/adc/versal-sysmon-core.c | 678 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  44 ++
 2 files changed, 713 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 72f7da61115..e87974c641a 100644
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
 #define SYSMON_CHAN_TEMP(_chan, _address, _name) {		\
 	.type = IIO_TEMP,					\
 	.indexed = 1,						\
@@ -32,14 +43,86 @@
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
@@ -57,6 +140,49 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
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
@@ -103,6 +229,275 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
@@ -116,23 +511,247 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
+		for_each_set_bit(bit, &alarm_flag_reg,
+				 SYSMON_ALARM_BITS_PER_REG) {
+			address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
+			sysmon_push_event(indio_dev, address);
+			ret = regmap_update_bits(sysmon->regmap, alarm_reg_offset, BIT(bit), 0);
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
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int isr, imr;
+
+	guard(spinlock)(&sysmon->irq_lock);
+
+	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
+	regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
+
+	isr &= ~imr;
+	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
+
+	if (!isr)
+		return IRQ_NONE;
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
+	const struct iio_chan_spec *temp_chans;
 	unsigned int num_supply = 0, num_temp = 0;
-	unsigned int idx, temp_chan_idx, volt_chan_idx;
+	unsigned int num_static, idx, temp_chan_idx, volt_chan_idx;
 	struct iio_chan_spec *sysmon_channels;
 	const char *label;
 	u32 reg;
@@ -148,17 +767,25 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 	if (temp_node)
 		num_temp = fwnode_get_child_node_count(temp_node);
 
+	if (has_irq) {
+		temp_chans = temp_channels_with_events;
+		num_static = ARRAY_SIZE(temp_channels_with_events);
+	} else {
+		temp_chans = temp_channels_no_events;
+		num_static = ARRAY_SIZE(temp_channels_no_events);
+	}
+
 	sysmon_channels = devm_kcalloc(dev,
-				       size_add(ARRAY_SIZE(temp_channels),
+				       size_add(num_static,
 						num_supply + num_temp),
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
@@ -183,6 +810,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 			.address = reg,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.event_spec = has_irq ?
+				sysmon_supply_events : NULL,
+			.num_event_specs = has_irq ?
+				ARRAY_SIZE(sysmon_supply_events) : 0,
 			.datasheet_name = label,
 		};
 	}
@@ -249,6 +880,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 {
 	struct iio_dev *indio_dev;
 	struct sysmon *sysmon;
+	bool has_irq;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
@@ -261,6 +894,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -270,13 +904,39 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
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
index 2cb737ec890..e06d2379c23 100644
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
@@ -48,11 +66,26 @@ struct regmap;
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
@@ -62,6 +95,17 @@ struct sysmon {
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

