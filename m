Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794635329;
	b=yoPXAq2uqkX0RLDJqDVv8SvN/20wlMjJf55gNu3zfNJk7orw/2xljEpuzribhJ2FTrmH
	 owc4bl/vT69qNoJl+ggBKN8Q7nWswtl0E014fjqXWtwI+b55rKeSQ8Z8UUau6QAYgGDUB
	 CNJQ1uznkAZUeUPc+vnXaJLyb0aoUTbNTDPri1xyBGw4AIyMYk9yPUsM9wsuqR86mtUh6
	 GDqYlLRY71cvJZc6Omw6nyxit0sIDlONsz7g2rG4WULvbXD6p6+bw/4M6wPXdpV3b93og
	 0l1XJ3oLoSEo/mzWID7Q3jGdbu9h2LCQINwMeKR6ZuLyzy8P3zCrO6yKwrR8BdlznBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635329;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=3Aq8RPZ/sptmUocOrBADIXcTVIFOaABpWeNbGlwKF4g=;
	b=2Wp+DltQidRHFL2fDwYIBDQwbF60FoWwSy7a0ijxDQ6I2vZU63m/beMrU/ocZBG4ho3x
	 ZPCWIb2y+BB7sc0ehGthl3O/R9OF6YVVQdp3WdL7ZBWVRrya3VKRx7XDgBJqPTPzOZidn
	 PwTsfAQyVVhThUzvyX+hemQMZWtw4/iWLW2fKARz527gQF3vXBrWHQxtChdl9sTSqBJEj
	 KCHbnoEZSdJ0fs80Fw8V8cH6ObnUHC6XfSuucBxQqwQEwN11q5wXeZ9Wdo73E78VGeZdH
	 /rxpwj7hZcGyxwI9pUlyelWJCHKAAe4tHPgwWbsM/b55Cbs3HnT7qgMaJnnKc4dPrtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tkN4K6Zy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.51
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D4606A327;
	Sat, 14 Nov 2026 05:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B51D4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tkN4K6Zy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH9RsHSCwMrD6OjpEUjml6YoNg76JEQYC/uDD+h2AXqldh29TdgLdRV+H1J+LBxCYbSb5ZR+qj3Rz9DeGfqYp+2VY/1coWC/MAxl3aeIe5x1fe+n0ZeWbI/vLWFA5DiV0UBAg1+5Ty2HPFS5m4eoIROPEuL8d94dwngie65Pp4kK7f6z7hPC5+oX1wDdsdeLYCra+CT+sTsygmXmfs27Ir/EAA4JgZGxNKrHfBLOQPEIjoHGBVVF7nMMFxO+Gc8puUPNmXbZuaTS1Yxor7gdbZxSg+rBvDc+WzSFAy+q41juJOsrG/3dHavTq2qmEhOYXXs/QSSMzCluZmJrTcqYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Aq8RPZ/sptmUocOrBADIXcTVIFOaABpWeNbGlwKF4g=;
 b=HGl2diNBXJijGXnRDPALE2BQaI2t2R77GgTEoQKTF4du7I2w6q61eg6a8SjmcSTInXqjA2UYIyux02N6AAyRrWR/t4l9Tz2EFyTfpxh6WQAtYahicgylCnRm9Z+hRaLSIAFVKMtv7wUShFIfeauBCgeFuF4bID8eo3NXbtdypiHLCP2l96WjcQI2w69lZigadQsL0Kaw3QY5Ds5+Epzje9EzVdQ1JKOrb63NdvizfEn2ku2QYJkDNpVDUkFHBPBWgciUNrjvlOz+DaCxvxkozu0iBNl/2iCs8Z6OzCb8xhN50pH+LJqzpm+wXevViEeg0L+bOkMdGm7kten82bui+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Aq8RPZ/sptmUocOrBADIXcTVIFOaABpWeNbGlwKF4g=;
 b=tkN4K6Zy0GWGCkUlWCqo2vnuGpbSj0WDBmCQxm3vCrirIeAICgS6CEK9g15TkUKF5KyP81EBamuiM1QXNXamh9iju/NnEnbcpdIghxDOgd1yc1mmicucSVIDwi/YUqB3R3hhRrLnXhB1g9TfzSO4bN/L8zg1czpo4OP9OvT1N6Q=
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 14 Nov
 2026 05:48:41 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::9d) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sat,
 14 Nov 2026 05:48:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 05:48:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 23:48:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 23:48:40 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 23:48:30 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: <sai.krishna.potthuri@amd.com>, <DileepKumar.Nagavarapu@amd.com>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <pramod.nexgen@gmail.com>
CC: <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>,
	Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Subject: [PATCH v6] dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
Date: Sat, 14 Nov 2026 11:18:26 +0530
Message-ID: <20261114054826.3222636-1-dileepkumar.nagavarapu@amd.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 242343d2-85c6-4de1-af3b-08df4212eff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|13003099007|18002099003|921020|3023799007|261026140227099003|11063799006|56012099006|261009221727099003|261009221227099003|261009220027099003|261102123227099003|261009223027099003|261009223327099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261021135927099003|261026121527099003|261021123027099003|10067099003|261028144727099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2jXw1tCErlPjRprsbkXjKBwzlJNrYDQa4TafPszxmbOswmj/I/O7TnWw15HAqEwU8bhmdKGOGpELwdytOMH/bGPRr5B6dZuKeE3KnCuZD25pBU60k3yEs8HnzaoCm+AGh8AAkAELvcun9p0NYMlaqRu+Tc2EGa8yrNdum7hiCDN+w5q/sbyzHzu20UxlKQW6Dfav/1Jvd1VM6KgrQdwkykdQWUGvD0QvzkWQsKxIGWhNN4RlnIfYn05HBOakcx6uDgsBmdpAH5+0lZahpOirRzuKDiX9PCy4f/yiiVgBhBlEsVINriGJcOEeE7rRMeVaBBPF+v/zxGgggib0uLG8iP+19hmPWnv5tsY2RjD78oqTQBVwrPcDJuu9wlTCEXKSPIuom57uY2EPbRygQIo/vuZKAf197NC8jsrZB9/kD1e6pCWGwRIqTYWJzPvlOKE+iI8FykekSAKWNL4dbTKz/nSUTnOpLj8Y9tVeeL6wZ2Hy/TpPwp8mYOs+Jq2x5LU1oKWwsubi/MBvOQ5di03CAhnpqWVvByCkW8cv9PDEQXybf/JWlWiyyr2iGxprJVPxPl9nqwJJlEYTppAPtOiSBvjxltneZgCOpejyApNn5dUSZxZw06+cxFeNuB8GTpdp5zyIwpXpPCKOmG/CgLYZFvmfFARJhB8ewYsG2nWGkQ+7o6gwqhN6lo1ah2s50NdB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(18002099003)(921020)(3023799007)(261026140227099003)(11063799006)(56012099006)(261009221727099003)(261009221227099003)(261009220027099003)(261102123227099003)(261009223027099003)(261009223327099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021135927099003)(261026121527099003)(261021123027099003)(10067099003)(261028144727099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q9YQC73dN2vkCT00E3NKWHULqvrszXAqq70p7rtCeDQ4jrEmPHXQunMFf40H26kNsH7LwVzbBwxlO+471lJ9lbB2HC4Y970sutG9yjgMRITVlH3QvcxdTD0bA+DX+8lkhcYWHQxJbE+PSrGTqN25YSc4UyrwjlKJ/hOqWCiEXLDsc1gkze9vKRwxhjD1/iWJIlX8x2J2dYjyfDtCGRiIh1w0YoD5uIkq+E7KUZQm/yTNX3t6wNeH9iDpyfHD3EAR74iJk65B3KwiWITDFfpSBlMkIutlyuXhWUAn8XlGUCO1e6rIZjNupEhf8P5WvPbUhgzL58vncSABKBFmNJEoyznNHnEaVbovpJC4bTcag5/v9jLX9o2GkxJI5q4QX+gsedcovQP8ySNyM/obS6HeJgHkH+2XdGKARVPyBD58/aQlMKIQg2YPJ6U2u6u1JqL3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 05:48:41.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242343d2-85c6-4de1-af3b-08df4212eff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703

From: Pramod Maurya <pramod.nexgen@gmail.com>

Convert the Xilinx XADC and UltraScale System Monitor device tree binding
from the legacy plain-text format to a YAML.

The new binding covers the same hardware and compatible strings:
  - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
  - xlnx,axi-xadc-1.00.a  (AXI softblock)
  - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)

The xlnx,channels subnode retains its legacy name (including the comma)
for backwards compatibility with existing device trees. The reg property
of the channel subnodes is limited to the valid channel range of 0 to 16.

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
This patch was originally posted by Pramod Maurya.

Link:https://lore.kernel.org/all/20260515075736.172172-2-pramod.nexgen@gmail.com/

I will be maintaining the patch going forward and posting updated
revisions.

Changes in v6:
- Add Reviewed-by from Rob Herring
(Comments from Sashiko AI review)
- Remove the paragraphs from the commit message that described changes
  between revisions, and reword the commit message
(Comments from Jonathan Cameron)
- Drop Lars-Peter Clausen form maintainers list in both xlnx,xadc.yaml
  and MAINTAINERS

Changes in v5:
- Simplify the commit message: drop the mention of automated validation
  and remove the dt-schema PR reference
- Use "hardblock" and "softblock" instead of "hardmacro" and "softmacro"
  for the Zynq and AXI XADC variants
- Drop the clock description
(Comments from Jonathan Cameron)
- Drop the "|" literal block indicator from the clocks and
  xlnx,external-mux descriptions, as the formatting does not need to be
  preserved
- Add "default: none" for xlnx,external-mux and remove the sentence about
  the behavior when it is omitted
- Reduce the examples to a single one. Remove the ZYNQ/AXI/UltraScale
  origin comments and the two redundant examples. Add xlnx,bipolar to
  a channel in the remaining example
- Add Sai Krishna Potthuri and Dileep Kumar Nagavarapu as additional
  maintainers in the binding and the MAINTAINERS entry, alongside
  Lars-Peter Clausen
(Comments from Sashiko AI review)
- Constrain reg in the channel subnodes to the valid range 0-16 with
  minimum/maximum
- Reword the commit message to describe the valid range constraint
  (minimum and maximum)

Changes in v4:
- Move xlnx,channels from patternProperties: to properties: per Rob
  Herring's guidance (keywords.yaml: "Fixed strings belong in properties")
  This requires a companion dt-schema update to add xlnx,channels as an
  object-type exception in vendor-props.yaml (like adi,channels).
- Fix reg constraints inside channel subnodes: remove items block with
  minimum/maximum which is invalid for cell arrays per cell.yaml; the
  valid channel range (0-16) is documented in the description instead.
- Remove redundant type: boolean from xlnx,bipolar; the $ref to
  /schemas/types.yaml#/definitions/flag already implies boolean type.
- Fix patternProperties regex for channel subnodes to "^channel@([0-9a-f]|10)$"
  covering all valid hex unit addresses for channels 0-16.

Changes in v3:
- Move xlnx,channels from properties: to patternProperties: to satisfy
  vendor-props.yaml meta-schema (reversed in v4, see above)

Changes in v2:
- Fix patternProperties regex to use lowercase hex unit addresses
- Add allOf/if/then conditional requiring xlnx,external-mux-channel
  when xlnx,external-mux is "single" or "dual"
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ---------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 164 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 3 files changed, 172 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
deleted file mode 100644
index f42e18078376..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-Xilinx XADC device driver
-
-This binding document describes the bindings for the Xilinx 7 Series XADC as well
-as the UltraScale/UltraScale+ System Monitor.
-
-The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
-The XADC has a DRP interface for communication. Currently two different
-frontends for the DRP interface exist. One that is only available on the ZYNQ
-family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
-on all series 7 platforms and is a softmacro with a AXI interface. This binding
-document describes the bindings for both of them since the bindings are very
-similar.
-
-The Xilinx System Monitor is an ADC that is found in the UltraScale and
-UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
-communication. Xilinx provides a standard IP core that can be used to access the
-System Monitor through an AXI interface in the FPGA fabric. This IP core is
-called the Xilinx System Management Wizard. This document describes the bindings
-for this IP.
-
-Required properties:
-	- compatible: Should be one of
-		* "xlnx,zynq-xadc-1.00.a": When using the ZYNQ device
-		  configuration interface to interface to the XADC hardmacro.
-		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
-		  interface to the XADC hardmacro.
-		* "xlnx,system-management-wiz-1.3": When using the
-		  Xilinx System Management Wizard fabric IP core to access the
-		  UltraScale and UltraScale+ System Monitor.
-	- reg: Address and length of the register set for the device
-	- interrupts: Interrupt for the XADC control interface.
-	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
-	  when using the axi-xadc or the axi-system-management-wizard this must be
-	  the clock that provides the clock to the AXI bus interface of the core.
-
-Optional properties:
-	- xlnx,external-mux:
-		* "none": No external multiplexer is used, this is the default
-		  if the property is omitted.
-		* "single": External multiplexer mode is used with one
-		   multiplexer.
-		* "dual": External multiplexer mode is used with two
-		  multiplexers for simultaneous sampling.
-	- xlnx,external-mux-channel: Configures which pair of pins is used to
-	  sample data in external mux mode.
-	  Valid values for single external multiplexer mode are:
-		0: VP/VN
-		1: VAUXP[0]/VAUXN[0]
-		2: VAUXP[1]/VAUXN[1]
-		...
-		16: VAUXP[15]/VAUXN[15]
-	  Valid values for dual external multiplexer mode are:
-		1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
-		2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
-		...
-		8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
-
-	  This property needs to be present if the device is configured for
-	  external multiplexer mode (either single or dual). If the device is
-	  not using external multiplexer mode the property is ignored.
-	- xnlx,channels: List of external channels that are connected to the ADC
-	  Required properties:
-		* #address-cells: Should be 1.
-		* #size-cells: Should be 0.
-
-	  The child nodes of this node represent the external channels which are
-	  connected to the ADC. If the property is no present no external
-	  channels will be assumed to be connected.
-
-	  Each child node represents one channel and has the following
-	  properties:
-		Required properties:
-			* reg: Pair of pins the channel is connected to.
-				0: VP/VN
-				1: VAUXP[0]/VAUXN[0]
-				2: VAUXP[1]/VAUXN[1]
-				...
-				16: VAUXP[15]/VAUXN[15]
-			  Note each channel number should only be used at most
-			  once.
-		Optional properties:
-			* xlnx,bipolar: If set the channel is used in bipolar
-			  mode.
-
-
-Examples:
-	xadc@f8007100 {
-		compatible = "xlnx,zynq-xadc-1.00.a";
-		reg = <0xf8007100 0x20>;
-		interrupts = <0 7 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&pcap_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-			};
-			channel@1 {
-				reg = <1>;
-			};
-			channel@8 {
-				reg = <8>;
-			};
-		};
-	};
-
-	xadc@43200000 {
-		compatible = "xlnx,axi-xadc-1.00.a";
-		reg = <0x43200000 0x1000>;
-		interrupts = <0 53 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
-
-	adc@80000000 {
-		compatible = "xlnx,system-management-wiz-1.3";
-		reg = <0x80000000 0x1000>;
-		interrupts = <0 81 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
new file mode 100644
index 000000000000..b0f2128a3032
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and UltraScale System Monitor
+
+maintainers:
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+  - Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
+
+description: |
+  The Xilinx XADC is an ADC found in the Series 7 FPGAs. It has a DRP
+  (Dynamic Reconfiguration Port) interface for communication. Two different
+  frontends for the DRP interface are supported:
+
+    - ZYNQ hardblock: available only on the ZYNQ family as a hardblock in
+      the SoC portion of the ZYNQ device.
+    - AXI softblock: available on all Series 7 platforms as a softblock
+      with an AXI interface (PG019).
+
+  The Xilinx System Monitor is an ADC found in UltraScale and UltraScale+
+  FPGAs. It is accessed through the Xilinx System Management Wizard IP core
+  via an AXI interface in the FPGA fabric.
+
+  The xlnx,channels subnode name contains a comma as part of the legacy
+  device tree binding that has been in use for over a decade. This name is
+  retained for backwards compatibility with existing device trees.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynq-xadc-1.00.a
+      - xlnx,axi-xadc-1.00.a
+      - xlnx,system-management-wiz-1.3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  xlnx,external-mux:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Selects the external multiplexer mode.
+    enum:
+      - none
+      - single
+      - dual
+    default: none
+
+  xlnx,external-mux-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configures which pair of pins is used to sample data in external
+      multiplexer mode. Required when xlnx,external-mux is "single" or
+      "dual".
+
+      Valid values for single external multiplexer mode:
+        0: VP/VN
+        1: VAUXP[0]/VAUXN[0]
+        2: VAUXP[1]/VAUXN[1]
+        ...
+        16: VAUXP[15]/VAUXN[15]
+
+      Valid values for dual external multiplexer mode:
+        1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
+        2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
+        ...
+        8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
+    minimum: 0
+    maximum: 16
+
+  xlnx,channels:
+    type: object
+    description:
+      List of external channels connected to the ADC. If this node is
+      absent, no external channels are assumed to be connected.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([0-9a-f]|10)$":
+        type: object
+        description:
+          Represents an external channel connected to the ADC.
+
+        properties:
+          reg:
+            description: |
+              Pair of pins the channel is connected to.
+                0: VP/VN
+                1: VAUXP[0]/VAUXN[0]
+                2: VAUXP[1]/VAUXN[1]
+                ...
+                16: VAUXP[15]/VAUXN[15]
+            minimum: 0
+            maximum: 16
+
+          xlnx,bipolar:
+            $ref: /schemas/types.yaml#/definitions/flag
+            description:
+              If set, the channel is used in bipolar mode.
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        xlnx,external-mux:
+          enum:
+            - single
+            - dual
+      required:
+        - xlnx,external-mux
+    then:
+      required:
+        - xlnx,external-mux-channel
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    xadc@43200000 {
+        compatible = "xlnx,axi-xadc-1.00.a";
+        reg = <0x43200000 0x1000>;
+        interrupts = <0 53 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                xlnx,bipolar;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 745d8d0169b2..e7f402c45054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29996,6 +29996,14 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
 F:	drivers/watchdog/xilinx_wwdt.c
 
+XILINX XADC DRIVER
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+M:	Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
+F:	drivers/iio/adc/xilinx-xadc*
+
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
 M:	Brian Xu <brian.xu@amd.com>

base-commit: 309bd01041636b587bcb424b243640b448bd62f7
-- 
2.34.1

