Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287337;
	b=LPUSVf67yWEEPJO1sWoznoLtPH55SznDhNlrmE99XXtaimd9e9oimifl3N4kMmWX4ja+
	 CLgArAdjHZDzhAVnPCch+Lzz7m/wG9DA4IebWW8ww+3AdFuAOpZGdfudkPkQwlAPm8R6r
	 2lZL/x2cx6/DcLAf/jsQtM+I3ThjqcOmIMFiBzaWEajts9M7TsVVhcMoq/9OoKxKZlWSl
	 2B/hpA+nXrmj4bXdyjRSpPLSQkMlbRVvLc1JytYYiEXruSOiPqpksL8hqdG4VIQr1/SSs
	 7f+0HIxrkrjTMreXoa3Q5GW1wGE+Q2ZzRAwBEfIxR8vvuqcoAY7SLAQuqJRecjJ56bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287337;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=s6+81S1BaYsAxRgs8WUywsXSi47VNCVV18WCTJLe9Ro=;
	b=QPxhWXk8fjmjx1mFZ8DGRx7geAfmE9ZQcA1oyyIZUCXl/leAxq4Q1VRuF+94TgId8HUQ
	 8aGWdQuI9mHqCGtmyrJo7bzmvRcfhK5OyZ+2sq6Ls+QCKiOvTw0wazhVeNsX93E3LkP/p
	 E5/5j2B6FZaJWkz6PUmKpOtHNZ1HmcvupjqHGRibpMcOhuWkW9MgA9OLwVHPLTfYUv2Rd
	 wG9/gZAxcUIElmbQISDLrXd9EnVKy5ui22/IePqvpqyHTyjBFiJPdyaCd3PxmRlSFLsBo
	 p5MjBeAJm6EqE2Z+0qVjs3vg0KqWPR2UEmXkjBAas3r7JWwF+16bp0IrPh6hO4iY7pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UYosBiAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.64
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AE606A334;
	Tue, 10 Nov 2026 05:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550AE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UYosBiAr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cx9pscLtXAKpmodPTcdAfJTca4X5P9pi7ezlx2Q3D44us5kYLBXWagnV8ZSM2g4vlP3MYEn8ADvSwMQ+whv2B+ipQqL5/pT1UDRFOJPnNYLvYgxjdx40S6VVxYOq4XbO14BVCydWOz/fEJwNz6GuUdIlh4cvKql4c7VhDxT6aFaVLAiGde65LTFhIlE7Hqh/xSlcMEL5nn0ufJXGyCyLV3zvh0U4sx1v5AKoFr8JDGe2PtJ0Bb81uTg2zbRpjPYeFSnoGPb3NoxMEsizIMhdIwVuoc0DYr236G6NiGc5arAMMxjpKvGEZFPSWUsqRkMDDXzWVHmzQo6ORxxn8hfHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6+81S1BaYsAxRgs8WUywsXSi47VNCVV18WCTJLe9Ro=;
 b=efkP1Ph5WgNL+ddD7AGJt3Sp9c/hlN2ta8jX9BRuSL56Abn6RhLGEkuDUnnELXgh56G2yKFb58nROQ/N0/d4YZQ3JdNgudvPaY9e/oq9QlzehWgXZtizYUk5uSJSZE5smK/PtCSebAyRKdLnh7m0u9AtEkNWW8TfLlAlkTsz7x+jGjAeatClGMkyGGgu8noZykVtMaUnRLCvZDLsy7bgrY0FxPNmE2cskaFk8LECj6SMRM5obvmpH5r2Detu+JH4F13FbjrEknYfvkX/jzS7XI9VfeQZovTBnChLsxwvklWwi9cnPqPOOq5WzTbOKqxUIqUdfg0gCcriOaXgQwpK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6+81S1BaYsAxRgs8WUywsXSi47VNCVV18WCTJLe9Ro=;
 b=UYosBiArLlyQq/X4SQKhwk6hZcRx1ktdcX8pSrpjdMDrqzkba8SFCJu7CwCUNJ5hgCTrTldE3uPhUaeMcugxtzwvRodjWD2f5U8t01BQf0S/HGL8Vvs/rsNljc3GrIn1qCalYQk93rUELhL4uhh34hheI1s0WS8NBG+QD0Rt3kE=
Received: from MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::20)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:08:53 +0000
Received: from IA0PEPF00000038.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::55) by MN0P221CA0029.outlook.office365.com
 (2603:10b6:208:52a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000038.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:45 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:42 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 04/16] iio: adc: xilinx-xadc: Drop unnecessary masking and dead code
Date: Tue, 10 Nov 2026 10:31:49 +0530
Message-ID: <20261110050201.1850399-5-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000038:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f7df88-7d07-4ef3-12c4-08df3ee8b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|261028144727099003|11063799006|261021123027099003|56012099006|261021121427099003|261022075727099003|261009223027099003|261022105027099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JQxwIKaARU+/II4aixHfbWaTMEvGb1KIcck8y81jwXV013q67K0ELi+A4uLIsjwhEuQyno5tACT/xYMTjwAQaQT5MK6H1i16I3Kei28EtHaYeEB9D2Sp5JFMxAWagI9+52lO1tt/bxGw34aV7a/EUXkV/D0z+qepuSyadcOd5oab7ZTNXGQr0d8qyLm++blvJAvfacWRIjyDe/3+Pz7HPWidc2STxkJHuPFWJPsE1exV6IVM4AcX+EyVribPbSZ6Z3ZbVk0+xQakrm6OTsNhXQfteY/wE3Arl1BvgRNepCi31DPTXUHb4w3o5NQjhRq/3rFLU747VtHnkuu0c6SjP4y8sbld4WwStGajs3+2QgBzV3XmNiVq/nZohXx2XSsiQeSRLIg4elQtdX1q3o/glNh7hrSRL25ZKi1CzbniecF7nCiG/nb4AJA9LPLm5+T3vS+xsUT8tWnqfwAjSap80IxY6CV7j2DJVzIjwJutEBXOsYkKKfmFWWHUQ404RMYiR/S+qHcXQyrT2zONWJMTd0italeznXR3TyH4MixOZFvWmtaYVZFXCqEF7yC2EgxGIvPRvcn574f1RPw6aCn/HxymxvtbFWAkYqg/WHjgOBOwVLjsbfG9MxIFind8ekrJBNBH41UzIe4LIe/zBcxl1ACavk6gpeucKyjLrFZgogf/ByjxEeMnOr4tIUcDITvnbZRVeansdwdLMMrJLamWBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(261028144727099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gV7qRQgDW2JXXSABO9Hyko/5KG1xoZfo5eTpWQwVmonmD3Bnikb/GNzuPK8/dSNIEkoIEeJtCiR0LABY+GhyC+lMlHxMLWTCJDjrD9kKhKZrp8PbeLCKvLvwAvt8xzu8Y7CWmBY6w+BnbkamgvxbNcpWfgEGRAGsUjPVWJSF7PSpU3HfvGbagTCRX2sW0FezJP718PGkylUe6po1+lJFXlIpPBdj4vwbosAFK2wF/lczEt8Bsp5cBXb46hF+YT72w/lX9OE19LEAR2InDXmHRncBi9Y1XBt3525WwOOJcDWBvq7qsb30qd2oqCki56VDGat7nMyH7ugj20ZC4vXMUrtkzLG6i5eva5nggKr8eJyUAwTApQTm12aHKYMBVdtKU5ERr/Q2Rq1pK5yDGPd0CMlBX6yl71pExsksMguKgwd5UnRnutxqVwT0L5e3lTZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:48.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f7df88-7d07-4ef3-12c4-08df3ee8b409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000038.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

Remove a no-operation bitwise-OR with zero (dead code) and the redundant
16-bit masking when storing values into u16 destinations, where the
mask has no effect.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e9d5b7ebdccf..66c6f3319ca0 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -182,7 +182,6 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -230,7 +229,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 
-	*val = resp & 0xffff;
+	*val = resp;
 
 	return 0;
 }
@@ -452,7 +451,7 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	u32 val32;
 
 	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
-	*val = val32 & 0xffff;
+	*val = val32;
 
 	return 0;
 }
-- 
2.34.1

