Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577D3A63F7;
	Mon,  9 Mar 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066963; cv=fail; b=nXiL0HYf9ieDRFBlAem3BQBDre3H5BlHnnlo+/Z1F9YrPwoJg5icKVL4pnTPIFnqIlRQB3or220HJWjhdrl6aWslT/hqG574JpJoPLeu5Su2ZPE8pwpMMxNiZCkvhI1bcmG3SnAaDCXH1iPO3EfR4eymJ/RF6zVjNBM0FhBPiF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066963; c=relaxed/simple;
	bh=KvwfDoCjTDMS2FCV6I218pXzDRUlRpmDzeW+kE1EoWU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8Nts8K0OlKCN0aIutBQ4/XjIGHDnVCkTW0EmRmVJNbUyEYYIyJRJs2Wx1pSFL/t61aYZ5+ieUPSZ4SIdP6aBKH/nPva5GLNj/MAW4eU0T7z9AoJMObzIes/on8uSFBpNFqLgvU3PCSX5jTi2/Zy5UtCl4M+5GouImmGg0N6lf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=h00aH9F9; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="h00aH9F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFE6CzmPr9Elnf2l3vGA+j7Ehu3VF94Km79A9eNFH7TYmoy3TiGijj0G8pVpqfMfQhdwFJaxd8s6COds3vePhT+1sIMHoSK8mQ29u9v+tpOsfRfm2be697x3LP/3qbRQOigL29Dfn4psUtQuqnZC8FnDsLoLEukqyxdsiae0ucp/aPwa5GNUmvZtyTPpenB4r+WLazwX+hrUgsnpYdxPNhWiALiFW33+5V3kyHbwGT0M7ySBd8H3rqhJXjSUsK7FDDThSWYT8SwuVXJ4W2uqxPu4oeAmLUKAlh9cHNZN+QGQXoHKt51ebj+OU6S4bT4KTW1Q6a75Ld0ZEwueearRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLwoEeS++l7TvID8TrrnvMMPIUUgfkB7+qbEQ2Toxsk=;
 b=uZGlxBGvVBm5Y7dYN43nSi+NR/sAzl/0l2dqTZuohS5Qdy14HK/PRvaFHEuEfhWYChoNj7tvs9ddiuvpxkjbIuE9PT9Ld5qnzkdMLVFShnRRTpk9C7e6yOos+/7q3z5J0PPXa0E8xMMowbt3JqZy9PqCvYCEOmmyQl4LVzHZnucfg3wfBgDZuRvLzKPmGMoO84EEMT1cg3fbXTqXcaToDUUtDRvfIpDW79ZairpAIP/ecSqHITo5q7lz/Zk2pR2lFt4paa7hzLecepxwjjzaeWWHYI1tO2WN5VPK10Dyds8ozerblemRVYfmCXLdHuX99SPbfLlibPNLuRymFYB5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLwoEeS++l7TvID8TrrnvMMPIUUgfkB7+qbEQ2Toxsk=;
 b=h00aH9F9kij2zgO8Z7YDE53u4GwmPu1dCVEQOCm/SaiwzQ7MENDZzPs8GSaaJju3jdjIZlpegdEDQfyCy0wSHlkJ1uBok3wYAec2XoUgkWrurvRS7jkcNLxRq4pGTOKZLcLeLc0HCh/tB/7nJ4P4j4c12oA4qGJAeWWGUc26KAo=
Received: from DUZPR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::21) by PR3PR02MB6105.eurprd02.prod.outlook.com
 (2603:10a6:102:6b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:35:58 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::ea) by DUZPR01CA0128.outlook.office365.com
 (2603:10a6:10:4bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 9 Mar 2026 14:35:58 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 9 Mar
 2026 15:35:58 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
CC: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linusw@kernel.org>, <sakari.ailus@linux.intel.com>,
	<harshit.m.mogalapalli@oracle.com>, <antoniu.miclaus@analog.com>,
	<andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
In-Reply-To: <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
	(Rajveer Chaudhari's message of "Mon, 9 Mar 2026 19:53:49 +0530")
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
	<20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
User-Agent: a.out
Date: Mon, 9 Mar 2026 15:35:58 +0100
Message-ID: <pndeclt5aup.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PR3PR02MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4e4eb1-21be-4135-ac7a-08de7de92e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	4KC3l/ZjWmnNLp6YREia/Eu8/JvroI1ojADwxmVJFE9hVVh/hnPhlLuI2MClnVW5OJDqSV05You8mFsgXG6RhiBKRaTS2f7YwMIG598P2CQbQYErHfkucVGQDdwjqftmDzM4cUoZo0QPkI3hVOE+T/A9bMYrKLTGmJS7g5x8NckMtUqTDxvqIko1CKcujBU5l0F7hy6pjalQ9C9Zr23cwt9hsKcDYbtzxxEqrlU8TyzZdU/iEQzMkhZmxcRFtd19qYodrO9Ii55oo0EZgoX0qKxm+yYw4Hzidkx+5k4ME1fc7lVNabAMVWfi/UFC0SnukMZLPkaYert9/ZdoRkKHEqN5LpYUhcdVBk4f4UiHRpJy0pQAtaywSC/WmoT2AAwwwbN1QGG7afJl99ZvdjboeYHYbvrPkwr7mJRDuz4zQ6+rNjEF9HIJg5nFN5oecKruJvdykp+9eEmiI03eSrNWGC9fqg9QGBi+Sv0KHwmzUmnCn3Uvqi0E7jxxl+HZxVxL2GIyHKcTbgIpsu4jhVT7VMW6NMDNKYaA/IEbuvA1BhKbnTIuL75vjmg5Fcv80uqL4iLk7DIjnB5p2FC3AQ7qED5DGeoE17Z/Ypf3jMXzgybOt+QH2p/f6nwrEmLkegobxk5kVhKS/UdKbLyCc1/DEuVZa3NJM/LuGb9fcSITRO10HoHpXEZelJSovjTKKT2w3euuYAmcUu3MGT7INy+/8U/lfgvQaIQtfATQpRmlYzenkqFh7w6yO89NOlvT0o5TOuQSBJxo9WOgurGQ0f1TTA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QKiJTZD+41bqtfe1bUyPf86/UqGbKaFKMEvVRPtk7D6bMPyoezqXwfIqG4E7D3/XEys0bNsthSjtDenv263WMsinDj8FPGkN9jZytpkiWuuDiOz/jYNdK5YVXqwUzsWoBTbtw8XkKK2WSR6x79jE6dRQGsYneIx+Ta6QPaTyelQHgiRKIyc5EwnPzGpJFbgC9eqwiBxFMEvbF9gItWouez1eq07kHCwEL0gSpVsvitjuLP41e4kg0iA27m3crc2sbdc/JFaNHNOLq0iZiBARWURVPobrspRvbWfvHBVCDDafnjm3MXKN0ESiU0W12cnGYhKAgqqb+8JFkFkvY3pf5a/QycXD2KaC456iQ9AOMghhvRKpRulfZeQD2SsSwF12r3nDvuA/GdtfMkS2FABO1xcoLeL4snLsaBOOjytSRZgIn1foJbE4Mvydn9xOodQY
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:35:58.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4e4eb1-21be-4135-ac7a-08de7de92e1c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6105

On Mon, Mar 09, 2026 at 19:53 +0530 Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> bmc150_accel_buffer_predisable(). This ensures the mutex is
> released on all return paths and allows returning directly
> without a goto label.
>
> Aligned headers in alphabatical order.

Never mix unrelated changes. This should be separate patches. Why? Think
about traceability (bisect etc.).

This comment applies to all other patches in the series as well. I'll
just state it here and wait for V2 before taking a deeper look. 

To be honest, I'm not even sure if sorting the headers is a "valid"
patch. It's just cosmetics (and there seems to be no such code style
guidelines)...

[...]

