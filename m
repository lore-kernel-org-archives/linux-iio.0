Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287338;
	b=tNV/I0gk8vrpZGrLhAtwU4KNpWQSV4L0VEPQO/uouxnfRAi3EYOLwM39vfBBOiIbPltP
	 sPOfYPvgKD3rcutElcEORmpEoKvLdjv5uEID+KrYRNaRNMzTW7qQAQCxgh/H2PoIaoAk/
	 c29/qK14BLTlGGbQMo2s34mUAD0Hfv7+A3ygc/eudwL/HEjDTWmmgXJUT9hHfiAqnJvON
	 XGDVjVLvhrbM/p3UptkMueMBBBKeRFURV22zMKs2qvwoigBYQYvfB33JCHWQ6+paCz+C7
	 loApBMzJNU+FTSNeak48GjZzN1/uuEClmhHeis1LULUNmPZYeIbaJBOyCW7vf++PW0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287338;
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
	bh=1TF/rR/FdKC76jmX2gQsdX4Cpcu8b9XxBpB5UOTMrBY=;
	b=okpl5jZT+cCUMVHYvO8Siz2Vd3objh+PYwFnMifzFxQhriEiTWJL0Sdh2xPlA8cTSdj/
	 YKXRJNZbgxMWL4DHsk3i3DkTzQelWH+fu+USeoo6N+z87E0CsNePsH+qJWkcqk3n6E/9O
	 qGzaIxiWLAWn72OFRoXdiLx410RqzWG1sKWYdUHhOGYPY8Wba+IHp8WW9jVRUkzaNq9yC
	 RrgtmR06mdFoqh+Wzv9yUxkck167Lx71F/f9ag+Qr6lJ7wURoQDTvhBPNGNY1VXhpY+rG
	 QQzYJu3eEelQ7Vd2ABxe95rIDkyzbV9sBZ0Huj13JODrILbIO0rJTM7Avhg8G4Rlzeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P+xv4AGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.29
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331460A2608;
	Tue, 10 Nov 2026 05:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D331460A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P+xv4AGz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYtH8xH3wZJsTbzZ7n56JugOxffEgPIN5pSKKpPUNJEqy3DpeVupnF4RYjgJlCbmYbLfewzIzDAVaNDqmAqIr2Nn4L2fo5bNJCy/+DZryn1fxcD2ZkDKkL/zSRP7QFFJVraIOLFPpHFwe/qhmKLu+vY/cui/4DjjCVB0A8e0o5grjF2LGTXay4FXjuetLk2De9ALM2OnpCEXk3VUZnUafeZYwsQwQi8NGg5x4088I/0EakP3rELxMpTbPu0Qm01lnTvn78X+hhyTkXfbSbRyQ60jJZUjGeK78tOkoAGeyg620RGuAYMMKo2xlLAuey+moy4EN0UFptdhNxsrqPYirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TF/rR/FdKC76jmX2gQsdX4Cpcu8b9XxBpB5UOTMrBY=;
 b=ZNOWStEPsez/wOoc3gDmHUVGmX6I4upc4jaf8lfwWDEcMrw2xVv/mgQWGGptnYelv8iXjZo6YMghxIkHi52xGgArDrvOZCD5UvNnnal6mZyeC64bTcmj8rgnfm2b10cbBFCpptjQWmyHRIU8OF2sycctw6U1Ig183UOrZr4rAGdLC6IQ2XJL2NsHQq41R96giZCfNLJ9HhChNABYDXPME/XGRS2941hN8vxYjdPnvxyXl8rKGs3KmBeq5kzD8AXS8KE/qOLQxdD87tHcN3s55wZR/hVCvLE2x598XZYABrQmBTpo4L8JFCetEn2M2Z+VBas3nonyd5cblcn9GdhNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TF/rR/FdKC76jmX2gQsdX4Cpcu8b9XxBpB5UOTMrBY=;
 b=P+xv4AGzyF+/llnwnrzQPms7pPck+XfVzNGt3FIZ4BcWu2b4S0GuaGH1teAi/n7RX+frcGlv0p5OvtO64n+AZih21dfQodYgmWvRY20S4LN8oHPCc/+CPGn62uttYI1LB7V94QOzgDS3GZVy4TMeFe0h4sDPV0Kp+QakW4kQ/j4=
Received: from MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::27)
 by DS6PR12MB738673.namprd12.prod.outlook.com (2603:10b6:8:417::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 05:08:54 +0000
Received: from IA0PEPF00000038.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::6d) by MN0P221CA0009.outlook.office365.com
 (2603:10b6:208:52a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:08:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000038.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:48 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:45 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 05/16] iio: adc: xilinx-xadc: Use bitfield helpers and bit macros
Date: Tue, 10 Nov 2026 10:31:50 +0530
Message-ID: <20261110050201.1850399-6-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000038:EE_|DS6PR12MB738673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0e9f59-f249-433c-c931-08df3ee8b7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	YnJjaPP2Q42ZHl7mY830hOj3xsqxQj1u+1S2DLdEgSo8ItthEcWia6EYH9o64XYVWnYaxkB0XjoIZsA+fTw5AxYm5PK7TKoDXl39fRGZmw8NpSnicnWm/nA6NrF/AuuGW8ET29tAoKzSK+lRwg2n69WqRlpWKzz+eWOjNy5KHPrQEq4oFrgGaIhj6LUf8/8mU5JwrzHBFMU7+WDfuxF3MYTwt/CoUOfm4ns0791kWgGnb+N+ZGzWBQeTdOMU032XXWjn/jz4iRZkOyPzIX9/Dboe0pZuRGBFXngXvn4ACjhTkDZXKz9NFNagNDx+zEVo/OqY4JUUp3qn4dbnF+5PH/lmuQcDoFljfnMd4DJkKJ5frdIuNKtiU6X4H2ZJFg0ZYfBZJhPqGNXAJQYifs46GE4QX2U+hCg24fLzEcUxjxkDn0SnERZ5qjdyjlKihZSU93TJ94/T3AWh1VKVOJ00mi6/XIa3Hnv2O3KJR5mJGEgWgM3h3XI+F3X6jBug0NrVO7RwFb1Be+Zt3LdznFk6F08uX6hs9Qlgq0+xdNMEgdVIzY6aHHaQYkjD/FZcTtoPf71bZPraqEl8QMTTz40PqEnb1eg38X3VAh7OQ9s1psPYThix53qKQG2fWTnFlzXSWUW0tdlNesseJ7g9Xq+6jV6tvr7Ndlxpd3Ytp0wlzY/gpjyW6a0FsfRQD6JG2gRybI2IlG1x0yOAThe6rApwAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p+H0Nl1ocszRVN2H6PDN2A3ZBSW/kjy5wJyp7ZyAvoUXvll8OLXZ0G44R9ypfZG+x2XLQayjv70+YscG7dbsbQLLy/fqwsR26UkNYRkAe229Kr8ceINrjZs/No1QRLXVzVV0vku/RDDzRzCi0aMJwYk1dfNvr+8YODR2434MURy2yIFAUADdrdE8AIxst3CEMyx6Vcc4+QJhcCgOmxtJoIa+Tl8RNK3QTijpM9L0jOpb6oFjsZgRMy4oyirrB7wxPjE0SUu0eo/+jCv+FOY2EWffdudvtYmBjYRHkpgTJR1XkFfxQzDOOxSWaxVsavlAQQ+P+TVtoEzSR0UTIyxIn2DStYoYqpTxvKqSTJvXeBfjhgE2Ji6jEng5gI0M3bfTdGelPQ13PIlhKNb+idXHRMk0MgK0RaN+aN8/UrZt7/WRqtxckLw5nn+0QnPC2q6l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:54.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0e9f59-f249-433c-c931-08df3ee8b7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000038.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB738673

Replace open-coded bit manipulation with FIELD_GET(),
FIELD_PREP(), BIT(), and GENMASK() helpers.

Using the kernel bitfield helpers improves readability and
makes bit operations less error-prone.

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 50 ++++++++++++++++++------------
 drivers/iio/adc/xilinx-xadc.h      | 29 +++++++++--------
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 66c6f3319ca0..eb63675464bb 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,6 +11,8 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -47,28 +49,28 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_ZYNQ_REG_CTL		0x18
 
 #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
-#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
+#define XADC_ZYNQ_CFG_CFIFOTH_MASK	GENMASK(23, 20)
 #define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
-#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
+#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
 #define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
 #define XADC_ZYNQ_CFG_WEDGE		BIT(13)
 #define XADC_ZYNQ_CFG_REDGE		BIT(12)
-#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
-#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
+#define XADC_ZYNQ_CFG_TCKRATE_MASK	GENMASK(9, 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV2	0
+#define XADC_ZYNQ_CFG_TCKRATE_DIV4	1
+#define XADC_ZYNQ_CFG_TCKRATE_DIV8	2
+#define XADC_ZYNQ_CFG_TCKRATE_DIV16	3
+#define XADC_ZYNQ_CFG_IGAP_MASK		GENMASK(4, 0)
 #define XADC_ZYNQ_CFG_IGAP(x)		(x)
 
 #define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
 #define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
-#define XADC_ZYNQ_INT_ALARM_MASK	0xff
+#define XADC_ZYNQ_INT_ALARM_MASK	GENMASK(7, 0)
 #define XADC_ZYNQ_INT_ALARM_OFFSET	0
 
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
+#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	GENMASK(19, 16)
 #define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
+#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	GENMASK(15, 12)
 #define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
 #define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
 #define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
@@ -105,7 +107,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_AXI_GIER_ENABLE		BIT(31)
 
 #define XADC_AXI_INT_EOS		BIT(4)
-#define XADC_AXI_INT_ALARM_MASK		0x3c0f
+#define XADC_AXI_INT_ALARM_OT		BIT(0)
+#define XADC_AXI_INT_ALARM_TEMP_SUPPLY		GENMASK(3, 1)
+#define XADC_AXI_INT_ALARM_SUPPLY		GENMASK(13, 10)
+#define XADC_AXI_INT_ALARM_MASK		(XADC_AXI_INT_ALARM_SUPPLY | \
+					 XADC_AXI_INT_ALARM_TEMP_SUPPLY | \
+					 XADC_AXI_INT_ALARM_OT)
 
 #define XADC_FLAGS_BUFFERED BIT(0)
 #define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
@@ -215,7 +222,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
+	tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -373,7 +380,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | FIELD_PREP(XADC_ZYNQ_CFG_TCKRATE_MASK, tck_div) |
+		       XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -391,7 +399,7 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
 
-	switch (val & XADC_ZYNQ_CFG_TCKRATE_MASK) {
+	switch (FIELD_GET(XADC_ZYNQ_CFG_TCKRATE_MASK, val)) {
 	case XADC_ZYNQ_CFG_TCKRATE_DIV4:
 		div = 4;
 		break;
@@ -760,7 +768,8 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 		break;
 	}
 
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
+	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
+				   FIELD_PREP(XADC_CONF2_PD_MASK, val));
 }
 
 static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
@@ -807,7 +816,8 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
+				  FIELD_PREP(XADC_CONF1_SEQ_MASK, seq_mode));
 	if (ret)
 		return ret;
 
@@ -822,7 +832,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  XADC_CONF1_SEQ_DEFAULT);
+				  FIELD_PREP(XADC_CONF1_SEQ_MASK, XADC_CONF1_SEQ_DEFAULT));
 	if (ret)
 		goto err;
 
@@ -876,7 +886,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 	if (ret)
 		return ret;
 
-	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
+	div = FIELD_GET(XADC_CONF2_DIV_MASK, val16);
 	if (div < 2)
 		div = 2;
 
@@ -984,7 +994,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		div = 0xff;
 
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-				   div << XADC_CONF2_DIV_OFFSET);
+				   FIELD_PREP(XADC_CONF2_DIV_MASK, div));
 }
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index fb911ed87600..f5bf2d08eedc 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -9,6 +9,7 @@
 #ifndef __IIO_XILINX_XADC__
 #define __IIO_XILINX_XADC__
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -159,22 +160,24 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_CONF0_MUX			BIT(11)
 #define XADC_CONF0_CHAN(x)		(x)
 
-#define XADC_CONF1_SEQ_MASK		(0xf << 12)
-#define XADC_CONF1_SEQ_DEFAULT		(0 << 12)
-#define XADC_CONF1_SEQ_SINGLE_PASS	(1 << 12)
-#define XADC_CONF1_SEQ_CONTINUOUS	(2 << 12)
-#define XADC_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
-#define XADC_CONF1_SEQ_SIMULTANEOUS	(4 << 12)
-#define XADC_CONF1_SEQ_INDEPENDENT	(8 << 12)
-#define XADC_CONF1_ALARM_MASK		0x0f0f
+#define XADC_CONF1_SEQ_MASK		GENMASK(15, 12)
+#define XADC_CONF1_SEQ_DEFAULT		0
+#define XADC_CONF1_SEQ_SINGLE_PASS	1
+#define XADC_CONF1_SEQ_CONTINUOUS	2
+#define XADC_CONF1_SEQ_SINGLE_CHANNEL	3
+#define XADC_CONF1_SEQ_SIMULTANEOUS	4
+#define XADC_CONF1_SEQ_INDEPENDENT	8
+#define XADC_CONF1_ALARM_LOW_MASK	GENMASK(3, 0)
+#define XADC_CONF1_ALARM_HIGH_MASK	GENMASK(11, 8)
+#define XADC_CONF1_ALARM_MASK		(XADC_CONF1_ALARM_HIGH_MASK | XADC_CONF1_ALARM_LOW_MASK)
 
-#define XADC_CONF2_DIV_MASK	0xff00
+#define XADC_CONF2_DIV_MASK	GENMASK(15, 8)
 #define XADC_CONF2_DIV_OFFSET	8
 
-#define XADC_CONF2_PD_MASK	(0x3 << 4)
-#define XADC_CONF2_PD_NONE	(0x0 << 4)
-#define XADC_CONF2_PD_ADC_B	(0x2 << 4)
-#define XADC_CONF2_PD_BOTH	(0x3 << 4)
+#define XADC_CONF2_PD_MASK	GENMASK(5, 4)
+#define XADC_CONF2_PD_NONE	0
+#define XADC_CONF2_PD_ADC_B	2
+#define XADC_CONF2_PD_BOTH	3
 
 #define XADC_ALARM_TEMP_MASK		BIT(0)
 #define XADC_ALARM_VCCINT_MASK		BIT(1)
-- 
2.34.1

