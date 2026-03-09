Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F893EBF05;
	Mon,  9 Mar 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079047; cv=fail; b=Sg4rHSUlTwqWdA4aZYMmPBT/ocXOuavsFDaElTfwmLlLKyCvOwte11SeyqmJDuU5qeSUK2L67clxN+xQ8vSmrSCnGJsmPlGVJEMSl7e8Sgx+dzoTSBDrnBo+qbyfLMeoXqqajaqY3jUw62n8QHaJe1CXOoV+eis96SdA4dbDwZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079047; c=relaxed/simple;
	bh=+eeoTT1ztdSr9Y6e7iii4BumfCYMSNeM/pzEJ5lFfLg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5wy2LKMx060mXyFQMihPcck1BspXq8Lx/JrmHcfcRVDT9KAtp5DzZl/m6hpkQ/FxYUunpf9ID15lBNRK5GBZSPVw2MDWTTIwPu08VmlJbaWSE6grkwFzrK3gLnt2vSejvvzh/7dIYQEVPGWV7XVdu0fWNRyPCn+s2o6ckRjtos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=W3SbE7fr; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="W3SbE7fr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdyBbtCch0XiVVnIi//g9rqM0uh4eTXIAt8Avk4Ekl5x7EHzWf1pdz6Y23vowudP/7QOElYJC00NpzJwTSvRh9dx9Av9AINvTZf/9otCulQCumRES8HRqY8Vnwmbx7rD4+ZToCChSOMD6Dkf3RjR0wruz9Muc17sbmO6xXBtvrZqI6pTHynVNa/PR9vXH1RT5uOjfhYggkUb3n0zXtla/rX7tbORkip8WmpbhX0TYOGZVJqT5sqdwrbiUBNcBpwcbaiYNQpK7MuC2caEW3f0ltl3iUt5OYNSBuDWAC2yQPRT7X6XYG/K3SPQvJffJPXPIPxmJdsENHEFXox45HGqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eeoTT1ztdSr9Y6e7iii4BumfCYMSNeM/pzEJ5lFfLg=;
 b=YMcZEwF+DzVE42lnzHvB9RzG6Nri5CJ43R+2SwBQSWYBzuIN1oIXudWfa6lJp6WN2lKQwtCxc1GzCiwArPMqguvw2g7snGtF6UlWL+6ahMGRBWUlLQ3y587dVXbA9Kdjft8d8RUIBXiNDrRFL7riHDjrozueiJEKOY1I776NXJNXWJ3nP8BeXMkfJbUrrvRLiHJmgRx5k1JsH6GsW2FdHgNtia3KsP+eIYrtF7i9QMCDddaz6VjY9Li6+fSYsn2gfiXYT5Mi86bZnBhmJbsm9cLBiOTI64ubP/Ft1GCnJKlHIGGAFR2p/qubb0sREF+StoOJiX1cQJRGDXShpE3hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eeoTT1ztdSr9Y6e7iii4BumfCYMSNeM/pzEJ5lFfLg=;
 b=W3SbE7fr37QqctMPeC97rLFC6LKLswfpNYKmo+6PIZmAduSa6LlOOXZL1BhqCVWkRLbUT5Qk/jKqzUdpM9LPT/TLano8xqkAgBGjtFqfacmtRHCdFV56sUp+RWnsmxZIJ2ozh6IiNCuxb9SgWNT5AaOk1masxUELCnSXGlP7LoM=
Received: from AS4PR09CA0024.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::12)
 by MRWPR02MB12216.eurprd02.prod.outlook.com (2603:10a6:501:80::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 17:57:21 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::5d) by AS4PR09CA0024.outlook.office365.com
 (2603:10a6:20b:5d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 17:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 17:57:21 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 9 Mar
 2026 18:57:21 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linusw@kernel.org>, <sakari.ailus@linux.intel.com>,
	<harshit.m.mogalapalli@oracle.com>, <antoniu.miclaus@analog.com>,
	<andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: accel: convert to guard(mutex)
In-Reply-To: <CANS1Ubiz2Lcq6fkq2yK0vzcxXSBGOZYdLr3XWGkmcnZLK9RHDQ@mail.gmail.com>
	(Rajveer Chaudhari's message of "Mon, 9 Mar 2026 23:03:35 +0530")
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
	<aa71mdKAc74CNhdd@ashevche-desk.local>
	<CANS1Ubiz2Lcq6fkq2yK0vzcxXSBGOZYdLr3XWGkmcnZLK9RHDQ@mail.gmail.com>
User-Agent: a.out
Date: Mon, 9 Mar 2026 18:57:20 +0100
Message-ID: <pndwlzk51j3.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|MRWPR02MB12216:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fdd7b9-3839-49a6-94e4-08de7e054ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	jcGwPtb8zBX0WJgTWsZcQTID8Hzww0LVtbT2z8Zg4t4b6NtI8gH/nJ+xR9hkj3W8YWsDnchQrd0/rr6VqnKTkipCeNmrC71ukLGL1XCE6J/8oANKyxCZjI5aSQEf7PtwuGhhThwppDUgXOWi2XkfYFiYqUR7LndJ5Fensn8aFW4iht/M/OEzlWA4BnJoV7SWQ+h2LLS6MiEc+jyNfRC8P8InFera2+0xq3KqsEQHn06WQq8CUbCtJxQqQcOffTek2g8obiSsgzg0wnMUianSEzkmHX93FqyvOhU2Xc+VWqB3sggQ/ftzZWkY1JvYeFNVzM2Kce8Kmhu26z0cy77R25AtuleUdRPCCh0McHa2RdHEAaYIOAdEfqPMr6xBXKYIhk+wVHXFF0EJMrOb1oHn80haSPudCuJHhOd1Cj0LUDGIlgTBUVqF7u2jSvmakaGck+sCJ9iRKLyzuWWskT56rLNLASlRgcoDz/sULcX2RM4g6fOV7ErKcCaP6ZzbPKd4r0JpIUFHC/heC16ZSuvXE6Fymi0inZFB7zjQrxf+vvFwcayysWmxhzQQq6eXNl/YlEe60JWl2CbA1R9RWPDw2/qdZN2yzw2Iz0x+Bi11pV7gCgtd9UmRSL6WFkHcYVXRZA0bTilV5Na3pWcgp71aSL/D5NkwKlvnWDWnjkZ9RI2TkGLCnyMsvI+tG6QeYfjLwZo8DMmyuF/N59Pqmd2R7L+7A+QoRplwK170/v1eYoPGpomnAGJS32nXj8TCdS8sBsxUCo1uwv5j9Ynomejjcg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OmbvrzxhhxdDlJVcN5VzJ47Qe7YYIGoxDqz3OWMHImF9/gYJ2rPXk8dzD1bCnBfYPgUAlHX2U1zuFnIJt+9yFrLHnH3QtzigeklmPVnCdN3ts6oIbu7Vmu7ivnlabjfjmPlp52fF34WrTzMno1Vnv4vSzXgaDzypc4D37CAju/kRdzHfF50Q1qVPjEl7wZbMuXJvOyuxIjDKX++XFNBxif831ROMd6Jf0sZzfc7FlQCseCKMtllqQvpONvu14POwQszQdA5WFQ9j6zJR6CBGlQ+GCzwE1YVWNrC/bG8bi7aT6n72zL7akA915dCyw8eJ5fgryC8nPHPaplJFxY+2s6XyjkmDkZrgH7uqi2JnYdV4LUfv4Y3+uqVguW6faD7k1dMTzWRpfS1DGTmmxN0rszo11qTM22jaLxA6gRv9Rr0Wn5Hg2yhcBSah0WwlXyuy
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:57:21.4046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fdd7b9-3839-49a6-94e4-08de7e054ff2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR02MB12216

On Mon, Mar 09, 2026 at 23:03 +0530 Rajveer Chaudhari <rajveer.chaudhari.li=
nux@gmail.com> wrote:

> On Mon, Mar 9, 2026 at 10:00=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> Why? It's valid change when in the series.
>
> Hello Andy Thanks for the review, As Waqar Hameed previously
> instructed that alphabetically aligning
> headers is just a cosmetic change and to be kept in seperate patch. I
> thought it would be a good idea to keep
> only one logical change in the series.

A separate patch can still be in the same patch _series_. I would advise
you to not change anything until we have a consensus here (as already
mentioned in other thread).

[...]

