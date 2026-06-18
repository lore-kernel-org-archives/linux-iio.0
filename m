Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84727874F;
	Thu, 18 Jun 2026 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806135; cv=fail; b=priCyw9ZyR0OQy124M6OcxMz2p9LnvCXQWMNu4lq3bc3CReJPkClOYQUv/0iLmv4k1AzEAQv8eR4wgXx9KFjBAuxv+svTTi3REgVIInTEtIjGe7mXRKvRJv6Q+LwgyPqvt0O0fH2nGnfioi096DRL1BWr/hmxVEga/HwAOZcvMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806135; c=relaxed/simple;
	bh=cYbeYZ44cls924C+YjbwhWW619ln2tM8Xrbl0NbCR8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WPd/AsBzsiEpbqkV7mkxNEi0I/aRKjaXzza48Y3/aBacNkg7NsU8TS1tKd4BDzMmi+6Op4efudSlmBB19fN4mD83UwH0u0IRq0V3Bpwof17sM871dsKPO3UQ8VaSnUuL36HweE4QAGO1e2ydtMkLMbx8qQBb3mj/23Mk65bC7GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZjTE/ZRA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZjTE/ZRA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psuHoXvbKu7ODvugtalxYR9HgYa8EbrObB5AX86rmZjB+87P/Mx7XWJlBVzvsvStXGQsnAQ/Q7PAyCXl9Tmue5OsdALIcEg3/k2RG7+W+YmbQDWVpa2G1oGCBfw7W5Rqo4/21/EbXZmFZ7umNsso9vfJPvUfkUjnMiG4dqMACg5aUkOce5jF8uEJZzAYiPw6D73QhIVVBzuQ5HoqPZcWwzpF8RLZz0rynaeyzOkm01+6kTbm3gdaW2PA9ya3khcFCX63P6SnlyHBHSJDMq9RK5X+36N6y7vwcSSoSM24fGiR1DeFp0ctlbFHtf4JNuhb/FFvvWHIRtmgAX7HdjCNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSEnmGs3mjy+vfxwPzcR+yZ+r4FQU8rtSB41cKVFiZY=;
 b=e2THs/JLviDyH0s4h2BXIw3rbR850nUCJEKRBSKLmGFqbaULaaGq5zOCsrnjZuWdvV5tgb+VBPs4zNekkfScXz01fgv4eDZJ97lcSe42Fn9QQn6QS1jO1hmPdtzO5/h3tVTKdjeF8wvEWb4NG5Sq61JTbaSckpUO8n3KqTa03DvJJTGoheWEJOYPpTsr8VXGw663v4LAOJXOLTdCf6vWxU/CGmAsO2Oowv7owk1TCHabQfjYYAq4Cuqrlg4auoe0aXhe4vEnicpesGYBedFLamslFxMLf3TzpcVa9WSnIQxKpqjw+FJCDR9MLHiuqwoOLMTv8IUM7q2WDl2MWjgV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSEnmGs3mjy+vfxwPzcR+yZ+r4FQU8rtSB41cKVFiZY=;
 b=ZjTE/ZRAANdi7iYjXHreAp7udeP1qkyezVRJOzaN5rEoohOEjaQZvDiz7WLLUpQSoNFwQTiXhlzXpSsMcD4cL5cGkN16d15Qfnn8w87HwXbcCJsr3y8BuV0d9x/OrcoMW6P4YFnqC444gsDqaTdGk+3itbZdRjnRc49w5KVK2Gk3zhX/74/YSYZRHGTUln6GsDIGTRHUTdqnhyP0yqkLiIDVzCYm96O5ktPIOy9r0zbxNVPDDpb0PT5O9B2vqTMcN+xVOZXQqqI03n0qYQ+QkRqu6ES0QHDa0YJAwtRAL3/I6FM2zG3T9SKjdaGLqyGfW51w3MSESVp5QXTOWcwQyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8862.eurprd04.prod.outlook.com (2603:10a6:102:20d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 18:08:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:08:50 +0000
Date: Thu, 18 Jun 2026 13:08:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 1/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajQ0J3GCbALg0-qR@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
 <ajF3p3Vu_pOx9z_V@SMW015318>
 <ajQnE0e5a1JS7IWU@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQnE0e5a1JS7IWU@nsa>
X-ClientProxiedBy: PH0PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:e::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 33848e6c-4851-4928-b26d-08decd64a5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tX1YrgrImn3OzZK0HJfTxyFpRe+xshZ0GH4ypXBIc7zdi5/KDJRTDTv62/zpRa5NkvgbKpcr/TlNYaLlddhKGQxaa9eGX7d9aOYzfSb1Tsy0wom6AjLieSocE9jFQ3BVSlf58SnoPfdX5v59sH6B+l2I4PcQdBqTaXM2u8tf2EHPW/RK0tw5QXz8m3iQUik4rRGjdh0Ys7nXOx9wA5pOZor1bpHqi4W6oJdiTcjRCGut6urMAmZH2arFDenr26aWLgAVw+f0mMBqdwwVZPKSMHxJZdrEQSLHQetfQk6WSWpvdreXc5BozGfZ77glos5IUTsyv80QZVzVDQIprH4q1gnRkzbifXT+rPVBuwhhwdqXA5/h1AOT/N/PTEtrNYsO6AV3srlwXURPVZC8eNPIxAe+5pc6vLzH4gvfiLWRTyAMWoM4PeHZ6attUCQSfxbbNuT2knetHoOKAjXIUzGUGuU9dN/hhAEVAjuSzbSqHVSDuU7Bp+qMVrJGh/FFSCFksZnnXN9bgAMfk0dZlLaCanfXmTWTMDIV4NWxVC1t/9DiqyIUXv/1DYxn/hy029bIZU6eQaPYjKhs5t7JKfzKEJBfyh2yW034Nn1RqYgOCBPa9/BXlX6Ubd6e0cGyuoECUsSR8vdajLpqFfC4AzzCz6n3tUb8pn7h9EX7A/A8f4XebazXr5mI+rWI3zpbwT/W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HEgZOFbQM7ATUK1IzCQoeiDfALZui3mxtK1NO4hTBRBgpPFF9lHBGRjC5z?=
 =?iso-8859-1?Q?cg1qncaPgGSUoxCNCGazbtRQApkhbjvQKTsIixkdPdhs+XbfrWaWaKo8Oq?=
 =?iso-8859-1?Q?jRjSLAk4ps8wp45F3lJUx9Rb2eMlVzfi8A1tlBlRojAaJHZcatIvhLAnVi?=
 =?iso-8859-1?Q?OBjbyZlExsySOxxdPm+EKJFY9HooKHdMaPRRYrrMlxTJwm9F80JSgi5EKG?=
 =?iso-8859-1?Q?0SgqmGdsgTaV7rOXiQ0UrpmJFRT1Cg0QDK0OWk5SwG4Xd7vr4RW6a8bivW?=
 =?iso-8859-1?Q?oWGGfmet61ZK4PKcIU9Wmere/dK+KaRPTelWRBcr2B+D24uDOMnUEdkNLq?=
 =?iso-8859-1?Q?e521kV2GGuHeMj4YfYDeiZXoJGfTxhponXIw+mW0lVTL3PM+iKGc4QHcsN?=
 =?iso-8859-1?Q?+3mSfHixm39lqqjt8731TVlzj8E/bxkCKcVxzFpAN16zqW9v+d9AdShOiG?=
 =?iso-8859-1?Q?J52Q3SvSxFmS4gRGAA0AJpzeG56NNGuQONDpTrM+pljqqtZOesICKURhUq?=
 =?iso-8859-1?Q?05lqJtJRdV/1yzIzTE1nVoRVPdcOohTiIV425tUrAfg4BxSCKD0MaUtV6Y?=
 =?iso-8859-1?Q?GDs5hTh2Om/3subwcpALfuO+eMkwBhNlxAG4jE7uNxhZwqT4cD11nEO5QW?=
 =?iso-8859-1?Q?QOj9ckCaYmPuldZ94iLUJUIowAZsXM2I+cKEhhSIwkyQUFVjfC4/sz5hlp?=
 =?iso-8859-1?Q?Myegvuru0xBQcAEds8LToAU1dBfOzqfy2spNzkl1ZlwlrMcg8ALxCQDkyp?=
 =?iso-8859-1?Q?Ydcag0XV23aJ45Tvhpc6leMAVJ2TDIP9xQ8mu8+Z9WhZDS9zuq9BPfWAWs?=
 =?iso-8859-1?Q?FT/WLUd/XDeT5KYsTZr8o30Xz8ZtlweB6t6NTnbuahJSSHYH33gR4uAnC6?=
 =?iso-8859-1?Q?YHP7eRN11FLIsnZE1eOjZ78vm8AzMgwrJM5YNwjGqstwWb16l24CiGnPsP?=
 =?iso-8859-1?Q?ksW2L3KfVAqPOtGMZpcexzKqzcu9++bLHM9f1FMiDu9LIQtlEzJJmZdICe?=
 =?iso-8859-1?Q?WBsPv/RkbGWd24/d/e46svhMnjGoQbUzYUjRKgXZeftV29EXDsTKst84o1?=
 =?iso-8859-1?Q?UwW3KyyhVFvyRSH0vvo8dRn/UkoSzDtdlRE9tdLrrYn5mV0VG0t2GybTbX?=
 =?iso-8859-1?Q?4GGrAAC1euq9a2PeTUeiwnIh70QMzoFYRJnVsppXZMGrN5kgixkqmVS7rn?=
 =?iso-8859-1?Q?MEd/SvcZUftXYmjl65LaQr1neBkvXRio6d80dbsfxQ+IGYYxM/g+nZfUsH?=
 =?iso-8859-1?Q?fwt0+kNp4I5xHygjqsLpWuKKo2pAGDGAS+crG1q0E+ya52g6mm58OKT+xp?=
 =?iso-8859-1?Q?xLsBQewO1dtzIdMMxvmmoJ/4BSYKWAVs4BTOigmbFu1/ZQ11yveJ+xF/PD?=
 =?iso-8859-1?Q?u4nH1bNrw41MVVQGfDMsFjAQ53OQ6v4uTV2IwnzX5H75oLFZRebipu4et6?=
 =?iso-8859-1?Q?Y88EqaMTeWdyNKL5LxskxRKKQnQ0Ift6FAiehYpWzDrDgZgUKGLKxWtCny?=
 =?iso-8859-1?Q?kXrMD8+0SrB25PuthNDEAyDvacp6HRw6h4qVVrBxIC2hFXLxbZ4MrwZnM6?=
 =?iso-8859-1?Q?Vxg7e4SpquCunqxxvW1bfb3AQ1bGzolFDQPaLPPpcjpNgulQKEhXLV8spa?=
 =?iso-8859-1?Q?RlFIwOTSJEejjulVya970JucfSfd8u10hAByJqoDZX1QPqWw1bRHB56M0S?=
 =?iso-8859-1?Q?5fxXAGWbKkgEW0aB8dCWD7OgAYI2ESwUnz6d439CZ+0EKwCD6Lc5SGVEy+?=
 =?iso-8859-1?Q?DMgWvcF/3S+GC5ZOVXTx8Av7YhtRRtEJr2iH+IgAIhTDB/SlZy0JAz8XDI?=
 =?iso-8859-1?Q?3Jj4dVnpvMlvPLCRSufVk9oLtNZMOYmqgmRDQ2FATiSuNI8Eu0Nm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33848e6c-4851-4928-b26d-08decd64a5f6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:08:50.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azsT287qpQnsinq0op2MCof6tQIoFkyKuQufQ/fcnYTAhYgZaDT/IMXmwiYlvYzzsI9Y4IcDrSkfw1aNAln+YChFROjYpH0dvk+2TR95MRDlvjqxxKPHsJGhTjJWjxj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8862

On Thu, Jun 18, 2026 at 06:13:47PM +0100, Nuno Sá wrote:
> [You don't often get email from noname.nuno@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Jun 16, 2026 at 11:19:51AM -0500, Frank Li wrote:
> > On Tue, Jun 16, 2026 at 04:40:52PM +0100, Nuno Sá via B4 Relay wrote:
> > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: Nuno Sá <nuno.sa@analog.com>
> > >
> > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > supported width as a bit whose position equals the corresponding
> > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> > > bit 4). As these masks are plain u32, widths of 32 bytes and above
> > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > be represented at all.
> >
> > This is problem, which should be fixed.
> >
> > >
> > > Introduce bitmap-based masks that span the full enum range. To allow
> > > controllers and consumers to be converted incrementally, the legacy
> > > u32 fields are kept alongside the new bitmaps: producers populate the
> > > bitmap (mirroring the low 32 bits back into the legacy field) and
> > > dma_get_slave_caps() folds a legacy-only producer's u32 into the
> > > returned bitmap.
> > >
> > > Add dma_set_{src,dst}_addr_mask() for producers and
> > > dma_slave_caps_get_{src,dst}_width_min() for consumers so that, once
> > > every user is converted, the legacy u32 fields can be dropped and the
> > > bitmaps renamed without further churn.
> >
> > Good mirgration plan.
>
> Cool! I'll then wait some more days and if nothing pops up will drop the
> RFC and send a new series addressing some valid AI inputs and converting
> more drivers.

After check code, dma_slave_buswidth is NOT cap mask, which indicate
device's FIFO width.

enum dmaengine_alignment is used for check memory address alginment for
DMA.

Frank


>
> - Nuno Sá
> >
> > Frank
