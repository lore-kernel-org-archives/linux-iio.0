Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E4456DED;
	Mon,  5 Oct 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193351; cv=fail; b=hba1gMo5zB1CUukKf8lNfmTapRt9KlZWdDbRixg1d4ENo1LISe+vQlWc9L82ARVkk+EcV9eI6qSeVyggjg1bRKDlB13SpV5UVSXLt0w3gtfD/2BeNIvJ51oiBou0WlT577jW3Vs7tCD03SgY0Ed4woKAUhDC+lT2wKKBBgX0Imw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193351; c=relaxed/simple;
	bh=EvmLBw/94YSyPaNAFVdJBJ0qL8hZgCgk+Q97DPpiikg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jozrgvqxs+zX9/sxhl093Xl+10jOBQUoDRMuCXl9F8/VFhzmBEkE3BT/JR+tQIIuOiKTW6JL70fx64LLUR3rv2UgnU/SAqFGKtQwa3jaKjfrghfmt/jMexsxwRtMC1ICHuw3Go48AkjGuEdLhbfszxIyMHtUowmLsBN+QkOr8Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LebH3fH4; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LebH3fH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN6BetfuRRaJR1SrS/8Q6VoJvzdzYd+kotmItSl4gBz4fDxdu9P55+CTzukJk0GJbCqvmmCU1RHZ4T1/t7Wwm+7mVWddztRhtNvVH0G5hpLEacvNU2HMNmu1C6AYAubBbbmRxSVZ6ktk5Vp7h8Kef62I0j5MuQct+bmvMyeftVDloWkivM0vazj40p5RiuNH7kh+XfWnbTB/ARyRTQrgShBbmMzysRBRmjr3Kcpy7yFOs4+ohUGhhES0xDUfanKCj5Czw5fKZVn9EAQ3Id7qPhGfEWzDj2+N7KCf7eTcmM0Is61vBUqy61cKR+1ZWcpFKhCm7s1xzicdMxy/SubKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWij291icpKy8bPpa5RUBdgXZWDSijHQWCeSPglfL2Y=;
 b=npPDH2buYgv2BMsws+9S1SMhO25Wg9IPc7QgDZA/tacE1o7+M6VCfLhs6gnC4n/AaP4p7Nb7ND+2U7zD/lcHq7TbTOF14MqllP8STRYluBY1fzUcT1V1ItEir3L07uvlVGu3xTJ5axludmLpCkuKN3P/6Ko94Z6ZD3DnwrOkjpgIkTP48uoEfR7TJ/6J7rnanmsH+ABO2v6WSsw8XI7twe4WxlJ1lyHIXmcGtjKPSkzXZzFeZTXNxZ7Vo6WONToFtSa7hvUAsUolyVDrQkR9+WDcAtcxZU8weiBQqCFbYiVg9PF334DderL7/JY6JmOKoAv1WcxxjEPAahz+y8JFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWij291icpKy8bPpa5RUBdgXZWDSijHQWCeSPglfL2Y=;
 b=LebH3fH4PEscJ0s5jrvA/JKQP84c53vzqm2jJs6uotVLfP6EEu8MNAR1Xhj7Z9m7tS5VSWI0jc5etv2x81YM0F2l/860qaFoBPdbdD+VzFkjCJwXHSAZuvndjnTEEDLtGZSU247UQWMyf37lVo8PBg5ier0dXLcHQF2vMYPxeYQ=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 5 Oct
 2026 09:42:17 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::1b) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD5.mail.protection.outlook.com (10.167.248.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:15 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:12 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>
Subject: [PATCH v4 00/15] iio: adc: xilinx-xadc: Add I2C interface support for System Management Wizard
Date: Mon, 5 Oct 2026 15:11:50 +0530
Message-ID: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: dc85669e-c8df-4a44-b84d-08df22c4f1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|13003099007|6133799003|10067099003|11063799006|5023799004|3023799007|56012099006|20046099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xpIE4kH9sXSZiHekW5F0qXbuGBE0FLkixQ1Tzr/EJEjdaUgABn2/v7/QgGRe2yM5v9UIFRd4g8+kiQW8cRal+H/qn1YHeHpKJ51VKc1Q2tkc8aotAU2nPAlEl5NI4oK+6R9aMjA6qyYrK8sKyY4SEF7Yqr1oJ7J2GIivDjybKMbrI/2n6ADScRqxhkDy9O4eQBntIPXJV7uxcZXA/xij6Ku7W5RoQXSKN1hVy5LU42yQp7BdYc3DvX/4Uqa2yHnU4v0pbl6RGn2nCGjBz2ThLixAoT185TnTrZBEFoiKHLXiVmCj6GNDG9e+9C7XD+zoT2TgblGlJ6rNZEbttpM53jogixITnn8aEiHjQ7xWEEKtQSPfFt3gvnM7ahZ9Mrqe9RLmQ/TNJ5Mkp9a3aL3PpjblLRWfB66YbKbF8qs1utz6pUklGrMMlcYGNexHe8hNPBnsqxzyih/RTJfYTm63ZFd8xbHKKDj2XKcnFkSjBhv9keD3U3X1Grvxom0i5sX/B8kvq36ZAbGlr2I30htj18jZVrpBDDeiEPfCo/q7O8nZRot3KdtQyfNR4k3CUjPK3rvV6eNI/x0jFjQ6nNqWNEi6eGKWqIp+npenHaUt8bY4tYtjPvYXy3eusl6t2pZ+YdhBXd4AzqpEQpnECOZF+QTeEyyswLEEAwy/8bc9FE5NWJ08jen5vHgNYc0oyPn1bqJHewvuMb2vRzpgJF1zFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(6133799003)(10067099003)(11063799006)(5023799004)(3023799007)(56012099006)(20046099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E7nHFXoWgO7prA/pq633ZzzgcwfC7zAvAhCe7tNHKL0bYlpPUjCNuFvXo8KJU1XJStOZWnINAdCdtJ+eyexCVGaZZ8FI9xF8mB8N9JnVstG06WUHLLqFtxptThx2DdxTxEpTPmgSEJHf2p9CoDOYU+dyv1HnCrLICFDULpLXWn8fFRkJeRFai3rMHMEMxITNFziB/jpCTcehDKBU4l0P+QHg89kjpdtjr8Bw2+ttVimNB3ftdGiqK+OYlNi/2gTKZ9ozMizuCLameVIKMMEeCD6VzpFEdIb/z0o3wyRvgysF+QTgk+XAKby7Tc4evFdhPKUd+cK5hmmroJaWXSUAU56xjUWV7FzkppJe0s3SsUerMptzFCTi6cf9YhHQ6quzaoWu9FTkVJNXTd2tau3U+fFMj6mrQLG5cO7LnBwbVMznuMkTJKhGsjnTBk0f23rS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:17.2236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc85669e-c8df-4a44-b84d-08df22c4f1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850

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
       - Kept only one example as there is not much differences.


Dileep Kumar Nagavarapu (15):
  iio: adc: xilinx-xadc: Correct write edge in CFG
  iio: adc: xilinx-xadc: Fix coding style issues
  iio: adc: xilinx-xadc: Use kernel integer types
  iio: adc: xilinx-xadc: Drop unnecessary masking and dead code
  iio: adc: xilinx-xadc: Use bitfield helpers and bit macros
  iio: adc: xilinx-xadc: Use guard()/scoped_guard() for spinlock locking
  iio: adc: xilinx-xadc: Simplify common coding patterns
  iio: adc: xilinx-xadc: Add unit suffixes to macro names
  iio: adc: xilinx-xadc: Drop unused header files
  iio: adc: xilinx-xadc: Add clarifying comments
  iio: adc: xilinx-xadc: Refine Zynq read/write error handling on
    timeout/interrupt
  iio: adc: xilinx-xadc: Add helper functions for the device setup
  iio: adc: xilinx-xadc: Split driver into core and platform files
  iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
  iio: adc: xilinx-xadc: Add I2C interface support

 drivers/iio/adc/Kconfig                       |   23 +-
 drivers/iio/adc/Makefile                      |    6 +-
 drivers/iio/adc/xilinx-xadc-core.c            |  894 +++-----------
 drivers/iio/adc/xilinx-xadc-events.c          |   55 +-
 drivers/iio/adc/xilinx-xadc-i2c.c             |  236 ++++
 ...inx-xadc-core.c => xilinx-xadc-platform.c} | 1064 ++---------------
 drivers/iio/adc/xilinx-xadc.h                 |  140 +--
 7 files changed, 615 insertions(+), 1803 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c
 copy drivers/iio/adc/{xilinx-xadc-core.c => xilinx-xadc-platform.c} (32%)

-- 
2.34.1

