Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5478359704;
	Mon,  2 Feb 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035132; cv=fail; b=hYbJpbX4930XevIAuW4DiZfCXd+Ajkw1PjE/qfvD1NVPDJYkar64nXTNJJHNA2i82Ez50PJNt3YuesgI1yrLZC6fMBb4oWJ1WH6pw9XbFNcaiUIi+62mtdsMSoafInR/5fgVcmKIINzgiTo3Lx9UJo2X92D1KS0eXYRufnv6XdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035132; c=relaxed/simple;
	bh=xo/p4Yyo9byD3NxLDXEosNWTLeOj41XV60LvKvMfVYM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hX9ItdDlEn4WNs7XcLVRl00hOhwluB1nbmfBMQGB4gz91ZQCrpDFMBPBV5HMiDZ8+GPwo9zKp4S6oDG540dJR+iRGkIThKcOe325IoQNX6VyCPhhHQo2/1xB28FIWNOMtsbSV/Mw7muDlQwgBbVGDqFCaRRyyCoNdxpDSVqHSTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pyn6ORU1; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pyn6ORU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwBFkgXigpc4bpxZ39kYEt+F2ealob+ut4VgMtfDSkggWeRFY/XxzTWsQY55rbtQM+5H3Jylj31T0uQqpfcUk3QKnQ/h89HJLYWiZWkxiSpNe7RkdD9qvkylGSztsLq+ZDpUxiJ3hRmEJrDtsx42R+ahtGrJi1Bm0lBFWBm8Hg1t5qhqI9ZWU7Mu/WZo3eIaEMnAhvdPJk5uRxchV3PQov/9YeZpn2u9W2GfWWvNOF55jZBGTI/H/DfOX7ayZFeOPaJnZmM627dKd2TK/n9jajP90lTagvAnsZ4W+ryNVMY8tAj6suqZwbfWqlyopoyxjuXo1t5zgnLzeoO2ydx+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rbWKlF4D5s4roDuqHc4Pc1PGPVKVrdSJ5m8YTFM0kk=;
 b=RHYikBuDkfD/jf+cFq7NfOa8Dc328Q5BrQnuinVZd5C6ZmijCn1PfZcZvT75ErsUrVK6cw0ZGh2hHDzcWn8IcENsm1rAbnQ3Y69kHgK4AAfdn7t0RouODW+Z/D/A/8vvOG/CJ+aItmaGiircvFowUJWalyESF1LIilsg+JBZtbdS5Gswgf9E1LFwXD36d26Re39rk5C6ibOjsBhJt7sppHb3ixXonZBLRZ0f6LI8OmngMZ9fpFyGYEEXq7z3NfyyQNsonH3rPP/VGne9jdmyo6StaXK+XWkfaeVrEsPp1meuw5DFHIwELNSHLm+zvVEmVWjg2oiGpFyFWIistUfu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rbWKlF4D5s4roDuqHc4Pc1PGPVKVrdSJ5m8YTFM0kk=;
 b=pyn6ORU14pcJOAPGX3qgXsSDr7gFZsddMeU3RRG+gOrCIfahGdRjb0hEj1PTzU2Molh2p3rWMyr+VjtQRdCpHvvrX/8Lb5UGc2RsQM4BVMt5diZhd6TT+B/3yzBQcV3On2QPQZ639CZWjLCbmKWkf1JBYRf2yuY8iMf7nINuUAI=
Received: from AM0P309CA0018.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::11)
 by AS8PR02MB8615.eurprd02.prod.outlook.com (2603:10a6:20b:54d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:25:26 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::13) by AM0P309CA0018.outlook.office365.com
 (2603:10a6:20b:28f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 12:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 12:25:25 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 2 Feb
 2026 13:25:25 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, chuguangqing <chuguangqing@inspur.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: light: ltr501: return proper error code from
 ltr501_get_gain_index()
In-Reply-To: <20260202120715.25625-1-antoniu.miclaus@analog.com> (Antoniu
	Miclaus's message of "Mon, 2 Feb 2026 14:07:12 +0200")
References: <20260202120715.25625-1-antoniu.miclaus@analog.com>
User-Agent: a.out
Date: Mon, 2 Feb 2026 13:25:25 +0100
Message-ID: <pnd8qdbl4cq.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AS8PR02MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8eb863-e2d6-4885-9fb7-08de625624d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+Ne9qQdOsl/uttIEDho5x07pUKG0NQS09wmOFsrVQhtKyIyBnx49hwbSUe7?=
 =?us-ascii?Q?bwd1VHJlLfGActtzPt213RYlMS81zuFjGAeVnS2/F7pV5FvoNLUCILrZIiua?=
 =?us-ascii?Q?EhY8dWrVLrro9ppnaZUUxVeAkgxs7AcfBcxwWEioP8zqIyTCPuMeAqIQLS0g?=
 =?us-ascii?Q?yS6kGC0V3OPBU7SCFP0PMo4wiPbPl1p69xIj0czNx19il5J8iONRR1IJ4xKK?=
 =?us-ascii?Q?h7i6oDiJn+cmpO21mRyl4e9YyvJQ9IPPu8aZTj8zt3+4Ln5181fSvOUDptw3?=
 =?us-ascii?Q?R3vYyd+InwdwFe0SqPh9a9gZVSgd0QPuNTQdZzYqOLH6SoqVESMlDdpgpIOz?=
 =?us-ascii?Q?8Y+3u7mPv3X+f3uvgRZn+6qqeLyI3cNtTk56pyQON++Avs+KjP0jmZRjOIiE?=
 =?us-ascii?Q?Ltuh5cKj+Ul6g3FtSydydEAaeDVQWCNVh6fyWzC6lcGygC8mrHSRdzrasdlr?=
 =?us-ascii?Q?FSSGp7YTazijLIMe4iB+/dS/uFoenfGZrewLNjaqs9gabHp5fXT01rlFR3mC?=
 =?us-ascii?Q?Vv/kAlDuQdUHzXAb5ypzEgyLlna/BXCfsjY7Nm6N4OS7YZMEdq8eW1dLrKDW?=
 =?us-ascii?Q?QXfRJ/mLRjzous0+DiDbd2pCOsvy0YGFtg0FT52a6+l4/pp7ypx9sB5jwRnP?=
 =?us-ascii?Q?WETT9XLWizfQDnL32BH9K5Y4wulmt15LixoBGaRHneToWWCCM1fYBdLS9pXf?=
 =?us-ascii?Q?lH/bJtLrlQXBYecolrr7b0tMmRfTRu/a27Bti50M/ZckbTy9PzBbq+OdXjgt?=
 =?us-ascii?Q?TW5j+oFTm4FLrwwExz4WwxuqZW3oRCazrNlYx/IvTbuC35l9h8O1UGoWvacE?=
 =?us-ascii?Q?+wKlnUEBWzIbOaTaTUX94vcN6hGkUJShWPgqIArc4keeaLqTzH2JannPv1mk?=
 =?us-ascii?Q?I50ptBuy1QmB+sb357QCLXuuajqmFf5RtO41jdP9Bw3+YrSl4sJBEWUO1iVj?=
 =?us-ascii?Q?thh7bQSS93T1sL5UNY1j/OGw0vRpCCWSGR0BwN1MuB100FoeYKKeaK+KgWDW?=
 =?us-ascii?Q?oTPTdQnvyTaSTqw/BUJ0Szu7J9O5LRQEXXeD6vBY0VxWFoFSe13Qd/edPcDY?=
 =?us-ascii?Q?NsOdES1GBrpPjMoH+2H13hpr0YvR9ZigAQ/8evPxMbb1ht4sWDbEF8WuuUEk?=
 =?us-ascii?Q?+Jtydyfwgaj2w8nNrnItR8pcuCjNGda5UzQqoPr9BxIBk5HyXJmoeX7XpJcN?=
 =?us-ascii?Q?tIW3UT4EmZrQu3NRDB2+4+aM23uDULFoa7Y/VhTMi97Smk4+vv5f6E1OuTWT?=
 =?us-ascii?Q?YIPJBULTCn8cGeuv/QmrYd5FtZUXNaX8YgWgvK1xq8KcEkBeWc6TuH96ePVo?=
 =?us-ascii?Q?HwkyIO6aYpc/Bc1Aje6vx6cALr9R75XqYKH6qIglGR3DKi2zNV0TStlJiIcl?=
 =?us-ascii?Q?TC8oimmybbQPq5XuW701SexCU/UUXOj90ZgQAX6LRsaqz1P//zGiOJJQ+R8V?=
 =?us-ascii?Q?ikigJnoARqk88eTkHTzQayuO7pydW3Ldss9qZp3UiEBDkkpuZMqjJx6gy7cv?=
 =?us-ascii?Q?yRH8P61Q9jDMLKZnIL5V5x7a1LkUELpedA3mgevXhyetdFngS+mGcgDZq3iO?=
 =?us-ascii?Q?sQ4bsePgCgs/R+xbPjLxFBPfMarHJnQukAMvqgPT8flVw4nq50MOD2RF5hZA?=
 =?us-ascii?Q?mkZA/AJTZbcnXlxtW8BTQkb8wd2LQc2nqxo/pwgKjvrznO7E54J1VwyvFFI9?=
 =?us-ascii?Q?Asijvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4VMnaARHMRGhbzaihWaPrtlVlo+WHhXDjDTBj4SAoUaO2V9yEuYVnp0v323V/+uOW9OycyC6jl8RRxFF0cuVb1JIIBPX1tUxcuxB4NE4ArHdQpbTNTUty69ptWElvKZTPibYtX1wW6kHTzzKNmJt2cYHNTe6LNOIlmsMIRw776V/b/eRNPXnKk/Mw9KVm0PlBJY3nG4tf0ZhrG6iJcp1c4IPdrJdIoV7WP99/leEnXGqORhAeR63TVMXymn0FK6xf6m0yoQ0So9KJ6Hf+5XFKCKNufhrYfg02S46pffPb96WI7tXZpVuMYLR45o+NbSbFSk6jwwz/cHzWkfoUuykIFx5Nxjz42wXK2UKadqT6ewNMTA32xMxJ44Ciltc7HD2vCfVcctUJdvkX9J7C0ENT1orx7ebCK6ScUtp4cj9VJb+d3ecMd2AasQLRhbywcEb
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:25:25.7763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8eb863-e2d6-4885-9fb7-08de625624d9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8615

On Mon, Feb 02, 2026 at 14:07 +0200 Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Return -EINVAL instead of -1 when no matching gain value is found
> in the gain table. Update the callers to propagate this error directly
> rather than overwriting it with -EINVAL.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
>  - Update callers to propagate the error directly instead of
>    overwriting it with -EINVAL.

For future reference, it's good practice to also have a link to v1. (No
need to resend for that)

>
>  drivers/iio/light/ltr501.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 022e0693983b..4d99ae336f61 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -754,7 +754,7 @@ static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
>  		if (val == gain[i].scale && val2 == gain[i].uscale)
>  			return i;
>  
> -	return -1;
> +	return -EINVAL;
>  }
>  
>  static int __ltr501_write_raw(struct iio_dev *indio_dev,
> @@ -773,7 +773,7 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
>  						  info->als_gain_tbl_size,
>  						  val, val2);
>  			if (i < 0)
> -				return -EINVAL;
> +				return i;
>  
>  			data->als_contr &= ~info->als_gain_mask;
>  			data->als_contr |= i << info->als_gain_shift;
> @@ -785,7 +785,7 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
>  						  info->ps_gain_tbl_size,
>  						  val, val2);
>  			if (i < 0)
> -				return -EINVAL;
> +				return i;
>  
>  			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
>  			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;

This return-pattern is similar to how it is used in the other `case`s in
this function. Consistency is a nice trait to have in code :)

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
