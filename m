Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05D407563;
	Tue, 15 Sep 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491915; cv=fail; b=Zrivck6ZyTttP3HogC2xPSKPI/N0OLVvUxXkN36eloUDwT8WAbym2LasXd1YS9Wd+lsmbLi9vx692wiV3Ijw0RXwG+uRMa69mmWZVy5PVwc6nwXHAOeCVCz/jegWVhL/WIl/prZl1pQG7SUmh1y+9IF37WXtJpI487v5TN2AJPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491915; c=relaxed/simple;
	bh=yxIyHhUXTr8LL8o1N8ky5fEy0SkNFblriO8jx6WAoVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dxn0qmSKi8YuaY/FQLe9KzLYSInjA0HV49K17qXCD8IbtIt/NzdNgAud1MB/MOzCHpXfAC6ozMOexagQY3fKarmilJF80fn3+0Ke8PJC/SQlNkVk2c3rD2oWj4DJ2h+fd6LtpkzsjIfK6QbQ3Jv2oD/xlVK8A3sw8qe/7wSV62I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KO6gY8og reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KO6gY8og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU7KaV7MJYj04j/rt8FFnKrAGgkk1y9WfObYPIkw9AF7sXqaA6ldIp+MlDyJ9C+R5FlT6cNPQbCRm9OdSo2c3x4hKV2kWm1xs+6uJUHwl4Pv/ykUejDmFrmtq5hy+fj1s51Y5mtnQ/ZlefFuFj9yNSqijEEaFdq2REctNKYj52KUBuXObl+4FdeEH82fihUl5jfJ4EXdpoyveVsY3tgqplFeMS3WfXbKohdZGnCIHmlC13gg0kO4Tz/5b9x8ZzvcsKv23Dh19PBr+TEwNGrapUxO3ar1zSzyLnQWGJcqZN+VhZiCPLz8EjgpVXUujnEsfFOogHiOGbQAWkwpTpmZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIr+x+FsoijVTeBTB1ksZwk6B1eWqV3q4LaR1L90ebE=;
 b=w/LHDC5gnZoIsMrIxt4sIYTN8yaSpsgsv73SnQEOb2EM966C6KMB866JTGFMn1E8D87aQKFcLtL6ejDpNT0eCed+/LVHgev55NE850a5lDbXePfjfMeuAXKR6/OXM3n0pboxjtbf2JEjmOK1ui3eXh90TH134Ny6Kov7I1HPDOAJg0uvE8tdweDR8mtUdFRekCkxSH7LcZYVL10eaO+sFHsqCljvUqCeFLIpo+HoIYYQESzbbFL3jZKZ4h8jWE801KpVzp/CRB7IoLK2fuEkZgW9fRR/F+s6gkIyRjlTxehoA9LcRdb/wHWcR0Z94PB3PTYbkySQqOv0voZd0Eng9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIr+x+FsoijVTeBTB1ksZwk6B1eWqV3q4LaR1L90ebE=;
 b=KO6gY8og45hzz3EwqYKRB9oRenZsuflMrnAV3YuzHFKjqUrKeqU3cbENrq3DSYOq2c0lamoNMCsmey/Z7ZpSL1FgbLwoa+3dFF9mH4GoOmt/qgVpWIHR/7Pg/TcBEPgAtarU+F4lQCS4HaId5VRmuKZAGowoO0wW1CnOhoWakYkmDyI04wuVM4GLK7Cysl4dw5CGknqNStwPSL4CJVOM2TEdIdDYU4X58S6bDwYqYSEL6nVHpXJyp7/ZDfigHjicECHjPiJiuqz+IeMDWhvbxrJbPL+QYcLa4CcdKi76tY6ZKUgQY8cMrNB5lrXFs7cOWM2nToEYVEI2359iWjC6MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8458.eurprd04.prod.outlook.com (2603:10a6:102:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:05:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 17:05:10 +0000
Date: Tue, 15 Sep 2026 12:04:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
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
Message-ID: <aql6u3T0nnSVr-FC@SMW015318>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlwRkNcs_UqKjWs@parshuram>
X-ClientProxiedBy: CYXPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:930:d2::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 382fc4b2-375b-4030-5985-08df134b7fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|376014|7416014|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2N7Qh3tqbmnH5+jRMXqd4SqSZtRgrJtgPRFPPTooSSw4fWUO4V+era9JOmbJ+KB53pNTFNUKWQI79aDoKMvRSw1GDH7pwSk8aRg2s2FGmWMqtORf0/qew5z5xFCO2uAghgUYYOBQBIG1o7lJwPsOqvO4pQSxfmDxyoi3OkEYpvOmDe69v9kqPwyFPlEahy5ctORHmI/w7aztxLmnnxDCb76v9KhnidFCuguyUFtWca2pbXfD88r2IIVSZXOB59ezelzzJmJ2PhRKFkVzZwcZ0QyoOrCLD1obYAINRdhmNDaGjwJ/fjnYd1Vn8jVWPSYiIwEOcamZg3OjLaaM6HT6V7nJ8JQrohBCau9FfCg5xAr6JoL084JclSL9bPGBy/IFzeZ9IuOTI92MMziQeQiiKQ342XlpKMywcS3OlP7nbSPg2iohKgWcvQ/5FGfZrj5gYabffXxx/m9/f9zuuFaqVf7gComtNu1zAl9Zo85+edlyqKWzCOnfLW89vLkRSAJGtJ91ohHKpCqNsxglk1gae1Cy0RRf+kpQxovZd+rtBIdqDftrOzQvRUdkFZJpUHAfKrmpxpbyLAnUOaExf77l2ryP0V1ggXsPj6BiUYWt912Ru1ZTSC4ubgGolRiLZ+kWYoKQc4M41iMOxQsSUKqGEgW2imL8zNfyhtuYYDD/AWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(7416014)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RplA4Ux3njAN99D9jS9IFAimoTLQ8dcuhcO1pNddi2xp5ZqG3ci8wrHhjI?=
 =?iso-8859-1?Q?Ejju11w1JOuUWhmurUx6kDsctPspLzFfXShXqBgg60VCYSgaejBpS18sIy?=
 =?iso-8859-1?Q?NE77Y/6ETqRZVgUsZIOIm0qOeqEM1iPHeW3jlHZ8lekl/u3EUTPMzWXTrf?=
 =?iso-8859-1?Q?Ve6R+xPrRgFT1DqOBTgd481fMGyRDypuLAJKlLixrmj/GDpNuQ5t/lhsYJ?=
 =?iso-8859-1?Q?1xeGhZ7PhR5/ZcvNnK9T9B/v5QWLLB4kpLDHvFcFTcxpahb3RcSdyy++Zj?=
 =?iso-8859-1?Q?8FF9IX4bNF1G9jLsORpypqJKZhxXKtiNfhHxbs6ZE8vwLwx17A7ECkpl0H?=
 =?iso-8859-1?Q?yv4Cr3JRKCMByJdE/Fa689hHHitQSDR1ATms48lXlFxqRTi2YnUnqT6nmp?=
 =?iso-8859-1?Q?PWYz9QjmRBhp+Qp8Ks+8pjorcxHnOx/uywRItxOPPSDm6wtoKY/2e0vRDW?=
 =?iso-8859-1?Q?WE2PnsXYmYKIVuLstoRrSf/NgiFwWxlhq2j7C13db1/2ynYy1eK8dUZBMY?=
 =?iso-8859-1?Q?iFMVwqVF7LGFtAbDT9A072hPDhEKyBCogxPGQZK66W0knBzpWrkUr5tcY1?=
 =?iso-8859-1?Q?kz/Q3d+PAvZcdBkig5JOtx5BcK9tCqbq9uHMIy1hw3m6X4kwhE1cF6I+YC?=
 =?iso-8859-1?Q?utN9qUD2zYNAKEW3Qa2Zkjxpkwft0VbCgnEVWFP7De0iXjjOyDHXZF1/Rz?=
 =?iso-8859-1?Q?4VW2ucJzFPmNUlZrR6QHKwG52L0uwxG7XM1i0LmPJ7Pf+SJIxmexRdQvrd?=
 =?iso-8859-1?Q?6Ta19akvr2pQrkOpmOHj1KP0NnBmDPkTVtYgf03XiVEplymQgkwimlPzdo?=
 =?iso-8859-1?Q?o3YoDq2YuJvPH7pmLs5yhSdYMfVvRIKd4tftihec02ty6Cr9nrGIwvNSN1?=
 =?iso-8859-1?Q?ZAHQ857bQB86NeMUBwP5Wk9t74sgMOtk0RKbYrsLjp+Y8U7Mg8DEryC3VA?=
 =?iso-8859-1?Q?vPWlvXdvlnzJhWsApl4HO3JT6hFW6O/b9DKDbIy5ZBFatRk4rTLAgnngml?=
 =?iso-8859-1?Q?8zijax1yv8Hp+WsmDxEy7kfe1fMdCeP+8JGobVBS88wiiVn2HvbU5rzVZj?=
 =?iso-8859-1?Q?C8mwLByREyjvGbNrywel9oFYFu9SU+aNRYImcfDDDXLmTIlBTjtkxwCuf+?=
 =?iso-8859-1?Q?v7Fmp1UPENJx6w256tpVQX0OtI6n7dq1sHN4dX554AoNL5giL3Zc1bVVM5?=
 =?iso-8859-1?Q?kjvGIcpz2epz/LSF0Ed8DudPGUiLg2q1xkLd/hi9SS0KK2H4M3QwQPSh08?=
 =?iso-8859-1?Q?78PO1Ylaoc0cEzLzJ2UD1/b3mOAPrCwMLI7fmS+X0CkK6dPOKpHaTzh1y7?=
 =?iso-8859-1?Q?WyiJGf7qt5skkK3OKm5hzva/LRQXv9G1fjUVMJIun2E0Ovj0gFbSuxHY6E?=
 =?iso-8859-1?Q?j6sPjacdv7DAHA1mnY9/TgGnH/6hDHjMvuhs0GEJYlc4MCtsv+g1B0UQh8?=
 =?iso-8859-1?Q?GAxqj9+l+wFs3zOglmX/PBxfi8RIHzHTFkHAL3u+HoqyPRRIRx+esZxNSY?=
 =?iso-8859-1?Q?5LyPfrwvrAggnbuT3ulbDhzCcwAL2QSizIN8sJ5tNVR7+CRrqSPat/6tuQ?=
 =?iso-8859-1?Q?E9dlmewaOUzChRYktq7nWCZySDML1UFZf4AOZyzgqRJ2Fi+YuJyN7TKO1A?=
 =?iso-8859-1?Q?C0PtYzf4p6beVzY+ME3mS6N0b8XhA539X0Ltceds/W9NB8xXsnd+p0uglf?=
 =?iso-8859-1?Q?WVGWWMAIeh9QSb6S3Af5PS8pJydX70PttwRf2HUjy0vpcLRvaSQ4WhjhyD?=
 =?iso-8859-1?Q?sGKzDQya+56He4Gtbz6vgWhmhojzlSL+GOMJWhaVtbVzMp4suMmgYzSub4?=
 =?iso-8859-1?Q?xXyk8m9dwbaiNFnd5E2Qy/Aw079JWDguQUrv+PfDeS1WnTina6pH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382fc4b2-375b-4030-5985-08df134b7fc7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:05:10.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+lFio+7KouomE5TXoYZwkCL1iAnYNWgiGuy6UG96GPBAJdjyfN7mzftxzLzajvy3Fb5xjir9rCqZ82wtuFeMmJ2B1QVFfHVR5WAFyrjCQLc5UomlAuPQY7NBlv3s21Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8458

On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> On 15-09-26, 21:22, Vinod Koul wrote:
> > On 15-09-26, 10:29, Andy Shevchenko wrote:
> > > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > > In preparation for the bitmap based bus width capabilities, move
> > > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > > include/linux/dma/engine/types.h.
> > > > >
> > > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > > new interface would make every one of its users pay for it. Keeping the
> > > > > basic types in a separate header lets the new interface live next to it
> > > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > > users are unaffected.
> > > > >
> > > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > > already opened with /**, so kernel-doc expected every member to be
> > > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > > in particular, as its meaning depends on where the value is used.
> > >
> > > ...
> > >
> > > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > > >
> > > > I think it is good to split dmengine consumer and provider header files to
> > > > hidden dmaengine's detail.
> > >
> > > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > > I suggest to do one step at a time. Would it work for you?
> > >
> > > > suggest name
> > > > 	dma/engine.h
> > > >
> > > > so we can start move more API to this files.
> > > >
> > > > after all user include this consumer header file,  old
> > > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > > which only include by dmaengine drivers.
> > >
> > > Traditional naming would be
> > > dma/engine/provider.h
> > > dma/engine/consumer.h
> >
> > consumer and provider and good names.. I would retain the full dmaengine
> > everywhere please. dma causes confusion already!
>
> Thinking about it again, drivers/dma/dmaengine.h should be the provider

There some dmaengine code outside drivers/dma directory, like
drivers/crypto/ccp/ccp-dmaengine.c

Frank

> and include/linux/dmaengine.h the consumer header, things can be
> arranged into these files.. I would say whatever is not used by
> consumers can be moved into local header
>
> Thanks
> --
> ~Vinod
