Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012059.outbound.protection.outlook.com [52.103.10.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277C3FBA7;
	Tue, 23 Jun 2026 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182046; cv=fail; b=RPRAi3hEZaNlbBmQu5yWnfDdkMt67FYFX9TGmiBFyIuePwRHgYIIp7+vWeGssTkrbEMfl4SnOvWhLCCPsLzbzohE9sSjIHA2g0s2E6V19nTD61pcN4ZKpLEsV6LUsJ1cmgmNaGFVZOMaWdx9DUQFZ8bFevznvdN86l0Fu74G3Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182046; c=relaxed/simple;
	bh=74966W61sT9kDt63WJyDrUX8fc06U4gY4Kte/0kaIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=epP8leQlp5VzdeaqT6HbL7bLQDiVvsYh7rCvybOKdyjUiD+fe7UNCezJLJu+OBo+estv2+S5hdyxj5XeVTv66RnGhucLUXPnhSnRZRONxGxHGeIvG1+w6sVnbfjQ1VdJNzQ5jMtRePqgB4X8x4jNJu4XZycuh3Ek7+NXsBy2jSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Xro3WiB4; arc=fail smtp.client-ip=52.103.10.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Xro3WiB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmEyQ0Y0HEPJvT1roKOBEUL0ymlxL7VvZOzFgyqGcfAz/RxJd6F8TorEpBbHdWfEyjX3oEREO2AwVgLtXC9SOaIDPd+BDYPNJ2vVFQlJyiChs4apr4Pycs/BXJftENxsZQ5vKG61uPUqrj5KaN3fhrJm4xALQUojJ1xA4eeqwmjPPOhiMudjgVU32F1q1MgDsinf2DO9MH2ijRB7Q/lRXL6NojDgbBTOIiEXjZCgxWW29uCrAbAvvRkakXw1zyKchCydQgkWq0fboqC6x4gUeUcF5cWvRQWGiV2GFi/iki9uiC67mdCMAGmTOnfE/4hgfqUAmpNODGmIBQxuLsAIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFo9y5cjLf6D84eBEEv1Zj9GvDocFY7QEpTYdFY4Pw4=;
 b=p7d1/Ea4HAq4CMpy/Y/vsMk6ZeKJczkxmTGFl44Op1/wL2Rklr3y4BLKDtk1q7AcphEyGLOrLwUtKUZUbEzM8k5MlE0jepzZhfHsZel26Bt7ruVDTqnROE8Nf6XNnu/WvyF/7IhZboRzJq7+vxzscL0adDEbPWCRiJNtW2QXPekH8ZMDG7BL4bW/kHPWvx0PjWFSB+FWtnSjzeajG0V4LPxqJLIgi0mfmraScBBeR79Y8R9k4gNxTAsD6HfG7VwKnDSAiHQHVdod3H29mOFFQerrXtYqlM7FyDqs0De7iqvI5PPCrhdfpO5y0yGcj8xVcmuwmA5LuHXADYWYQx/ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFo9y5cjLf6D84eBEEv1Zj9GvDocFY7QEpTYdFY4Pw4=;
 b=Xro3WiB4PONyke+YY+9UDbOSG7L0dA5m1ozVSrWv+nZRyd5aLhdGdJOSVNvb/djZcOV0B+x7sFwD3ecqWI8nnDMrDRi4faLvtMoryZdAjmvfbMI0CliWCiuW+lERDxRpdEbvzuvz6E4XHRaxUrpksS6hAbln6wIf+MxeaTImtTkkSBWflPqCRID3shZyF97XQJBPx/KeZFGyj7ox0f9wYXQ1xGKoC0bU0CG/zgyXNr1QOV6Jpj7fkg5aiK180qGUB6SqWVWSE2EetPegnjlORnvD1GmTZM+kgDplVxrA7r78CjHPWxTJOukgxxh9qDUVje+JzD5nffK+Fd+n43nZWA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM3PR19MB8305.namprd19.prod.outlook.com
 (2603:10b6:0:49::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:34:02 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:34:02 +0000
Date: Mon, 22 Jun 2026 21:33:55 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V13 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID:
 <PH0PR19MB997338E32ADB15237F62804862A5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-6-macroalpha82@gmail.com>
 <20260621181948.21d40a09@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621181948.21d40a09@jic23-huawei>
X-ClientProxiedBy: BN9PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:408:f7::30) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajnwk_zWevY14mEO@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM3PR19MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e51ac1-de16-4b68-3080-08ded0cfe36c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|51005399006|15080799012|24021099003|19110799012|37011999003|8060799015|12121999013|4140399003|5072599009|25010399006|25031999004|41001999006|10035399007|1141799003|1602099012|440099028|4302099013|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7DqiSXkRCWPkw1vA8DJRvjQGXAcyM5STOXQyjYqOfov5o6StHgK6wqXIhJx?=
 =?us-ascii?Q?nkdrc6O63dkXNTgBgWN9G7AYS+P1nunLh5qgItfVFtzZOypTXKfg8usit+Dt?=
 =?us-ascii?Q?gL6OfoMw9eiJVhIC+3ptU3zvOHcBgHHLWwVB6qkDnajStA7T+wo0wsAoZ2Tx?=
 =?us-ascii?Q?CtqWOxnbm89XAXuYHywSKO/GC+U9MpP5ZvHVbaRQrTQT/y+CpilEv8C2u6pY?=
 =?us-ascii?Q?P9xAbpnlOjBoEa2kCJp1CECYlAD9X6AcAaQZXTdIIbtzmocZREPvGUEiHbAu?=
 =?us-ascii?Q?zUWKPkvdZrMfw1AutpaqhH3jIHXyQqOgIJC+D9BjLNaMCokaytVawavn9q4J?=
 =?us-ascii?Q?IgKUY2bjNY9vJ+7oSYSdv+YtlooUfiLNwuAVcgmErLkOX/6ycim126Vke4Bj?=
 =?us-ascii?Q?RF86A9en8WrAjT0hOHmiyEHz0Z695zcwfajJgnhNNFToJ060DOVdnBQOLhbt?=
 =?us-ascii?Q?UHghqEsJS2sy6487IWhIltIVFk2GMR66p3ty1hagDNLWjCwmM79wE9iU7Aax?=
 =?us-ascii?Q?7LVfgAT1qlH0Hx2LJbrjowntrz+6E1BqvrqUq4HOmppVTZZZaUDKBRO7T6w1?=
 =?us-ascii?Q?kbNNQbvGnlBgz0t3FvU74fXCGgr0h4oo9qwB0xq/y43NiB2GxM0NUh2kIzqt?=
 =?us-ascii?Q?kDE2p881++hNyN68hm/v3yQ9tY0ZwMQCGKoyyBWyraMZfOVNwY6hMMG9tKSw?=
 =?us-ascii?Q?FTM1GXLAHWw9OCQvIDgRFfURf9Ihq9qUeW9+hiq6HZ2gZaAKpmi/MFZdJTGy?=
 =?us-ascii?Q?l+Rp00BTM5v9kHvfTO/306RLA7STpxD3XSJ+FZ3Rm7TpNXVXN5BRMttLDIrZ?=
 =?us-ascii?Q?nScLT82w28PEGrwjlVUprbJHz2eHvUawMpqHRXSWU99TlyGhhO/Ev94c4elV?=
 =?us-ascii?Q?ZkIJLVy7xD0n8H+kJHV3n3sXuhSaBHOzbzh4sxPFskVfeBMyJTO6ZStDy9F8?=
 =?us-ascii?Q?e5uEn9zXNgl9Awk0WWkCeEwltxm2XCk2rRXj8GG/J4+pjp7V0otx8x44Jeje?=
 =?us-ascii?Q?YmR5nSx0mg+TdHjF3ZQ6Znwa5rJ/oakixRSSS8ltB33D5qwr4a13nn0HyYui?=
 =?us-ascii?Q?2fnw5NYJ4J35ZYybc0SGUyQxgTlG7bS0A0CmCa/o+Oqd9kpsx2JR1T1QRI/q?=
 =?us-ascii?Q?dhPnwqstgrqiI8dO0KyipKmU1KOUcoItZg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0Gjp4d7N7Fter5iRDWG2agPtfhgL5Sqhos21KxdqZe7FxwzfXzKmwKVc9KT?=
 =?us-ascii?Q?NeTf/HcMPVcPbgryiVzsECLxXze3HNUP/dog2HMh1TKZpaD9At7LQryEXqwn?=
 =?us-ascii?Q?n1NwsJU/X/bym44tzl0PSrROagnpI/alLrEMr5vwIGUk/GbuTI6/t301ZYdA?=
 =?us-ascii?Q?9if1dj8GdKw8FL+6imWhvs6z2sgr454SP6kQC+zK67+wB5h/Tz0JR/CZIUPm?=
 =?us-ascii?Q?/X3d0bRON/wz2JJ2qCGNk+N2rUI43W7BEoNoPGgPDJ24XMvo1EDchlOAYRvN?=
 =?us-ascii?Q?F1rhQsssOhAe5ivSojFKN08mePfC23k9+UL9JMukQ0VN7YxG/h2R2ejYQgBo?=
 =?us-ascii?Q?a34GcMq0keE6RUnqXPKc9TDSL6FIjChU8gk1PoTOUD0joI/at2uBldr9pUXA?=
 =?us-ascii?Q?QsXcl7+dUb1gZUfaeuwA3J46Y+YrOi8n5ITRqza6jKcXNIGCrNSpetbr/Aom?=
 =?us-ascii?Q?T3dbFGI1f7Oo5bYe5NoZaPAH4Kp+CoIE0JUl0KqiX8/r2SJ7LfyCKY3+CSMG?=
 =?us-ascii?Q?m3hxt44EQrx0599784RhvQnV1HJ/WDmqtQ/n9JUzqNFYzKN0nWIHtN4Hy/+N?=
 =?us-ascii?Q?1VVn0UlmjS2rjZXdD/CJsBVg06z9poOUz+WroT9ZQEgbmS4CKlP6VO61/u3i?=
 =?us-ascii?Q?5NQpceowepfXSrIjUELa7cRWg3kVRwydB7XhDDky8mmeWfOAgTBpb7+5wMqZ?=
 =?us-ascii?Q?6FkoJEM0w1yac872O7urj9FtOytsL1hetCyASwMKT0yhmZyqsmgEzQNIQGtK?=
 =?us-ascii?Q?M1ugfoFsCBWN7d5kw6d6PaeHbCB2EaPuE/i4OV/T88icyiU45gmxVtY/XCoK?=
 =?us-ascii?Q?sFy6JumPvTxMqcPYkx+rNnxpLWdD6BrwhZW29wjo38+Ox1mKQeUWMiip0lLI?=
 =?us-ascii?Q?jKoFa1MLO0vIxAZa7Oo6E7he62T7aQefi8CXREyg725tGqszHpfd1YL9+igw?=
 =?us-ascii?Q?1C6NK78kZ/oaAn8ZjBKkHBBGHX5B6HJgwoAq+362Ly8Dq46jJjqelv3gSgs+?=
 =?us-ascii?Q?ehUIb0Xgr+kKDI6d8r5KK1T11+YBkmerVEu7qW03QwArxu0L4Uh5HeioldYa?=
 =?us-ascii?Q?ShCuJ83ZXqUFY/G1e5zzG2UIXie//6ZVDqH1sNqJiQsXP6hqPVpIQ2VCCbtS?=
 =?us-ascii?Q?CYPXhFJ8uovLcdWK44jno9HmYmm+IYt9P4lR6BPKMMhvLrqb8+swZV9E3+0A?=
 =?us-ascii?Q?6WPk3VvxGLdO6Rm+PGYUOuOHmqw1Ojb6dhvHfCFSRPyupGz7ZFPhOYc6DtmO?=
 =?us-ascii?Q?EWSeHYy6BzyN0yzlTq1ZFWO02kqYNyhpzlMthxmvtz1Ov+wLlm0+M1Mu2KVi?=
 =?us-ascii?Q?3TTJvdDkNPsEjUPCt7la25aQhaVFkYnw8ZtY2mr23JJle164txdPGQR5V8Vg?=
 =?us-ascii?Q?Uhfbu84xSuJHhdOcidCtpKzZUUJJuos0V36urAqrdkGa+ruAr47NEbNAr+13?=
 =?us-ascii?Q?8uh/QG9WvaAKwp3Hp8hfsF+BZR9JHPHd?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e51ac1-de16-4b68-3080-08ded0cfe36c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:34:02.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8305

On Sun, Jun 21, 2026 at 06:19:48PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Jun 2026 12:25:48 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add power management support for the ICM42607 device driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> A few things from taking a look at the sashiko report:
> https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail.com
> 
> > ---
> >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 139 ++++++++++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
> >  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
> >  4 files changed, 159 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > index a6a58571935f..4f4f541027dc 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> 
> > @@ -334,11 +345,18 @@ struct inv_icm42607_state {
> >  #define INV_ICM42607_GYRO_STOP_TIME_MS			45
> >  #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
> >  
> > +/*
> > + * Suspend delay assumed from other icm42600 series device, not
> > + * documented in datasheet.
> > + */
> > +#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * USEC_PER_MSEC)
> 
> Sashiko had a valid comment on this.  MSEC_PER_SEC seems more
> appropriate given this is 2 seconds in milli seconds.
> 
> > +
> >  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> >  
> >  extern const struct regmap_config inv_icm42607_regmap_config;
> >  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
> >  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> > +extern const struct dev_pm_ops inv_icm42607_pm_ops;
> >  
> >  int inv_icm42607_core_probe(struct regmap *regmap,
> >  			    const struct inv_icm42607_hw *hw,
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > index 4b8e19091786..64f5d263de4f 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/delay.h>
> >  #include <linux/dev_printk.h>
> >  #include <linux/device/devres.h>
> > @@ -11,6 +12,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/time.h>
> > @@ -103,6 +105,63 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> >  };
> >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> >  
> > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > +				      enum inv_icm42607_sensor_mode gyro,
> > +				      enum inv_icm42607_sensor_mode accel,
> > +				      bool temp, unsigned int *sleep_ms)
> > +{
> > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > +	bool oldtemp = st->conf.temp_en;
> > +	unsigned int sleepval_ms;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > +		return 0;
> > +
> > +	/*
> > +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> > +	 * for a minimum of 45ms. So if we transition from an on state to an
> > +	 * off state wait 45ms to ensure a sufficient pause before power off.
> 
> Sashiko commented on this..  I think what we could do with adding to the
> comment is what the path is that didn't pass through this function which would
> ensure we have been on for 30 of this msecs already.

I'm going to track whatever time the gyro started, and then if less
than 45ms has elapsed just pause the remaining amount of time.

> 
> > +	 */
> > +	if (!gyro && oldgyro)
> > +		fsleep(INV_ICM42607_GYRO_STOP_TIME_MS * USEC_PER_MSEC);
> > +
> > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->conf.gyro.mode = gyro;
> > +	st->conf.accel.mode = accel;
> > +	st->conf.temp_en = temp;
> > +
> > +	/*
> > +	 * If a state change occurs from off to on, sleep for the startup
> > +	 * time of the sensor, unless a sleep_ms is specified. Since more
> > +	 * than one sensor can be transitioned from off to on, select the
> > +	 * maximum time from each of the sensors changing from off to on.
> > +	 */
> > +	sleepval_ms = 0;
> > +	if (temp && !oldtemp)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> > +
> > +	if (accel && !oldaccel)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> > +
> > +	if (gyro && !oldgyro)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
> > +
> > +	if (sleep_ms)
> > +		*sleep_ms = sleepval_ms;
> > +	else if (sleepval_ms)
> > +		fsleep(sleepval_ms * USEC_PER_MSEC);
> > +
> > +	return 0;
> > +}
> 
> >  
> >  int inv_icm42607_core_probe(struct regmap *regmap,
> > @@ -236,6 +305,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> >  	if (!st)
> >  		return -ENOMEM;
> >  
> > +	dev_set_drvdata(dev, st);
> > +
> >  	ret = devm_mutex_init(dev, &st->lock);
> >  	if (ret)
> >  		return ret;
> > @@ -271,10 +342,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = devm_pm_runtime_set_active_enabled(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);
> Sashiko does put out some stuff here.  Please take a look and work out or
> test if it is right (I think not but haven't checked that carefully!)
> From a quick look I think that the auto disabling of autosuspend does a
> rpm_idle() that should result in it suspending...
> 

I see a few other drivers adding one more call to
devm_pm_runtime_enable() so I'm going to see how that works out.

> 
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");

Thank you,
Chris
