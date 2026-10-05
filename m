Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7F463B62;
	Mon,  5 Oct 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193390; cv=fail; b=I/jo7tAd2NB35Ad7bxzXtbmAWpP7fKp9+iZR9lCB8UOWLDoz9oO4MD0upFw6qGKeUM03sMPyv0eOpe0+MccfOrq3+r79AmPkxUD3BuOL1AscN1gP9/iY9sOFQHBaIYY+Kp97bVghmf3HDrAzCewddLG4MwTg0wAAyc2M3bMmNqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193390; c=relaxed/simple;
	bh=qDpyaKlW58A7y+OMtLFNMZePbgqt/vOurKQFZ0AnTME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWiwJ1qb74pmvnuwL2jXtPpfhlOqj+3fsWQ7W/Zon2Pt3m8clN0xezo1ddckJFJZ+3IgAyROKDJdyexypyN7Gw1mSfB5RuKclKUk0HVgJpFlBLYNDMc00hHxOFr2lq12ZgVWWtvnA/5n2dsHVqn4/2+yYjT6uiznGEMRX7y5HZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/RS4q/l; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/RS4q/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEGp0JJ6FCtEg6TcKq6YzKS1iizVZ8dNBQLUY2QhYTsFSvcqhmHh48DbF+YhYa36DiNlf7+toMLFkNqwHK9q1QmzaIiPx7bDe7DsvA2475ge6zfUHV4vkGhXgfqE8AqkDP38llg8zUwG3K4Fs6gkIKkEm6aE99Mq5oAk5gRBNJ5AdU4y8W1gj7rejriFsWgc14bqQKajsKPVwfCCKHnP/GRPJVLpmQFWL2pyBU/qGMGOIUWTEo4LgAK/VJmMb3pNOJq+7OZ/NI0Zkb6h1z41bTHxOWaHDEj25SmVw04Z7jh21ChbBBLymYFAagGejiABzYLRsUF280Ddadn3tD56Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFxJkmgXmcPATKNvoUg4XNjuk7RRbHMcKiLeY5DnLHk=;
 b=ya4+TXNqI9c8lBEDIsDA0oBxEV2RDCr0jEmVmpUVlwN89GjuYk+Yu/Rwn2TJeF5YAE2DAi+stPJEd624daBr8VtfCDL40GS+Orr+/mJCRirB1QDqVc8Jx9ELSXQFBTT3zEKRG5ty+MJAoH+fdZPuthz50XGBqNenhj0dYJ4zkZK3oqZFXQmYNMAzgmyJXvOSfJBZQwqskzVG/VUGJ4hrlulMvgWtfDoU3RKWPNzLYNyPzt1Odbbq2O4Hsh/5dGfivjjOzD0H+ZAe5bGawpZ+iP2A9ZUjjC+qCM4FqOxnV0UPkAZRJq7EV9bALwm41SDDhXCTfckCxldvoSawRp4xPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFxJkmgXmcPATKNvoUg4XNjuk7RRbHMcKiLeY5DnLHk=;
 b=G/RS4q/lZCZKfdbWtwBN7tYrpveHRgmKJefbUrw0VN5wIMnKzFv7EMjaW6XrV0qaJ/HmSMr9WCf3AsphqIgx7ylJtCvSkqmiCgaVBsmwNQBP5JWKlOBACvdf3nMmE2WTAHxLe+LtjvWI+Pn7js67Ouw5p1bpBcSLIPiZm9zPPP0=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 09:42:57 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::8f) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:55 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:52 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 10/15] iio: adc: xilinx-xadc: Add clarifying comments
Date: Mon, 5 Oct 2026 15:12:00 +0530
Message-ID: <20261005094205.1045874-11-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a658928-1b75-41e3-c5c0-08df22c5094f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LKXMoEJb+J49nVkNKAXjYpo9G5w/FU5lWg+KxLEUPqwCPlzuo8gYcksNS4kz2vPLsNDBjU7+SE73NbDhCUmGcKJngYCusTaco6e0OoQOYCVlGeHmc9iTdtmICm+xPNeAczE1JXPsDAUmFtbfYDmpz1qVI9vWeHdMgeczEmngdEIzUUU1fSUYppmfTGA6pjdsIOzZWDD8rYy/AU/1HpD63i4f/4ltCx//BprpIyPI1V8vc77y1DE8g2BHuqk8+UTtqCTcTT3zJ1GTgV5V4m71dZnp/xe+PfXHo/y+t2FsaRmu7XqFXKPQcwakg8BwIXGkMkG1qpNhF1F0RBa5ha9KEuDrC6k2NImhAmhZU2RXOfi3aBTbGS/d4vTIdCtUh8t6ydjQMriB7Z2BLOJ0lX+uWNje0TB34GOGtT2JnaBAykayBH/I2E9bT2CkL+rFrixnl8PApoxcU7h2ZdtbIPdwdBlCM6LYzCLbx6bLbWET0HA/gc0GbCdgzJWg9a6nCswqrhYTuPYngITua6N9k+mHY9dXdTy2vFHZafBQWD2Y3Cwek+nFF8725sL4YREtbb3a1GqUG5pzUGjY2IN3drCdGfRwg32tmFueFCtWCEm6pXAwQiagr/lR1tlox0tgKEgfNe+/6H3TUvfJYKzzso4Z/eqK/FunMXrPo9Q7mKWE04pqH9f9yrYbXj2Ux+JlfpiasBhFpOvElgcLINTyC2+Uug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BVphkvcQpIFVgBXFGtHaYksK9mCRd9h6dor3fsuIbf1ZnyiELerLkQrvU9gAQ2OlnSvDqJURYeWZWUYX5FhoZOS5n5JkJM+46+VL2bLLOroT6MfsU7vXSUtUJz38lH/6vPrqhyE4d+1ZBN9duq5EQ1RHrDDqg3tVpd5iPgT7mjU2yjMAIU3jFnprjZm5z0ZtCbiZZZoPiYuZDTRVM9EBCG68jBzAl8gLbOT4ppbxe0l25isckZNjuAIEQ4nA1dMigj2rwkQzNyjdsv25LxcjCkXdoSbjTvIH7RLaV6DmdFCECh+MdyQ3QKna2a35xMytgCVUlA+1qlaZIDU8F6cL0BP21KSwFrAaUDHnD5zBSggq8ILAuZfJFAa/8svZtXl9EK+wK5W2V/tk+ncSe9j8+WFFsW/2cw0JvytJ+CPbCwTLkv0PM1FFdTwAT0aE0z4S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:56.9589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a658928-1b75-41e3-c5c0-08df22c5094f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052

Add missing comments on struct mutex and spinlock_t in struct xadc
(per checkpatch.pl), and explain the non-obvious FIFO-drain loop and
Zynq alarm-bit reordering logic.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 9 +++++++++
 drivers/iio/adc/xilinx-xadc.h      | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 46b95883a250..47fa4d516611 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -133,6 +133,11 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
 
+	/*
+	 * Reading XADC_ZYNQ_REG_DFIFO pops one entry from the data FIFO.
+	 * The loop therefore removes one pending entry per iteration and
+	 * terminates once the hardware reports the FIFO empty.
+	 */
 	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
@@ -216,6 +221,10 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
+	/*
+	 * Reorder the Zynq PS-XADC alarm bits defined in UG585 to match the common
+	 * XADC driver alarm layout.
+	 */
 	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index a659b7981b2f..cb48a5a38e8b 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -60,7 +60,9 @@ struct xadc {
 	unsigned int zynq_intmask;
 	struct delayed_work zynq_unmask_work;
 
+	/* Serializes register access and device configuration updates */
 	struct mutex mutex;
+	/* Protects interrupt state and FIFO operations */
 	spinlock_t lock;
 
 	struct completion completion;
-- 
2.34.1

