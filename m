Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D003EEAE5;
	Mon, 12 Oct 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816424; cv=fail; b=ANeB5O0q1A983ZF0qN44/4WMV8UR9rsJx918rlsQ0UTvYMQBimVfr3HMCmbrgc8APQFK7fXnpdyCI1oB8jNHk0EHbSmh4y5JTCkhI5mCYtHIgpYAhUl0LKjiNnfLJcV0/rtA/YebBeWxNxTOoU5vgVUVNxtInLmeBXo8/fpmJ2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816424; c=relaxed/simple;
	bh=dcHLI5re4Nd9VkzVEy99ErdTtwFeqLvrndivT3CRep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Op28laFD/urCglViBvYacJ1h9pBu2R5R9/Mz306vpoaEkJoPYWU6ljcQ9bxz9/eD5kTsB4HSRxc8YZsATJv+9L0jgNaGyY0nEalKKqN1tDdARSAWobnmu4MVZOQMKiJjxHjeFUI8i4SmSXXc9b36qu2AylhrJX2Dkwh1ZNZkHDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F8lFPRg6 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F8lFPRg6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXLbsm+s+vCe2gfL2J6DVKoN4IQGoxOkm/h9PK95mQ7TxuTsEX9q/RlVl+zffHu8FGSXmKDOZsi1a4yMjmLyoXRRMCxT6I2j6pxHhMXCywSC1wl0/KMtayP9mkcQ6u8i3PQzDN8+mF3kDhuEfj1TYSXF7g5sjZVxJR9LL2QgGKR4kLnR4nif7m41NkpEBQS/luqqQm/JmZZ5aljDdx49tTK5hT+Dd4D5Nj5mALJPbWHWsLCkUEj9cDIXMvQr4GZi3uidp9J1lmn+UVmDncanQHdUol+NPX2Y76R2w3D1x4jHSrvjmcDBXJvJR+2hdZCWCwfTXjqbBNHqdJOO0ra3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrbnHqCigN+b6ryVBtcUbIzkncE+9J0Vnmci2wzCA5U=;
 b=BM+qwMxvAJeD850pdrI5k2YoJ1vlKy/YMypyIht9tlTYV+JhEmuvtoLBV+rfOyVqMLfGgOeCHJSlv6P/qmZm+gExMGVeQMo5MpSOXsqdMG6qV4iQx5DqciM+bn+WAkg3flymLThOzVREIXO/O/jM7aI+jMPyj6nPKcC9xmmtAG8/r1R1aSp3l6ANfc7ohTRLKTUEHQmBxyroLfmPHRNOAVvwMUtzJvijRhEGvAkchUP2AMlUFLTctEaPm7xx+6JUi5vPoFca+h8ymMSR54hKEBLvvzI7St2edrs5H2dxQ+O+LWkrcWcGiTGNbvqVvTYl5W4pEtssLEYWDhkNpCfakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrbnHqCigN+b6ryVBtcUbIzkncE+9J0Vnmci2wzCA5U=;
 b=F8lFPRg6kK96LcmWJctfbqp5LsGeH3fKQD5YmIXmEW+Q27v2ARCmQarU/GIVvj/MervwCK/oY+FUByyA8m2f92IWgWDd1CeWgNsgaBM1J4Fk35JDNC3XGXenkIMZrz8FEiXFAT0ahZ3WeZzsqXdNnWKPrsGygg1jzueeFSy89NarrICMRhhZmQp6zsshyMfclopcUIqSqlV/QEn05gyekwnPq7fwi0zNaPgEdGBejbpGvLIgV+q9X8QrXytl9ztE1NKrB1ihxxZqldWMRFtiT/3yJjjM/G67G2bWFVUuvpX8tmv6mfLX2vSlKaq/Ikw1f2tj79P8kIOaBoAV+EiAAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11373.eurprd04.prod.outlook.com (2603:10a6:150:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 14:46:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:46:55 +0000
Date: Mon, 12 Oct 2026 09:46:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
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
Subject: Re: [PATCH v5 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <aszy1ERwH23J36ih@SMW015318>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
 <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
 <asmmsoNxW-gfugXx@SMW015318>
 <asy3ky8r1Cyo8vS9@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asy3ky8r1Cyo8vS9@nsa>
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eca189b-21af-4c8f-d012-08df286fa8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|7416014|366016|10067099003|261009223027099003|11063799006|4143699003|6133799003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	q4t+Zcfz4EG0niMCLAlKuCnz5/6f51hA/qeAPTpFM0Uv7rgWjTL3R3YiK6wqikfTxwsqxW7/YKG0GBAnB8UPuKWowibJqE5MZPklCA+Ie6QRZt5YCG7Ybj9S+YPFCbI0PIiSAdpc0NIwGha8Y3P/2VHsvdbnQKWe0IIsMewtVuX19bmBlY0xo0Ws7cqdv9lZHUaB18xbYaEC6LUmYdBKl9EDYHx2FwFIAOWkNUHST2aFAmXeUG82Pqntr5XLHiCZ0quR6sLvIfWLtorbQfwBe7emd40Mt4EVXR9X5++px9gcgTHwIcUGIlJbNIActTexRng2KdVklRNgOD6p1EfDm1h3L3CTgACpIzC7uroMrv2WE0J5Go/EBGiiJ+kPpaz+lzicxPJUWUUgDKyH8yg05bMPHMrL0oQU028BfUaEisZF2bZo2RXYk+WYVE98GasCCA0zHf4gTlL3Rn4nMvxIR65aMJqEN5Qd+Og98Mqe8Zf3nneT/+CBMEeTYPSGwJNYqPmJpQraOJac9bBkFyUvPBNDA9SBEC1HJ01C1aR6G7Nd9qtsBsvS+8MbemxuK+cJM2/h7JSeX+PgxIrzRNLuOfAdsiojetUr01rE1cxoBnzsBAGJA/crfGKMi4Mojqa5SRzDMS6b8t0Rmv4U3hO89svGMySAhWnRDWra8eiLmnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(7416014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SebfnJljnVDQ+JkmugXNQASk2sTVulVYVpzSHdwPKhE2UQ9NNlySI/3bqQ?=
 =?iso-8859-1?Q?lv8cxrLMN4qTWowIrrAejJe22QBKOq6zECrl0NphqjAnoYrDxswQ0r6k1i?=
 =?iso-8859-1?Q?tYdqUbV0qtzJWCXVMEtuXYoFGGFnF54k2Cwy3OE1xU9pzhoh6eMO/olGjS?=
 =?iso-8859-1?Q?CJ+mEgcdTEr7QV3tm9tRhQ4myJb1HuxFPEkzwciKqzAwAuJx4nr/FMzva3?=
 =?iso-8859-1?Q?zPqfrJ2kpsDORgvkeFdvBnbVghLECgMFVq86baiNoZs0yFaGVevxvZOZmr?=
 =?iso-8859-1?Q?2PPxlDV8GY9OgawohXsC3f9rEdFbOzZWztgcc2TZw0qrLvo9YWKC5SMPNk?=
 =?iso-8859-1?Q?KHPYQeJLTlcYwXQs4I4wDqd9soZrRw/1rcnQdAGvjP/t/KRNta0amm1CoB?=
 =?iso-8859-1?Q?UxOxEciX0TiM4Fu2JDGRaohPyaACjcYdSC8piCGESrw1OOs3qOrS+aNqbP?=
 =?iso-8859-1?Q?hVW8jHcoA2R8U7501eBiFFreTRib1s/xyZYGcTIaDAeMWRNxzUsZsYxTeO?=
 =?iso-8859-1?Q?INzPa7T5rjhcSWuVZ1VS4jAveF3dv80ejymr98LdS7XHCrURK/mvrt3woG?=
 =?iso-8859-1?Q?s2MW/WjlU7T2C233sGYbXDO1l7OHYbWVgyrwd6Oj2+jMHyk7cfUC39eJbD?=
 =?iso-8859-1?Q?ttepN1cUv7N4jtRTXIHEScLCOGQBcZnzBYea3HSXzTOyeS0hCTKEviy9jO?=
 =?iso-8859-1?Q?yMhGthEYD5/SluUyIi4mFcfBmgbx2klNXj6WN35NZlGRTiZZnIn+s6SZ4l?=
 =?iso-8859-1?Q?DS3fqywKmlWN4cRIxtsQN6ZUGJ73pYeXSna7ZFhigFoBi+hmMB0Y9tn00W?=
 =?iso-8859-1?Q?nQ1rRT9+q3T651YhZf1SspRfn7LkNDSa2muMgl5/6OdefxzrnkT3qdbd8Q?=
 =?iso-8859-1?Q?R/Pyc3qj4+5QDt8ht0RDUUNQTcAqUq16gSzxuhm5SB02C6RkMnR+Sbm0JS?=
 =?iso-8859-1?Q?u3Zn3QtwCTcCdVp0S+bJo7kt32NPAvzSYyy2Ljq4ZwSFnNVn54icrVxi1C?=
 =?iso-8859-1?Q?LlfznEjumPL2LCSURPIefA49q+1kwuo/+mg2W2js6gwgoiX0zv4iL7EcUr?=
 =?iso-8859-1?Q?wrQDWJrOiZi0qkznmEGo3A30VQMinBzgR3LWeCn+1zs+zLHSOkRoK7I4QB?=
 =?iso-8859-1?Q?qmCg+8M+TeIpEWmxSaIwixhaYbP0AYVNqdWL5RNybQFtHnMbw9U8G/ABNW?=
 =?iso-8859-1?Q?vpjS/X5ufcDdzDRDlgpRl/ahgrv7UW3Y4AND3kIEvUBX79Q+5vsbW2Lfnt?=
 =?iso-8859-1?Q?F9HQBaHFMW4wqg1KZFEYRhAZpz+J8c6BZomEoI1F6klE49Ha5viVJ/HV12?=
 =?iso-8859-1?Q?TWmCbNCXipPfqPZPt8rzZUMynZ3BT0rrQ6NbzoRwD6Ml/5S+7eR/JFqqaD?=
 =?iso-8859-1?Q?2/nwUTEL+/x6X1CL86hnWWVdPWdXUADDGpzTjOVcufvvo6EZP3X3S5sr9p?=
 =?iso-8859-1?Q?Dhu31KXun8eMpQByapRwFGHHUvLLMknBszehWCVlJssWOnlzidZiAnoRpM?=
 =?iso-8859-1?Q?o0ffce1vh0i0rdCtb+AOd5DqcW2y3tt7npVQfivpt+rLTm0xgYmuohZn6w?=
 =?iso-8859-1?Q?pAQA058/zd3kAZSuxuiLSu2k7Fveh+1GfTZrzn9jvhzD2P1LbgcEZt2m3M?=
 =?iso-8859-1?Q?B4gMt7IyjsOmNU4i9DC8SsINq7kBo0NykIU/orc7Z8PpNzSHcEEgNYTIUU?=
 =?iso-8859-1?Q?2/6/dZex0RFiOo7zjd+BX8ZYHD40OIeOLmu5+IH1982NGXbxlZkvhM/OjL?=
 =?iso-8859-1?Q?qAgKrFNbDZ3moXUC8zzrv+RJPlIeshdxv0P5sITv41j6pNaOJbsDThPLTn?=
 =?iso-8859-1?Q?rhlT96c5LM29Raqu12P7fmuCGTDHIFa6CFA9QxvqJh6srjZE9AUv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca189b-21af-4c8f-d012-08df286fa8ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:46:55.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeesSrQVOjXeKZdjbLp+4U56o6zDcZIGW7EQXYUzUbNYz0riqP/XOA7oe1wTJTkmbZw5ADFya1wuRCe9eGWYYwFKclnv0SXjfCCByT0WOmODRg0z4biqqkoRcfNM5teg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11373

On Mon, Oct 12, 2026 at 11:47:20AM +0100, Nuno Sá wrote:
> On Fri, Oct 09, 2026 at 09:45:06PM -0500, Frank Li wrote:
> > On Fri, Oct 09, 2026 at 04:52:53PM +0100, Nuno Sá wrote:
> > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > supported width as a bit whose position equals the corresponding
> > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > be represented at all.
> > >
> > > Introduce bitmap-based bus width capabilities that span the full enum
> > > range, through a new dma_buswidth_mask_t type modeled after
> > > dma_cap_mask_t. To allow DMA controller drivers to be converted
> > > incrementally, the legacy dma_device u32 fields are kept alongside the
> > > new masks and the core folds a legacy-only driver's u32 into the mask
> > > when the device is registered, so consumers only ever have to look at
> > > the mask.
> > >
> > > The fold is bidirectional while both representations coexist. A driver
> > > that only fills in the legacy u32 gets its mask derived from it, so the
> > > consumers already converted see it. A driver that only fills in the mask
> > > gets its legacy u32 derived from the mask, so the consumers not
> > > converted yet, which read the legacy dma_slave_caps fields, keep working.
> > >
> > > On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
> > > masks from the new ones when a device_caps() callback adjusted them, so
> > > that a converted controller narrowing its per-channel capabilities is
> > > still seen by the consumers not converted yet, while a driver adjusting
> > > the legacy masks directly keeps working.
> > >
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > >
> > > ---
> > >
> > > Andy, did not take your tag given that you're the one asking for the
> > > split and since we ended up not doing it, not sure if the tag is
> > > to be kept :)
> > > ---
> > >  drivers/dma/dmaengine.c   |  51 +++++++++++-
> > >  include/linux/dmaengine.h | 208 +++++++++++++++++++++++++++++++++++++++++++---
> > >  2 files changed, 246 insertions(+), 13 deletions(-)
> > >
> > ...
> > >
> > >  	/* note: this only matters in the
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 71cde09ff240..eb68eea840b5 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -427,8 +427,179 @@ enum dma_slave_buswidth {
> > >  	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> > >  	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> > >  	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > > +	DMA_SLAVE_BUSWIDTH_MAX
> > >  };
> > >
> > ...
> > > +/**
> > > + * dma_bus_width_min - get the smallest bus width of a bus width mask
> > > + * @mask: bus width mask
> > > + *
> > > + * Return: the smallest bus width set in @mask, or
> > > + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
> > > + */
> > > +#define dma_bus_width_min(mask) __dma_bus_width_min(&(mask))
> > > +
> >
> > We are working on make dma_device private. New API avoid direct use
> > dma_device field.
> >
> > pass down dma_chan point, dma engine handle everything in core part.
>
> Not sure I follow the above. All the API's work directly on
> dma_buswidth_mask_t and never touch dma_device. Now, consumers should
> use this API through struct dma_slave_caps while provider's
> (drivers/dma) should be able to use the private struct?
>
> Other thing that came to mind that I can do in v6 is that APIs that
> change the mask like:
>
> dma_bus_width_clear()
> dma_bus_width_set_many()
> dma_bus_width_set()
>
> Should be safely made private? I mean my expectation is that only
> controllers know (can) act of the bitmap so don't think there's any
> usecase where it makes sense to have API's like the above on the
> consumer side of things?

Sorry, I messed up. It is in dma_slave_config, which should be used by
consumer.

But all API should be prefix dmaengine_

Frank

