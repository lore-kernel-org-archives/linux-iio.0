Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020123.outbound.protection.outlook.com [52.101.69.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95413EB0E7;
	Mon,  6 Jul 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321318; cv=fail; b=f0IRztusnHmiboQoOY+xA1D8kwBe0rXsJs66cwOFTM5gwo3Ff72vuLbwrkV0AqDZx3nfDbzQJVWYa2P2MRpZQQL7mCHEkWzzg/Vw1P6oRM6X7ZY0p+k5mii+V18oTv740qcvVenpCkmnnUB2EPr0DQc9NbPI/7ELrQfLXEwwKos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321318; c=relaxed/simple;
	bh=Zva/5vCmdNNcGXo9MxCPfTWPPLHuqwSy+Nr6faskxFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzYvNd4bA5fh7bKRaofPw8ndtqAdqs7v8ZRMDv0zZTrNGgFT0urqXZodGaZzdyMjqjVg5OLUZkCVqrgGyQZicmrveFPLHEybI4JXnI4NHJj3vO46fBe9BXx1ezSeq8QiYd9OFYRXzs3mDQ8i/MGrv5rR9iohcZ7hSFX7YVHVdyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=THKqLkE5; arc=fail smtp.client-ip=52.101.69.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="THKqLkE5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOyCY4GTsryTjzp7791sz9RUekskucitWiGuLUIDBi0HwtjdiPeZdwbX0nuNhFcrB/DqTP2iKJnCPH3IYWylJhs8BDBaY8A9u5nkr4yJN077P/B17z4KjYJmjQ4G1ZUQOfBRNnQh7AekmHBTu+E580I4O6kdGLHJ+Rc7KJ3eiQsAecKHuPtLnl3XTwMmDkYg343BMsC02PJWxi5orfjh4PrdEem09kYY//9LsVzubFX94z1VzmnFgmAmPV16n3dbhE4cBMMOaeIxqwiMy1Uz2c4/eu43ihP3HS0ELbEvZVYGcWOZTVc2d5VHiYkdsxJTx/yf6aYJJNEQ/Gc1rLVZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpKX01mT7k3KmVzpmy701Cwx3+ntMsje/XxUhiISESY=;
 b=B0KEEIkf/TwDGzOGsMT056R+rRbsoDV8w6Ph8MVRdZgi5d5zEwvQgOFQeWSrJjOumsGBzi9Z44fCSoBKknutjFiQ7nD0f2I1twNsPcX6xhLAILZwnEN0STcndZwDIJDakwV/NEbQWLGMWLgLLtIL171OjwlKO+IJxneebGh3jRIlj47naPdxFDaDChOWetx1/du888mDoOCcAR5ZmT6j+RAVv8D4Ehhwiv+5Zu3RuXah7Uh/cNapb25dl+5fyz8uy0BPFu2sd//aIJMO4mVOHdMTorMS/wBsa1gGYBPVPaNI8NnnrUhxx+Z2UVZZVna2tBtUmAOqkzbMtIpcOxmlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=intel.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpKX01mT7k3KmVzpmy701Cwx3+ntMsje/XxUhiISESY=;
 b=THKqLkE5HBJOegiv9DaOPrdgrjXd7WbNypIsWvPixQbYlb15GeYd1R5FiOjdAuDp5866EkpAfkInURsGl1oDdActNw1Fybqz07ad/2cDFSyFmhnEy1u9Mpg7+6JS6gTO0pSZa6MxkRaxmRDJ1KF3yWncFlGZCUfuu5IEr3bDdPU=
Received: from DU7P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::29)
 by VI0PR02MB11065.eurprd02.prod.outlook.com (2603:10a6:800:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 07:01:44 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::25) by DU7P190CA0010.outlook.office365.com
 (2603:10a6:10:550::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 07:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 07:01:44 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 09:01:42 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Mon, 6 Jul 2026 09:01:42 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wgdKo-00FvY2-2h;
	Mon, 06 Jul 2026 09:01:42 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andriy.shevchenko@intel.com>
CC: <andy@kernel.org>, <dlechner@baylibre.com>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nuno.sa@analog.com>, <paul.geurts@prodrive-technologies.com>,
	<tobias.sperling@softing.com>
Subject: Re: [PATCH v3] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Mon, 6 Jul 2026 09:01:42 +0200
Message-ID: <20260706070142.3796126-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ajvBlBValiK4VY2p@ashevche-desk.local>
References: <ajvBlBValiK4VY2p@ashevche-desk.local>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|VI0PR02MB11065:EE_
X-MS-Office365-Filtering-Correlation-Id: 046cfd34-bc3b-411e-3fa0-08dedb2c706a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iJRHFr235hAlnOXT9w7I6QerClm4YEkenhk7bN5JM35coJHdbqqEhnw0Vy8Siat8QD2sQ8bToV7PTi8ln1zEvB61ldj2hLB3DJnBpW/FBoghWjwhRJdY1za2JcmY1br1302AvDT4lkM8T0HdgslPCGVVw3KSo459ZdwWn15+A3ZKaSsS2Ggoe2uVQaYHybjNrKcGMvo3NVY10rtYZfM5EaxUhoB7M7Z+QQReA2C8kMpH59/PuIQ9kG4i9sSVb3nQUq9Gw+XvQ1geaLspGcsD4NWMQttsjjvhUNHyI39BdBnjV3xkjsbI3tRSXbn0OQREzg6YXUeNIP5hBIGP4XX3i7apOhq75njngij6k/6lLT+dBwJXdCSgy2tXoUoiwKpTHjhiMjJJ83gVzucJy3gG/hbAsjbmydhNntSzAubx6v6G4QfSqTIDPMbLzOqJqlJJ5jmRFs7yuPEvsK4Rr9CX02KTPY0pLCOUTir1V6iQMV00pdoQRQP2KOjgEREcB8QoBAYTNiknQoM/FMpBcWemq19GXi5tQiF6wFFDScs2J6PDh8rL3+Zovx2n+AU2TLmh+GLzVxpL8oAV4Tf97pXDlSFrvzSudmBRCL15x83X0xtek7l8rXxa5XPP4D8QVG1N26rO6+bRFq85aEfcljtbg9ajM4CChJuH1sC5ap5WGpvkEdBHcGWrK7HXxiylkgXlAOMwRPpYzD8rlb/AZMyRcg==
X-Forefront-Antispam-Report:
	CIP:109.94.150.189;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7tLDi9wFFlvB6rFxOg5Zk/Q+m61G/IrkgygkUnOxvS9tsbOmZMuwR3pu031bw6R/NuCobOTMNDm37P/oJb+vOqe+SrrwA6J+y/quJ+x6ms96y5p7+l53ZnmvZqSHaYe9/8nqoNmopzZsRneUkPMO8KOyDVg7qstw6krvDGhfaJaNOpLBHXs24hmF8N13KYlWD0fohPsxbybDdvF3aCrq1tYdG97KZwhjltgYLQGCFX1SG3U8VCIkc7B4K+Y2jseLLZ78JwzUfCnLZQ8rjfqG8ah+2H+exhZy4Cip6T6fPNkVk8tkGqaPU0repe7Zem4sLaEUKxDlIx8tI08wwjpTz1mJWK8fX+VcRU+eKKb8L+cYR2OxnZyREhmnIc4BUFus9hs/hdppm42NhSTj7o76MJy86YZ/6rJziPQvLxYGcv9V9NKe1lD75N0FSi+ul5My
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:01:44.3551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046cfd34-bc3b-411e-3fa0-08dedb2c706a
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[109.94.150.189];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11065

> On Wed, Jun 24, 2026 at 10:01:31AM +0200, Paul Geurts wrote:
>> There is a data race in reading the STATS registers, resulting in wrong
>> data being read. When the data in the RECENT register switches between
>> 0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
>> happens when the value is updated inbetween reading MSB and LSB.
>>
>> Disable the update of the channel stats before reading the values, for
>> registers MIN, MAX and RECENT.
>
> It seems the commit message still needs some elaboration as you explained in
> the previous version thread.

Ok I'll try to add even more information

>
>> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
>> Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")

...

>> +             if (ret)
>> +                     return ret;
>> 
>>                *val = get_unaligned_le16(values);
>>                return IIO_VAL_INT;
>
> This adds a lot of duplication? Can we have a wrapper on top of
> _i2c_read_block()?
>
> _i2c_read_statistics(client, reg, values, values_len)

That does make sense indeed. Will do that.

>
> --
> With Best Regards,
> Andy Shevchenko

Thanks,
Paul
