Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011090.outbound.protection.outlook.com [52.103.23.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D13FC5C5;
	Mon, 15 Jun 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534972; cv=fail; b=JP2ubcAIFL8R/5PI93gK4ll5ZEdKKOH9dej/Lj92Pwon38yifRAZHk02dvhaSHHTlRc+X3HMQn8QleOEwisiLApAosQYDF+jZ8A+vOAmZ9dYbnWMhDBP2EIYEkiTkU447taK+Gc0a98QouurvwBdqdIeCxlJXFuIc85dyUlZ/nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534972; c=relaxed/simple;
	bh=vAfYN+xTLmmIacy45b2K3XVEL7xrvApX/mOpwlXEAn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orzx02XaeGdeh0svJQzzEwoCl5IeUlLyTJKu6wvgiKpfROe6E0A21+T/dY9iH6nVTlS8Yz32g4cnVsxgY4Cx2At0P9GAK+OTI7r/hB7sRNybAm7VdnTc/VsQb3woOknvyD+SIf/ngM3D4sXzpLQmKx4lINJPYm72+1U6+9eZb+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kuDx3bfo; arc=fail smtp.client-ip=52.103.23.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kuDx3bfo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyqgTX7sXbGBPawZOnYstv4z3SGgTt/APF5vfhZdo0DeO0nDLw2v9bje6XiircAmuvagnRJkrIwHx957vqZhhsuQUFJAbZBS0zq33KuFCRh8+NaMxPLBjB/I6sHgPg4WTFLUG68ot8Vok5YHeZ7hsZGP6wxZvpXqOVVgnKNbfNLf9WP0IjvkQG/gDRxNFG9aHMrrKIPEEeOCyrZruL2KxHAC8F04woahjeU2Fj37isPrZiTkePPB/C/oqwGuuCi4+OEGAzIBihwythbqiDTAvuWGKHl210QjWCHpbUgp6keNbvBfe4DtxaK3TUS9vKwKAIHIJZvg1Dva6oKh7iV1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kkmc2LD+cVVEJJyWbIRO84Eoy1rOoa2J1broOTVy5E=;
 b=k4A7DtjQoTgSX+vDYW99bgjm9Y9k7F9g3ZQ6tTI/a+OhPQS84gKEpox5ClCO7xAnay6zuY3OcB+4pGU/i0VjhLZ1s6jAnHS4woADZq+GlWusut2YpK7RII3myE9HPZhXQ6CLYWopMqKn70E6svP4zsf4awVxEF0D/cn7c4seVSi2tVb2IWQqoMSK8oohR5hevUnoqIOmi+vysfmv6Td79L5c9c4DBfrAiYFNMl2vAhIdizfD8SlMxHT48iD7B8FkHfjo5t9cKYOCv5Za4hDRVOYLpT6l3zXRJQ7LXp0UcADBP0SWQFT18z7FdFL7PSB+MUCgMhai0TSGANXcEQnYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kkmc2LD+cVVEJJyWbIRO84Eoy1rOoa2J1broOTVy5E=;
 b=kuDx3bfos55X3dZ822mlHNfxZR48b9d71fMrKw3zIbiBlZTq682hwTaurGIJaQcgq4Sy5mTWW0/gxVi6bw/gZ/Dq8tVFIrPNTac42UWRfe04HfKjWrbg3xl6WBe15cJl52+30uMr8QwVYzwpaAG3DjPaYRe+EHuno1mua2cMS/68ol3716NOMJaZjr1i6jaEvbT3VUAH0Gv8lLkvHK+Y3yinbKFdoB3QuJUr2OeHLCljXVu6vUnzyZJwUyXjAt+FGbrSrkso/tSjyoQ7AqsxIqe2CKRP5GIHZBNUNl+SGg00/3lC+ZBjUkyKNWrUTLc1a/w9VBMeRYFPy1gVnHnM2A==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CH2PR19MB3928.namprd19.prod.outlook.com
 (2603:10b6:610:95::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 14:49:28 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:49:28 +0000
Date: Mon, 15 Jun 2026 09:49:26 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V12 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID:
 <PH0PR19MB997338D8F4A9372647962B97DFA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-6-macroalpha82@gmail.com>
 <ai_Tzbl3sZlyrh2M@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_Tzbl3sZlyrh2M@ashevche-desk.local>
X-ClientProxiedBy: SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::23) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajAQ9sV7ZyA69IWb@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CH2PR19MB3928:EE_
X-MS-Office365-Filtering-Correlation-Id: caec6b92-7f44-41c8-9b2f-08decaed4d11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|15080799012|8060799015|19110799012|23021999003|6090799003|5072599009|24021099003|41001999006|37011999003|25031999004|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zam+jafGHedCgw1FsxkfZoIFN87BbhXgw1UkbcGgRObPHsysdDQEY1LjQSrm?=
 =?us-ascii?Q?rqs5h0HLDIIXqWTHC6+oLjhAIFMxt4mqTtM6Tv+noArZZXRXkpdLJRBUXfCl?=
 =?us-ascii?Q?8RZHAFilBu9FT3ocmAb72/UG6EnSyJsjRDiUOc40RZsAdMANGFvVwp5QlCkj?=
 =?us-ascii?Q?sUcBdsgK4oYxhz+1Pii0m2Jk3BdXq9uKdgrD3ia9yHV9MzUzxRQ5w/yRBJVE?=
 =?us-ascii?Q?svdFjhdK97XbPaD4k1p0NacvtYIu1r4IMbjqybnaxas+N66lA9d9BsCa6jZe?=
 =?us-ascii?Q?cm0dmYAQgqS7mpUuV/2a00b5k2H+vA1dL/uCH4C/oAyA+neC1Xmuyfp3sVSq?=
 =?us-ascii?Q?MNZ6um7hfHt/XIVKa4oFBJx2M4OZKeqJI0/ktTmdoYa5CC98wEkR1JlLSY6e?=
 =?us-ascii?Q?VY2fyIG8dqnFQl62WIJhg5BdeulACaAeX8c3l8SRBxNCU7tWk5YPUL/Lk0W5?=
 =?us-ascii?Q?rRdMFpprZfeZNU5+WIOxON7e9Id91T13Ae7Zstag+xnluRcP+jZTN3MXz8Yt?=
 =?us-ascii?Q?Ke6208oITrF7gR88X2e80wGBjvG9ImXJJA3Ce4M7J7SLsyDP2gE5jV/2NKjT?=
 =?us-ascii?Q?99xEB+ef1qoKCDH/ZznX0ZNBS/a9L99K7EAigt1jiJh/veVPmuKdRHW95Bqz?=
 =?us-ascii?Q?ehv2EdRds45q1NPk9AN9PChKyMps0OQzalL5YIUkw2+dk/hlrYhBWCuXyiSu?=
 =?us-ascii?Q?RMT/H4QfLMHNT66Cu8rxp+HiHRFBCA3n2PlzviCBW49vUn4YHxSY6TtuUGDT?=
 =?us-ascii?Q?otkgnk2GxWUaBgyR7s5GOv8o2E5618mrkjX8TDD1gYYLAJ5OaAN+85FV/eqb?=
 =?us-ascii?Q?KriJGBqbEJfvz7vxrhNZD6zZiRNAdGlRZbiTLxrh5IEwDmADsgQepNB+91Va?=
 =?us-ascii?Q?EOIcCoCLHSO2whfwjKgdMAqJ8D+uwQJo/ef/30J6YC6agm6KKB5NVKZuZ4D3?=
 =?us-ascii?Q?5KtMFPJZrXnRd9HBQ42T7Qq7wZKigwM1oohe5vxSot6HWr0aq/X39K9485QS?=
 =?us-ascii?Q?GgzoluZtiQNPRlheIcc7r3fGArvExJ2Q3UGCYuM9mlaGV3eVtcxpKJqif9Tu?=
 =?us-ascii?Q?s27vNVJLPKTAgZCwL9OoWNEfnP3sbw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rucgXQWAvtG5gvloGKBDsNMK3WUAsLnCP+vpFf22F/grn8n5vD0BX6KHzfqh?=
 =?us-ascii?Q?RXLxtHF5rz6OTewUG7tXV+r5Xb4IBhJOW6ejkYKdtbNEgF+7giclqOeIjQUK?=
 =?us-ascii?Q?vadS+XH5qUn9DBxxwncF7NZyPoVRvBjMVzg69R/HHqG2yu1sKMsAgtqt34Pe?=
 =?us-ascii?Q?OGhRcLmyASBkC1iLjRPq2uUWi0av1CTkm3XdQrjT3J77ONVE2MT1vtC8/VpH?=
 =?us-ascii?Q?aD4Cj5OpeDEMHfojJuwRl25fXXbNxwt2VsWRhj16yKz+tJCI6nv2/A0u5MJY?=
 =?us-ascii?Q?UNFGeu1BLYw5ES3qdIG+goUx9n1bqR/fCJOGUgtU/PVK3Uz/VW5TdFFHjTwk?=
 =?us-ascii?Q?8skWsClZI1szvGUOGzXKN3rLFBTiFb8LgrAuAlg38NL+eZJRIZc8gLGCg+0B?=
 =?us-ascii?Q?vKU2X17KBlo2GsndAc5GawcBoSlGGPQKESF7psHAtKDiu9YAyIQCFvOO0bPD?=
 =?us-ascii?Q?1cr6KERwdXB5GQXO4NJ91FqTTSJ7gsKnbapHpjK2P3ox6f3Cvu8dG/9AhxmW?=
 =?us-ascii?Q?/mToK8HOmZbMScE6zcFnzNTLNBSOgDew4YZHWRNE/ceyaeT7KGswtRczEBfe?=
 =?us-ascii?Q?ELZImvHfR8Z4xyD/E9kUdKILzA2SnTTMJ3ydX2LNdyJDnoXOLrYhrV8z9rbO?=
 =?us-ascii?Q?dUM43tEJD07iR1wzTKKenVCqbvoQTecx4IG6Ne9haImc5Y3hx8lBvifma+cA?=
 =?us-ascii?Q?QuKxZcWhdZMTlLg65YeCXfClqb1nt73+21Ra1OGSWaImg1maE2vtCR8yGvWR?=
 =?us-ascii?Q?qv+5emNWn1BbZ5tYI1+OPdsh/Y7SsM3rS7kExNkX4i6lXi1NyIQSJDQ6BNBw?=
 =?us-ascii?Q?X9p4ELSi/15j11jruqYNjn90AQQyyE3VXprWjdFNVGFbU8WBj9UazsMsJ3pv?=
 =?us-ascii?Q?/JqAsTvUZ0T3GcLYqdt76VUHyEXCPT5QJsKVxJs8ZBB10InEq5hJMTbMbITY?=
 =?us-ascii?Q?KMtxQEo+zfmnGsT8yWWOMuzxdw+PbIszETzA6biGfUWqfUCYayIvLQI5DOEi?=
 =?us-ascii?Q?ZQ0uoqcCK8RJ91+aDNfMH005SN4efiTSkXAwuJj4DYEdkJKOb8D7ZV5Gh4MN?=
 =?us-ascii?Q?VaaFrYCOUIjSReRwwUXabYR2SnWNp5iOqC4we0/TVTUmxxNQ7NvV7YArAPhM?=
 =?us-ascii?Q?xkej5YzZXmi3OJcrTg0GTPE9lQCwNbM6+DZ5Grx70XaiSkbEsa744rVQ4PQr?=
 =?us-ascii?Q?iZFcE6TqmQFok1VT0BlIp0rcze8Cz5BID03YxJcjQER70USwLznZ4bJhbv3j?=
 =?us-ascii?Q?T8vqpNFhY9zj0CGCKvBjfaKdOTkk4SE96k0t057Z7rYS7/xrFwW0p7R/SPMQ?=
 =?us-ascii?Q?HMrAMdWhpHDoMSzUEl88rw7gzxilJhYLSglA1IeFgwp8kORN5Df3ewN17sLW?=
 =?us-ascii?Q?10hB/f0F10WnqPhx3Y/dYfb4RNWK6vylk6gz1YLybBCfE6wACg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: caec6b92-7f44-41c8-9b2f-08decaed4d11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:49:28.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3928

On Mon, Jun 15, 2026 at 01:28:29PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 11, 2026 at 03:26:02PM -0500, Chris Morgan wrote:
> 
> > Add power management support for the ICM42607 device driver.
> 
> ...
> 
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
> 
> This validation seems weak, see below why.
> 
> > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > +	/*
> > +	 * Note that temp being enabled here doesn't affect PM since
> > +	 * per 10.25 of the datasheet the clock will be off by default
> > +	 * if both the gyro and accel modes are off.
> > +	 */
> > +	if (!temp)
> > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->conf.gyro.mode = gyro;
> > +	st->conf.accel.mode = accel;
> > +	st->conf.temp_en = temp;
> 
> > +	sleepval_ms = 0;
> > +	if (temp && !oldtemp)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> > +
> > +	if (accel != oldaccel)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> > +
> > +	if (gyro != oldgyro)
> > +		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
> 
> Does it mean that it might be more than a single conditional to become true?
> If so, the last code wins, which is most likely buggy approach. Can you put
> a comment, and possible convert this to if-else-if, to clarify what's going
> on here?

I've changed this logic in the next version, but basically what needs
to be done is ensure if any sensor changes from off to on we wait the
startup delay amount of time for that sensor. If more than one sensor
changes from off to on, we wait the maximum of the two sensors delay.

I'm going to change this instead to just (sensor && !oldsensor) for
each of the three. Note that I also have to insert a shutdown delay
for the gyro to ensure if the state goes from on to off the sensor is
on a minimum of 45ms per the datasheet.

So I do expect it to be possible for more than one condition to be true
here, and when it is I want to select the maximum value for the sleep.
If the sleep_ms is specified however, we will use that value.

> 
> > +	if (sleep_ms)
> > +		*sleep_ms = sleepval_ms;
> > +	else if (sleepval_ms)
> > +		fsleep(sleepval_ms * USEC_PER_MSEC);
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you,
Chris
