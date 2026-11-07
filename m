Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794059452;
	b=Xpb9gQ1rT0zyFlWArQC/iynjzGo1Sx2C4vPwnuhKqiugwe6I3P119E1LOyv7s9TBhDfj
	 NtF12SLus+lMZt+tYwpqkhx4FtqRB8n6Qn9IKAHBTz0n2zIis2qynfat+E6w6wI7Dtej5
	 EPLfd4ww0ERVyqWBjDApvgQyLkrmLT2ptHW0ZM+9Els1uco9XNaYGV6mXOQRWu7ubuAtF
	 Xud7VJi3wmnMShYKapW2xjdlqwbAeHi/493Sb1lA282djeXaXgmLmWRc/UmUvi2df8Ob+
	 rKRrWgWh7KiAtRlG+fjrKa7M7O3x2IsBd5dY7+C+hAue884RIglLpqPbNlKv8ZbBBLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059452;
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
	bh=gUjYiSjY8l1CmwK1SwGbTJkvLYGyM2sX3J+c+wA34sQ=;
	b=1blRFxujXZPS6T9Rgtf2cmf+DW2UMRfr6S31CVxF66fbB1k7/l6M9JLZ01iE/pCSeoYH
	 AcW15oJsbMH8iNUtP7/ZYutVZgpN1N+IGzn7FAUAsdBZZgdfKnYCWBVR2im4QS8DQYLQO
	 3OAvU1jgJSNXZnmxMIztVTnAzA18QPqHYYsnPCZL5ZQvp5PH8GIgj2f7YdYkZqoZKgCfT
	 0fVo2R1+IGzuB5LRe58YkCY3BTq/6jODnSQBj9n9HL77Y4+qpgaFD4TGh1riMmrtycsSQ
	 lzoRGcwp8LdH0lEjuJNGYlVAXQNKlne+HaB3XYvwk4+voqvqlNpfFtbjkIhtIau+WvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="w2X9bQp/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.52
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8490606A333;
	Sat,  7 Nov 2026 13:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8490606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w2X9bQp/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usEtLPlteM5jVOsiq1mLR1FRtK54qtoP4b/CUCslKa0XdEYYwJpL0LwczbHMl9X3QqaA0VtmsxJMbQ1cTS4y9u65OeBNh3czUxY8SY0sWD25gIGn7r00wJTrkIJhOwromOK1Tt5TzgY5S/8xCw/EeBxlyJrIWFG9iiQsWB4nddeYPW7GadacxpqJvA+Mp6QNq6jYL0WPA6PqLrqG18O7v/kukRf3nuJD7a3C5rxblnKxod1zzM6dHYdC5/BoW1Z8O4xDV0FV2QDH7Tq0/bCn7UkUEaQKoeuiT7vnKQfJiai004CiQpHUtMKr3b4R6DfyQO0sHxInNUQ7KLBs/SbFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUjYiSjY8l1CmwK1SwGbTJkvLYGyM2sX3J+c+wA34sQ=;
 b=kcY8Exl97bs5mlnPy14cM2P8aSbt/ifdbwLb6V3Lmjk5EFMQTwqrrP2QLiecmQyzd3rZ0QUM3vERWQvNlPvcxRANRj1J7M0ODM+YCZfIh1T3FUwyks0A5XtdEjGhgojsTDH+NM9s7j5DmlyM0PQM3oS5aoTTl92R12gnrcqKduryiqJiwM0FlzfCGL5FBIFqhLOhToD9fgiyq7osmqa2QhyTfpCauVK971kq+gbZoJcHrSlAANO25+ZP6ClQi5U/N5ifeZGvO2mcLVHQT/tdCRCoqy6d0Dkv+LC8FTioiPSO7cc1EbDOUhXTwqgLlG0mNWg1tTmU0LcXOSw92g8vRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=metafoo.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUjYiSjY8l1CmwK1SwGbTJkvLYGyM2sX3J+c+wA34sQ=;
 b=w2X9bQp/6wdQeL36RmW+bbajOFu2Sp7RxRg2KbNJHLCXqGumTfqj4lgs4sqSpScCnvjhQiB5fslk/B1uc86QbVNT1sPUfgf9Gq5fDl4S8qHQkoptmqzYxlaPH8/cLg6Jk+j/6bToS0cBgyChdq4ri9tPKDsobTMYhCS6+aMaj7Y=
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by DSVPR12MB999309.namprd12.prod.outlook.com (2603:10b6:8:41f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:50:46 +0000
Received: from MN1PEPF000793FA.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::8e) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 13:50:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF000793FA.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 13:50:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 7 Nov
 2026 07:50:45 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 7 Nov
 2026 07:50:44 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sat, 7 Nov 2026 07:50:40 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: <lars@metafoo.de>, <sai.krishna.potthuri@amd.com>,
	<dileepkumar.nagavarapu@amd.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <pramod.nexgen@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH v5] dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
Date: Sat, 7 Nov 2026 19:19:55 +0530
Message-ID: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FA:EE_|DSVPR12MB999309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2fa48d-a9b7-44d6-6c88-08df3cd61f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|921020|11063799006|261009221227099003|56012099006|261009223027099003|261021121427099003|261021135927099003|261021123027099003|261022105027099003|261009223327099003|261009221727099003|261022075727099003|261009220027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|10067099003|18002099003|13003099007|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NIekQlALZkvp2QPrIgzS/URbk95R2RWnHEoy3SVnsVZr+NbRnpePGKuxxDolqUaC5kpv75CN81l/bPrnDLQ+sivZLTJ63du594zCrFYesYfjyU+fTc8a0QzZA2g1r+Auu92e3WiwbQtnkEtXdxIwPKBt+80/hfml8yaU7flMJp5wlXBzR3by44wXch4K67RvOPXQAIWMoik3ffzRVAPDSvaFdcY85QGG5VI0IbXMly7Nn0fbGqVQ0/S2QRlC6XlXXF+5Do4WEXoinoT7H7aa7yIZDOrTlE3YwZ+KsiMjKXuaEo6Grp0dVw99xWZI3rOKN/iZ5bkof6HrxLjlKP7CAi5i4vfj/saqBMM8hufOMLDA8hIcje5o8Xzt5NrUmzZXmLpBxHeQaC6g9As2ok8nNnIZzBAJL3b3+kNZQnQPnmcOBAtEzKKJendth7tZFfY07WQxXnsWtrEd8eRyaZQssoPDMvBCsKGvQs6DZ3/EsBTTZ6C7JYOpbCBoSH7tlPlwE9rl4I8gVa8xBD52SqHSVzTg2DOa5FZ6gnkt3fkz75W9VhAmZCNp1LbDJgzsXYnLAxiy/2YCnnI5a0k3cjlLzwo0flRqeWHbIwEgFPoZAeWcLU7sZVj06FRYfpttTnw8xX3Tf2C5dJjNLzy5QkWv31fyGpwoE7htaUvoYEFQoeIYs8mCan/yBpsDpgHAP/4f
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(921020)(11063799006)(261009221227099003)(56012099006)(261009223027099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022105027099003)(261009223327099003)(261009221727099003)(261022075727099003)(261009220027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(13003099007)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y5d5MAV7KeakrzmHljq70y978i5WZ+29n5QJLOkxv9sC1t3PX255DlpYlqYutlRaFee5z0pkewrx1w8uf8NQbN3wYkc9TUtyqvXUAKxpJtMQd/u7SwWY9lhuvOAtDgqzsDeFGodd8Oa8fYut5QuBtbUk87efXX2QIsJoJgq4vieyU1BtvvIRjBkJfsuTtCtd7uJX/DLf7FnF+i1M1RYJAGDUdREGS6ICZOxwoS83l17DZ3/nQ7z1VZB6ohjzyp9ryV0ayCqKWWDVQ0zCkBDhtVrovW1A2zhzwwviQjx72PnwyMmjj5jTjBfe0drrgIO4wmVgJVAWF2DBBZfMD3IksUQ7j64smYbIKAhHLD4FNXJp0bSHsgq0uEVThXAmzdc8zJIhJ3CScY7mQUgA0C8z7Sr9FJXEihZiyvBLARNvqDRaPrn0hIAYJrX9dx0iCNAW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:50:45.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2fa48d-a9b7-44d6-6c88-08df3cd61f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999309

From: Pramod Maurya <pramod.nexgen@gmail.com>

Convert the Xilinx XADC and UltraScale System Monitor device tree binding
from the legacy plain-text format to a YAML.

The new binding covers the same hardware and compatible strings:
  - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
  - xlnx,axi-xadc-1.00.a  (AXI softblock)
  - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)

The xlnx,channels subnode retains its legacy name (including the comma)
for backwards compatibility with existing device trees.

Move xlnx,channels under properties, as dt-schema now allows node names
containing a comma for long-established bindings.Constrain the reg
property of the channel subnodes to the valid channel range of 0 to
16 with minimum and maximum.

Drop the redundant "type: boolean" from xlnx,bipolar, since its $ref to
the flag type already implies it.

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
This patch was originally posted by Pramod Maurya.

Link:https://lore.kernel.org/all/20260515075736.172172-2-pramod.nexgen@gmail.com/

I will be maintaining the patch going forward and posting updated
revisions.

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
 .../bindings/iio/adc/xlnx,xadc.yaml           | 165 ++++++++++++++++++
 MAINTAINERS                                   |   9 +
 3 files changed, 174 insertions(+), 141 deletions(-)
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
index 000000000000..2cbc3b82a26f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and UltraScale System Monitor
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
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
index 745d8d0169b2..2d7e9c9ca659 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29996,6 +29996,15 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
 F:	drivers/watchdog/xilinx_wwdt.c
 
+XILINX XADC DRIVER
+M:	Lars-Peter Clausen <lars@metafoo.de>
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

