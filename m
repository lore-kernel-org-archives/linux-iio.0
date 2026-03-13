Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DF1F192E;
	Fri, 13 Mar 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397693; cv=fail; b=rJSzzX2XjnoJhhkMmXQntFT7wU02WBSL895xQVTPGTdUuweBi6p21JWsvmziOmMkKJirFD97tPkFaywVI7UyUFteMKygSrJwGXG0Kt4G2+9h5LxDEJbYjtkLTjPjxqTCgIIr90hR35uo+7ZJU1DMuNA11qwYivV/aVo7cDZaDUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397693; c=relaxed/simple;
	bh=/DonoH4SMFo+h7Ia9xWmkcuRDqhSsnnIYalF24icJ2c=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ps+YqgOs6gqrFJndAx5YgfjbOqCv0YftneHpQ/lkd4xbShGi7smDl41+IKa4G2MMtbOF6BsZRasJmOS+9bIgUq36KQLu8DEJadvJxgRHcxVVetTAmSSr/bz0DSYzlj+/z61G83v6pBB+b4CVgfBf0hfVb0KZMCv7+VEofNLX9io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IdcIKDC8; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IdcIKDC8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKZ9CT5SRUuBvjaOxbUPzvbiC/cq+zg9oayv7/IZwE7pHR/AcNhtqxakRLDsI2MIBhLNhov0HpO2JsQLmX+xY3aYsO7w90b2yeG1f5c5CbOYcnlPGRqJaDlWYbNvQNXmUa/0rTPjoPmXuSFuBWlkBMDtwSPE6ewfsLG6Sgql1tYKULNiRiC/UPyOAAzq7ngFxSZy0Ru86ASx2uwv1DFtlpqJtnDR5SpsfDMLKtBuutv45h6dj+hn7F8906VLQAORH04O+LPJ6c0uY2fpUWnYPyBxPFRmBc0Pd9Yoonaeo75SNBqAJdJ03GXPMZVuyI2WsAULJ/2W/MKenZVNHZ/Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DonoH4SMFo+h7Ia9xWmkcuRDqhSsnnIYalF24icJ2c=;
 b=GqVbtx5OXWCI/QOg6D7cgMHLkKgj2qR5GRf46JYkNJ/9L+/C0jTaLO5I3fcla8eWKDxyoj1Mo5+JxlUClz5OyLLTtetUSH+kVXbb8pxwx99cWrIjHQT8z+eE3X3+UoQRxI68Yy4uViwgTVfJxPnF4nAY3ZpTdPeO3qZ96Op5CNGcdbB/aC09FDP2XEapBUCFcz8aglYMPiu6k7NpZKK55R6WikaDr3xpKWj/bSvKAcCYHoeLTEizOmzQiBWvtfjR/Z97fu0gwI4sHfzx7PcuPtiqGFiUl0S4zx/6vzhmMt4Xsv4YS9UM+aa9e0rZvcSspwqNf83oz97RLIwm9iDymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DonoH4SMFo+h7Ia9xWmkcuRDqhSsnnIYalF24icJ2c=;
 b=IdcIKDC8IG7fQ7Ynaka8iHSFDVTLRukNn7bCe8+9xL31WlNeFN+xzTLHGVv9qxlB7ODBEwDIAhMBp1o1MR/E+VNlkbmKSw459e7GRFWZhllJta1wvKIIFbnF5pvOPTc5Yk+m32QrEpipaMqSI3kHFcytciity8k4GUUPdygpF3M=
Received: from DU2PR04CA0315.eurprd04.prod.outlook.com (2603:10a6:10:2b5::20)
 by PA6PR02MB10647.eurprd02.prod.outlook.com (2603:10a6:102:3d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 10:28:07 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::41) by DU2PR04CA0315.outlook.office365.com
 (2603:10a6:10:2b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 10:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:28:07 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Mar
 2026 11:28:06 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linusw@kernel.org>, <sakari.ailus@linux.intel.com>,
	<harshit.m.mogalapalli@oracle.com>, <antoniu.miclaus@analog.com>,
	<andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
In-Reply-To: <CANS1UbhMH_z=e5KrmxQv+D9=_7YQL=g=qdxv9e86iRjZ7LF=uA@mail.gmail.com>
	(Rajveer Chaudhari's message of "Thu, 12 Mar 2026 23:01:16 +0530")
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
	<20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
	<abLLap9bN3tTXfD6@ashevche-desk.local>
	<CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
	<pndikb1kn9n.a.out@axis.com>
	<CANS1UbhMH_z=e5KrmxQv+D9=_7YQL=g=qdxv9e86iRjZ7LF=uA@mail.gmail.com>
User-Agent: a.out
Date: Fri, 13 Mar 2026 11:28:02 +0100
Message-ID: <pndh5qk2fd9.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|PA6PR02MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: 987ff366-af03-462c-62a1-08de80eb37b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MpQEDFo3BQRtg/hUyZH4T+uDLkj1I2NZO+4tLNbRcPW2XVyJXIwbkiLeHVVyZJzhndhIXpO1kbPgMjRVeBk+JBrq3gsmCmC4soXC7I99Sw953x9B8Nr3QKApKrtWHtSD6LX5iBnoc1m3Qa7O+KGB6ScaBmIUPpOkZ3CFdP4uDw/XJanK43OmPBSD0wDU5BUzY5Z0viNVDYfA4xi5Ko0iL+61Tqg1gzwFfTwZJ7db8KUmkgdgAlM6WQa5Bo6Tp16y57sZv9hmGfxVyk4RWB0+88NMovfWWxDMC3vvBPT2BfxLc6n1vmcWfy3kMI3auPoSt6v3BfV3GNulb8kTGQ5tJKDwmkuv5IJvzOlvSNCuFK4qhAqpOvolPD7dF/AKM1iQpfGaxhDeBRFVDR8q20GFIxEklSndF5unWu5DLFhfZscJwa3FBJL1EsRKuk5iY2nsPBXp2HtJOo/aNJEEOetrVeTO725h/ZHEjUp9kKrXsx6ZB60G8lqGU2EQT1WdurQGNxEOli1xImR+vKcLwCekBhGZEirVakMMkOs/aR+PXHPoqDde+QicL3Xw7gccS4+LnOhg6THFJTamzw5JJaV04qeTkTDew90cjJpEycCHttgqWeGAlU5FxHVZKwxYr/kJeAx3ujJW0QfXy2P6uLPs/sMkeY6H8UzH+w3lK6cI0MNzQxN4152auBtr16SVl1OIqxIYNFINon5ncJje/4fKL4UdJCW8J6x5x5R5Fq6JkbfZ41H6SeZitemnh3mh/WSD1dTkxHeTG3jlz4KBejQmUg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JoFLi5HqPxAyB5rIoCzYX3TkJwOIS8DbT1PhAX2kunMHKXDrqhUHDmg54A0AgKk+nWwvXN5eNANqI3fqv8bcnoBVP4iPl2xoL5QrBiuL8OMSPBZhdP36QEWFpmamNeEKEZLIoqZmBhX961r+77R+QBQf28XE6hXO/R4faskPlPbZlTbUGx193nzugtJSBlljOdE06/IhJe2szMymKKT/6rU9Bt5iW15ZMG93dbQ2AIFWRFlx1CFPNV8M9/aS3jQv+aOqYFUtOwPUrGPTX3QC+KvXdymjTSATVsOAUZbndS0Z/3jDeiNd64JRWyCGkop2J6sQXP3X4a5w2wvAda/flx7dK3JFpH+8hiT5vjAjqK1emse2LwCpMizz7hdS1ER/rl+LOBokYlLht5dC0ZC38+a8q8WrmV+JTYq/WhZZeWtnLYBHhJNwdU/iF8cgE8Rf
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:28:07.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ff366-af03-462c-62a1-08de80eb37b3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10647

On Thu, Mar 12, 2026 at 23:01 +0530 Rajveer Chaudhari <rajveer.chaudhari.li=
nux@gmail.com> wrote:

> On Thu, Mar 12, 2026 at 10:17=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.=
com> wrote:
>>
>> I think "consensus" was met with Jonathan's mail [1]. You must've read
>> it since you replied to it, or?
>
> Yes i have read that reply, i am sorry i misunderstood your statement i t=
hought
> it would be an update in styling rules or something then i will have to a=
ct.
> Now i get it.

[...]

No worries! As I said before, it's not always easy navigating the
different sub-systems in kernel development. A future tip is to see how
most other drivers are written, they usually tend to follow the guide
lines. If not, one can fix them on the go, just like here :)
