Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAF3603EF;
	Tue, 23 Jun 2026 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238092; cv=fail; b=L2oDQnxYz76dgQniqgCb2TaHVy/hGpB1jbbu98dtH9Q8r8o9McLUp1mdd6SImDJBglBetJCC4modosFlUTSAZw6sIDEtf2Ss4I3w2ZMyJJxdpKULJnjDUoKNXMVdAz8iEqkT3q/azfV301OeZqedwKHoeS99XsozjWmqUb/R/qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238092; c=relaxed/simple;
	bh=yCpj9q8zMH/fj4lgEIT6+tDY0n68Tw8B9X9gs5jlIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qUA90Wy9sLN07thCfsOE3oQAvKkedb5UsRhQkdnKbv2sAhqmaVxv0VvaTY8h4yfDQaACakWNk08oPkcsrx8kPVvrvhkmAMCnwbZufR0SiL9lFiu2ooowOYaEFAnAASE76gQEjXdR9A2ftszPew25i7sSa9T3GiOVrD+Qq+1Ir7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=eo0LeseJ; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="eo0LeseJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooDuu7N8F/l5T6Sfm+MuZ8JLrsQdqKPD9LIu5xl7OpwwhaJe9qNZ2x+eyhsh3WP3rYKwiH4SVGY7MdSJqw7NIQH3UmgTBaVaT+3W0lnnroniPYHDc4K5WkBLGRR4Hj3X+R2aZCjzSOSrS+kwBbdZlgbiTiTgkH851EmKAPh+HWQ6dFjA3lxljmSbMqHJyZqwfNF/r9dTGRvabhrPlGlArtVJ11IzmH25qE2fkzVNDLqsr6sdrdeOPm0vtS0nD8zpQ1Y7+qfdf2MpBoevEzmluKfVy1PldbpY6rsUe8GWnbTMO0mLA2O8myt40yk8RYZdDl/1sZQjWGywQVBbP3p3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H7Bv0kcIBbYgpyUHFqBv1C0baYW8vEHjDWlgBe34M8=;
 b=NXNPZSXobdpozDszu3+WjFQG2JOlSzxrmxnx7557hJ50HJbJTt/Dei7jnHh/ocB85QNVfgGTWheGdE3vKSNPXaCwXdz4BXIgZyJ0/2Tne74E9qsHBo270AZtYq2BmzLbXZJwtpmzXlgRXqCJFPyhr8rfYJf+J+adPtQnMEEJLsiVMDSNKg+koqXy3WIxub55venb80DXI7MAPlyXZil8ooE0p+e1nu50MwHjGWrjXXQAjF6OqB6EvmqF681yJwKkawS2lN/tTJUATnIBWEw2P4J+JxJeEbSvvlULdQm4gmZ9DYYKpbzw3RPrxa5t3M4kgzWkv11nLTrMtjGo4pqIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H7Bv0kcIBbYgpyUHFqBv1C0baYW8vEHjDWlgBe34M8=;
 b=eo0LeseJBtO1jTZMrGLu/5MntXmHb6jdJ41ec3PJmTWzH5nMUOuDJ5hfk1C5r5vnLQ2ORWB2la782D13aQkM3Lnp37BvnCGL/rSA+Cx/bWeVZYnRVkCAEUwOdgpNkQsPYTOZuCEArQ+DUu8Hp1pMjVHz0PH5T8T9xgvsYYRGxr/VrceBIPExb+hxsQQrWByc1BCbmJdZ/7PJ3HOcJba+xnlVi/BDpUJx30PJfISdecrcDB5TZiBGj5oM9BLfarfyFO7vytvGPJuaOQnlpkp/acO8pFy/azljpp0E3rb3ZcSbdwxU1B2XYFhjXaKKduYXZg9JIa62/wWzf6gLuIyjGQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SJ0PR19MB5365.namprd19.prod.outlook.com
 (2603:10b6:a03:3dc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 18:08:07 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 18:08:07 +0000
Date: Tue, 23 Jun 2026 13:08:02 -0500
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
 <PH0PR19MB99733833C502FDB1FA4927B8DEA5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-6-macroalpha82@gmail.com>
 <20260621181948.21d40a09@jic23-huawei>
 <ajnwk_zWevY14mEO@wintermute.localhost.fail>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajnwk_zWevY14mEO@wintermute.localhost.fail>
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajrLghafuPx8j-Zp@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SJ0PR19MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f13e2c-c35d-4ad9-b2bd-08ded1526086
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|37011999003|15080799012|6090799003|19110799012|25031999004|8060799015|23021999003|41001999006|24021099003|51005399006|25010399006|5072599009|4140399003|1141799003|40105399003|10035399007|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmK7xFVTd9/aW5TxuSN8OBHBrrTQ+lkzbsN2ny7TZlzxCG9Fn/1mKvFCNUcM?=
 =?us-ascii?Q?4fedLj28X4mLSQ375CdWlhqAwMiDwe4fh0FvIf02dxunygVNKNaP8WQngY75?=
 =?us-ascii?Q?nfrZVfzwZSfg3fOd5OGE8KkYusz4PKc6wiAwZcssPItMra4d143YyAv1Iykv?=
 =?us-ascii?Q?G+D/UoZ/xezPe4RcXXogBxMAjOCPokZfegZTetRJOi0HJsyZ0kxKMohIIxia?=
 =?us-ascii?Q?dl/pMZguMPALVb7boYD49gm9uguX3b+xlqb+V79327AkMZLzROR2t6GXyBwK?=
 =?us-ascii?Q?vlSt2B8/YG4ie91C5vVV9P40BtoNvGFr8VNz4msMV8mAFnBzH/rZCXNmkQJc?=
 =?us-ascii?Q?KTBGJLCu7HdtO+w8w9vXXotK9vZjyTHRskfo1jUO/+engtT1OpVZvS1GzJnX?=
 =?us-ascii?Q?rYNZyWO9FDioNlrIPfVGULRyQgMeoPWB3BxH2YGY+xHArvs/ONNdNlfF6ltG?=
 =?us-ascii?Q?XS1UY614eOdX8LobHLBhZklkjL9TozUF63VCFba6kESH6c+u2M9iQhnJG+Bq?=
 =?us-ascii?Q?68h0HpKFaSAuRS86mxmVoZVbEIoBD4yRw09dYpAF4bRdvp+ySJlod/ypJGha?=
 =?us-ascii?Q?2REWGWx8QQD5skO2r7EdYHopBa7hCFDPRIiP6DvCGpKt3/gXy8MmRNviFPad?=
 =?us-ascii?Q?e/oWfF+AaH4Ef3nip4BsihaUAH2/4zNVgYej3GfyuZrDB0n+aMoSKlLCjEyQ?=
 =?us-ascii?Q?bcm8gL1K/VF2vnWCyILN9mcvu9HqbGu3wj6E+v/jZPUepV1zqlNR2D+rLEZF?=
 =?us-ascii?Q?lD8PO42uYt5infK1Y689GgPDuQ2izS+agynkd2bntvRSuRj1/YybqzsVO4j7?=
 =?us-ascii?Q?6sJ8TKb527aJ7nrM65ldVbfOnrODhtvcB0bajLW4VWSmr3PmVkfzlpyk3qNv?=
 =?us-ascii?Q?qvspU2FinUT0GG7orlwOQulLjE02LMs88X85gLVqVDb0pxZsZk7lMTvTmiNP?=
 =?us-ascii?Q?KM7cDKsPVluPS01r4HdxCrz4BlCWZ1YwFT3G2l8FqQyVrhKpuFrdSBfAq0L7?=
 =?us-ascii?Q?NhttSH7NYTWMtcFeu5GgsyPVe034q/tIwyKCBSm54Z8c3Q+ConRURbXgRZm7?=
 =?us-ascii?Q?T0KIG2uIsm/BTb2MNlxKA7s4N8c6DiJuN6DRa8RK9XVmn/OVLzKUmSLvos94?=
 =?us-ascii?Q?9Rq+dNeQB8l7psD16bfo+FFlR2dNeGS2CQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REQaIGEaUyJjok7PJSRnaEETO4MZSnyddOoy0VbQ3T9lRiPf0vOA0sTLsyqe?=
 =?us-ascii?Q?RIqQQKek2Xh+Y3mzwnvvXg1YsOI3ZAOP3WvZNP3XjmXEgdUIqHauBJ7a1IpA?=
 =?us-ascii?Q?IykExxo6ktOJ3fG4aJscQVXyLFFhPjkO+04ynOs4vLP/3Gr7RWiEvXMYrS3z?=
 =?us-ascii?Q?sG5HITNTr/O32+/wDN5kIb0QnhXqe3js6nMWwvwqV9OpOSqdIKsd29ojBQjw?=
 =?us-ascii?Q?nEy1d96Pwo/+gAtKncnrESUnyvN2yHwT99Ge3iwUR395y3iZnY1orKqB3whM?=
 =?us-ascii?Q?pPe1m6U+I6UmLGJMGvhmC4LTvPwoGAd3NeoqZ+ioZ9+OyUL5BHPURDTtSUzR?=
 =?us-ascii?Q?8QOczYe9P7I3vh2uRoiagf+EeBMmAluFjlRHOGQ1eJokCL7kgqxj2LuUcZlU?=
 =?us-ascii?Q?TMhdNwvLUV6zZdv7jHqLS+WWm02v3+hdcG8gslw+rnRBOZNbIvt9mZA8Ocmi?=
 =?us-ascii?Q?x8RsV6E1Q8yEAG00VVxYZC6Jb8fubeVYfUx1FOvwL2jmwZHcI2Rfi3VBEAsu?=
 =?us-ascii?Q?lFTXVFWTepx5nqNyLhy/krIhONVVzoQJW8XurnjT7e+xwJjvCEcHn6XnLOnw?=
 =?us-ascii?Q?UJSjyyaZzPJ84inoUCFXPlEkqNdFnbF5oGs8sucFsEXD3nHCCYyjMsqAqfXu?=
 =?us-ascii?Q?yM588HGNBfkEXg9KXTCD3tY5eDUKCqA4hOmM7UvMofj4D4rNz5VlHOY7JVxb?=
 =?us-ascii?Q?b8UHO0q+suCI+sLY48e0HgyGItnZ6P6B8hC3pB4azMI/iksGykIb4+ja7YrL?=
 =?us-ascii?Q?IVd7Z5NtY8E5q5WAEZKqg4FW0M7JXrwnGOvTja4N7D8KpE5OdhBI/X6oLrLC?=
 =?us-ascii?Q?c+V/2z6n0Fmkr5nJDZf+s6phAqHw3AQcxqOWRLTJYMOLDtmMrjjBjECWGMSn?=
 =?us-ascii?Q?UN427IvxAk369OVyoSVJ/BhmS+hrvznZqLCsM5ougTSmOG1yrNmUdHptvUdI?=
 =?us-ascii?Q?vUjJxnm+xjHBCN4Na27DncgE9HngMSSLgbodBHZeHp82FDzPycRdzvp/4De9?=
 =?us-ascii?Q?5FjGHHuThqJgzO3fhpmn8pq1VfLGMtWmqguJk1k5SzaOWTywI6k8tQ++9xmm?=
 =?us-ascii?Q?84BNhLz1CHpMvp3OyYKFl3EkBZBe7RGZRMpYy9QzD0srUDTZfx9I8qO1ATVc?=
 =?us-ascii?Q?eJ/FelKcWTPsy9exaHT5LQABhKjCVDfO0LHOrtVDSgbAY79Qwn6LpOAjYvf6?=
 =?us-ascii?Q?UdlMQflGK565Wd4x1NgX3Yrc9cfBR7VPav9A8whqCIQk8US3mp9nGD8L0n/m?=
 =?us-ascii?Q?Kc76FLV8dq2JtvYJauH2CwhC+gcuVZHwZ4EWDljTRdcojGE4mnNPQYuBUzUl?=
 =?us-ascii?Q?V6lCcRuBN/TqtkpI0RnClgIwI/DLugEkn83nSYKY5uNIErUpgcZfbbfksaWb?=
 =?us-ascii?Q?PuyuyFASgxxiQe8uvS4u0aIv4F0ucHuhF75Le91Zwvtl1licKw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f13e2c-c35d-4ad9-b2bd-08ded1526086
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:08:07.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5365

On Mon, Jun 22, 2026 at 09:34:10PM -0500, Chris Morgan wrote:
> On Sun, Jun 21, 2026 at 06:19:48PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Jun 2026 12:25:48 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> > 
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add power management support for the ICM42607 device driver.
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > A few things from taking a look at the sashiko report:
> > https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail.com
> > 
> > > ---
> > >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
> > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 139 ++++++++++++++++++
> > >  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
> > >  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
> > >  4 files changed, 159 insertions(+)
> > > 
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > index a6a58571935f..4f4f541027dc 100644
> > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > 
> > > @@ -334,11 +345,18 @@ struct inv_icm42607_state {
> > >  #define INV_ICM42607_GYRO_STOP_TIME_MS			45
> > >  #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
> > >  
> > > +/*
> > > + * Suspend delay assumed from other icm42600 series device, not
> > > + * documented in datasheet.
> > > + */
> > > +#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * USEC_PER_MSEC)
> > 
> > Sashiko had a valid comment on this.  MSEC_PER_SEC seems more
> > appropriate given this is 2 seconds in milli seconds.
> > 
> > > +
> > >  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> > >  
> > >  extern const struct regmap_config inv_icm42607_regmap_config;
> > >  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
> > >  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> > > +extern const struct dev_pm_ops inv_icm42607_pm_ops;
> > >  
> > >  int inv_icm42607_core_probe(struct regmap *regmap,
> > >  			    const struct inv_icm42607_hw *hw,
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > index 4b8e19091786..64f5d263de4f 100644
> > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > @@ -4,6 +4,7 @@
> > >   */
> > >  
> > >  #include <linux/bitfield.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/dev_printk.h>
> > >  #include <linux/device/devres.h>
> > > @@ -11,6 +12,7 @@
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/module.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/time.h>
> > > @@ -103,6 +105,63 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> > >  
> > > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > > +				      enum inv_icm42607_sensor_mode gyro,
> > > +				      enum inv_icm42607_sensor_mode accel,
> > > +				      bool temp, unsigned int *sleep_ms)
> > > +{
> > > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > > +	bool oldtemp = st->conf.temp_en;
> > > +	unsigned int sleepval_ms;
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> > > +	 * for a minimum of 45ms. So if we transition from an on state to an
> > > +	 * off state wait 45ms to ensure a sufficient pause before power off.
> > 
> > Sashiko commented on this..  I think what we could do with adding to the
> > comment is what the path is that didn't pass through this function which would
> > ensure we have been on for 30 of this msecs already.
> 
> I'm going to track whatever time the gyro started, and then if less
> than 45ms has elapsed just pause the remaining amount of time.
> 
> > 
> > > +	 */
> > > +	if (!gyro && oldgyro)
> > > +		fsleep(INV_ICM42607_GYRO_STOP_TIME_MS * USEC_PER_MSEC);
> > > +
> > > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	st->conf.gyro.mode = gyro;
> > > +	st->conf.accel.mode = accel;
> > > +	st->conf.temp_en = temp;
> > > +
> > > +	/*
> > > +	 * If a state change occurs from off to on, sleep for the startup
> > > +	 * time of the sensor, unless a sleep_ms is specified. Since more
> > > +	 * than one sensor can be transitioned from off to on, select the
> > > +	 * maximum time from each of the sensors changing from off to on.
> > > +	 */
> > > +	sleepval_ms = 0;
> > > +	if (temp && !oldtemp)
> > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> > > +
> > > +	if (accel && !oldaccel)
> > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> > > +
> > > +	if (gyro && !oldgyro)
> > > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
> > > +
> > > +	if (sleep_ms)
> > > +		*sleep_ms = sleepval_ms;
> > > +	else if (sleepval_ms)
> > > +		fsleep(sleepval_ms * USEC_PER_MSEC);
> > > +
> > > +	return 0;
> > > +}
> > 
> > >  
> > >  int inv_icm42607_core_probe(struct regmap *regmap,
> > > @@ -236,6 +305,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> > >  	if (!st)
> > >  		return -ENOMEM;
> > >  
> > > +	dev_set_drvdata(dev, st);
> > > +
> > >  	ret = devm_mutex_init(dev, &st->lock);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -271,10 +342,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	ret = devm_pm_runtime_set_active_enabled(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> > > +	pm_runtime_use_autosuspend(dev);
> > Sashiko does put out some stuff here.  Please take a look and work out or
> > test if it is right (I think not but haven't checked that carefully!)
> > From a quick look I think that the auto disabling of autosuspend does a
> > rpm_idle() that should result in it suspending...
> > 
> 
> I see a few other drivers adding one more call to
> devm_pm_runtime_enable() so I'm going to see how that works out.

Obviously that didn't work, but digging in much deeper into the PM code
I see that devm_pm_runtime_set_active_enabled() returns
devm_pm_runtime_enable(), which sets devm_add_action_or_reset() on
pm_runtime_disable_action(), which calls
pm_runtime_dont_use_autosuspend() and pm_runtime_disable(). Shouldn't
this work, or am I missing something? Basically when the driver
detaches shouldn't this chain end up calling
pm_runtime_dont_use_autosuspend()?

Thank you,
Chris

> 
> > 
> > > +
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
> 
> Thank you,
> Chris
