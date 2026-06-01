Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013088.outbound.protection.outlook.com [52.103.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07891FE471;
	Mon,  1 Jun 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324682; cv=fail; b=WtV/Uj/6eFJhjhAsHhaBjXR3dN2SGs1uWiS7rfpbAy3VbRBN73oetxfo9JC4GO+w+C3lxrSbYVuOHB+4paqxRjO/si9/BYrJj2FiLLCkosGLI+iF3Spw98VBUSRCpOO7zLmoJXOVyff0boQZKLIdseYtfZhCxqShRHbYeuFhtCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324682; c=relaxed/simple;
	bh=U9QfBmM2Iuai3E8XM0n5D1sUvdXKMWme5I48xfTvAqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyFbIOEvvT6Hab5Q4ndzMZ0QL0eRTjm01jNDLzojs9+yvCUSTafJJsmjNhEu3/hGJ9lS6g2wtBPKpJsOaDcjjXs74HbxMffBVEW7YC+lplY3GZIty32e/A8hs/JlvIr+xAMoyDpjBJacENAHVJhPKG/KqMAnA1hFiycOHoghqu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Ilf2Du9g; arc=fail smtp.client-ip=52.103.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ilf2Du9g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdtRI9OoA1KzP8DDOSWWB6ja/zzU2EsP0Nuh4z+ZcoUcQd9TK241cijDTFx/PYkewlalYThkoHsrNyxJzMLI0FSCcdQ6GuFjnsg8MLPbgi+cr4tIi1hu20dRfLUEuxr/5AtfENWP4DgTj2WXeKcnErOgraxvyrxNx+/4JTkUXMDNOvW67ggYQo1IVeIByq+YcvQjZm+eAq7J07oTBL/ZvGLBm+KjHCsYwLGXTmNv1jW8VZYjlDPZy/eP/W23TYfwIEGMkdqXmpCd8NBkAgdPbkbZdDMM0eIa47228xZ4Wb9GSmKPO7Ku0nielxQXjYKrEciszGvy2jzIS/yW2WUqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prEn4Q6all3jMN9B1vhrZxQsV78j/CX3XFLtsVf0844=;
 b=x1ML82mKBjzheTVhl0kKlhbd/2hGqZ/wymqkraI1N2jU+ItKtjthejQmeiuMwjZYbDPYM2FcYPtmy2I9mf96gnYTnoQxJoThjC3+FWTbE6vfPEbeDdBhxs+iq+txKr1Y10BkxsWk6qq9quXGoqGveOoZCSMjr+UMOtWC8hI80HZz3ZFx4NBsJnViOeajQ2UF5C1kzKvGvDBhZ1U4eP+IM9MQLUWfp+zSCH4wMa4vKL5Ao1+06F6xoht3uPTNDf5OoxhhUHbbAP1M3w2Zb+25YVXewHTQB3l0bOmf67L3QdTQPxwuJtHSnhDVPILbZcJiY4We/S/cYbGCLa+SLlVBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prEn4Q6all3jMN9B1vhrZxQsV78j/CX3XFLtsVf0844=;
 b=Ilf2Du9g8j//jU0l/My/WBaqOzOyN4vbFukJrXwkLyiHU8Ot2WwVLW0ig4mkX5bS0Vd9/am6LSHoJhYy/Qg8M4V2fbLWj/oh95NQx9aMV4ZjsTFDyvHTDmSQWkxNoWBY0rMxI8X44thpRH//zsNLME/xksdSGLzCRbAYEdFJaKpCUI4vwAtIB7qyTkG8FtJUsfF6jr8n6FRd0ZCxYROtQWtmt3YRVPpwcHntmLFzZnZsP1GcUDQY2un3Jyivql5foC31KxveIhGXdugYI3w3oz3rDvFe2isrHr791MUfmg//XGJAq5T0RMAaZA/sIG0msd29LrhwIWTxXm7HyUq/cg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB4975.namprd19.prod.outlook.com
 (2603:10b6:806:1a8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:37:58 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 14:37:58 +0000
Date: Mon, 1 Jun 2026 09:37:56 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V9 10/11] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID:
 <PH0PR19MB997338A6EE5428FC9B058F2E07A5152@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
 <20260530031739.109063-11-macroalpha82@gmail.com>
 <20260531135823.015c4fd1@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531135823.015c4fd1@jic23-huawei>
X-ClientProxiedBy: SN7PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:806:121::31) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ah2ZRHWl2JLVjha8@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA1PR19MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 70756c0d-2cf5-4c56-3463-08debfeb5fee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|6090799003|41001999006|23021999003|19110799012|5072599009|15080799012|24021099003|37011999003|25031999004|51005399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qzd9GP3cw63iwejG7jCWmNTrnLlrCIaKB5lQakQA1nNdOqm2/2+3NeQ5/AG?=
 =?us-ascii?Q?re8aiZJvRY8hot/MGzpuv+AHOThqX66Y0Ca+k+xsP2M2cJgNTUpKNBBI3l4a?=
 =?us-ascii?Q?SdIlJPluMvvRJv/5Vq6buyEAuXD4+2ANINuuKi3DrpmqR1cMYi6mfY6fRbpK?=
 =?us-ascii?Q?lPUbi7SOWQFLMlqpn0H04I74/GwkFL0rH2LUoctf1JbKGyRRJQS0iLKy2hHg?=
 =?us-ascii?Q?kbwfOuexNyL3NNPIrLmkA5dh6oNE2PqMl7v1Xg7D4dqnq0Ynqakmv9sKHkBq?=
 =?us-ascii?Q?SWeiNd8eZskJiTYL3GJb+d3hF+lKRQm4LTwSRmf1sgDxqN2NnoHEJXbnwaHC?=
 =?us-ascii?Q?Wu0h5zGHApMkQV7X2Cqdr6akbBj9ORL4nycKGJXHs2kSiGJ2PcIgwWOSA71X?=
 =?us-ascii?Q?okaWkimIR01OJEOHQr2aGVtTLgpHT41GU55ZA/CAa7aKTp+2M+f07aQYGA83?=
 =?us-ascii?Q?vL82tqW6EEHGS6VvOkc/N4TBiHeT33RRQe8gFsedhS2camIHBnAi9gr4wako?=
 =?us-ascii?Q?gK0/I9vQIx3De8ODGAEWfeN2CzbLqTI0qsao8D2vuem9AtPsNi5stVAOYO9C?=
 =?us-ascii?Q?CFZdm9dWXWQK28ke4WdM5AYTw9l92NyRHeIpH7yk/BeS1Q0mGbJINnCTI4or?=
 =?us-ascii?Q?zjW2wNbr/KEZYr5blCWaLhMQBJAiO6B2g79LSuUN3CjjMJRlWebaVJ8Q2j0T?=
 =?us-ascii?Q?gw1tUqm+wZ78F98+SA3CCYr3CYqLRWsDA03xPiRdKWrqSpnVOT+2vyxUyxj3?=
 =?us-ascii?Q?x7Rm+H2mE5JCrBqeNOwvXN908JT1BerE2+D8y/GsENHihtWgRryYG0HZwgVM?=
 =?us-ascii?Q?GZiH3X8WGadBv56kuNN5bsjXRGALy7RSovvItI39wS9C8IggL3WVgrPGO+Mw?=
 =?us-ascii?Q?Gnrld0G6RyMK2Hr9Fb+3Av1DjpsOysliPfTZAWjGbz/9W73X+cpHxgh6wwLY?=
 =?us-ascii?Q?Yg63KpP4QI/t4t572GDVbG1tKa5UwMUS0siOySc9zBI1LKOpJhKcLz7LL67V?=
 =?us-ascii?Q?Io3c6toRnsgA+JYBtlgcK3GW20M3Bs3cRmTVJC69AsjpxAgOnCqVxuQtsfRj?=
 =?us-ascii?Q?rw2W29WSGpt8msVQVRxix1PfA+3qSQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4clr1sh8B8UwsSDUqv34MIwWHWCcJgnuXAdsEhDBmcac9hIfPpjkGbGMixk?=
 =?us-ascii?Q?MJ5IH8Vksm6eYrhQXAFNRaa2z2duiHzyS3jQsj6Pl1NYbtK27cnh3wMT5XhB?=
 =?us-ascii?Q?Lywa+CpAh/defuUjQuVCp+PSslCom11tbpcaSWa242THzk4wd5DcWzfo3p9R?=
 =?us-ascii?Q?bParsDC6InsC54gPP6QFwm/tHQcSGbwGmv535bA+zecTEqULaOI5znMnyETR?=
 =?us-ascii?Q?dfImR6wciXdXdrI7paXzxDaYvmWu4W9DYba8ATM5G1JeAhrvjdCqg2VY7EFm?=
 =?us-ascii?Q?O20GXjrXuF/E6TL5uNnIWwzgpyI8BLQK0AsT8dOMRcCLPtSDiHLDzn1DhAeG?=
 =?us-ascii?Q?x7yFdbiCQxyjGdVO9uoNe2JQId2EjGpzmsk0GVYs+fxjeZFipgDwzqaYTXei?=
 =?us-ascii?Q?crBYpgPEupho2SAwkzedZVBUBgNJ0Zau04/JnVCOoqmHniYbroyV67TIw4Kd?=
 =?us-ascii?Q?rzcWFXchPx8a8B+HEZjuZ2rY6pqpSBvRQUT7Sz6ypUWgIIGD9oQ33rsn4LJs?=
 =?us-ascii?Q?GFfarsDgffiBJ0d19bO8ZMTvY0+Ncgml0ncoMpMbUD/CfLQOuLZ1pr6qSh74?=
 =?us-ascii?Q?Sv95HxMaeox2K6RoNQEGmqKKkh/heES338HP5Bd7XNuqFjAVkBtlrckhLuFF?=
 =?us-ascii?Q?xovelhzr9AKRa+BaFEc5/HfNq0KdwXLDVcYU1UP0PcjRPZ36r/fXREhUDlRK?=
 =?us-ascii?Q?SL9iwLVNhFfa9h/2GAWs4SrbJW0ds00VktwdSj3Hr4dCCNLrPTpNAbwjbTGM?=
 =?us-ascii?Q?pGEvaeBChxGhws+ZWh1sWVP/6fvkeVUve0E+tB0jLQNjZor1+K1+ONmDUUJ0?=
 =?us-ascii?Q?GCRBRPhKwVx4sBXzlEe++olAdnj2Mrkpopoog/zzdg8HUlScmVGNljmbz1zR?=
 =?us-ascii?Q?15MPJ+95g6JHRVNPQ+Pgdh1QH9Esx+bVPSWudTx1CmeCojL5Er2QmwErY3Eb?=
 =?us-ascii?Q?lKPb7+SxghD7guzS1M9lE2YTuBjnREekl2Y+GXx566zpIlETy+Ue2uTL0iSz?=
 =?us-ascii?Q?h+1IGUSiQWLjhP0JmNgOvLDBKOxdQpVpQY+y9i0CK6Ja/sheq1xt1+Vgl17v?=
 =?us-ascii?Q?D4W5IVl3UZA0kxPTv3qveAac/7WhEPl7mrbAb19sMC6xe1RD4VIWjzXKChrF?=
 =?us-ascii?Q?7EIp+C14Q9fCaX4WJ+5jiZumgGRpCCWxD261q5BhnLcRVMprG0WhXp5OnM09?=
 =?us-ascii?Q?GWLIpveNMpOjQhUYKmbfkAFnB+ymfd2azRCFQHomfd4OPBGhHZ3/4xdAlyGB?=
 =?us-ascii?Q?na3+/7AnxLOzPMBCGjieZXfgs0t619blnfuR1UuoqMUk2MHv4fABULx+juEV?=
 =?us-ascii?Q?/Z/0QuASJJjGZygiD+2jXaEMQkW27hgIFVd5o/Jf7ZJQk/GK2H4Qrw6hr666?=
 =?us-ascii?Q?80fMYVJASoYBeAWZIHmsnM4+MX8ARkXAWZ2o3WlAGYTYnT+xOw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 70756c0d-2cf5-4c56-3463-08debfeb5fee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:37:58.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4975

On Sun, May 31, 2026 at 01:58:23PM +0100, Jonathan Cameron wrote:
> On Fri, 29 May 2026 22:17:37 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add gyroscope functions to the icm42607 driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> Hi Chris,
> Various things inline.
> 
> Thanks,
> 
> Jonathan
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > index 5b69bf895b35..c45239613344 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> 
> >  int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
> >  {
> > +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> >  	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
> >  	struct inv_sensors_timestamp *ts;
> >  	int ret;
> > @@ -491,6 +494,16 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
> >  	if (st->fifo.nb.total == 0)
> >  		return 0;
> >  
> > +	/* handle gyroscope timestamp and FIFO data parsing */
> > +	if (st->fifo.nb.gyro > 0) {
> > +		ts = &gyro_st->ts;
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
> > +						st->timestamp.gyro);
> > +		ret = inv_icm42607_gyro_parse_fifo(st->indio_gyro);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	/* handle accelerometer timestamp and FIFO data parsing */
> >  	if (st->fifo.nb.accel > 0) {
> >  		ts = &accel_st->ts;
> > @@ -507,12 +520,14 @@ int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
> >  int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
> >  				     unsigned int count)
> >  {
> > +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> >  	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
> >  	struct inv_sensors_timestamp *ts;
> > -	s64 accel_ts;
> > +	s64 gyro_ts, accel_ts;
> >  	int ret;
> >  
> >  	accel_ts = iio_get_time_ns(st->indio_accel);
> > +	gyro_ts = iio_get_time_ns(st->indio_gyro);
> 
> Sashiko calls out correctly that there is a race with devices finishing
> coming up that might be hit here.  Probably need some sort of presence
> check and locking to be sure those are both valid.
> 

While I'm not sure how to fix this exactly, I think (attempting to)
test deadlocks I found a bigger issue... I don't think my interrupt
line is hooked up at all...

Assuming I should be getting interrupts when enabling the buffer
(and also assuming I can do that with sysfs) I'm not getting any calls
to the IRQ routine.

Would you know a better way to test the hardware buffers? Thus far
my tests for data correctness involved either `monitor-sensor -a`
or reading the values directly from sysfs.

Assuming I am in fact working with a device with no interrupt line, I
can just modify this to remove the hardware buffer stuff and the IRQ
stuff and work with an even more simplified driver. Probably going to
miss the 7.2 merge window at this time, but still...

> 
> 
> >  
> >  	ret = inv_icm42607_buffer_fifo_read(st, count);
> >  	if (ret)
> 
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> > new file mode 100644
> > index 000000000000..8d59156086b1
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> 
> > +
> > +static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> > +	{ },
> No comma. Check for any other commas after terminating entries like this one.
> > +};
> 
> 
> > +
> > +int inv_icm42607_gyro_parse_fifo(struct iio_dev *indio_dev)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> > +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> > +	ssize_t i, size;
> > +	unsigned int no;
> > +	const void *accel, *gyro, *timestamp;
> > +	const s8 *temp;
> > +	unsigned int odr;
> > +	s64 ts_val;
> > +	struct inv_icm42607_gyro_buffer buffer = { };
> > +
> > +	guard(mutex)(&st->lock);
> Sashiko thinks there is a deadlock here as this lock will already
> be held.  Report looks correct to me + same bug in the accelerometer case.
> 
> I'm surprised you didn't see them in testing as deadlocks tend to be obvious!
> 

Yeah... about that... turns out my IRQ wasn't firing correctly so I was never
hitting this path. I suspect the line isn't even hooked up!

> 
> > +
> > +	/* parse all fifo packets */
> > +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> > +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> > +				&accel, &gyro, &temp, &timestamp, &odr);
> > +		/* quit if error or FIFO is empty */
> > +		if (size <= 0)
> > +			return size;
> > +
> > +		/* If the packet size could cause us to overflow, return. */
> > +		if (i + size > st->fifo.count)
> > +			return -EIO;
> > +
> > +		/* skip packet if no gyro data or data is invalid */
> > +		if (gyro == NULL || !inv_icm42607_fifo_is_data_valid(gyro))
> > +			continue;
> > +
> > +		/* update odr */
> > +		if (odr & INV_ICM42607_SENSOR_GYRO)
> > +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> > +							st->fifo.nb.total, no);
> > +
> > +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> > +		/* convert 8 bits FIFO temperature in high resolution format */
> > +		buffer.temp = temp ? (*temp * 64) : 0;
> > +		ts_val = inv_sensors_timestamp_pop(ts);
> > +		iio_push_to_buffers_with_ts(indio_dev, &buffer,
> > +					    sizeof(buffer), ts_val);
> > +	}
> > +
> > +	return 0;
> > +}
> 

Thank you again for all your help.
