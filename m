Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AB44F55B;
	Mon,  5 Oct 2026 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193392; cv=fail; b=MdIp921b2BuFjOtRPaWu/7Lqy5uQHXZWmJX3CKzMsi2C8udZgnBjKBzwJPQ1jf8ov+RJmOK5ofY62xdtnli2Y5HkusQuldVhgg58urIB7IVCnVSXAEZgmQaoD/7XbelhCOfBhnWaeTPHvLq+QU3KZ1TbCXzx9ru/HLk8j7ZnRrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193392; c=relaxed/simple;
	bh=wBRQjMEC72PTmGLkQJ/qxNrB7aHdxJdvzr/OpWtCMSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ1f6c4fb40vfg/Rp9v6W0LZ84i55Tl6k9Vinv3WO4ff09WUmshxzis2fadoKBOgrIR2xrbA/Yej8EfzUOk094nmQyvr76Z54WoFYZatV6Qr+u+V6i9RF8voTNkg5MZx0kGfIO3m5Hj3v1MCKQPBSy3Ahu9fLbnmFQdATJvgBgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZULDZy3; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZULDZy3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmjWz5SLl8luzm9NS8x7EEl9J26QS+rOS3AM8haO5MXLI3HhKASEXtlPb67SH/oFSYmY9P6BEQIspD8vAfvVGYeYd7vli2lPQj3VVuGv22p35lzWhwj9eEmOGT8JwGqh4EFrNcn3m1lDc/xwhOGFXiLXYa/nZ5Dz8me/AQ1xkBAgXarI2ZIph5k0Q/eZxX9bTBNlPpBGtLF8TtTx9+RxRB5DekuwTYup44yofqbN1kxA5TPcCof1nQAOZ//Of6A3Osxvkd17p5mftLY4Y08LkmXV0QG1HyVt4D3BnFPtET8U0tXkC2KShdcHJc9E02nFdV04cWBN9VKxQLTquNzVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0NVZ30vrrOpWLOHWdsZnk3EmA+lh8mtHimeASpcURQ=;
 b=KDrXD3IHR2guPMf7fYZL7PDbOeL5RAOS8BvT7kLrCnAm1/Oye/cCuBCi5sUmt9Kq9GfZr2l19Y7U4SCN1HTL4tHAX5G3YEDnyaIcaxW08tNGXaHe0yhwCYve/DA5wqy2IcQ8+mmbGWIOycDPiEPKg/EXGleumroH4ExfmwFVYUCBzdgcIsDj1HG0IaNIa67mW5vY/TuwzMGyUhBQs4nF6keZM1fR7pGeRev2BCM0boUsIrNc+BHYfglfh4H9x6oC0vmnFmQUyxgSb3DU1FTpcxiXsCexRMk5FhsNfBRUFxGrhT9eT3NLEv7SQK+1UilBAI2+ipM5PoWMkOnfX14qMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NVZ30vrrOpWLOHWdsZnk3EmA+lh8mtHimeASpcURQ=;
 b=qZULDZy3SFDBuaM+qu3qEtrjB1M6TrcqNJ7aKFMJx5WLhJQsgAnYy7UPcn7uVwTE52498N+nj14jFGFj5HHlGTwHzybEAfnl/qbwLP5tXUDkrKOzYqaApsRfvio9jKTtadnZ84cLwQ5wcyG4UNfY7cuRFF4sUGeTV+AJiNPXkrU=
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:43:01 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::50) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 09:43:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:43:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:58 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:55 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 11/15] iio: adc: xilinx-xadc: Refine Zynq read/write error handling on timeout/interrupt
Date: Mon, 5 Oct 2026 15:12:01 +0530
Message-ID: <20261005094205.1045874-12-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c31d113-c5ea-444e-6156-08df22c50b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZvqUCZ0x4Ai1Qw1tAFIeRxlXsgdwefX8V+yGJo7gunELm8cJT0t1zh3zqSnFVgDSH6qgc9yZZADX1uXNrCsc7uVYXffdSFq91YiDWdw+th0PhJHbUe1mR4mZ3KRQuo98g8dBr02LICZ94ct56/b6K3HMeJelvm3k8XQE4KaK0tNDvEDreoOgtCWRAKZORwlvzHFY575YmBH5AlIpjlWtxh0R2IzvEDuz7s66oa7a7nIfueBf/SiDifyhirYFwajZ8hF87y0ZGxC7rT6a0cwXG1CKm79Q6gOINHFPSWuxzfDnTlnsS3Foui40QLQ39i9+oOtzWIS6N9QEYCOO8tWMOO1pAPm1+o8GC8e/Oub5zR74btPcPIePtZ89Q9Ms7hoz9Ew1ywnPhJfMgquzEc4VmQD3RDZw4BOu8i6kYWEXCYmTQGav9HbdOYzQu+jy16qdSROes4k84FT0eFIBLyM3PGgro9RpTPBy7hRCpGHi3YZqUr/wAGpRfU9/MoY6elDeTeM5ZJshtH1qO3bC10F/adxjpLrOpuZRhhceQT1LCrDvZU/RjSt5w1gL84dI5oZVQ+9WCDmZDkc6QcPo9dmAYhws0CHmBgMq0r8y563D/CH7qhyWOQz0c4uyXzOm/7Hc/pBd8G5UnDRg4Za3f1Dwj0N36Wa0Y5B+LDMOT/VIAOzuq7Gu4OHlCwYOVnKaZUvtuvvbVigvoh3l7OscgeU0+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bz8DWO7lSOS+BzJ2jwxY2Izyd9rBUhdORlIagIQ55HF9XxTAzWIIhVaeSHRaWu6iynLM4La/CP/Fd46J4F/eLyNizHLbZb+cnLHF0rwNUTWBroiMAppZO/NGcAiPUxq+NzuFkQ2ie0bQ1NwT0QBUI1qUxT80h5I0rRRuZ+Hx+56b8q3E8yJMzJl1EqEHCl2ZfUQsimj2NPW+X/T1oOEHckDdD6xOHd9+jolmUgt7KaS+xf8SN6JrlAYIXjF5oH8Vj99+qw7Gyn+GP2CfekB9LVCZyPJBlpukyhgQvznn3qjPPcBqSKCa53QbR8D1witxRF5IG3+jtzLsPw71OWGleUxuVo8gauZykj8rId3e1MxiOpswpZwNwli+aLqAEPr8boJFmv248wGS/kgPVatPwpmbjo4jqs48RfYI4vcQYBysE5P7gQB2CrPzBmGd11D8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:43:00.4879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c31d113-c5ea-444e-6156-08df22c50b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632

Refine the error codes returned from the wait, the same way in both
xadc_zynq_write_adc_reg() and xadc_zynq_read_adc_reg(): a timeout
(ret == 0) now returns -ETIMEDOUT instead of the previous -EIO,
giving a more precise errno for this condition. An interrupted wait
(ret < 0) now propagates that error to the caller instead of being
silently treated as success.

xadc_zynq_write_adc_reg() waits on xadc->completion after issuing the
Zynq DRP write command, then drains the response word from
XADC_ZYNQ_REG_DFIFO. The DFIFO read already ran unconditionally after
the wait, regardless of outcome.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 47fa4d516611..92cd38cd1834 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -172,14 +172,16 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	}
 
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
-	if (ret == 0)
-		ret = -EIO;
-	else
-		ret = 0;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
 
-	return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
@@ -207,7 +209,8 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret == 0)
-		ret = -EIO;
+		return -ETIMEDOUT;
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

