Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626710;
	b=cTJH03AMV/7F4LqWwl5R9Fr8Mm2DXqb26pat89Hz1C2JwWlefaYf+5HPorCHGAinnCRp
	 dDiSk3tfHwC+zPuiMODx/GzvjYtP7X5JeeFzWO0vcjpBlWV7Jgn0zcR9rEPa4yhCOdaGc
	 2Ryj/O2zjFcYaFu3TxecHvprgJa4qwtmxyNj5Kxqc9c1D/PyUMoGM+bwCs+D99zayIA7D
	 FtsbSOyrPSCxxNNYQNnPzg211UMQuiJ3wybzDep/qwK0QypJuT688h5NaaorgFEmAaVzt
	 hwPrIkoCOUYcwuyOeTWaMPVDOkc+9ygpdbR6chont5f/9xvB5UBgARfyVfnAEn6cpZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626710;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=/9Fqr2P/cgXeKdMrM9LMEJKTwG1wvsdiKCHFNbxUxBc=;
	b=TwsO7hY1lsbpkoLntlL6k4+mrke8hfCWsq4mm/zn2vc8JfPAmUualDf1ceiYBp56eYx2
	 tu8ocQpcSAxGO9iYQuYo87oz4T7RCQtC4NWPVT99jUN0T27/BnUjZ/iH+SEETyF4LV4XU
	 8M08PFJnqWV9Uds9D7N1ApZxvZIenrHS8x3eY643n+OXRF42HAXpo2zAsCvJrROUtl2O7
	 ukkQKZ4ttQn4tNe+owSeWaI+b/hZ5IU72QWIvxz89h9HDx/eg6p/OSxyP8wUxslXIgvQP
	 YvLkEIRVz0Rd111L/ijms1RlYPV4v1nt4gXVHsrFWQukxoxLpznV4ijQXPrCLhqBGIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BaAnavEu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.36
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50798606A327;
	Wed, 25 Nov 2026 17:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50798606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BaAnavEu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF+KVa7yHFDHp68j8HYD1vGhOYN6aFjg1gSdOzs8DVb1nucIkUasurcqwNaaqfz935q1KDdkEmMlMm8af3PFgmp8J5u/zhAH31DPbNsnaFw5k74f1bZVVFAkZw5w/w6/76YeR5BgmC6zZiQNXZhwN4eEd6Q57lQkjkBBkFO3/mbPw+wyRYtof/KEQ70cSTN+kx8xWX+TxM1oYmPaKp6g/p8s1NYvbY+s2yfJWxxSHCWRyUQ/rNYfcdNq9LySlAo/HDg+xEg0fgFtt5vHmi+SQ8pkOAkap7VpyuMQJkp5CVN3XaArhu957yaU2S4pN7fEDdkFG/JFr0xXWE2v8NjxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9Fqr2P/cgXeKdMrM9LMEJKTwG1wvsdiKCHFNbxUxBc=;
 b=uz7UTA7o7J4o1eZHaiKMw76d4r185Mv/g+RjsjRhCPAsV+ICyNoL2MHP8DSWMj4rw1wErH40jzkrG1hFL0ajqxQo0RES7Gfxi+8IRn0vSpA9QzeqX3TrS6BGLKb1a189UUk5JxvXLn2USPy5AeJBFRulWrvCL7TjMhniuFLHuXS8/zKbV+jrAAiN/Quu7b3EGdUKQv30LavrkJpXpDwF3qppH48o7JTtGFmZ5k3G1qU4U5vNHQhJxYd3iUUNsXtvdSAy5Zbyk6h+oDzONOKRsUiEaOQN9POzFNVHRAe/2DHahIE+UN1NKmSAAMWtVkNXRm1/Wx6InW+ysjkDla9LHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9Fqr2P/cgXeKdMrM9LMEJKTwG1wvsdiKCHFNbxUxBc=;
 b=BaAnavEuPZmlq4V+Ycs5UREJLQFksUljrPtLWjWRBwPa6aEFVOnWoMlYfoasZnt/UG2PoX9CsutNq8p04BpTOIaeHecj2BOxfL6NNI32/aQRBeJ8DjmtYdKXcLavNI6p/FDiUmLdWFCUL6u/uJ3GWFzKoxp9Rk1yVrLMTfUNw0o=
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:11:41 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6e) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 17:11:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 25 Nov 2026 17:11:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:38 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:35 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 11/16] iio: adc: xilinx-xadc: Include appropriate header files
Date: Wed, 25 Nov 2026 22:40:25 +0530
Message-ID: <20261125171045.1246381-12-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb66805-cee7-4e2a-cd36-08df4b172b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|261009223027099003|22082099003|18002099003|56012099006|11063799006|10067099003|261102123227099003|261022075727099003|261021123027099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Np9GGMLMRIPN0ycqERAxwiBIRJPpf1jlYNLpVVSsWe9ZmDR0bqyQ8EEyImdTx/N99jOPJPG9Bu/J53nZiJf5aZHnlldRn2bbV2mYs6EEDIg4ssKFPGrQ8jURQPxWtc92rJBFlFwfZTVIvhBBo+EjDSzynTdOKCa9V7M0JBiiQuHnNvPIiagxWeRsEB+miDeSxjjz9uz6kb93O0sMy1TuUrDUGbkNC8fyxlqUEhl2GTQqcp4n2QXZa59n5Cz3D11u7V2La+WNQu5xDE+NApWrveOPcF6QMUI4/kOtfk2hSAKtXKk6Y2CbnygkT1JXiaF6ZLnmaHBjJV31I7PN/DIiEP1c4T61FW5YRFYaVRSw7W2gaEk/NS76dDwJW39ihGYolWptjTSZVJCYPR5oE3VMG47JKHk8Kp0UbKWjjCHrtZP1p1txmqE/XcqEaSayQdHmsxYspKJDJzzeYMUSNthsFwHUdyQou1YmQs+FOkKGFSCAYuOfPMGzCNooOag7YU0lPcWcpXnT5IQIG3LBqqh6KuqKswWd3N7q22STdtRoCOlFIdSCUe48voZEtkJqJTC5ar5COSKj17z8QsgoBdJyw57HW2xjmcvE+LfqQmfD/vK4Sl/50IzXuNQK0HQzLNTUjPdkxfPiz8fnK0nPAODHKEoxvDppWHH+JD9cRkTCH8EmnlPT2U2FeKtjKp3bkXEEXdTAberbOTC9NV0xDWjPgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261022075727099003)(261021123027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+ezsKSZ3SG67LAKt8xWIScFZHox1bKdr85lA3e+uD0alBDohf4aUUXnWMCPxC7CaaL21GG8JBa8n8mcA3hkWJlLqqVCDbG29KLUI0Poh2MIt4bKCDXFNCErCbqYQK30R102cYT5X5CfBvSMIWm1uluByyUiY1AeVYAvZGH2e7Z8wzTtwl12QzVA1buHunFUwVCJdAGZgXc1w9wqfhfEHwTf5i7AGYniOErpOI6xLZOLuzNBtqXhbcZ9SSeA8u3oOvLm+6NkzZv9nM2SPuHFOFbX6UhnY83emHliWlShEi2RfDg6zILlIfSVPiLyecXxRwtxOR8jHipF5mNIWTV8amGETdgMjAr56gLY9DYtKsslsd6AG7/zqtNK3AcS+p7bPzi9HsbGnxu+e1G7yQpL0sTbOZ1PpOQt2ULbaQ6XIB7paw+h1cemP4u39uIO+87Af
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:39.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb66805-cee7-4e2a-cd36-08df4b172b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

Include the headers for the symbols the code uses directly
(linux/array_size.h, linux/bitmap.h, linux/bitops.h and
linux/container_of.h) and drop the ones that are no longer
needed after the recent cleanups (linux/kernel.h, linux/overflow.h,
linux/sysfs.h and linux/iio/sysfs.h).

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 7 +++----
 drivers/iio/adc/xilinx-xadc-events.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 813caf66b11a..7a92ea75cbdf 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,28 +11,27 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index f20614edd153..a63ea766b712 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -6,9 +6,9 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitmap.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 
 #include "xilinx-xadc.h"
-- 
2.34.1

