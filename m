Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749938D41A;
	Wed, 17 Jun 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730658; cv=fail; b=jYCMmdPj8MpbyRdAXy3KBg1TMw9VPTbtTZjXnuEV/X2IxSkSUYqjhqienILSJ0NyN4HjlRXQgVmPtXmHgJdVpAOIERPrBBMSi1/T5KaVWQvZXdSs+NmrKYTZDVncysmpfBiEwoVwj5ILYXy+BAEl/ZG1Kh86f/vd0EIhJOrQYRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730658; c=relaxed/simple;
	bh=8PBYZqqQj4W2xKagg4cEhRZWvv7iq08QjQIHbStST18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIuVfFnPVFgkl3EZU3hnajCwnl//sWaVSvR2J8RTi33g6WaVDwZc4IQXtBerUepWSeoORB17PJJfp3I727J6z8vUGU65cwwtjHutpN8ORcRKK+rcJJPU5wiGyg1UHYMayU63tKrvmaGZJsrjaRapTSuwVkoELD6d+5/gGfiDN8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qZ2A+2qh; arc=fail smtp.client-ip=52.103.12.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qZ2A+2qh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxG97C29aTEqo1u9500SfjAM5KtAo/GGegqsGRPdwx2I+U4+LOA2zb3lRdT3X/+11YOW1ioiduj4qaMlP9wJEOuzFScxLoQKKnfEHJVrHbMDZcfPILsMMUZPXbGrD5yW6Z2pTvdqlerciPNjm7uQICfpEHce3weNnO27BTM0G4AJc9PZjZrFt1bEnUG7SvCrnwrCCF0OQF5+3gkacrbFC+4GZc2176IYf6zjrRrr7VdCirY6Kv9CWlVuBmP8rP24vNEd7KAfwqb6btYg8DDLa4aGPnaqhU/OFT1XTEcHTeCyBENReFgoruq6Eas2TfLVdyGIhVtdO084yz+ecMMMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moH+IIGpse93OkLrG4rxLgvgdkqOwCNfEksCK+1DTfU=;
 b=EbQYt+yL68J4f5XB3NE2DuWwsFfZoUM3Pc+XyuNHdSLRznTpR0whiF8fmjNRH1p6YKHVEbM/UjSnogq8o0SkH4vsYqDYEDTJdDsIOIW1arcCmbT2i6Q74AOHDokjpxW2gSTl9P7RPs2VBxUkcF5bq5RsiAov6FP93cP6xIwfrhY8WyLitF1+8liSezrtEp8xoiN1K08w8lj2U64YuBRFTMZnYJ0qkGcFmTUWPdav4QXlbVAOXnLR3g9flViI15m/3/hct7Dbg94RNLx1Pbzcq42dX+c440zmlRQspZoxtsC0rSGmDpAFdpM1TeCEOK+cM8BpGhikeGpybRefScHhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moH+IIGpse93OkLrG4rxLgvgdkqOwCNfEksCK+1DTfU=;
 b=qZ2A+2qh6tDaoJfdCWS0Qf6cM6ELIcfyKPu5knlo6JPJKcL/xuvC3ZMhybIP8g7ak0uWgERxyalWuNF91DINJ686qsos72N0goLR/pKJg7kSflqg+gpLCLgFwTegu4w6ly/ZERSw4FIuDv7tzJRxp4gjzLaj5KNJn/UvbTvl+wlXV94d5gz+pkP52ZNDTr8EB+20A0a0TsCeeQFDTL+osMJAgfvTQBsz2LCVMazFu3SAL+qWwBoBfrnWR0NJXm23RHdqIp01uI1Smt3SdSY9Ws8PnxyXyZbIKur0qaAufpa3lFEAih5EarDuReFp+muhuhLZP6Cn/txO64bdeK94hg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB997203.namprd19.prod.outlook.com
 (2603:10b6:806:4bf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 21:10:52 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.011; Wed, 17 Jun 2026
 21:10:52 +0000
Date: Wed, 17 Jun 2026 16:10:49 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Message-ID:
 <PH0PR19MB997338E86152468CE26F60953FA5E42@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-9-macroalpha82@gmail.com>
 <ajEhr0JIQwzRgoZa@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajEhr0JIQwzRgoZa@ashevche-desk.local>
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajMNWcDnL2HK2dxO@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA1PR19MB997203:EE_
X-MS-Office365-Filtering-Correlation-Id: 336850ea-c59b-4903-93ea-08deccb4e9e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|6090799003|12121999013|8060799015|51005399006|25031999004|19110799012|15080799012|41001999006|23021999003|37011999003|5072599009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6Eq2Nx50I9oEvUGbwm+uiYozLvbP/AbWWRwqxK5TIw7wSpblHKueIEBVAbF?=
 =?us-ascii?Q?qZx68n4mYG5lFiTKvFP5Nmc5gbX5ppQoJIRLkAQtVuWXUbZb8zTU69garMxe?=
 =?us-ascii?Q?ePmVTb7uH7aJINq+TbWgjCG1Y3oPFMU63oNqZxcpc7aezA67UBX6bkXhDAIp?=
 =?us-ascii?Q?xRIzTD9sdH4fUOGXu7ilH3neWWiVF++/Nop2/LpEzlAwYn1EXgJ4fje75PTg?=
 =?us-ascii?Q?NkVZzMVshSECFK7Yn7XmHc3wJA9/S92iAec0DDnRuZ2zO86JyO2KUGOmZK5+?=
 =?us-ascii?Q?vrr6WWWpzy2Kd465OEeQRak36WUdlPRHyweubixEcDn2PydiAkBkLNl3opTy?=
 =?us-ascii?Q?iJkXRVzXyEeV9AuoqRpBCRmE358gmqFUYof8T5QKoZGmaBq4cuQgrslCUrO0?=
 =?us-ascii?Q?fp4WpDVcws36bAV2L8nmfOOLM7eKBdiUKZCQQuuj24aBPWNrVZf2HL3INeWY?=
 =?us-ascii?Q?vHwTIfUmQEAnQLP91Sj+JxmuOGF6fElT37hYAMHUpNSUH4mmjMwDzK1Dg9eU?=
 =?us-ascii?Q?phcnv1vik0gbUtbNsZzLNq9wQMypK18FloPgVKxVpWiOfUAyj/YCQxivB1mk?=
 =?us-ascii?Q?V1PhTOdheJCiurzJY/HmDeJXWWvz1qV0yd8vFq+OeERTzXehCJ7b+hCuvZaP?=
 =?us-ascii?Q?ZXZboBWslLPU2KMt5JaS+RF4rQ5RP3IXtpthYx+MmNYw9QgRB337/oQ542xP?=
 =?us-ascii?Q?iqxKhRi09gUuEXto5x1NQI9wYQ+++0ptNzVGqri9lM16O0q/nTMz3oQqRvNk?=
 =?us-ascii?Q?tYGX05L5pemcX4p/6Fot+VoH/xJi9/iECDTP1MWAP5dmHQq6LkOFrLUWGkXM?=
 =?us-ascii?Q?M0I7EKI6OLfVxYcZ1fY7hQ0qM2pWChzgZgFjO///x7c3IusxYCQ1V1t0p3HB?=
 =?us-ascii?Q?IDXAgqaG9aBY2kH1WqD3BqIM18P4kMKBrOep4JAwExWZsQ1pfQ78BEAhUeOs?=
 =?us-ascii?Q?eSc2lXtOeWhOyukbM7zQj7zw16pkoQU/8mBx2w2wVxwMMSXjPqBE/Hvz6qJT?=
 =?us-ascii?Q?8IL2+qdoh07j58hnZ+e/GpYc87FgOuSVCtZLzrhbLu06tfpSWkf2qBu6eIIe?=
 =?us-ascii?Q?FFr4SAceF8msC5DzoNMKOTTLEC5+veKsOGvCKJntE2gwj2lRQXY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yz75LoNoBUxEzEHbDR63dl6fIlsiRIbOGbneV2wpg4tCcncGVoHWnlT00xC8?=
 =?us-ascii?Q?t2p6Dd8LARlw8X+aoOlMDNXEMJlm7jZT0YXM5OmtyqQijMUh+6SlgU1zIhP6?=
 =?us-ascii?Q?QjZCxwtD2iBJSIonuacHV6PfqvMTTOiSUUTaTktmaAjXIEx1W/PxCApxqtGo?=
 =?us-ascii?Q?vhuSsf9nFv1t7TLULO1VHhcd5rKsNVDZUqtgRNmtigwRF7xmvoi3lRHjmLJ7?=
 =?us-ascii?Q?ZUKkd1LPg4k7ylF0OdohDWCgdqRzYEXAKafX7pAvpkvMwPVRFZgoMN+xygQl?=
 =?us-ascii?Q?c3itimIsaBs23eqdzyH4Q064H8sdCtNCOgw7SXsqkMioYnC9IZIpEI3QzeNG?=
 =?us-ascii?Q?eyqsl3iBvrbbfbspDbSVvN46Lw65FIlKzrLiFiw7wYzH59UM4jogdDHo4coo?=
 =?us-ascii?Q?ljud/eWyM/Z4CkVA6AKSR7RUepB1POHhkujoDjnrYIR/Pyoo0hss0ghqoSDy?=
 =?us-ascii?Q?sQRRYtqOAUoUkvvuyYp3IBBHGanJikZL49vKxSWvjj6CJMSocSLLm45mAZ9w?=
 =?us-ascii?Q?Z+V0m3FjzI7Fm1Q37MxCgip1N+i4ic4QaspTlqcma3fho+kHiBl5wy/g5Rf0?=
 =?us-ascii?Q?elIpJGCDkwAKwtnlVnbxQQ55lc8DYif6dpNQgJ1hgY0Mfk2e+znVAfnAkQZf?=
 =?us-ascii?Q?L9zsd7fmX1PuV/HCcH3FAlSWXFLbYtWf1PD1BWXXXAVNaoTBrJ87vAR/rxfp?=
 =?us-ascii?Q?uGSxST6ChXB5qp04AVIimEHM0iUqhc3/8A7MObGg1zQMHyahSDMUjDhR9ZM8?=
 =?us-ascii?Q?1FleQ6rZO+XkgVK1XWP/6JjQZbgv4IRFWAL7IWB6Ri6OHOZ07Ax1CPtWmt1f?=
 =?us-ascii?Q?lYJ9F9eDqSAikQHukDfiEZheQeZ9FAEASy75JfFAKV10oG0OaXBHsvcfJ4gI?=
 =?us-ascii?Q?n+fEJw18UMrEdGxOQMTER+5l82/yS8UCrI8NYEiOsXZOErdn5vrrKSMEo7gX?=
 =?us-ascii?Q?jbbU0wvikpX+bXS0mxfhhSfE6njj9tMG/r/s9Hd/pWbX7Tmgim676p3YfAPA?=
 =?us-ascii?Q?u+aiYKmXt9s63O/6tboi3xrx4P6qIhV68dZRdfDVfwgDuGPCN61QY6LcrNIe?=
 =?us-ascii?Q?EfojrxTBDqfcxZH6l3UAkl1jMfnXXrLxSWzVhr19jdbCYjBGNv/MS3DSy0q8?=
 =?us-ascii?Q?swBq8J5RwHI1qKCGtRcqftwtQh3VtNa+RmMCNhDP+NWoAdJHZyJQTVPTpZra?=
 =?us-ascii?Q?rD4a57CpFgmFzG7dmS0gKxvPisFMa8rb9hFQnPkyD/WKCUZZg51Ut61cL0lo?=
 =?us-ascii?Q?IhUvAdxBoQ7FHouz3LGx3e1MxewZ+KXPLJvU/R/mLJKbu8St8t7v8X/GWDEx?=
 =?us-ascii?Q?EpUkm7giVWOk0PJ2WlLnaD85n1hv8G3GgcQQDMmyXiMAsNdKaw+H3FYUYM0a?=
 =?us-ascii?Q?p6Bq6MM71GBaDyOCMYZ3hRtV9HEpb4RutYf+7rLYrMVJKh8lHg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 336850ea-c59b-4903-93ea-08deccb4e9e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:10:52.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB997203

On Tue, Jun 16, 2026 at 01:13:03PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 12:25:51PM -0500, Chris Morgan wrote:
> 
> > Add gyroscope functions to the icm42607 driver.
> 
> ...
> 
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
> 
> Same comment as per previous patch. But looking at this, can you rather have
> a helper that answers the below two questions? Something like
> 
> void _assign_conf(..., bool *write_odr, bool *write_filter)
> {
> 	...
> }
> EXPORT_...
> 
> in the core driver? But wight both approaches and choose either existing one
> (as in this patch series) or what I suggested.

In the core driver, I was going to do something like this:

static void inv_icm42607_update_config(struct inv_icm42607_sensor_conf *conf,
                                       struct inv_icm42607_sensor_conf *oldconf,
                                       bool *config0, bool *config1)
{
        if (conf->mode < 0)
                conf->mode = oldconf->mode;
        if (conf->fs < 0)
                conf->fs = oldconf->fs;
        if (conf->odr < 0)
                conf->odr = oldconf->odr;
        if (conf->filter < 0)
                conf->filter = oldconf->filter;

        if (conf->fs != oldconf->fs || conf->odr != oldconf->odr)
                *config0 = true;

        if (conf->filter != oldconf->filter)
                *config1 = true;
}

So the step of copying stuff for sanity checking as well as checking
if I need to update config0 or config1 registers is handled here, and
I can simply check the values of config0 and config1 with an if to
determine if I need to call to write to the registers.

> 
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
> ...
> 
> > +{
> > +	unsigned int odr;
> > +	unsigned int i;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	odr = st->conf.gyro.odr;
> > +
> > +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_gyro_odr); ++i) {
> 
> Same comment, why pre-increment?

I could not brain on this day, I had the dumb.
I'll fix it. :-)

> 
> > +		if (i == odr)
> > +			break;
> > +	}
> > +	if (i >= ARRAY_SIZE(inv_icm42607_gyro_odr))
> > +		return -EINVAL;
> > +
> > +	*val = inv_icm42607_gyro_odr[i][0];
> > +	*val2 = inv_icm42607_gyro_odr[i][1];
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
> > +				       int val, int val2)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct device *dev = regmap_get_device(st->map);
> > +	unsigned int idx;
> > +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> > +	int ret;
> > +
> > +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_gyro_odr); ++idx) {
> 
> Ditto.
> 
> > +		if (val == inv_icm42607_gyro_odr[idx][0] &&
> > +		    val2 == inv_icm42607_gyro_odr[idx][1])
> > +			break;
> > +	}
> > +	if (idx >= ARRAY_SIZE(inv_icm42607_gyro_odr))
> > +		return -EINVAL;
> > +
> > +	conf.odr = idx;
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	return inv_icm42607_set_gyro_conf(st, &conf, NULL);
> > +}
> 
> Can be some of the code deduplicated between gyro and accel?

Probably a fair amount, but the deduplication will likely need to be
undone somewhat if we get buffer, WoM or apex support added back
(I don't have any devices with such functionality, so if anyone will
do it then it won't be me). I can refactor more if you want, or we
can keep it split like this to make it easy if someone else wants to
tackle the buffers/IRQs stuff later? Your call.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you,
Chris
