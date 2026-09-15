Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2368F3C5856;
	Tue, 15 Sep 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483082; cv=fail; b=Pouljs/hjAdjKMypEf4R/vNoyXVHRTpQOK/KtR7Gip7fyUycIBZF0uwzCXXp52XrI3fRh4X2Hrt72AfV+6XdgmeY4J8KkHMrcQEs8WKlggMn3bcL+G8DMVV66GPSUHLMiQQGuMjHYiO3iJVFI8b/iO1ILKd3W9xvbIc6mZmZ8N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483082; c=relaxed/simple;
	bh=fxPxSQSEWU+tlTxw1QnNwG0Tce1bKNWlqJTBv0HfzqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSnAfHv2fXOQ3Rwr2dvq8xjpoq63tzUM94OoUhvKnnXQ8xq6vmwhiGGoUFKSCvUbiybl5+EcEkwXIQ/6joe1lyYgEX1P2V41GzuSMeHiiriQVZXocOojW0tRhDQSiJ09w49EXRJPNGJHjY3Hdq4TI8yxnMIBFK9L0dd3w3H6OH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=igV7gQNf reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="igV7gQNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSdHMCGb5g2O8A8Tnla9EauWAeuDKO71ZrmMeWJ6++IbzatJLkBzSVEy8KoyCshGk28EjBluab4+EBvLM7f3EoI46XfkRGDViZhlAYH4LunNW8aUnNhezNKYlD0NeisOahliWtSgZxtVMCcYcuEocICMxQMDTeO+dcJ1NslRXkD74xTtY94IY+0xw0VW8lZBHpQqllN6vUqr8ZXFKaTbI8P9DCszys8WMsihUbybQgzUvXvLGiaEps/tdp6LeP5Igp1/+aBuXuPa40WXojxc4A3HWjFuiHbufZ2bZCwhCReWZNGBaq6stHFx8wG37C8tlNFj5/y5HqZRRzZ8OIGreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U4D15ZDlQ89hKgU4y2s1p3qrJrjQyTxJYl9nYvoh/o=;
 b=rZcoxgoUwnRKnQumHlE5Rx/uPZEdsajsiV+Yvds1e+j124UtneN6Y9mGtim3guA5nOcIRTl8t84isy+zdxm/TeHveXtf7qxaeIdcTmxBfe7eayjmBg/ChPAjjky2jPFYD4glGKlFXxDi7/rb7+cWLyJbnNSA/3x968o8OeaLmNNA5XWrnb21aSfnoF9HrY329Idh00mN+dblBkQMwfY3aHzRSklK6VqFVvWOnzBz3dKOysvAK9VfxhvDAYBMsTst5yOfm9Am9BfGsx0G2LBQ8QHKTCdzY5x9p94LG9ef147XhRk45s9D/JHak4ytEtvSKaz/kt6l9Jvzctd3WfC4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U4D15ZDlQ89hKgU4y2s1p3qrJrjQyTxJYl9nYvoh/o=;
 b=igV7gQNfOBnGWSOYTnX4Xq0eM3ydvl564wafhu3Fg0MzAm8TrnCgj962OqRhfexu43Cg6de/Y7aUUyc6+C4nW8mGnltme3ugVutpPd5kYmndpVPKd6E4iwuWaFxa1f9VbDRQMGrZA+Jqxj+/lcSBn7CyF1x5+M0cgtGnGAmVU7sL8J3u1kkgws8sfjDwrYGxzU0RFueEEmDlancq33yXaGkGWNunWS842BAn1nCiEz24GnRV/owmh/i4CfoqbSWLwoyto97I6t6OlN3vAT9JTwd6RFsTutZSHtdFlGtAhxNX/wZn9MEJP9b7AzFqDzC7+PjIROxNHAVU5LKW4WmYRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB602228.eurprd04.prod.outlook.com (2603:10a6:800:363::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:37:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 14:37:56 +0000
Date: Tue, 15 Sep 2026 09:37:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqlYOHIFU_dB72I3@SMW015318>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqjzvxI4ecoFvRLT@ashevche-desk.local>
X-ClientProxiedBy: PH8P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB602228:EE_
X-MS-Office365-Filtering-Correlation-Id: d93da7fd-092d-417c-2763-08df1336ee6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|19092799006|1800799024|5023799004|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e3mvwU2N472ONvpKS37W4Uknmr6cFp8+5wXp7Lznclq5tifA68prP9AoPy0umIp2qG/1dusw0HWlSbKgFBfw6PfD7z3dyykVBfMa+M+GbZ7KyPXIR1x9aLv7rJV874VOeUKmlkLUovDHr6/WoeTprNyIyCk9JAc3itvE0rrO6ipb/TeQ3JxcfxsdBa+BL7Q4wS3UVVMOquDjHn3wm7dHoIss5ybIVUrY0+LLVTtNoY3quxpycH5DhPn2YZ/dugJWu6N3r/+W8ZHrUk+8ebE+2hRxtTSs2Rj/zy2HbOVnp+XhDbVZUuUokjOFtb8W85O4XudxwTnb8PfVVHGBpd/h+ClpGnwmqqW4JL3v6XZLI6F96vt6Gof1UVS/4KERONrIomvNBQgljg8/w94jr6HQWoq9SL2Yh3MZPU/NvzshA7D/M1vKfMnjsG93zbWge6ZSxZ6hLlc3b/qUfImLLzOBpvyn3uWmp+aYERgq7V/YvRwPto/xcBT8P7R2g0FAJ1cS5sOJvFHMWfpxDMlFJUh+VkC7ilVpWQFA6kOGmZdrc6YLqWw3QH6opg5iOds2ckE47BlslHwde+XEhSn7Fr9Wuu1nRYyd2qg91BljNGnyU0StqZ492kMVIjp00InCVLJMKj6eLOmGSxlcbM6GQsaJlxO6wrhmosy5hF2bFDuv5qI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(19092799006)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?BYHGDnH4TpFRi9wbDZAx5T3LGfOFWLhQVZX/qXzL4K5v/PPpTx9lqpVT8H?=
 =?iso-8859-1?Q?Sik9VkBoaVOxXioqXhpke2bhNbix6jNByDmy8PUAxvLU7Py55NtIpOxgSU?=
 =?iso-8859-1?Q?maLvBRJAZ2u+aTHAuZ74jOOnm0Jwmrp5zlHSksmz4xSlQGk2uAfjaER+if?=
 =?iso-8859-1?Q?yl4XGZZ6jvQMGgV9NOSjx5E1GhnMbstFXLBLaIlmExKmRrlZemm4LBjw3s?=
 =?iso-8859-1?Q?taZq1rgbg1uvnRru2DIalxIM9O0076GtH7Fz1lCfOSKQwE/jwxBW0MgwUR?=
 =?iso-8859-1?Q?Bg2C+GvRBN/7Y1DgOLB2aXdwb4qKqv3sUI2CMF8H2xEESmgACsBamBuTt1?=
 =?iso-8859-1?Q?Is1v3AkaIPRB/azciUF0IoNPXLCxGUYt40mkSBTR2qjS1Ztl4B1L1ysYjN?=
 =?iso-8859-1?Q?Dx4VL/PPUqpt4zydkW/awl+twAJ72QSqbuI49ptlYzvwfHHISghwCxHIcc?=
 =?iso-8859-1?Q?EKVAsok9+WnbFa7pFFSBgWEnUfxtQJUasJCsv7j79nccIVYTzxr2Nh9HFP?=
 =?iso-8859-1?Q?UNemECSFUWLxG/ts2HKecBY4IYdmq9UZLy+nnIFboKobxhwsoVDdtNZ062?=
 =?iso-8859-1?Q?QTotdm6GHED/nj4sxYl6vNDsiNMWsXIIpewmZwFGFokkWR0h3SZleTVVkg?=
 =?iso-8859-1?Q?JFGXGU9iW7T2/YFKj33RuQgNVhZzvoUSKMIf8agmrF+XHaQmrThh9rO03/?=
 =?iso-8859-1?Q?n+WX+4Nq1bcSWTIPTgs4sdi1M2oMDZMpGYkSUEBuhg/9D9NufN9TFqm/LL?=
 =?iso-8859-1?Q?pSVxpFRzV3rptTGEe1XsrYBDPCYcY+aNp7EJo9qmkOvONzSUcLxEnb4hfU?=
 =?iso-8859-1?Q?+432BC7T3/a1CxWRiGttWUd/Zi1r/TbALWj5op+UV47XsG/bvF6DN9zDDP?=
 =?iso-8859-1?Q?zitG71lAubqkli7AEwzg611ugFDhRXd373944LQeGx4m5YmMSZQcx/ksYF?=
 =?iso-8859-1?Q?KGxjUcM26PM1zSo2xqsPmCkbv7cC5AxmNUJM5gcKCz7bLmNInWXSeebPrZ?=
 =?iso-8859-1?Q?q+9FNyJKhkv5Bkd6kuQNg/wFVDK0GzExZZVZdEI3/aCgienaf+kzxb7DHy?=
 =?iso-8859-1?Q?rpkvk03bd6SPESUgXhRtxwZUXMPJZ6Rh5imnkhe4edeR7ucI9ZLVt2w602?=
 =?iso-8859-1?Q?MpPErz1+FxHPPlVoQROLFAsX25BUExUQ7L6OcY80k5dlo6Gqi1BzPh5yfm?=
 =?iso-8859-1?Q?gxsCSWQSNrn8MBU64T7FQ8NQfrPb/2LXshyCRL0/tOmFxVssz2OJkReOlj?=
 =?iso-8859-1?Q?GKwgaE4/4+bxSNLjt23iH71tqjs7Pdyx5vh1MtFTKPx539RougHpepvPqq?=
 =?iso-8859-1?Q?o7RdWARQxBo+kwpug+HEy+QTZgPBwPkekn8zl1jeIGuOQm7b+7D6l0BUWq?=
 =?iso-8859-1?Q?ltNaXZafVlnUUM0H6Fk6oC8scBlBfwOLJkhKWpV4bIDs5n9ZrXJlhLkK5K?=
 =?iso-8859-1?Q?r+VLxbiLsTAvy8k8Zl47dT2Ws3VoEx/B6BMfJYWf6yV2LB6Aa9bnp/zetv?=
 =?iso-8859-1?Q?FaWPUw4tSZrJ0Wp7+3fh97OQ4Y2nS0DU1ClA4aqALSh1MW0blWDj3SBYq3?=
 =?iso-8859-1?Q?5j8VIbaGEu7PUPpjzZ9Kk3xK9Sl+tuDVxupS13lSP+YSxrxHRhiR1RFIGP?=
 =?iso-8859-1?Q?0+G6iByw7ZkLqOALcJ9OzTvgiO2nhM9KoDYaPJzFk73ODl2eA7YoyvDli4?=
 =?iso-8859-1?Q?DviAB2O299t9DUAUT6NKIwPNlz/i7S0/eap5RcmLrVi4drlkmq+uA+DfTP?=
 =?iso-8859-1?Q?t5gqkUhXe8i8cmMUO8IpfMxKYoDgqt2Mx3MtNLnSyb7KmGQuW3d+kC4SJN?=
 =?iso-8859-1?Q?UuwQXO7NOpzqokGviv3B566VMBkrekbf0KtIYFCLwBM+LdeZZDZM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93da7fd-092d-417c-2763-08df1336ee6e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:37:56.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdzdd3luSU5h5lonpnhdlgkpIUaUqkcgh/qkqfpuF59lL9cjsbJnNc/yr556Ttm5IRIGzzJOWLVvlSYvqBKDtt22/zRhErFxYX3x7FQ5UCHjE4Fj8qpf1KKOI5THHZuJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB602228

On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > In preparation for the bitmap based bus width capabilities, move
> > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > include/linux/dma/engine/types.h.
> > >
> > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > new interface would make every one of its users pay for it. Keeping the
> > > basic types in a separate header lets the new interface live next to it
> > > without that cost. linux/dmaengine.h includes the new header, so its
> > > users are unaffected.
> > >
> > > While at it, add the missing kernel-doc for the enum members. The block
> > > already opened with /**, so kernel-doc expected every member to be
> > > described and warned about each one of them. Describe the UNDEFINED case
> > > in particular, as its meaning depends on where the value is used.
>
> ...
>
> > >  include/linux/dmaengine.h        | 20 +++-----------------
> >
> > I think it is good to split dmengine consumer and provider header files to
> > hidden dmaengine's detail.
>
> It's indeed desirable change. but isn't it a bit out of scope of the series?
> I suggest to do one step at a time. Would it work for you?

Yes, but I hope the file name is finial expected file name. it is okay
just move enum dma_slave_buswidth to there now.

Frank

>
> > suggest name
> > 	dma/engine.h
> >
> > so we can start move more API to this files.
> >
> > after all user include this consumer header file,  old
> > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > which only include by dmaengine drivers.
>
> Traditional naming would be
> dma/engine/provider.h
> dma/engine/consumer.h
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
