Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287331;
	b=n7iXeOKsMEoqGMAdS7FhBUFTM+9TrZRFQoTVs0NT8ej2RrVewFuJ765fk/vqxrPamXxG
	 P1/s1et14KN2VVPVdhNkJnOuID3sZaNakmVZ9SiyO2tlwPjYa57a/WGzrSGrHmYtxOSaT
	 7wNxgW2vYAtCIlXV5COVCRhyR8TBar3f1SyLPFT2dplV0/iTLQyM26dXDhe9Ffs+2Chlv
	 bF+osjzCEnHWNgMdUHzE3MUUS4D6kgO/qNYsm6/S4BrySRfKENOCPM7VB38Sd2SZxomL2
	 wXkwd/6j8T/pVwAgYNbsSezgGEEr617sYbbEBIGBTodwspXpDL6FvrQEG7tWd0ztwfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287331;
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
	bh=+3va/jBpndWAC2rG923npLLwpGONMtCneZPbBBZ6gGM=;
	b=sAo5TzrRehZCKAZsA1K91SJCTmVGhSpF8hJEJqxlZlodNLd85xveyi+JdLqdHeKoqD5R
	 FCPMRlEdnbTvl7CrHIyzmrUJgUJWk3+fUjsMvOPvZlqeOjz71E/tY1WYlvlrBg3YhLmrC
	 Yr7XEsCdoqdFmEkwtK3A0bpMqx69f9VDMpEn1vOc/83+fG2a79uW5SsUOK19Wsh18sLti
	 jGreo7u2+BiYlZL3I5WfvnhYdmpIQOvH3IEEsnaAs0RlaVvsaxFSu0re7JaEzd7SiAi+1
	 N4hJl6hioC2RG3Qm98zI6t1x6srWMjM2gnEdwt7nSxFsOkzmtKIAv6x8rtT9KSCCwkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ty8MJxEW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.26
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C5606A32E;
	Tue, 10 Nov 2026 05:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82C5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ty8MJxEW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8AZPNsS4Q6GpoMtdaNWuxNcsluyCgEnwPzmkCrgMEg9L34WKj9ewIK97Ckio/CSMCcsSMdyBtnWYMrktmIh9BMHxbn82XAe/aeb8VXkUQGxBxZV4xmd4Xo65V0d9mGjafmii8p11BRDw3A19EeX/GRFV/sJScK4JloWdztuSTKDR9WeMPrLsULEbS8Xlyhen5ZZ43yGCMuYiRrGI5f0BfDJIbj9zEWBav4XZKi7hqpxWIvlpaKSrbsiOMIIDnTR41IEe1bHEwotcmLk9krcxnTEu0VN3ZHZOTNXZ3X1omma7Yb8nZecJiWk2TSyMSoYqgHFlJ3nvjZnLspg2a7ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3va/jBpndWAC2rG923npLLwpGONMtCneZPbBBZ6gGM=;
 b=Bo/7oZMxHslI4i0b+QXtS+2S7AewePqCvtkGDqu4HijBuy/H3bv60fHPlIWLC7A/0JciB2Ucb79lpUGrzVFHa7mqM/zdWn6Zzp8++ttDPkwjzao4hBG+67lDKrh5D8YN2l62LjJZBnEbQezC0m1akvRonNKiShd6Ka07cwxhJCQ33UZXNXbDP7/vtT9o6XNJ1YNKmjruOvYXQSA+76kq9iTuhJla3FwMkUkxOkmZIdwWI7/O7WGvVsmGtS2F6wUIJ4CUCXlumaLM63gqD3Lc3DdCiHupWrh+b5liGe6fPYTKbNIOyksUFlp2DLfV0W6Ko7SoXP6q4NfyiNRsasCf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3va/jBpndWAC2rG923npLLwpGONMtCneZPbBBZ6gGM=;
 b=Ty8MJxEWjdb7YwpF9gjli4JtWOeTNj79IyQUSRFYfbq52/PLIE8ThXphVWRc0wLr089XpkRxotL9qlQJW4dSVqS+bpHHAcVUnGFCLt0QXfOvTYonDNzbQz1dne692T+liTdg+7sO5ig4WNp9I1ISApLUWTy2Fj+tpk2gaSFoZZ0=
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 05:08:32 +0000
Received: from IA0PEPF0000003E.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::8b) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:08:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003E.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:30 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:27 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>
Subject: [PATCH v5 00/16] iio: adc: xilinx-xadc: Add I2C interface support for System Management Wizard
Date: Tue, 10 Nov 2026 10:31:45 +0530
Message-ID: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003E:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 958bf88e-7097-4bd1-9443-08df3ee8aa3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261009223027099003|261102130727099003|261102123227099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|20046099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	Zjt6ekBNoiREx+f5Od6NzPUapppe7ekvRhTJu5AATYEe1oaGsj9rY5QZa6M1FVoZUpMdyaUeiQjibEXwlWW0X57rspvoQ0OQfLVpnOJaNL2BoTcylc0KwTD3uytywFCZ71kT75lV5S2Le+qbz4mISXSy2rHyKjwjBZku7to3FUh8g8w4Sf4Ec0QIzRZygmYlJIfiQaQRGpnMoyJUrn+fUZD2PF/KBNuAjfbRS9ukV8ogiuwnJhyZiEuWCPOTUpJoNeowmIVQvKLDRQTUXLa2IsRELxAjYZ7FmzIPgOKOX11rgww+YAej/zvC4d9wDuTV3YDo2nM6o8TKxM8TlF9acpfE5sF8+qXxxIWSb7JuY69QF3/8vEUKg8IEMee9RiQQbv+xo82efhi2Pv4asNd3RHCIRKM2njd9iDRmX0FMo05POG4KCiOcvmjMcneVva1GOGEmGqHIOXxDgAOJBgtBTY/BBjsd76KClVNxc9HqEtlAdsYEPNZ74RyciCG6L5DE3KHesxtDlaGpsJ2aD5hfIPGfyepQ6hEs1+b33neW4NdRxxpfzcSOcaMiRXuOJ+75QxNw0lXSd+Hc4mVB7TwHOnV1qVEtep6qaoz5shWFuRRFG5U5BaBBXqQ/feaGFc21O+y2t8dmcTjRp1/WjXd7Hg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(20046099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YrkQab2uIVz9byiDzioTaCaUYKtzlyOdd7aAqqAdAWl5Xk44Ow9qwaTmfOG/wmOe782y960Cl7pdDTzrVPE0+IyZ44wK/XPUREI+xg82Bg2bluJTbyPflcNK21LbwgjKjoYMqwS4pQi9VTEtmlzKaO4S+AG0EbThR740z551wiJtZLGGxcdw5L/vWhwLw7mJUzQR/pDUfcDjKzmM+/hZwQhDXRzLslshJqdnYBwGKsYElhPNWLnqq3Vzthmn8VwY40EqDJ0ueCbMWd3zaGurYJmb61gkwrGLnGHbir6Itv6/q51a26Z9pobOrXJwjR7d9gmRynFEe16z+HBZJ6EFv/+lnqAbsPj8u9XyEJeW9vQlQVtPAiU2c91aeFxgiYrEaA6g86kLuPuzJySGbslt7AqUoUiQe/BYSW4+Uar/W/XKp52iucUgB2BWS3tIN9UF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:31.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958bf88e-7097-4bd1-9443-08df3ee8aa3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

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
  iio: adc: xilinx-xadc: Refine Zynq read/write error handling on
    timeout/interrupt
  iio: adc: xilinx-xadc: Add helper functions for the device setup
  iio: adc: xilinx-xadc: Split driver into core and platform files
  iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
  iio: adc: xilinx-xadc: Add I2C interface support

 drivers/iio/adc/Kconfig                       |   23 +-
 drivers/iio/adc/Makefile                      |    6 +-
 drivers/iio/adc/xilinx-xadc-core.c            |  909 +++-----------
 drivers/iio/adc/xilinx-xadc-events.c          |   79 +-
 drivers/iio/adc/xilinx-xadc-i2c.c             |  242 ++++
 ...inx-xadc-core.c => xilinx-xadc-platform.c} | 1095 +++--------------
 drivers/iio/adc/xilinx-xadc.h                 |  125 +-
 7 files changed, 688 insertions(+), 1791 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c
 copy drivers/iio/adc/{xilinx-xadc-core.c => xilinx-xadc-platform.c} (34%)


base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
-- 
2.34.1

