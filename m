Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644444BC97;
	Thu, 11 Jun 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216880; cv=fail; b=R5HLa+cGKluVkSXgBOeXp4oH6pw4E6tPAHquX+vZ1UBXX79Ti9/WfYeGUSZFsU6/v6kWJ4TdpFPmQr+ruP0DwZjPj+AFEyuG9ymg85WG16f0M1iNwWE1K2i+h6La1D13iqRAQYvunDGt14L5ny4OTUKbcPIl5FcTGYCNwd1BRts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216880; c=relaxed/simple;
	bh=6+5QN2IE1By4ChM3ywfkxOQ91RIcLVRhq2TptUnQtMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCf0TD+k7vj6PFbgnR5hpuP+fNK/4LiR5LLSPpmgR7L0MITbIIta64LWgW2W+GTp+ae/YxRy3R60AKp7bqsJRAR9ramoROW+jWUKdCltAxCQ9lTsAz59SuG8E6DTlle85UbqrMow0MMWqTiZOL2dj482cXmHdvbYgxdWqUafwi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=stM2nY1D; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="stM2nY1D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKRQCWd/4gokbQrqL5Pb5H0hVmQBwxYofAEcrWCcP3G7kobhIF2lgC3BNNwqvgLwoHVbvpCzhQKDTvxQ8ckN62+DCRhp5tOb3ryAMwvnB4C78AMYg1nZIWi7+PFq30eNK1u58fQXQl9XcDhIr3+UYOYgyiDfGCBtzM1FPjqSrZZp7u0aPKOO4d+Fko1kBEwSqlJ9LWDcRKBaekQubfYcK3YTW/LS96SQamnmyh7JgUKTTr+GeOTGkK8Y4FKfYQ0rJOX6mwJEoY5fqipnPzPtvrqiCM6x8RJrnMpT+NAUEQwSi+R3f+rnQWD1fvzj/Ft9Cajxt/SmzJlNiluYl/qoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWYGp9DS8T9rLETtqYD88tEeGpAqwv1ku32IRoDulDM=;
 b=SBIJut9gfSjltFP04ICDIATd5Bqan/lEuckSXw7iNPaCdActliYXrlQfcUeds9qJVuBMUdsBycIhO+ZA+rzej7tUGvzPySwT2cHrrqi1ZkpU7moCeoEH3m0rfZPD4+OXeiXvLUBV6ZV9Mthxq/DsL2X7qqwAjbBI5vRKq4PrCfsszvqgGcGgWyVexEH0BO28TxpXBpFcqaz2tzdU2NMFyGsPBQwaonQ9rXiWLvmtAvj23sbc8bB1e+mbovRkeTOEkWjeHB9StRs8Ia2ka8NZm1c/Q6cvTNvJ/ScAy8PqI/PMJnsU9o8VnSPCIjakyFHz9L28P4b5uFpDguLD4T8kAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWYGp9DS8T9rLETtqYD88tEeGpAqwv1ku32IRoDulDM=;
 b=stM2nY1DbUaEsRTgyULZWs4oNcoQcl4iPg89VInWYOrWIWG9e0vXrfDUr00/poS2dSeDloIogrhDe0NGCJcTTLpcQkcjQFi//YMK/D2rmzAUWgQgIQTtz1ek3AJoPc6PUwfH/vj3sQSlZ3lYBc82hsFlEVvfM/hCg4b2mWcvX7A=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 22:27:50 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::6) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 22:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 22:27:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:47 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 17:27:46 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v6 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Thu, 11 Jun 2026 23:27:37 +0100
Message-ID: <20260611222738.2035062-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611222738.2035062-1-salih.erim@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba919f2-2db1-43be-9582-08dec808ab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|36860700016|6133799003|18002099003|22082099003|18092099006|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wtoV4r9HOk+uLDXieTnHUk330wHvgl4Zzl/RBTsw7vsCBivccNr5IZW7/T2x7n6KNVsoo2BaTtgKRSLbsCHBMhjELiLLwAj7nUsvoT36eyESRsRJpNOAhK+IlzMKWK52BhIAbIAEveeH+nH3+ihB7Fbioan1O4LaemTlwrBTnvEcvFKQi4/7q8uDVie3CDvR7oXBDUHw2ul4kdaPpZO3KVtVsaipnQHyxSalu0YPRbBhgtVcLe2wjqysMEN7Qv4LOQHJotvRRwZkGf02cP0PQwrIzjtUkTma0/3wz436unCJI6edccWgl3UhNfWK/W1v5zzBmDZylLhww5lpB2q2gzZTu4TYJ7uMdsu7M6g7Wt12YHxAVlO6IPNzkOgDKzB26w42hGF83vbfbQKDyanXOy+TTGPwYFyTbnLRaqY7PE06cX2K/pVBnIznx5ioqFTJUDb4l+Gh/3nVm+TaTpe2Pught4hFhl5FFnx4qPXryc4khZkvoF7TE13HN2/2Do6E451kbzKFwdqJK00GPT9tqBwC7/5dW0Uxc9xxyjEzqur0RHYuyioTCqftadotc6PyqZq6joUtcIrQtPi4S70h2gw3kWT++LWjhPcOL7FrIoUTXrH2B8y+gPlWPnSEKLpQKiS0nTe8HRN6EG0eXkD0Yf1XYwEqr/MpfDuqGonPl7ynsVK4NRrVsuU5sP+ygBXwF5tu9tViLvEOBHKhF07P03yi9Uj68nHL9FYrjJXzJCI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(18092099006)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TaGAES9KJMNudGWPswiXqZMsxaOo2V8umqnnMGBfDpuEb00kuQv46/PLV+o1YFY0GVnYqrFwbOXcv4wJa2w/vDmQ6qCBaxWsbuXaL5657XIPs1LlXQ3JlTN5yY49EtwYOJzk0rablUmvNRRca294vPwL4+5rI956FBTEj9zk3ahWE545hnh/HEyuDipjOGJVo7w7Q8qm1SEZ7qS5J53I8Z7+wHNca6ynfyKJ9NEkomYfxwThLImqoJcOrlLmeSPDwSuLTHYUM/e2bdusGKH5g6BZtcjvwVSicW5P1grkcozpnfmJCm+o3ZPnhmmQgHArhAQVshfhyGwDHqERI40/tGx0B3+pa2WHpJMvZX0jSch2pzIKt9S6HXNUPOQZWFTwd0DGCSoR2RGRsMXpAVyiQ0dS8bZ/lkzVzcRQOJJ25BifHU5P2gLU4Mzf4tTm6Fw0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:27:49.5257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba919f2-2db1-43be-9582-08dec808ab7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

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
Changes in v6:
  - Remove types.h from header (not needed at any stage) (Andy)
  - Macro brace on separate line for SYSMON_CHAN_TEMP_EVENT (Andy)
  - switch(chan->type) in all event functions instead of cascading
    if statements (Andy)
  - switch(info) in read/write_event_value for nested
    dispatch (Andy)
  - Reversed xmas tree in sysmon_update_temp_lower and
    sysmon_init_hysteresis (Andy)
  - scoped_guard(spinlock_irq) with error check in
    sysmon_unmask_worker (Andy)
  - Combined regmap_read error check with || in
    sysmon_iio_irq (Andy)
  - Join devm_request_irq on one line (Andy)
  - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER;
    treating all negatives as fatal broke probe on I2C nodes
    without interrupts property

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
 drivers/iio/adc/versal-sysmon-core.c | 700 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  44 ++
 2 files changed, 734 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index c875d156dbe..20fd3a87d44 100644
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
 #define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
 {								\
 	.type = IIO_TEMP,					\
@@ -34,14 +45,87 @@
 	.datasheet_name = _name,				\
 }
 
+#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events)	\
+{								\
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
 	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
 	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
 	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
 	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
 };
 
+/* Static temperature channels with event support (when IRQ available) */
+static const struct iio_chan_spec temp_channels_with_events[] = {
+	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
+	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
+	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
+	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
+	SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
+			      sysmon_temp_events),
+	SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",
+			      sysmon_temp_events),
+};
+
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
@@ -59,6 +143,49 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
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
@@ -105,6 +232,289 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		config_value = sysmon_read_alarm_config(sysmon, chan->address);
+		if (config_value < 0)
+			return config_value;
+		return config_value && (imr & alarm_event_mask);
+
+	case IIO_TEMP:
+		return !!(imr & alarm_event_mask);
+
+	default:
+		return -EINVAL;
+	}
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
+	switch (chan->type) {
+	case IIO_VOLTAGE:
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
+
+	case IIO_TEMP:
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
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Recompute the lower threshold register from upper threshold and
+ * cached hysteresis. Called when either upper threshold or hysteresis
+ * is written.
+ */
+static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
+{
+	int upper_mc, lower_mc, hysteresis;
+	int upper_off, lower_off, ret;
+	unsigned int upper_reg;
+	u32 raw_val;
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
+	switch (chan->type) {
+	case IIO_TEMP:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
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
+
+		case IIO_EV_INFO_HYSTERESIS:
+			if (chan->address == SYSMON_ADDR_OT_EVENT)
+				*val = sysmon->ot_hysteresis;
+			else
+				*val = sysmon->temp_hysteresis;
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_VOLTAGE:
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
+
+	default:
+		return -EINVAL;
+	}
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
+	switch (chan->type) {
+	case IIO_TEMP:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
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
+
+		case IIO_EV_INFO_HYSTERESIS:
+			if (val < 0)
+				return -EINVAL;
+
+			if (chan->address == SYSMON_ADDR_OT_EVENT)
+				sysmon->ot_hysteresis = val;
+			else
+				sysmon->temp_hysteresis = val;
+
+			return sysmon_update_temp_lower(sysmon, chan->address);
+
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_VOLTAGE:
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
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sysmon_read_label(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     char *label)
@@ -118,24 +528,253 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
+	 * If the ISR read fails, skip processing to avoid acting
+	 * on undefined data.
+	 */
+	scoped_guard(spinlock_irq, &sysmon->irq_lock) {
+		if (regmap_read(sysmon->regmap, SYSMON_ISR, &isr))
+			break;
+		regmap_write(sysmon->regmap, SYSMON_ISR, isr);
+		sysmon_unmask_temp(sysmon, isr);
+	}
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
+	if (regmap_read(sysmon->regmap, SYSMON_ISR, &isr) ||
+	    regmap_read(sysmon->regmap, SYSMON_IMR, &imr))
+		return IRQ_NONE;
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
+	return devm_request_irq(dev, irq, sysmon_iio_irq, 0, "sysmon-irq", indio_dev);
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
+	int upper_off, lower_off;
+	int upper_mc, lower_mc;
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
-	unsigned int num_chan, idx, temp_chan_idx, volt_chan_idx;
-	unsigned int num_supply, num_temp;
+	unsigned int num_chan, num_static, idx, temp_chan_idx, volt_chan_idx;
+	const struct iio_chan_spec *temp_chans;
 	struct iio_chan_spec *sysmon_channels;
+	unsigned int num_supply, num_temp;
 	const char *label;
 	u32 reg;
 	int ret;
@@ -148,14 +787,22 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 		device_get_named_child_node(dev, "temperature-channels");
 	num_temp = fwnode_get_child_node_count(temp_node);
 
-	num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));
+	if (irq > 0) {
+		temp_chans = temp_channels_with_events;
+		num_static = ARRAY_SIZE(temp_channels_with_events);
+	} else {
+		temp_chans = temp_channels_no_events;
+		num_static = ARRAY_SIZE(temp_channels_no_events);
+	}
+
+	num_chan = size_add(num_temp, size_add(num_static, num_supply));
 	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels)
 		return -ENOMEM;
 
-	/* Static temperature channels first */
-	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
-	idx = ARRAY_SIZE(temp_channels);
+	/* Static temperature channels (with or without events) */
+	memcpy(sysmon_channels, temp_chans, num_static * sizeof(*temp_chans));
+	idx = num_static;
 
 	/* Supply channels from DT */
 	fwnode_for_each_child_node_scoped(supply_node, child) {
@@ -179,6 +826,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 			.indexed = 1,
 			.address = reg,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			.event_spec = irq > 0 ?
+				sysmon_supply_events : NULL,
+			.num_event_specs = irq > 0 ?
+				ARRAY_SIZE(sysmon_supply_events) : 0,
 			.datasheet_name = label,
 		};
 	}
@@ -244,6 +895,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 {
 	struct iio_dev *indio_dev;
 	struct sysmon *sysmon;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
@@ -256,6 +908,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -265,13 +918,40 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ret;
 
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (irq == -EPROBE_DEFER)
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
index 0c0c89f6e0c..2c6cea64ddf 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -11,6 +11,8 @@
 
 #include <linux/bits.h>
 #include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct regmap;
@@ -18,12 +20,24 @@ struct regmap;
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
 
@@ -35,8 +49,12 @@ struct regmap;
 
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
@@ -46,11 +64,26 @@ struct regmap;
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
@@ -60,6 +93,17 @@ struct sysmon {
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

