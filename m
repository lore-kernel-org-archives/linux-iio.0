Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E601922FD;
	Sun,  4 Oct 2026 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791075570; cv=fail; b=HRi/PXQunV4uYK2/UgOU2Ak8Q0uAeJBWBJy8l9QMcUMnhgO+hUS8412QDoKn03S35b7D2E4Az0dDNXMrqs+VzCjUTLMAxZmKs79FDSTJmMhAe8hFeAFGSpw6UOaXzQa6cki9bO9kx1zYR5nhgEEb+I1akDvWx3CKsGVxQUEQaLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791075570; c=relaxed/simple;
	bh=gxUdWvEobBaCH9LJHM/0E4HnKZRoagG4pxREcMdhwu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DkREyQU36eWaojl2cyafXxDT1KvS0pDr+QNpcGdILNZ6cergaCYupuL8j9pugjj44ozDxQIc+xvwitLQOt7F+Ni/zMglr3FbaapJYZsTygiyGRKkM50TQiO0IfTCMrVafcccogAblPLHZH+hBZHbEC8zl3/3s19WMxsoJnhWL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PNaPW3E/ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PNaPW3E/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d62zmW4RobrHsVpe3cG7L7IoZeaftdQwxfIBtOsnewOVlh1iLounIQcBmD0ukj8n29r1v1Go3Fkv8JUOR/m0zbjlNHG91rUVmrM2ra7efcHuQQD7iHipGVgDs5FO3/GWZmrka5z1vc7AZdEN4PcLNTsAXqqVx3N84tdgdwXsi3csNbIr0EM6SpKKpHGB37uS9DrBHsVwEZQJWZx0DcpV57djQH1yrJ2q9RRePpi0EK3OGD1eeVBf41Axej44YuNCav+k6phae9gZD2LTKUgJnNL9HyIsSx47bTTFzSTAlkp9yn0Senjf1EdclmXyiU+sVPqVaeuuidBXEJT6LcRZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icl2wYAb1h4y/FTIRrKJRtDo7nD5+O20nuzr9ef3Wyg=;
 b=KAETRnGmyIv8ezWLOjZ5xcZwhVSoA7o4QRRJTseKTzL+/936jODYSJiJiHKaaMBxChBbYPrHuf7Cmi09VvTHNkvID8TB6mLx6qk0i3n/4IxCKYrcBde/hDen1SQkvwxWYum44zw+cCLfG3REgNcJ9ISeFvu2DiXe4PnUv/hq5mfz0RJwONFO28tmwXb0V+Z0pRpiPAvDk8rl6KgyWFCUH/h+Y0y88RVz9NVQXeBmpDAI4dykkttVcpALL59SZEgmxfCMMXxJgqWR/qDxF3o7h1bg5K9WsSU+7veryo+fpIPt5a33vL8e82ciOCgyi//ZC8CY665aixgt1WJOh4ugOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icl2wYAb1h4y/FTIRrKJRtDo7nD5+O20nuzr9ef3Wyg=;
 b=PNaPW3E/MU9tGWcFV52VdH61RC/BHx5YKdtqZtIA/1GX78X/WUdtrqoo8GWOSIb7sh6+jeI00CFh6GjqQeBad6b7xpsSu9ZZT+9Ta0SiPbL+kevsFE84wMis8/CaV9tpi1YHPgxwuhPwj1PvI95ooZAr7R9AJWjOhtgoKQiiE0eM1mNdH4MVMUvwqqRNxwJgh0M6a2XxTb4yUvb6l/yL/MlwThrRLHbEqagodM5kaXE4d35M3I6jx6flbsuhpnR3KeSiEcpnux477WOk4uLS9fxtAcgxzIUHUuk3orpOd7eXZB97quqA4/YOsmfNWB3Ia4fj822K4EaUHYC9kRolgw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI7PR04MB118002.eurprd04.prod.outlook.com (2603:10a6:290:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 00:59:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 00:59:25 +0000
Date: Sat, 3 Oct 2026 19:59:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
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
Message-ID: <asGk4fj_HQ5HupB4@SMW015318>
References: <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
 <ar-Il2qP_Qms3Qw1@nsa>
 <ar-13p3a7ENGfMOF@SMW015318>
 <asEWwIfO0LB27wj9@ashevche-desk.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asEWwIfO0LB27wj9@ashevche-desk.local>
X-ClientProxiedBy: CY5PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:930:16::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI7PR04MB118002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1018aa-a804-4469-1f22-08df21b2bbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|23010399003|10067099003|56012099006|11063799006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	npmlbMe4gB8nBBs0aZ7eDBP3xBBktt7p+Ar0FIgqAbH3AkxqULXaL57SWm0kK9jRmhF3Jg2rE1FhEhN0uZrpowvbYv5X9WumzN+ahU3hkRq0X3yh9YizTjRflfph1ghXms3cCTH0jxQmuyKHVnunKFI5FNlLSvVbhaHtKSq1UfQzlHX+AsFlNrxrTV59PAVXyKbW/cxOb9AJXlu/uC9SrxmFr1hehyqZiGf27ydSrxFZEVVO8pv8wEM9u7rP/8U29k5pVvADzQ6dNqYC35h5We5hKHO9hlqado/TzUUWoDwxjTQfjHygHlL2LFNxs4oKSkO1CdwvjmfLtuhyuuLXlCwzRaP9x5jS5zWerLfvurvKGKQuBqI+C2W/G7bI1ubUJaVMiS/c2SXrXZai3Jo+roKWHxL0ovqgwxxOskzx5F2CDkq6IbOJmFjyAKjiC2B2ESGHY3FU3ez2TTJ1abnD/JnW2PZjm7P1vmRtCP1aYdna9qgwvql52EGJrYSkv2zaGgd27idtMOPjZ1PpLu5fd22mhyb3pFZaOw6uj4k8FBUSIdHK7l/bcetL320XI+zZ1en45JEyhS1APD6sZ7Etp7/m8MnYNjFwbIyuf9R/04Amt3u0SQ8aNHPo42WyfG7cgPahBoFewlGZTec3JKD6x5/0gukI7/sGDnm8U8YJSjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wew4rF8Za7hToSXBLFWyyGA9/ScFw3twyIEYODStxxbWgcOPZoytQONLAE?=
 =?iso-8859-1?Q?prEmJmAzrCuJdDHRtuS27sVcIcKsEHrp6U71412N1DSAS8PTcEfhkGhbUz?=
 =?iso-8859-1?Q?fieJj6MQYzotk0SfffAyZVOxBbPLSAmJVFPPhrgU0z7THmYJCt5Z0hm4pb?=
 =?iso-8859-1?Q?pUmKvJole49bqj1YAvKMMp84TSPf1oS/TEXrQ4U1VmftLyfPfnlwh3RIzM?=
 =?iso-8859-1?Q?KmvknfMQ0mCRjQwPsWsQqqfyJfOpR+p9RK0roW71rSfe6zvH+GWHTnR0Fm?=
 =?iso-8859-1?Q?EXeDuBjFD9xYOFnh0JlwuAWg8cBGjG0FUXh/fCVGZxIQoaqHFgeTRsQlMk?=
 =?iso-8859-1?Q?j+8Gapl3LBwr/iUrpC611apO9kuK78yzBwaBzAj3w0vajgCdy2cDQv8pqG?=
 =?iso-8859-1?Q?oZHIbEd/3SjKTUNKDVi0BrPwpv2+0QCaNo26OmCn9jQPSoBkWyGrG4E5y+?=
 =?iso-8859-1?Q?fb9LznrHTuV4LDQ+Sf5vIvbvMUo252PcD4ao+RW9ZeeDH5d5hvBGG86KJT?=
 =?iso-8859-1?Q?uiBF3K6fNkDpLIDeuKdbtfSAIuhNzGH0CtY+9DalTxMGhHnnWgsunjP+4X?=
 =?iso-8859-1?Q?B2fkukp90MWPBtJ1/niQHfrG/fTIOVHxnV9makOdMxn3AUBlN3rngQ1Cxx?=
 =?iso-8859-1?Q?M5zl1c0tdL3YcbG95lZwH43VvAUqY4szx2eaRkdYqUf/EZnBX9vYiPMfR4?=
 =?iso-8859-1?Q?4NTjXXYSygfQGqYJpVAcrlpqycYVLJi6xDZGvPkKg78A4glr16dAhDOZoW?=
 =?iso-8859-1?Q?/w1Su5z+yFhfjvoy9rzeP/BIwGfWV+elcf61bisuL1h/UD5j+t9FFL7nz2?=
 =?iso-8859-1?Q?/h/J6pFy8sLHUm23LPH92HWkBadsCV+O0qRFAXqkXnhKljmouhtNHkfNRP?=
 =?iso-8859-1?Q?ad6ZsX6gev73gtJPTE9CXt1BGsVGPmfmXv23DMfzKCHq7NzrT/BwoceA9b?=
 =?iso-8859-1?Q?SLEGXd3ew0YpnK6KPuq3Tld2vt+cSLXPJffzAowsD6GP6EajFItls+dFu6?=
 =?iso-8859-1?Q?nsc2oufZJJE1gj1vPVoEqs13C1vZeRjOL0R9LQnXFJ9pzD8tJ/w4vk7iHq?=
 =?iso-8859-1?Q?/3W3x0rn+Q56lL4w7GRsI0xgqIl/4SlDe2c27vh5djP3akqnqjXAm17NTA?=
 =?iso-8859-1?Q?ACDY8/NHG/gvO+RC781ga6zl1QKtJJIpQ+3uitODOVvX0RjLL0DzjCNHQf?=
 =?iso-8859-1?Q?xuheJP+Xxq8js4sCp93wYxgZ8Vwwi/9smzYRcttzkYLP5AQUULPpfDa8Xo?=
 =?iso-8859-1?Q?ZgMoR+fZAp3d7j6UHTswhiXZEy4TMRS0MiNRiJfDlvh7s3xlPxNegqymmH?=
 =?iso-8859-1?Q?NzJG5R/vCnozea89gACJufmfMXfZTAqupa25IJa9w0nJwzbjpvUQpTjUSQ?=
 =?iso-8859-1?Q?qvYIdNbVlOvtXxr5SfBNXf+aiGjw9jZSyLHPkhcKue/XbdguLC3pa2KBox?=
 =?iso-8859-1?Q?++cXPNuN3uDxjEoo+zcmoKZzyo86wUzn7x4A2kFiGreLp92grarJJNvJJj?=
 =?iso-8859-1?Q?D2Djk/C7jvT10MQxzqajtDMA9SSfZZ8MjKn9PwqTn4NNYREHbOg3DitrWt?=
 =?iso-8859-1?Q?zcAcnTcpbe8B8ohdoMDtDRtbJ9fpGHo92vYCMGh+E0pbSNn6IE8FMaBeHK?=
 =?iso-8859-1?Q?ly+nYJGBeTAIUL3X4aHQds05uNY3OI25qfZ4SOpOVlieqsVL8O6CxVSzRR?=
 =?iso-8859-1?Q?scwFdq8YmOUTtCkSAdAapQXkTaX1xx9Qz8fRmQ8bfsKdyfYNsjSQlbh8yX?=
 =?iso-8859-1?Q?mYwWSAxvNwaLyM+8F3oXGGJqoc6EW75m9oEOA/4oXpZUa7SLwOahxkY+Zd?=
 =?iso-8859-1?Q?qzYCXZ8hUNXx8yg+C350rlMs9TkKbD5cQrMTP7JYssEY25PAcbPG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1018aa-a804-4469-1f22-08df21b2bbc4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 00:59:25.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS0LbejlVEi5ONiDtxkw9vNNXum/0pZ+l/AOPJ+lkYO3bJne+tDQshpakN4r+IWKc9ROFc0TO4n+Yc+ITZcbx9eTbTzmV/YCWXVIurd0DKyy4hZkE0Fi+z3S9zATuAvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB118002

On Sat, Oct 03, 2026 at 05:52:48PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 08:47:10AM -0500, Frank Li wrote:
> > On Fri, Oct 02, 2026 at 11:43:17AM +0100, Nuno Sá wrote:
> > > On Mon, Sep 21, 2026 at 11:12:35AM -0500, Frank Li wrote:
> > > > On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno Sá wrote:
> > > > > On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > > > > > On 18-09-26, 09:39, Nuno Sá wrote:
> > > > > > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > > > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > > > > > > On 15-09-26, 21:22, Vinod Koul wrote:
>
> ...
>
> > > > > > > > > > > > Traditional naming would be
> > > > > > > > > > > > dma/engine/provider.h
> > > > > > > > > > > > dma/engine/consumer.h
> > > > > > > > > > >
> > > > > > > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > > > > > > everywhere please. dma causes confusion already!
> > > > > > > > > >
> > > > > > > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > > > > > >
> > > > > > > > > There some dmaengine code outside drivers/dma directory, like
> > > > > > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > > > > > >
> > > > > > > > They chose to be outside, their choice... They need to be updated as
> > > > > > > > well to point to ../../dma/dmaengine.h :-)
> > > > > > >
> > > > > > > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > > > > > > scope now. So what we have now in the series is:
> > > > > > >
> > > > > > >
> > > > > > > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > > > > > > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> > > > > > >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> > > > > > >   drop bitmap.h from dmaengine.h
> > > > > > > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > > > > > >
> > > > > > > I kind like the separation (and the whole point was to avoid bitmap.h in
> > > > > > > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > > > > > > will ever use dma/widthmask.h without needing the consumer API. But
> > > > > > > to sum things up, what do you suggest for vÛE?
> > > > > > >
> > > > > > > * include/linux/dmaengine.h as the consumer API and includes the new
> > > > > > > the widthmask API
> > > > > > > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > > > > > > include/linux/dmaengine.h as the starting point?
> > > > > > >
> > > > > > > Let me know how do you want things for v5
> > > > > >
> > > > > > Yes lets talk about dma_slave_buswidth, it is client type. This is
> > > > > > configured by users to set the width of peripheral.
> > > > > > So this needs to be in the include/linux/dmaengine.h
> > > > > >
> > > > >
> > > > > Agreed! But providers also need to set the allowed bus mask. And I'm
> > > > > just not sure they need to include/consume all of the consumer API.
> > > > > Also, it's common to allow the provider API to be widely used throughout
> > > > > the kernel (but I agree that could be even harder to get done - if we
> > > > > want to make some stuff really private - but I guess that could be done
> > > > > in a second step or more incrementally). We do also have some subfolders
> > > > > in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
> > > > > include which I do not love tbh (on top of the crypto stuff).
> > > > >
> > > > > I really think something like the below would be more appropriate (if we
> > > > > just want the provider/consumer API without further splitting like the
> > > > > types.h and widthmak.h in this version):
> > > > >
> > > > > include/linux/dmaengine.h - provider API (as of today)
> > > > > include/linux/dmaengine-consumer.h
> > > > >
> > > > > But anyways, if you or Frank do not object in the next few days, I'll
> > > > > take the above approach suggested by Vinod:
> > > > >
> > > > > drivers/dma/dmaengine.h - provider
> > > > > include/linux/dmaengine.h - consumer
> > > >
> > > > It think it is fine.
> > >
> > > So I was aboutto start on this again and I just realized
> > > drivers/dma/dmaengine.h already exists today so nothing to do on this
> > > series.
> >
> > I just find it and start some cleanup/move work.
> >
> > > I mean I could remove the consumer include on the dmaengine
> > > drivers that I'm touching but not really on scope and super important
> > > IMO. So, for the consumer side, should I just go to the first approach
> > > where all the bus_width API goes into include/linux/dmaengine.h or
> > > should I keep:
> > >
> > > include/linux/engine/types.h
> > > include/linux/engine/widthmask.h
> > >
> > > And have a better separation on the consumer side? Or maybe changing
> > > s/engine/consumer/ on the above paths?
> >
> > I go through v3 thread, Andy just said split to new type.h, but not have
> > provided reason.
> >
> > I am planning move provide API and data structure to driver/dma/dmaengine.h
> >
> > include/linux/dmaengine.h will keep consume only defination and API.
> >
> > why still need types.h?
>
> The idea was to rectify the messed up dependencies. Without split of types we
> will need to have bitmap.h (IIRC the initial idea of the split was that) only

There are already include bitmap.h, and use

typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;

Suppose all DMA Engine consumer will use it to do some check. So I think
needn't split it as indivial version.

Frank

> where it's indeed required. Besides bitmap.h there are might be more headers
> that "include half of the world" which should be avoided in every header file.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
