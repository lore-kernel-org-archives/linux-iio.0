Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010094.outbound.protection.outlook.com [52.103.10.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DC1C28E;
	Mon, 15 Jun 2026 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489581; cv=fail; b=VKH9cbZt9lwZYLIA+VOxSsNNFB0hiUUq+pTXupiWDpwpPQ7uzvjnRfGyGLAoUas4elNZdOjrsIkzorveRdRMphmKVOUnvdVeesELME+AgPsIzql9H537E9wE78GFNAKgdyQnQe/2mGbC6GVm630cKmU96DS8Iar/5SKBxpvchS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489581; c=relaxed/simple;
	bh=ZQscr6KqqSjx6flDv9eBJmlx5f2O21dhjzEqUX9hLI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ql5+vzAGj1jt6kL6cYEEXW5GQ2XjT+Zzhuypjfqapz01jc+1VLj1NB8iUdhtuqJE69UTcF06alOAXsOkxL/+qCOFzk7pEJd7eJUtSTWcLFegaGabaW+CInHNl1gdit4SagsdoNGVFS6r91AN/Fgl0VkNs4876bPaJLpNMETMQfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=K5yxaqPA; arc=fail smtp.client-ip=52.103.10.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="K5yxaqPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRmlniWH75mDxHDFSshD0Cl2baopahIMHuxB1Mseb9ppMRebYamWLfWZg/ru3jjXk/gAtMl+GQN61nP/lFmtExMsB+Vy/2wAl2TtA/Onr55cYDQW6GXJeQMbWFZt3f+6K0jJWp1psvmzfBmdOByg4sNWrINatxS9IRq3SLhqtvZy0qtVChhGWAYAFl+XGo3DizvNaRfOORpvJRwGuay5dZzd7k68wVkOT9icNbep/r4TTSx1IS6ogxzDhjhhCGWpW3GGIsalG/wkBGUyrt0dQEsxhqM1tVWAIl14Z+IPEqQjK2fM9RzxZwvsYU8+/1coY24HaYi14AnLMDxCeUMraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzQelQw2CPH8k6VowmIJKAkskf0ba6DrcJCugJl/Hnk=;
 b=iuOgzy+y/W6vxWwlrxbJmHfEa4iiWTvBigJqC5ty4WKnfq4D3R5fqRS3VRRP5eWKLmM8/5nE3EWDd7PVsSgk3m/4EWIX+Mcfw8BoAToT+lDSSyC7FDVd42Kp4bL9QIMRtuieZXcyWvaiY/n89aKX5826y4Zqux0YPkcgOqE+Pj06vchemecU4w/sUu1j3xpP/MxYSnvQ6UN562QNbMXudXNEaWZJbfKvuG3CxO8z//jvwkpEt3ZJChh6VHxG4aBISE1ckE175JvVRebv/RPuadOghU2n2f0XnF4UxtUrx3L5Z98f/ErJe74NSKyyoCm+Vmh2Xk0nQUVmQLr2NeFe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzQelQw2CPH8k6VowmIJKAkskf0ba6DrcJCugJl/Hnk=;
 b=K5yxaqPASen3hkwx4btvVqmON1HqAoygmuJLsRHLgBu5L64zKV9fGAntd5ybkUvn/MhEDHTuOwqc62W6fEFKptOe+HrCM5yn5NaWLbBZx++TtrsC7oNVsLEXS1W3nkIfj/Nvg2pUGtnApm77ZF/3LCNo7UIJjsXzBL7YsTOj+LGwfC68YWgiKOMVXjPfRuAlP+fmUEpryhWvwHSaJnpGEZPW4d4Z4Qht6UFlOzYIwN89dI8PskTePgAoYIVxAKOPlTbjuivGSM/gqsEIAPjsU3nnafHwKQ72NnbzNpMVj6CFl0R6RTt5mzde1FL9ltSDKnAm8uFXknU8bRDmI/OyOg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SJ1PR19MB6404.namprd19.prod.outlook.com
 (2603:10b6:a03:455::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 02:12:57 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:12:57 +0000
Date: Sun, 14 Jun 2026 21:12:56 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V12 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB9973389B1648F13113B00B3E3EA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-4-macroalpha82@gmail.com>
 <20260614171847.3c412ca3@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614171847.3c412ca3@jic23-huawei>
X-ClientProxiedBy: SA0PR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:806:d0::10) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ai9fqI7Ob9_BbUnK@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SJ1PR19MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: b8026358-9168-45f8-f4fa-08deca839e19
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|6090799003|51005399006|25031999004|37011999003|23021999003|19110799012|8060799015|15080799012|24021099003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xnnA5YAGRuBM78Hn7Ly89/p+vr9cuCHgsgv91j7Qw3CP722LQJgixlos9qY+?=
 =?us-ascii?Q?q7FSkLGqC7tH0G7Va03HvcKqcyPFbCxtAIrq0yK9zYGF0753ti7nh2z08wy4?=
 =?us-ascii?Q?Tgv+iH0urTmw5QbNvXhXw+5jk9JiMCtSTZeLghrb4ABz4YYEs7hD9zC/d6B6?=
 =?us-ascii?Q?rSHqlwy2nCpLtmSq7Q+/oq+X4+CMzf9t2tqAl2oW/jRtwBdrUVS8VwVYpnTd?=
 =?us-ascii?Q?UpBekcSSFregR6b7/i66mwRvj3i97cYbXEwRnxwvJdGiNfWPMJWXkzmpaggt?=
 =?us-ascii?Q?WPYLS8gT2cdxo4fRuoqR8VTauSmvng8zdBcBVZlSucYf5yXvVeEs66yDJVjf?=
 =?us-ascii?Q?bGFrEoBwO6vu7oBQWNwFVIUBGDMZnU7GRCqqxqorWu58mR6gHqQyl3jZikdZ?=
 =?us-ascii?Q?5r7pnNDI29S5cSFNgNajEQ4iiAmDnn+BQfNRI5ZwkIjGTWybbEY/sVX0yp5r?=
 =?us-ascii?Q?Txo3vZWRVugy4OOzXo2nBA5l2wpw8WHdKD3cmsGmJ/mmy5jWw6Xg2rzHr7Yy?=
 =?us-ascii?Q?N8JQCJExTbUHYH0+RLxzsJ7k7JjKZhTYJ/RfbMTPJdf26RxradyvHu0jIwwU?=
 =?us-ascii?Q?CpFALl5QWpRkLqzwKivCe/K/pjp7ap5YTivnp9U3Xp5A0JpM3mmXHFjIXlNu?=
 =?us-ascii?Q?wfSTs5/XYLUkCDLMYNbg9n2yFslBa0iobR2dKxfTasFuMk7vCLvB964AX7mL?=
 =?us-ascii?Q?MkhZZHc0O2Skc+8i1e2JOs1Rl1B8zLiFuGg0aiwfg8beXduuM+28commNS5e?=
 =?us-ascii?Q?8xxICVjtg026JnR4J8bUiITeFcdCUfSkqwZNKXXx61+NDUJlH1PiU4W+6GwZ?=
 =?us-ascii?Q?KCPWu4XQINmOTxuKQlqzKSw0gkY1bl534WxA0dAIawjDye53uBw5nskiQnyX?=
 =?us-ascii?Q?JhbhYR118roio+sfw8PXErr11V24GMBNwPc1CsAfLql/6i28Pvs2BUZXSjPI?=
 =?us-ascii?Q?w23L9DpOw2H+Uu/VYvtVawrHNNgu92yVf5g6wowN2gStK+otwuWOcgpoiFub?=
 =?us-ascii?Q?evMIsm1e0KRWPch1JZoKpfigFqLN4joptup7sk36VvLNlnEwScGCyLGqz3pi?=
 =?us-ascii?Q?0IU2GHB9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgEznOPGUuzNOoIhsg0hoap+DIH0qDJCbS1R3uYDUOQKUafmLMYTCq9EianD?=
 =?us-ascii?Q?f9VuYEdSMG86vkoZrtBCvuWhd+hv/DeBWYauqVp3fuWhErV0LrsBxGc4POq+?=
 =?us-ascii?Q?F+L5EjWNt9VnOByU/NuDmLTQAOZXPS/waK25snTD5C/teRp9mNXVru3PWidZ?=
 =?us-ascii?Q?oulaHLy6lnPLmi4fxHarlo/ZbqtshhWzMtKi42UPkSiEWwY93moYlRZKPdh7?=
 =?us-ascii?Q?pZVGRIaVRjLxVgEYMjILKClx7BZXr+RBm5PVqeozAo5hm+5sQnPqx7vwzTDw?=
 =?us-ascii?Q?fR2wwEWaR4r3xYOpbJqE+GltWZRaYR1kjMZmGyAJN/yKPpdUSBGB+r3MINJ4?=
 =?us-ascii?Q?34BFrLyY4f6PEJFKB59lrJbIM2mb/Z9BHbDORy4F6pJXnFtMg6E1W9aMP2IF?=
 =?us-ascii?Q?SnKaY8/rlbx9LmDzPDbTBHjoD+mtHvYDcAzfnEm5z6PXoEPGCWcoWunMBjZR?=
 =?us-ascii?Q?JwSorYPUYAyveLNAVj4k4p5rBsmugTcMLTbwdt5g1uvqAA3YNtU4sMtc7Bim?=
 =?us-ascii?Q?qi95a31getApnH1LLlytV+s8yvBQEA2lc0ltBVmdLCjlI/ljqodyl9gJAJX2?=
 =?us-ascii?Q?WKQmKi4A8oXXCD3KfOa41lXHI9Z9mmgPn5xJmFEZ1mt1OPuoqthZPOX6cFf8?=
 =?us-ascii?Q?W6povZpi0y/UY7PWkbFvDzMmzyJXUmfEOenekGVvCTXEpcKIw3vPwnve7FdP?=
 =?us-ascii?Q?ehFKZoP7dJizSnKP5MbtKcCYiMDbjKSEKkQ4Qy9QHN+G/T3Exs8mr/P5+Qcm?=
 =?us-ascii?Q?al0nxze8FG5f2Nr1qIRCJb59ONGe+gSiYzTN9Z6LKFtnwHpuFFJwf24W7c1P?=
 =?us-ascii?Q?6PIqqm0zP9W6A9TYG5H+V0XOcHA86wB+FurgYutYnNBqNnB6f0EP7HUfWQCp?=
 =?us-ascii?Q?77jeyjnMkP7iZEG+fUXMRsaNfycAjNLzFDLLGA11XNkMAF8yNq0dvSZm+xzC?=
 =?us-ascii?Q?TrJ+JJbwDx9QLeZiam85j/j8tysM6//CFPKEVuI84Z6Yqdl5Em1fWXYYy/2g?=
 =?us-ascii?Q?40CVAcZyJLo5QLjpt2qpomTljO6p7uX9U2vHLOsDeDb+aQ7YtyiYOg9y4Dvi?=
 =?us-ascii?Q?qh292b6poxTyNTjImxwJ5+/p+5mCfZJVrPuxi9UDedMKGTIla7jNBPohhkqF?=
 =?us-ascii?Q?WabbjUXkYCWCUcewMdZ3ZTjJ9uiU3BxjD8CePb5sks66pPUAAtp+OvAD/vyI?=
 =?us-ascii?Q?ip5CHieK/oMpwt4NAXlhqKk9AkvPy6ZQd5XuW5xZNX+w4XGu1vWgsZUz07ZN?=
 =?us-ascii?Q?aP754ECMPPqRPTRjGc48F2vNuTmAD0RcWrcpsdFyf6/wYZ/e1HoFpJslNzGk?=
 =?us-ascii?Q?5a+gIhKwKlDXyvM3o5UY0J2OFrLeocNoia1F0RX/PR8ouotJg6ruIhPvvqHX?=
 =?us-ascii?Q?vUz/JiXV1TYDjbXgUx0uJMgPqQfvytMv+vtphxxaY31UhaBhZA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8026358-9168-45f8-f4fa-08deca839e19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 02:12:57.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6404

On Sun, Jun 14, 2026 at 05:18:47PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 15:26:00 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add the core component of a new inv_icm42607 driver. This includes
> > a few setup functions and the full register definition in the
> > header file, as well as the bits necessary to compile and probe the
> > device when used on an i2c bus.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Hi Chris,
> 
> Given this is nearly ready to merge I took a look at Sashiko and
> seems it has found a few more things.
> 
> Other than those, looks good to me.
> 
> Jonathan

Thanks. I'm going to resubmit again probably tomorrow (even though
it's merge window, again unless you don't want it).

I've removed the buffer from the main st struct, since it's really
no longer needed given the lack of buffer support. Additionally
I've removed the registers completely that sashiko was complaining
about, since it only applies to the 42607c and isn't used by this
driver right now anyway (only needed for APEX/WoM). I also altered
the power management logic a bit to prevent it from delaying on
shutdown, except for when the gyro changes state which the datasheet
says is needed. If Sashiko continues to complain about power management
for the temp sensor that can be ignored, as I've confirmed so long as
both the gyro and accel are off the whole chip is "off". Along with
making a change from 42607x to just 42607 in a few places those are
the only major changes.

Chris

> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > new file mode 100644
> > index 000000000000..c85d3b74166f
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> 
> > +#define INV_ICM42607_REG_INTF_CONFIG0			0x35
> > +#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_FORMAT	BIT(6)
> > +#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
> > +#define INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
> > +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK	GENMASK(1, 0)
> > +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	\
> > +	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 2)
> Define this as simply 2.
> 
> > +#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	\
> > +	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 3)
> and 3
> not the FIELD_PREPified version
> 
> Sashiko correctly called out that it is field_prepped again at
> the callsite.  As the mask includes lowest bit this is will 'work'
> but definitely isn't what you intended!
> 
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > new file mode 100644
> > index 000000000000..5d40f1ee53d6
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> > +static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
> > +	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
> > +	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
> > +	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
> Sashiko pointed out that the WOM_ registers, 4b to 4d are in the defines, but
> not readable or writeable which seems like an omission.
> 
> So far only matters for debug, but perhaps better to add them from the start.
> 
> > +	case INV_ICM42607_REG_WHOAMI:
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
> > +	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
> > +	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
