Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82C317153;
	Thu, 11 Jun 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195481; cv=fail; b=Q0nil7PbmlGv+MjVJGXEto3jd43kAEpXq47V6Cjq7xy/5GHXv8FS2t1TBfkYe6hIrHoQUK1ZQViW1MwZSc3962CPmy1htMiL5D++Htt94fcode8SM1ogAfW+M1cSC3ZsTaUZDiiNEAPPaeRfEXja5RbtjaYQJjBy9xLCvHJsEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195481; c=relaxed/simple;
	bh=AAb05UiF1O1V/+i9L9k35fcWhUD/LeXv9GempEFZyuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E2JMQp46gznZ/frVFb4kyoRR+/SXTrXt5yeLo7bqUjXEErbCUf29WlZvHLgKjXzmy8NJjSbnuN5qaY+ZK9OvsrfAMTOjqpF4gZJ5dL4i225rptvpp7dbGaSEloQo0y1L8ZuUg17SFYGjQrqDlKMQ+ov9e6wWSzfRV1CPCRlHl7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dJnRElzR; arc=fail smtp.client-ip=52.103.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dJnRElzR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9xX4woNOmRgVHQ+Dv5n02ybEg0zETCQ+rgnUubTNF3pHlRAA7Xtke53estECzCj0MEhUVsC+Re4W53g9Sv1maCJMTt1o7Nb3w1p9/FUETGNWgD7j6zY58xPzmcwVHGkXcRgQvh2DrmFf/l1i9NJoqvL1KKK/eqI1oX1Umpk8+0a+KlRTPcNtMd05E6uuD4XNEx0npkIrSBSn/0/UX47K1MIgw0sCX6VL48GzhAERgpwLwHi/Yp/1P+qSxWIoQUMJ/AC2T4rQZDtMBQCBxeROIsoJ6OoDIkPQXVkIYfJQJop52sy7yPbuIYD0XOPL8/cnuRaQ8eclV8Vrj5VVe+pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6TYiCOctCDVmF4YvrSLo01S81vi3qIMk4pbW8MS0YI=;
 b=KZmGUJOugsCv0eq1WJQu42NOzLE0i3Mh7QiqufUTvN+LNpjx1qvo9Kd+6zAGuwEND63G/IpEN7Zr/rFN87mRoi17ufnw4tBWbz9LN9C3OjDI3f0/VjqpRAvDnHhcS7eFWuG0HrRQNNsVmL56sQZwXR3aGxC8JP4tcYRjn9rem8xnJ/lFMszVG1XIR8wTO6k7FDYiS0Z3pW81hA8S4OvuFsIE/TYbJYVef/eeADLvwwfnWD5Oh9V9X+Ai6gf5NYDvguRP4sb3cNqyaXditpPUs+OD9R6fvnxP8y2i3m4yqccZb8toEdFKs/eHTlyPSG+B5aEu/VcsrkkElQytti8vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6TYiCOctCDVmF4YvrSLo01S81vi3qIMk4pbW8MS0YI=;
 b=dJnRElzRdn9gxTBqVh1veXMTEKxLaDGaJzmAdPcfwJKbIetFDmldZs+2XMaC1p02WWAlTIBGLRvs/JjVuTFOQy5VzZjXdw3DGPt9XHnEGGUHjaF+cKdphTVPQFbwPiD135oL2IBGKBoAp5WvDw6ci6sB2Q2UpKVZxszzaqgNz//0w1eFHAiKeeKGuL6/f2dXF8tATJH2ZRqCuxMC4tkNBe2YF7DDyzi/VYBetQ+pkgYXqg30pmTN/GLESd1yhQKMjLXuaF6toE02a0PdVWrh1gCs9N6Hhg8B2PvJ/XNSfoVkgI1JHzfgSVOA0IVyUsr6p+dZibiBiUJI9ySieVP5Zg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SJ4PPF1F6CB6F4A.namprd19.prod.outlook.com
 (2603:10b6:a0f:fc02::a0e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:31:13 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 16:31:13 +0000
Date: Thu, 11 Jun 2026 11:31:09 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V11 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB997338CE11110E16E7FB668E3BA51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-4-macroalpha82@gmail.com>
 <20260611120943.7119975b@jic23-huawei>
 <PH0PR19MB9973387E29375D4E8F28C6B9D9A51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260611172022.4d138820@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172022.4d138820@jic23-huawei>
X-ClientProxiedBy: DS1PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:8:44a::7) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <airizZ_fqdrRtEBt@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SJ4PPF1F6CB6F4A:EE_
X-MS-Office365-Filtering-Correlation-Id: cae996ef-0992-4950-b60c-08dec7d6da25
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|15080799012|23021999003|51005399006|41001999006|25031999004|37011999003|8060799015|19110799012|24021099003|13031999006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cHRE8hmcpSfOYQRvMdRexjweKv13QJ8eGHjevj9mCS/ZupYPjVmZbuRSdOek?=
 =?us-ascii?Q?lT75NV/8XGI8E/K44u9zpXjbFPq+nNVNkAddeCxAZbF4ToPD0uHfY40sCcwJ?=
 =?us-ascii?Q?D44xqlJbCgCeRzWeZhauDr3wVDHKROspat/wLV8wqwDCdTNT8V1r0t7t+X7b?=
 =?us-ascii?Q?VAXaiXeaJQxtqIPYYqBoPvFJcSIiSdfko9k4DpcMBRO57jlVhV4EHUD8Gx0L?=
 =?us-ascii?Q?Snd4bQXuhX7+QFd1H1PW3p3xpAlAyW6JiI8tjHPQRv1H0FneCcgODLmeNV2P?=
 =?us-ascii?Q?FM7gTlhKuGCH4bh/fmwm6vej5NTTqV73iLGExzKBMGj4pUgBv9Zqm7Cyhy7I?=
 =?us-ascii?Q?xUQBrjlaV96fVeG/Tq0jbIBgUPnb08aoDpbII0rDuoIGWYswIxx7PCffFJ8O?=
 =?us-ascii?Q?7XUTdX5wJYFhkzBprBHmHA17jnL5oNkKSaAv8AvV0TqKiaV6b3J2JmAd8up7?=
 =?us-ascii?Q?2JdkyNbnToIViwg4v3wIfA005gf6//t47lXi4yMafVhDo5n9YBSnBqyUaTRD?=
 =?us-ascii?Q?0ZjCbTRHjqUFZjZUUcFVdFrTHZ1XD0zLs36OvBmftbPtZ0re/YnTHDkiIgzH?=
 =?us-ascii?Q?uBh8BNRnj6R7E6VecHhBruUupwbs547apE4PA4yxAzYCJmawDIZZWtWJLvS/?=
 =?us-ascii?Q?mqizvrPT9lSuUlLulxAdmp6Lsf004aJMcBBBoxTtyqFGAaT0sQ9cmpAJHAp4?=
 =?us-ascii?Q?Xfml1qEyKSR1IHgi2uSQOOur06FB48r7Rm9EKQJB0YHAKpJWG+XmQjP95u36?=
 =?us-ascii?Q?GAL5P5YGzO/yiUT2ioxEgvfKMVOZqqFJEvpEryX2oQFdi5EiHXkr9AbSVJ3s?=
 =?us-ascii?Q?r5YhfbBgBSPj0R7IISOxm11wsspPbv4NL0Lha40O9Dl9NhYqw9MMZI2JbFHi?=
 =?us-ascii?Q?QBLwAFewRsDGFDVsDEfmBNSdUBOQEVXlU4SdyElSOXVQ7bw/rmrEC9YUFi/W?=
 =?us-ascii?Q?3HI9kaiUK6HuMarKLCO17+8nIHuf0m73JZwI5NUVszmZ6+cqL/Gy9qfREiee?=
 =?us-ascii?Q?8hbe+TiOLhm1lhoQNT0FHA5+kxZBVgNX+qTaPSJ7CXdNoEPwIYDin5VoFutn?=
 =?us-ascii?Q?WCJ5nkFAEXk22LXY2lJbRFFL/phAWQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZUEZ5QN5w2ts6YRVrXFM3Y+baNQNwYpMfVI9ygGtO4yxgASczwj9B0A/Sz9T?=
 =?us-ascii?Q?zFDoKxe6EElF3LhyrQcYYyvaFp/B03de0bDNX07cVli2LBjQKnoWNxbDrZSF?=
 =?us-ascii?Q?ik7hlLeZ+o+cLBAnPkOkFcAkfJihhKxZz9MEvZ+qGMTDwKl+xH4gd/WiKdSK?=
 =?us-ascii?Q?jtSmi2SxlasdSpn1H26IMazAR2PKw3KjTbN1ei++MAONPVdZoaZhAD39FAuW?=
 =?us-ascii?Q?4yJnJ1uy8ki3am2UPCdD29KOFQEr/K5ML9drGsTr+QWYaCQFvvLvhmfrSs90?=
 =?us-ascii?Q?6q/QGYjFbFPpys/0mTIguhQlqE0J8dS7Zwjcs80Onmr/X9j+1JA++jDvMQhx?=
 =?us-ascii?Q?DCQcdXp9Rv0OaMbeC8zDfazm+vISKyCGLU7sfhHbZLhJE8gI2s0CveBQRITg?=
 =?us-ascii?Q?p/VlGN7axEw9w6dgQHFCpsiM/j45z7I+MDFrPpqfaLHKwV9X/3Fl5SV7RUtl?=
 =?us-ascii?Q?qBmT/2Q61K6FnuxqnSjgm7c6Wzq8e7ch9kKDT8J/N57IMZivtiBCOczCxxxp?=
 =?us-ascii?Q?aWxyT/YQb7SLkqRBYUyVAwkNME5cToOoVnkwyd/Jy7gAOi1aYIon2Wer2xNo?=
 =?us-ascii?Q?x+h2fg4hzBwRzKEkKP7d3aYkuIoeKOsILu58Ju50w2eVspAcHettNVAZO3vM?=
 =?us-ascii?Q?b0Zi8RBCGevSLKfZDeGUnUw1Rj11Lsh5QOHP1B5rabrF2MiVaZAffTzDMq9v?=
 =?us-ascii?Q?L7PwgUX1i1fNlsxhfEHItIPQHdhn6+r+RRr/M9hjCNdeKZgrWRDy9kA3jMB4?=
 =?us-ascii?Q?5RMr798OIL9hIjhlzd6bcBsIWtyITPk+tbyv5J9C4I+JlF506//NRw1KP4+K?=
 =?us-ascii?Q?SlT9hzohFJYVQRHGlFqmcY3JHzCe5X9qQ95IhtI+AVX0LCpptDJ16ZdZOq2H?=
 =?us-ascii?Q?Hpnsuok1WBGWqicd0NXbY7Eppbvy5L0WM15HnXCXPR8yd1mLyEIrMajlk+23?=
 =?us-ascii?Q?nVK8iXOqvDElWDU74vo/saMNRIVvb5WeJSwfQaqrZItfL8SlH/IYOxrK1hYo?=
 =?us-ascii?Q?mpVDKRz5sPTQNLwAA4XYJokXlYWJYG5xauJ621Hmv/CZ/46Ky+nBLALkRPzT?=
 =?us-ascii?Q?bONBWfZ6Ky6+93xbVo9ITnAJzv2XOngyxsxgnjJdmH0by770XbHzGLiQlB5H?=
 =?us-ascii?Q?5/567ya32/Wxd4DofcLsDO2hqEX174mlXtil8nDrSGfVPTXvy+4mC1K/pC+f?=
 =?us-ascii?Q?JqUD/z7O8gYeKo6jRJe3cb4XcEMqwUUYunwwB8EFBQXsgM4fWofvg2wphDyb?=
 =?us-ascii?Q?f5RoiDKX4FlWr5agQT94Poj17n874EI/Bwrp0fgX6Qo3cZuovQ6NVtuHBmRd?=
 =?us-ascii?Q?U+TZYw7whD5+GrzGb3jHJL2Dao3OR8rBspNad1IBO1ufW+TthLYo2jcgVSz/?=
 =?us-ascii?Q?9PJeXiihqtUEdE3oCYcvKMaopGicqhcetopEhRsA5f9dBqL+4w=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cae996ef-0992-4950-b60c-08dec7d6da25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:31:13.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF1F6CB6F4A

On Thu, Jun 11, 2026 at 05:20:22PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 09:32:38 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Thu, Jun 11, 2026 at 12:09:43PM +0100, Jonathan Cameron wrote:
> > > On Wed, 10 Jun 2026 12:54:47 -0500
> > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > >   
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > Add the core component of a new inv_icm42607 driver. This includes
> > > > a few setup functions and the full register definition in the
> > > > header file.
> > > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > > Hi Chris,
> > > 
> > > A couple more minor things from a fresh read.
> > > 
> > > Thanks
> > > 
> > > Jonathan
> > >   
> > > > ---
> > > >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
> > > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 197 +++++++++++
> > > >  2 files changed, 531 insertions(+)
> > > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > 
> > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > > new file mode 100644
> > > > index 000000000000..716fc0f1c3fd
> > > > --- /dev/null
> > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h  
> > >   
> > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > new file mode 100644
> > > > index 000000000000..334264120b42
> > > > --- /dev/null
> > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c  
> > >   
> > > > +
> > > > +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> > > > +			      inv_icm42607_bus_setup inv_icm42607_bus_setup)
> > > > +{
> > > > +	const struct device *dev = regmap_get_device(st->map);
> > > > +	unsigned int val;
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Warn, but don't fail. */
> > > > +	if (val != st->hw->whoami)
> > > > +		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
> > > > +			 val, st->hw->whoami, st->hw->name);
> > > > +
> > > > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > > > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	fsleep(INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC);
> > > > +
> > > > +	/*
> > > > +	 * No polling interval specified in datasheet, so use reset time as
> > > > +	 * polling interval and 10x reset time as timeout period.
> > > > +	 */
> > > > +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> > > > +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> > > > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC),
> > > > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC * 10));
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret,
> > > > +				     "reset error, reset done bit not set\n");
> > > > +
> > > > +	/* Sync the regcache again after a reset. */
> > > > +	regcache_mark_dirty(st->map);
> > > > +	ret = regcache_sync(st->map);  
> > > 
> > > Sashiko raised the point that you don't have a writeable register list for the regmap
> > > and so potentially we at very least write a bunch of stuff that isn't needed.
> > > I doubt it's actually a problem or you would have seen it, but nice little optimization
> > > to reduce what is written.  
> > 
> > I will add such a list, I'd put it in patch 4 unless you think I should
> > merge patch 3 and 4 to make the driver compileable at the first commit
> > of code (will push the number of lines to the ~850/900 range though).
> > 
> I'm fine with them split but don't mind if Andy prefers them combined.
> His comment on adding a COMPILE_TEST option would allow that to be
> built, but it is a bit odd to do it just for that purpose.
> 
> Jonathan
> 

I'm going to add the i2c stuff to this series, and then do the SPI
on the next patch. That should add only a little bit to this one but
still ensure the very first (code) commit has something to compile.
I'm going to avoid doing COMPILE_TEST unless collectively you all
think I should.

I'm still racing to try and get this one done before the merge
window opens up, but I'm pretty sure it's already too late at
this point. I'll refrain from submitting updates once the window opens
though.

Thank you,
Chris
