Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793034656;
	b=Sltupp4feMVRZIUs8l7w6ZTZXR6RGTxC2tTDuB65ernsPVc2sA7y0LIvvS8/KPnml34D
	 9yvP+eq3fiIVSzSfcY4Fy3dVcgqGkAyMAqzYGHen+aUNxt6qRRPI8Vg/7qsDY3lWL9yxX
	 fB/nXOLc9ztYGiQkkzz1fl9UoOcLcrEE0v0n9tWepVBVs4mwW6yy09iOmjfKqHddNLsYU
	 e7EsLvhA6OHunfaKIb0rmGqYfoCsCO23CkmpVqLdhXBLHlyaWIeYNL2J7n0kzx79oBzso
	 /8CxDYWBWFA2kfTVE/wqo6ZObvkX8LQUIkS65kmWUZVUyp21qz5I+qUkcd9f5OHKZBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034656;
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
	bh=ZbQSWcuhLqfWDFin/p014eO37KPVD6Ke9Gs37gPnwOc=;
	b=wL/SGZzIN57jlvTaN3ETmsHLxIJca157YocXH2msg05/RbXVvWyrXkgYsQZxxcDw2MjY
	 XQVtCcB1GatoDutVfrckq0TgdBcMbB+exb0v21126U78mx4bwVixZ+KiyHDyyLpoh9diu
	 OBHI/22VpM1lZbJwgvUwbExA3xBKIIvsjomj14nSDFuK3TvaSbhd7nzVRzW0Q6W9slSkG
	 xvBfWnKSDGBeDpd3vWC4SPNUxZdFG8Uk9e2a5B/kzFSgH8VdlhWtyoaKfxpDSCxtFPI5V
	 dJJmRF4z/xCRdmvZ9COTX+QA/j4TN2ZQx14Vs4japZrOc+0BqBkP8wTkX6i5p9P39QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=CsH0uf5q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010021.outbound.protection.outlook.com [52.103.13.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71C606A325;
	Mon, 26 Oct 2026 17:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B71C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=CsH0uf5q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDKKsXF+IyVEKP2GbC5zZ3KM9TcuVjm0gBll7RlrO4Icb5AiEa00J+WGCaYkKqtrBp2V7SPhadEcaF6CY+Q6tN2TdUaBxT53EVIVxUGyghfUEF4JQPvm8iya53EslSsChWuW9ylei5Xr6QThKN30ouB8zk6Qtu/mxu7QpxbzLyTyAmJaguAfUpmLw2pumh21NbmFUEYa5RNPYwdDg2IwA8biXHD6aTq5FcvYLxY7PasKkPJByJf5v81ONsrIHbg3ziguzodKbU0xqIgQ+ZeoAYGMr/DwEg/ihlty7J1JoUbmr1rpC5mP/lNDHMqb8YwWoQt3TTULAvXr1XcozINfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbQSWcuhLqfWDFin/p014eO37KPVD6Ke9Gs37gPnwOc=;
 b=PXvCGDBM48YWzHhQf4/s7KKCG+CvErDz+OBXoIf6+XSvPR2tgLbw/m8R7rgiYzklvH6YdgmOkxff11ZfwFnHg1PNrIaUenzV/z+6huiQKvgtvx6iHgQJDd9atR/6YL2CblqbjKhWMQLXA2a1GrqNvHyJ4UmLRkQYr7+AoNelRnBnlixYN/UT7GYgHcPXC+NMMCyXAvylMypZozBiWVVWLwxzs/iSTqn0mIiPrGcDC5PR5tTtD4jz1rJ2QsPxvR7m7PQbxS6U0vc7rhCvYAe/Dy+K5iYiihwDv6hok0VcgK4tx9qOpOQs9yVUSmA8HT53jrwFab3Za5PgdnW9kVc56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbQSWcuhLqfWDFin/p014eO37KPVD6Ke9Gs37gPnwOc=;
 b=CsH0uf5qUnvoUqNjBHLS4YplQtbNQbaArYBhbh9ZPJFLANI7caK/jzRUsPSfjVC47ztM28wAQ9AQOiGmh0UrIfeTcBQvA/IQ/JKJ7yGykqZfVmfqB/QbPgVaSEgIHHSiYgDhGXSNRmPS3MWE1ARcx3/SIyODKnZL0A51l9aZuBHn+JMKjneyh0ekkbTTkMzuguM0PTaUdaUdILQpiQF4BkzlOns5aIbanNFFLh97ZjXXZRiXDCa4iU5I0c0VhI+jtptXSLmKKj8SmfuXm02jdo03TOPTWtXkOJ7zKNdDNDvoVguQbEf2Lj5wR4vIooOIJF/EQB2EHXb4tvtebdbqAg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:06:45 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:06:45 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon, 26 Oct 2026 12:06:36 -0500
Message-ID:
 <SN1PR12MB25284A3A9B89F3CC50689527A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at8g26_l5JVbqs2i@ashevche-desk.local>
References: <at8g26_l5JVbqs2i@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::31) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026170636.123218-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: db0b5c12-6568-4692-27f7-08df33838394
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|24021099003|39105399006|22091999003|24121999003|23021999003|20031999006|24071999003|15080799012|5072599009|25010399006|8060799015|19110799012|12121999013|260925184616899003|4140399003|3412199025|440099028|261007181701699018|26121999007|11120399003|261005200801699003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nxN8LVp8OT25GbniKX1kyNhmu1t90dPoj4ZlfTLjpd5/25dR9/3DJl7CdDR4?=
 =?us-ascii?Q?M70SPyN+8ADZnVRkFs9KGjD0n4tMNeRD7mu3cuFjqn3xcDkCNoKiR26NvGjH?=
 =?us-ascii?Q?x8lk6GcoVsrqtW5hfLG0NiFfv+zES87VI7KE0d8cdtu/pQ6STWbNpEysCmuY?=
 =?us-ascii?Q?p49f4mVqSeH0tt1cAm1toU+lFz0ydYN4Ao7VxLiS9ZSwDdOXerdd4oLIiUGa?=
 =?us-ascii?Q?GNZi/P8Me6mXxzIyKu5efL+4R9wlyLA/iAtjjHeFIZbw4jFBnZOlRw+StVlp?=
 =?us-ascii?Q?RRju/C/kx2yxxF6BZ5v2w+k1XZ11lz0381u2pxOhERakqs4nkijmxvJm/4/t?=
 =?us-ascii?Q?MVXgGxVxXlKgbb8rUwFJOs9KOJGg7BNjsto8OkqmcnN3dkr5oLt2jRrJpL/s?=
 =?us-ascii?Q?LVpZidrLTLnNu9CO7NAStIkeOVxontEBuGsvObto4dBp0YPdC+KEqfymphSe?=
 =?us-ascii?Q?t1w+Xuw2ytHLQkB2pIbVCzcEX6UkFe2+rEznJcSyUM5SihkMzLtB7wetehaU?=
 =?us-ascii?Q?YhHHfiXzII9HlUvibgAieSZVXSdGJBdZ0XfiJfzSZHvF38+BDXdKDjas1dvE?=
 =?us-ascii?Q?8gEpZpq82K9c9OchOyvR4aNA+XBoNxctMzbtDVsVMkcan7SnaRhPcilgZ0Ed?=
 =?us-ascii?Q?7F6dMlvddlk63QFDZGxsnHHYiZbUDkdXzzo+SHfwKU4Hobcy8YncxyBy7Nu2?=
 =?us-ascii?Q?yYY5qFv+qMW0XchbbbEIg4q+8lsJh6mfWKrMmKcUcHhkLi+KQlVgCKyTbUgt?=
 =?us-ascii?Q?49fO4makopH30oDKPMkS4juR3y9gizazvGbpqiPau049aY2ciOaFDTfqlj5g?=
 =?us-ascii?Q?fIo7fZhneojbC8h1SNmAviY3rhVRCeo+vlrlrNyTssyiq8OaIGshj5vGsUcp?=
 =?us-ascii?Q?vLJNHSdXpeZRm4S23rdpy0LpNbi3gihlnrrmgBvmy1RG228eGkuGZmU14YPx?=
 =?us-ascii?Q?ngx/SRaxytoxatW18xLna2gwxUbTpdfvXMJ7KvQpQ5BTI1nwau8mXMSMfbu3?=
 =?us-ascii?Q?a9dGVm1vETSzctGE+h6+wg09Ym/Jj0PgmW1MiIGVj68bCE/KGcs0q2QI+GWK?=
 =?us-ascii?Q?4DU7Dw9AJZ9VEW/Mezq/gNIK70e/Uz/g/bc1BgKg0YkINyPt5Eahh8t0rPf1?=
 =?us-ascii?Q?XzAt+6WcuUpFNCoCEU+U2H/s/grf6VGUM9iBMDga9w3bvISYGOCBFeYvSjsR?=
 =?us-ascii?Q?f0IaDs5IS/vtd6gcunrV6cp4x1mgPUEfxoktUFDOC4CLrDRf70En/Iv3aPo?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqupfgpRHPJP7pzA+jNDThycIOHngovooNbgXbO5cKSkU3faBZBrL6K0Lbsn?=
 =?us-ascii?Q?V1Z1/p/jDsTUZFUZzsD67+Z+S8b6wiD8hbsmx80dEHe0SpAYpowSKaVtZoJ/?=
 =?us-ascii?Q?2J7oPjfe70RHDSG+Ul+DtViOEU63jnOvd8J6Es9KL/s0YgTLQdmkAQRY3b0D?=
 =?us-ascii?Q?rWDbTCjLW9sQicA7d3nFvk9Art7Ff82YRTxxMco6cxKSaG4KF8uYF1E4N5SF?=
 =?us-ascii?Q?Jhc4hgfieRU+gYQDZxIMcVQHIjbt5ZK6Kav9bgXzmm0zVkZyFq3x+GDBOmAL?=
 =?us-ascii?Q?rnBajIW3eTkFN6l7basd1oUaXcj1NgRvg2Pgc7ODGTdfOb/186Z3IBUTqLnq?=
 =?us-ascii?Q?Nes9wSEXx4ERIvKABGOCbe2hM082TDNVWZ3ttMjHY9w44Y9p4K6HhMph/H3f?=
 =?us-ascii?Q?wADYkBFjtqZtjNpGkWFLifLvGFljjKtzchIC49XT2nGcVRDYQHxBddoVbVPI?=
 =?us-ascii?Q?fxNYDhUP4l+GWoKQ4ImR065MRkusB/XQMtk4xecasJiC1JfC44yIWZDvsMaU?=
 =?us-ascii?Q?zm6YFsc5omVHqThcoSZksu3TyKUiFZfhCEXPmNAFYvYtkJLa38pk8Dj1p5Ht?=
 =?us-ascii?Q?yT23qMMMdbgwXzCjlQuH3BdRUxmyew/+/xkRLL6G0qRN6gPqxG+GH2kTskrW?=
 =?us-ascii?Q?kIlTofFED4QOrEKcym1nrsh0JeYFRx3rdLVnpdK0/mZSdGj1q0oZYplzA1c4?=
 =?us-ascii?Q?iuEA4n2QsmFQjrbr0QViNu9RLGb7ai4JTab0HFWo2mJ9diax8xQbWpykvNtf?=
 =?us-ascii?Q?i6Yjqzw3bimxN3FX/8Igcj5r30BjFKNlHSdkdf5qs1SUBimoqhloAOzfwMK5?=
 =?us-ascii?Q?riWRUyr+AoTxEjIuZcP3Li53FqrSE/BumxMXfs1ACE5PQ8GTo5/Hv8xKeB40?=
 =?us-ascii?Q?nu2ePxSvdGnKLg67PIeMbe0bHM0LewhtvCr/lT96vCIkWCy5uzxC6lD8QnH7?=
 =?us-ascii?Q?CRREQBmtAhJSMkpApVBN3zX3YW54fkV7OGTjQFPd1vdfW4Szd7xQeoIa7m0H?=
 =?us-ascii?Q?Yy7CAvH6Hxi/NDUGFmPkCJ2GZr+LCy/0V01iQmNOtX73uSAxG0THcU7sint7?=
 =?us-ascii?Q?I3qGijqthMj1YH0Y2UbC1AtaQjkCoWN1XVrmunzG3yEnD6K27grgDm4VtvDA?=
 =?us-ascii?Q?LRiRH6W8XKCgEmBJ6SFVZsQRV+gdrdllhwKB/ylt+zlnhPHpxAkAQ4O7EU22?=
 =?us-ascii?Q?9q1sQHO2Fp5k5ZPqGD8UBAJhDcJkDdlaXB3theCXuhIvjXhiqnZgYZrbW+yv?=
 =?us-ascii?Q?G3EUg6TMwvULYrgZnrcwOhyLHNRBNaQSwWg0oYZYMJoI2/AgZcX4tv++vj98?=
 =?us-ascii?Q?XyqB027cYa10qwHPXNGckO9H+0mtsfFrzs2hoFCAa/ZSybG+gwSaCneFRDv2?=
 =?us-ascii?Q?XwLjEB3dwvrqsDtif0mxKKLtLR8HlzUVRNgPpdaoE9hrq8T69Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0b5c12-6568-4692-27f7-08df33838394
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:06:45.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

> > regmap gives us the two 16-bit registers in native CPU endianness.
> 
> It's only if you specify endianess for the whole communication of regmap.
> I'm too lazy now to check the original patch, but if it's not specified,
> it means the device native endianess, whatever it is on per register basis.

We do specify it, yes (the chip is big-endian).


> > If the CPU is little endian, that means the overall 32 bits aren't in
> > __be32 format (because the two bytes in each of the halves are swapped).
> 
> But yes, even if you do it in the device native endianess, it will still be
> a pair of 16-bit values with the halves being swapped in case of treating
> them as a single 32-bit value. This is unfortunate... So, basically this
> needs to be elaborated in the comment above (where you refer datasheet).

Can you clarify what you want elaborated? (or are you saying, *if* we
were working in the device's native endianness, *then* we would have to
explain that in the comment?)


> What I meant is to compare decomposed val64 as well.

Hmm, if we only worked with the decomposed values, I think we would have to
write something like this, which is probably even worse...

    if ((val < fdc1004_calibscale[0][0]) || 
        (val == fdc1004_calibscale[0][0] && val2 < fdc1004_calibscale[0][1]) ||
        (val > fdc1004_calibscale[2][0]) || 
        (val == fdc1004_calibscale[2][0] && val2 > fdc1004_calibscale[2][1]))
        return -EINVAL;


