Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012069.outbound.protection.outlook.com [52.103.14.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309D3FBA7;
	Tue, 23 Jun 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182231; cv=fail; b=nnxPyY65GT9FT3YOhcnS4BzejD/+51uekWXCchKJSP9hmG9wRHAnfB+BS2lRp+oKy7HwN6nn2U6xbTIn8dxsaOWxldwNKnPRgoW5ny3ksB23O2TNzZg7JQPnLgWpL4f+wOMVPTbLNoerWTF/ihOFXI721gddtIVgeIBiZpUfZ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182231; c=relaxed/simple;
	bh=j/SPtvkAvechWfaMntqWJUcyVchxjuq6T2S2DU/jyBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdN5Sefvkrg+kNTtFDoWSzSAIvZg8I4ZD8zoXddRRtOddw5aRG2vyxWoneGn9bB5+/C4V5/i1navph8ga732BheNRxz6aMLBIe0ukRorPrMEDhZyBl8vCEX9Mh5E7vg12oJHLd90Qg0oynShSW/o4Mg3Z7ae1TPaDgBdgLOcmP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Og+PIWna; arc=fail smtp.client-ip=52.103.14.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Og+PIWna"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/uPwx8gO8H7SHxtnRbqlFlVAO0lPwCqdBBlbV5YOL2WHpCGb9YZ7hCY/FSwaCPtRBSvff8VIr3CMQtP9a68TM8KhS4u0xcBrwCirj+XtLVLS7/WMQapC/g599MVZbPzln4pZmz7D89PqmOpOqIYIvZbBKWv/Hf9Td+GAvQR1oJeMKmjmDO8h4OMmQ4auqiyAB1AjItXvuXLZjpyd4IM+Pq7T2nKRgrryNjdxRyxbhD6h+EHYuis+b50g/to6tgUnrirD1SXp5PWc37SYk1Z7mC14dO+m2TrEHD+B6w0se9BG5xtC64dcTpVPttw1T2ShY7qBUKLVMMeSg52zNBitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1zBoNzgqEZNdgaaydyBtOe2ZodEZYH5uu2uRrlM0a0=;
 b=tamhz/v8Ef7u/MGf6ozDYbJQbmUxGzmOjVh4Om5ZDqHCAihFFjAG+bEagFwXBGFo8Rcw5acIfNaZA2l4WggKzBPhg1iZTlRoMflRhNBnm2sxHdiI2fmij2FaZu1VaUnhrlnXp5RnbqZEi1ScGpQb7JA+mYSZzDAOlP+22Q5ukUvdspAnCkc7hrJ1IFI3QDOs86oLtJ20TaDQr6CZPNykISzd2UiiI8FcLDOlkAUenaZzXx6Y1pSv6bNJlXjjfR7UAOM/LNmuiZ/BNbOGO17gGRjxib/pjgsKXRizB7gDP+6YEPUda9O4xgd3Nc6BFET3WnIK+3V0YG31c6vMa5Rjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1zBoNzgqEZNdgaaydyBtOe2ZodEZYH5uu2uRrlM0a0=;
 b=Og+PIWnaYXvEGZ8wincfNEvYNWM4Be8YWcBTC7xU4dehHKhAN9euW65AqLhk6SngqHpSfpwM6TwReraF6bnF8yehh+1Lq4GrNCGOa8fFV8GdrsPo1+ygWFms2xuoZpNvphTx2fzGxp6URtvNjOvp7utaBrtiSlPppjkSFlre+TI/bYsWO+UVdIeR8iqeeUUN3jKvgpx5hI1h4NU9vtKWxf4wlz90DF0PxoZzyZJ/s6v6gFnFea/jeGFmVBqMqB32P8cB8K4Ru4A2vX5gngkxaCOrKAv0lIVO1XdEQi14+slMfC8R/Nz3+rzq77cjK9QaOodW23sv1GBZeJxI3zf1Zw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM3PR19MB8305.namprd19.prod.outlook.com
 (2603:10b6:0:49::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:37:07 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:37:07 +0000
Date: Mon, 22 Jun 2026 21:37:04 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Message-ID:
 <PH0PR19MB9973380B3D3497F8688D845A60A5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-9-macroalpha82@gmail.com>
 <20260621183408.032e18b4@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621183408.032e18b4@jic23-huawei>
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajnxUEzPEmikfofo@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM3PR19MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: ed97f463-6cd6-4d34-4404-08ded0d0518a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|51005399006|15080799012|24021099003|19110799012|37011999003|8060799015|4140399003|5072599009|25010399006|25031999004|41001999006|10035399007|1141799003|1602099012|440099028|4302099013|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKfSQ2CCB2Qmx3Pr4nT9g8e/QFyYGOm3UbIVLqpA3SejtFXydfGXM26oeFyx?=
 =?us-ascii?Q?cu4369EIYvykQjfxOlWktlXmfZJkGBbTqY4rv51DydbAp/zNRrpkyHVlblLS?=
 =?us-ascii?Q?duF3ub88OWRblFTinkGJj/PcB8GTmIeGvVwONocm1FDxkhslA0o4LnvaodfC?=
 =?us-ascii?Q?rTVGq9dRZW9It+Uc992Wbi99rWVcy7dwGPYiCLIk5okSYgJTgpBSZLOX5MQE?=
 =?us-ascii?Q?A91u49QwfIpT6Iega5OPVI7JJyhoU1LyekgMkRZlJAaPNw/7FkxJpraMuT60?=
 =?us-ascii?Q?+j+gSBuAqeNVylOcHxxJbQvzX1601pfUOdl4E9ypPt6nRZPmjWo/rkSbMpT2?=
 =?us-ascii?Q?q9qb6o+e3zScDZkwoauhfBkgnEA6TgRwbFWLeeVBnSFKMk1VqyWlnZzfQ0Vs?=
 =?us-ascii?Q?rYl9MJGnYVa+9w/iPHU8b+LFckue4XCWWCIqp1rS968eVd2T+JnHjAksyBaI?=
 =?us-ascii?Q?WINGYZmqgHhqTiI5NNQQNrFuOz3rXaj294XheNF3YzF8QCwvKo2VYxL/HLsm?=
 =?us-ascii?Q?V5vhsAY/rOtkJLiVe6fRaXOQ/RJs345RKAgYMmD3kRe5ESzabyVlutkB/0js?=
 =?us-ascii?Q?SlmM+0ZN1UdpA8vzgGXReH2j0DLQDgsWuFxE8B5dq2O7/Uh5AlFjEKlfohXU?=
 =?us-ascii?Q?PnTWovYkSWCrobimPJ5bRuS2VWlczM7kn90IPwj5Cn8hyLZmH5b/9933kSG7?=
 =?us-ascii?Q?O3OO+GNaxhaiqLN4cqsqRdWFc5QRu/QEISeVOA4dnjY58C/0geyzsRvPhWdB?=
 =?us-ascii?Q?1HU4JVpE2khltzJsE8dTYqiPIBfqo6xYW8As6N7CTvOIB9CvXcelE0WGBYS4?=
 =?us-ascii?Q?gsP8XO2h0A6TVQoE71+paSs6u/sT85WXeMIk4Kw3SElGZxYjoyZVX+AkWnIS?=
 =?us-ascii?Q?c0VvX1SfuBPbrmFlvmhiK7ciUfiFuBNhx4gQJPqzFIrlyaAoo3J84AHzqT2g?=
 =?us-ascii?Q?ZsWHDBopT1twHQhsoE0RsYsoOAZMcSaZ/NOrDu+giUIvX+3u2wfu89ofjRrh?=
 =?us-ascii?Q?L/3zp1iNn9rlPWnIPlTGSjfDoolj1Xfy2q+32GDoK6ffBjcVwUJc5RaMQWtO?=
 =?us-ascii?Q?g5qAG2iqFDada1ssTLqQd9YppV6kXIXe7x0iZ1QgRuxLRTyMrw361TpCB7An?=
 =?us-ascii?Q?ZQ6bKTDxpuOX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xxp22r2FogSWj3pohLzjSAWOQdgGv9vnGGvtCbjiLLUW/vguSi8MnAKjxBME?=
 =?us-ascii?Q?KkfAhsvWHg4N0+0OBEKVKB9bhNAY1G+v7ryui/7ctRRzNvD4FUXnfJmmZ6HC?=
 =?us-ascii?Q?Ze0lfDfLcRmMLeBN8aioix3SBBiCKrzni9wrL3UwZcbaeKe3bdRcllLiycai?=
 =?us-ascii?Q?+x6bHM7XDAF9cLsw8YNmYw8+LvJNL4X0/x3JEovm9eDf8W0PL9MzYAMqeOdH?=
 =?us-ascii?Q?PdnbttyaBlTaE3CBPOzJ4NqiHbnJ4rjCm7A8UQYQydBNw37YGzOURlO354nC?=
 =?us-ascii?Q?4IDJV+bBWxl/o0kHhH7EFdy1/ASf2mcBXOtj8MZARzMSfAmYOgd/pQQua2v7?=
 =?us-ascii?Q?RM1IHk3nrqSh9WDzfCdUSqwZGVCWY8qsNynt5b6h5Ra7X43wKDMDLjMXe8dU?=
 =?us-ascii?Q?z179t3alFw2ctxf/PaPa3kO77rmXNHNwmtA+UyIJagbqBUiRJwN11cynOBWn?=
 =?us-ascii?Q?aXy2LSIqI1cbeh74GfdiWbAafOo3QUupxgIqftXRuB/sqLBHno66YpuhEki+?=
 =?us-ascii?Q?aWjidFKJhZTsh5WEufAD0CbmDiFQDBzd5mg/wsFOp8q3ywVmMswcfGB6LtG8?=
 =?us-ascii?Q?S8yBdqptio8b/ocESLvIm8w9Q2m7KL/TytgO6ukEbySX1z9/AW18HpZAA7n0?=
 =?us-ascii?Q?vZkwScr6tTUtjBgFGAmmeTDTNMU9NwlzhnIpAGz3+OS8tzFkb+lYrjXfarO9?=
 =?us-ascii?Q?cWK82Y3ai0ihzwM9tf80QV6NvOSQ0pZ9B2a7sq5Z5JTih98Vu1LbOpHZ/HS2?=
 =?us-ascii?Q?jxrS9gG/+k/tzmPS6KFBDKLR4Qq2sR9p86guDzbFsdmjTdJ7sE+VHVs3Pon7?=
 =?us-ascii?Q?RQryxyC0aAYeDhbgZoN06eUVnZGk8l5RYkI8CS54CZWgifN7nATpdnFNt0QT?=
 =?us-ascii?Q?F1y1/e2Sc1ET/inNzmmjZOe1LOPPPLvpHz+rAScTrVkpElR8D60MIK7pPP/S?=
 =?us-ascii?Q?5Crqxbf5TnaPqC3NHVZd0UxHPbyRUeDSVqr2Y1JT2dZuYQTlNbbEhbdbcGHs?=
 =?us-ascii?Q?ljAHTFkyVZxL9RU2TevrwTgBFqNtK2ha7R4R1ojpEU90XQ0/oJJxwY9DCeTm?=
 =?us-ascii?Q?hXhLL4ScWPPbDboNf50tZKBoj+2XKlYphP8tT9ThhDqE8B4K/Yo4b8NbHmXg?=
 =?us-ascii?Q?iDnN2irUsCGJ70wDSbwEHU+gBJ90DO6H0PudNdgvu0pjmPGYBDDB+povHCLj?=
 =?us-ascii?Q?kVGwxoL6LBr6WuepMc5fPW4l/4bkN6oCnbJU2gHybM7v3XhaQdn5tNLKmq4g?=
 =?us-ascii?Q?QKU1GCv71ij8p/u4z1nA+JjtQdu5a5i5EGYwypOmL1dlFsWTg6i+cKbQrUSJ?=
 =?us-ascii?Q?SUJta5twFBXAl753VpOX9xfYnDx30MWavr12lOvdRKgugzyC9lV7etQJbC7u?=
 =?us-ascii?Q?nYjvRvl0+/prFEFgS9UPdCKypE9qwKkfR+CSsBnNEVNBRy5uxvs6psJ4RLiB?=
 =?us-ascii?Q?7OegQhI5PVlbq2uGDsgqNUrvnc7ksvZU?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed97f463-6cd6-4d34-4404-08ded0d0518a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:37:07.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8305

On Sun, Jun 21, 2026 at 06:34:08PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Jun 2026 12:25:51 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add gyroscope functions to the icm42607 driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> There is another bit of sashiko stuff in here. Please
> take a look
> https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail.com
> 
> I think it is correct about there being a path in which the
> gyro ends up always enabled along side anything else after
> the first read.
> 
> In general there seems to be a bit of mix on whether the caller
> or the power management function should be responsible for the caching
> of state.
> 
> I know you look at Sashiko so I could just have waited a bit, but
> I was reviewing anyway so took a look and having done that might
> as well highlight some stuff!
> 
> Jonathan
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > index eb239987a1ce..23ca7529825c 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -218,6 +218,49 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
> >  					  st->conf.temp_en, sleep_ms);
> >  }
> >  
> > +int inv_icm42607_set_gyro_conf(struct inv_icm42607_state *st,
> > +			       struct inv_icm42607_sensor_conf *conf,
> > +			       unsigned int *sleep_ms)
> > +{
> > +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.gyro;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (conf->mode < 0)
> > +		conf->mode = oldconf->mode;
> > +	if (conf->fs < 0)
> > +		conf->fs = oldconf->fs;
> > +	if (conf->odr < 0)
> > +		conf->odr = oldconf->odr;
> > +	if (conf->filter < 0)
> > +		conf->filter = oldconf->filter;
> > +
> > +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> > +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK,
> > +				 conf->fs);
> > +		val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK,
> > +				  conf->odr);
> > +		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> > +		if (ret)
> > +			return ret;
> > +		oldconf->fs = conf->fs;
> > +		oldconf->odr = conf->odr;
> > +	}
> > +
> > +	if (conf->filter != oldconf->filter) {
> > +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
> > +				 conf->filter);
> > +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
> > +					 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
> > +		if (ret)
> > +			return ret;
> > +		oldconf->filter = conf->filter;
> > +	}
> > +
> > +	return inv_icm42607_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
> > +					  st->conf.temp_en, sleep_ms);
> > +}
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> > new file mode 100644
> > index 000000000000..ef73560b39d7
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> 
> > +static int inv_icm42607_gyro_read_sensor(struct iio_dev *indio_dev,
> > +					 struct iio_chan_spec const *chan,
> > +					 s16 *val)
> > +{
> > +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(st->map);
> > +	unsigned int reg;
> > +	u8 data[2];
> > +	int ret;
> > +
> > +	if (chan->type != IIO_ANGL_VEL)
> > +		return -EINVAL;
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		reg = INV_ICM42607_REG_GYRO_DATA_X1;
> > +		break;
> > +	case IIO_MOD_Y:
> > +		reg = INV_ICM42607_REG_GYRO_DATA_Y1;
> > +		break;
> > +	case IIO_MOD_Z:
> > +		reg = INV_ICM42607_REG_GYRO_DATA_Z1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	/* enable gyro sensor */
> > +	conf.mode = gyro_st->power_mode;
> > +	conf.filter = gyro_st->filter;
> > +	ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
> The sashiko report is basically:
> 
> This turns it on, and runtime pm will turn it off but the
> state cached ends up such that it is turned on again for
> any runtime pm resume.

Yep, for this and for the accel sensor it looks like it gets stuck on.
I've revamped this code for the next round and so far it looks like the
sensor is powering down correctly.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* read gyro register data */
> > +	ret = regmap_bulk_read(st->map, reg, data, sizeof(data));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = get_unaligned_be16(data);
> > +	if (*val == INV_ICM42607_DATA_INVALID)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 

Thank you,
Chris
