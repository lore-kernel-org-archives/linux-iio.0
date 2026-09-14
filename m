Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECE47ECF1;
	Mon, 14 Sep 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396459; cv=fail; b=cdlQtd5cHUgIFLrPnsAdgURoofjNd/845QWhIB4s7IiBSPdbfn37LroVGuEpAkv5Gw4LEAMIwjFL3N+0Tjb7M5fAGX2wlUV1xlS2HTf6eVEzKm6XVepXJlI/UDGI8A+HQMzRLgV6qeOCjRNakS6ntIZVwucxbBjky38VWi1gl+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396459; c=relaxed/simple;
	bh=RbvWigCRd5Q1EoNJW44SBSLCpCbZA/poiJ6VEJey+tI=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=s4u8UAOYbM+ZS21aPpefj9TipvWgyq9SJE8ZOmC1QfknkRnswz1lgpAiZI0vv1gJEvvyqXGdbvP3HgwnheAYt4O/OTVJecSrrZgLv/mI/u8M4p1StDioLDwJZa3d/7k2Py5pI/YeFpd5sg2rzzK/HdO9uMSG2o4PHcoePVUlSBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EkXDU1Ir; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EkXDU1Ir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfpDX44f3++nZMDTy++YfM7O+lfxYcRv0pJKoaLAy/OKJZeZay1Il0aEF39qhz3RaWkbgGdtr3z69o8iZZ7IL0vLsWNF5ipcscWRk1rIPyDwgLPAD0uBK04Ny/CsvAmdRvtK4XgQ4ZFcMXeNiAbpZT0RlqUtDK1qOYvdMhv34fpMhVVSN/nXWd2eOYhenZ/LVPJXb4ESnxg7Ehgk337NDDjVdgrwrUkgY1596ktPeibJpFJvY8l8Su3Xm1yyjnGGIKASqIHnU/q9i5THoAMTie/7lpTZMjF9V5fVq8mahcJaMR8MNOvm9bMXPSsD4CMoRSXJKVRboHS8+DmYCMtjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDCMias+5vvGOZAjNMN8Fd5K7FkLHGdztTW8D5YjQn0=;
 b=WvEcBSjhUlVPwa+wu51FpuhJAhccc7MMxDdejY7a2U+vLRhjeZauA4scfl2kqiGDS8WbA912PasxZyF11eS+5s4NdCCWBUlH03Lcg7rD2u4hvEzqThIL3viQydBuxrL1Wqp7Qyo7/+vuGWzFjAI7Jy55xG43sEAASEMWkU1law4J7zARE9tFHJ/V2bPnmV6CZgqCdx0xiZYGSrC2ScZ9jBU7Nh+vdvAo7AFjzo5PwiSrSatHolzULGD/7FVYhVewuVYRWMR41tK+lO7CHv7kZwlmp720rurJB+wrcq/ZKbIc5LtyjrZ6NDca6Cj75zXQxDLhvaiaS0GiGbMmtDm/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDCMias+5vvGOZAjNMN8Fd5K7FkLHGdztTW8D5YjQn0=;
 b=EkXDU1Irh0BrEK0xYwiQiZTsJKaQs3kk9BB6fgkicOp9LPiMd2dDqBxwL0EiC1tNDwbQ/uxu0mMYW9+dF/68A3Bit0vzNbb49Hf7aEHEacf6Gc3IqDlbfW/QcbziHhH3BOewLuQzMMwQJvQr3mR75nxo0RhFSggSkHQ3q/h3pdk=
Received: from ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::19)
 by AS2PR02MB9415.eurprd02.prod.outlook.com (2603:10a6:20b:59d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:34:13 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:910:53:cafe::10) by ZR2P278CA0046.outlook.office365.com
 (2603:10a6:910:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 14:34:10 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 14 Sep
 2026 16:34:09 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 14 Sep
 2026 16:34:09 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 14 Sep 2026 16:34:09 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 83274293E;
	Mon, 14 Sep 2026 16:34:09 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 658FB305CB16; Mon, 14 Sep 2026 16:34:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
From: Kanak Shilledar <kanak.shilledar@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
	<macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linmao Li <lilinmao@kylinos.cn>,
	<kernel@axis.com>
In-Reply-To: <20260824035531.141429-1-lilinmao@kylinos.cn>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
Date: Mon, 14 Sep 2026 16:34:06 +0200
Message-ID: <178939644602.1670536.5651900027161221634.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=RbvWigCRd5Q1EoNJW44SBSLCpCbZA/poiJ6VEJey+tI=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYshawfrw4bdry7asvlzBVdS9+ZL0+mPPvAQipMqr7v/2W
 jg3dYqnUkcpC4MYF4OsmCLLOaPt0fuT/+nOkXa6BDOHlQlkCAMXpwBMJPM1I8P8iArmi7brPTWW
 bzkUydKh2Kv295iZLmea3ONphat1921mZDi40MDkXM0OV0Ph4zFebnd/c9vb1Nk7V0f9Mr5ycr7
 MdBYA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008491:EE_|AS2PR02MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b97aee-0875-4fc2-1b4a-08df126d3dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|36860700016|376014|23010399003|1800799024|82310400026|3613699012|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ftsSmXxcU6WWnImdmxmCU2JPZ1mNK4mlIUhO2UA440+gR/DljvgSLcLWUbV4MeHbEwNeYISxnu5r4qq27pqvt/1/5D7eTz3YEA9o+FvFDfD+yd69e4pfTK69lHY/2+gH38aZgPiJT/RbH8LGVsXqsXXVw4NMKfwwxwgaqRyFelwNqiL8bIlOrF2heO2xcbKP8WKVrc5r2oZQjHBLjoXYhmR1rO5SMFYJ8GwSSQN3zIA9L3xqx2X51PW0bWsdBLbMp1IZVF80q6o1g/fEH3+7fNpbHx2H6XunkbCh8h5lZazkb+Xa6VKT8IpQJzwkmqLaPJyJOVY3pxK64OJB7nLfcyCLIsQVa2AJqRIwTSluuvGCauDvAKHM9buoRdkHHZbv7phzff4cOfqELIKhY0UizCx6MR2wBFuEbfr4oGG2ypCL0Y7udfO16IGcfdjx6BYNDTdl+9RPv8PWK6HuXVJwYI3z8xrRBObXtnMBQ1H4QmSXx6tU7WzViZJB6bJUaO4Ra55SNitZY64bNKu2x2sClIISsZKQqNgV42vPNkZe6Vc+ehSaHIR9/v27yPliv6B/zRE0TcHup4y6mqVLJCwB5D8A5uijdapWthT4+g/oPPCTZYX6kqW1H2fdb8OgfWmXtAIknDd6TCeKpJcGEO18DGzUAP1DceKc7luhlGfYoaMsSpvv+4fJ0+4o3S0MBUGDvvRGjHq2d36H7psLjmFfv4dRmC/WS8nm42UC5tRyRMr0cHpzqMhnm4d3S0KKeblc
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(3613699012)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ucqTNPju+GyqYWfub6G5s787QigEY3rIDNIzOqrprxjHcEigO7m+QM3QIzvSv3Br15rTvYWFImPI2PFGJWJTspAMLwNKbPMQViRp48N4Sfk4jvoxmTXerhvi0ROIR0OYtU6zbxl6w5kDk1n7RHGqGgFXOUcckxIsaBSA5Tac5PcI9X0kxwQ9O/m3Oj7kEhl0Gih82qVZpFXbQZvfUEA/C7R7qMoo+y5QCz36kvj8oJJu7TNhew7AWmqxp7LTewzKo8AoBzoov+951Bktgovnk2JhV3AcwR0wZaliH1ABOPdugCeJkJ8gUuVNFRiCkyLL1ZH2updUOb5PNfskPznPamVH7KZCdKe7QWg79MSWC6c3SOcE3h/ve9IJNjcCCbvy6Stonby/a9++wahjt9M0nLK3w3CXYeMhMIzgc2qeoHWysxqjkFzTH+eRWvFL0PjK
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:34:10.7626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b97aee-0875-4fc2-1b4a-08df126d3dd8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9415

> The recently queued ICM-42607 PM support has two error paths that can leave
> the PM core's state inconsistent with the device.
> 
> Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
> ensures that system resume restores runtime PM management on both of its
> error paths, so that a failed resume does not leave runtime PM disabled for
> good.
> 
> Changes since v3:
> - Patch 1: commit message expanded with the practical effect of the current
>   behaviour, the cost of propagating the error, and a description of the
>   recovery path that does not assume a particular regmap bus
>   implementation.  No code change.
> - Patch 2: unchanged.
> 
> Neither patch was reproduced on hardware; both were found by code
> inspection.  They were compile-tested with W=1 and checked with smatch.
> 
> Whether patch 1 is worth making is still a fair question - it trades a
> possible idle power leak that may be cleared by a later successful access
> for a runtime PM error state that needs an explicit reset.  The commit
> message spells that out; happy to drop it if you would rather not take
> that trade.
> 
> Linmao Li (2):
>   iio: imu: inv_icm42607: propagate runtime suspend errors
>   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> 
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
> --
> 2.25.1

Tested on Invensense, ICM-42370-P development board. Performed testing
with basic r/w to the device and checking the PM runtime status. It
worked as expeted.

Tested-by: Kanak Shilledar <kanak.shilledar@axis.com>

-- 
Kanak Shilledar <kanak.shilledar@axis.com>
