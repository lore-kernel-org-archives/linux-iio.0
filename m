Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81383E4C8D;
	Mon,  8 Jun 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943896; cv=fail; b=kC9WbNafChOZvZU1TOzaLByntet+HsMFWKamrgE6tWCE+abozeTIpTz2nvn5HCuP0Pbq7RnVDkNRD7slxgzxMWuCd8JP1QGWoJ+9MnT0M70iMRIQ4LhyniYhSw+Lb7anSk2AhVuvq74onjO9jLXiqTMCnfKeiXbmYxQYHXWtQr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943896; c=relaxed/simple;
	bh=upZ3s09Phuo4UKrYViYs8ROJv+74EceCAzULeqiEMwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aXJ869gj16c0B1jjoUHtbXCZKuBaajyeEf3lzTNKJkS1n6EozrLLBsg2s/RC38XYhHSXRvPH8pUmLYa5fbZ4VJOdpMIHFXpIMJRtEuGvbdQbRQZVyiCnJ4UBs5WkZ5WtUlXRNY/iu8EIe6tewI97R9GUYfEKg4JaZWW9GNSID/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AhxT+Bpn; arc=fail smtp.client-ip=52.101.46.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AhxT+Bpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/VhXRAIbhe4e+DJHA4poazjrdbLZmp45oMq/dlRlj/K4L8TumRwuKVykwaFuecsEEJ3DkuXj4+8mPxDWNUhFiC4BsPvPF+FHJlXGNScG19pjSY23HKTshon9xjBg8En46CH54nSfK4bWZIOprhHj2FoOjJXPkaA2wzmfpHP3ltADTqbB/TASYxQAaA9cO1G4gppnr1So2jHwdVpq6IOTAoaTaRavDN9z1ICFvvlWY0XZVnbsrq3JygqhzxgvNpD7ZcXwsFTHcnFlEU+WVkxsUe7ZVv167fzXslL17CgtjRKqYtn6t8+TQLlmmIlsa5oZCXwoESyyP1jX3oQy69RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMfqLw/T2zLySLYtT0vZV9SqRIXA9NwFOrZBqArPSw4=;
 b=FL/sWSay8jDHKcBvxo8JyU9Rv+uJmZbE+jIR0XvH4O6gGGTyvGGty+yt/c3vBEnxHTSk1aZB+dSOArqSVKc+Fy+6JqrAG1XkGo5LraX82GU8Y4+SmiDwBe2WvOEP37aQxwftYreib3vHP4uEzONOJ7Xrr5GCtJiHW0cOoqmV8OSKokJJTKqlUgUr7zY97D7Cn9pwqieL+as4axvQJT3wY6qzuAdhmwsb3WbHgREJd4csNppegEU95zhR1GHjpBilFF6JYT5pcWdIV/7cZox7uPx0m2JQtTbQ5Qu1JIp+3TDybb3MAC4ubND4zgV505EjDzm3qCQpWxfJfOeW5jIpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMfqLw/T2zLySLYtT0vZV9SqRIXA9NwFOrZBqArPSw4=;
 b=AhxT+BpnqQYu3ECK7IlsHa8r+TZ3D/wFoE+SwuxCd9lxfgZo6pPAUm09exh09feQrail5iMYVD6kCC7XxcpM7WN4uHGoHrkdrLea2cnuPxIOMM+2j0eZzqURLQHHjpGOooIBh0ZYehVZ3zfPTvhcnVaVzhRugVJZt61OHKpQ3/g=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:38:06 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7e) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 18:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:38:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 13:38:04 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 13:38:02 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v5 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Mon, 8 Jun 2026 19:37:56 +0100
Message-ID: <20260608183801.1257051-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbf2cc3-f43a-45db-7fe7-08dec58d1502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|13003099007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zgdodeAsbQKL3QUIEx5/608+U/RfLudwaYE3AzuCtFWPL3xiGGty2LqM79PErs2jXwRDy9uyH/ey2x+EiFrAwCpeEhzT4QFz8wpOLEEZqyVh17eQc/Ict22TJdjsEr4R+iaAFee5VnGUKDSi/BA3p52ZnfEOFkaQzPpDKkX3LXnQSxoaFZFMDabcloRUxRu3xsBjQwHPU5tmZutqXwEmB8kPPWYrUYFMQ+CRYji3v1RbtPO0uhlG7WwwWXz+k8CNd5pBphVfEiMMyqJehT/2kbIhgeIeSKk3Lh30em4QCpQUZqzGI32qIukLblcPBY4OE7K6DP3EIG1NwDVMLGCLr0mgI8MPNzX0piikqDLfJMBH4BIikmPiXqm6CdL4DwJaykgZFYl+oD0XMuRQVw7OMMKSQMrY1mDMzY5oUruP0v3r56sBAjkSfXE26UvRZWzuVMn2FiJB3DwUeBPH4uSufPvH9hquQOYTeSDxmw1uYoc5+Y/rHe+QexivZkYczou/c5mXyeQdeV+BjWCoUaboTbPxLdHSDlRvFjhEQZS3WtlQNOnmRwn1AUGQsMaCA51XWrPJmPXghFjXBqxcNp/AMu4+6zG0YDH8nPiQf759ga6JbyAPwDFVLlHvDfop8VHVWqpyVxueaHZodXhKLhfZBFo9SIpToZsLSsXBhDmpSpxK0YQGP5KSOo23QQO9eD64S3sVpSsJR4bAFMPnP1v3c1Gv+Gb7onY6h81hha/95pU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(13003099007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MshsWrg3Ef8KnEz0gpIuEuHFVADYmDl3W9PeBqggTvcgpJcO4khFJAHcU31cDIAe84nBsHwGd/ajrc7k3kEQ0di6vToWoeZLNRWR3zZpCt2ysktoEOaDKGzALHB7hwrLUmSc7g6fJcoqyjqfji1X9iEZ8MOmb9VJ48SbyC+65xs9BJwUioc5qMmJKab0j6Rx1DQHAYHuG5yhJf0LG0jlaHu1Lad5JfDUFWpibLfY0Ncb0BMwRozcFVxHamk6zyRxO24YWA/lPU2sKouMm8mQD/uTiYC0vAPfa6sAZJDJW7kHK48eOXoY6mafCDQUCIqTdZdy+DnBFcxUTtd0XyhcFqeKiqT0hF36ApdUlGrXMn8j8ZIyrSTZXRVcEr+S2zgN8t7OGUkqt8jJVdn0T+/IQL2P3FKc6TwFRdcWMMCCVpYtZYDjjS3pA0N/QzIOenIT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:38:06.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbf2cc3-f43a-45db-7fe7-08dec58d1502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

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
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

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
satellites) and VPK180 (System Controller, I2C path, 7 supplies).

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
 drivers/iio/adc/versal-sysmon-core.c          | 1092 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  127 ++
 drivers/iio/adc/versal-sysmon.c               |   93 ++
 drivers/iio/adc/versal-sysmon.h               |  129 ++
 8 files changed, 1638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

