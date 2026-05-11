Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374547CC96;
	Mon, 11 May 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527526; cv=fail; b=WkJmKfPeajMhzzjDGjdaBirgp5jwFGsUYaDGVT0YnytiZ9OkyHwtCWB8rul4Uxvw15dOUA7mHOuKjyLtJQmpFLqJRRwEqsFefSTkJammJ5tMJFZzbMmc6xqSlAkSZfvKJJ2wGZAaN1HwEBNPwYlN7FqPUS5Ze+tvNRO15MC+nOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527526; c=relaxed/simple;
	bh=vik1czcN5C2ETLwz8kb1wpvr2/Mx4XT+qnI5Qx1CQbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ULdaNv9Pj/L34s/AmaFpcC/dhEdyMD7ymCi+6uqQtiEBDxztuwTHpeA6qNiJ4kzhl0P1s1zzdk4e2gVBGm98jtS1OUpCF7GrlQlzRfCQufAQ1igUG6Q8acGx2XGLtrl++Vy+HOjKO7+Z/46nx05UKVN7D0Zoxyna9MucB/zJVsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XOakkhP8; arc=fail smtp.client-ip=52.103.12.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XOakkhP8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9RtX1MqLW7bDInxCZuLW9M/oqfBWLn10mbwyuqf0QYxzw7PsQrpe62KUCT4ZwOnA0bcXiXPDjqc63ovlrOMnsPHr7uVjDmOSUPNcUWS11d6Cc0eBrKTi+haQe0R9KTWKbkOOkVYLc4VhReN6yLFgUfmoC4jI9Yszl735ig8pQA7cicr7IbSdZZ386JL0WUBibTjv1RdqWGtqTLciLmOznKc1fLKUomqMqwwrMYTrGPKjyTmTvSxmdkew+byfzF338F9X/Of0Xo30q4ADH2xkIAIs2ylvF32HjPuZEUKdmDgaQOe90oVqGFecPltRjwbb3Hxk+qSOD1iV+1MTFfkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KdFOPhCS/c5QHsItFlhPsdfjtqymjAOOzrBfYwWOQg=;
 b=Jc5z6sG13J6I51u8Qkz/RNUWLJj3RE8M1pHqUWoakFvlmMu23aE/OtQNZkt26sK/W4/n00xof0O/MaI/obw2fE2o2kx+LDJNrcFOwNXV/2N7o+xQRqC5gI5LkwBYi5PufhEtiNGbuMPrGb6fSt5KtTDFJa3n0+mV9cMfLiC9j6IXoIcZpLYHzUvr/bpEBbk0s/373vOCLtLRklenlQp/itFvBRhzymIsCwbMyvAkRgQBeko3cDc4rD9WVyxs0/Oip7G44fqhtoSO0/ETG2TnRdkVU/meNcZJsRFV9q+/TZyM6a4hqy8Z5Nd7gh+dYozh4E1y9zJteqUve1PbsIUIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KdFOPhCS/c5QHsItFlhPsdfjtqymjAOOzrBfYwWOQg=;
 b=XOakkhP8fKp4OineSTEg+6Vg/F6x0lHNNN4BxqMvn4KwsUgfwXLZCpSdE/TwE7J0CL92Tl+FnUTvxJHtn89mvRmsDkN8c1u4pUcWcQjpGBPfoWADsYKnAFFxROXNCOJn8T61/lFm0QR+k9H0Yy9Z2fUbT1GEBRYEVR5ms7Zv4V7pj4QbePGiNHTqN+Edte1lEIc0jL0UYp1oRC/j3YW+flw+FjT4XemiH0Nxkr1UPH1keN4+3RcTUsLl2quGCue/JZd9U5Fw+ydyYcQbaXRLKxPIZWYY9I+oIvoAq1Q6WyTei2uq5yp+pc9RAYDfc9dR/362qtpDx1pqZgUbPBjpww==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by MN2PR19MB3807.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 19:25:21 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:25:21 +0000
Date: Mon, 11 May 2026 14:25:19 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V5 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB9973387CE20819398ADA732F7FA5382@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
 <20260509191907.24734-4-macroalpha82@gmail.com>
 <20260511182835.3754c543@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511182835.3754c543@jic23-huawei>
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <agItH8oXdEqEgQkA@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|MN2PR19MB3807:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ef74c4-0fc1-4471-3708-08deaf930ab4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|12121999013|37011999003|25031999004|51005399006|24021099003|41001999006|23021999003|5072599009|19110799012|8060799015|15080799012|56899033|1602099012|40105399003|1141799003|4302099013|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jw2Mf2dk6QLcgKtv19HP5WB23u67k0nWLsrZzGrrGOXoBlqYlsIzlG6OCxX?=
 =?us-ascii?Q?lCv0ouVTp88TZ/FLBxhpDECRjrbUAi3q+GCZ1yie1Oc5sIEF0nMInpKuj9TN?=
 =?us-ascii?Q?DGea4GfCIEWs7GPWdll37Po9gGX4xPEp7TXVRRhGCxJAOd2ytZCsPcR4v8N4?=
 =?us-ascii?Q?5UhRc/IIaAYAp3yNhQ50Ablfw+JSha3qAuBjmQybHyG304P5XW8W/G50NbZz?=
 =?us-ascii?Q?Dk5/uzPdpVXIx8/kcdSqwyAGol0PKuUJ29EfdYxo3Atw62ZSUGd37VFimOD6?=
 =?us-ascii?Q?ovsqdY70Fb9/ZG4mvC6aKj2AUQsYc6oevSzC6dej3uDbag2zBHBJwWPw/0T0?=
 =?us-ascii?Q?CSuUfkICW3ah5QJr5brWawjJuw4gxkAVvkqPvH2hy1sjWA2j1VQieVzhZyun?=
 =?us-ascii?Q?WB5L/i7kpocLIbX/fmsH6E13+BNzo/D14/gkFBRCizVDmgznNWcUbFFl28hw?=
 =?us-ascii?Q?V6WhjdE538Ta6ZuS+MdIfwehSXovqMe7d2Gs6GNk0wNUePx3r+j2miNgVztw?=
 =?us-ascii?Q?SB+3E9OifbxQoLWCvD+lRjAXQuTJOLp2uLHNIbcQCSy0E1RIiuUjBaPXu/64?=
 =?us-ascii?Q?KTKWv2jjfTFJHiB3ZbqBBglDncazaBzr6gsyTgN346zSej9GGCNOOrGHZR9m?=
 =?us-ascii?Q?e+njy32CPCfjjhbuw3979Ve+mvgwn6uDi8gCVqUORvmreNbPpa2OETe8M5YM?=
 =?us-ascii?Q?83IQt8YH56vC/ypQC/yLqUshLu0PIrMd3oBs/azx3x7uEZTpDpD5iNDbLGPH?=
 =?us-ascii?Q?tpfou6cnV/yJo7KNYtIHm1duJngjIwiVkMvw4wRUJjo/HCWZZHLBXiAd+Yr1?=
 =?us-ascii?Q?X6IWicbJ0L3R05C6Bclslttq+WBieqzpEJt6dblH15MIWRPnOZdAShOkbcod?=
 =?us-ascii?Q?4NKFhusHg6mKJC9cFcw9QcIe6MmEqVLB54s2CdiXBHXC4Hor/PslVsnuZIKr?=
 =?us-ascii?Q?yv1bEKVg26KnDm2Lazptlik86B0i53cpdgxCl/VL6LVTJSQKuPvWEYIjfyRa?=
 =?us-ascii?Q?4uGFgVetGzZZ/sUT4equl71Mhe6X+KyStaGQHC85tS6To29HNK9yX42qMcf0?=
 =?us-ascii?Q?IOee4teZICUfa8x0MuL+JRGnB5r6Y4amoMrbBC3Xq64B23HqMk6ps6EthPlY?=
 =?us-ascii?Q?NOdPk5QKqkDOmGRma9DwIa+hdrEf0gOe/IjEkAAxXNvaqMvOaWI2dz0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7Zm49u4Mkd5evURaFWYe6XygZ+Knv5UYIsg/pMtdy3Qzkco4TNawHeZXSc0?=
 =?us-ascii?Q?9ltbllkics8XSJgWabuHSUhMGMgu0o0x32IjApQZwmTey1z2vhA8uumIEB0j?=
 =?us-ascii?Q?IQLWnlq6euZ7fDXmr+O/p7CwuMDY61n0AlDItVXVM8hyWmYMp6q8Hz50UPq8?=
 =?us-ascii?Q?jcyrEHP/3PaSE+cyLgDFub5KGr06fvWkcIfudgOZUD99cTp0o6OS324P1qDM?=
 =?us-ascii?Q?MPAx1mn1ZmhZNrnSVQA1ibVZOS7WdmmRAD0NQkd7vfCN4En/3NZ9qqdYvdQv?=
 =?us-ascii?Q?QU5HzkH+8MAEiG1Y5DzJlW6Q9nurNEZ0Ecl4lOwxBNToR6hkSRJcXp/2iH0c?=
 =?us-ascii?Q?0BNoHWgGKv98K2NaosCec+MkrHcix1HD0IZsf9YCrvt7eCUnI9ukers6CSbf?=
 =?us-ascii?Q?Tvy+UwbKteahzsn64XSe190G9U2fLY3pJrpYK1wvzT4YWRyQaWnO1YAzIRN9?=
 =?us-ascii?Q?aQNga4NXPUOI7S3x+qFrOdPg8doguPYL5a3E0BTmbVMYssJ95mXXQuMnHyo/?=
 =?us-ascii?Q?++zShxOA8WFcdRVQuC/dg05B2aYxLGTh0DumNjt1UbWM62Lld3BSn2FnWO4n?=
 =?us-ascii?Q?fM6MphyYqKodwVPUpR76TkooHGvUM9FeLN2HcDJlTpTskTJeSq1nL4PMo6Q6?=
 =?us-ascii?Q?ZIkJZ/8nJQUPOtp6qB5rgObpmDsPbsAsGST2cnIkK27efFWC6glxGjdXGNZN?=
 =?us-ascii?Q?6a/Qi1EbzKIsh7PJSFLJtI9w5JrNRnbia909UoZCHy0/Q/6kHPszMdcQ5Bwo?=
 =?us-ascii?Q?BOg6YzYOc60OAby55klFtkBEMOieFJJDsHX6c/3i7ffMMyps8/zK3XRHbzCB?=
 =?us-ascii?Q?SkDmlnoCcBFWtYkPHQlALLhFSGKXP+RIVMEDCVMmUkiweDn+OUscVlssT89j?=
 =?us-ascii?Q?Jglbm1a0EGTcbwBO7Z411FPIR87carWdrPusBfCoQ8+OwDxzUgmktyVJ6Uta?=
 =?us-ascii?Q?e8aZOUc9rmgJG92diXtllWx0eyGOh59s67vnbny1qCgJY+i8A4wch3RFr3jD?=
 =?us-ascii?Q?v6UQfhuOEoocMqbyWKeORV7sREPwY/4DxJCqKeQX2RL2dm1CPVfTS2Q5kYQM?=
 =?us-ascii?Q?iUk2ipi8/LkgyGIWAKZJf2mT/W4iYZHPpWM13Fj1IUvtsN5nzOus9XiDxzuo?=
 =?us-ascii?Q?bKAnNSftW3L2QUGpReIwSs+naj2s1aKAa67P2hGmlwp7G7DT2t+Il0nllwCr?=
 =?us-ascii?Q?jX5c7ezYcvKhq+bpam0xlwvF9T9eFFePZ71DIxUFEPspIY/i3ioMxNSVd8Uz?=
 =?us-ascii?Q?a4RX8679R+2+zyKnlY+Qy7XQGEeYCxmjWFEC+2J8jK9FWknw/DFDQLr9vWSf?=
 =?us-ascii?Q?u8eQILhND29tlFsL1Ek8USac+BzskZHyXLC4/LqXgtyVPLybgewnR23VsuMY?=
 =?us-ascii?Q?0/dX2S7jUfw+j4Gc49wPS+F4b0KRGDrot1Tn+2s/ffzsmCIzVw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ef74c4-0fc1-4471-3708-08deaf930ab4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:25:21.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3807

On Mon, May 11, 2026 at 06:28:35PM +0100, Jonathan Cameron wrote:
> On Sat,  9 May 2026 14:18:57 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add the core component of a new inv_icm42607 driver. This includes
> > a few setup functions and the full register definition in the
> > header file.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Hi Chris
> 
> The sashiko bot has taken a look and had some comments
> and one in this patch is valid.
> 
> https://sashiko.dev/#/patchset/20260509191907.24734-1-macroalpha82%40gmail.com
> 
> It's minor though so if everything else looks good I might
> just tweak whilst applying.

I see a few things in the bot's comments that seem valid, so I'll try to
address them an do another revision. I think the only one I disagreed with
was the stuff about "keeping the temperature sensor enabled", because if
I read the data sheet right the temperature sensor really isn't doing anything
unless the gyro or accelerometer is also enabled.

> 
> 
> > ---
> >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 332 ++++++++++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 210 +++++++++++
> >  2 files changed, 542 insertions(+)
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > new file mode 100644
> > index 000000000000..10dcd3473e9c
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > new file mode 100644
> > index 000000000000..e84e84416dab
> > --- /dev/null
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
> > +		dev_warn_probe(dev, -ENODEV,
> > +			       "invalid whoami %#02x expected %#02x (%s)\n",
> > +			       val, st->hw->whoami, st->hw->name);
> Sashiko correctly called this out as a bit nonsensical.
> dev_warn_probe() is useful for dealing with deferral or that can't happen
> with allowing a return dev_warn_probe() type call.
> 
> In this particular case it brings us nothing over dev_warn() so better
> to just use that.

Yeah, I think I called that twice in various places but didn't return
from it, so I can change them to just "dev_warn" which makes more sense.

> 
> > +
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > +	if (ret)
> > +		return ret;
> 
> 

Thank you,
Chris
