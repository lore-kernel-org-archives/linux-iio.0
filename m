Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE43FB062;
	Thu, 12 Mar 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334080; cv=fail; b=exhMAeBvOOoibsD3JIq8dYn6yAs0S69VtP7+6w6mriLfx+sLYPPDLkH0y9r/+fFGql8mILnZDfgfLSuYlxZVpb3AHdm3p889GoSZAnCJQ7TYttnwtSKsiWWOMOIL4q3482LSa4w6GEHghIOenhL8MhGQWmkCci32jApImS6nuYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334080; c=relaxed/simple;
	bh=MdgE7Q2GLzFDyXtLqzmOC3v/QPa3nN82lc9ZUycnOjY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuJ6AWUhKNQ3MM/MfxUNnGrKOhEpVVVGNX5D40dB6NB5vkow+sBb47fGA1A8iznJSFU/WX8DQxW8HGhNXe3EC5h7Ud87v9BTyaUphShi+YIFyW3lIN5v3Jr7Jlo6IpCpW2vNNLYa6tyteC2TXj9Gp0J/gjJdrVwVGweNNnrqFLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Sdx3q0S8; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Sdx3q0S8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKS4kzY+tX3G6u/z/kN8di0Kvms1t+6KttJVJrRe0QgUZbWC/nri1Joa1IfKC57GD8YYm0BTPoEwZZCoeUhknctV76xHY3tMjWWgqcnbuL+eyVRJWkGG/AHpqLaQr2MpLzryJ51v67Tt0aW+/7G3WXfC74TCuiLO1YYjrrL9YQBW/SUUsSZAYqC+CzFceyCcd67U65h35lRaI6uOZPe1+C/QCfQvDXKrYAI6cA0IWEabbntNXULKFGbRQNANumi1GTctyw2bqukXeuwZAxskD2RvE7IgwMwlHpNG4MSiF/8A+Gp678+TwTNJlHJ9/f8tORrHSPuI2KjxGUO0Xt060g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdgE7Q2GLzFDyXtLqzmOC3v/QPa3nN82lc9ZUycnOjY=;
 b=PCHWlqWIW+EGeAjOZ+NZe+IvGoZBgJVecQ4KdxbbB5QDOQ41/XND6Y/fuFoCbklHoctX4pdSP2Bln/t5Wnrt6+D6OM+GbQsx+Niwq355JViaoC/CDfOMNuDUeCuzOTCDsIeHJvCpcsuyNP4cnJGR0gB6n1ZKjHTPWC8iXa36/GW3HZVnPp5aQhIgsB9Z9ihHKuBIsKPnHrQa3IBEVO+SszOgLFjZtsK7+iSukw8pIae1waLce4ftVUVbgmzu2PehHMZDhXTOfteixT8g0o1//umXcJoUBKOZnM+809Jjjf8Xr9L08JMYxHk5bNV0iLd9K9eMFK/J5x0jFd62yZclfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdgE7Q2GLzFDyXtLqzmOC3v/QPa3nN82lc9ZUycnOjY=;
 b=Sdx3q0S8uME1H2fIKKuV0j1hsMV9HNxE89AHH62cXv06/hygm9tNu5oMifNllZUMN1XtrIBAJ5kjAm82o3dEMUq8HRvzD52xhmzVt6PqQFqzVu3wa9+yZ1w+86uK0SU3+gy+FO7hJrWRtyy8cL8d+7CPEyw5x898iSME65v+qxA=
Received: from AM0P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::20)
 by AS8PR02MB8735.eurprd02.prod.outlook.com (2603:10a6:20b:561::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:47:49 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::f1) by AM0P190CA0010.outlook.office365.com
 (2603:10a6:208:190::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 16:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 16:47:48 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Mar
 2026 17:47:48 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<linusw@kernel.org>, <sakari.ailus@linux.intel.com>,
	<harshit.m.mogalapalli@oracle.com>, <antoniu.miclaus@analog.com>,
	<andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
In-Reply-To: <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
	(Rajveer Chaudhari's message of "Thu, 12 Mar 2026 21:57:33 +0530")
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
	<20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
	<abLLap9bN3tTXfD6@ashevche-desk.local>
	<CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
User-Agent: a.out
Date: Thu, 12 Mar 2026 17:47:48 +0100
Message-ID: <pndikb1kn9n.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|AS8PR02MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 400e2d0f-3ce4-40ab-8fd3-08de80571827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ENeBdu4ysv5ihNIDcZ3LlupNSsBmUEqL+Vm+p2DWxo7VmA1EpXi1CdcdD8GCLatGAJSOwHGxUJhr1BvxInGG23IQlY5a2nH9XwM237aRZTeS7QQ0tLRcelOgzyNWOw9OepONyrcnR4MszuSBCvpPZONFCkVRPhHXQVFW8wF7dPN24rc98I8ZRd/PxE5PkVFk76wt9IWA95nmSFN60DmfBLcBVQ7gG5LqsQB9SNwkij/0k0c7XvDD4Qk/e37P6eYCyI8PZ6IFrCilHMvlMUgJWnrTixfGjTLNrBJ8BiEKs5SgGMSkgZQtvRS7HVM/moOIJUiZ8cL9miq5LCybcjiov3DlVaymNh4kD8MOEt/NmyZzRxNqdBM5YfDKZyOWmzPILmx5cE2hMHfCfrJNOsipMWW4cG6W8Tjdhcq4mddotyQnfDBNZx86Sxsa0D33MiycINTCoUshS83K6FLLcrJsn29UdF9HMlDu+MI4971o6Ksx0ckB/p7z52vDIS5A/B/dN4CbXJmRZVl214gVw16DO96eZLh1UE/Nwe7IxdUTtoHTvznmVCvQ4ZHnmRIjecDNKdPpaZZidBX6nohr2A+CmWdn0lnNarvk3hkB8DkIVzBUweTp0ti2L7ZlWbtY69vmSti8ZRbn3t3i+OaYo6A5Pq961851lKhqRe4QPNea1FhAJm8JN4nr76QGMUTiJ3eOYdm717OsZ13W4aj1vaixWJQXS/PPxWbUuu014rbCd7sBTdIhte/GPoaA9pR6B8N3Uv73e7wB1oljB9e5ptXDQA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s2/eD2HuDLMY7XXTcumb4HKH9QR+zZMggg/Qxjir/VWWVNmw+CFFjlzfBoEmOSZ8FW0w7il7bD44Cc35tM/YaNeSGhWpkZ2Oa32RfJQA7QND753RLX8Z6sdGxyvzNkkpeHmSrT/n5fxOtnys48Zuad22DL8NcaWwTqNjdsxat8T6/xzm29N0XO9MT+OG/5lMClQPKjk7Wc/iqFydHfUuw/EH4xuWdaPQa1ThzODEQ0NwXlnDhTmx5OhtnvIjjVyntz4MPMpuvt8KQ8crBd4THd5nv6kLMJ3fsHFXkEXzxnIZMTLmXzsUS0sml6Nwrt+RKlccYRhjQuXc4ns/rnJdxbp3ADysgjma/xSzWhcrPlPeWOyG8WN2DAF2vQ9gYJVoq6rxNzzAWNFoCqBlEmg5LCetS3YO6/QdF3r2JoGJKL59JQ5KPtbxhiU0/+Wbm5PD
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:47:48.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e2d0f-3ce4-40ab-8fd3-08de80571827
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8735

On Thu, Mar 12, 2026 at 21:57 +0530 Rajveer Chaudhari <rajveer.chaudhari.li=
nux@gmail.com> wrote:

> On Thu, Mar 12, 2026 at 7:49=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> I don't understand why you can't do that as prerequisite. At some point =
we
>> probably go through them to fix, but since the new header is added, it m=
akes
>> sense to put it to the proper order.
>
> Hello Andy
>
> Thanks for the review, as Waqar Hameed said earlier to not change
> anything until they have
> a consensus here.
> Ref Link: https://lore.kernel.org/all/pndwlzk51j3.a.out@axis.com/
>
> Do you want me to order the headers now in the new version?, I would
> be happy to do that.

I think "consensus" was met with Jonathan's mail [1]. You must've read
it since you replied to it, or?

As I said in my first comment: put the changes into separate patches
(sorting the headers is one patch and the `guard(mutex)` another). Then
put all of them in *one* patch series. I hope this is clear enough...

[1] https://lore.kernel.org/lkml/20260309191504.616a9bd3@jic23-huawei/
