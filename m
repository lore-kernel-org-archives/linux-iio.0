Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A81946DA;
	Fri, 20 Feb 2026 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566007; cv=fail; b=B+h8isY41BYLbxI1z3C5+haQC8W7f8yWYvgrzp8tB0XM5P+D3v/kbFoiwE8/hAZ4p4fddfPXe+2JAmAQS/3c2v6toFMPOlFYNUB8FdX6tmkIbgLmsrAloskPXJEPxUqOD71V7lzppxU9boC6RRyjZn8hbRusERcgpyBDW1P5plU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566007; c=relaxed/simple;
	bh=7ezWng7VWtzv3Vik5iUsMwcRRlvHP97TTuoYddInb8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPC2JhVWdt/VwQ0o6Hx1TrI89p/U1eu/902E2cA1SLop+K4lAmOSz8i55rw1YojZbTUxmoproMvXJYKMapr15JnT0LI0X07eJ0Aiv07gFZXaFQoTQ5UEWB56O0f3arSbuXoxeAFT/zUT/PDtj4WHpHD7HMOXRXCFoMUn2eLN2tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tg477hBM; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tg477hBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2iYAIajlx0Y8ooxyDQR8sY9dvk0h86auI/2DQA7gDghe0fO4T4eC2zxw3ME5M2jFnqGTqp2Zhav5LncceHC9lw2hx8TD0voBA+O0/07OgMRNof89aUcHUxxkE+DUy5OcWLFlc8c+BaXk1sjd88wfxhtMaxuvHU5FLgMGnX7tLVam6e/3STSN4vS4FSzurGNsjqkzrunXhtGbsNMzCobM40+oPaPtzqyXeUOFKOhuA1IxMDPtqtrDCKIiM6Cq32VF0VDXcSJ0OFaiohErIdqzJeXp2Re0rJsrr2Ry9688+tDaCS5dUjEd4DwnQRisSfLj1vwBttpQdMzyjkmGI0liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPA/xD9nwO7BVS4+YWF9Qj37bDqH3Tq3oHtjlY/gmDw=;
 b=xl99OwJvETxkBTgVI+OmF5aE6wIY4wNKfiiHXG0kGWMAy2fDAD4NdmDUoYkw3TU25QNfwsUNF0OXFoY78A8X7IWZBdCU5Yxo8MMLBKfQUqgjoVLDoW0F8g0e4PSUlz7ODJTxEYpPC0/L4rgXGw+0lbpVZSznGEUewcfbxqN4OttER0I5kOiTQrOppP8VB6JniX/YYXbYs+AbhE6a3HaiccWEoxdXOnM4N9zgoBgRQgZ3ilzKZh9EEiT9AtUcSdUvdWbvtawdo7PlY8lhWlVVruEgXHjUfMts5TUx35+KudPfWvwxEHHALqHww8a7xh4Gds3svkTN9Iac0JC3JwDHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPA/xD9nwO7BVS4+YWF9Qj37bDqH3Tq3oHtjlY/gmDw=;
 b=Tg477hBMwh91rR51xu+gUOdP54MarOad3qrnYNafgDxOuaHfKMUglnfVgRbpg4J9t+q0uwxLpZxLAYrLBDWgMZnpvPbS9WQFNgJIxFxyc7H35lFK0wChMnYkTKyPYbty6JfW/O47ai4mG/BvPBGdKpcFFVNWE1/ORvBYVH9BmNE=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 05:40:00 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::f9) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 05:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 05:40:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:39:59 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 23:39:55 -0600
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<saikrishna12468@gmail.com>, <git@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/5] iio: adc: xilinx-xadc: Add I2C interface support for System Management Wizard
Date: Fri, 20 Feb 2026 11:09:36 +0530
Message-ID: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: d242efc0-0113-4c91-079f-08de70427d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kUu3q/Vwxz2sK/uy/vZqwaZml0G86vlSjrAa4meAXurRmnYsav713SeLQdr4?=
 =?us-ascii?Q?lsYWkfDeEBmjihDemIrlPw6lSzok3A6Wwka/zxIvhU+ibAB3diY18faev9MQ?=
 =?us-ascii?Q?1YfobT+ZktvNzpkIUjzKmft0/ZPIKt1P+ZuWdzh3JhzPYrGN/pJuFhLqKvwm?=
 =?us-ascii?Q?WrxRO4ZU7SGG6te4mdMEXw192j48SelA8Uug5AbFgqbLVZtoWXdaGsa0JYHA?=
 =?us-ascii?Q?vcki/XgtL21CImvtWpmzQbzNVRzNF46utQtvFrquZhX7FCHxOda8Bt0HW3A7?=
 =?us-ascii?Q?L0mJFxQCqqE4LLBRTSzc9+vVWVcpR2iLr76sIj0hoP9ezDXwBXxzekJXh4k2?=
 =?us-ascii?Q?N0lFYgxSab2+/8xfWF/lmw02e/o0zGpM/iSoi2qR9w8Mf7bCTGP0+q5YWmMF?=
 =?us-ascii?Q?vZC6EZyfcK7NxusTduneSuevKVE4md0ngMqOWlslUbBokN/o5vJn9P6HtQ9o?=
 =?us-ascii?Q?52WHx84zy9lXHa2dNk+xlAfiQbNR45o43xB0jHIFepBfHeHnDhas5BpO8tEI?=
 =?us-ascii?Q?2KvqEwSLA5qp63tYZrKTbabQ4bPnnSEnkkhWvUyXVvx2GaxGKY99wwCcSxBA?=
 =?us-ascii?Q?8uk90/ZEdjpnBZONwMLUAsn9PY4gRInrO8TMDLbSOvpC2Vx4qlrDBzaVABzL?=
 =?us-ascii?Q?whV3C4/MGCRg67YdqBodJzY9FN7D9Coul+D1pR9G2Ea1+Z1LIfiwsifyXbtQ?=
 =?us-ascii?Q?VTHrjQ37+efOcLjzO1+8f85HDQ5/JI5fOt/yfCRq9iqdskdi3CsSPZH3heCN?=
 =?us-ascii?Q?lo6mQL2g4tdQfAcQ5MslK1UpeT+mSWjvUvZmS3cNRJeH8deuoIccwBqViAZq?=
 =?us-ascii?Q?7GPj/xRuIyAX1+GwY4rkppEg+EyuieVAt77vmtn5KOn9ikPcTHHuxeVJ5mF5?=
 =?us-ascii?Q?/Bb/EiycEOqymVirCb3zAXlPDvztxo+dh73Mm+h1w8HRjBh12T8/UbXwiGxY?=
 =?us-ascii?Q?hcTRVmglZrSWNIVqAHVIQ390GMpMYo76bFa1kcJPmqzswot18IkXiormmp5H?=
 =?us-ascii?Q?f3G3eMmSsNakI7CcnSTEM+hExHo/3UGFvEF/M00QzYV3PQvQUvLOGFZnP2Fy?=
 =?us-ascii?Q?tiHNnR9WQiS4esW3SSYvz8r2fILJL75nnLwS9q4elTv0L6ubqMCoqZ/1mxTf?=
 =?us-ascii?Q?DGHc/sU8PPOSQKSzDiqXSxiU78rypgZiT7EgD9Gw7Fv7DbD7MEifA0S6GJUB?=
 =?us-ascii?Q?woP6CiaLIDxW0WB2s6m3YZARNtUQ15B8J8SOinUUdD3+ybhykt+gLDXm1hZK?=
 =?us-ascii?Q?n6h0hI4+ubQ/ygIvwN/rKCiF5nwUXmcLaQSBrUXZmHEFNvjFTWMube0LCkSP?=
 =?us-ascii?Q?sOnkb52KsawCCdom+bnqgKxDTyHlP217tEq/Pf03IFnraqKZLbGR8mw/ScSt?=
 =?us-ascii?Q?nz4FsJbcXy+eac0ylg9C+qkiK6Zy5lg7grEJBvmIuFYb1UGrL7srCTTLTIPV?=
 =?us-ascii?Q?k2dX3/Ig4vMXGxAtX68jGXbIvaXt31gD75hR/41rhFREv3AMJeWNixfsDa09?=
 =?us-ascii?Q?jhTQ2OWjyVlSJ4s6Y/AXqlqMyd9o1e9nmGtXN8V7tcMQi7fGN4fj3qdSYk7w?=
 =?us-ascii?Q?sY+ToJSp2ZkKvrNOd++pCYUOYcX8i0j4+1cwyOLgJ1I0K08qYQtGU9m/u/EA?=
 =?us-ascii?Q?HzXejSN5TWIdn4++xrEcuik1rwT763JfNTfVOewMVpE3MaWdsE45iiXhF8DC?=
 =?us-ascii?Q?mUeN7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LpcTK7kFey8uvlyRXVVmERG+jwaHQUBwrn6pGPS5US3RA+7dzrR+b6XmoUwCuPgbFxAXJYCyWGH6Z9Lrix1pRVUNNlnNEAopQF5gGZS07fenrB3RCu2PJL4MIGVMke1IizuA/bxAjCVFC1sNYReWu7yUGPz3Mtp3cg1ggC+kdbRPQ32tfn//1btIvtltSNaj7UJGrRlmaHKzPwmUg3aaDGce7PgyxKJ8KVgaFCAL3t+XBY8UXXslTp1SUlU+Cs+XKMt3+YYM8hHgzZgsYWzBNv8DUoi9tsLwLVHqLxWH1ciSIG93iu2SvHOxYg8bIOpiCFyRQ9c2BRrA5IsN+Hxec5jSxhwH84oM6xoeoVkCOmoNCTCu/U/xBoCf8loc5+Opc672CDsB0h/tMOXzaUiZRMnnytBrZKnkkZajBA2kzUwhZJEl9115ziICI8ctezV+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:40:00.4940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d242efc0-0113-4c91-079f-08de70427d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

The existing driver only supported AXI memory-mapped access to the System
Management Wizard IP. This series extends the driver to support I2C-based
access, which is particularly useful for System Controller usecases.

Key Changes:
- Extract common probe logic into xadc_device_setup() and
xadc_device_configure().
- Add setup_channels function pointer to ops structure to support
different ways to configure the channels.
- Replace module_platform_driver() macro with custom init and exit
functions to support multiple bus interfaces.
- I2C interface support.
- Convert binding file to YAML format.

Note: We are working on x86 platform support where fixed channel
configuration is used(no DT support). The setup_channels function
pointer introduced in patch 2/3 enables different channel configuration
approaches for various platforms.

Sai Krishna Potthuri (5):
  iio: adc: xilinx-xadc: Add helper functions for the device setup
  iio: adc: xilinx-xadc: Add setup_channels function pointer to ops
    structure
  iio: adc: xilinx-xadc: Replace module macro with custom init/exit
    functions
  iio: adc: xilinx-xadc: Add I2C interface support
  dt-bindings: iio: adc: xilinx-xadc: convert to YAML format

 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ---------
 .../bindings/iio/adc/xilinx-xadc.yaml         | 194 ++++++++++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/xilinx-xadc-core.c            | 283 ++++++++++++++++--
 drivers/iio/adc/xilinx-xadc.h                 |   8 +
 5 files changed, 475 insertions(+), 162 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml

-- 
2.25.1

