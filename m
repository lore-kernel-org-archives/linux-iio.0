Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626689;
	b=JOh2m//P21J21LAQ6aPl/JcOdmSJ92OMMm1y6pGW7Hfi4YoJhJxBuZIi0DE4vINvVbhI
	 SvJQIU5XBZKf0gzAJAyWv+WxUZchPSAHSU7cCAKOzFnUyxu72hnOdCcKo+Xb/a8QdTWYN
	 VP9GEJr0tDmSHjdZbQDFZIz3Ms+4xB3m1sUa4ucdL8C0UAru7y2FkbQA9bsh04Osi+HyY
	 eQYmETYadonAiYb328qqWLjsvc3L9mPWrjmK4TNaU+dgbx+QtBDjc9C3TrjVEXu3NE8Ao
	 EnwYAWnRYdk1PhB9cN8woLZhcPZEJYRO6otFsliMCcT4d/+7EwwH6kBEbqPdL2Diiaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626689;
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
	bh=tmYKWYJHfbIgPZL3ZN9/ZNXKmKYheOj+VAnfOmL+vm8=;
	b=iExZmIFiabhwH7AxvWzxcuBuLHmeAop8SDycYNXvwkMUHRyUtEtxP7WSDjwvevj7T+fY
	 C2zCJIMWYlunDDwc8idSQnmOK22HU+zJm3g4rn9Z4EdnSNURPwmjmaFXQsqjpY3jUjwEQ
	 +ptnS64b9cJj7v0HhviYHe/WQ3M8Hr1GzDhMc6zQyhi9zzKh1buyowOtKC7JTPJWVR1Us
	 osdsHuihbZuwXAw1m7vJs4xnF5+bIyuAOXSFwukymvMqGZH4qlVp5CdJF3dUygxaWN7Q6
	 Daqs4xq8c7vJ8vE8t856GAdpRSSpEz2Wv1G0UfjPj2Fncz+FUSKxLFdiVyOyl8/Ff9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dsqElTW7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.56
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67A606A32A;
	Wed, 25 Nov 2026 17:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F67A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dsqElTW7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuAv/yBJZFMQZ2EGx62QuZcWDliOpUH4Toi1iOXExmzD6f+2u47t+IRg/vjCyIzGPmkz1SP7+y72GYWwFc41FpmOkVhcAAvjyyfQcWku4yjTDAGJlVZS9dqMXa5jyqn0rMQARGV4XiG37228y5iENcmGX+CkyAnuxuwAF1pKZhsYKlYqJTUlBF2wQkUF331WRV50Z2QZrH1vlpugrv6cMADIJa3Eq4OnJp6gIemDnWiUS11T5V8DGlEH/em0taXLCM7tuuPhpPZQS6yXSOYy+QF4ECVdcOa2IwGYXZL8pHzgQeAbOlx6x65LPTW+j+C2v4FKKfOQsJTTWuvNWPudgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmYKWYJHfbIgPZL3ZN9/ZNXKmKYheOj+VAnfOmL+vm8=;
 b=q63A32gPhJSmyPcK+eLiVlnh6ZBwRzs8jIjUtgowrGeMs9Xhl3k9utseIxdg9fPtp5iHhtnikPMwlF2S+tOzsyw2vCuYABy4C8QycRv7WazCxaFX7ZSQsU953M1ruOLpQnDELQCtC03HJCSueZY6pmI47zRrM39NLIqcFwJcCjCdu1sYX1RujUZ/En6wl8CKEw4qBv+GbJ4TPbhVcWgRDCPHTreKCOI/SawFUIx6yJ1yUxzGDajlBTrIX7A3YbjOWUXuxgurKuLLDDQEFBxrQm9xxmSSQwKaxoVyzZIe8pt1vKtthdRqfAywY9Qzw9Y7OpwDsPyxd4WFvD4pgHBM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmYKWYJHfbIgPZL3ZN9/ZNXKmKYheOj+VAnfOmL+vm8=;
 b=dsqElTW7f+ZYY4Z9lSdgWapbIL6G4d9J0eC6pA0PXdW9JpUZV29OZlIHdVy9um81MMffHAZJUhLGlnCAzI/d+DT1C3RzSDbBy6ObPfbWL4sBcGqnSrSRkw24UWv2i5itnL2YxPIYNezCfkSUvaIwpKWTRv+AQTQtxyMYAO5kHwU=
Received: from CH2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:5a::15)
 by CH8PR12MB049423.namprd12.prod.outlook.com (2603:10b6:610:32f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 17:11:26 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::7b) by CH2PR08CA0005.outlook.office365.com
 (2603:10b6:610:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 25
 Nov 2026 17:11:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 25 Nov 2026 17:11:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:24 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:21 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 07/16] iio: adc: xilinx-xadc: Use guard()/scoped_guard() for spinlock locking
Date: Wed, 25 Nov 2026 22:40:21 +0530
Message-ID: <20261125171045.1246381-8-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH8PR12MB049423:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c5b1e4-c668-484d-c517-08df4b172380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|261009223027099003|18002099003|22082099003|56012099006|10067099003|11063799006|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	zdfPkd5+qe28RLo4jaWmQxFeoEWHhh+CUDjXsguvXs8+o4jOIVhQIDuNZ5cYSwGwIWvVZW9bfjPyaLyMU4YZLwm8xG2YisNxcfZTnEPeX45Bv6G91PTTfRoLVYSd47Ti32Ti6KVKX/m1HAGWZE2ZC3Pu7GTp5tCu7IAzf7Wmylc4z3XzU6zXaGf9YvhiHsCYs3FrvCaMACo2pW7adHH5/7EW5mbNBBykRVXFlg8jb4KZEqG91AnwEI4DQZukiNCg98n4v8++hfXdAT8A5bDvigYuznO9gTCcX37AGqsBemcyfZLiLO6UDpXPthuGz6gjD6vCPam5DAulDXM6GpWuMtMpfxXgtOYCXutCz+y+FxdGhxSvoJCDt5rlwfS59X/tl1ET6JjqmTMuo4LdM9rQJftiFVRJRo+1a8OGu4bbk7BQ+9ka4jmxZa4GLQd2XIkP3wVtt9/qbuArSXEkrX4cEmK64Xve01RAcz3tJd2oHiAAfr3VJUNn3NoHdiw+LC2Km8Vi478u+c/bdTsoXAtsVo7gGXjq6iUS32d8pZU2GANVQgy7wC86HThMWuhWDB480O9/S9zrmb/CmwfAPMPNjCiyqkQrd5Lo9cKj4YQD8X1ITpOjUAzWiV6HfYcAVeUKMA4YLNy9rikfSeEuADcsk6CZjlh5TMGUO28yG/hkl+JG4bu7I6Vkk9n2FKr411OCUvkb3FpmdpiNcdWv0rF8AA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ndthnSlWhg545sft53hPbUICErDYPGhXiIk9DMaa2sBqUDTFphNM6aQEVhfcuuxS4QpgTjJeV3GQXGt0G9JWg5trM18X5mI0Aj8/qERb2KezdS2mQWJTEZHuVDdsrzlUzSpCBGICM3vTCtJGfvcoswdNr1w2DrfOE2bE/F93YLiPJBvIy/5eJWfK42j2Pe/Hfjqgy7cS84/c8RWHuUevG6bb0KPUaDEEv4pMMG28iHZkst36ebAPJv75LEvdTXWiVGNqEYTUicNJO45E0wNjxK8RoUOdbOED4al3yA3uwFGhYMz2m5mNT0O6nd/R3d7g6scs5jijsevI4MQ2Sr63rDhRusN/dZ/u8ol1tHbBToOokiARk0ptg+uQPVB/Oej4UB2D4CnxHWUItcLgQjCNbQmZXELJhFN+xNPo6ArAtYn8OLP/CXemuytvGcZNxTRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:26.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c5b1e4-c668-484d-c517-08df4b172380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB049423

Use guard() and scoped_guard() helpers for spinlock handling
instead of spin_lock/spin_unlock sequences.

This removes the need for explicit spin_unlock()

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 97 ++++++++++++++----------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 929e8973f49f..2d36de97e8d4 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -174,19 +175,19 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	u32 tmp;
 	int ret;
 
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 
-	reinit_completion(&xadc->completion);
+		reinit_completion(&xadc->completion);
 
-	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+		cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
+		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	}
 
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 
@@ -210,19 +211,20 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
-	xadc_zynq_drain_fifo(xadc);
-	reinit_completion(&xadc->completion);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+		xadc_zynq_drain_fifo(xadc);
+		reinit_completion(&xadc->completion);
 
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+		tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	}
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret < 0)
 		return ret;
@@ -260,21 +262,19 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 
 	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
 
-	spin_lock_irq(&xadc->lock);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		/* Clear those bits which are not active anymore */
+		unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
+		xadc->zynq_masked_alarm &= misc_sts;
 
-	/* Clear those bits which are not active anymore */
-	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
-	xadc->zynq_masked_alarm &= misc_sts;
+		/* Also clear those which are masked out anyway */
+		xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
 
-	/* Also clear those which are masked out anyway */
-	xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
+		/* Clear the interrupts before we unmask them */
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
 
-	/* Clear the interrupts before we unmask them */
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
-
-	xadc_zynq_update_intmsk(xadc, 0, 0);
-
-	spin_unlock_irq(&xadc->lock);
+		xadc_zynq_update_intmsk(xadc, 0, 0);
+	}
 
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
@@ -296,7 +296,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	if (!status)
 		return IRQ_NONE;
 
-	spin_lock(&xadc->lock);
+	guard(spinlock)(&xadc->lock);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
@@ -320,7 +320,6 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 		schedule_delayed_work(&xadc->zynq_unmask_work,
 				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
-	spin_unlock(&xadc->lock);
 
 	return IRQ_HANDLED;
 }
@@ -416,21 +415,18 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 
 static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	unsigned long flags;
 	u32 status;
 
 	/* Move OT to bit 7 */
 	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	guard(spinlock_irqsave)(&xadc->lock);
 
 	/* Clear previous interrupts if any. */
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
-
-	spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static const struct xadc_ops xadc_zynq_ops = {
@@ -515,7 +511,6 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 
 static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	unsigned long flags;
 	u32 val;
 
 	/*
@@ -526,12 +521,11 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	 */
 	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	guard(spinlock_irqsave)(&xadc->lock);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
 	val &= ~XADC_AXI_INT_ALARM_MASK;
 	val |= alarm;
 	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
@@ -674,7 +668,6 @@ static irqreturn_t xadc_trigger_handler(int irq, void *p)
 static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 {
 	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
-	unsigned long flags;
 	unsigned int convst;
 	unsigned int val;
 	int ret = 0;
@@ -700,15 +693,15 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		xadc->trigger = NULL;
 	}
 
-	spin_lock_irqsave(&xadc->lock, flags);
-	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
-	if (state)
-		val |= XADC_AXI_INT_EOS;
-	else
-		val &= ~XADC_AXI_INT_EOS;
-	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
+	scoped_guard(spinlock_irqsave, &xadc->lock) {
+		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
+		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
+		if (state)
+			val |= XADC_AXI_INT_EOS;
+		else
+			val &= ~XADC_AXI_INT_EOS;
+		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
+	}
 
 err_out:
 	mutex_unlock(&xadc->mutex);
-- 
2.34.1

