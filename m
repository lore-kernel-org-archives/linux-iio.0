Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601F33F374;
	Wed, 17 Jun 2026 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719321; cv=fail; b=XKkxXQ2VhDufMxj2mMLGotUoH0lH3V3HRGw2bGv/Bnkwvhh5G0hv6zjkonV+eVnZv3TeFDCneP2jszHFzqozLAZKJDNWZjCk7vDQa8PTYWLJPiC4ZdG5pPsSRRvlq4++ltk6We14xfrXALk6o1I+vkrpU3ffffwx6lZwijxcq6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719321; c=relaxed/simple;
	bh=FsoZN0JZEOrWaMk7dYHFM3ucC/2T8P8ghZTXlnWbfxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KckUjsSD8MUo2S+VR7I1NB5RwyuJFBcKPNFZaAfCEKu2TJJzcp0GXB8BRYZXxIaV6tPjsEhaKfiqNOQdPuiM8rNJbV/DvOc5AtMRRi6mNj7Oza6X++EwY3vHezuDQZN6TB6A6vk2tBra5nfe/leMQJ2MOIwcO5SCDTFz+LDrrCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4e4q7lo2; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4e4q7lo2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph1dgM7XHH4abuIA3Wt/VPxtCv8Bs1NcMmV3u/xoQm++mIQrnOs9qtieKiuR5LVndCKS70pkOgPrU5zqeMwL6AqzqiPgZrsLqUZgii20ByoZSaYrjEPAsGV8j5MrIVz8RkFI9Jyi3OjkdnDu5bUVyrgddGMiFok8B15tOvV1P3Qc9UiCEpCbYpaLM31fhaFrsJC2y5fCb+QXBCd32GYTwrQ2qRrVLN+3nV8WKGKBMJiX9UATtWdzSpYDfulrrGZUOrDkeylNTpGcg6LH/fOJIpKZrqE9QJrPX1jeYXlsti+6ERLx4KRg/6guPaZwlN8EF5K824fHEPgJEp1RyXhJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AENQM5hqP8+LVgcmvRydvAhGUXb0RgaRVBPBIPplQPQ=;
 b=ewbDUwmgSVGsiT0786yzi1d59lbzYfd8n5u3UPcNQDke3jfCc0XG65sR4W96HpQSIVd2yEhBTkthJ9k9FbPsDRvgttONbYIghYnrg2QwfqBXs5wvwedcFtL89FJl0oottf9FA60R0lIlUJeXqOovKq0Vr1mAlj3LK0FgGykFGPgdhh+N4CrVRkoD+yUbXebQCYQswaQO90FNxxB+9iIxXUHj/9uSyhgsDCJcjA3CdpQp0uMnhGgVZ1BFvv/uCvjmaz7+KtPclfGwzCltRzYrqfCOK74a+9ZlyHH7i2bgjg0oNAmEKueI3boQQ1ZgDJAk+K3GmyWu4bCmD/P4OGyWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AENQM5hqP8+LVgcmvRydvAhGUXb0RgaRVBPBIPplQPQ=;
 b=4e4q7lo2hWwCETdRn2a67O9D81dWMJCBPRflgkH6TFDnPC0PAgjrp2/FPE7/xg2/dhULyA6Hn7E9XcOCEGYVf6wzWyKii6JDgLp6rJhuRP3Lh1d79d7pBJrv7VWave8pp7h1tEwbl81feajTOeyi4QGyOmyYdujPkMxD3c5Q5AA=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:01:55 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::ad) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 18:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 18:01:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 13:01:54 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 13:01:53 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v9 0/5] iio: adc: add Versal SysMon driver
Date: Wed, 17 Jun 2026 19:01:42 +0100
Message-ID: <20260617180147.3370346-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: c772a7ed-93b4-45d5-d462-08decc9a843a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ntSTsER0LZN1URgEjOYvaBccMXw+4ZulrVG2Y1FSKOnMbtuTpE1yydwEPmeBDy4Mz+eH+nHx2ybjqrNBB3ynVU6Vl4zdk7ji25U7VIFzN1CvNRUnhm8c20Jq9qCflwc1QDXrAjLkJ2PkF4PEXMW7Cypq2Zrasbjh5QbBcCIZB5ehnXZ2pgUDoYszzqX28Ww68mQOaSS7AmS1qK6nIaNW4t2HrRVwe9xKzpSYyWMd7Y81eFo2fxJShhpendO1S/0ZeEWx6+HzsHxWcgq/y39frRzEalcWmMyKZt93un/UfWpWbpyfWKaJ2kn00GoC4jC9o2iDBxMoPMo/aInEvFIybAd4m6Ei6LJRqLdyQAY6yoR2rqufbdPRaU+yCzELrlnHdtYLZuAGoleSiYomdmKpuUL8HEU+vqARpVagFcX8sG7HyC0A0Nl5+2ChZgclnlpy5lsSJ7u6pHH0KcgV52VwVbB+FNpqS00sCJ8kPbvrZvk9dF39g217j7aSI6Tm46okP3+lkF1G4kqh5jvGIsLwERu1pe3lN8cOQvNoga2kfpwyKD4jhKfP8ZpXLWiqmI5i92EZHt43QuGW9jkRyf7LFCIom3uA+dLE9lI8BQ847NGNGb/Nea0mkR+YaAviNQIRlZXvsPT0jyND8ClzApNUpFrCwM+be4Z7jbzyhvCoSHgXC/OH+Yj8lTyStzQV3oZ9W2N6ODCChPCp2O/UHPb3SMWyM0lX7IDgERgfZAlyXbw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yYJqT2kamA6ei7Vcg2Yk+WYxqbEQ5dKIsh/npbUXVZtvBM0WciFT5jnTH6ZTwBCzVvIP36SoSpJ/c4kTh+BwHWAfaH+SAutAwno/nLuFkCebgmhhnY13h2z56VnSnzgJui5NdN3Hzqf4ZDuK2xQBIL9mMvUru/wgh5jPd/3wE9hr5EjpxV+wTDQAApxvhIhd9k/eOIYpV4xB+ZxXwm2ax7dkQZrKfBjythoxIM9tGMRMAgfsI4Vd/ssbiMn4RxGmyByr1/b9roeOd3q+xMDbyIDy6xFhcbtwofgq3fYR8Zg66iT0Fs9cTDzlmWW4EbrDP+wtiZzTkhyU96Bwfsz/JLmF529NaWVT+nVwkpV+qTL1UJotc+6gy503uzQPhzDZtydSS4Kch7tC/vMv+kHF+vGITF3CKhgpbHW/S2n6awb62b1KZlY6/kUXM6f2gS+N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:01:54.7710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c772a7ed-93b4-45d5-d462-08decc9a843a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

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
  v8: https://lore.kernel.org/all/20260616131559.3029543-1-salih.erim@amd.com/
  v7: https://lore.kernel.org/all/20260614233722.2603459-1-salih.erim@amd.com/
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

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
 drivers/iio/adc/versal-sysmon-core.c          | 1034 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  134 +++
 drivers/iio/adc/versal-sysmon.c               |   92 ++
 drivers/iio/adc/versal-sysmon.h               |  120 ++
 8 files changed, 1577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

