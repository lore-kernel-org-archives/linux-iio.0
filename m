Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011037.outbound.protection.outlook.com [52.103.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F47261B9C;
	Sat, 16 May 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896273; cv=fail; b=RpInO9+u8nZzAoPrNVInJQwKuiMtfxR5APGCqFf37xxPI6P0sYgSQKW+ttiVBFT8hYJespwceqTzRr/LlxGOPlogx/613oXgZdc/ktEQW8MuW7Wc+TTlaVPtHy4UWSiPjDYcwWwh5KXl1a+INEIby5wwoezIQEXVEVp5wMLRFPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896273; c=relaxed/simple;
	bh=r9XfuEJfbAh6rXbDMPAH8Q9lfx/h2q5ojkEnZY68XCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VKqlOZN5TnfxGJ0PT7BHYiFWXr+7rmPkvIAK3H9ZK8uazg8E4iYtTW9wNbwriMhj3A2X9a2boGz9f8Eb7KBmootJGm8kUCL1uI6PEBLvfNrxuxezb500kUjM9eg5pvMgQEee9LRZ0hwg8AqEPUUhQP/T7XwD0np19pHf6BWo614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=L1E7aQq/; arc=fail smtp.client-ip=52.103.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="L1E7aQq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0DNVBS6f9MueHpKQ9jb1fyjj0v3DDxhAABTJJDIUdaQHiRxesS9np9JaIpzDcnrXlZtZHygeUlc3C1xCFc1Zwjk/tlQK16abMmgM9Jombr2yx0mF5XMLdoOKJYCWGlzDZTyIvktkRFbnGPT7J55mBue1vSnk7FIrkmPag1lu9c0cZFkJC+ce3cJXsJmwh09E56VbxTzaY0vDYATB7sWoFVEBsiCpiPk05uD6/2IA8MskTSBIlHTDruGafM2bHFY3oDbPtpE+QW667zxsR2KEWzG5bsbRzDmLmXNK4PQnL92s36fLC6IBl4EJDLZOIbU0XZk8zFlJ06fPyhUC7Loig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DmHWLtuoOLI/2ijXidlhEqFplwKkYM0umj5rkugd0c=;
 b=ccwTFBpbGpTJTCr5ehEZB66h/4Ag5v7nzE+LwJ9DtOEtvqyZQnyJWOuKBg+oFQItT4PiMduivBLBtIf1U8JJgiY/dRSYS5p1pGUgPxUVWRPUoXlG4hHKPgFxooDyYD1qew2zYwVFVyelVPkGzCoNAO4c1Wroc8i44l6pGAQO3lA8GpuWaU3yHV2tNVKeFsyowGc67fa2j80b3RA/cSsxxWPyO+3VIJc8vh4Q5fhVL4gVvKyWleFAbT2ACLmYRPVo6yl7STVtqPeZBBX9/txens7YA82MUumr08Bt5xmMKXf1q2XcHvDf35wSrPaPxZqq1Mu6pfuSZavGIyf6myFPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DmHWLtuoOLI/2ijXidlhEqFplwKkYM0umj5rkugd0c=;
 b=L1E7aQq/pPeTPaTMajr8Q6tq6GwjH89urAKvPI6gmDrndPSpFvHrRSO7f0hrUqYxPB8o0TaV7rdG1qK0AqDXnt7OVRsh2rSgsjYu0LF3lmL6LHaS7TwO27RuBF0UZ8Z06bYAp6IKGuyHa5yTXbSHSnS3J7t8qu5+9hnADmap9jAblkeTnEDMcGgxBuSjIE5X/egz7XHFm/Je2BD+QCgixsS/o/H5IFCApQH30U4+AeIUcq/HsLTHQuwXj3JnTkcjE8V4bmdTWIygkKFDpk1C4G1FHLmdw3yMQdro09kMxY9u1OGYh8eM29vw/9M64pXBYfOigD1TtbsXeg6ZpH4M4Q==
Received: from DS4PR19MB997335.namprd19.prod.outlook.com (2603:10b6:8:34a::23)
 by SN7PR19MB4766.namprd19.prod.outlook.com (2603:10b6:806:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Sat, 16 May
 2026 01:51:09 +0000
Received: from DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8]) by DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8%4]) with mapi id 15.20.9913.009; Sat, 16 May 2026
 01:51:09 +0000
Date: Fri, 15 May 2026 20:51:01 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V7 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <DS4PR19MB997335152F245D758A97162671A5052@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
 <20260515130018.237378-4-macroalpha82@gmail.com>
 <20260515193102.123b664a@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515193102.123b664a@jic23-huawei>
X-ClientProxiedBy: DS7PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::7) To DS4PR19MB997335.namprd19.prod.outlook.com
 (2603:10b6:8:34a::23)
X-Microsoft-Original-Message-ID: <agfNhbPvZWF2X-sn@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR19MB997335:EE_|SN7PR19MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf6d33f-35c9-4e16-5f4d-08deb2ed9964
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|5072599009|41001999006|12121999013|24021099003|37011999003|25031999004|23021999003|51005399006|8060799015|6090799003|3412199025|440099028|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+K4ZX0qCH7Ebmf5FhmkEV5rliZc7ax53oNbpqvMm5UZTKg+S2qqXfoCtT6C?=
 =?us-ascii?Q?KTBn7sL0ZHQmZ7wAmehzEj8yQOilAYLbBG1to8yTykBNd2a2gq7S8Wp/DA68?=
 =?us-ascii?Q?t9Cl22d8N6+iv4XZ3Ip2GziwlNeeZNEKqki44TL2ZbrR90uDqB5ithlIQMZ+?=
 =?us-ascii?Q?GXxm/MoSAV+ihjQ947z0GYhCzBxenqtW75t8urKeFI48GEScLbbcZLXAmU5m?=
 =?us-ascii?Q?dJ1SbBU37RCcGyol8NHrNH2BjCcq/Irdh4Vl1iNCbVFQsA34XlX8wxWb6rjN?=
 =?us-ascii?Q?a8dyxPzVxK5Ie1wjtPVGzooxlXlYsbhovge77k/E32kK185yT9tHpEEK+4AG?=
 =?us-ascii?Q?R8lbGCpmq0RwDP4hfgy/fibS2DHRaWHWcL3fSqv4ficruNJD0qOG4fu6Qrwr?=
 =?us-ascii?Q?MbGBrYCjYzkR0J0FWvxulGMMqwNB+HPxXBmhqH7i2eSxwj3nfqK4F57iBF80?=
 =?us-ascii?Q?SZfBz+gXPWbZIglWlr49OmJG+zxxzCzxPks5idUWxfbgK4OyMiUQSoPCW5By?=
 =?us-ascii?Q?0f9D9gY4Q9g1ORh+YmXna6q/DFdbDva5s5SAIBO+rv6V+XV9p+j/t8Befs9J?=
 =?us-ascii?Q?W57l5V7CxcLMbtBwpwKT1kcHyZ7ghclz9XzlBhmtZt7K9J5ijKxsP4segi8Q?=
 =?us-ascii?Q?xpHRP1pekiRd07+ehjbXnwJliokzsQZtxpV7vRcczy/U/sAoHju2IdPeiGcy?=
 =?us-ascii?Q?Ij24EBNtU4gjnakG0AQBAW4f1OuqpdhpL5cppQh/uMQBdsGhZ01pPZE9oCA9?=
 =?us-ascii?Q?2R0aOpwjrMubHwmlX3RZsajT2xg5CDqXf6cYOxDWpvPJqhGTGAJ5k2lNcg/u?=
 =?us-ascii?Q?1FTwJB0joSvawnHDEnxdGEDJF56XFb/cKm67qlZn0645hv8Kgov7E/YBudI5?=
 =?us-ascii?Q?ZKVD2dsqCSSHuso/zbZQIptBkesFsKE735h4qHjPVkehLk0u+VWrtSdGX4Y3?=
 =?us-ascii?Q?BEKj+6qKkRdYksCN0Rfd+0vY5O3XTMibpTLJEkf1+TnHGw11U1XSmpPv4XO3?=
 =?us-ascii?Q?wWxPOvjuye/alZRW2HBH8ftqVxp4JJ04eKG3CQ0Rb7t3CQpB7ZkTyXCFsX4y?=
 =?us-ascii?Q?t2LTpTKYxBuO3PQlxKcMLNy/NZFZu0Rrd1zVIO1UqrAkerIq6cln8MVc6MoW?=
 =?us-ascii?Q?UbBWj0oCcT7t?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?junCF/yEj3F6GeEoWym2CsjZJStv7yJoW37hytTPAGRUfSELpxRxf67KGVLU?=
 =?us-ascii?Q?UEWwdZKnVGnmZrpXzo6iVHvflk2oyGY9KPviQDBQyoXW+XP+cSyDf0Jz25m/?=
 =?us-ascii?Q?outc5sTsa6P16LpWXdY7ogXWqCVPY4UeWU6mGJVONXv2uBpsj0Qm6Uvl6v3H?=
 =?us-ascii?Q?ZR5MXuIhgjzM/LtIq6QvypAxstsxcUXhcwusw70genWgsh/qzW8zAs5uYW+d?=
 =?us-ascii?Q?G+LpLeplU62dRJH7HuLtvNbx76847a2vPz3QPu+jmnCadsAtqLUwAuFh/z7g?=
 =?us-ascii?Q?zc3XpvyFMCsDhB9XdyUNLpiIoyozQw6iZUzre701GQ1Jo80Tw0b66r+Bfetd?=
 =?us-ascii?Q?X9q8I40a6YUHCwlGU5HkriiM51NWszQszGNekEvVI5go4bSR2PAfO/dYkw38?=
 =?us-ascii?Q?s89vkZn0k3rdRcPrp8mCZy+suHoXFAgBGUTwc1QEG0mFEKzkb6ZaEDGiE3SA?=
 =?us-ascii?Q?jyp+CD6LzpQZGfjRTw27gSYotu7HKjuuINLgoeR+KutIbeXhHYXMOGCH5Djc?=
 =?us-ascii?Q?L4m3VzEfks3imcfNAWM8Yy1cMnD1W+1JjHnbvgq8teUGNwDXLuyiO5glzQ8f?=
 =?us-ascii?Q?je8Rud5Wr/j7wxrZhrgKVRRM6jT8prq5VrtPqPQDiSmgPOO0wkrLr0BKk0eV?=
 =?us-ascii?Q?VQayZLxbdiWEWeKQWqLIE/hH5sTR+th+8PtVJFUEps4B/cPutkUWLUv3nLcH?=
 =?us-ascii?Q?ZF6dU7M/zEHTed3DzQ5yYoTABHc2Jez7RqhrVaCBl7B5QwW8k2R9U8TiJTnI?=
 =?us-ascii?Q?xeEB7wiiYcHGyCZx3beLa4QUKlo1NWev75Aol8kvH1R5jEe4E6hUOxtFflL5?=
 =?us-ascii?Q?LZ3Yvx0dKAC1zfZqlnU1NNuwFkJVDKAvg6BDCyHczTcp5xIE1cE+Pe/csfn+?=
 =?us-ascii?Q?eJo5oO/vc1N5eKkq25zNVpCuyY3UV3+ox/rdSdbc1sF8kwO/cTSZp18Y5zbT?=
 =?us-ascii?Q?qqvRnQWWWcO1PU8wT9GS7C/x3vUoUOZ7aX1uxCWE8TNCM4Yf1gygXKee6gXh?=
 =?us-ascii?Q?66e7fKMQK8tdFSt5hJHmxqJbjq6lhSn5YYhi6dAVI2Cqd3loWy0XsyxD+yxL?=
 =?us-ascii?Q?a4XEoK23SoMkxYwKp83VdMywhR2zCQXMfrKt0nirxwOD74IDNLNcHsRYheTS?=
 =?us-ascii?Q?aCLsDLDX1Mn3j2rtptnyo+mC7wwrxy4cnzq4SgR7Y1TQT75JR/iu//ezJTY3?=
 =?us-ascii?Q?j7tqy6TBAJAG2lHBJNdsrVcyzOw9My7A3p7+ONNiQVLvnf1AXMoehOkFaWB1?=
 =?us-ascii?Q?Ezu7pfJ2VucJYkj3fVAJ5MbmBsw5digwQemLvdSi2DxH4oHWmGOyf+NjGzFp?=
 =?us-ascii?Q?DjpPSO+BDY33lwIJrom3AUV6rmnqTi3rbGSr0VGax54z0RQdDjCRvhQ7AVrs?=
 =?us-ascii?Q?XdqfAUgYNZDdFIxvZAidGVKZXPhvtw7YZ1gJBUfQbua3PFbZv1isjw5BLnm4?=
 =?us-ascii?Q?cPte/DltIFLOZapIYgdS+UebyrzQEzcK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf6d33f-35c9-4e16-5f4d-08deb2ed9964
X-MS-Exchange-CrossTenant-AuthSource: DS4PR19MB997335.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:51:08.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4766

On Fri, May 15, 2026 at 07:31:02PM +0100, Jonathan Cameron wrote:
> On Fri, 15 May 2026 08:00:08 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add the core component of a new inv_icm42607 driver. This includes
> > a few setup functions and the full register definition in the
> > header file.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> Sashiko led you into the weeks with irq request return values.
> It was less broken in v6 :(
> 
> As to it's other comments on checking for line high/low values (0x00 / 0xFF)
> for whoami is something we don't normally bother with but you could if you like.
> I'm fairly sure we've had both those values turn up as valid in some devices
> in the past.
> 
> Otherwise just trivial stuff I noticed whilst having a fresh read through.
> All stuff I might have tweaked whilst applying or just let through but
> seeing as you are going to be doing a v8, please take a look.
> 
> Jonathan

I think I'll ignore that comment about the high-low values, but it does make
valid points about using the wrong call to invalidate the regmap cache and
also the wrong call to set the SPI_MODE_3 stuff.

All in all I'll try to post another version in another day or two with the
recommended fixes (as best I can) and see if it still complains. I'm expecting
a few complaints like the 0x00/0xFF or some stuff about "keeping the temp sensor
enabled" which is a non-issue per the datasheet. Hopefully I'm near the finish
line either way.

> 
> 
> > ---
> >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 207 +++++++++++
> >  2 files changed, 541 insertions(+)
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > new file mode 100644
> > index 000000000000..1916e0b08bca
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > @@ -0,0 +1,334 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2026 InvenSense, Inc.
> > + */
> > +
> > +#ifndef INV_ICM42607_H_
> > +#define INV_ICM42607_H_
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +enum inv_icm42607_sensor_mode {
> > +	INV_ICM42607_SENSOR_MODE_OFF,
> > +	INV_ICM42607_SENSOR_MODE_STANDBY,
> > +	INV_ICM42607_SENSOR_MODE_LOW_POWER,
> > +	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
> > +	INV_ICM42607_SENSOR_MODE_NB
> > +};
> > +
> > +/* gyroscope fullscale values */
> > +enum inv_icm42607_gyro_fs {
> > +	INV_ICM42607_GYRO_FS_2000DPS,
> > +	INV_ICM42607_GYRO_FS_1000DPS,
> > +	INV_ICM42607_GYRO_FS_500DPS,
> > +	INV_ICM42607_GYRO_FS_250DPS,
> > +	INV_ICM42607_GYRO_FS_NB
> > +};
> > +
> > +/* accelerometer fullscale values */
> > +enum inv_icm42607_accel_fs {
> > +	INV_ICM42607_ACCEL_FS_16G,
> > +	INV_ICM42607_ACCEL_FS_8G,
> > +	INV_ICM42607_ACCEL_FS_4G,
> > +	INV_ICM42607_ACCEL_FS_2G,
> > +	INV_ICM42607_ACCEL_FS_NB
> > +};
> > +
> > +/* ODR values */
> > +enum inv_icm42607_odr {
> > +	INV_ICM42607_ODR_1600HZ = 5,
> > +	INV_ICM42607_ODR_800HZ,
> > +	INV_ICM42607_ODR_400HZ,
> > +	INV_ICM42607_ODR_200HZ,
> > +	INV_ICM42607_ODR_100HZ,
> > +	INV_ICM42607_ODR_50HZ,
> > +	INV_ICM42607_ODR_25HZ,
> > +	INV_ICM42607_ODR_12_5HZ,
> > +	INV_ICM42607_ODR_6_25HZ_LP,
> > +	INV_ICM42607_ODR_3_125HZ_LP,
> > +	INV_ICM42607_ODR_1_5625HZ_LP,
> > +	INV_ICM42607_ODR_NB
> > +};
> > +
> > +enum inv_icm42607_filter_bw {
> > +	/* Low-Noise mode sensor data filter (bandwidth) */
> > +	INV_ICM42607_FILTER_BYPASS,
> > +	INV_ICM42607_FILTER_BW_180HZ,
> > +	INV_ICM42607_FILTER_BW_121HZ,
> > +	INV_ICM42607_FILTER_BW_73HZ,
> > +	INV_ICM42607_FILTER_BW_53HZ,
> > +	INV_ICM42607_FILTER_BW_34HZ,
> > +	INV_ICM42607_FILTER_BW_25HZ,
> > +	INV_ICM42607_FILTER_BW_16HZ
> 
> That isn't a terminating entry so it should have a ,
> Rules on this are a bit obscure - but basically _NB type entries
> should never have a , anything else should - even if it's
> a register field enum where we know all values are there.
> 
> > +};
> 
> 
> > +/* Sleep times required by the driver */
> > +#define INV_ICM42607_POWER_UP_TIME_US			100000
> > +#define INV_ICM42607_RESET_TIME_MS			1
> > +#define INV_ICM42607_ACCEL_STARTUP_TIME_MS		20
> > +#define INV_ICM42607_GYRO_STARTUP_TIME_MS		60
> > +#define INV_ICM42607_GYRO_STOP_TIME_MS			150
> > +#define INV_ICM42607_TEMP_STARTUP_TIME_MS		14
> > +#define INV_ICM42607_SUSPEND_DELAY_MS			2000
> 
> Can we have spec references for these?  We often hit problems later
> with devices that are a little bit slow and no one is sure if it's because
> the sleeps are wrong or device is actually out of spec. Hence
> it is useful to be able to quickly check these.

I took these from the driver I basically copied wholesale and changed
the registers for according to the datasheet, but I didn't take a very
close look at these (which I am now).

The POWER_UP_TIME_US, assuming it's the same as "Supply Ramp Time" from
the datasheet is 100ms which matches. Likewise, the "Start-up time for
register read/write" listed under "Power-On Reset" shows 1ms, which
matches.

The ACCEL_STARTUP_TIME_MS should probably be 10ms, and the
GYRO_STARTUP_TIME_MS should probably be 30ms. I don't see a startup
time listed for the temperature sensor but I do see "Stabilization
Time" which lists 77us. Gyro stop time and suspend delay time I cannot
find a reference for... logically if those values are needed I think
they should likely be the same as the gyro start time and power up
time, respectively right?

The values I am referencing now appear under the electrical
characteristics section (section 3) of the datasheet for both the
icm42607p (my test devices, over i2c) and the icm42607(c).

> 
> > +
> > +typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> > +
> > +extern const struct regmap_config inv_icm42607_regmap_config;
> > +
> > +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> > +			    inv_icm42607_bus_setup bus_setup);
> > +
> > +#endif
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > new file mode 100644
> > index 000000000000..9784709319b9
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 InvenSense, Inc.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "inv_icm42607.h"
> > +
> > +static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
> > +				 const struct inv_icm42607_conf *conf)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK,
> > +			 conf->gyro.mode);
> > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK,
> > +			  conf->accel.mode);
> 
> As below - I'm fine with these going on one line (first is 80 chars, second just over)
> 
> > +	/*
> > +	 * No temperature enable reg in datasheet, but BSP driver
> > +	 * selected RC oscillator clock in LP mode when temperature
> > +	 * was disabled.
> > +	 */
> 	/*
> 	 * No temperature enable reg in datasheet, but BSP driver selected 
> 	 * RC oscillator clock in LP mode when temperature was disabled.
> 	 */
> 
> Basically go up to 80 chars. Here I think keeping RC oscillator on one line
> is a good idea though.
> 
> 
> > +	if (!conf->temp_en)
> > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK,
> > +			 conf->gyro.fs);
> It's under 80 chars on one line so don't wrap.
> 
> > +	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK,
> > +			  conf->gyro.odr);
> 
> As is this.
> 
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
> > +	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
> > +			 conf->gyro.filter);
> 
> Whilst this one and next are a tiny bit over 80 chars, if you want to I don't
> mind those being a little long as single lines.
> 
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
> > +			 conf->accel.filter);
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG1, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->conf = *conf;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + *  inv_icm42607_setup() - check and setup chip
> > + *  @st:	driver internal state
> > + *  @bus_setup:	callback for setting up bus specific registers
> > + *
> > + *  Returns 0 on success, a negative error code otherwise.
> > + */
> > +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> > +			      inv_icm42607_bus_setup bus_setup)
> > +{
> > +	const struct device *dev = regmap_get_device(st->map);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val != st->hw->whoami)
> > +		dev_warn(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> > +			 val, st->hw->whoami, st->hw->name);
> > +
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(1000);
> 
> Do we need an explicit sleep here, or is the idea just to save on
> a read that can't succeed in the poll that follows?  I'd be tempted
> to drop this if it's not absolutely needed just to avoid explaining it.
> This isn't fast path code. If we need to leave the device alone after
> reset for a bit then a datasheet reference is needed.
> 

Data sheet only really says that the time required after a *hard* reset
is 1ms, it honestly doesn't say anything about a soft reset.

I also thought I got rid of the read_poll_timeout, since I'm already
waiting 1ms... if you think this fsleep is needed or not I'll defer
to you.

Honestly this whole path thing got messed up when we wanted to code for
3 wire SPI. For 3 wire I need to make sure I enable it as soon as the reset
completes, so it's probably not even right here. I need to add bus_setup()
before the read not after. So to support 3-wire it needs to go:
bus_setup()
whoami check
reset
wait (maybe)
bus_setup() again
check int_status (if we can after the bus_setup)
do the rest

whereas if we explicitly say no 3-wire then we can drop the first bus setup
and use regmap_read_poll_timeout to get the status.


> > +
> > +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> > +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> > +				       INV_ICM42607_RESET_TIME_MS * 100,
> > +				       INV_ICM42607_RESET_TIME_MS * 1000);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "reset error, reset done bit not set\n");
> > +
> > +	ret = bus_setup(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> > +			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> > +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> > +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return inv_icm42607_set_conf(st, st->hw->conf);
> > +}
> 
> > +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> > +			    inv_icm42607_bus_setup bus_setup)
> > +{
> > +	struct device *dev = regmap_get_device(regmap);
> > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +	struct inv_icm42607_state *st;
> > +	int irq;
> > +	int ret;
> > +
> > +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> Trivial but if fwnode is only used here (I didn't check later patches) then
> put the dev_fwnode() inline.
> 
> I've never really understood why we don't have device_ variant of that - perhaps
> because it's hard to come up with a clear name.
> 
> > +	if (!(irq > 0))
> > +		return dev_err_probe(dev, -EINVAL, "Unable to get INT1 interrupt\n");
> 
> I assume this is in response to sashiko saying fwnode_irq_get_byname() can in some
> corner cases (where I suspect things are broken enough the system probably won't boot)
> return 0.   If we are actually going to defend against that then you need
> to special case it.  New sashiko review correctly reports this breaks probe
> deferal if say the interrupt chip driver hasn't loaded yet.
> 
> 	if (irq < 0) {
> 		return dev_err_probe(dev, irq, ...);
> 	if (irq == 0)
> 		/* Odd corner case... */
> 		return dev_err_probe(dev, -EINVAL, ...);
> 
> However I'm deeply suspicious of whether the code paths that return 0 can happen in
> practice.  Given you have a suitable DT, can you try seeing if you can actually make
> it return 0 by messing around with the interrupt mappings?
> 

I will mess with it a bit, but I think I'll just go back to the simple
(irq < 0) then return dev_err_probe(dev, irq). Worst case if it's
wrong I'm in good company. :-p

> 
> > +
> > +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> > +	if (!st)
> > +		return -ENOMEM;
> 

I sincerely appreciate all your help on this. Here I was thinking this would
be easy and I could focus on a joystick/LED driver next... how wrong I was!

Chris
