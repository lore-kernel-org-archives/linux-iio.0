Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013083.outbound.protection.outlook.com [52.103.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417403BD228;
	Thu, 21 May 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396165; cv=fail; b=lkqSBceWrP5p/TXJ34QEy1zjiT/OqyflMIEfXitiyzE2Z5ZPgVKAT9DXtdc1TF/IZZdAJOHljMYg9DfZFkuXmpQmSuPXcV5glr52hs1oMtrVXoyE8TgRo67Cfi4vB9zDEPUTA1U1Y92vIl3j50Wl0N+9kcKLtfe2lxkyG8ZnKwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396165; c=relaxed/simple;
	bh=i1mDQI+Dsjn8zzkgy1EFi7QHEgOp5mQDYuSrzy018yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BaaM8HmYYxxh/0nRR3JYYJz8gtfbocgbkGBadD+ivBDsmAahmhm8BuhQS0nD9SiFRqltywNVqqYHskBM8KLCFbAEDThaZei8ZKCjJi1f4y1QPnnVUddvSJ64R0QAt3LL32u+hrtSTajugCaVslZFyhNBF19ivU6MSuO+2LLugng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gAOUJxAR; arc=fail smtp.client-ip=52.103.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gAOUJxAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/8+av/RhmHRdotS3B6nErAHBpd7l9cIoqPDHPT8QW714PdkmX29qEgGpQshbYEVK42RTjW56g5a1l09i8SJFWIhqnL4M2AtyT2kXsRSHJfbv8ctUsfLMzh3a9Bj2NuG6C4jK8sSwtQD3JgpwkV9EsK8MzlhvEyGtmsdee65Kqy3wBMf5MRfg/ZE1RiUL0yq+QBBr9ce70hDbmmK6bJtyCTsfcqWu2aZ3Nmktl+UTEgbc/RpOU1xuKJTJSJTb4aSlYhIWdpnSUBAg1l8oyz+VqXcOtusDjO/42q5sGhyokdgVxOtT3loDLNOYgmHW239zbctGYnxBI7MTFypM4Vn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hcr5Li5wI115T0Tor3VH8aCQ5jxR9RXyAOn+os69zo=;
 b=VaqwCpPbQznfBOcbulcdp2rcItVqeAIqaU30qhmEVjIoArLmnUWLqatR3tFPDrDEaxeGJk3VxR19QkA33+iGPpIaMOGIKg7pt4+hBpZmPCXy216TPInZbsUoOWCtuk5icpWGD83z5yUl7EmLm3gdVX9EHUUfdhJqH2SKwdSaMt6w5NgCgJePgdUI/xuvF9qS83AjcS4N5YCdBt4HzoVpnuKFBgcrbG4LGg4FRohpwNR4nrH5hkX2E+222SBGRqjVAWl2xXF5RY29EvXCiuiKYBTSfzoAyYmaWdabe9FsFuO4zVTFBAv/taG5avUCZy4fQHU1b04KSvVjP3hCdodz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hcr5Li5wI115T0Tor3VH8aCQ5jxR9RXyAOn+os69zo=;
 b=gAOUJxARBO1NrDJDUsxoUG8pVWuDuob30hEkivHWlUwKBtXyGLU6MS4Gawjz8cQBC+uv/CQSZF1oqvjEvWhSOgHW8MesRc8QO2SLQyF1L9MjJycOp5MTcPco+n5+SBbpz1IqRidcNoCjgdHIwSPjkfu79Q2f14jm+aHEPzUmwu1TrQh7L55079Uw2SBEXnRTMmarY6CAujdsl6AK3n0F1g+IPXEVIX9tXC4EWX6QuWtIs7MA+o4OFGkEGiD+J/kyOllrXasgIdlha5KiiQXURVx4t0gaEhd4qHsBd58bwnRwmClMh1nD0KOKVqoXe0gVgu2ZV8NN+2ceNq/cKve9Iw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CO6PR19MB5419.namprd19.prod.outlook.com
 (2603:10b6:303:14e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 20:42:41 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 20:42:41 +0000
Date: Thu, 21 May 2026 15:42:38 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V8 05/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID:
 <PH0PR19MB9973386EF146AD6590DE5508F5A50E2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
 <20260518200526.458421-6-macroalpha82@gmail.com>
 <20260520181353.0a0371cb@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520181353.0a0371cb@jic23-huawei>
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ag9uPpL5BN2trJSo@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CO6PR19MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe660f0-614b-4e86-7aba-08deb77980a2
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQmM7KNZxyCfd+5xcyAOZnIEmumAQVuHi7MmdhTJfF5hRYAhfvXSrq/9TY3ve1Iis3n4BqS2AiqvYlEGRH0RlUH1USS6OoaiayTOpR/K7eEvOo3pwwKhYtXTW9FZiumjwsf74djTLzQ2ivTJXXyLZpAbPL4DTVJGTLGDjDpYpl9IS4uO9es/Czql4Z70d0m4MPVrp9l3Y5dPfmohQUuIcbyhmKaaNkKfSqjeo0zWCbF/BmFeE/MwozKY9IMXwBDDbb6ATtzeTswH1uQqLTEkDMrsEtEnDcuKlJYtrp/gvXSdjCgwvSXPVKU5IbxuDmGSZEthApuv04RDZUxM42bxjlpTJt4YouhOWrbBVWDB088umvQ6GjXlJjQm5m0SEyUpD47iA4krqiu11EQ787Nmp0852JuDxuS/WNss28pT4P3wbNoIZCPmDOxSUbWzjzWfFequXKIo49ZOd20qMPPnIZHsm3uO48R14UcTuFgGM3/PJobyT+Zl7QMCk/OBS0MkkRwWbPgfYUaYPWvmiOAgNE3aUDz4oVj07mfIf2FQD9J9gYiZsofPoOdyydf9pwVD7SQoilHYIBiCM8gbLEFroX9FUnV9NyoTNgOklo0Yn3xjlaJJB9LoGMdMtPTViW1CAjP/pDJ+asPKdWDqnfHZvTBsl1c2igzXI9afHayNyOEKrOsAV460aPdxkgviAKbbXjZzLX07qmdkV1JDuCZDs4TAmrdcmlVgPf8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|8060799015|19110799012|23021999003|41001999006|24021099003|6090799003|51005399006|37011999003|25031999004|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbOGB5XB4ONsCNNB/vMS+uKnLbV/NM2D33iwdmtnVKSycSau0P+XbBv9+bl8?=
 =?us-ascii?Q?aUccc2l32NgUZcJvtlCLkllgEe1DTQPjQZWqX4+eFNMw+MajkO29TLQZZCdU?=
 =?us-ascii?Q?6LdHQWacqRxHh5qjA1DyDy3MhrjO+YrpglWN8MWBha26SYvBagIr6dRDPyz4?=
 =?us-ascii?Q?JZBbOtnl/FWyXLsi9dTNQoz+jdCIK/01GMW7N4XQ8F/RsqfkAEe7nKL5udwi?=
 =?us-ascii?Q?gn3WuJeE6Pt55LBMWjIunmNfRrpG3hTN0jQA81nUwpPf0DIRQbsrbRumItI8?=
 =?us-ascii?Q?oL6VRXgia3FNZD1FWnxEvWgpsvpK+Q+6EzHhOE5PNd7zPYSnUbQdWvmxOtAL?=
 =?us-ascii?Q?MtJtk/7VYwY+EMmaAXXfm7H0XxwCexAt8JLnR3SwB/3NCaYjSMyDxegqpJO3?=
 =?us-ascii?Q?1mQf74McQ9VFjFfUG87eJefwijRG4k1zhLSUkvKkzwuJl2j6JsJ2rN7jrJjo?=
 =?us-ascii?Q?RWVe0v7vyONeHFmYrBgsvaDJzcesFji8AUijdd65xoPf7UlwNzKy0VTjuHmD?=
 =?us-ascii?Q?Pq75cqmg5XECMse96DHSxveUppd27eJeGKNC/NeAjYXAsR0WWE7WE/P6MhEp?=
 =?us-ascii?Q?WkDzu1jIbDI6RaqMnKrX0fyvLq4lp6ifTkahr/1IyZdH79dkCub69ps2w7EV?=
 =?us-ascii?Q?VlHricy6RNS+ppUtYGVOUnC2xBEJ3FINevOFPa9J1gpQt1+bLPs6dlvE/9OK?=
 =?us-ascii?Q?jsLLAXtqWrrs2zHT/e4FtDP8/0XtnWj5aOCx/0F6kPjg1rK3KW2HU3Gi/LDB?=
 =?us-ascii?Q?ug53KrQDapRg1nxw9WRpwlwCD6tGnWQbSf9pXWovSNXqX64jdxsqlDNGz6Kw?=
 =?us-ascii?Q?gEoGBG/e41235vHo9PX6+N6u+EEPHfF7vhI4EyGxju5eobY4eJs0GYLgFBAH?=
 =?us-ascii?Q?TPx/U/EydnBpbQTUmBTajljemlQ2tR9/3MEg3x+N218h5TESyxVaMJh7p1LV?=
 =?us-ascii?Q?uqcG/mwrBh/CUV2uS5ZBZ/Axe/GbofUgIvo3q8mt8UrPk5699/jiohEBfKHm?=
 =?us-ascii?Q?lWTcTfaIe32eKYL68rhrYe1aFyXFtIzTEJXN9q/lrJC3V54=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmNvDXi9Z5QZSaUF3r0h6FM9j29upwMUV5At+AihR1o5Of6T2MWiYfqeFP/l?=
 =?us-ascii?Q?0VQUbC0hSbirR6QqAfhIrEZiismT0J9ZXEzZTwCAuM9alJjKiL+Q9diz1mj9?=
 =?us-ascii?Q?yYChvyU0Z30VzMJrZbPNC2fz2/BvUhe8gUZZe+3wCFfGuKG2/uC5KxUUDVLV?=
 =?us-ascii?Q?+HwYPX9YLeUJ92a+2+KkU0Ps+tprbb9xe3vIaS+rsjaoaZ43NcZAgmLDCNP+?=
 =?us-ascii?Q?AbLkOF9IE/RXkMAjoci7ydo3vkktJFlQJUP2vc0dmqyIUG9gKLJP6szj8/WT?=
 =?us-ascii?Q?iZhMnTiG//BtqwwDqgclGIBu1v6mgdg2IwURzGUPo6iGDHsGNwQLXDJdXFh9?=
 =?us-ascii?Q?1WAiWqyRuw1+foYGR6+YhI1nqjQmAmBRFCeaA+na2tE49q7l0U3pkw3IBQLD?=
 =?us-ascii?Q?YQ4WD+n9vqMWBZLmfBdrA7DmTXRAf1m/uDc6wZKtymi8gE8wRtz7P2huyaRB?=
 =?us-ascii?Q?l6yAvHKChOPO1dDCBb5Cj1CO3Zxu/z/SBesxUKNYH5+3EogAeB6FATnrAlEJ?=
 =?us-ascii?Q?uPWgxLASR9qc+JBeVaoaBEGUkg461OkyVFp969YjPin+3QyAg4kz+lvsz/6Z?=
 =?us-ascii?Q?xwxj1O9tvL+RDWeVF3xswSP2cNX4RLuMdZPDlpvjVMqaiHnlotxf/GEtJxeo?=
 =?us-ascii?Q?LGRDTHYOvF0dMXCzpIpbC2IWm6JwfSObur3gP5nCtUGU73bH64m7xcdxHXVR?=
 =?us-ascii?Q?997A8VfZ6a3zzP6a2I3JWETfN7oULMPnigjb70vgWIaotdrEKX4epykh18qk?=
 =?us-ascii?Q?x29sauP5mBJanEpjR93LzWUH2folU/E+7BszhdazXcXvI+Wha1RO7VXreVKh?=
 =?us-ascii?Q?ICdzO2aEUId3ykAD7h5cNRnB50qtG4kLmykTz/wxPxc54IJDSjb2kqQ8/lDb?=
 =?us-ascii?Q?KywrBKNxTyWy6PdBSUMDf86Ox3W8Benj6z8RKsYop2Hllvs3ks9Cu+zsbpC2?=
 =?us-ascii?Q?j7rSJuMkUlatoRW74xL1pGU79rRRrn3+ijOcBT0IGUl/b83mQ0PLfMYqEIxM?=
 =?us-ascii?Q?481uANKxLZPcySSMEg40IQaXMOj+eTV713cl1dl5i4KKwuiXU0EI0iIMvwW1?=
 =?us-ascii?Q?RDauWEuR/ACy5ElSJObg/i8eb94wVzn0SFF5Nw4X9GQdgYFJhDkDPuQOSBGo?=
 =?us-ascii?Q?xWNYzOih4WSRpKf3FTiBLEtXq4v4r2j4trYapB8g/Rze7k3moDmQeLJNoXak?=
 =?us-ascii?Q?gDxmLZb48i0BDSXhDiMeSUALhqa40jGRbGbh/BmYdO+66zjdFeLBKLdhvxdO?=
 =?us-ascii?Q?8377RqymnUWKlGfFY1FHsOVZAqvj1/GInFIbcahoYsLJAvx5hHuF8MShvj0t?=
 =?us-ascii?Q?P7BCkwfHbo5yiMZ6JE3uY3qfdE1OTtSff2SFZzyH5zMQmHeO0Glpf841a9aV?=
 =?us-ascii?Q?9/tq/1IKWKujw1TcDHLrNPNv1bP1yv141ibYJKRV7TP1al1Hgw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe660f0-614b-4e86-7aba-08deb77980a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:42:41.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5419

On Wed, May 20, 2026 at 06:13:53PM +0100, Jonathan Cameron wrote:
> On Mon, 18 May 2026 15:05:20 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add power management support for the ICM42607 device driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> Hi Chris,  runtime PM is my current place to look closest
> for bugs because we've had a lot of them recently.
> 
> Anyhow, took another look and here I think we can optimize
> things a little more.
> 
> > ---
> >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 147 ++++++++++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
> >  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
> >  4 files changed, 167 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > index 74d8d3d7c890..b05828415053 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > @@ -96,24 +97,34 @@ struct inv_icm42607_hw {
> >  	const struct inv_icm42607_conf *conf;
> >  };
> >  
> > +struct inv_icm42607_suspended {
> > +	enum inv_icm42607_sensor_mode gyro;
> > +	enum inv_icm42607_sensor_mode accel;
> > +	bool temp;
> > +};
> > +
> >  /**
> >   *  struct inv_icm42607_state - driver state variables
> >   *  @lock:		lock for serializing multiple registers access.
> >   *  @hw:		Hardware specific data.
> >   *  @map:		regmap pointer.
> >   *  @vddio_supply:	I/O voltage regulator for the chip.
> > + *  @vddio_en:		I/O voltage status for runtime PM.
> >   *  @irq:		chip irq, required to enable/disable and set wakeup
> >   *  @orientation:	sensor chip orientation relative to main hardware.
> >   *  @conf:		chip sensors configurations.
> > + *  @suspended:		suspended sensors configuration.
> >   */
> >  struct inv_icm42607_state {
> >  	struct mutex lock;
> >  	const struct inv_icm42607_hw *hw;
> >  	struct regmap *map;
> >  	struct regulator *vddio_supply;
> > +	bool vddio_en;
> >  	int irq;
> >  	struct iio_mount_matrix orientation;
> >  	struct inv_icm42607_conf conf;
> > +	struct inv_icm42607_suspended suspended;
> 
> Is this used?  If not bring it in only when needed.
> 
> >  };
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > index e9c81b52f9ef..bc0cefa2fb77 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > @@ -72,6 +73,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> >  };
> >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> >  
> > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > +				      enum inv_icm42607_sensor_mode gyro,
> > +				      enum inv_icm42607_sensor_mode accel,
> > +				      bool temp, unsigned int *sleep_ms)
> > +{
> > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > +	bool oldtemp = st->conf.temp_en;
> > +	unsigned int sleepval;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > +		return 0;
> > +
> > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > +	if (!temp)
> > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->conf.gyro.mode = gyro;
> > +	st->conf.accel.mode = accel;
> > +	st->conf.temp_en = temp;
> > +
> > +	sleepval = 0;
> > +	if (temp && !oldtemp) {
> > +		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
> > +			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
> 		sleepval = max(sleepval,)
> or just assign it here if not later patches add stuff in between
> the assignment to 0 and here.

I'm going to assign it to 0 here (unless you think I should define it
at the beginning as 0) and then tweak as needed. I think this code
here can be further optimized, especially if we make the assumption
that START and STOP time for each sensor is comparable (the datasheet
doesn't say, so I'm going to go with yes since that greatly simplifies
things).

> > +	}
> > +	if (accel != oldaccel && oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
> > +		usleep_range(200, 300);
> 
> fsleep() + add a comment on why we are sleeping in here.
> 

Just going to delete these usleep_ranges since 1) I can't find them
documented in the datasheet and 2) we sleep later on anyway if this
condition is met.

> > +		if (sleepval < INV_ICM42607_ACCEL_STARTUP_TIME_MS)
> > +			sleepval = INV_ICM42607_ACCEL_STARTUP_TIME_MS;
> 		sleepval = max(sleepval, INV...);
> 
> > +	}
> > +	if (gyro != oldgyro) {
> > +		if (oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
> > +			usleep_range(200, 300);
> 
> fsleep()
> 
> > +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> > +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
> I'd use max for these as well.
> 
> > +		} else if (gyro == INV_ICM42607_SENSOR_MODE_OFF) {
> > +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> > +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
> > +		}
> > +	}
> > +
> > +	if (sleep_ms)
> > +		*sleep_ms = sleepval;
> > +	else if (sleepval)
> > +		msleep(sleepval);
> > +
> > +	return 0;
> > +}
> 
> >  
> > +static int inv_icm42607_suspend(struct device *dev)
> > +{
> > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> Could you use pm_runtime_force_suspend()?
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> > +
> > +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> > +					 INV_ICM42607_SENSOR_MODE_OFF,
> > +					 false, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	inv_icm42607_disable_vddio_reg(st);
> > +
> > +	return 0;
> > +}
> > +
> > +static int inv_icm42607_resume(struct device *dev)
> > +{
> > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> Given the bunch of stuff we've run into recently around these
> I'm getting more paranoid.
> Similar to above, could you use pm_runtime_force_resume()
> You would need to gate stuff added later to not occur
> though if it wasn't runtime suspended.

This I'm having trouble understanding. If I use
pm_force_runtime_resume() I'm assuming that either I got an error (in
which case I'd return the error) or the device is runtime resumed
after the call completes. If that's the case, wouldn't my suspend and
resume steps just be pm_force_runtime_suspend/resume, and enabling the
regulator (first for resume) or disabling the regulator (last for
suspend) as needed?

> 
> 
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> > +
> > +	ret = inv_icm42607_enable_vddio_reg(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Nothing else to restore at this time. */
> > +
> > +	return 0;
> > +}
> > +
> > +static int inv_icm42607_runtime_suspend(struct device *dev)
> > +{
> > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> > +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> > +					 NULL);
> Different alignment to above - aim for consistent choices on this.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	inv_icm42607_disable_vddio_reg(st);
> > +
> > +	return 0;
> > +}
> > +
> > +static int inv_icm42607_runtime_resume(struct device *dev)
> > +{
> > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	return inv_icm42607_enable_vddio_reg(st);
> > +}
> > +
> > +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
> > +	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)
> > +	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend,
> > +		       inv_icm42607_runtime_resume, NULL)
> > +};
> > +

Thank you,
Chris
