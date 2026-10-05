Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0D463B66;
	Mon,  5 Oct 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193387; cv=fail; b=FcqU1oLZG0sq0OOtfHUInlKUtLEZIL52MbD3FfZTnDWZr31gCcJpc4xS46Vlnig8xJQxPQop6BJygBPaj87536S5lFMHGZ2o/RjLKvVRoK/DbepWSqjKk1x+/RQzFV2OZB88eq/uNLPh1S2J9Z/jzBJXELyCAhm7pr7kyIzvyV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193387; c=relaxed/simple;
	bh=t2E+/eUEX5+ljmrCtNq5xNu7I0PpdunYaCkIlSIaW/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAOEWC4U1XYNtFDsHMbvcICrGOHVGraki0ljUWV5K+hxodw5vQeFR8aHmhWxCL9cYDNveDzbpHycgrSPmS90eG36PwnFMoXfDjgBwkZ4xpmsi32dOnQVvxxteaWSofaf+qUbKdpw1jNqhnh/ejdvf5/uIDBVrz7B+HfSllGiE8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjYz2XDt; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjYz2XDt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccHwYBSIXOrsIO/SfQv0l81vUDUGFWtzyuvHkCkvb+aePqY452iduMkuWH9bsfRpikNvs+AYdcFsn77er2JFxdApkUoqbVpGMYuQQNPtSzs1Fi3cx2qiF8zvq1Qme2veqy51vRtqWIJQNMcAwa22NISJHLYJTxS2wPKXeL4qkm8wEZ2MfjvqZq2PFYUgFVCBMNzpzk+mkqtHiJb7+3f2oSJHyJPA05hs0uTlv3X0/mF4H+D/GLPscCKDWhBkGyA4L+QrpWkOZKvJV9BL02TttBjBQsLD+nKen14XtuO+Uox3GY3hl4InPXd4xugnNSIJvyT+66jLxg4G6k3eu+LbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuE2SQFC4DRh/PjiVGWvUBbryg2h+J3J6eaUTqXD9N0=;
 b=PbrMySnI96luFDvd5A8k8UnjgJ53aVL+JK3j3gBwPz8MSltqQTOCbIPOTx1qENSN3yPFbEERnZ6Ssx11MDRRxkTmI4jU9du/batq5wu7UPXSKr5IekKC6nd2FMKD7raeiaR2eVfrrgAfZo2McVgwiCWYfy+Uaf6H0LwGiqC2ZWcINKspTjTiMM6rSn6+yx0OziWPFtoYFqDjuY6G2Q+6tgI40BIZOoRamb6RIHYIRwp8ikp8DjnSZwHoknKeQxAl9YMLzAPptp5OkYHYhIR2k1o6MV1Ykya0GnjGfT9wEY99DvxsEZzL5qIRFkGsI/IEYKfuP47qiUjKIXK5PaE/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuE2SQFC4DRh/PjiVGWvUBbryg2h+J3J6eaUTqXD9N0=;
 b=vjYz2XDt2M3PMhjvj4T6lyJgDtd6k/SlaV6BWb9sgoe6LYG2kv5fue0IVN3CUqjCIVw4tIBJWxp8i2zw3p9e2qtk1gYA8Mtix3dDxTiLmIHC3J6BIbYZrc9yHKqO7a3Zf5IBroTVrnHIZPuFR1BRzDkrLtHAn/0dzevtT0pe6wc=
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by MN7PR12MB219968.namprd12.prod.outlook.com (2603:10b6:208:632::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:42:53 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::41) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:51 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:48 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 09/15] iio: adc: xilinx-xadc: Drop unused header files
Date: Mon, 5 Oct 2026 15:11:59 +0530
Message-ID: <20261005094205.1045874-10-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN7PR12MB219968:EE_
X-MS-Office365-Filtering-Correlation-Id: 525d915f-63f7-4931-15c1-08df22c50728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	6bFTRQZ0M/BsSIlEj91Tjt6su2bgp6X6Wg/hIbDbGkKbhbkM917y5tf74n9UwTJqJkTc4MO9Pg7+BhYqc7t9YEWkIYOE06Rwqh/APZP4RyrDREDhL4iayioOLz4YY2zI9SjzIH4DaA7Ki/QD1d5bRDWpA1pOlCCLOZ+BW5Nh0nZ6/CvYVDoARTNLyN2deBdrqQBv5dXa4RfVVzMp6Ro9KTc6OKGs2alpbhMxmQL3Z/1S9S4GUFPemVU8HE+x3smivxie1IpGON4At66rmn3s2DiaUSka6+gK8zrdVgJogxgu2/jQTPZgBNI3TV99R8Ld30/iBMHF0vkRh2PI9E+R6jsISptNPJiKkHkPzcMC7ZC9Dy0MKlo1JWv6ecc3ZXsKKwp866F+tyAuTTWt6lBHgfAN4dTLhScLpZ07+qS8TyHKRfGDJ1qBHSgBAi3mOJB3m1F6MHTKJdPzMu4E8arQadPK/MXYT9cT8x9+v98q5PA5BnRKOvUtQ5igu8lYDUvjIEtOKCGqog8B5idyBW6KSEnLevuKLNq5zqCLNsvgDPmnvc7z3kPKj9Wv9MjaifxRnz1cx7SP0QIAJGNjywAml8w3rn9Ewlnfd0JJJ2YFQiJfPmFv3EqCFWfRaJeFq5DuuePAb5fJCBxMMph8U5FitEk2adxEQymvk9aUt7HiHo2izvUPKylgPaIfLElulcRJoIZt8nf8zua+m2dbbxqkyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EN2UQ1+JhYnn0dFffhdalbBAgVX51x8S72Rfh/s6+GM4ipzDMBFtjX0zps44KAitMyTcaFQGGONwjgnEPNUjfUs02hjfUdi5AXhY+3r1lf749n6QWIsDhXy1khpYc+srSYODCjf2hL5/917JBsZnHytDyFLs8b6wq97O4lLilIQLkWgn/QWvaadWsms3umj8Jv0pfEx8SfsDyQdK4ViUJrArvh8cnFgDX1bFXOKhja4/bFiuTqAb72EnlDbdZ9L5VdtolAavjbz0OUcwoX//ZyRFFL1FFmXDBbWmfVw6zituSZogxqAbsvtT9LZzkyLn0yP1EeDaEuTWMPrfBq7EBi3moM9VzF9LcWdd9bd+oD5GuNFWT/1bN5t9fKJl8vBzFaxd19QXiOCtzWNg+8lRVDf3u+Ue2upcbJuPx89teHEXU+7UUHCPHaKew1j6Z8gn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:53.3442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525d915f-63f7-4931-15c1-08df22c50728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB219968

Remove header files that are no longer required after the
recent code cleanups.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 7 +++----
 drivers/iio/adc/xilinx-xadc-events.c | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 65fcefa07516..46b95883a250 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,27 +11,26 @@
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
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index f5b5aad6e313..ea0f06ca2a82 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -8,7 +8,6 @@
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 
 #include "xilinx-xadc.h"
-- 
2.34.1

