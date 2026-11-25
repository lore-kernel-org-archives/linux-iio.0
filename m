Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626698;
	b=pTGXsBoYUBogpY3FwRfXvhvxrQpWgBZRjNa3AW2SUZjAWiGiLJw/wY7Tndk/N+VsdJe8
	 O29/J1uar/5xWugCgWTeJjzgGx5aIcMbq2zq7aLtBOLuCYaMRXLanPDWwae4uDiZDNe0J
	 NF78kg+pOAf2h1QCiJDVNysR7+GzQeOKP6mUrMabCSQx1nmj7c8flc4oTExh3dbGLhLZJ
	 ju2f6ZZ/RbcNnZaoR8hv9uo0CpnqnuqMk1OgXWA1RZ1TLtud+60QaZOtl/imH6M/ohZQp
	 T3kGqjYyNbnKDIqzFA55A/t4u8ckB6j3PQ/hMXNHseq7xdVgztSNa3LZI5CgZQBAvAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626698;
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
	bh=V2MkK/GE5i9eYlxic8B7WZZB2XfJLV0duP13/sdYGBE=;
	b=gQVcrJsYfDBxRE4PmzlaH7rE5nGRttJyzUrB56pIb3789ztZykgobpOITfIUn6q3MbX4
	 kKSbDt4W3rPUfjKl3XoiV9kAxq6Zyp4rdu3TwbVgN//q9FFTyhkpv6p51cP55+pytjv3x
	 4qoncw+8Id3QlcE5EOe0ECXU0xP61sEjxzKZWzYS/ZifcDI8wHJfc6TOb8OHRtH+/w4cn
	 fx2qTKhFSWZAl/Djv+OP7lYX+6l2NRpBjg/cSWdW40G7DcznO8T63lDYXwe4iV9c6ayeC
	 /N1Ki+M1zPOMsn9YLdP05O+flviQU6nwSWwxATnTo2E+qcw448BDhe7iNakL0hekAZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WEAEcClN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADE606A334;
	Wed, 25 Nov 2026 17:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ADE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WEAEcClN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qqiayfzsij42HCMwQdyiNzTxPLxNsaX7k8wAx2UxkUDH2J+oQ5wsrsBjvwc13KIhBOyiDgO9Uf8opqBpRFfFAusXfAbFJ9y9L3zGYoo5VQ23FiioGmUfeP+qd50fHYO3vaqSzQxzpWWz3FFeBujJz1ftYE5mvo7hk2FymgRKUJM7T5gqq8AYvkzRzfWthammOAtO8Pz7KmShUoWkb7hyA0mwpMO4WVKjcVImAODGRysNG0jalEMVU5yw53zSmeD8FXSvC5u5vvJ/Z4JID2h4dEdjtHor1s0a8jqHG9NE9IczNWKmU8kVphSfQU7+Y6efjqOJdfKIYFYBq7jDZCeWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2MkK/GE5i9eYlxic8B7WZZB2XfJLV0duP13/sdYGBE=;
 b=P+9ANtABzUHH3pQ+2IDdndFqaFsIh2nij3PSkG2Ouh6IUVNgChO7p6GfO8/wT+DVPTIYQQNSWPj86BEmWqe2rVmB+tP/5gfSftmHX3YYY0Vv8dPAw9cKVUVqRIt3w17MFHh+kF90E9GuSvh/XiOVqeK7mN6vTTWJP6tHUPxN3MezplB1SMMZZRloQK5Y6ztrzx/zqfGGppY6X8CtycnP+AAmKIducMw2BmXEUpszCyUKCQaoMrft4wzPHPLb6lM7OPEp2MLrudlgtZ91iazAUwB/aIqMA/u/jy7fmLTVgfnYxGhmi57YupmWzvegRTb03RZeGltjF9QkOtAbryahuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2MkK/GE5i9eYlxic8B7WZZB2XfJLV0duP13/sdYGBE=;
 b=WEAEcClN2YhXTHU+LZkn+ryfsofGUdD8cnoOOCrEzoTFdRMHLlZ08PUyGK6yMciBnQEbdZUPxY/uI3ROy6LUTW1GfT5cJpPF2RYvXY4Jcp2AfMhqBdMfAxVVI88k9WuKNq0fFpaKyhfyE6bsjCEUUPvhDaMPhMZujk3sj6w759g=
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::22)
 by CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:11:22 +0000
Received: from BY1PEPF00026965.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::4c) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Wed, 25
 Nov 2026 17:11:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026965.mail.protection.outlook.com (10.167.244.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:16 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:13 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v6 05/16] iio: adc: xilinx-xadc: Drop unnecessary masking and dead code
Date: Wed, 25 Nov 2026 22:40:19 +0530
Message-ID: <20261125171045.1246381-6-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026965:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f9a923-bd60-4df1-7bca-08df4b17217a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|261009223027099003|22082099003|18002099003|261022075727099003|11063799006|10067099003|56012099006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	xVLF6+8fRtS4n4uFF1m3K/luA6Q/IyWMZv/85SkJ2gXWdYLzpNjv1uh2f3tFoX+I7jtk92lFBsChcf4A22E5IdjiGTCCSCD0dkgTORNpBRBjH3G30c4eu4wCmxGdo8uvJqPV6K87UquvKUq2Xt+R/MUVtPOZaZ6TrSbjNhI2GWj96bLZ6N9HFUd4H9xnNDsDf8m/paIT8GHgcsz8iW5zwLA3WWe6c7bek0J4ruEiOoR7Eyoaeg4nkkxQiGrKvZA+j3F78KE+IEFEzjW89lzQmrp363wcnLUmwpr+0ek4GPRvZn88+6jLYmaqoZ5JMH3YY/VXwcGnMAIcFXFjq27trXYta8pclMheF7xyEI6fvXm4kYsx3KXTce9fwszVRMXFuagdvINuQ0j3LfO4OGH8j25jPMQiPYsr6xj6pucZDLGc71t/x/4jidJkGrMSv+MrHoxbvlQvt15TjceiXCTHzzTIcDdOy3pUkxY1b+q70dY0Xl+EjtLS2ndC3RtBr2d3Z9Gj7pXYFwWXjqnZSpOBne87A6R8VxH4UMHtViRlgrXdZ3vQyPWT269s/E4TYRmhd8yzRrSJfEE7lMD0793LauKm1WwV3EgJJgLnQasqpiCD8FWTf4kGBZRv+AXu97C+DA8mGJ6pKQwyS1Ck3gNKp/KIDyJcnF3e8ktaNhQZLsOcEaqZyNWehPFO1KImbaT+IOpDe23ydgwoa+P4xc8bUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(261009223027099003)(22082099003)(18002099003)(261022075727099003)(11063799006)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NLxlMeVHNMmQ9C05nD2vG+P6QHyZM/uW3i6HSUkuKmhAPtZ/YqP+E8rhzAFi7B/lBKl9Tm//ELkVFO+TBVdP2iD60MRR2curoc6l6jReTKnNPEOfwWUo82B7v3DineKG3Ip5DK3+LQCDPGF0ja7SDirz+Z+3qlMr68SFggRhfdEh1CBWBZN3T69Q9PhjIHa76kQgmpU2K4vyt0x73WhYN7+II0WNBv7iuKzS46jGs+hDokxFzq4YLyfMzc/hK92K7kNXp1A+IlbchLtxQHwp/ufs4/qW7pTKcMCoYGAZfnsYuuNa272FhwjRTE6/OcWmOMA/yHQ7R3ga3MA5UdAwgub1/BSlYISkXy0o1YrfCuPoxoLzmQp4uklcT9oCMqucgG4koW4iVQiW7liDD3w2SthSDoVIeSA7MWQQ1MRt2+MCDL0w3YOMRvdvp0OTcgcL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:22.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f9a923-bd60-4df1-7bca-08df4b17217a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026965.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826

Remove a no-operation bitwise-OR with zero (dead code) and the redundant
16-bit masking when storing values into u16 destinations, where the
mask has no effect.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index f7623b8050bf..3f9bf75d9067 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -182,7 +182,6 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -233,7 +232,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 
-	*val = resp & 0xffff;
+	*val = resp;
 
 	return 0;
 }
@@ -455,7 +454,7 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	u32 val32;
 
 	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
-	*val = val32 & 0xffff;
+	*val = val32;
 
 	return 0;
 }
-- 
2.34.1

