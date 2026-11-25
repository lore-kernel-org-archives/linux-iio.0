Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626669;
	b=SuEpJeUuOr2kRvyz4Q42fKZf/CyA9cICdzE4OF8XZD5JSvt85LoyBhA3pUPBjz8vqR85
	 BGwbFlZfyeKhVgm4Y82nntU1WzPSdNzBZMVwzrjxC/Ob4dgwy4eoVgDmad1Rr7YkS2qdc
	 W6Rsblaq6qo+eZt95TSHkYaF5mUEjmq03fhEaZH7fCh/RdKQgw2ktkWXcnqDokMVsrJYY
	 7rZyNpaSc4EFoAQwV9XqClNhsuZxLmUJoIhf0JFnhEXK/TKwJCNQSeBwyD6DaVXSbWW1j
	 UuhTIW1BIBAZaEAlIU/XIf+RsuY+lF7udDARvpwFO7cVEvqNwdU8HQDGbGOjDRfET+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626669;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vhq/MLzjzjJMz2LHevW2XZRHvdPzqvTAN+fRUSWN5eU=;
	b=wFgXwqEdIFz7e0n9eemnLjYgNuc8Fu6wTYus5KfhOJvVXbLTmyRbxASf7T/4EMq43a3M
	 AK9cE6uFjBLolSUJSbuEtPCf/zvrGsgoIHA6u6TY1hyf7tX/TmJWa7BWtOjJ2NgN24DvW
	 Vkktq31mlOU6KNSsWYUFNrfSIwDOnm4Iza7EP3jKniCDp62kD/Sksl+A1+MKhp7QR7nwT
	 V6xrV2vBmBhTUKxdtOFXzAAcswGI0E5esF9tCYCPTX0H14N4SyuKrAIzwO4L4uQTi8xrZ
	 leaeEKpAsVvD1MHl3/3mnmvnTIVsFn1NlEr4H+N3I+nuVjGSYcMXlniCcoFekJLolmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fe6GbOlJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767B606A31E;
	Wed, 25 Nov 2026 17:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B767B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fe6GbOlJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdt6xJ70d8CBo6THXTXlXIvD9WColCiWIFV3Wfjh3RHtCUvYYD7OhtQzLn/q+vqf2+Kx22eZ8mE8yTT9qKqY9wZA9nrkDvXBm9A2Q06g5VysCPTiD3qCymytgRiMLr+9huPXh1VQwMphC+rh/wXeZXNF4eM3XTlQ8vl+cHNTuEA4ORbDl93jmU34lmkCuWRHIR3rKqpo5sL0bjk25CTw+RbArvuYyled3daIbXcOffLhvNxFp/lqCocg6oIXTY6nLYGRaW1/CXu6ObXUNUiVXbUSVGmmUE9gSbEicPA9mOgB//mAQcP6yG3goyDjdNPKbJedwTh6T5YaOES96BXuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhq/MLzjzjJMz2LHevW2XZRHvdPzqvTAN+fRUSWN5eU=;
 b=DUViof1fjz8XhRiiDEdPszZZlWP6mFvOmh4jzFxXt2MTFMO453s7CzaF4TCaJ8FYE65IfYnXjsWu5b9MBRzAkLgiJAREVnBtFIoheS64pPDteYam2iiIRq76cTbev2wsyXnpAwZ6jujUQQAPplhv/y1rVGqwGwOy9zK7OzH3I1tm5YsWaVhVAE04aWlFu8EoMXYerumnEjNCiWTaefHcf4aTNL96rbX7F01Nt87ebA8DKzzWjGXtkJ7cAMIlwZImumFNfqUrrSmcjzfYP/w3cH06RWbb/XS47Vv5ir0GjYTgMduCf/0HOLCF8Mwq0rFPmvHUEfnuKmmziCEAhNyhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhq/MLzjzjJMz2LHevW2XZRHvdPzqvTAN+fRUSWN5eU=;
 b=Fe6GbOlJ2HYDmgigw/ysQayPXk7jBoT4/3JNjwjl5kTbnU9ADqgj5CiDQM4ZvanLWviGIlUcyzXnC7radtfpD1gaab6FuV5EQUcW0q4RXXPUc4EjWz6cY2oFKM9VXleLQ7OeCvc+vUmnBiGJqlKv1MH2hxPAR9Gg5XnGOEA3rVk=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:11:01 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:610:60:cafe::8b) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 17:10:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Wed, 25 Nov 2026 17:10:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:10:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:10:57 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:10:54 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>
Subject: [PATCH v6 00/16] iio: adc: xilinx-xadc: Add I2C interface support for System Management Wizard
Date: Wed, 25 Nov 2026 22:40:14 +0530
Message-ID: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f416ed-b930-4c0e-5c06-08df4b171366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|5023799004|261026140227099003|11063799006|261021123027099003|261026121527099003|56012099006|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261102130727099003|261028144727099003|20046099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	w+BKDI3jyDbOKZMoMwWOqmmaVjH9I0ceUveMiU3MtKEWBNajMiiQVSrvipPpUHEiLWA54OLDYjgNpygmCUpUImoNvPFomi2OdujwLPBjV/n12hhEhWrJ9VR0Fq+C1YFBsUAiFRvZ937fmOh0NxrDfuy9/7h77Fi0QRzFY7zEVJrv3WrpxNtK/9fU+1pY+oWkwxh6/Zd+Z3ntZvo462cbKPYD7MRduFLYF00js1LGh7KgV8XlM6bmfxhEfwDL5xDVEz6EbbvNWiLf5xCdjbsYf7LkQeX5FMhk6XuMP9dYmZSizFFdedJJxqFYPmYrG6edkxc9bbaTdbMWVRloLxUsedZdq8KNc4OaQLx65AsCS8MfG1UbGLXezZdzW5lEOBxlUyhTn1lkAu95PKFGvlgXafq7mA6JEmXLtzwu/SQJmwbo88yiFT798rkBu2PyybP3X7MJloctVZAu8aD2fW6pofshkSwA5ql4IYOiXtinTwxk3yisRqSsKvHb4i/YCgpElJ01AMVGw+zwoDLyuNYyi2p8eKDG5YjWIpPs3jfQTn3JqXxwdO8hN73qolhwvTbHMEt67lyRQh1b3X1iQ1dg30ISBIkgOxS9L/LOZFQhNjoChAJIjeu1ql49zNL1uq0y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(5023799004)(261026140227099003)(11063799006)(261021123027099003)(261026121527099003)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261102130727099003)(261028144727099003)(20046099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GDxlB41IRlhiYDW9b2Yf6J4Cauyup6hiJ1eOUexVHyPsDIFdB5cYyqSQzEW14vSBexAiUC6qxKnfk7a6+eQLZxoS0+Oz1gaKVs9zQgLROLOlCPSVopRTbt6lqBo65KjWyfAmx4ZVV3fa1yYDHX5hKcX6kr3dqmHMZ1r6k3j58jUpOtOIItcgtvZaZ3AwU28HGXoBj6/R65UAlP6BZF7sgEm58mnSoYzj+8Cbo4gQEVyQcMnPJmQQVjTMEUFk/QFCMcqyLC4G3dmqab3vJWlz/gdaHjeflpEA0euvryyCeCwohJExUOOmzHTFvlpuVMuiYQBgE8wqlaq3Gw1xcFyBoTBhPYumdWupACJrp1l81+meQL/mPXfJSRM70sbc/s7CxM5obeOWOcASwpvpkgbDnxjHGOBgbq5zOsjmpVc3OmJb5fg8XXCPz5WL/bSdj+xq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:10:59.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f416ed-b930-4c0e-5c06-08df4b171366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802

The existing driver only supported AXI memory-mapped access to the System
Management Wizard IP. This series extends the driver to support I2C-based
access, which is particularly useful for System Controller usecases.

Key Changes:
- Split the xilinx-xadc-core.c file into two files(xilinx-xadc-core.c and
  xilinx-xadc-platform.c)
- Add required helper functions and callbacks
- Add channel configuration via callback mechanism
- New I2C driver for UltraScale+ System Management Wizard for basic
  voltage and temperature monitoring

Note: We are working on x86 platform support where fixed channel
configuration is used(no DT support). The .setup_channels() function
pointer introduced in patch 2/4 enables different channel configuration
approaches for various platforms.

This series was originally posted by Sai Krishna Potthuri.

Link:https://lore.kernel.org/all/20260323074505.3853353-1-sai.krishna.potthuri@amd.com/

I will be maintaining the series going forward and posting updated
revisions.

Changes in v6:
-> Moved patch 12/16 in v5 to 2/16 in v6
-> Renumbered patches 2/16-11/16 in v5 to 3/16-12/16 in v6
-> Added Reviewed-by tags to the patches 3/16, 4/16 and 5/16
-> 2/16
    (Comments from Andy Shevchenko)
    - Reordered wait_for_completion_interruptible_timeout() return-value
      checks to handle generic errors before the timeout condition
    (Comments from Sashiko)
    - Added the Fixes tag and Cc
-> 6/16
    (Comments from Sashiko)
    - Replaced the open-coded register field preparation with
      FIELD_PREP() in xadc_zynq_setup and xadc_preenable
    (Comments from Jonathan Cameron)
    - Dropped unused _OFFSET definitions after converting the
      corresponding bitfield operations to FIELD_PREP() and
      FIELD_GET()
-> 8/16
    (Comments from Andy Shevchenko)
    - Added blank lines around guard() declarations to make the lock
      scope clearly visible
    - Removed return variables and returned the helper result directly
-> 10/16
    (Comments from Andy Shevchenko)
    - Used units.h multipliers for frequency and sample-rate constants
    - Used _Hz suffix for frequency-related macros
    - Simplified the sample-rate check to avoid an unnecessary division
-> 13/16
    (Comments from Andy Shevchenko)
    - Useed scan_type.format (IIO_SCAN_FORMAT_SIGNED_INT / _UNSIGNED_INT)
      instead of the deprecated scan_type.sign. This covers the bipolar
      mask loop in xadc_device_configure() and the other users of .sign
      in xadc_read_raw(), the two channel macros and xadc_parse_dt()
    - Handled -EPROBE_DEFER explicitly right after
      platform_get_irq_optional() and restructure the optional-IRQ
      check, instead of the single combined condition
    - Replaced "irq <= 0" with "irq < 0" in
      xadc_setup_buffer_and_triggers(), because 
      platform_get_irq_optional() never returns 0
-> 14/16
    (Comments from Sashiko)
    - Restored code that was missed when splitting the original driver
      into core and platform files
-> 16/16
    (Comments from Andy Shevchenko)
    - Reordered struct xadc_i2c to remove the 3-byte hole after
      hw_initialized
    - Replaced -ENODEV with -ENODATA when device_get_match_data() returns
      NULL in xadc_i2c_probe()
    - Dropped the unneeded blank line before MODULE_LICENSE()
    (Comments from Sashiko)
    - Moved xadc_common_init() from xilinx-xadc-platform.c to
      xilinx-xadc-core.c
    - Removed expose the sampling_frequency attribute when the interface
      has no get_dclk_rate() callback, since it could only return
      -EOPNOTSUPP
    - Dropped the XADC_REG_THRESHOLD() reads from xadc_hardware_init(),
      since the threshold cache is only used by the event callbacks,
      which the I2C iio_info does not provide
    - Reworded the commit message to state that the I2C path supports
      only the internal System Monitor channels and does not program
      the channel sequencer, instead of mirroring the platform
      sequencer setup

Changes in v5:
-> 4/16
    (Comments from Jonathan Cameron)
    - Retained the unused register field macros for register field
      documentation
-> 5/16
    (Comments from Jonathan Cameron)
    - Define TCKRATE and power-down mode constants as field values
      instead of shifted bit masks
    - Split the combined alarm masks into their individual register fields
    - Update the sequencer mode definitions according to the documented
      field encoding
-> (Comments from Jonathan Cameron and Joshua Crofts)
    - Introduced a new patch for mutex handling as patch 7/16 in v5;
      patches 7/15 through 15/15 in v4 are now patches 8/16 through
      16/16 in v5
    - Convert mutex locking to guard() helpers and remove goto-based
      cleanup
-> 8/16
    (Comments from Jonathan Cameron)
    - Retained explicit == 0 comparisons for auxiliary scan mode
      field checks
-> 10/6
    (Comments from Jonathan Cameron and Joshua Crofts)
    - Updated the patch title and commit message to reflect both added and
      removed header files
    - Added linux/bitmap.h explicitly for for_each_set_bit() in
      xilinx-xadc-events.c instead of relying on an indirect include
-> 13/16
    (Comments from Jonathan Cameron)
    - Added an early return when no IRQ is available to reduce indentation
      in xadc_setup_buffer_and_triggers()
    - Moved device_get_match_data() to the caller and passed the XADC type
      directly to xadc_device_setup()
-> 16/16
    (Comments from Jonathan Cameron)
    - Moved interface-specific properties (info, has_adc_b) into struct
      xadc_ops to avoid explicit XADC type checks
    - Added has_adc_b to struct xadc_ops to indicate whether the device
      has an ADC B, in place of checking the device type. UltraScale
      System Monitor devices have only one ADC, so has_adc_b is
      false for them
    - Reworked the I2C DRP packet definitions using an enum for the byte
      offsets and packet size
    - Simplified I2C DRP data handling using get/put_unaligned_le16() and
      removed unnecessary bitfield operations
    - Added short-transfer checks for I2C transactions
    - Added xadc_common_init() helper to initialize operations, mutex, and
      spinlock
    - Updated the I2C of match table terminator

Changes in v4:
-> Updated the sign-off email from uppercase letters to all lowercase
   letters
-> Dropped the commit message related to the binding YAML schema
   format from the cover letter, since it was sent separately
-> Dropped the MAINTAINERS entry from this patch series
-> Split the previous 1/6 "Modernize driver code" patch into 10 smaller,
   single-concern patches (2/15 - 10/15) as per the Joshua Crofts and
   radhey review comments.
   the combined result is equivalent to v3's patch 1/6:
    2/15 - Fix coding style issues
    3/15 - Use kernel integer types
    4/15 - Drop unnecessary masking and dead code
    5/15 - Use bitfield helpers and bit macros
    6/15 - Use guard()/scoped_guard() for spinlock locking
    7/15 - Simplify common coding patterns
    8/15 - Add unit suffixes to macro names
    9/15 - Drop unused header files
    10/15 - Add clarifying comments
    11/15 - Refine Zynq read/write error handling on timeout/interrupt
-> Patches 2/6 - 5/6 from v3 carry forward and renumbered to
    11/15 - 15/15.
-> 1/15
    - Reworded the commit message and subject
    - Added stable@vger.kernel.org to after the Signed-off-by block
    - Added Co-developed-by: Conall O'Griofa immediately before
      his Signed-off-by line
    (Comments from David Lechner)
    - Moved patch 6/6 "Correct Write edge in CFG" to 1/15
    - Updated the Fixes tag and explaining a commit message
      for write edge configuration issue.
-> 3/15
    (Comments from Joshua Crofts)
    - Included <linux/types.h> header
-> 5/15
    - Dropped unused macros
-> 8/15
    - Reformatted the XADC_ZYNQ_TCK_RATE_MAX_HZ,
      XADC_ZYNQ_IGAP_DEFAULT_CYCLES, and XADC_ZYNQ_PCAP_RATE_MAX_HZ
      macro definitions to use the standard "#define NAME<TAB>VALUE"
      style, instead of the single-line run-together form.
-> 9/15
    - Replaced #include <linux/kernel.h> with the required headers
      array_size.h, bitops.h, and container_of.h
-> 11/15
    - Changed the timeout errno from -EIO to -ETIMEDOUT in both
      xadc_zynq_read_adc_reg() and xadc_zynq_write_adc_reg(), for
      a more precise error code on wait_for_completion timeout.
    - Kept propagating an interrupted wait's error instead of
      forcing ret = 0 (success) in both functions
    - Added xadc_read_reg after the
      wait_for_completion_interruptible_timeout, Now DFIFO read
      unconditional so it always runs immediately after the wait
      completes, regardless of whether it timed out, was
      interrupted, or succeeded — avoiding a stale response word
      being left for the next transaction.
-> 12/15
    - Reordered dev/xadc declarations in
      xadc_setup_buffer_and_triggers() (reverse christmas tree).
    - Dropped the unused dev parameter from xadc_device_configure(),
      keeping the header prototype and definition in sync.
    - Added a commit-message note that the bipolar_mask computation
      is also moved to run immediately after xadc_parse_dt().
    - Removed the error handling from xadc_zynq_write_adc_reg()
      in patch 2/6 of v3 and moved it to a separate error handling
      patch 11/15 in v4.
-> 13/15
    - Changed the new xilinx-xadc-platform.c SPDX identifier from
      GPL-2.0 to GPL-2.0-only, for consistency with core.c and
      the header.
    - Tab-aligned XADC_MAX_SAMPLERATE_SPS, XADC_FLAGS_BUFFERED, and
      XADC_FLAGS_IRQ_OPTIONAL to match the XADC_AXI_* block below
      them.
    (Comments from Uwe Kleine-König)
    - Removed <linux/mod_devicetable.h> header file
-> 14/15(Comments from David Lechner)
    - Added a commit message explaining the export of xadc_parse_dt()
-> 15/15
    - Fixed missing spaces before opening parens in the commit
      message ("DRP(Dynamic" and 'string("xlnx,...")').
    - Consolidated the four redundant deferred-init rationale
      bullets into a single explanation.
    - Fixed the Kconfig typo "can also be build" -> "built" in the
      new XILINX_XADC_I2C entry.
    - Changed write_buffer/read_buffer from char to u8 in
      xadc_i2c_read_transaction()/xadc_i2c_write_transaction().
    - Added named defines for the DRP packet byte offsets
      (XADC_I2C_DRP_DATA_LOW etc.) instead of bare 0/1/2/3
      literals.
    - Dropped the redundant "xadc->clk = NULL;" in xadc_i2c_probe().
    - Fixed the devm_mutex_init(xadc->mutex) build error to
      devm_mutex_init(dev, &xadc->mutex).
    - Added the missing MODULE_IMPORT_NS("IIO_XADC").
    - Added Dileep Kumar Nagavarapu to MODULE_AUTHOR alongside
      Sai Krishna Potthuri.

Changes in v3:
-> 1/6 - Modernized the driver code with latest kernel coding styles
         and guidelines.
       - Restored one-variable-per-line declarations where no
         functional change  was intended.
       - Added unit suffixes to timing and clock-rate constants.
       - Replaced GENMASK() and FIELD_PREP() in appropriate places.
       - Added guard(spinlock_irq) helper to manage the spinlock
         automatically on scope exit.
       - Added MAINTAINERS entry for XILINX XADC driver.
-> 2/6 - Refactored the xadc_setup_buffer_and_triggers function
         with only two arguments.
       - Added xadc_device_setup() and xadc_device_configure() to handle
         device initialization and configuration separately.
-> 3/6 - Added IIO_XADC namespace to all exported symbols and
         imported the namespace in platform specific modulue.
       - Spliting the driver with modrern driver changes.
-> 4/6 - Added .setup_channels() to handle custom channel setup
         and configuration.
-> 5/6 - Replaced mutex initialization with devm_mutex_init()
       - Removed unused i2c_set_clientdata() usage.
       - Added comments describing the DRP packet layout used
         for I2C  transactions.
       - Added comment for hardware initialization check from xadc i2c
         write and read functions.
       - Wrapped Kconfig help text to conform to kernel style guidelines.
       - Switched device setup error handling to dev_err_probe().
-> 6/6 - Removed write edge default configuration in XADCIF_CFG register.
-> Dropped the binding to YAML conversion patch as this is already sent by
   Pramod Maurya and is in discussion.

Changes in v2:
-> 1/4 - Split the xilinx-xadc-core.c file into two files
         xilinx-xadc-core.c and xilinx-xadc-platform.c(comments from Andy).
-> 2/4 - Referred as .setup_channels instead of setup_channels.
-> 3/4 - Created separate functions for i2c read and write.
       - Created separate file for i2c interface handling.
-> 4/4(comments from Krzysztof)
       - Removed $defs and use it directly under xlnx,channels.
       - Documented the error information in the commit message due to
         vendor prefix properties.


Dileep Kumar Nagavarapu (16):
  iio: adc: xilinx-xadc: Correct write edge in CFG
  iio: adc: xilinx-xadc: Refine Zynq read/write error handling on
    timeout/interrupt
  iio: adc: xilinx-xadc: Fix coding style issues
  iio: adc: xilinx-xadc: Use kernel integer types
  iio: adc: xilinx-xadc: Drop unnecessary masking and dead code
  iio: adc: xilinx-xadc: Use bitfield helpers and bit macros
  iio: adc: xilinx-xadc: Use guard()/scoped_guard() for spinlock locking
  iio: adc: xilinx-xadc: Use guard() for mutex locking
  iio: adc: xilinx-xadc: Simplify common coding patterns
  iio: adc: xilinx-xadc: Add unit suffixes to macro names
  iio: adc: xilinx-xadc: Include appropriate header files
  iio: adc: xilinx-xadc: Add clarifying comments
  iio: adc: xilinx-xadc: Add helper functions for the device setup
  iio: adc: xilinx-xadc: Split driver into core and platform files
  iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
  iio: adc: xilinx-xadc: Add I2C interface support

 drivers/iio/adc/Kconfig                       |   23 +-
 drivers/iio/adc/Makefile                      |    6 +-
 drivers/iio/adc/xilinx-xadc-core.c            |  944 +++-----------
 drivers/iio/adc/xilinx-xadc-events.c          |   79 +-
 drivers/iio/adc/xilinx-xadc-i2c.c             |  235 ++++
 ...inx-xadc-core.c => xilinx-xadc-platform.c} | 1084 +++--------------
 drivers/iio/adc/xilinx-xadc.h                 |  135 +-
 7 files changed, 698 insertions(+), 1808 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c
 copy drivers/iio/adc/{xilinx-xadc-core.c => xilinx-xadc-platform.c} (33%)


base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
-- 
2.34.1

