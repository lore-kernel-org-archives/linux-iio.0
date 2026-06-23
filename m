Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3B36B061;
	Tue, 23 Jun 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178850; cv=fail; b=r9Ik0WBtkVv3F4hbbjPi9HoOGZF6gTvBpeeBB+sSFks1AJpeJ+dpvQyXytTmYh25oQ/sB18Zr9FwuvFdOCIdcOtOjfaPLaImjQ5HnXD3FaOFEIWtf3uS5PAYpeYlgHL+kCgku1O3Q8cQfFxKcVMgvqIIZSISLYBOLRN1BXRVPdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178850; c=relaxed/simple;
	bh=kfDb8vuezmxFeJD5d5FgVqm77qIa//+qjypnO3iXSE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8PlE9sLgPzX5qrz1jGaVk9VMpHTFltwRMiNSzwbMQZb5Uoq5U9NZYHO3nRKSL1yWaP8CY0rWFhXAl5wfqP3OF6aPI2Q3ggAsNcviY9MdyfAVhTfeaz/tnNFLYtrIfQlrliwH6Ax4TiPqNqVCpLcV+Z84a1br7Tfafsy6FXzpFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zs6xq/e8; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zs6xq/e8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLhB9Z/HuIocbqgwFr/jRSFqfll/GmyoxOI0l2R0kFyNmMShaoxZraswmZiT0T3rWtxOAqS8DIx3pLIkCOyMPSIIWqcxbbKePTYCMMcDeOEBW73f9CcnNewiDYzKuyfTYepC2JDyAwB9QTmr1xwYesIyIxAylCG+eEOCHb0JC/mpJeYFaPFZTT6GGUyx5NN4y7DdT/sS579dbMxlmVH8QbL/o5RGTK/e440P17CjIlRhZvh/Hq9I0cSSN0yZngVrSmeIEpLI9/it7DVpDDP+01M8gvgMppltgow/qojP1Yeyb5Z9WG5Oc9KA6SF9apLj42SH7DCWK2CfawxYK5oUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOXc801FE/3CKlg8MsHYgawbKW508wNZiYuIPh5YHzE=;
 b=xmP5wyfKSl1z1fwWvdeX4+34bVFl9oUJf21sI/CtCwCeEeJgxZTduLDdyj78tuepBURIMld5DPBllu0hpBkGcB7F43Ksc4HTrgBXJrABAk94ALjXLw3UnqAuMvcMIUcNuvPg5AiKxe5JZihaJpVCoQXmx4/kUbq7/m7k1RhmTPsFheqW5xl3/Xdv3aTT6K6vNMRncFdAd0AYlfC201MqhG0fgOxX8iSRG8oGC6ViNBz20USQbRJV3leumm62xbH7X+4ve1bILoHb3/q5tdiSVYr8l/gOYIMChJuStWtbUGrxVwCLQa3Hf1OdGJfWNnQ01po4eRYS03UmMLqEKiG7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOXc801FE/3CKlg8MsHYgawbKW508wNZiYuIPh5YHzE=;
 b=zs6xq/e8NU3u52Z+xkgaxTIZMeKDdUtBEm6eTq1lIxtIn19Qko7zWkqHMSbp0osz5lCtc3Jal7GNuGFZuJLrxxzFE5G9OIDRDe5SlaLfz/nUX/i/Xyj1NLALDzwf780Scg5YZyHm8ed2vUSMrTTigLnGFAr50G+l8Yz0TLb/yz4=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 01:40:44 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::65) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 01:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 01:40:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 20:40:42 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 22 Jun 2026 20:40:41 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v11 0/5] iio: adc: add Versal SysMon driver
Date: Tue, 23 Jun 2026 02:40:31 +0100
Message-ID: <20260623014036.3865402-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5675bc-d22d-4fed-a85c-08ded0c870d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|82310400026|23010399003|376014|13003099007|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YNeMB2qmcnF7LuuMRgRFANgBJhm42KPR3dZ64+0oyKkbjzgUvN9KpCBlOH57siuULLtBaLKUNC+xEwTwUK/XkJUNjbTJQBl3xgEW2psG7Ho1B5c7Lm1j5nfTbPE60Ai4SkAiZUseS4llcBmLoP2ThapyBnfnJGNWm6Q9qsVA4T3P8mzBkk6saYwziByGZEct6Gzppne2cRqgj0/vP5bSGQ8kH4mpedlxeX63T9oeGe9PEf+6EmdxuH9pi67U7ablpgMJ3wmJGwY4ckPBfK6FKXIrySSjU+tvXN7eSUdcM4wvzZklNe3OSAG3NGJ/T6ov/U4Bt70hemMX494eQZNDXRK8lGOIerwS+aQpWngdEE36fD3k2BgTa0RZov6bOje66Z5Dh7/L64JY7sHZJoLMZCF+mnPvttnYo4tijJxvIraAtDxztFP2DoDB/fYr9SeExGXPipU+ja8pY6JIN5Se7YSUNU9IqboZeHw4swl4kUJtp92usfxQ79rxX91Wok9q3eSUV3trMamX4Xi5+BhGmH2yLxTNZXtlAbBI812iWUU61IKAXk892XI+cQ/24cAdIpAIRCnuLsKd9jJ+nV/tbUY8jpZQgawOvuDpbJhfrnHNDCj/CXDZzNhpsg2RZBhtNgxVpxqQxgekW+m6vxGpcgi+NS2nJ7A+sZuZS0d5zGlBKAjOg6CSc3cNXYU1MKDeADC0gxI2Fg1MAF0R9xZIXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(376014)(13003099007)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u49bglWfVt6ztoo/ovtt0zIHrdfKjmJRIyez/eImXXCxpIUgtHAmaXm9CQnRwfouQssNtBlBlu75i3VO52twUUc/iBDqlLLwEZPiiuEmmNI/PW7vfp+HtendJVbHtr6lik7SuBPRfmNlXuMGZYmutWkzU58W/JGF+fFd2qBpqYXw8P3yR38TNxZjcG0uZpsqTpYNDAYeR8jRPq5tUeCHgVjEOVePYwbS8SBEyFYYhLUATc+PcjvseaGrdkK8s42nURlv/e2s4l3ckR0BxlruYx59OxPKjQ3M8crwYDedV8CmajjRflIEVO2baA/dBQ9Wh7hRmMMrJlpX8292k/m+49I1QNdcUyN/F/EGyGF+VzIgZksh29CdD9p/q2sgRPQZUcJHsReALz1psoXNkz7n079P5DrLzEn49ui2QbY5/+vOtMO4QkCnv7CshbdneyFv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:40:43.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5675bc-d22d-4fed-a85c-08ded0c870d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249

This series adds a new IIO driver for the AMD/Xilinx Versal System
Monitor (SysMon), providing on-chip voltage and temperature monitoring.

The Versal SysMon measures up to 160 supply voltages and reads up to
64 temperature satellites distributed across the SoC. The hardware
also provides aggregated device temperature registers: the current
max and min across all active satellites, and peak/trough values
recorded since last hardware reset. The device can be accessed via
memory-mapped I/O or via an I2C interface.

The driver is split into a bus-agnostic core module using the regmap
API, an MMIO platform driver, and an I2C driver. This allows the
same IIO logic to be shared across different bus transports.

Previous submissions:
  v10: https://lore.kernel.org/all/20260618101414.3462934-1-salih.erim@amd.com/
  v9: https://lore.kernel.org/all/20260617180147.3370346-1-salih.erim@amd.com/
  v8: https://lore.kernel.org/all/20260616131559.3029543-1-salih.erim@amd.com/
  v7: https://lore.kernel.org/all/20260614233722.2603459-1-salih.erim@amd.com/
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v11:
  - Add input validation for threshold event writes and clamp
    computed lower threshold to Q8.7 range (Jonathan, Sashiko)
  - Add oversampling info_mask to static temp channels (Jonathan)

Changes in v10:
  - Address Andy v9 nit-picks: limits.h for IWYU, variable
    declaration grouping in P2 (Andy)

Changes in v9:
  - Address Andy v8 review items: symbol namespace, function
    signature joins, minmax.h, variable naming consistency,
    num_static move to P2 (Andy)

Changes in v8:
  - Address Andy v7 review items: MILLIDEGREE_PER_DEGREE, overflow.h,
    devm_versal_sysmon_core_probe rename, volatile register comment,
    regmap_test_bits, unsigned int for osr_write, ~0 instead of
    ~0U (Andy)
  - Fix devm teardown race in interrupt cleanup (Sashiko)

Changes in v7:
  - Move TEMP event onto channel 0; drop OT as separate IIO
    channel; use single temp_channels array with runtime event
    attachment (Jonathan)
  - Return administrative state from temp_mask in read_event_config
    instead of transient hardware IMR (Jonathan, Sashiko)
  - Add devm cleanup to mask HW interrupts on driver unbind (Sashiko)
  - Add documentation comment for static aggregate temp channels
    (Jonathan)
  - Split sysmon_osr_write into per-type helpers (Jonathan)

Changes in v6:
  - Address all Andy v5 review items: switch(chan->type) in event
    functions, reversed xmas tree ordering, macro brace placement,
    scoped_guard in unmask worker, combined regmap error checks,
    join single-line constructs, IWYU header fixes (Andy)
  - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER; treating
    all negatives as fatal broke probe on I2C nodes without
    interrupts property

Changes in v5:
  - Core: add err.h include (IWYU) (Andy)
  - Core: drop (int) cast on MILLI in scale assignment (Andy)
  - Core: sign_extend32() instead of (s16) cast (Andy)
  - Core: remove unneeded parentheses in voltage address
    calculation (Andy)
  - Core: drop NULL checks before fwnode_get_child_node_count
    (NULL-aware) (Andy)
  - Core: nested size_add() for overflow-safe allocation (Andy)
  - Core: if (ret) instead of if (ret < 0) for fwnode property
    reads (Andy)
  - Core: remove outer parentheses in satellite address
    calculation (Andy)
  - Core: loop index declared in for() scope (Andy)
  - MMIO: add err.h, types.h includes (IWYU) (Andy)
  - Header: remove unused types.h include and struct iio_dev
    forward declaration at P2 stage (Andy)
  - I2C: add err.h, mod_devicetable.h includes (IWYU) (Andy)
  - Events: clamp() instead of clamp_t() (Andy)
  - Events: regmap_assign_bits() instead of separate set/clear (Andy)
  - Events: remove unneeded parentheses (2 places) (Andy)
  - Events: for_each_set_bit on single line (Andy)
  - Events: regmap_clear_bits() instead of regmap_update_bits() (Andy)
  - Events: simplify unmask XOR to ~status & masked_temp (Andy)
  - Events: add comment explaining unmask &= ~temp_mask logic (Andy)
  - Events: split container_of across two lines (Andy)
  - Events: move ISR write after !isr check (Andy)
  - Events: unsigned int for init_hysteresis address param (Andy)
  - Events: add comment explaining error check policy in
    worker/IRQ (Andy)
  - Events: nested size_add() for overflow-safe allocation (Andy)
  - Events: propagate negative from fwnode_irq_get() for
    EPROBE_DEFER (Andy)
  - Events: pass irq instead of has_irq to sysmon_parse_fw (Andy)
  - Oversampling: remove unneeded parentheses (Andy)
  - Oversampling: use struct regmap *map local variable (Andy)
  - Oversampling: switch instead of redundant if/if on
    channel_type (Andy)
  - Oversampling: add CONFIG register readback fence after
    oversampling update to prevent NoC bus hang from posted
    writes (found during hardware stress testing)

Changes in v4:
  - Core: temperature channels use RAW + SCALE (IIO_VAL_FRACTIONAL,
    1000/128) instead of PROCESSED; voltage channels use PROCESSED
    only, drop RAW; drop scan_type from all channel macros (Jonathan)
  - Core: move __free(fwnode_handle) declarations down to just
    above use; devm_regmap_init() on one line; lock comment
    describes RMW sequences and cached state (Jonathan)
  - Events: merge event channels into static temp array -- two
    arrays (with/without events) selected by has_irq; event-only
    channels have no info_mask (Jonathan)
  - Events: blank lines, fit under 80 chars, default returns error,
    return early in each case, guard(spinlock) in IRQ handler
    (Jonathan)
  - Events: take irq_lock in write_event_config for temp_mask
    updates (Sashiko)
  - I2C: replace enum with defines, use unaligned accessors for
    data and register offset packing, named initializer in
    i2c_device_id (Jonathan)
  - I2C: drop bitfield.h, add unaligned.h
  - Oversampling: return directly, remove else after early returns,
    rename mask defines, blank lines (Jonathan)
  - Oversampling: move oversampling read inside guard(mutex) scope
  - Fix v2 lore link in cover letter

Changes in v3:
  - DT binding: single compatible, voltage-channels rename, single
    quotes, drop label/bipolar/xlnx,aie-temp (Krzysztof)
  - Core: IWYU throughout, __free(fwnode_handle), sign_extend32(),
    size_add(), dev_err_probe(), s16 param, remove (int) casts,
    drop SYSMON_MILLI in favor of (int)MILLI, rename _ext to _name
    in SYSMON_CHAN_TEMP macro (Andy, Jonathan)
  - Core: fwnode_irq_get() moved to core_probe, remove sysmon->dev/
    indio_dev/irq from struct, describe protected data in lock
    comment, add RAW+PROCESSED comment (Jonathan)
  - I2C: IWYU, remove wrapper struct, explicit enum values, sizeof()
    for buffers, = { } initializers, adapt to core_probe interface
    change (Andy, Krzysztof)
  - Events: IWYU, FIELD_GET/FIELD_PREP, regmap_set/clear_bits,
    clamp_t, !!, IRQ_RETVAL(), devm_delayed_work_autocancel,
    loop var scope, error checks, remove redundant else, logical
    param splits, spinlock safety comment (Andy)
  - Events: hysteresis rework -- store as millicelsius, hardcode
    ALARM_CONFIG to hysteresis mode, compute lower threshold from
    (upper - hysteresis), remove falling threshold for temperature,
    single event spec per channel with IIO_EV_DIR_RISING, push
    IIO_EV_DIR_RISING for temp and IIO_EV_DIR_EITHER for voltage
    (Jonathan)

Tested on VCK190 (single SLR, MMIO path, 7 supplies, 10 temperature
satellites). I2C compile-tested.

A follow-up series will add thermal zone integration, secure firmware
access, and I2C remote monitoring.


Salih Erim (5):
  dt-bindings: iio: adc: add xlnx,versal-sysmon binding
  iio: adc: add Versal SysMon driver
  iio: adc: versal-sysmon: add I2C driver
  iio: adc: versal-sysmon: add threshold event support
  iio: adc: versal-sysmon: add oversampling support

 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  |  154 +++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   33 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/versal-sysmon-core.c          | 1052 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  134 +++
 drivers/iio/adc/versal-sysmon.c               |   92 ++
 drivers/iio/adc/versal-sysmon.h               |  120 ++
 8 files changed, 1595 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

