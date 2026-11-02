Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622112;
	b=IcuOV4dtJsUfDPdDR3HI91qfvdnCtm0N8mpVlIqa0LJAjPc4n7zrTtH0zRkYquetq+on
	 D8MIj66FZwBb3TYvokekWmzsnecmc08hYRwczCN9qtYorGAv6rGeLHLQ55G/eR1kp2GZX
	 jqOvvSePZAPDXj0MdUXruqadihEbP76GTP+hSnUEg+Zlt/H/GtaI3NX9ON4IBxKXLNpBm
	 P1+okZhHzk4/KGzwM/nhnrvyBeEe8BdOt5r63ogrDDxs7YRtUx3MbPuzOisGp8EYExFOW
	 mYpYzqUgx2fooVbMPgq8ZLNmchFqRhE3RdBFd1ZrwG8kRg4JY4KzCE16DVJJqgvLU3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622112;
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
	bh=xVGwxQnPo8iNr+bJIVXidlAAJucJK72QQd8YYeApDKs=;
	b=Xc+fO6fWJGVWCFNyha1oy7o/W0ka/rtjoEcA3tBzo3cqG3/CRV+vZcdzabjv/ab6LfSv
	 bcT67D1V2aha+QQa3MsZPm21jCzruEe6HSBvJOa8bo/LUrE1eJq/eA8aCrTkxz1yuWkbC
	 mHLT7eWj9RJfS0/y2brITPfU/p2S7T3B7ll0laRE+KoO+mCUn0GFztD4ZTuXvusQMi/2Q
	 rPBnzcHHO2nQVmHPdeWInancT4252s6DiU7rEZ3kJvtKPnj0Ny4+zbb//sKzRpKQUtx04
	 1p9Oh9XPppL2ttwdmh6capazAC3tuBDr72P+rU/srRYxcvnzbJ5UK5hzcMeKz00Xz7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XM26OgWD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.62
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088960A6F6C;
	Mon,  2 Nov 2026 12:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F088960A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XM26OgWD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ama+vbEcyIT3ZWCzBktiF2Ub9bcMPL9jggFTrjuPP6/cstT/X5lplruYa+TYzz42yXzRArcQ6d+wiq360GdxQu9be2r0CX61GciEADFFRUapoXUeRRr4DhQBWdAphJ+R2qdu2Adbz7zMahATl6O51RjCV60R7Q9it9so0pGe+UzplMxDwd9gQeSTu80dx0Vi/sLjtDG0O8fynmC2dkInLVpAlZ1C7cdBO8sPD7SzNVn0wUg8yfrkFeUkV2IzsU2g3WP7H4Rj6TIXEVxs4HX+WofLfzzvdoTc6Aaoy1ae0dhMeNK7nIgyKT2L9C967cpuV8sRvDEYMK1b/mz+uBGwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVGwxQnPo8iNr+bJIVXidlAAJucJK72QQd8YYeApDKs=;
 b=gplnDUDnDzwnJQdFQ9TFtTmizXMom/dOAEHJthfTf8Bye+cWJbDhi3THHJ5XWmKggspRqXz/BELeBPhuZ2z/FmCxiQYU0j//dTVu6pZonRooDxHhej/xB6YBnEY/SSDqUWpE7ATYpAzzG0SfBZF9gC2AlDvL6MvH2F/kVsFs6vgbUImrutnIjlItLnw86MGHl/EYRVmue/8hPEJonNlTI0z/y0/e1PcRBIBWTNa1DIDKuNNToua2dUdPD1cQ60TnGJtkDrR4R7eywBDqotn0/fGN8WxZI5n27ONSZC7VxnPVlS7EOWoNV+nwCOEDNvGdQ1URkd4iNAFpmGX6MkWKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVGwxQnPo8iNr+bJIVXidlAAJucJK72QQd8YYeApDKs=;
 b=XM26OgWD9eMJsHfLZh2uvlKPPBOVVrfqVNLAh0qQs1JR0YOA0pl+BkCfPIQQe5wurW3eI7jqfmOoh7UOJZhMDOiH8gmCma9qs1Ydz/j3hCFVndxKIkg39i0I71nvO7S0o2v6MlzPzQB5TvyCDTV0sZNUjQAJIzKBVmusnEqQEgc=
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:47 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::9) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Mon, 2
 Nov 2026 12:21:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:45 -0600
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 06:21:41 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 6/6] MAINTAINERS: update Versal SysMon maintainers
Date: Mon, 2 Nov 2026 17:51:12 +0530
Message-ID: <20261102122112.1723130-7-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 885ce92f-da9e-42e1-5a57-08df38dbdd52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0TVBxJbsLN/zDDxExUCJsq7ZO/rXtNj/ZeAi7fOMR6hsg1QUdmCtUw3aM3aK0r1B6QHFMhnt8tg2EwIknrS/gx3lvr/hUXuDF7BURs3tAYu0Zo0+JHfdIk9atXY7ae0HUTpCZT9vNG2U2jFZRH7m/ItjnXRLe+BNFEnsmdOwrR764TuZokG6hz93hTlI5/Rno8j1lHM3hP9CmmF6n4Y+bkkKC4zLlYIO6DLTCZw2wLaHvTE5LfnOrG3JlevMt+HFCYiBukTcXegB6ZXeoNuYqh8e5pF9yVE2Go38IBztIrGpT+C7o+okshPlAp/8GLhzOPlMBjvzGdCzFWn80/GuWexfDA+dBa4L7WAipHSa+WJuaHD2RbZPmYH7buASqKODGRua+JgtV541x0TPPHWZGxhcwvXk4lg+g2Hn+U22kpamJnF03sOjPJj2VG6/nQakBusR+JWfmL8m7+/5/cGZG9e0RIDYOsdArDt+sByqQXVYr/WPE0Se+A11NIYC2rbU2GGZLIW9u77VW4e1rw6Z0tZB6ZJ5t/PESPiCo8ApIG1hmZHaQKSDM4Z0edhHDMzJOonBU95yZ5MeMoKO5OHowa78WwAfqKmxY2oO1E5CBSpg0ziy3+2iDyGRCK4eTWp4wJDsLOad6G6aGJFzFWpmEWaqiZwCB4W4DDc87l//F9wSjLaQj215sGNUDLPbPa/XbQOtU1rusXt6xE7ap+THqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gZnwTwbPWJksg63QRaSwxrSU3Zk1gLej264wmWfTb4Z4wbGzlSO2BBiuig8+7vfZfVksX5+kPHHbvDnq/36caZ3DJEt/hiRt0fXr71jUL2CtpkWs4970P6+T6dwxWLv0iUjThNOkheX4MQaWDxOl8Dc/cnr+neIBiocOqEmi+JxGEWg2/ilCYYgjoVcqxERoFbmw+t1BdUSdpq2AwDOEc93VmjOJKkYhm9HWP1L64kXm2SkhHSxomcbLh94bkld2SbQFql8+bCUyUm6OVgWyE8EfnRlmD9twg3oqwFXgofJKcJf57VHjzO4sTEttDdx6xXoKqJAmKRqZ+B6wUoP78R4QQ+CIY0aZ9mm20U+wmRXsUiSJgj7304DoXcJqFxvRIhlsKxq3cxDDuJTwbmAPhMlWFC183Ivxe7yzgiqcWnoGTvZDH5i3kIoGYwFlnQdp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:47.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885ce92f-da9e-42e1-5a57-08df38dbdd52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

Replace Salih Erim with myself as a maintainer of the Versal SysMon
driver.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc22d1149d1..e3aca3bee13a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30023,8 +30023,8 @@ F:	drivers/edac/versalnet_edac.c
 F:	include/linux/cdx/edac_cdx_pcol.h
 
 XILINX VERSAL SYSMON DRIVER
-M:	Salih Erim <salih.erim@amd.com>
 M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
-- 
2.34.1

