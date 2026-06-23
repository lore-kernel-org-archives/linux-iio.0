Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010021.outbound.protection.outlook.com [52.103.7.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9743FBA7;
	Tue, 23 Jun 2026 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182152; cv=fail; b=iDMjqSoSWmIfcQcXcfew/XeALL4mjTuYoTY3P/CWxCj8Q8ywWDR1tI+tgkR+KAZs/yaeiboIY2aqebgOYo4lTUg0pz+F1J/zjssIf4DO8dXzBEMrTR5MwWXyoRmDka2pZF+CMO37ZeM/lwxx1lRzyY6bkPmF/Zm6dyu6y2BpQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182152; c=relaxed/simple;
	bh=b4Tyzb1t54KiDBCn/9fd/SyVDUnW0ei0Aqc+ph4ntW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNVtGNSKKmNPuP60/7wVfL+xTvgqWCb84CX92PK80zCBO7dUiwGupD1pSln78vIxuUSNzm5g3IdR8MTAHbM9haFU+cThW24MEb7r10nviXdv1cZO1YVkhf8vq5yWx12VOcZppd+NBnDdBFofg69a3OWbIk+bkuWr/6UJB3+C2gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RyD6M9dU; arc=fail smtp.client-ip=52.103.7.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RyD6M9dU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ+i8OwgZuiDwMDrr5IOt9fproRe2AGKINtvyH+h+w47qnACytQeZcjS8DhCjmjZjICm95mEW2md5Imndi6Qh9epMGjCW4sBsOwPZxPtB+Vjf98AAFu02q6oI5Hc2cTBWZeghSZuxSHzy4lCCC0VU1xz2a2TwCi+xeXUO6GWM6Ok/L4bW4Vx6jaD2QK8dganjhQVmv5XdvXJofAB7BDaW357uWMkvcAP3AWMNsN9VEDynxSs0dfx9nIlIoVrIPlC4C+EgfQ5qgga6ULU7APlobq8Lnf8JsFRSIbCVuEaHTd1otngpLHMfKr9afy0unFMve+gZeejUIBinxknUR9A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN6Vyc0riks63YOupI1rBZRANrLDRL3MD5ID0Pf0pn8=;
 b=mXdhJtLLlQWd+cOI7O9mYQAVcbM4SogzNzZEb51g4qTpTHem+vGcwJdyJH0H3ubATBoy8QdqIJ+C4zfXRsLvbdvQTStazUxiKyNBTlMekhfOxmapaJ+Jp0xdIxajhuR26HeasB9LDJarHhk4FRG9Gz7zUE485EDfKrixnToRvGBHi9KlhESDcjC0dHSb2Jrnaf9xNGR0h8qul5xKe5eprFSIkDzKXtoWa7PYEPkJEYfYDp8Rf+RslC7JUzd98aOD6YQlYiSb+VmNhzqCWWndIvE3W+Cth0zBeZ5zwopa/dCbcAnXqnTQ5aikBsqasl/0UvW5Ww1CtUsm22090JwHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN6Vyc0riks63YOupI1rBZRANrLDRL3MD5ID0Pf0pn8=;
 b=RyD6M9dUx4NMsrgN8ZNDApMrnnfs6PmHE/vJYSXkD2uR6OplJ64sYvOIB+bsVxAK2CeJw/dNBS0bZAgt9ZaprcJmhcw1Dmf3Sv/jNAFm+HAh3+9uvLHabwfwv0VNdhz7l/MkPndX4SrXvmDA3MlyXPEpErSA5PhzPwQny8iHAKxElhsw1eYKW0d/mDYYpkPq3itd9kaJ5TKn4IwiXhGgJera/AZPyQ3tHMxtO0MM2ULNM1mnBpAG3o5Z3o8aRFUiK/oZnFFYmt3hUNPBfnrYhc8Q0FHjyaSJZngPTbzlhE09vnEZPSTDCoLHUssHxboBg7Bq5yDWP0LKCwWvPYSVFQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM3PR19MB8305.namprd19.prod.outlook.com
 (2603:10b6:0:49::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:35:48 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:35:48 +0000
Date: Mon, 22 Jun 2026 21:35:44 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V13 6/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID:
 <PH0PR19MB997338E7823E60D7F02F80A491A5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-7-macroalpha82@gmail.com>
 <20260621182612.1a19278a@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621182612.1a19278a@jic23-huawei>
X-ClientProxiedBy: BN1PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:408:e0::15) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajnxACnr8SWHOAZ5@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM3PR19MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 414a1c9a-db79-4395-f96c-08ded0d022aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|51005399006|15080799012|24021099003|19110799012|37011999003|8060799015|12121999013|4140399003|5072599009|25010399006|25031999004|41001999006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SP2rvBomJJJ0NoqohsweK5PDhC2RNwqFlbQ4+yJhmwljb8itBQpF25p1Dj9G?=
 =?us-ascii?Q?hdXYx4H6MxQ9YMMV3XaT7ap7e9sJ8M649EZuzTDsAMOONr7kXLz2x9ZuNQJk?=
 =?us-ascii?Q?Asxw2uq38HCnBQYQJawRFBuRtwazlZJxbtFlvimTUkczRO0kjJBzWE5regDs?=
 =?us-ascii?Q?6fWYLtNAgo4unjIfd9TUH+KyLBQVqixyZU0H+14ul+95OAQ952+hJ25DIqzw?=
 =?us-ascii?Q?/91AFSrtjx2ZzT9Fn15SOWURGlAz6ZjI/W5u+IRBt4d+yN2arjorP7DXDQCE?=
 =?us-ascii?Q?PWbNzXwZr5DZRacFruFTNKZPApX5UzDcV5srq38b1Mh2PHGPtw48cOYixk4D?=
 =?us-ascii?Q?EdHbuM/Y8SYOsyvBg/tp3wPfxOxg7dxPiViUrSfGuAcuD+w/lx7sK38KEVLc?=
 =?us-ascii?Q?0qCukVQTyBPPKKX9SebhyojEwTDgefpybXYHgc6jRQ47wUFUWYlGSg0wu8/x?=
 =?us-ascii?Q?PVK2svoD3Avl9YRKVpQjdKiRK6ySwuuPVtygAaZxom1VcpIX3TzxJ7mxo3Pw?=
 =?us-ascii?Q?IENUeTFVfocdd5qJ6770/H19CFB1sWQEzpLKej5iTzbB403wwlIlZcEWyK4j?=
 =?us-ascii?Q?BESp8Y+KoZ1PpKbf77LEX8xMYaCkaOgv/iM43fdlsjs7NAWbHRAvwj/HG6eo?=
 =?us-ascii?Q?0K8xFSHgMzBq3DCkAbSzg6fIcEi3UXzhtKEm2xjQRDxILGQnxE392TL0SyT/?=
 =?us-ascii?Q?yD1ZrXsaI63I6pjeqdSFs8qqX3ubLrRLcXOyRDcrifBxYf1xd6RC4NkBS8P4?=
 =?us-ascii?Q?naHuRvZ9tG0wFIb3++NiWVS0oaWlqaZ5ezhLWm9afI+LB4GSC2AaH7XhAHIx?=
 =?us-ascii?Q?0E+V8cE45YIoSDkmpDsYw0CPNAo/rbfXjGJr3NC5vj7J0BR0u+yIm0mZboNM?=
 =?us-ascii?Q?zFvfllLmtwqiYH1/DxnCJcX2ndV/bE1Bdnne5lHajicW1b0MmUBbvyTwIY+V?=
 =?us-ascii?Q?rY1j/o/JFj+FneBAqn/a16XaFcKAA6Skv4yy4e0W7viI3baOMg3WZQnmZbW8?=
 =?us-ascii?Q?J98ncX5Psv/M2eVMap7TEY8kcCt+t3nEZzsqlghFdQbE4pRSnaYaNd3AkIfO?=
 =?us-ascii?Q?5OinsOQhgFOUoMSQwiBlaS+mnXmwQ0eDObzLhybNtKaKsGNMLho=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oq0LJl4Z8cYXucy611J9t+ZqSVHpWsGX+nZ7xaLByElLXtuVo2ELF9mVukxW?=
 =?us-ascii?Q?IgoovLYJKH6K3QF0z1b148BrlPn6QrA/IkAsrrQw3Z+wdBPcVGxc/2cPmXjm?=
 =?us-ascii?Q?gCCKX8CoNE9TiREVatfSR5TzY+xHgN8xgkP9mvb1//7ddPHo4RrSt5PndqBy?=
 =?us-ascii?Q?4V7dwwecm+dViUaMHL2x9H470o28skVKOFkwVJox0QNK5B9z0jodyYLwyQAM?=
 =?us-ascii?Q?rnwLnkqyBFlJrhUJ1ned9XjXDonEpZtKkctCjX8AggPN1yK9XwNkxX84f3Hm?=
 =?us-ascii?Q?bA/x63cLOYTm52jIlBoXBh2uXDfwugBwG5lYdb/fH+p5sNiIMRAt/ePoEKLe?=
 =?us-ascii?Q?228D5zZqwKWdRWgGYWBTIoXzSFxJPoxQCtfH4sgv3mKRakx0s0/QlT+UOmNo?=
 =?us-ascii?Q?nsApnqfPDTtYB1LM4hwWVSOQ5IWqYAV2VigOnmftSWifvujK8O+z3CjIBSP/?=
 =?us-ascii?Q?hyYtJbiUUl3sPDH42ARpjGSPKody3wXnIvcjpCzi5RSJpI+V8k+xCV26SFkq?=
 =?us-ascii?Q?DggJv3j7rQhpNVI6NpGoc3gPky0G4b3HTf+ZXrBzpjzPqaP8SlipQ5xd9cJ1?=
 =?us-ascii?Q?D/wNtat6dpAndxsmMQ+6ZjYQpYNfP4X0IYpl2ew7uxDfFIR1WoXWhG8kQH4F?=
 =?us-ascii?Q?H5ik/xwheV2o3LtctZnvtSQGQKfI9OVLGeWtxiBfSRYdc8Zvq3JfMaVkY0OD?=
 =?us-ascii?Q?PZR1uHVddP78FXElUMCoqpf8tleVWp1BV1UfA68OMkcSNjmKirokPVamhSAD?=
 =?us-ascii?Q?pYUhTYf4XWX0eKLtjz0Etl0OHNHh6Zrap1Tx8G2y/JChRpWmZvGEjSze+fP2?=
 =?us-ascii?Q?ygraUDzdCgUw2mvGHWae1pG0en40N6wT5CAFWb5iFiiqy/6w+VPkBlMnVhvf?=
 =?us-ascii?Q?bJ07MaqQ7HT8ZC+nlpTs1gA8unWJjK7JA1YXfZzAxzeUi/K3Pq5xLGg+pNdD?=
 =?us-ascii?Q?NhKcHX//AOAdt5q4M3dqmDVSXuMWO8bfWVLKU+SNoG6xerSNUHV7iX4YkySM?=
 =?us-ascii?Q?yM99FE5p+Eam4t0aMwQaUFcy507MWRJ/ZcU0Oi5dDn3HeV0+nfSmVe12SyNY?=
 =?us-ascii?Q?lwzTIiHkxq6c75BL3/27Orggf9HJ/yb4ywheP3TIOqzI6kn4g+ABi9PqrRMD?=
 =?us-ascii?Q?wXZM+nfua2/7xrA1g4P3p8AAJae3O2hqaeBYKUmt706fu1Rt3i4z/+SdF4bh?=
 =?us-ascii?Q?rCagUHqAs5Hn+YKzq2E8BMa60LlpKjPKAue2pXL8FvNzIeurT6UMAJpxWi7I?=
 =?us-ascii?Q?Fg89ExtjHDNhPjUOYYYseB4/HZ26tFd7inbYbSvlocPWUrV2KgT8iCM3MIVv?=
 =?us-ascii?Q?cyL2tAhPMBbai9bAJVuCfzYXH0LOSR383Ozv3YtobKine3aWDhhpvGaKqONw?=
 =?us-ascii?Q?fOpIpH+JyrP3acTNu/Pan+T+hJIPdLM4DcNHcD/MbjjebUFaZt/tPJrG2fGQ?=
 =?us-ascii?Q?O/YyAPThcYkybTxze9YF6jEiEj5uvOjy?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 414a1c9a-db79-4395-f96c-08ded0d022aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:35:48.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8305

On Sun, Jun 21, 2026 at 06:26:12PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Jun 2026 12:25:49 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add functions for reading temperature sensor data.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Another sashiko reported thing. I'd definitely have missed
> this one and I think it is correct.
> 
> When I get caught up I'll post a thread to see if people
> feel we should generally just ask for Sashiko to reply on
> list.
> 
> Jonathan
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > index 64f5d263de4f..644cd7f821b9 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -162,6 +162,24 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> >  	return 0;
> >  }
> >  
> > +int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
> > +			       unsigned int *sleep_ms)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_TEMP_CONFIG0_FILTER_MASK,
> > +			 INV_ICM42607_FILTER_BW_34HZ);
> > +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_TEMP_CONFIG0,
> > +				 INV_ICM42607_TEMP_CONFIG0_FILTER_MASK, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
> > +					  st->conf.accel.mode, enable,
> > +					  sleep_ms);
> > +}
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> > new file mode 100644
> > index 000000000000..9a60e1a478b0
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> 
> > +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
> > +{
> > +	struct device *dev = regmap_get_device(st->map);
> > +	u8 raw[2];
> > +	int ret;
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	st->conf.temp_en = true;
> 
> Sashiko points out (seems right) that this sets the internal state
> before the power management routine expects it to be set.  So why
> is this here as opposed to just passing true into the
> function that follows?

I'm going to take setting of state out of the power management function
entirely, as well as killing off any "temp_en" since technically there
is nothing to enable on the temp sensor. I'll do a check when you try
to read the temp to see if any sensors are on and if none are then I
will power up the accel sensor (since it uses about 5x less power than
the gyro per the datasheet).

> 
> > +	ret = inv_icm42607_set_temp_conf(st, st->conf.temp_en, NULL);
> > +	st->conf.temp_en = false;
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1,
> > +			       raw, sizeof(raw));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*temp = get_unaligned_be16(raw);
> > +	if (*temp == INV_ICM42607_DATA_INVALID)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}

Thank you,
Chris
