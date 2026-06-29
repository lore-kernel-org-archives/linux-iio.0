Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D33BB128;
	Mon, 29 Jun 2026 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733736; cv=fail; b=enKJiHIM+hOcZf6yct71zAl0d9HSJ5suDplivyLiLp65iUGxVwmowcM4y/4drF/qGP9rIIxRvyRNpRreZRN3QwPBgeGZZMH8Zho1s8DUfU7q5txXGtOs10MuyVH+irRAVvPsziZkiJWxPkXlsyGZZd/wfxmHvintKzaRE2w9TfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733736; c=relaxed/simple;
	bh=5TKOHctlZVNK02Rl5Qh28trc71oQcdOLKaxGVeoUaa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5580pDADtvIG1pWuuS3C7iuI7wRFP9ld1Ax+ZdSwQffVeeGqwl8tPava4lG+n18pMU9w6sYFwJ2nNut7wNAUxs94MMz/eSNTSi+piz1A8/5TZ9eUug4t5+d+Tfw/ImTihMzFeHcnHfOfWlxHV3ol4JUepLawZfQ1wT+fNI6iJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CaME9nhO; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CaME9nhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgFOXO4Ogk/xjqS5/kgjyNmZlVBx48u7qYN6msSZA2hzOmMDfgIhk5j5Z8tuWMKiU4ieNoz1SYRiLeha2wZhpPSoQ1hOd7XM0rHO/qVQD4aLIX8xuFOL1MsS1FaunThJsDHRVEzRMSBZAXX8MfgKW21CqUTMCp3K4dI1DzLmYWSOXZ919URXCbMIQZqCfn0ws8bouLJw2iTF+MqnPV2K9zn50lkT1CHUYGVpBzTrWoG2wMos3Kv6oHELniVc/ntR6h5S/ebLF0u/6cKXE2zuZhTbsliRcVFf/usoSitP8tY6qIuS0IiSOCW6zuy7c/sDoe50f3X3HWRnGKxsdJkrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYqn/5gK0R0Lt9VXTkmH0VhdiI0bVXl91k5XD2PjIhk=;
 b=gaX0ORkCo5G4ttQCCe1kuHlyu1mz+LKoovZbWQBMQTECMLoHWxSI7pxgxJgHSC5MezJ7xqdsBzD8nwh/F7kIVIZdrPzM6AU7nCq9EWRgVN1RheKozCCPyHKRp2/lFPBX4tenCDj9aA8VT66aOp9XxB7Wx0S3Sz4TEubVRPIs8kZhS9iXkHvsvNIxjo8molhF2HJ9kb7s/K2OKh3X6VVqaEB/MDac0ZyoaKZyS5TKrvUatM5Jhr72qEpEYYsxX7gTvvJfOJsBJuXD6U15hid6De+V7hshXgWWos5QwQ1W0tpPKouyuJbjwHDhrdwtMMGDmmwOoimTuWXzj0tNdF1VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYqn/5gK0R0Lt9VXTkmH0VhdiI0bVXl91k5XD2PjIhk=;
 b=CaME9nhOoWtF1NlFmnryXcRSn880gqDf21hCGyqB9Q9246cI+veDPeC62Bvcea9yH4GNsOMoLUVe3antR4T2zJ0doyhv/lWuMluJKU1Bo8QgPOO8/Xx2L+rTiCsjmxpxqa/z4vIq/M4etGfFGH1Kaz42pDrsWkR1MEblEHMkMoQ=
Received: from BL1PR13CA0281.namprd13.prod.outlook.com (2603:10b6:208:2bc::16)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:48:51 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::36) by BL1PR13CA0281.outlook.office365.com
 (2603:10b6:208:2bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 11:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 11:48:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 06:48:49 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 06:48:48 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, <michal.simek@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH] MAINTAINERS: Add Sai Krishna Potthuri to Xilinx AMS driver
Date: Mon, 29 Jun 2026 17:17:54 +0530
Message-ID: <20260629114754.203415-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: a439f19f-f4c9-4e02-03dd-08ded5d46340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	W15cMIH2kuDAQVMOlGyQJt6wQQBagwXcbDXRPGIuzHBDhsCIKaWbzuw5Wg7VixckyOzaFKdmENugsuXcvzlYGzzIJ3+KHx8yOSz/R5NKuF2o7FDe96WwhQSP6iXepLheJBIiroHSmzJysioUkJw7fjRgLHIXfbO+t+Y7e/4DLB36vH0l8f8Zyj576YhZGKpx0DeiBDookQHx6zyWZFjKRLEeFwLvKeMvNhgV4f/0repavsEvVf5t2UluVJ09K6PwppFqhH4vPsKYODkJolrwqBHeaHWWeIkumkyCrRLD6rVbmCnSiC5vdjOFeRpK6RyHxry6aAewIBi3E8P7C/nzwSYjbpaC9BVhIpRasqD07qDKiqtJz/dG7aHHtgAm4JlWBCH4HRI9cYvEAjNiQYSsb+5mtNyfHv/UKoEb6XE8N+Kb/f40IJ5fcCu+VKbcpAUHP7Duc9bbiRDISOjPIlqW4u9zI7N4yWg/j9M9VIolyqNfGi+jxTXeqWgFFJL6cycUF/fJoTsR5aKVcLAdnaGcNCdk+pCsblNTR8zqN60K1IHbNLdL47jX0VIXhKg/NuwAx30pE972nV/9HO1bD5I4zTyhVnMBaBTidZdPNwVJZBoVQno6oyzdBbsEweqNkbvka4aYWVRB8sanAqdAkiNtDoNCT2dIoZj8zNHypoXgiNQPLd8wAUHKncbyRh3WBxkIdREnvJ7khxfN1CXhcwgp4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5S1dqdUEFtDVS3txrgVHNUzo3eXbFtXu/Em87NKV2grXUht3e77KdRYAUECFEzuAu6xfvH8ipi67PIFlKeVqozpUUpys+SWw+H5/idimJJLSKyuJTvK9rhW3TrREi2hn0A+HHjabHqzuthWyXCnoDXH+7P8t2NhyRr/SX4DTbIEeX6KjphO+EVAkb2Q/7CqQ+D+TXvAagAFii6kXy5q7w9hbbntctOG92VTL7IwykC2tUUfha3XjiqVi6d9B495i4QNkHtyp2M6BMpRekiAslQP28C0NRq1KX8uRX6pJpujQjIDYc6kREyYQcImf9dzjsJJXiDsvq1S8YLH8Py4tYyhdKvJU/ZK8C7mp5+P31W4p2JcoY8n7baIRx6+pQIhGjonW1gRygZmEbcjzykwlPhVU89MCw3U7tepg4bCAfni3EaWt8ZP9vHJHJtQ2ChB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:48:50.7691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a439f19f-f4c9-4e02-03dd-08ded5d46340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

Add Sai Krishna Potthuri as a maintainer for the Xilinx AMS
driver for continued development and maintenance.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b4560681b51..924e004a8a5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29460,6 +29460,7 @@ F:	include/uapi/linux/fsmap.h
 XILINX AMS DRIVER
 M:	Salih Erim <salih.erim@amd.com>
 M:	Conall O'Griofa <conall.ogriofa@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
-- 
2.25.1

