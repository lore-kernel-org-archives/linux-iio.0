Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010090.outbound.protection.outlook.com [52.103.10.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C743191BB;
	Fri, 12 Jun 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272756; cv=fail; b=jeYy0RovEIJmMUducTqNv66htHNNN74cTLgWJmNyztAoJ2AE1XRe5bYb1HbN7Otzr1u9xUwV+S4/YszECu6DWScqq1nqKAijev+5JzldOkuQYg3Gq93GxCZEMB5SBOeyNODfymST8NlsSSVbtihcOMrY/RNgT5Y9r6GhDdMcXVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272756; c=relaxed/simple;
	bh=vW/6vH6SSWbemc28vBQKDpE1wCjTOBJ3HMg2/MJbvAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufROyIf/YvzzSA6RIKTtftvqemSKncmk7ITpVICk2p/9gtDO+B2URMYBH177SEwKCf9ofihXN+9ur7leR9NOAV/TQPyjXzytMyu8dvtlET9a3lrkWgZKH1sLBXxftf145Oj5+/Ppu02ud6UTBCpod2Zp+hcXr2RxbTaQH3qZ0fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Hr/aTVGV; arc=fail smtp.client-ip=52.103.10.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Hr/aTVGV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBiZHdwElIx1IViMkFC8Y36MUDSXC0T5DazZdktTXq9ifdGOb45WfhrmSFMvwLW8kJOaWpCt6YbOd5vyhXS/fYA8mAqKEVpA05KektBVNLSSzpC+XhUJ6H+V6wFFg1nD8gSEFIdlYEZJgpwBW7BYaRxBqjASyz8X64pFi2EnTVl3ACMtrcZQWGljou1KKbwpdvuSi9pcgQakAwPxgOzlu49AnU1zRA8wubF3IdnqDzvp8YQQROO2oaO98Kn25fPtdkIDeiKENN2iklX+ZYzNyaWmlhbdbrqvJRRTyKEre70B0bgz8wNVPqZfOAbpGEyFD+yh0dR6/qJbyjfGVpLi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD9NDIL9w76waOF+od2YWX0b1tFCVFeKcm8vtwJTqTo=;
 b=viyK5QPpDLgxNI3nxIQJ6K+NYh3qSZvlUaVYA89hJhqxGMDWrHeOSbsdWnELulm7HzsXt9toWCa2/1UDm/CUd6xs0ZfQmZmbACxhUQX6sfISH1UbAA3rCEXVngs1XKi9v0UL8I+O/PoZG+Q6eCxLm09cX9OQaYUi+o6hMZj6QLxUyYiFQ+GisFozFmYju+PM1KRO4+NAOCgPxxjyDA4waN4rdo5X7YB4tUPG7BRiQtyIeovTjh9t6QVhWbr490GU2G8QhmGBUH45j7rn7ynScMWckWUVN7Y2p6UxgkdJ5Ca8WaBsmvE96s952x+HNKOs156FtjRNBlMV5CetV+EjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD9NDIL9w76waOF+od2YWX0b1tFCVFeKcm8vtwJTqTo=;
 b=Hr/aTVGV6cyvVstsLbaHMRpJZsqz7g9KkoN8oTmXFvtR1jAWHXPNBi9yKusYR7uZyo+AOKdg88w/01YiW8ao2dEbqv4kOshrNmyjgOOLs1t6Clynv+wHfE4KRwRxzgyhSAD1a8Q8SPm+E+teZ6LnMUoW4ebK5dcESbFP99IKDZQmMBLx/D/Fmbynem/GQiMr6lU8F5ih/w0+IBkcm4Mz9Ea5uYKv8kObhipe2xOj9tmaLsZvlUMUWtOZMUIdRfezL6E0EEzxHxuTFJY0sR3+sEwQMbdtm8NX7n9PDFwElpFjA7E5X5SeCvENI5egh/sAsd9IhI9G6YuGIW+7BWr0zQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CYXPR19MB8402.namprd19.prod.outlook.com
 (2603:10b6:930:de::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 13:59:12 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 13:59:12 +0000
Date: Fri, 12 Jun 2026 08:59:11 -0500
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
 <PH0PR19MB997338A8FD439C0528B96048BDA5182@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-4-macroalpha82@gmail.com>
 <20260611120943.7119975b@jic23-huawei>
 <PH0PR19MB9973387E29375D4E8F28C6B9D9A51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260611172022.4d138820@jic23-huawei>
 <PH0PR19MB997338CE11110E16E7FB668E3BA51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260612114230.0fd2f391@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612114230.0fd2f391@jic23-huawei>
X-ClientProxiedBy: SA9PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:806:23::10) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aiwQr1dWaDzxU3VJ@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CYXPR19MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e0d335-54df-45b3-22d5-08dec88ac860
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|24021099003|13031999006|25031999004|23021999003|37011999003|51005399006|15080799012|41001999006|6090799003|19110799012|8060799015|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8vH+ONnaZYHJwsxtyBjJ/86tL39Fzd2T0RlkpzZe0PwPFaMkLsVuRv6CIYU?=
 =?us-ascii?Q?ZlPAaMRVmKmBoXA3itMTXr5zA+kRzfVvEaiNKXIe8jzZsUA2q/j8Zc1JqyWi?=
 =?us-ascii?Q?tGzm6wMZvNCiSGjCZhExOiOxdrSXkrqEyL0jwLMAcHtyd5KGWzWLysiHBJjd?=
 =?us-ascii?Q?/+5exk/1dWBt7waVtswsFeKa8/yekVhGR7zGE9hjddEulddvBJWW84YW438d?=
 =?us-ascii?Q?rhPn/am/oNrf9GW4hmyWrNsimtLeIjr5d83qUu1gYIpyNBrw7g3DbGlWvEl0?=
 =?us-ascii?Q?v/6EAdOgvjCY+Org/ZDvkxbf5eXcJlYN0/Y87nJyPiJxRrW7Dry3yLnbDCmh?=
 =?us-ascii?Q?l8Qi2fm0q9ISSLeRvmAvAPKIt/If7/fS/aRtJ1SsQ7GohBkZaPT3wWeyUfWb?=
 =?us-ascii?Q?ipIvZMOhomQXvN/qSEuIUl1cTn2+b4ZHpQvLhFReMKn3mlFuqCSWb0dVcMYt?=
 =?us-ascii?Q?qVj/+nfCrvArJChMOEtXVgOS4vnylCjQDA2yV8knSUhknkpVcI2qbrV29vka?=
 =?us-ascii?Q?igYA2zaSmfjsO2uiZsFypF1Qn8dv+IDlHMdGLFU3jv75uKHnu3HR4bC2aNzE?=
 =?us-ascii?Q?Vur423CkDWP5cgbeOGzrYfKR48MNf5aOEyJLoW6d+EbjEQuElyfl30ehbl4x?=
 =?us-ascii?Q?skzMXBrNUzzoGZmaeOCqi8EDGLNF9D/AYStA0FwEogJAU6HLx6VooURtl2f1?=
 =?us-ascii?Q?Nb0gaTZL1SwZkV/TjcnjTsVMXi6kqnSfLwoA/FPChf3Y3a/8kCjO7/ewo7Vy?=
 =?us-ascii?Q?4veIn/KrrY32p9aqxRoLbHsNtZZY1w5zq3/AyiDBboC6/U67+MCib4NiKBai?=
 =?us-ascii?Q?gFHttyzvqGomuQ/qyMXIILTCAcvIRQLA3GL2UiZZjwF83Gql9UaRGUGV3qlo?=
 =?us-ascii?Q?b+mJ/Xq4d3GpX0MZspuUwrLhIZ7ZVWLox8O9cKHcZE36EgI2rKCmUM80NnYi?=
 =?us-ascii?Q?dXf7igKqGzw/dvVgLeOY9pgmF6odLTEWeVEqPGAC7Btg58KulH2+tzvlSW1k?=
 =?us-ascii?Q?hpHYmuaPIuKAkSZdbnBmC4EMH4+5HhLxFboL3LHGmZcYGuERNjx85j98G/la?=
 =?us-ascii?Q?SqJX0rZaUObPwOLmxOMgy29+h3un+A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+IFLsarxVjSxeRX2nUtBKp8XcYtCuEM+W18jKcbHrZOG818b0RAKZ3Lv/flL?=
 =?us-ascii?Q?DBFnltXjhdw8Aon5COJ4lDufxRLOuAYB6FTp0rlRO73vRpdjhdtCop+uY0o1?=
 =?us-ascii?Q?fjpzFSbW6opIR0UoEc6DFZgIUreToqp3fBa1L2yGj6oHjhp5Dq252MYATx4x?=
 =?us-ascii?Q?DbYnf3nBIphCGKZr9ieqG7PUdZ+YpbZLBosmzpRulNntgXn7lBc1ytB64Nmi?=
 =?us-ascii?Q?1C5UK+bM69hMhPzRxu7w5AqJI1O72mRKybzkrKAvrRuEm7ZYM8y1TYBm1ROQ?=
 =?us-ascii?Q?RQwaApR8ly5tvkKOFsb68KS00NRPlrZr6yKM8iUftsTYxc8/DPIAvch4VDht?=
 =?us-ascii?Q?ytydv493EifIswkCR6KF7OPpkeaJyV1gec9S4WrpgO2tW2MYpojb0sE8JUMU?=
 =?us-ascii?Q?7wTHcmhWGBciNw6dZUysG/cGM1Q3gx9kBNzysV/ZNPBX4rk8mFT0MDJjYtVA?=
 =?us-ascii?Q?ps+OKrluSmYK+XSwj444m/Pjn3nMly16kFrOnxk/4rY7jPMBJRa1uk/c2Qoc?=
 =?us-ascii?Q?fg4diVRKkIXFrN9/qT8QrL4JdwEU1/UyrFFno4Uf9t66ZMVr5fhIY1vnXF5e?=
 =?us-ascii?Q?bda10OtAMGyVxE/23G3cvN9iqroGam33zmYkkD8tlf8LTUwWxAAD4fy8JjGy?=
 =?us-ascii?Q?iLaHooGK5ZHIMDIMlW5qdJlpR+TB3Hs+463mqMAyESGRAcglkj0xgneMxwqk?=
 =?us-ascii?Q?nXB25M44kDPlEHE6lfsJK6L3OyMxVHDw8teeaNkj7o3s/g9O4gzts36IsAu+?=
 =?us-ascii?Q?yJ/1qi8OkMMr2D8qm4ARZe0idgxsBYkQ1rQq9oro3oHh7J9WaCCpZMX8/xH3?=
 =?us-ascii?Q?fl+T7+6qYt51cA5HVxn2JJKvQnZz7bRM9KUdU7Yknfbj2SZ5k9Y53DZoyuqq?=
 =?us-ascii?Q?SRuyStXUpMFlAXHZ1WU1wpgamseh9WFUvQC5TU5xJ4hOUa416ew4XVG6mJ9I?=
 =?us-ascii?Q?IWDlPW0miOPthTH7FTRuAovNA1A8+w+qbQA44HmMyOpAJA5bKZnTQwZYKH+r?=
 =?us-ascii?Q?IHYaBWk39nXBE0DqrMVm4dkG3zMOq6BlFezlK3qzBja2wmTDZbFjpv9WgW6w?=
 =?us-ascii?Q?Q3Dv+RGE45bS3Un/bC7kG3kKQimiXlCDWsnx41MrC0QXmV4JxtJv0SbHdQff?=
 =?us-ascii?Q?jHqUhzFt2ZicDz5LupGsPHVsGmKnOalUKElhgQmCuTuMfQZK+uUhibwL0+fD?=
 =?us-ascii?Q?WMyjJo6FOh4YMbjOPCRXcegmgNo0FweLIFugirs9QSOXbgzmyBLFgSS1muC0?=
 =?us-ascii?Q?8uFpB62c5+ueHRXQ1ezKWSmbJLeA0xl/43UJvh40O8IdmbH53nCn5Me4BubW?=
 =?us-ascii?Q?RkLQmIrWfQLH/W0bVFMiFuEJJMJNhXJANoe5zRiAw4ZEKpxRaeMEt/hV+BXG?=
 =?us-ascii?Q?jmP5Jjw8kpFreGWyXhmFqrCXXXOZb1J7twMREB6fUScf6c7YqqsrD4uIEHii?=
 =?us-ascii?Q?JbKSv3/nJkgjBZAZ0VqRngkvRtC0C/Wx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e0d335-54df-45b3-22d5-08dec88ac860
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:59:12.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR19MB8402

On Fri, Jun 12, 2026 at 11:42:30AM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 11:31:09 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Thu, Jun 11, 2026 at 05:20:22PM +0100, Jonathan Cameron wrote:
> > > On Thu, 11 Jun 2026 09:32:38 -0500
> > > Chris Morgan <macromorgan@hotmail.com> wrote:
> > >   
> > > > On Thu, Jun 11, 2026 at 12:09:43PM +0100, Jonathan Cameron wrote:  
> > > > > On Wed, 10 Jun 2026 12:54:47 -0500
> > > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > > >     
> > > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > > 
> > > > > > Add the core component of a new inv_icm42607 driver. This includes
> > > > > > a few setup functions and the full register definition in the
> > > > > > header file.
> > > > > > 
> > > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>    
> > > > > Hi Chris,
> > > > > 
> > > > > A couple more minor things from a fresh read.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > Jonathan
> > > > >     
> > > > > > ---
> > > > > >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
> > > > > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 197 +++++++++++
> > > > > >  2 files changed, 531 insertions(+)
> > > > > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > > > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > > 
> > > > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..716fc0f1c3fd
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h    
> > > > >     
> > > > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..334264120b42
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c    
> > > > >     
> > > > > > +
> > > > > > +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> > > > > > +			      inv_icm42607_bus_setup inv_icm42607_bus_setup)
> > > > > > +{
> > > > > > +	const struct device *dev = regmap_get_device(st->map);
> > > > > > +	unsigned int val;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	/* Warn, but don't fail. */
> > > > > > +	if (val != st->hw->whoami)
> > > > > > +		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
> > > > > > +			 val, st->hw->whoami, st->hw->name);
> > > > > > +
> > > > > > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > > > > > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	fsleep(INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * No polling interval specified in datasheet, so use reset time as
> > > > > > +	 * polling interval and 10x reset time as timeout period.
> > > > > > +	 */
> > > > > > +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> > > > > > +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> > > > > > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC),
> > > > > > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC * 10));
> > > > > > +	if (ret)
> > > > > > +		return dev_err_probe(dev, ret,
> > > > > > +				     "reset error, reset done bit not set\n");
> > > > > > +
> > > > > > +	/* Sync the regcache again after a reset. */
> > > > > > +	regcache_mark_dirty(st->map);
> > > > > > +	ret = regcache_sync(st->map);    
> > > > > 
> > > > > Sashiko raised the point that you don't have a writeable register list for the regmap
> > > > > and so potentially we at very least write a bunch of stuff that isn't needed.
> > > > > I doubt it's actually a problem or you would have seen it, but nice little optimization
> > > > > to reduce what is written.    
> > > > 
> > > > I will add such a list, I'd put it in patch 4 unless you think I should
> > > > merge patch 3 and 4 to make the driver compileable at the first commit
> > > > of code (will push the number of lines to the ~850/900 range though).
> > > >   
> > > I'm fine with them split but don't mind if Andy prefers them combined.
> > > His comment on adding a COMPILE_TEST option would allow that to be
> > > built, but it is a bit odd to do it just for that purpose.
> > > 
> > > Jonathan
> > >   
> > 
> > I'm going to add the i2c stuff to this series, and then do the SPI
> > on the next patch. That should add only a little bit to this one but
> > still ensure the very first (code) commit has something to compile.
> > I'm going to avoid doing COMPILE_TEST unless collectively you all
> > think I should.
> > 
> > I'm still racing to try and get this one done before the merge
> > window opens up, but I'm pretty sure it's already too late at
> > this point. I'll refrain from submitting updates once the window opens
> > though.
> Unfortunately you are correct. IIO in practice closes around 10 days before
> the merge window to give time to both expose new things to testing in linux-next
> and to allow time for Greg KH to merge my pull request into char-misc (which
> is the path IIO takes to upstream)
> 
> Sorry about that, and whilst no need to rush as a result, we also don't
> stop merging IIO stuff in the merge window, it just sits in the testing
> branch until I can rebase that on rc1 and then push it out for linux-next
> to pick up.
> 
> Thanks,

No worries. I think I'm down to 2 bugs with sashiko that I'll try to
quash, then I can move on to other stuff. Note that when it complains
about the temperature sensor and power management that's a false
positive. I tried to put a note there to give it a hint but it doesn't
seem to want to take it.

If I haven't communicated it previously, thank you again for your help
with this. I thought adding an accelerometer to my handheld would be
easy, but I do appreciate everything you and the other maintainers have
helped me with.

Chris

> 
> Jonathan
> > 
> > Thank you,
> > Chris
> > 
> 
