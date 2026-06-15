Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010029.outbound.protection.outlook.com [52.103.23.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942340E8F4;
	Mon, 15 Jun 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541642; cv=fail; b=ic5lR/qoZmTLTQuEn2USoE94ZluFX/Svs3NoPZsvNbQxPkcqn75/uUa4qFBfGWWEbHv+6uUZdYaf6TUm3uwNU2oGgqJDmISdbKM0s2CNpRvLmEZvBO644khc8e452T+dWhbKJghhbfF9cPxoxdJVvE2KPYyNff9p4MbU6pdmBU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541642; c=relaxed/simple;
	bh=/Gu7Slx0QueKhTD3JVZS5Lj+dKRmMbMEgA90rTNJVaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQhQSVHa6cNSqxOTdBmhMmAjuIki3CGhKOQNEHkxq8ODS6ToTnewDp1uJqfyFCzb8zKw/ppdfF9ATCynEuxOQEehjGPJzpKN+dPHkQ4Ni68vpG5iNGb3IQqIPf2IRGZs0tkyEhsKbpyBq01V+g6rH/pqPb9UEmdLZNWkMjZWQhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Jw15lBWU; arc=fail smtp.client-ip=52.103.23.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Jw15lBWU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6VlpYjJmVjNscYSndZKgK8myh4btOVJ6v46Jm4xHcKbYxDc58C7LiH7C4MdyRPsLYCMVHDg7qNFiTqqvI5MEbIJxjVjG+AL78PL0NSBGmILyvp2D3LXkfsQ78WxVbbvPBC3shCemCMIOfVqm6bqQE8PkLrk2aKHdxULOedR37CqnBpWlOgBcji1xC5iCEIk2oIipqrUZxFnd96zDv6JHzuX2GdEO1hU/N60bN5gtwrfV6mRHTsYvBz0hA/4WW+iTDiNFXgtaAj9A5C7o+9f1V7NjcynQil7qNK2rIvGsiQgqc+PdhnXJhaZtJG2L5sZ4D6YfWb1aY9mPQdVVNQggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOtz1SpbiR18IPK7jia1UyCRzWfo+6Bg9lYTsWIpwpc=;
 b=HqFhsQk8tLBvuq5WRbyS/WwELI0iHb/eFU8bHr2RRwXxp+VQMF566AN/SZNccAwY2d1Pz3aYv6+uNGzhp0xPsYvSJvFyD7EjsrEthAhw20Fr9pMaVfH7vlChv37qNMPOx1oTo8u5JuaIei6RV5nxsCjdZcLGu25wJtmuG49sjL8JRJYgVkKnnUqbgmI1+Wh7VQ1iSsZ2yJxk/qHGW78ZXcwgqhZnXjddzeFf0BZvrYZhMpzZyQQgVbXnT/CTqQVqVgMd69ua0anlrxpzbtyD8ROW3EC5GeTWI3CLti1fEkoExlKT34+9Ltj426iZle7aPNNmWMI80bI9ntLCESjbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOtz1SpbiR18IPK7jia1UyCRzWfo+6Bg9lYTsWIpwpc=;
 b=Jw15lBWUzK9ybL0jgdTWToIa75G5rDGR3Nw9UG0/djS+qx2KjhStZ85zb05to/X4THAlOsYxA7CuM1UD2CvCgGilu9xbZdlWyK66K6DTQ47p7IyNZdTNHI/nMIg7/3oB03fQjEsHuLQKGMLA9tLC9pYM4YBcVCV9jmdmNAjjayDRaAv9zk+cGOFbQjTyNoufIc/3S5z9Yooc3cvHsEFRh5cu+jAgPcc84naU/ZB2lmQVR8zYvccQjvG+kK3v4pevSEvwTB2v9+6dOStp9T8PP2XK1XPprqFqmDp+elDuOFbkmwDn3D5jEJSjsbIIJF+PkCWU30I0VNn/MDvdgs3ttA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by BY1PR19MB7798.namprd19.prod.outlook.com
 (2603:10b6:a03:524::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 16:40:38 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 16:40:36 +0000
Date: Mon, 15 Jun 2026 11:40:31 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V12 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID:
 <PH0PR19MB9973380BF26E3EF16BD2D35ED0A5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-8-macroalpha82@gmail.com>
 <ai_gIR2d9fzHLZ-G@ashevche-desk.local>
 <PH0PR19MB997338010EC6FA92E0AA63875FA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
 <ajAVI0KXkx3FM1ZX@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajAVI0KXkx3FM1ZX@ashevche-desk.local>
X-ClientProxiedBy: SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44)
 To PH0PR19MB997338.namprd19.prod.outlook.com (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajAq_5HgHuhnGOdB@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|BY1PR19MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ed54f0-51f8-4f44-99da-08decafcd33b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|37011999003|25031999004|15080799012|51005399006|5072599009|23021999003|6040799012|6090799003|8060799015|19110799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/n+hOTE46uuVSeFGY4GvzvjWd3TK1xGP0cH5Oz7DBXJULEj7lJTcN+Jyemt4?=
 =?us-ascii?Q?tHEV66WZ7il6SKqbchM2uweu6hWW3JE1hM4ZBJ6IKRPVfvken0NF/e1XcVPd?=
 =?us-ascii?Q?m3dQWTQV+o7eRAaNERFa2L5TpM9oW03IKMejFbCgEbO4ZQqY82G+xvoDMNc6?=
 =?us-ascii?Q?FLSQv/enpArldGvlXloxfjkc5rhCHdJU+i4e/+mTSkMP0XZ6twUganjHZlDM?=
 =?us-ascii?Q?snjHCphKSrmwzUaa9IUDirgedMzxWUT1xvchsWC+hPsg+gCQVsPfKUmUYLxS?=
 =?us-ascii?Q?nlpiA2sw5yXyE/eP0ievm0S7RKjxC0IjcavFhRAEa6pVW9AUwXJrwHywbsFx?=
 =?us-ascii?Q?KIfs2TDXwloq4eNBBU2Ld9Gng/aCthDhcChaoEWC2Dk5FqofK+lnc4SsX3n2?=
 =?us-ascii?Q?VCTOlnaf29XyZ1LZBA4Ppn2b5pxbLppfn+vl9KgzEWPEo6HMBy25r5U7LaJV?=
 =?us-ascii?Q?2GkahRaqAA1o0aZfWVzfF5i4jaUfN5yW6wu957YUlbJwf07DFPsxe7TkM/h6?=
 =?us-ascii?Q?DY39a4Wav2E8aTsJuUKEZ+l3Lw0o3SkHwFdu6zehMU6X9CQVYCe0fl3jXqp4?=
 =?us-ascii?Q?pYaYKQNIBGhVcGOigbl993qBbbjJNf5+uetMsW92DwYnziR1POzRPIbQ9PnN?=
 =?us-ascii?Q?uk5fNpXV4McnTG4hDb4jbvqNuKOeEqZwyTL2imxdgJmYuxjr/hocz+KuJIud?=
 =?us-ascii?Q?OVhGChgcB6/I+WCEce8Gl6ODlK/CsvnVOOGsv6CUau1DEFjPGYeI7qiBYvSZ?=
 =?us-ascii?Q?i3KUPzWdXaOC2m8+dyj6MtyQVzNf4kDPlC+O5kGSebRA2RD38laxVYLd+pBs?=
 =?us-ascii?Q?DCh4zxkBWLTaWRLaC0UF17XUAe/myEeMieUMpg+KkQxljep6i9BZ7qBDjuA0?=
 =?us-ascii?Q?1blO1UUK3BkZcVrTMzAxPL3RPg9PSIDMDMqTOh2oCxxkYABEbN7DEAS+FV6f?=
 =?us-ascii?Q?gu/KcQdBE6nRfCI1nINFekbabSBaJEivENsLOtnz2B48Tu36J2Cqsu4PFkn5?=
 =?us-ascii?Q?9z7m9IHc62re5eZtLKfTH54ULnvJvraQ7GX9XrvfqoTHvfkhC2pNDcLzdt/o?=
 =?us-ascii?Q?v+7kAaHA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LONQLHppu/tyb6nPA+ggtDMXZ4CN0zvzehF/kbMEtR/9OIssQjRqPxIcSUNk?=
 =?us-ascii?Q?MzB2HYwRe2E4Vf775gSyU5awUINCI+muqj1K3DN81ZSzd4V1H/2OyXlq8JpP?=
 =?us-ascii?Q?k1aC2NIvLsltCz888yx+5wYR2QLSYKztgUN00oKd29vBMxY8reua13exSWrV?=
 =?us-ascii?Q?X/aX+nRq2+G/y37EQH2jIMqmt7NjmlPugUcksMBguZR9c0BaSFl2ot1EeddW?=
 =?us-ascii?Q?xF+fg2a3NVBOsip/boiVtr7AXbptf52TtTDoSjFF+J0qGw2QOC54oEFwoROt?=
 =?us-ascii?Q?D0GYNfunKOTsB/os4smCdOtLkPX1513I1vB/fYFj0SNf0VpGVn6INCrmM6Iv?=
 =?us-ascii?Q?HwkCo7VCfvk2IDuZhot1JBC1QEUDI0+PMd7oqmEBm+SYpuoLDTYVx+Y4l0kc?=
 =?us-ascii?Q?RYXjLvtbUp5I7VLhc9jK1m8RPATwYW5W6W6cNEtDImTsjGyjPDZJ+Ar65gyI?=
 =?us-ascii?Q?19kGe29NkcroLJ1d9Ocelk8GQrHh41HjY2dhtFkCMH7Dl3d7qP3FCNBNgcvb?=
 =?us-ascii?Q?jAnjrEoylaWuIcYkFd/hZSvP4+KgqoyF5pNrh5D6xkB+Y62B0Al72wxd80x3?=
 =?us-ascii?Q?MiV/EfOgqHRQFti1Ox32V+zLreLQ7LKR4CkAkyvTozCZN5i9AqZXaEDKKxCx?=
 =?us-ascii?Q?A6Wm7k4xAcpLeKPSWYFV8kk0rkII+tHP1E0sC1eTfeBKb9T6yYT7hIdLk6B5?=
 =?us-ascii?Q?f/a/H5gkc7vgHgcRB6S92uabVC5wNZl0zuTobz8fzvdiUUAwxnMDVrcBZEJ7?=
 =?us-ascii?Q?pplWqQL9Jurjbs2/YexOcTbfCCeWp0O06Hni9JlgMtS5EfpssnuKj6wyllFo?=
 =?us-ascii?Q?EbK3n+FDvtxR9fx6d8ZeR+/1qkI+i6fgAMIrkipSV4HhVnm9ZWqH5IEc7MrH?=
 =?us-ascii?Q?jptXIBfhm2+/mzJ2d8FCcRcu/19lr+4f7M4aUIA494vmBEnioK1sNUb9ubzC?=
 =?us-ascii?Q?0ETHYFHnt11bWTpyvvXY7SqTKTBQwovobAwg2mtd9g5SNcLwWiZ1Tu3ZuiDZ?=
 =?us-ascii?Q?q/I9iu4ABiDysHg6JefdNjsBTH3wl6d+Ev3LdR3/1sztG/RxsT7b/5CT4O2Q?=
 =?us-ascii?Q?FPBJn+zILC9rzPQ5txnICo5HUwgFQKSABcx5EencDtokB6UxXa0X0v3uzet5?=
 =?us-ascii?Q?1lwhj4DksvG7jfi1LiLujcZxLdblV+BhvhHM8bToRuZCnQJ9sBpOWqeKnC3P?=
 =?us-ascii?Q?LjvgVvpm281/6g9l0BmgXS6mddRrT1wxB81Hv0WTBdgCj5hxNXroFUXI7S/r?=
 =?us-ascii?Q?YNONqQy2682po0kKwwjN9cujyRWzE82oHJ1BIca3/gELvwStlPD5zYuLrsAf?=
 =?us-ascii?Q?4UeLfSTCSZhWSbC6F0AHM+D8/BqgJb6yg8aBsjeHsRN9u9AuIeZfm8cAbPog?=
 =?us-ascii?Q?xM8pypK71K/2lDy1whc8iy3CfO5Cyne3DWI1zGoEXORzdSYm5A=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ed54f0-51f8-4f44-99da-08decafcd33b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:40:36.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7798

On Mon, Jun 15, 2026 at 06:07:15PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 09:51:40AM -0500, Chris Morgan wrote:
> > On Mon, Jun 15, 2026 at 02:21:05PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 11, 2026 at 03:26:04PM -0500, Chris Morgan wrote:
> 
> ...
> 
> > > Please, please, use IWYU! So many headers are missing...
> > > (Same comment to all files in this series.)
> > > 
> > > + array_size.h
> > > + bits.h // BIT()
> > > + cleanup.h // guard()()
> > > + device/devres.h // devm_kasprintf()
> > > + err.h // -EINVAL, IS_ERR()
> > > 
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/regmap.h>
> > > 
> > > + types.h // s16, __be16
> > > 
> > > Also you need to have
> > > 
> > > asm/byteorder.h // be16_to_cpup()
> > 
> > How are you running IWYU against the builds? So far I've tried but I
> > can't seem to get it to run properly. 
> 
> Sorry, I meant "use IWYU principle". I don't run the tool, I just looked into
> the code.

I've done what I can then, I have added these headers where I am using
them. I'm not going to add asm/byteorder.h though because I am dropping
that in the next revision and replacing it with get_unaligned_be16() to
further simplify things. Note that I am adding linux/unaligned.h for
the files where I use that function.

The additional headers will be added in the next revision. If you see
any other obvious ones missing let me know but for now I *think* it's
correct.

> 
> ...
> 
> > > > +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {
> > > 
> > > Why pre-increment? Same for all other cases.
> > 
> > The register starts at 5 and all values below 5 are invalid. Starting
> > this increment at 5 ensures we don't expose invalid values to
> > userspace.
> 
> It doesn't explain pre-increment. Post-increment should work as is.

The array this references starts at 5, because those correspond to the
values written to the odr register. That said, I do see a bug because
the odr register is from highest to smallest and this array is
backwards in the accel and gyro code. I'll fix that.

> 
> > > > +		if (i == odr)
> > > > +			break;
> > > > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you,
Chris
