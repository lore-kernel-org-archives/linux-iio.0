Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EC4AD4D9;
	Fri,  2 Oct 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948851; cv=fail; b=Js8FoBbLldGU3cNf8L5E79zwCfY7+p35WftZJGrsjkAMyb0NMGKhjJfWOP7fYSrpj24XqISNIvYRuieQR06zdZp8MrKn2X3JW7BKwoyxoJtGFpTsAQqdNMsKJ1Ws0uFJHg/PdE4LInbxJb9MlnTjDaQovUbZQ9761oaocF+MrJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948851; c=relaxed/simple;
	bh=B++vhrdB4dZgogsBGio+bXlCtnN1T6Wb9NuZZkvPrmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pj1X/LyEXDJ2Xb3ElEounVHkY7GBnGbfzwU8prgSO2wNZq7N5YrgD1cPuUI1Ph/1K5Ff4KXhi2VduSyfhPYwdIT6rxSCpBvLRhtwhvpi/ph2bdnypXsSj+h75k/Ac48TTXIdA8Y9NzJt8JE3pKNIOySQKdEIJqgWTudivQrtxHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a6ATuoz/ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a6ATuoz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU3tm1tyYVxrCPtpyawm2DbzxQ4gjXE7d8/9gbORsbTGBpwCotsTrgD/oKhRJI0d45gM5Ma+KXL8WyJLyGRjjsDIPIdrlRpITm9ksMEBkZexwkzD4af1a2nHoJMhJStmDmJ1J0lG9j+DQXMdW4n2b+HW4e/YStj035TwwqW1PbF3h3FPe4F4mDa3PhCjBj/vvHIrxxVJNJmuu0WIB2fN/CUr1ei5QY0QWlclGKjF6+jcuHTKfLaVFHKFUYY2TH7NxaQgSRKa3qpJb1CFYrA/iP/aT3VAPsGBlE0e7qSqfpsaB0ebgL8ZThewElHOjUAa3kwWI57Hw8pEfhGKEbKNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvv5uR9wQI8hrwSg7KrIDW/gBWyHMhZT3fjc+6e7l2E=;
 b=OgU87U4aLzohV9HCT8nY/wGB2Qwr5OP3FFROAD7JZ42O4Cd+AYuGmsWFzI7PlWTIEveIPC2ZTBzfRqhlJNu+RISu0Zjh0x4gAND8jJDd/ggOQqw4/S7obhCc3Ii+yQevhCtWAXhXmQ+hKxuyl4JUoJjcMVDalT9/BgTclpfxp1Kn6C8yPU9/2RZw+C79CwbRQhxqRWrq8HXBAV5+cN3YGqRtvSmOt/FtPXqg52wtj1ssS4gdpBHD11rzEV8cDPZVneLGBRmugyt1kmfZU9Gtyuj+5Mk1hMRnH+8mLsndoSB5NO6Cr3qxrduWJyfpz1SG8JtX3ikkanEgLigwrStcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvv5uR9wQI8hrwSg7KrIDW/gBWyHMhZT3fjc+6e7l2E=;
 b=a6ATuoz/zcNQ80BFhv9U5GBS4l702DBtzWm69gJ9fHQnJndPcrxuZk3TtUqaQi8JEcu4VdsM+3vYIWp2iM5Q9vyMRXiHTUtyJazA8iVWAwQ+9kwSGx2xfOo8CWomtoVAHUOPnRH9GIWPF0hIbZVNcWt6ZrdR2/sdncXwCWxzplXpk9qVT4WcsoROcETac61qGlFLZFNiOrgJENAH9cu2EN6hanKLjWjmmxrgZNyefW1xDrJqaEFPOgYXb+2b+Ied8EYGIg+wAapfjcg0AcjeSfSPdpJ6B7eaJ8AISMAtvTH+au5r15yK7smYHvZbproUcUd/iuhjwTNBQ1P4jON3YA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:47:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 13:47:22 +0000
Date: Fri, 2 Oct 2026 08:47:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Message-ID: <ar-13p3a7ENGfMOF@SMW015318>
References: <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
 <ar-Il2qP_Qms3Qw1@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar-Il2qP_Qms3Qw1@nsa>
X-ClientProxiedBy: PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b938fb-cede-407f-749f-08df208baf18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	VaUFosvvyyCSoij5pZn5FAz8c81rDJ1zxzSiyyrmhKEr0BxIhSsCLSX2Hyoo6XVCkDHcLaIH5mL7J3DqIaKvBPGaKch642wTZbZPh1qQBQ1RwEvnmFq5ezKiamcbH4MioqENYSvNr2DL+xQoXjqxwLaPevKj1hN/hJj0GgQMKsMUc8oEEYOyWVhSw4lv9EXzedxI3E4A0Om8g9H1BTnZV310+lnG1QqkLk2ITjVcLjrNlgRcDrwKgG0Ms5o4t2o5dpYAkr8g1uUJFPYqDcTw+aAwH7ASpsBz+oDBqOZpGwNDl7doAYV+tzhUH7RrllN6qJbz4z/r8kkx6Pr6SlMOvsm3ZGNoYkW4NpunjU+M6xp9w7/W/0f0HNooeYqO4d10O9FJWoPFm8Rfsf56j1Lz0yUbi4AhgZnXlCmMD+DMLPuahuyLtE1Xm9VnylkfTeXCmIrdMf5UC7FAY6q5Jmwg0W33nrhmUXz/wDr08m2N6LH+aVfQfPCSUkvSjsLq3rFrXBvE7vz1Yqn7yqWCw8LIgrlYR2SHqCAIh+MEpMJo/TrljE4aGJ1mcb4pNimAsdTena6qkjXWIWAzHJBK7LU70JrtFxfkSlaxEhatyqZ8TlOweMDqUZyCOuz5s6bwkMojPLQR+Qdel5QJu9KMFHOR4Vxq6JLa7pxaA/pYEMQtgbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?XV/3gCP3ERW//7THfs934M0LVBrNKQ62ZmlCdlvDcMVUAm1Y7b6XSYRcR7?=
 =?iso-8859-1?Q?zUwbIqluZ94gP2ywNSHB6184pkL2twAYKm/K0jVHOgqj9ms5H6tFPz9LO0?=
 =?iso-8859-1?Q?e6axFE4ZwYGqPajNpsJuTqnHohF+1hebywRpcBayKcfDWYAXvhL5pjWgYF?=
 =?iso-8859-1?Q?VHPPKAUTSNfZ72WgPu2SdgcGkjH3hVLo5JhJd/6b7ZFg9t+dF+uGTTDwo8?=
 =?iso-8859-1?Q?wUiCkemU/pY4x9dj3XkIdlNlUCrNEMD64QZUhb1GdvZS0enzUmckC7vxmL?=
 =?iso-8859-1?Q?iMw+8aJy/Q9NmP6Yltz3y5HkUWZ3cJOGxfDqns5i6Hzth9bX74Bdm69CgK?=
 =?iso-8859-1?Q?BSFdlr1ICR/lTfdI/Em75rCLFocAs27F88jshr+68wczYDw+aGR2XBiELy?=
 =?iso-8859-1?Q?A+o4N1hH3j8hwPgWaCcfAGPqpKfAOGw75wJq2ocQ7tlNiZ0LN7wcPAfzxS?=
 =?iso-8859-1?Q?XhgSFZ0DjJGr+yIoBQ2UY5vnqgzFoileOYPewrot25fwW9XEIczvzuxuYm?=
 =?iso-8859-1?Q?DGia13Ojpkn0QmR/3yrineNlR9aGs67dyxDnF/6PV0K2PZjMSHWdQTIutL?=
 =?iso-8859-1?Q?9sbdFqkqqnbDhIvXmLAbGwIwaZI0iMYO/SqR/yZ5DmOqXwW4dkk9XOXFp0?=
 =?iso-8859-1?Q?2d/hG20sA73XYW6dH5DbxzAAMGRaOU6FDVsi/zv8rapn0D4DwbXTOMNds8?=
 =?iso-8859-1?Q?J/PznehieCZqDB7ZUDX/cjFVVtMC5OdYjTMjunJ1OS0cRdKFVlc069nXOw?=
 =?iso-8859-1?Q?dTIqSt9xIbsctRor6JtV98AylsOhFFnGmsxbO/nayWjjzYOBHx5mjO1arZ?=
 =?iso-8859-1?Q?j7CqhyzTNjyHd6PmP3OyyIzrTfOkyOpVmYZtTBrWhdn7Lo0KoUXZxLuhfd?=
 =?iso-8859-1?Q?b4RyJsm6uJr87FjulCH951PB63XvpGEKuxgcdDKbPXVvNlzb2yDDDl+pMr?=
 =?iso-8859-1?Q?rzAgX7VPzyWrJRmZYYu1UWRxBiqyraCRXYd4vbHdFfh7Bt35k+wtDWIpsW?=
 =?iso-8859-1?Q?KMjwA85faGGhZzIPMMtkrZiBPgJfmEylhGaIPGzt888hJP8Z4zjelUhdoj?=
 =?iso-8859-1?Q?l/bN+b4tJ3l5aadH3XC24tCQ5oJsp8ujQy2HR+C6jhUwSuh3Q4DuIha29F?=
 =?iso-8859-1?Q?QFrJ0K4y2p8tUZRQx/hIZ7EQcfhkTkOz4XHbK4ksjCXB9mrL3OKnHV1LOw?=
 =?iso-8859-1?Q?aQN+VMyi1F8pVWA0e5E4EWZMj46H3W/JKTEcRX1iifoE2DhNTuqPVvt2RC?=
 =?iso-8859-1?Q?FSZ1uBqMzHQPbPlrZNcUyeptaa/rJA1QGqyB8NPM4k8w5/yVdQZFc8/lL3?=
 =?iso-8859-1?Q?Ts5OVvzz3KhFonAkEoTdu60hje/1plLkF8sZRWaDlSo12Q8DpC+uz7u3ST?=
 =?iso-8859-1?Q?GCaqebNroTe4yFWGxSmH2ZG3iEVv3Ai26JI7Gs4W0MiS+ZGTAOO3yCUoEP?=
 =?iso-8859-1?Q?pFeyb/RbmQIkJjyrhdsSBpZeDNW5CSIarjOIUoUUZ52xf2IMkiyw7yfrn3?=
 =?iso-8859-1?Q?i1pZ+6Uad0T3CAeFzJQxRPCENkC42eSZnYlK61fdjquJZxpAV865aqcz9A?=
 =?iso-8859-1?Q?aBdolTVpAxGUHrUblnp9a5aBpsqQtwAnQ5fr3J867K6zLZdXG+RcY1RzMk?=
 =?iso-8859-1?Q?aI4S0oL7dddsfYyVRjN7G3BP6oDATNuKnfLFDdsr+MezB4GW7rlDSKlUrx?=
 =?iso-8859-1?Q?PyinxOo6bVHGzqplgpGz1pTqNuE2KlL0aT6imyymuc9UcSNtvO+5tr7M8R?=
 =?iso-8859-1?Q?1P/oHgC2mW8u2eja4Q4cOKCwBZKAwzj0apB29rO24X29SbM59HnwxPs0uL?=
 =?iso-8859-1?Q?+S75NZYLCiJZN/i4hMBTIe0nsr8jS/9fvwyPkN8OoFz7MEgGKQLD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b938fb-cede-407f-749f-08df208baf18
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:47:22.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMOb+gu7wK9wgI52DhrE5ehPBp+NwAZUgqBjsf/PEBmzHihmjEKwHFpIbeCgtnr9FS8PgF/KCqfPwxlxpBMhsoQ2hsWaT2zPTKYv4KQk/rvnmr6T10nxqBsrN5ngku3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597

On Fri, Oct 02, 2026 at 11:43:17AM +0100, Nuno Sá wrote:
> On Mon, Sep 21, 2026 at 11:12:35AM -0500, Frank Li wrote:
> > On Mon, Sep 21, 2026 at 09:53:49AM +0100, Nuno Sá wrote:
> > > On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> > > > On 18-09-26, 09:39, Nuno Sá wrote:
> > > > > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > > > > On 15-09-26, 12:04, Frank Li wrote:
> > > > > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > > > > On 15-09-26, 21:22, Vinod Koul wrote:
> > > > > >
> > > > > > > > > > Traditional naming would be
> > > > > > > > > > dma/engine/provider.h
> > > > > > > > > > dma/engine/consumer.h
> > > > > > > > >
> > > > > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > > > > everywhere please. dma causes confusion already!
> > > > > > > >
> > > > > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > > > >
> > > > > > > There some dmaengine code outside drivers/dma directory, like
> > > > > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > > > >
> > > > > > They chose to be outside, their choice... They need to be updated as
> > > > > > well to point to ../../dma/dmaengine.h :-)
> > > > >
> > > > > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > > > > scope now. So what we have now in the series is:
> > > > >
> > > > >
> > > > > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > > > > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> > > > >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> > > > >   drop bitmap.h from dmaengine.h
> > > > > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > > > >
> > > > > I kind like the separation (and the whole point was to avoid bitmap.h in
> > > > > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > > > > will ever use dma/widthmask.h without needing the consumer API. But
> > > > > to sum things up, what do you suggest for vÛE?
> > > > >
> > > > > * include/linux/dmaengine.h as the consumer API and includes the new
> > > > > the widthmask API
> > > > > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > > > > include/linux/dmaengine.h as the starting point?
> > > > >
> > > > > Let me know how do you want things for v5
> > > >
> > > > Yes lets talk about dma_slave_buswidth, it is client type. This is
> > > > configured by users to set the width of peripheral.
> > > > So this needs to be in the include/linux/dmaengine.h
> > > >
> > >
> > > Agreed! But providers also need to set the allowed bus mask. And I'm
> > > just not sure they need to include/consume all of the consumer API.
> > > Also, it's common to allow the provider API to be widely used throughout
> > > the kernel (but I agree that could be even harder to get done - if we
> > > want to make some stuff really private - but I guess that could be done
> > > in a second step or more incrementally). We do also have some subfolders
> > > in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
> > > include which I do not love tbh (on top of the crypto stuff).
> > >
> > > I really think something like the below would be more appropriate (if we
> > > just want the provider/consumer API without further splitting like the
> > > types.h and widthmak.h in this version):
> > >
> > > include/linux/dmaengine.h - provider API (as of today)
> > > include/linux/dmaengine-consumer.h
> > >
> > > But anyways, if you or Frank do not object in the next few days, I'll
> > > take the above approach suggested by Vinod:
> > >
> > > drivers/dma/dmaengine.h - provider
> > > include/linux/dmaengine.h - consumer
> >
> > It think it is fine.
>
> Hi Frank,
>
> So I was aboutto start on this again and I just realized
> drivers/dma/dmaengine.h already exists today so nothing to do on this
> series.

I just find it and start some cleanup/move work.

> I mean I could remove the consumer include on the dmaengine
> drivers that I'm touching but not really on scope and super important
> IMO. So, for the consumer side, should I just go to the first approach
> where all the bus_width API goes into include/linux/dmaengine.h or
> should I keep:
>
> include/linux/engine/types.h
> include/linux/engine/widthmask.h
>
> And have a better separation on the consumer side? Or maybe changing
> s/engine/consumer/ on the above paths?

I go through v3 thread, Andy just said split to new type.h, but not have
provided reason.

I am planning move provide API and data structure to driver/dma/dmaengine.h

include/linux/dmaengine.h will keep consume only defination and API.

why still need types.h?

Frank

>
> - Nuno Sá
>
> >
> > Frank
> >
> > >
> > > - Nuno Sá
> > >
> > > > --
> > > > ~Vinod
