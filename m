Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794406263;
	b=p9GZzkP9H1KgzmmHBSliD/5kGnOVR79a0UzhJBVZBw37tUZHvHBbdy3Pb4ej57huC/n7
	 4KMUw0q188hnDCehkH4zFiC6Qb21Z7aJsRLNcImtznykn1UecH0Nwu+eeIFi6/jSz5xzR
	 ipvmldIxyNnatq6JGjqKIvn+C5deGmUp74slMshjsTTe+Qw52nV3msN/A8xAGGwimEcUw
	 R2YBz4df7hEwreUGn3a3KhPujOZCv/QgB2zpiN5chkmHODQ6xV5NKvZFc+ro8mmx863YZ
	 UJbL5ibFaxS5btdQBXz6c/AjvIxGBaPEDdYijWfBef5hmvgz219bDBvXcl8fcuDdwQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406263;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QCzXh1B7ZMHkymeBgxN30acix0Jb5unBiLu6Bki5Dps=;
	b=EL0tjQ0m8frxdRaoAgERbRbiWLjF5hlBzJS8Aq1hDiWTa5Ci+VP26Sf5OImWpzp7MxKo
	 jP90NBb3XNlrTJU1HMtUM8AEWK2zTxOPgfV6NIELJ6jgUDcEXQIuoaerI4WyQdq1h2gnQ
	 3gqPM1AXY3u3N39E/fTikxeU5EtSfhlc5tSKsDK+BqKmfxpHU4qF1Y1IvOwDYhK62q0a9
	 I1+hwi2kOEC+PCUi4y6sYh8wkLZ2ffRSi6idWCpCGWKRvshKGYEW2h4BGUwM3YihysNZe
	 /T06pAirR2PwKgMtQpef6pD9XXLt6cLzkDuUVK0ho5I4rv22P4j8dnVL11gX+jPkFjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sxRY2Lnu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.12
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023A606A32E;
	Wed, 11 Nov 2026 14:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4023A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sxRY2Lnu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3qSG13/RSb/kByRPjv2ZA6d3AEDkKLbwDgK4e6O6c8nKubvT9gZnsOzPOEM6aIFJSStNopbqeRe0+aU1/NHBUiMZyWcVCaLmy40zuXcOK9U/EA9u75vMkfsVId9QM8TI15He7W8059Qt93EktzYjLcYbsNbQUNFNJXJp7qjTh61viczCcy3NPBNNiD687sz3mdlV2xuIyIjarffHNe5VTteBzMnTWaVUKChDmnOyyk/3wEXi38rNAmo2FcCjseSRRyAvOHU+uN4RfNiw7j5OlKWHUzrLX/v5ozmfni1mLYXwUBUtOsnEPz24CejLbbEDSw4a0bvg5H7V0DZyfk86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCzXh1B7ZMHkymeBgxN30acix0Jb5unBiLu6Bki5Dps=;
 b=stg2nACAndaD50kTsNbKnlZrn0o9X9/OEB1WSZx3jbh+KdBY1JNXC7T7G+L2rLHr6FEUaCmbQcshbx7R7r6AM44t+ixRSxutVMfRJbEHbr+hy/ZE7j+AorfpXUWWuj3S6/2KXh7A9siHhln3VJJ0V/j+Qc3txHVk2LsPd9TLTQM9GVWB6gbk1xVQUazwoxVASFLw5JeZhuXIQ7jl+sFQ5kU3cElrwXpIC5kKaufBUnfB2mKalnNNx2Ai07V3GZFHz0itS8Bil1c1SNxSByMWyTil00gtIeFGLD8X59UXO+1/xaAFdaO8k3cSs6FB9C4iukzZLlh5345cu5T/qnHhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCzXh1B7ZMHkymeBgxN30acix0Jb5unBiLu6Bki5Dps=;
 b=sxRY2LnubliDkDQy38efz2wqXEa/8dpEaBBk5KUu9UFa1ykI8HBxecYmnXbY7jDPN00+3P5wqEl5MHWXdBbo22fPYp58iuXyufYpBr5XwWASRggqURMkQiJ6Xc9FmCTGwRjJ2yRTQ3VcJ7GMR2KstwuxbuVjkGSBLs9MwJUjhUiZ7KpNtZSq8xCbqKezCtI4YLoqLfBs2wfaOOHxLSY+8GcY6r2BHginiDj5mrerwpQHUgwY9Pb1o+PVSU0iVPWr+siNqSVbdT/6B9Pk6fCkydqCuwdi3uHLP5EVd3XOl6MvIMlnWVzUlQtv8x7FRmOmXYbo3f+wTLEncSJEjqgtcg==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:11:00 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:10:57 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v8 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Wed, 11 Nov 2026 08:10:49 -0600
Message-ID:
 <MW2PR12MB2523036E2E017B5952015D9AA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avQqQ8s3-fkvIiGX@ashevche-desk.local>
References: <avQqQ8s3-fkvIiGX@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:610:e5::34) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111141049.19559-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f88b603-f90e-4895-18c6-08df3ffd9b1b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|260925184616899003|5072599009|25010399006|4140399003|15080799012|24121999003|22091999003|19110799012|23021999003|8060799015|40105399003|52005399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAJKDTWE78rWZhifVaedJiF5IAWvhY5kV7swhC56VaMw56NyTr8l5sVtY4Em?=
 =?us-ascii?Q?90PVsbO9vN/G8bS8pR1G3ioKuN1gqX8wKTAWfxGsRhLFVvjSMQpBmctHxK/V?=
 =?us-ascii?Q?iqdLiBL3r1Inx0iahZR+1MXp24vIhbRON+d1L07YZFlbgsQET/M9doY76VWk?=
 =?us-ascii?Q?wUzVfMdpHkah0rKXoHSATXTvtZ0Zh2Ynewds226nl5hXqWtS4X0P3MfXMRRi?=
 =?us-ascii?Q?ARARBBuinkxX3UwIesdXw1eM8nY+kXuXM7+xi50HKYE3jIKMdGK211U5tjJ3?=
 =?us-ascii?Q?O8gog/WQ3l0besBDgrhfp18FWDhBe4S1LqISjnLjYsZK3cy3VqOD4sZ9VPIj?=
 =?us-ascii?Q?bO/9kiIYs2xXsBAIouRwvJNjP9Lemuv1D3h66xrx4Rg1k8dm6XHoZs1eXEnG?=
 =?us-ascii?Q?jdefUJ06CCDga16asbDt72a5zI8bpo1d2KA2AifkdvS/ZCK/h6BSpi2UVBMF?=
 =?us-ascii?Q?LVt1y7qYyXsunjWZQbuF6jcFWFvwoIblVoWTgQ8RmSYL9bVbuZkuWt5Vh/FJ?=
 =?us-ascii?Q?vQHNOEFohQ6IDQZoCn258paxWEYpjxA9hw15BFfe3wE2ho01d1N2B3CzJEot?=
 =?us-ascii?Q?LNIg1eFYuC1rMn8oLmb8ENgQokZbJY1WrEqHhzQvLuDVjY7sUYGSIZ04rP4g?=
 =?us-ascii?Q?k7gnXd+elDWOhr+gwg2+3wm4d7dd8hTd8DK9lBRgLly6eQvqKLcRtZeazfSp?=
 =?us-ascii?Q?auSoYXqqp4r21UzcFuzfx3slxPuDZpV7QW1gcY0+7RMQOhHU0Q8NSQNYXXkd?=
 =?us-ascii?Q?E97SEGuN2DjgbErh6mtiXqFsWifD39WXhCUVX8mcLsqhRMTpnkl1Ux3V5mM2?=
 =?us-ascii?Q?dIBnRMcm1FUnCtNuOr3Os5kKK1NmfwEvIdke0iA+mPfYu/rLOTkEQBPPY8nd?=
 =?us-ascii?Q?NAthqmeS5K1V+WA865qBsod8Q1LNQqr6BjEfHnEtZWnRI5rwWGbLUYm86W79?=
 =?us-ascii?Q?nhBHmN4HZ9Ib5H4bPNAn9nd4S+TK6Qm91N5A1IXnw3sZGJNdnGODkbhSFDbJ?=
 =?us-ascii?Q?4MSTSBmfZScOmDCbxDcv6CjEVurxOs8yfJY86uws3Jl8ox4Khv+nJX38jU0g?=
 =?us-ascii?Q?uU4aVxHw?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9DBjeM8SQKzDs6rDpGTETM67GJxkIqcS8/asHxsltJ+zUqw1ODWpe9zpJdA?=
 =?us-ascii?Q?Xzvo08ZInjp8ya4Nct9mbfW+bXeRxNEfPUnNBAKpeb7KEWvyjvnA/OxrnSP6?=
 =?us-ascii?Q?LWWGmhweJ3BBco0djGgdDNq33PqYUOqB1hZ5prcuKSElR4N9KAIlNJ+oNN/+?=
 =?us-ascii?Q?hI5FjejdJ4M3rJDXCOwvwJjLVZzyzohZuoIKUYw65PaZ9LD84kJloGKQ3RkR?=
 =?us-ascii?Q?awgFG//Lwyx0yGjgL1nst5fv0LdxF6Prr7mbGJ712n+bozvoEOdG9uHvQStt?=
 =?us-ascii?Q?eecR/7OHycYrQ7oHWSzfMZ4jx46Sy2GlXY0tv6c6UE91V0yZNGBzrWw9t3Q+?=
 =?us-ascii?Q?WIWHR22ryEwfTjqRK5/USctmPRaCzIdmPFKaYJv4vq1LP3KIQEwdJvztSKhY?=
 =?us-ascii?Q?/p7AXoZoeCGlnLSiZBbkbDxlGoO1oVdlmbAXY2OhuaKr0+KIum6jau3GKtq1?=
 =?us-ascii?Q?JRsCnNfRbHvWVZRizoNv49JGcOqnSMS3Ujg9cOiuo7CGASJna3C7hvU1aeXe?=
 =?us-ascii?Q?umzS/jRahMgz3dCI4P8YE3zhBu2YHMiW21js1KTGXqSueYEmZ2O51oUrvs7X?=
 =?us-ascii?Q?nhyOO24qAKCrUSRC6XGcoQ9CpYVZNXSnA2HGd6FnWC0UKXtWaHd2nzsXYRSZ?=
 =?us-ascii?Q?GAe//Fv+eQ5BBsc9zxy4W0OEjDoVVIGLxhnRz4UPAzMzdQq0CbqmjNZjBKRA?=
 =?us-ascii?Q?N2zlLvGkhgcYocvM6WahDiktI6x33l0H4bt+sr79AIQPub8ez4b6LQa8e9Gf?=
 =?us-ascii?Q?AZMQdOVd14KCUZP31H/h5yaO72TkF0+qtuS8+JzrlZ0fZ9MWrf6qi4WHzDUG?=
 =?us-ascii?Q?r+i1OWdI51BOZXGfC6FqR3va/QgzOx7aGac9rtBXT56L9GHwq7iOCYUxDAxh?=
 =?us-ascii?Q?Qytee4f9TeVIC0A2vGLaSMr3DXbfbI26jhLpKXJdIOLn3/XSERQ3sAXfzBzd?=
 =?us-ascii?Q?qqD7f6QO6Ro5czqJKPU3bpsmk/yf8tNNye/FY3wYt2xKsurZN82D16fwlu14?=
 =?us-ascii?Q?2zkGoKvAax6OIHGFxZDmxv+TmzrZYgIVRgkKJcRz435uTo1TmrmII1IvS+JH?=
 =?us-ascii?Q?boYcsvXAHzu7fAv2R/uQj0om7eJC+GyHXvNMKeeYOrPLVpsYpTRRogjyljVP?=
 =?us-ascii?Q?lHQFWs7DBCagzxtGX6TmyAzYpuahWg42fzX/nAB9pGjQ4MXhTMj9Ls2cMaS1?=
 =?us-ascii?Q?qCAQ3uruZG2/xQzjip3es0i0UENmo1f9SeD5CgEb+LrrolaYZULN939a6V24?=
 =?us-ascii?Q?D6BCHA2D2pke9a0qi/aA49yFA9Y/zdt8LH3QzZIc7KyZnsZIAYhKVE+LiMT5?=
 =?us-ascii?Q?Gyy01HoW9KPvw5eqi/yt0f9Bn/skfJ9VnlJmor+NF1UKfkuFdq8Ttzvu3yIX?=
 =?us-ascii?Q?aXQbu8AsdawMM0WutEeN2CjXXZ7NObUrFPIAq0ejxRPC2El/lA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f88b603-f90e-4895-18c6-08df3ffd9b1b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:10:57.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

> > > > +static const int fdc1004_calibbias_decomposed[] = {
> > > > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > > > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > > > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > > > +};
> > > > +
> > > > +static const int fdc1004_calibscale_decomposed[] = {
> > > > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > > > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > > > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > > > +};
> > > 
> > > Can we prepare them dynamically at runtime? Use global variables and a macro
> > > from once.h to make the populate function a singleton, so we don't have as many
> > > copies as devices on the system that are driven by this code. We can probably
> > > do this later, though.
> > 
> > Are you sure there's a separate copy for each device? In my understanding,
> > these static variables are loaded along with the module, and the module
> > is loaded only once and shared between all devices.
> 
> I started my paragraph with "Can we prepare them dynamically at runtime?"
> which assumes that the rest of the paragraph is elaborating that idea.

Oh, I see how I misread that, sorry.

Here's the implementation I tried:

static int fdc1004_calibbias_decomposed[6];
static int fdc1004_calibscale_decomposed[6];

static void fdc1004_init_decomposed_arrays(void)
{
	for (int i = 0; i < ARRAY_SIZE(fdc1004_calibbias); i++) {
		iio_val_s64_decompose(fdc1004_calibbias[i], &fdc1004_calibbias_decomposed[2 * i],
							    &fdc1004_calibbias_decomposed[2 * i + 1]);
		iio_val_s64_decompose(fdc1004_calibscale[i], &fdc1004_calibscale_decomposed[2 * i],
							     &fdc1004_calibscale_decomposed[2 * i + 1]);
	}
}

static int fdc1004_read_avail(...)
{
	DO_ONCE(fdc1004_init_decomposed_arrays);
	....
}

Running bloat-o-meter, the code got quite a bit bigger unfortunately:

Function                                     old     new   delta
fdc1004_read_avail                           141     369    +228
____versions                                1408    1536    +128
____version_ext_names                        406     437     +31
___once_key                                    -      16     +16
____version_ext_crcs                          88      96      +8
___done                                        -       1      +1
Total: Before=8750, After=9162, chg +4.71%

(This was compiling with KCFLAGS="-Os". I also tried KCFLAGS="-O2" and
the result is very similar)
