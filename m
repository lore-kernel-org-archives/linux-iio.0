Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012072.outbound.protection.outlook.com [52.103.11.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F51313E29;
	Mon,  8 Jun 2026 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951967; cv=fail; b=P75ZHrFaf2ZiLxDA2zEfIqOnNwN8KS4cqIfox8wP3I/7kALd6AJ3YjHWQKwpt5DIbGgwvTXL3A0zqBvaa7zihLU0SPEB+lhgwolHEGi3X9+71cL4E49Wm4yqzj2miG8pPZtltgG1ynjdAfSyYnhf24Oje488BJIq8vR+hkhZHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951967; c=relaxed/simple;
	bh=RQnyw1/cbYxMcPXdOgKfLsOY/cqm09wEV+3qT6KTJAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KNmOKOEp7Q+JhJqSv8fb+23Yu5Y1f6DLzdqBQZUDRfudkLbMyYKYqRtT90Nk1uAdOkpiygQNGaqwwG86AbKjE6h/xH7VTO6/nvTA8SESm4f3OqRNRkaj6LInYlh8/4VjORWQWqSfjqbbCI+jlnOA8ZowkdQDUNUhj9jHN5V4fUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=fail (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=InBMtHNw reason="signature verification failed"; arc=fail smtp.client-ip=52.103.11.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="InBMtHNw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpMRtCkwQdRQCDxGeeIh3iYPbc6XxAM7XrmQke9K7lP7FXba7LhJ1N2dqWbERj16FeX3ThtjlEuXZ6jFjUHMAmAzc5fDnl81dChZ9x80e+p0vE7ZhRUKuH/G6bekOOKsh03XNrrLX0CRUDEWI/d8opMm9vkD2X6oaIg73dmhMHVfA/QwUp/QNtP4mjobV3guUApHxMowWWyl2Pz4V6Y1ymJQVriM71RcuStMQdoYOxaveadx0kGHa7ZajXSBIROFHnPBodt+QwT5xLu8tYCw2N5vPmk2N1INHzNN6sDYHx9tQ9J5qhOm8BGBDift7jf2RmJJRvp+fmuTHgMxjuYt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfeQoYpMToXKejH9+Cq7FjtALv7nJpha61eLVk39EKc=;
 b=buokE2Bhf9cDXfXqppmQK/YDAgEHtNCS9Y1mQfhxfICQ81+12T4IcQ/F1fKh2iaHxYd542gsjtRuMpAJGL78B72SwkyOHJjGTYECI2FznmvSKP2OU5z9q2ZIQfb95lVrDoOU5oqr/8Nrn6ddN1M25Cr2eDrR8idvF6bXQwphIN3/A00glv0bpzCNS5TnSEG4nSOxzWQJT9OgyktTA9AM/upkamax1k2+MZlVDEXjcwFkQ+GbcRQQ6HmLzAXRSncob/dPtDg9bGdD7TpovYk9lYhNalWEBnqDzGM1wYNJzZxGYdCRkuiMeKpRz4Umg0ouS7CTJoydgJ2W+UMZUQZ4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfeQoYpMToXKejH9+Cq7FjtALv7nJpha61eLVk39EKc=;
 b=InBMtHNwGSdAK3vjiZRiFk0P4wA0ZI0Ub1RPtFMdoiuDOAukIzdFVniDGiLz/y0QV5jR9hKLeRS1s2AAMtrlWlSJdXc4vfFBzR7V/Ye7DWirq1MD1PHKzPwB1qBsMsm0zzJhcbmUxT5cbatHMyX0+NxXA7tMhN6u04thpta3rpgUIff96AKJTmxXjp+LHnu5VhTRCJwgr1Va8+YLSiejeMNnNnRZuLsRD4LZA8PVXUMcdeZzu28HddkKvEN5G2dPrAEdilkr7y41AdomXWY+VTZIa+RIsYjAWU15txch2Ore4eJjXQuMZfRbAX52lL8wd5ykWFToa2DgGGYwVe4F2w==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SJ0PR19MB5558.namprd19.prod.outlook.com
 (2603:10b6:a03:427::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 20:52:42 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 20:52:42 +0000
Date: Mon, 8 Jun 2026 15:52:38 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V10 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB99733851DADB0671AE5F76B788A51C2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
 <20260604201832.60656-4-macroalpha82@gmail.com>
 <aiL0g8d0Y_JeAC5c@ashevche-desk.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiL0g8d0Y_JeAC5c@ashevche-desk.local>
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aicrljrjYg_R7Llu@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SJ0PR19MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f197c9b-dcbf-443f-b613-08dec59fe21e
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxO3pHOGDU5H2qJMGFC34uzINA3XcTgr6rxcsYpRf8SrtTW6i3wef6Dp5RNOHV5+3EBb6VQULj569GF3mvD2RGKJpvHfSPwllyNvm3EJE2MYoDkbtZuwtY8pbKlY2we8auaMgFFiw01cis/4S9AidCKNGO6hMsV3aQOLTmpIBxDlpTO9qACfsjq1nyOyRl76osd3eji59R6DfVwDo20Wid3vzNCwtRKqTx8mE3h+xSL4E1my0T1oq1HlavhsWy55ySeiKYUGnbE4OEQ3ObqsOksUFrqJSMqF9aVeBdefF1uYBoUS5s37MkYv1jeZdUk7QOWv7rS1vxjONAMS6NRcLvebl5Q33H/B0ls/A+7vysf16ev9TqQcRkx1P7irExCQq12vpVCcXwG2jEqN5QGuD6Uc1ej+QHh8QfIgY5HV+R9mPXYpyTtbIkgWU+xWjndV+5LFOqYe3UzFqPzXL86ipwEyKsZdMXpZ7RbD4uodTatWpqHLa/aTiFa0fogHmAumDpfohlh7MZWmlhTVb4h0fAcO+GtNOrm9TFKxPANUDaJ3KC+14LbOtoLXVonOMgP3wCLReAlGhwSXl4EXGZ2nXi6Mpxq+CjFzyVmtY2XxTgvO5Ecu+EMzTzB1Ni/xcvdaBUEgFHFf3aBRumjMKbHP80X9PbTEbzWkJq/I5MRNWqQpfrCGNaZZFFLcpd/BGvQ7/BW1ZgCmjwDFCwlvpw9kZ+UJoxxFmqGg2M6EWbRUb3As7Y=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|6090799003|25031999004|13031999006|51005399006|37011999003|41001999006|5072599009|15080799012|12121999013|8060799015|19110799012|23021999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?xDaTRhHubrtwG60s+lxNjpQYziFtlpAMoiTlbY1PeHA7Ayc/hilPx9NwVK?=
 =?iso-8859-1?Q?nFHmPfyUrTu/mq6TiP507r7BVDNh7dXSl3hquJSBSIUshOBNcGwP40Cj6x?=
 =?iso-8859-1?Q?T61a+raeimSKuk+mZfSCWDxm7X458b19GC03sNlqIQrd1Avh/3kOJErO1D?=
 =?iso-8859-1?Q?Q0ng6Ih8dSsBZ/iUx6r8NFqSURrvV/MwHLkYL645dIZ/K4Jvg3aBfMxUlQ?=
 =?iso-8859-1?Q?6/x2sHGjaPDtAIvx0hPBNqdSxeivxkEzn+TeXibP6FJrFaaAcsbpiYR21B?=
 =?iso-8859-1?Q?6sZq4ZMbaL38Ay2ZQacxO6yaokbJ5HAPY4AMijMbgvgMV1CBgcNhbDJHp5?=
 =?iso-8859-1?Q?T/xHRqEhD/Kk6yXFkBZUcukUVpxo4mVdJWRghupw9Lh7R7Qn773iQ1ZmYQ?=
 =?iso-8859-1?Q?WeY/vBi+8F34kyB682YngUh6xodQ7j54LvLSujQrCDUWupES4C4hHv6nja?=
 =?iso-8859-1?Q?c/U9dfETPZM6fXoiC+ERFOzzol4qeUiz7Khcq00NyJTueVD5juwyWvpr4s?=
 =?iso-8859-1?Q?VtKqzeKhHliGVjpvmkFtX3c9mD7H1hwyyuN9G5ePi4FQLhN+ciQYAn60hM?=
 =?iso-8859-1?Q?EoGBkF2b8dRv/OOko0jtPBrzFXKK3xOmKDZpwcHGPv30Qm0SA6+B1l62Xx?=
 =?iso-8859-1?Q?+y/XbXCBE9owCu67/mJx+rfPxKkQGkphMiSvi5yItMaRBXifVzAPFEFTz2?=
 =?iso-8859-1?Q?imoPO0mwTdoCUpBCJxYW8NqZvtdjrtWGJz30E1OPrb1HHdq/ANf3IOfxEh?=
 =?iso-8859-1?Q?UsMamJQxoE4riC5/WvltvzQcAqWK/XeIByhgnt1pYAJzWM4Z7wjbMrQXqD?=
 =?iso-8859-1?Q?tIIWht0RtqWSeqi6nuZ8fKqJ9N/biRXxnHC2f73sjdugDgIP3cXuTd7CVv?=
 =?iso-8859-1?Q?bRjiA5DXlCJMdhfgfMR5t95IufeXwOJeX30jH/DFhak2uo/GvDy9/Dc/kU?=
 =?iso-8859-1?Q?ygN4rh5UD9swoFo2t4po62KnxYkZecc/RiTuaBX0/hX2+nWS1o2dTp6YBw?=
 =?iso-8859-1?Q?zb7kFPdTTqdb7P3IRA5Glrxqp+rPJg1NIul5wypajP5WF2Ew5q3ZNWXR9Q?=
 =?iso-8859-1?Q?D/7voRG24fEB+vGAzz5cQxHRiaaV+4Y38OpbwtNErVZzRAdx4D7GJr/L6C?=
 =?iso-8859-1?Q?TsILhVCiy2luE0aL/5CKFaMRrESOU21qJ7PxQFJSP8Oq944PRI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uFjgNq4uo9CglOMy3GkGIwgRmaTFsCBkKU4TmhscoZCEtcYUCjfMxn897u?=
 =?iso-8859-1?Q?zfoNZNjlK9ctTEEbKAk5hhdghPldg/05K5qGfAJ7TzyKW5k3QSZnE29RYr?=
 =?iso-8859-1?Q?YAxNQxQQrkA29Pe8QKRjdLGtVn7hazlJHnZ49m1Vyuroyl9fhuFgdZUqYx?=
 =?iso-8859-1?Q?LEhhqthJs48IEzPsaytWmUTqTzbVMYSekXxIQhZkgR2MgdFXPb6Ebd/zOI?=
 =?iso-8859-1?Q?zHNSigVlV1s23KIoCZQlMywHLMd+u6Q1VZJQF+fj9Lc/5AFaayqgWH0aH5?=
 =?iso-8859-1?Q?TSXw1H7QS4K/yB4Mq6QFU3xME5FBUwh6xmmCFGvn97BBI0mGkw7rqEZPCl?=
 =?iso-8859-1?Q?bkXbvwAWNvlsFcEW3/q/r07shCj8tkOn5YIsquLqUxOeTuWwdm+KTWWweP?=
 =?iso-8859-1?Q?Kl3ZCderaxIyOKlS0GZpycQwRGG/76cdN6wdWbCEmgR+Hib6xAWvaDvlEw?=
 =?iso-8859-1?Q?HPYHq2p4VMC4lbiW7M6tOZ7czw5QdLTRXn14NcQhDCTNB16JM3AEvIUx9m?=
 =?iso-8859-1?Q?KKvmavmeU6jHWeuEZPctUO63XQZLOVWpkaNugwi02IVYgW4GkeQowPMfYv?=
 =?iso-8859-1?Q?MRlLIpKk2VFo8IZ+isG9uxVdxHi2aABXr7dVOvTKyq98bln4NyVQNk46Gq?=
 =?iso-8859-1?Q?g1gAIE2eTe4FYUKnj1HPQRdaDxXXk6qBY5kd91rIVtwregWlvJ174v+HU/?=
 =?iso-8859-1?Q?zEWh4OZTjnNFz4ZARjqAUfzd7l7hFffY0npEzbk2wM0sHy90aQro92PGG0?=
 =?iso-8859-1?Q?yPXacCl4CeH4U0QtwSpWLGhIvXU3at6k+txw+2jZO3ZzH7FJxTtwPlX8tA?=
 =?iso-8859-1?Q?lWRhNh0N3Uos2a5q3l0OmfluqHZocS1t0ExWig/HaAv8tj3atwwRxTr1Q/?=
 =?iso-8859-1?Q?g4OqoKq/fdCL6ZEGgH/LRVJdWaa1ROYzXbe27iJCa89p6yDCOtVuosmT+u?=
 =?iso-8859-1?Q?kHdyJ83U+CJvF3jwzq/jK6J7zNJS24S8+LXzw7xVxYWSTXNFWcJ08UzUds?=
 =?iso-8859-1?Q?/0F3wlf0BmHAOQFydcru5RYOdRx60cQYtzLVJh5F7bxfFnmS9bHCj7yQlU?=
 =?iso-8859-1?Q?TSFIZ3ifZ+hPt1+hS5JE6JMSMWvjt7PLHaU4DCFBZ5JJi766zOSicsI3gF?=
 =?iso-8859-1?Q?bG+x6ZpRABEvWdiQvkdEb22t7k3O0VX+al/PbmXJFK8YIdCMrX1V2erNXF?=
 =?iso-8859-1?Q?oICQrH4OvF4k47pwx0wVNSQU4xdqO1l54jRHoaW25wwZbYRewd1vE0rvPK?=
 =?iso-8859-1?Q?2OcvfS5v+hcG1E2GDHCTvzh2shyBZBPzdpEfyLFsHXbcn10/EeWHtuAj9h?=
 =?iso-8859-1?Q?q8wqMLtxzegoeDb3g0sbsEEj9YEdfVS0isF1mSV78NCHcxMBUhiQl+vHn7?=
 =?iso-8859-1?Q?5eQsCitYxWFTwb0o+ybiyO5TH+BulUWP0lL6Ej8tHN0AGYVF2YECjoCIc2?=
 =?iso-8859-1?Q?Cd+tMsvrkJiua3EtQGcalI10cVd2JQK7Dc30vw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f197c9b-dcbf-443f-b613-08dec59fe21e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:52:42.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5558

On Fri, Jun 05, 2026 at 07:08:35PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 03:18:25PM -0500, Chris Morgan wrote:
> 
> > Add the core component of a new inv_icm42607 driver. This includes
> > a few setup functions and the full register definition in the
> > header file.
> 
> ...
> 
> > +#ifndef INV_ICM42607_H_
> > +#define INV_ICM42607_H_
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> 
> I haven't found users for these two.
> 
> + bits.h // BIT() / GENMASK()

I'll correct this.

> 
> > +#include <linux/iio/iio.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> 
> 
> > +#include <linux/regulator/consumer.h>
> 
> No users for this one.
> 
> + types.h // for bool
> 
> ...
> 

And this.

> > +enum inv_icm42607_sensor_mode {
> > +	INV_ICM42607_SENSOR_MODE_OFF,
> > +	INV_ICM42607_SENSOR_MODE_STANDBY,
> > +	INV_ICM42607_SENSOR_MODE_LOW_POWER,
> > +	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
> 
> Are those enums map 1:1 to HW bits or bitfields? If so, assign explicitly each
> of them.

I'll explicitly set every value in the enums to be clear.

> 
> > +	INV_ICM42607_SENSOR_MODE_NB
> 
> Is this a terminator like NUMBER_OF ?

This is a terminator, yes. I will not set these explicitly and keep
commas off of them to keep them easily identifable as terminators.

> 
> > +};
> 
> ...
> 
> > +/* ODR values */
> > +enum inv_icm42607_odr {
> > +	INV_ICM42607_ODR_1600HZ = 5,
> 
> See above. This one is problematic. No one should rely on Linux/C enums when
> it's about HW bits. All HW related stuff has to be explicit.
> 

I will explicitly set the values here.

> > +	INV_ICM42607_ODR_800HZ,
> > +	INV_ICM42607_ODR_400HZ,
> > +	INV_ICM42607_ODR_200HZ,
> > +	INV_ICM42607_ODR_100HZ,
> > +	INV_ICM42607_ODR_50HZ,
> > +	INV_ICM42607_ODR_25HZ,
> > +	INV_ICM42607_ODR_12_5HZ,
> > +	INV_ICM42607_ODR_6_25HZ_LP,
> > +	INV_ICM42607_ODR_3_125HZ_LP,
> > +	INV_ICM42607_ODR_1_5625HZ_LP,
> > +	INV_ICM42607_ODR_NB
> > +};
> 
> ...
> 
> > +struct inv_icm42607_sensor_conf {
> > +	int mode;
> > +	int fs;
> > +	int odr;
> > +	int filter;
> 
> All of them are supposed to be signed? Why?
> 
> > +};
> 

A later commit will use -1 for invalid values.

> ...
> 
> > +struct inv_icm42607_hw {
> > +	uint8_t whoami;
> 
> What's wrong with u8?

Nothing, I'll make the change.

> 
> > +	const char *name;
> > +	const struct inv_icm42607_conf *conf;
> > +};
> 
> ...
> 
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> 
> IWYU, please.
> 
> ...
> 

This may sound like a dumb question, but what's the best way to invoke
iwyu for a kernel? None of the readmes or man pages seem to be getting
me anywhere...

> > +/**
> > + *  inv_icm42607_setup() - check and setup chip
> > + *  @st:	driver internal state
> > + *  @bus_setup:	callback for setting up bus specific registers
> > + *
> > + *  Returns 0 on success, a negative error code otherwise.
> 
> If you do kernel-doc, validate it. Return section is missing here.
> 

I'll just nuke it, most of the stuff is fairly self explanatory anyway.

> > + */
> 
> ...
> 
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
> > +		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
> > +			 val, st->hw->whoami, st->hw->name);
> 
> dev_warn_probe() ?
> 
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > +	if (ret)
> > +		return ret;
> 
> > +	fsleep(INV_ICM42607_RESET_TIME_MS * 1000);
> 
> USEC_PER_MSEC (needs time.h)

> 
> > +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> > +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> > +				       INV_ICM42607_RESET_TIME_MS * 100,
> > +				       INV_ICM42607_RESET_TIME_MS * 10000);
> 
> These are weird, as in the first case it's actually 1/10th of _RESET_TIME_MS.
> Perhaps you need to reconsider what you use as that constant. Personally I
> prefer to see just plain values with the multipliers (to convert to µs).
> 

I honestly don't know what a good wait period between polling should
be, so I guessed at 1/10th the timeout period. I will however change
the timeout to us.

> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "reset error, reset done bit not set\n");
> > +
> > +	/* Sync the regcache again after a reset. */
> > +	regcache_mark_dirty(st->map);
> > +	ret = regcache_sync(st->map);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = bus_setup(st);
> 
> Hmm... This is bad name with potential of name collision in the future (in case
> driver bus code wants to have the same name for the function).

Thanks, I'll rename the function.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> > +			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> > +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> > +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return inv_icm42607_set_conf(st, st->hw->conf);
> > +}
> 
> ...
> 
> > +int inv_icm42607_core_probe(struct regmap *regmap,
> > +			    const struct inv_icm42607_hw *hw,
> > +			    inv_icm42607_bus_setup bus_setup)
> > +{
> > +	struct device *dev = regmap_get_device(regmap);
> > +	struct inv_icm42607_state *st;
> > +	int ret;
> > +
> > +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> > +	if (!st)
> > +		return -ENOMEM;
> > +
> > +	ret = devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->hw = hw;
> > +	st->map = regmap;
> > +
> > +	ret = iio_read_mount_matrix(dev, &st->orientation);
> > +	if (ret)
> 
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to retrieve mounting matrix %d\n", ret);
> 
> Remove duplicate ret printing.
> 

Understood.

> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get vdd regulator\n");
> > +
> > +	st->vddio_supply = devm_regulator_get(dev, "vddio");
> > +	if (IS_ERR(st->vddio_supply))
> > +		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
> > +				     "Failed to get vddio regulator\n");
> > +
> > +	ret = inv_icm42607_enable_vddio_reg(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, inv_icm42607_disable_vddio_reg, st);
> > +	if (ret)
> > +		return ret;
> 
> > +	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
> > +	ret = inv_icm42607_setup(st, bus_setup);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> Just
> 
> 	return inv_icm42607_setup(st, bus_setup);
> 
> ? Or is it going to be extended in the next changes?
> 
> > +}

It will get extended, so I'll keep this for now if that's okay.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you for your feedback. And please let me know about the iwyu
tool, that seems like it would be useful.

- Chris
