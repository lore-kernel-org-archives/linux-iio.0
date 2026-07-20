Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012064.outbound.protection.outlook.com [52.103.14.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA743D51A;
	Mon, 20 Jul 2026 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567716; cv=fail; b=gdhoV34izY91PcT/g3qN6juNMNEvh0fNI6+GSP5NMn2KKMGNk3ZI88YUSd1lMOusOK4RobYWJ2SPaham18goPOcrqshzPw3sNumHPTym1RQ3oNHyXqplLTpLtRc25B4h+WDOuB57IDgVQQc1ngpoLvl1QTPw1uuIyYcNxXQmKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567716; c=relaxed/simple;
	bh=v+MmfLWGPIDFgQSFFwamwWjrANwSM3gz24AIGPXWH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ihRvj4HcRd/hjl8pIzhWBpbS9k6oUg6xCn6uDt5K1UMAlOoCUtCfHyKscghOBJaEoAqub0dTdTHKPj1rCkC5qwma/kNbYmyjHFNxA/Xo1Dqrzn/nCklVb4nono/jCGYTA85NaIKeAQexhLdo6cewPMJocJvviHATmiXuw9NNAew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=oxeHgCK3; arc=fail smtp.client-ip=52.103.14.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="oxeHgCK3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa0dM7Kp9OwwntdyMskFqEInl+obPxrfNEnQeMF+CrDSaUBmT9u1mukWpmFWGZADeVVdoq3MAJQy4hiK/EuKgnLm9wUA+FlFXQR6hG4U1fJI3ELmOZGpso12rF7RGhHGlq4oixaVFiptNxl2V5lkbIzFjBQaZGQ3+0QFWHcm2nSTDmZCMMj3DLSdGhz5ZYYaWG0CTkYP18fek0EX45UGywocuU9XWC7tdjrCdj/Vu0wvo8+pK4ZELbDRPDwH3IxN3m3RduaPqcMso9UUE6y+O4svW92eolIuP2M7SafvLHYEjkVt6HeByNaYmsxlH/eh1yajcoGweu+gUs7DnXR/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy4tIDWE2t3ra1aC3DmjD+mCedqvLWBNuyinYgKe3bM=;
 b=XeTAPxjrekN+c/PYF5FEeJ1WIIqPRittGPEQ+EA8pI9ezX6rgrU/E6yOM8epwh3kXakEKhrRsIq8sZ6rQLq5VTLSBWv6jYqRRi3icBTTIaIYRGAU4R6iJagHZO9r/h7pVpoP+rwl9yIx0Di8kekzH31Rfv9vMLGDebvlh7Ywl1rqaXIfuR1m13CTt1uo8M7vyKGSQ79u0DEfN/LbLYsNOqG4yMFzXJAGbYMIq8irGoTInu7SAvGgc/iCp3YBZaAFml07vLxBRQAe/3p0FiL1eTTqKZooX40+35lkXodauhcr1xGwKIbZch4AUzF3627FkSzRLF3xCIMWMBziCkqjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy4tIDWE2t3ra1aC3DmjD+mCedqvLWBNuyinYgKe3bM=;
 b=oxeHgCK3HRAvPrVMB0HegLeqyqXCdsXcThCMJ374a5v0f8TI1iMVe9rMAnQjKBYVy6kirDWhEnlYxcoz7FgAF7YlnQTHPe8EwoyNvRPghDBAqFmr9grYLAnGngm1rvgUkSYGgvA8G4EQbnFq93Bg6AWbifpsmmJFcMfbdqTXE8sveXCeifbhVzItbrUUckWfJb+JsOclbgEnAE2hS3Mg4tWQ4f3FzhqScYzetcQamAuylnhKmmqzGV0EK94eytw0sYF/Rb9tqlyZDVXR612ObOO6qPPcG0E6kK88+h1+fABDLwiU3LTQEisyA7FxStRqKbLUwqSh95MPah2HmaDy2A==
Received: from DS4PR19MB997335.namprd19.prod.outlook.com (2603:10b6:8:34a::23)
 by MW4PR19MB6885.namprd19.prod.outlook.com (2603:10b6:303:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 17:15:08 +0000
Received: from DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8]) by DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 17:15:08 +0000
Date: Mon, 20 Jul 2026 12:15:06 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V17 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <DS4PR19MB9973350E9251D329E03A96066FA5C32@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
 <20260716182637.24310-4-macroalpha82@gmail.com>
 <20260719000530.62bad145@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719000530.62bad145@jic23-huawei>
X-ClientProxiedBy: DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23)
 To DS4PR19MB997335.namprd19.prod.outlook.com (2603:10b6:8:34a::23)
X-Microsoft-Original-Message-ID: <al5XmmaCqUptHFj8@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR19MB997335:EE_|MW4PR19MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d5ee0b-2fa0-4edb-e818-08dee682725f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|55001999006|51005399006|4140399003|25010399006|5072599009|23021999003|6090799003|41001999006|25031999004|19110799012|8060799015|37011999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FQ+jtAWvSTlnvydfFxsOej/8rX769PgTrbCCNWHA9p4OhAtjmBxjdEUHyEi?=
 =?us-ascii?Q?U6bG/0h5CJo4rPuehpl1mJ5PXyqrP+uvnbxBdksTsYUHnnjHmLatd3/ODHpz?=
 =?us-ascii?Q?/I7mPc6P0l+BRyXqju04EZ10HPfiQdldTbjg959eKQkcbEiXAezKnQxqeJYx?=
 =?us-ascii?Q?/hFwkTIlUHcskkA/Pjy7oa2jMBIFtuJ/AH8SRMcn8/UynC41w+ZBjs+Uc8EI?=
 =?us-ascii?Q?Dn8C7qG9q5c3omA+mUFlKGcfkjUdD7w9O1+Wx8Q7jcrYyoINAzKrs2q7Bdzr?=
 =?us-ascii?Q?/OMkgVmuHWV1SvOGSXyb/a77muGokqQR2z0KekbjvTBWN0J8LDgIHW4p2TlP?=
 =?us-ascii?Q?K00bj5Gn2AeNW4FLipqHn7nNS8KgclBVa+ntAzU5MTHAksCfW8HKdMQXo7mj?=
 =?us-ascii?Q?wX75Z1ic9EKHW8usbL/uKy4qIT9B8GmoiNaC1/Rt+dDp0Z5m77Cha4xoB/t9?=
 =?us-ascii?Q?xDY42w1vw4CvTKQqBMfMPopVWtUw0lRm+ZPox/ThCMmXyZTcGu1VZCp9KaFb?=
 =?us-ascii?Q?PjZiFxux4oMRM5wWNauxWwq1h0S/dJvn4IUNb++eQ+Av6f/yL4CsqrDwQTvS?=
 =?us-ascii?Q?lxO3xhOzas3Z+JoC2QeT3PwWrE+xVezMtw+FdFhS7jfm57pnvkICMSR6H+GA?=
 =?us-ascii?Q?+bxM6Y8Z8nRB8Q7T45KyLgYBrLEnsKgu6J0a4s1MLs6kgr2k8F7Vwts3zip+?=
 =?us-ascii?Q?5kJc60vPctKQg57yK8KpRxwUZBTv70CMETG/X9sntKdT5owO3Yi54Ou1yY+8?=
 =?us-ascii?Q?V04BlRPaXQN7lyoE/3JDgcbivfDWLs+9Y6S/9FZjUUdMsUjYJOKbaIMojFeO?=
 =?us-ascii?Q?KD/jtyRtWUheOEy1nnwHZa6ypo8akFx9LpRr+xIYtQJpgkho5n3Sn0EJITI8?=
 =?us-ascii?Q?Pj5aCnyrLAh7AFLexrfHyNo5HqeTzFzGVkwr3xtqCu4NWNtAcpGbon0vbq2R?=
 =?us-ascii?Q?ER1jUqff/ZOviMbNFUDOHfm9+pV4vXPUpZT8lBmkV50UzBu3DVbro0eYvzUp?=
 =?us-ascii?Q?2Uy+cAc65FN21hpO1eBKhCVvIRxNfeXXM926pc3lHPDd5b2Mqh7NZJ1zdLBv?=
 =?us-ascii?Q?O45NZwk1cXfmGkFtWEuiNjP1zaU1sA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsacKQKH+iXYVPdwiu+aPYcxUF7xM2inDYqAUdVNsgG7p+qe9KneFZW8n41N?=
 =?us-ascii?Q?s72VoeDnZ1W0+mpXd8/D65wdG3B/470nHTtekE/luqgZfv9sUkMjw6u0tpW8?=
 =?us-ascii?Q?MP6KzSmz/THihISRfCGHrCEARvvV5EsjoRRcOWgmqltKstC6R3BtD9kXEkwR?=
 =?us-ascii?Q?2bN8cAP4UI0l7HuH00MIoWUq2/iblcctTWpT1oq8eHvPwyOpWTJKPnVF3zKH?=
 =?us-ascii?Q?xUjvMyDGRfQIx18lPVXr9fb0y3H/GY9Hn0XDpgaZebhGTHdpDepBoO2GwCBw?=
 =?us-ascii?Q?NYuCiQxIzXEiLjZg6dE+keDzkQtks8rnnp0IsOBbt/mfoXMvrgrQo3Y8aHN8?=
 =?us-ascii?Q?YJVq3gqr2jwt8547mW47h7JnT7Ivw9QMGXL395HLTfI2/6StqaOp2ltSDEqQ?=
 =?us-ascii?Q?ILf4cDcPp+7o/N+LamqyTRAUZ6GlH7CnxLsKbHUTl6zoa+kbNcTfxoUcqcmK?=
 =?us-ascii?Q?DzYRxECPQzqtB03Zk//jay+CDs2DcgVwZEDYQmmXo1dUxHul937GokDci713?=
 =?us-ascii?Q?WhGgg86rhYLTZ8s5FyAT+w/eiaEIlVtssRacmhR3HV5P6yCQ2FTwkW5TgkPK?=
 =?us-ascii?Q?aU0zIA/qSAF9GKhcgzy1LIVewmsAfup1nCRb9ZRNfCCP1/jfSde9GoiTC7sZ?=
 =?us-ascii?Q?H7lbF6Ti+Eg9StNGdp8/i1OXGQp6ZgKCrsurRJOChFZhxqeYEMZImU52ZcYZ?=
 =?us-ascii?Q?XHHB3pPPx4jtvVt336/iZcDDFndehJXrywmO7LTZMC9F86GwnI7zySoSwMzL?=
 =?us-ascii?Q?+GVXY/GuDS7E2EwTuqmVbgG6/GYcLTNU+KpeBpV2Cdh2QbjqAUZZql4DHKyc?=
 =?us-ascii?Q?nmWrOjZ+1qnxDrYFSSgZlOB3O8V5hC1KkkRxpMT/Rf90fUhsTjaoV+ShkH2h?=
 =?us-ascii?Q?VQZK+HuomjeRXC92Y8O9DqoU/zUR+DzBfHf7hqLrU90RTbnkLpa9A4Pop/Na?=
 =?us-ascii?Q?CMmihvanAunlDtB7g0i+F5R+S41NXe6pFoT/fABRfVQQEpEMozdi7eczlhxA?=
 =?us-ascii?Q?UVtolStxTPjWImu3OVh41XlYxwZjONOscPNk+lohup46guE4xEvO+swDyaJu?=
 =?us-ascii?Q?NTaF3fuGPs9MYvxdjbIXsC7oZjEMiqdPUmNnla3wujwcAsUOW+sBeXI2FXIz?=
 =?us-ascii?Q?V6CbBFezg1Sd6axRMYvINXtL9zebiT/atrduPd3D8AkU782S/hegciNdRiFA?=
 =?us-ascii?Q?RtZe/1ysmfRJHjPTpX4m1O9o+un4G7pqdh6e9NqQ446TEwmbENSyLGaPhdJM?=
 =?us-ascii?Q?YIaNLFTieg0lJV+oljKec0dy60PimvRKFRZgLspI1QBXlZxg1WWfeCinFz2x?=
 =?us-ascii?Q?R0Ng+7SedU12/ZcKNyGQ9CVV++ZbdYReSJbaM0OC7XnARy0M+wlrbgqre9Cm?=
 =?us-ascii?Q?TiouXup2aG21iYwNd8RgokLjmTBixzHJezkisQlEeZ+xeEIytHFxO72IOg+5?=
 =?us-ascii?Q?cgRmonQhgzg97dDkBc1OPo9qnx0cUM92?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5ee0b-2fa0-4edb-e818-08dee682725f
X-MS-Exchange-CrossTenant-AuthSource: DS4PR19MB997335.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 17:15:07.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6885

On Sun, Jul 19, 2026 at 12:05:30AM +0100, Jonathan Cameron wrote:
> On Thu, 16 Jul 2026 13:26:30 -0500
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
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Hi Chris,
> 
> Just one small thing below given you are probably going to do
> a v18.  If it had just been this I might have tweaked it whilst
> applying
> 
> Thanks,
> 
> Jonathan
> 
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> > new file mode 100644
> > index 000000000000..8f74bf38aad1
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> 
> ...
> 
> > +static int inv_icm42607_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	const struct inv_icm42607_hw *hw;
> > +	struct regmap *regmap;
> > +
> > +	hw = i2c_get_match_data(client);
> > +	if (!hw)
> > +		return dev_err_probe(dev, -ENODEV, "Failed to get i2c data\n");
> > +
> > +	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "Failed to register i2c regmap\n");
> > +
> > +	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_i2c_bus_setup);
> > +}
> > +
> > +static const struct i2c_device_id inv_icm42607_id[] = {
> > +	{
> > +		.name = "icm42607",
> > +		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
> > +	}, {
> > +		.name = "icm42607p",
> > +		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
> > +
> > +static const struct of_device_id inv_icm42607_of_matches[] = {
> > +	{
> > +		.compatible = "invensense,icm42607",
> 
> I'd expect to see the data here as well.  Look at implementation of i2c_get_match_data()
> and consider what would happen if there was a slightly mismatch between which devices
> were listed in each table.  To avoid that fragility we normally just put
> the data pointers in both places.

I was advised in the notes for patch v16 that it could be removed. Should I go back and
undo the remove?

Thank you,
Chris

> 
> > +	}, {
> > +		.compatible = "invensense,icm42607p",
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> 
> 
