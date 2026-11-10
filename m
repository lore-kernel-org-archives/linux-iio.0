Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283021;
	b=FrXhk6OQ9JY1210s9SPEn2ZRXSTu+9xGnCfA4NBIVG6X0loIihnV+Xps2Fs1UfyQKtCW
	 RcjCDOEqG23QLmuNUmNFnZr9aADtLn1BBh2h8QC0ZNvEdbYvozCYu5LhpbYDu+qxnDCmH
	 J+4gQzoc+NtzyHCrUsUIvLzF1fqg1WUJ5CmNTT0GHWT3VIck7sN/1DAp3mppUiPl1GtPw
	 /WV12gKTPQs89RQMEjo7cZ8yEVPUDmDrtsBSG7YKH8Gm9K8hz4VNJ8Zq6K2nJumg/A6Hp
	 dgOZizyiKXd3mFJEIt1f0iW1UrZ6iNqWNB8Qe4P73pLpsjTd4PomEXmon2MCbil7PYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283021;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qE6F6zTKfrqZaallJIWsDyBiW3wWNlC0DxafMSAHVvo=;
	b=iJBxhwUWW68arFaKRRS8JrGHiNKVFkNEvWHe+zDLrTH7wlfT0oa4H1U8sCKlkJTp+v3O
	 BJvnHTSDeQelZz9Q9eFQX715ieGzi4IkigQAcz9bhF8MjpwRc8EGGSJzX+j5jWBirAUVr
	 wgQMuee9ddSxXH2Z40kWPCb6FG+zc2Kemn4H7N+qKY2xOuDxYuFHLFTjesqJ9tfbkNWf6
	 LTYYBUAHXgx1HxrlylCstQr6enA7atKwq5RmkhfagFEXVgarlBjcb8agWQSOUfNlprDaL
	 ze1ldQz5KTtHevXP6piBgt0fe1YQcLr7Si5Wn/lEy/mOZUvHD7fIq8YyyHkYYxbwU4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nuo11RdJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.2
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010002.outbound.protection.outlook.com [52.103.12.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7B606A32E;
	Tue, 10 Nov 2026 03:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A7B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nuo11RdJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F599tyCSFUDETZAykjxLfR6WWwKZ5M638XLhcbItJ94FW5eHJUEHqJ+IvUADmLPrEjaRxXTtdpg06kpDU3KBaQh0z814/WtLv7pOnjZA9FTi9nKNI8RE/Mq5m+Et81ydqed/gxN1Fo5wtZK6fe6IbXxbP3NiWQcRx3IeI7AZqR7oAr4SOqp8w2NjSjZfcTAm84le7uUcJdI8IZMqm8/+G3wHvaWXFqp+VrlVJUV5bOaXixQrCXbIltpFGm83GuNFKZ9O2PnCV22M0w0QLZimzmEsJhcY1sGMknBwvI+1nXgD1tCQSZEbqshpOjPN/hCyQNHh8Iffrg3zkMpHow2Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE6F6zTKfrqZaallJIWsDyBiW3wWNlC0DxafMSAHVvo=;
 b=AhnFfLb82OS31n+ogz1YtAxVmfP/m/gBYJCUjBY5j1ZNi2By5FMXWuClByfqGXhzJlkt/YrTRbd4ADkUh5YnW3cXLEYmXnVNYi6GMeq0PWjVnJcJD0miLzBf9hjkKDmHwkFLIbvHgbJzrK0uJilFar/xG46If7mVdZi39rCxJPovAapMMUqLQTqkZQadYfk0sTBLy9UE6T4CzrVo8iMuN/3K82FIpXiLL5iJ1j8nWrYouUPgaiJ+vhcQ9ruR7dxE1FFmeJSILWx1TZo06KGNsVnwk3QUQkEif2RhzmXere3HzWO/Zdn9dcowJk29gUi/PE84xO68XrO/jKmu0+nFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE6F6zTKfrqZaallJIWsDyBiW3wWNlC0DxafMSAHVvo=;
 b=Nuo11RdJZ+jdRLrBo3r11YMh+qvyYrP2apqhPQlTP0y1qjFj4KQvJ73UIGuOVXzgloFQcHjIbdcidhs1t/tF7AEL4QBTMHC6BjcKplW7ki0J3F3sCkFrSWAOOuEECv27V8nbP8sjWbMB/Ln4uALc2UG9Olcvkf4jUJTLmteFZxfXYm1X70qFF8VVXtT5DJh5zRTWxf0SoQtnH2NtY3UvX469ya41D9gEs+Jq2WvJ9wMyRnwVg9AOVvllUQXdlbESqdp+bpwmELdpKFSfJ68ht4didWhgO7rzv6GLmMD3MNVBX/Ck62wZuuRhg29LGxNWbMGQl4ulE7RCiTVbzPL2uQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 03:56:57 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 03:56:56 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v7 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon,  9 Nov 2026 21:56:44 -0600
Message-ID:
 <SN1PR12MB2528754241E5C6271A02734FA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avJZyb5S--smaHpX@ashevche-desk.local>
References: <avJZyb5S--smaHpX@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:610:32::26) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110035645.1031945-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bf4d0b-3135-4f6e-d791-08df3edea980
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|260925184616899003|12121999013|19110799012|8060799015|5072599009|15080799012|22091999003|24121999003|8022599003|24021099003|23021999003|41001999006|10035399007|1602099012|26121999007|3071699003|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOFN9UskhEWjqg8raIIihZkjcHdMq3daX6V19XLZRQCo33YgpVXnXZtF22nn?=
 =?us-ascii?Q?wCXVcBbtyU2ypTbo8Awz88mEl2WcttXlMhVQ3f4jlpeHwNkx8jbmqxByOP9H?=
 =?us-ascii?Q?Vz/Yv55TKfa4+GTgyhFRWy9EqF9ApWttNIdfKCXaYXIfjG35ftBZYo2lJnfe?=
 =?us-ascii?Q?PC9LFrjyZFW/Bjk4juAaogGscnkF+6YCV5RPi57W78/YelDdC6cGtMHvhQdF?=
 =?us-ascii?Q?odiS58zUsJq5sMr3xMaTSO0ll/+A5wiY2SExK6c20oy18AB1LBNyiqU1nF4V?=
 =?us-ascii?Q?VAbCzAGMV0SVIUDLYllTjd/HS+OMJaJw6pUFBZPgoqRIjgXfeuNOxP6TJitx?=
 =?us-ascii?Q?WSRb7gSf+pkYEARh4ivlg9gjtUUSSqJYkc+7E8LToiWVTSZ5LUNr7y9n+UI2?=
 =?us-ascii?Q?4dVS4wN8gERAHbAHK6Z3RMCFFKM/Cz23aqrIlm3KN11x04jWrSyZjDmbYqQq?=
 =?us-ascii?Q?opu9MBVvDtGzurvwi3Y4sbaVi06DTk+fG3GstXIm8gaENV/SXUziNnHYRIsJ?=
 =?us-ascii?Q?iOL2+Ay3cf1CBUEha+gfDYVcpqF1koU4RznnrzyUII2UsLUhbDf2shiJNXTQ?=
 =?us-ascii?Q?K9mtXqvzscSprEY8PD5tVNfsDuxjQfZymQAh1d4azkN7nwwnbxDrsc8sS7aD?=
 =?us-ascii?Q?y4wn3PxuKYUnD2XTb6CpLA0k2vJCZS0+CrKXPK9YShqoNqiHXsZdI1bTQ3h3?=
 =?us-ascii?Q?5S8S6HH53tqxyF2hWQusdgZ4iabAreiLzi6L0NAMsLcZBZvL9mFAKwHhbLr0?=
 =?us-ascii?Q?OlDLEmjWHXAhuzqeVahSi18y/sd9khq8NG9h2hqaGlIy5wcwbC1C8cN9aJXQ?=
 =?us-ascii?Q?jed67XtUPLszJETfIy5EkeHgt+r4O+qn1Ix7qEg0FCrXYVHbnBySWRiSz53v?=
 =?us-ascii?Q?013vqaBwgPn1p0+ZutgQ2LKHvIU/wqTkz4ACIYgcdb2qWH7p1X+7c8quPQl1?=
 =?us-ascii?Q?OiWN0zSgfkSEMSZKRm5LH3XJ6WziG9pijX8rblcOOV19Qt1e8sPmUVO8hcF7?=
 =?us-ascii?Q?aF6koorny7vbc4ye2/aeEdfz9zo/RsWF1ELwWdqrpnblSpzzHXK/GehMh1Ef?=
 =?us-ascii?Q?476Ca0yGMWGY/0IXdfUoT6aGNdXyY4+FBplJwEzw9XRD2hMe/H4/kv7N1oK3?=
 =?us-ascii?Q?foFE7cE1kS/pZ1wJsGP3BVNtnWMkfjs6JjpJfiUIGxPqcl6FpQ/uNMk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BddBqTQ358MA8OXm9Etj1Z/HLRzhp1mMqBRCZ72lnTljJ+yuMmQCzxqGxnYo?=
 =?us-ascii?Q?BsBN+cifGxb4erf8kHzW084ZYDSY4PCoCCrdtHwc0F4GIjDsPSdvqRFvOvy3?=
 =?us-ascii?Q?gPWRAzQCtdpoq3SIdke5eS9Mpwa5upvCdR2LNgzSadrk6j3t0N8SukN9D4rB?=
 =?us-ascii?Q?4+ijIYRXY5ofAeB5CNV34N7oJpFX7I1mk+I18sHWbDWt0NIW+WbIwBmDeBou?=
 =?us-ascii?Q?079OuZJ/w1eH9o7q5Nk1MKfOTlECps7qRI+3BhjREMQeJ+5xQlR+iVU3DVTf?=
 =?us-ascii?Q?0qCG9oST09dihhnsy5dI6wcf2Q2dRWsQIXl1JsjpiIsyHAzKtisepQYDc6wc?=
 =?us-ascii?Q?85IFanRAOqSs2Oy0RzbXfEqgwdsfQyyukLqV69qvxlUQGIUwHfn1vttvfTS1?=
 =?us-ascii?Q?5n4jbo3fP267kx1QMA2Pb4CJTHvwAG5UYudB7KV6nVdyRbeBlkSfwlJe6G+o?=
 =?us-ascii?Q?/CfD1glgIxIAjzgSNSBWzjeM543UkFSEDO9gEISVp6yrP2lOzTnLO2Z0Y4sG?=
 =?us-ascii?Q?mDEXWt1Hd3L8MUOcG/T1qvXegPdTSixzSIrGENr2oooqt7F/2VZuQyCp8TEV?=
 =?us-ascii?Q?hewqXH1bkgt3NVGHJvYfdewFi9ErgsmA9lD9o3yZmGVGwMY95/bJcxJSOKNr?=
 =?us-ascii?Q?5XDDky9Uq8W5Nee5dafqQNBOPWR4Q9//YKAbgBElgFTsikD4P8vgTsMtPSxv?=
 =?us-ascii?Q?A9dUlDv/KACvHJELpD1tJ5R+pOUKMx6vp1pi7mCOES0mA63+uaECluZQ14Qt?=
 =?us-ascii?Q?NQjJVrjKJJWoHELV7Ku9xk5nQ3lZ90J6+8ZRUnBNkUB5mZS25NOs65puhfcX?=
 =?us-ascii?Q?y2Oa/nImftAYGj5ORSCD1oC1I/Ni+No16WO8h/NBWIps160zkYzt27JsIpt4?=
 =?us-ascii?Q?+mmsd4uBOCVxTGeQ9dfX0JwR+y0loHQ9CskFj6v1ttt+V39G876dpMOE7N8y?=
 =?us-ascii?Q?Hp22Lpn+yt5ARCWTNbz56VRZ2IrqcTd2R2Zw/wGdgPpvd6z4i+2VJyz0mz7H?=
 =?us-ascii?Q?V5SdeNq34uUF/4digIclVOJplTcKfup5ClcFq8W1mg+BDV9+rflIsHEZZKzE?=
 =?us-ascii?Q?ei3R+Ts8tg97XzHrqT9WogjhJofIZzZcvwj9op9wYAVjqWxtw46rzlnKiG1b?=
 =?us-ascii?Q?e0MfHSyV+l1u/5JtokZykL00wEIOjZGLSABrQwbjSUA48JlHWHT3W0h9HTlL?=
 =?us-ascii?Q?mqpCsRFzvckt9Opc8Vs6RQSEYh/NIRJqqsqfaO3FBQ0cxvijC/AIhynPkVgR?=
 =?us-ascii?Q?L4u2hV7jgxiW939x2EcH1piV2K/qAnOS/nQYhCSEbAuHKiAJEt6ZNVcN6nkk?=
 =?us-ascii?Q?BtCMbxluNYrV2/LwxHbelX52n2OUT8FwEUb2sFkDbe/aDQ5PsW/79bG4WAcJ?=
 =?us-ascii?Q?YbNidNGgDgQTRRXiq5Z2ezi20sFkXfUJB2BEFs5pJw2la1w/SA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bf4d0b-3135-4f6e-d791-08df3edea980
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:56:56.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291

> > +	case IIO_CHAN_INFO_OFFSET: {
> > +		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
> > +		    val % fdc1004_offset[1])
> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&data->lock);
> > +
> > +		data->offsets[chan->channel] = val / fdc1004_offset[1];
> 
> Make a temporary variables to have division and modulo operations coupled
> together. The rationale is explained here:
> 9b3cd5c7099f ("regmap: place foo / 8 and foo % 8 closer to each other")

Now that I think about it, maybe the modulo check is unnecessarily
strict and I should just remove it. Each offset step is ~10% of
the measurement full scale range, so if the driver rounds the value
to the closest step, the maximum difference between what the user
wanted and what they got is 5%. That shouldn't cause any surprises.


> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		val64 = iio_val_s64_compose(val, val2);
> > +		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
> > +			return -EINVAL;
> > +
> > +		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> > +				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
> 
> Why casting? Shouldn't it be handled on the regmap_write() stage based on
> the register / field description?

This was prompted by this sashiko review:

https://lore.kernel.org/SN1PR12MB252888B43D53AB1723952D21A5742@SN1PR12MB2528.namprd12.prod.outlook.com

TLDR I'm not certain the cast is necessary, but I'm also not certain
it's not necessary (if regmap does handle it, I couldn't figure out
where), so I've added it out of caution.
