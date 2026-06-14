Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2E38645E;
	Sun, 14 Jun 2026 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480264; cv=fail; b=gl9ndd7sL9VttZy0xY03/VetMusyCGi4LsR5k2HuqTrFaIeXt7VHyeoG4QGZQqMi97GuO55r54ygrXIpfAUzo84BgFwBapxTnLqaPNWZfUVKLV6/jfFAne4iaLvet6aPI6/c2tbKFIr1iyUZ8zbdWJfGeRHB3AEZnaYblDoHFLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480264; c=relaxed/simple;
	bh=twrZjnBcMC6BWoXNHTT2RVNWb3tmXenxlRW83DHvXzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuRfTs1holaVJkvOn/84GVVsKNhZUp9Yp9D65+MiiOoDnPPsqUMv9pZk2NQKapXmOMKiWO8mRNixyIB35FUvX8oxJAhU8zDGDi50qhkcT0pyRtAC+hZgJ0KdLOmaqCn57JOv/Dmw+n0hBFoSdRiHVAKvNL+JAG7cvMZ+fX/0lb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u++u8ulM; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u++u8ulM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tinSrySGe88N+6J7Mqg397e8HRSyzC1RYK78TNF9Ac2cgIZu9qhXJPTIkjiD2XS6RDR9fYcN2IZIF/ZsL/X7/AgPctKyNcpP0//zpvXTXA1UXp/ecl1gofcI3MvD/uzpJsa5HfwR+vU/k/f/PtBmdA/tXFjJhq+1B+Hw80m3p4m+YSg7W1Ma3aKYpk3VFYsLelSD3FNfpgwWRUW+Twu3UNclfuKPshRb2h96Hm1nojZpCgPSApCZWgkkXxzjXr4ACIxEC6dHJ400jllLogp4lo5aNm7ZBKm7g+iOfLJslcd8NtNMeV5uXWRsVYYHaKalNuw7eD07aVojORvdAHjmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhtxVJSv5nCUMizXQqwxUKK73ENTOltE8qu2mmFWEUA=;
 b=I22ZTzapdZk1tWNi+1aDldqKOpNm2ETUNr53IYQEvx7+sD24ud63khwAQTlFFK2Y/VK0gd5wuzmIk0egdP+wMf9YokMUd5wG4/oMirWNItLsLPMx+Y/ux4ftUZxOLjNzXQsTqtxo3AasvYHGLCXAqO456GQwTmENTDvXcWiZ0dqyhXaI5PhV+7g0nNVVBAitkB95fa50c4WxL+tSYGXebmboUlWSOcD2CyRDzfjj8K4g0OuEmIIwB6TTalaeP2Qhd/vBBw8w4uFEeVXCSS3CBwQI35C9Ng57bJmG4OWsxOnfi165GjwGXSAngTENJCjqQ/sG4vhLrq4npqmmviYzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhtxVJSv5nCUMizXQqwxUKK73ENTOltE8qu2mmFWEUA=;
 b=u++u8ulMEwjiDj1pBBs/NuPcs+U/ZqdXsmVlhTi60r1Wo50/pRtJFooiE8Zp7cFKbRa/BUEU1XlBCGeFbUY2C5mbJWBcnwodouKUKbjgJrtc67N+Ly19M2F5Y3W1UdLKRhzsoyQdd56m9Fmc9CT5k3EuETuUWKrFfq7tSdRhrpQ=
Received: from SA1PR04CA0008.namprd04.prod.outlook.com (2603:10b6:806:2ce::13)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 23:37:33 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::2) by SA1PR04CA0008.outlook.office365.com
 (2603:10b6:806:2ce::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Sun,
 14 Jun 2026 23:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 23:37:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 18:37:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 16:37:32 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 14 Jun 2026 18:37:31 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v7 4/5] iio: adc: versal-sysmon: add threshold event support
Date: Mon, 15 Jun 2026 00:37:21 +0100
Message-ID: <20260614233722.2603459-5-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614233722.2603459-1-salih.erim@amd.com>
References: <20260614233722.2603459-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b13498c-be9d-498f-fd46-08deca6de872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|6133799003|3023799007|18092099006|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JmFb9+YWspdScTQ3HCVWStymvpjcsHb6DwHndOsKcWFgeUhDsHcHf67Rnb+Paf+N6LOpjVwdTA9byZYSrc6TMv0Jy7re5t/DSlpeV7zgB69bxestWmroXRfo2E/uHBdhWO2zQJcpSkDLwkeUx7qP2wI8jkiWs0KpKpQnz6DxrMbBzFPo0kY+axGz7X7LQ9rBlbr7DCjbBwEB9IpUPgLQE6/uEqEocprzsfwan0cUd145xuTAzozst5G4Sqn1qg8vjf7aQRFS9tqDQ/d5Ri27PoWBOj3qrL0tydm2QIECYQ71GhKvzBH2qYCrcnfofHhlnplMcQaC9U1dP3tYthW3m+GJsdKobtozEVlywFfUrW8dr7s3NFN+5ETnu8WySSw7TwJnFn8rqFDpiIqlZyVzOXNXveKKbsHYtHYe2Gs/EayqwggnDBu4ARXsgpOLfrwWuju1fCL9xUgr63dxx5eo1Ay54EEoSmUI/QVCsnYQ4fwH5k59f6rmyrF2YznLJTy1kuEfjo0Vt0nwnrQ7+cOG6hNNcQ7FiZrtlgZiisE3GGoOFxjUJniT4WW18ysHPXYlQ5T0flxVt5MqlXlC1mbKlMVArauhylO1MeoU2eGb5Da4NATToXmexYvyWOJS1vmrMze+8JHpx2eg2x3MdiP5Cb5pH6dswdE1HZCRd6QfTR6ZsvmJz0B+14ns6Up141JTuxP6Vm4VyNzEwBCXhWnro4tbz9YrHXpr6Nm03zcFGqs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(6133799003)(3023799007)(18092099006)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	doZwuXYjzhVrkc4iJ3MDEhqYpFSBRIETPH9J4QMJ9Zm2Jy3MvBv7QPni1kWVwppw40oG2tQUrGkb5lzCSHdtRwWKlmZDvtwS+qAMw5s+YqUYuSG/6Mx0AvObMG7tNay0rRoFb/oFyxErYpFWkst+/AZgniz1+kUpl0tn463pH7squK7PmoOWsY9goCagXxwMFnGPHmqz5QDWvK8XQMS6dHa0C/MRrLnP+WpgpCHduESIqa9W7zcXmvY/q7/BIzRmGMRvijYV/62vojIZSOJYRIhn+ZxwKYfOYP6zuBhFfC1B/LPzGJxE9ez6eoFBMVv3zi6myUyxyPuQrOCREv1lUL5pIkCFwii8SCOIz6WXa54fupXsv6/1ir3q68KzUU9kThQpm1B/1h4t5fvgO2ohNPf2yg7nPYdYcQovf+GDvmc9hI9vdPTRIea6KEDEG5TA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 23:37:33.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b13498c-be9d-498f-fd46-08deca6de872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

Add threshold event support for temperature and supply voltage
channels.

Temperature events:
  - Rising threshold with configurable value on the device
    temperature channel (current max across all satellites)
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

The hardware also provides a separate over-temperature (OT)
threshold, but it is not exposed through IIO as it serves as a
hardware safety mechanism for platform shutdown. OT will be
exposed through the thermal framework in a follow-up series.

The interrupt handler masks active threshold interrupts (which are
level-sensitive) and schedules a delayed worker to poll for condition
clear before unmasking. When no hardware IRQ is available, event
specs are not attached and interrupt init is skipped, since the
I2C regmap backend cannot be called from atomic context.

When disabling a supply channel alarm, the group interrupt remains
active if any other channel in the same alarm group still has an
alarm enabled.

A devm cleanup action masks all interrupts on driver unbind to
prevent unhandled interrupt storms after the IRQ handler is freed.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
Changes in v7:
  - Move TEMP threshold event onto channel 0; drop OT as
    separate IIO channel -- OT is a hardware safety mechanism
    better suited for the thermal framework follow-up (Jonathan)
  - Use single temp_channels array; attach event spec to
    channel 0 at runtime when IRQ is available, matching the
    pattern used for supply channels (Jonathan)
  - Remove sysmon_temp_thresh_offset; use SYSMON_TEMP_TH_UP
    and SYSMON_TEMP_TH_LOW defines directly at call sites
  - Return administrative state from temp_mask in
    read_event_config instead of transient hardware IMR
    (Jonathan, Sashiko)
  - Add devm_add_action_or_reset to mask all HW interrupts
    on driver unbind (Sashiko)
  - Remove SYSMON_CHAN_TEMP_EVENT macro, SYSMON_ADDR_TEMP_EVENT,
    SYSMON_ADDR_OT_EVENT, SYSMON_BIT_OT, SYSMON_OT_HYST_MASK,
    OT_TH_LOW/UP registers, ot_hysteresis from struct
  - Simplify sysmon_get_event_mask, sysmon_update_temp_lower,
    sysmon_init_hysteresis -- all now operate on single TEMP
    channel only


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
 drivers/iio/adc/versal-sysmon-core.c | 616 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  36 ++
 2 files changed, 644 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 5b7439e443f..16feb373bc7 100644
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
@@ -19,10 +21,18 @@
 #include <linux/sysfs.h>
 #include <linux/units.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
 #include "versal-sysmon.h"
 
+/* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
+#define SYSMON_TEMP_HYST_MASK		BIT(1)
+
+/* Compute alarm register offset from a channel address */
+#define SYSMON_ALARM_OFFSET(addr) \
+	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
+
 #define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
 {								\
 	.type = IIO_TEMP,					\
@@ -34,6 +44,45 @@
 	.datasheet_name = _name,				\
 }
 
+enum sysmon_alarm_bit {
+	SYSMON_BIT_ALARM0 = 0,
+	SYSMON_BIT_ALARM1 = 1,
+	SYSMON_BIT_ALARM2 = 2,
+	SYSMON_BIT_ALARM3 = 3,
+	SYSMON_BIT_ALARM4 = 4,
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
 /*
  * Static temperature channels (always present).
  *
@@ -51,6 +100,16 @@ static const struct iio_chan_spec temp_channels[] = {
 	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
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
@@ -68,6 +127,34 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
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
@@ -114,6 +201,265 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static u32 sysmon_get_event_mask(const struct iio_chan_spec *chan)
+{
+	if (chan->type == IIO_TEMP)
+		return BIT(SYSMON_BIT_TEMP);
+
+	return BIT(chan->address / SYSMON_ALARM_BITS_PER_REG);
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
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int imr;
+	int config_value;
+	u32 mask;
+	int ret;
+
+	mask = sysmon_get_event_mask(chan);
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
+		return config_value && (imr & mask);
+
+	case IIO_TEMP:
+		/*
+		 * Return the administrative state, not the hardware IMR.
+		 * The IRQ handler temporarily masks the interrupt during
+		 * the polling window; reading IMR would show it as disabled.
+		 * temp_mask bit is set when administratively disabled.
+		 */
+		return !(sysmon->temp_mask & mask);
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
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 ier = sysmon_get_event_mask(chan);
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
+static int sysmon_update_temp_lower(struct sysmon *sysmon)
+{
+	unsigned int upper_reg;
+	int upper_mc, lower_mc;
+	u32 raw_val;
+	int ret;
+
+	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
+	if (ret)
+		return ret;
+
+	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
+
+	lower_mc = upper_mc - sysmon->temp_hysteresis;
+	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
+
+	return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
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
+			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &reg_val);
+			if (ret)
+				return ret;
+
+			sysmon_q8p7_to_millicelsius(reg_val, val);
+
+			return IIO_VAL_INT;
+
+		case IIO_EV_INFO_HYSTERESIS:
+			*val = sysmon->temp_hysteresis;
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
+			sysmon_millicelsius_to_q8p7(&raw_val, val);
+
+			ret = regmap_write(sysmon->regmap, SYSMON_TEMP_TH_UP, raw_val);
+			if (ret)
+				return ret;
+
+			/* Recompute lower = upper - hysteresis */
+			return sysmon_update_temp_lower(sysmon);
+
+		case IIO_EV_INFO_HYSTERESIS:
+			if (val < 0)
+				return -EINVAL;
+
+			sysmon->temp_hysteresis = val;
+
+			return sysmon_update_temp_lower(sysmon);
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
@@ -127,24 +473,244 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
+		sysmon_push_event(indio_dev, SYSMON_TEMP_MAX);
+
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
+		if (ret)
+			return ret;
+
+		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
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
+static void sysmon_disable_interrupts(void *data)
+{
+	struct sysmon *sysmon = data;
+
+	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
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
+	ret = devm_request_irq(dev, irq, sysmon_iio_irq, 0, "sysmon-irq", indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, sysmon_disable_interrupts, sysmon);
+}
+
+/*
+ * Initialize the cached hysteresis for a temperature channel from the
+ * current hardware threshold registers: hysteresis = upper - lower.
+ */
+static int sysmon_init_hysteresis(struct sysmon *sysmon, int *hysteresis)
+{
+	unsigned int upper_reg, lower_reg;
+	int upper_mc, lower_mc;
+	int ret;
+
+	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_LOW, &lower_reg);
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
 	struct iio_chan_spec *sysmon_channels;
+	unsigned int num_supply, num_temp;
 	const char *label;
 	u32 reg;
 	int ret;
@@ -157,14 +723,21 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 		device_get_named_child_node(dev, "temperature-channels");
 	num_temp = fwnode_get_child_node_count(temp_node);
 
-	num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));
+	num_static = ARRAY_SIZE(temp_channels);
+	num_chan = size_add(num_temp, size_add(num_static, num_supply));
 	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels)
 		return -ENOMEM;
 
-	/* Static temperature channels first */
 	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
-	idx = ARRAY_SIZE(temp_channels);
+
+	/* Attach event spec to channel 0 when IRQ is available */
+	if (irq > 0) {
+		sysmon_channels[0].event_spec = sysmon_temp_events;
+		sysmon_channels[0].num_event_specs = ARRAY_SIZE(sysmon_temp_events);
+	}
+
+	idx = num_static;
 
 	/* Supply channels from DT */
 	fwnode_for_each_child_node_scoped(supply_node, child) {
@@ -188,6 +761,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
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
@@ -253,6 +830,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 {
 	struct iio_dev *indio_dev;
 	struct sysmon *sysmon;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
@@ -265,6 +843,7 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
 		return ret;
+	spin_lock_init(&sysmon->irq_lock);
 
 	/* Disable all interrupts and clear pending status */
 	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
@@ -274,13 +853,34 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
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
+		/* Set hysteresis mode for temperature threshold */
+		ret = regmap_set_bits(sysmon->regmap, SYSMON_TEMP_EV_CFG,
+				      SYSMON_TEMP_HYST_MASK);
+		if (ret)
+			return ret;
+
+		/* Initialize cached hysteresis from hardware registers */
+		ret = sysmon_init_hysteresis(sysmon, &sysmon->temp_hysteresis);
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
index 0c0c89f6e0c..ca3df017dbb 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -11,6 +11,8 @@
 
 #include <linux/bits.h>
 #include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct regmap;
@@ -18,12 +20,22 @@ struct regmap;
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
+#define SYSMON_SUPPLY_TH_LOW		0x1980
+#define SYSMON_SUPPLY_TH_UP		0x1C80
+#define SYSMON_TEMP_EV_CFG		0x1F84
 #define SYSMON_TEMP_MIN_MIN		0x1F8C
 #define SYSMON_TEMP_MAX_MAX		0x1F90
+#define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
 #define SYSMON_MAX_REG			0x24C0
 
@@ -35,8 +47,12 @@ struct regmap;
 
 #define SYSMON_SUPPLY_IDX_MAX		159
 #define SYSMON_TEMP_SAT_MAX		64
+#define SYSMON_NO_OF_EVENTS		32
 #define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
 
+/* ISR/IMR temperature alarm mask (bit 9) */
+#define SYSMON_TEMP_INTR_MASK		BIT(9)
+
 /* Supply voltage conversion register fields */
 #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
 #define SYSMON_FMT_MASK			BIT(16)
@@ -46,11 +62,21 @@ struct regmap;
 #define SYSMON_FRACTIONAL_SHIFT		7U
 #define SYSMON_SUPPLY_MANTISSA_BITS	16
 
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
+ * @sysmon_unmask_work: re-enables events after alarm condition clears
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -60,6 +86,16 @@ struct sysmon {
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
+	struct delayed_work sysmon_unmask_work;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

