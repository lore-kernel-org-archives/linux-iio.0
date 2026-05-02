Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B152BE03B;
	Sat,  2 May 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720822; cv=fail; b=PxdDqm7sM3l4v5jyb/Vh5NMI6RprZBlPa5bvUCFR1g48/Np11ecj3BvspJGj5Mhg++Hd8WvPdu6eOITp3Rbq3HnztjfNrk165w7GhJ6uKhkPw5P3Deg4BpdXqwNaCEyFDN20Lz0SJkMPlpPl8KkM8vrKgOjhWR4Ktj5XY0Tex6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720822; c=relaxed/simple;
	bh=4Jcy0eonmchJOsrKZZ5P+n50Gda4mOMNERTjrWRpR/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UznOtcRuyn3UbVgAW5vjUQaXQHhEAq6DJgNgRM3R5M7qxJW2RrwBzhJyO4lo6YbC6zonH/rQ1wPQ7esGUExPV78Ahytly1A/6LuwMaVEENlMmf45WDFj9m2syIqe8CMYge1+JBkpHETp0raNqvxWS0G8qDQpTZx/CzOC8j4qpK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjZKSBxP; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjZKSBxP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXgUcOg534zth5/xTJt/mxfuZvzpVQ3AmUm+/PpCEa2XnQWzAa/erCp60LspxY+W10/rBx0MuudBLN2vloBoLS5T+qEHSJ9KgumeJRAn+5wL1vWz2Eu3p/Md//hsaky5bzz90v0hWssAEyhUnrR5PsbwXVVvA1jBRd1gfQilz0KrPmVIsxeroiHv4SvIQ/MZTcDPfHQxIzKdBscNXs0VU4xupRJnXajzK01FngChj4kphhyJiM+4g6z+Z2APYDuZ+IAO3BL4i1Zo8JJFic+63fgANK4EGZDhlBOqzaUQghzryHoMKY8F9kwGiREdBTilcS8edoo2weygGdoXbc0ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJUmKVTkUpwME0WtDWpsjuqrtaOsPxhVgB6gRSFjfJk=;
 b=URptAeKr6NWhoesy87PNw31N66ngKJk4wtLEnDhOtsz84gIo/UVRNSvan89bVsfClKc0eOaNKFLPZBia/bt/J67oPG4oiTo3hWz6Sp65GKvBuDs8IQr9q4bK4bLsAVcfKGgKhsszsJ60GornEXEXmzKYIm1wl6k3N8LZ6EXWkv+J6vfBioXAoT3tRIN0ZsLlIL2DvjkZHSGwuITKGjUUPr8ZMp3+ifpHq4JNdU9NQtfVp92123flppneiaIHLhhewoOVsUX/wLg7pnxbl85TH20Ad3kYsiFHaGKRYi4qYjGTJ/Ux2W8Xjs3VfN9Ces0m/q8OTIuFf3VSVyz/CQHYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJUmKVTkUpwME0WtDWpsjuqrtaOsPxhVgB6gRSFjfJk=;
 b=yjZKSBxPQFEbdYD7rYOAZ6iE09OULXerY+ht54l2xCom1IUF6dtxwj72EFxbi5kjSdq1YuSNEXZXn0EnLpzeDAbMHcf9uXgVOMD7RvN0qEY7ZzB3Ams3zPt5LgRzC3CV/yDo27fcvr2NY62Q7SfSE7Q0ju+0QpXl3qPZaVRiz58=
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 11:20:16 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a9) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 11:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 11:20:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 2 May
 2026 06:20:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 2 May
 2026 06:20:06 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:05 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Sat, 2 May 2026 12:19:46 +0100
Message-ID: <20260502111951.538488-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: salih.erim@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a79a79-bbb3-4d04-2dbd-08dea83cc960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GYEJZFakPyye3e1TQ86GRdQmswAbcpbiMx/AzWymj4RqUrOkeAr777KRI8xANOVgZAlMAge0LPjXKgBIRxvdJ2WWoJi81yG+MnhfWtukpPG63O4Fi0pHpT+KQtNuWa3McLrXKOWVYNBpqtRnlHxilCN0d997L10Mgr1XtB6hBAf65TrKt9xwA7Cm5QJmSqwg/GWmgjT5mAi+qfih8iTNwbj/WEAySUCx7naGzk1ZbZ5NPZU6/D6u/+ZjRTj8Tm9MmhbCyVFK4Uwcs56kqrkKHvRcirt0Z7xKPk2QfVUQtIoeU71JfqhyNIwuKMe8uSl2m7kXvrJng/bbLSovViBfjJ53bBNXRxwMFKSLxAezhHnnwsJ2QGQs6AxBprp1mYDW92plBCWwJicRLGTSljFPTYYOl0yyMuKlxrWfVLxvCS7qsgiqzFpO6s30iSWjzosoa2y+LC8HbLYRYinjf/Qy+aidj/ROR1iUEP+bO4m0/7qzymJFbpyV6GW5mmGtlbxv8X52SCMkXYzx6Dx34gFFSjW5FPiw+Oy2YwD1xq9VkOuftlgzQGa0K2RiQrmButmNfLVntRIk8LLUn5utCxfljtsieuWR9aqT8ie2P6rHY6nunrgtTNyZWY7nFs8o5Qy4zw7+2KXNTcCtal/gfk7xvWppGHKFR/YZ8x7wW3x3vkJ1id/36FzjUhNBDs2tiyK3JIdVyGCJMuvrECaANc3WpjAd/Yi+pgYE8mBsfJXuMM8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wnMbZz3lrrAOr6H519X6YDdvB3R8x6+69EOzgOPhuk6z+loDX46iBi5avYluM9qYGDLKmmKnghyR+3d4miAkQr3r2t3uXyVWSYIxxBlPAvEd53PjOGIij+RBDHIbdE6pQ1BmCtVtLrm8qWRZZFxRxdpIgflCAwPInsCwdL1PSB/WHk6JJ48eiSmGmU1eIhCv0ISa29FTOdk5xvxccDKLdY5OAbNgon4p94OCFF+z5hFEUDu+JZYGCkWjnz1COTcLyViPj8HlFTRDigfvLX0/75w55GS+o7BL7rcdsUtZMDy42O2KK+Oe7RpQePp/wGBj5PzpFON/WGOKBoW+UYzLuw+KocLZSUWgC13hdx6pmnI5l5TCbRW2xQU15Nlyaz7kDiXslzMGrZ6CdKUvROkeqnQV1DxVZRy12yJr3jGlzHW2AWE2/40oOwWiqBU2uL1l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:20:16.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a79a79-bbb3-4d04-2dbd-08dea83cc960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

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

Previous submission:
  https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v2:
  - Driver restructured into core/MMIO/I2C split (3 modules) using
    regmap API instead of direct readl/writel or custom ops
  - DT binding restructured: container nodes (supply-channels,
    temperature-channels) with channel@N children referencing adc.yaml,
    replacing flat supply@N/temp@N with vendor-specific properties
  - Added I2C compatible (xlnx,versal-sysmon-i2c) to binding
  - Binding: reg required for both MMIO and I2C, interrupts optional
  - Binding: hex unit-addresses (channel@a not channel@10) per DTSpec
  - Binding: example trimmed to minimal variants
  - API modernized: read_label instead of extend_name, guard/scoped_guard
    locking, fwnode property API, devm managed resources, per-type
    sequential channel numbering, IRQ_NONE for spurious interrupts
  - MMIO uses custom regmap callbacks with NPI unlock in write path
  - Bounds validation on DT reg values
  - Oversampling exposes actual sample counts (1,2,4,8,16) to
    userspace with internal HW register translation
  - write_raw_get_fmt returns IIO_VAL_INT for oversampling ratio
    to reject fractional input at parse time
  - EN_AVG per-channel bitmask registers correctly set to all-ones
    when oversampling is enabled, with error propagation
  - Event channels only created when IRQ is available (I2C path has
    no events since regmap cannot be called from atomic context)
  - Group alarm interrupt kept active while any channel in the group
    has an alarm enabled
  - Hysteresis input validated to single-bit range before HW write
  - Supply voltage conversion uses proper two's complement sign
    extension (s16 cast) matching the hardware specification
  - Named constants replace magic numbers throughout (SYSMON_REG_STRIDE,
    SYSMON_SUPPLY_MANTISSA_BITS, SYSMON_ALARM_BITS_PER_REG,
    SYSMON_ALARM_OFFSET, SYSMON_MILLI, BIT() for shift expressions)
  - Each patch introduces only the defines, struct fields, and
    includes it uses; register offsets sorted by address
  - kernel-doc for exported sysmon_core_probe() and sysmon_parse_fw()
  - regmap_write return values checked in probe and event config paths
  - devm cleanup ordering: cancel_work registered before request_irq
    so LIFO teardown frees IRQ first
  - Removed cross-instance global state and region-based event
    callback API (zero consumers upstream)
  - MAINTAINERS entry folded into driver patch with wildcard pattern
  - Thermal driver and binding deferred to follow-up series
  - Secure firmware access deferred to follow-up series
  - HBM SLR and I2C remote support deferred to follow-up series

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

 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 172 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  33 +
 drivers/iio/adc/Makefile                      |   3 +
 drivers/iio/adc/versal-sysmon-core.c          | 994 ++++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           | 166 +++
 drivers/iio/adc/versal-sysmon.c               |  94 ++
 drivers/iio/adc/versal-sysmon.h               | 122 +++
 8 files changed, 1591 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

