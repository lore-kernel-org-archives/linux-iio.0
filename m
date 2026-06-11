Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010004.outbound.protection.outlook.com [52.103.2.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6D413256;
	Thu, 11 Jun 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188141; cv=fail; b=DTEbuuvXjrldQQ0x2jNMz3EWRvPILN8u3eVH72lzc8rYV8OwBmA/A3NtS+nN8uxIxxXDZ/A58KpGZFNQorrNJ21qnpb1Bf3cpBF1hFSNHgaMMBeNC4zBnP8YRITUMZRIxagzgwhf4ubQPMV4JNbjJTuHxE9rWas9MN8Bsmcssgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188141; c=relaxed/simple;
	bh=vimFc9OOO0boA0h9ftETNZh6iyM625oAXFafKWaBrd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxtGQnXVovhzTojPpnhFF7yarwGv5Og5fgdOzVpDZLmxjwu9Eg7kCQSu+04NQFdOdyPNIqFaswL5hikN4Yk+OA8N3nWcOrmAUFX/bW1mZl9rT3XOEZVxdHFFN3RNA3dvYSVALZ/pQDdg197nogVH6kJW5mk1Hx14O5pIP8u4YGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JBph+pQ+; arc=fail smtp.client-ip=52.103.2.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JBph+pQ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Syw2z1Xlrn4rqsGvgdvAmD5IG7Gj6yquY0+e4SLWX43UE/0qSBA9uXUjJTFnkKjp0lDCGqqXHNay66RHxunN2H/lkzHqj52xcGdNKhdWSA+JlChRiT8zVY+3mRy5Tprvl8UIlaFIAOSukt9cF8zFPmCcvmHuKqjcQ1murE0hwEo2MzW3+AE3S7LBfBK5DS5uV4SsZkn7jpuXit7mZnlzWNzJmDtoHObHrr87tdTgHjRoC9o+RHvftC9e8329NAAR/6XbkCFVfwHQCt2fjY6pClmtetVk9ovjD4OyeDwrWKI0pYW0Lc7BqsYq77U1MeOYKpVTkW0qj53H2AwpIS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rgkIMaFrdmM76UktvlGxonNItzFjAApwmQtROdQyME=;
 b=nBSZDj7yTUBI9c17PwIuD0uFA1aD6we1xFBK8XSFLJyLLD7upkdNlpXVvdKV3G3eY1IRoec150qYAmSsmWVr+1AzHyg3kr0920WoiDDoWLXsZ5x75+PBtX165PnXrD8EPlWBHYfb0K8eqnmaj9n+1BSH+klB2EGeWLhQ0wTht89HNCCU1D6Sm3zf7T46IufP+GEywEanf/d+Sjl7JHu4YATfMdlYFXrmvix571qvXMHGF1pHgVeQ+vW6q7WCUnoFoIo9HvMA4V4A+OPKBGxc8Lkqng/1qzyX8b+/JS1HsP/YCSOUqJwnsdlREM4UHrZ2ZkRJz9tXk14MuZzVESxM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rgkIMaFrdmM76UktvlGxonNItzFjAApwmQtROdQyME=;
 b=JBph+pQ+9+7CR4VlALi27bbmXhG0GHeJQH/iArrVMSHv542yKXkKHnuParXo5mGt6p+kUUsJ5rn2bMr4q+LxymjaSoHqhJyP7Cl02Og7Xq1sWpUToeIQsoZejxQAlX8tBoh/CQXm07f+7UeD6JrsJlxOHYVNzwwLH7tqa+cBsrT+qLCOHHgBY1/Yp7OL5Lr/RrqqBKrfuj6Q/nINjGWxO9/UDgSxbOsuT8heG9SJz5jfpxAqvf8gCKK0f2+wY1VppiIcm5netC978xXCCmXaGRKpc4Hi0ZZd4D1RY09QrdGkGizX0/fqLUIGV1itmrdKQbY7vTwFyJiWTIL41i5v3w==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by LV9PR19MB9016.namprd19.prod.outlook.com
 (2603:10b6:408:2bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:28:58 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 14:28:58 +0000
Date: Thu, 11 Jun 2026 09:28:55 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V11 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID:
 <PH0PR19MB9973380727A98C4B42F9A79D77A51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-4-macroalpha82@gmail.com>
 <aiplVZRI-0TCDnjL@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiplVZRI-0TCDnjL@ashevche-desk.local>
X-ClientProxiedBy: SA0PR11CA0147.namprd11.prod.outlook.com
 (2603:10b6:806:131::32) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <airGJ8WLyKbs3SmT@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|LV9PR19MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c25d53-0e20-49e8-effa-08dec7c5c617
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|6090799003|41001999006|37011999003|5072599009|15080799012|23021999003|8060799015|25031999004|24021099003|19110799012|51005399006|13031999006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jGep1V9VksD36oj/FgX5pZjRoIvoF/9YeRzDMdTeR8hM0V7KCQWcSwaUV0cR?=
 =?us-ascii?Q?2ePQJx+hCqb1s16HBSgQrGRTPVXTRUSCoTarij+HyJfvN39IQvqLlMMbYA2M?=
 =?us-ascii?Q?7EZZwCxsDeFWx71vICoDb2tUd6DhC3im0RG9wVjcUg0k+H8hjQkxEfNDa3W0?=
 =?us-ascii?Q?/C3IqghXshW1SqIIFgd5w247F1hsB7vtJM4TbF8pGEbksc7bpJJQN3zAEw+N?=
 =?us-ascii?Q?JuDW67QnAoJ0SjV5o6nqbWMdILiVSq5kvMah6Q9BN8dz8uvt8lYY28kLIkp/?=
 =?us-ascii?Q?TlD82HuuTHGI1JjAtbQ1fzTAXu1XzRFVDT0GzSuqnf1ZqyUhvJfgHlMBDtlE?=
 =?us-ascii?Q?XS5T+WrjJQuOgWPzGkbc60luSTit0zIsZ1krx00bF23kSVkS9RX7ZPkEugO4?=
 =?us-ascii?Q?TJwBcnbpmVFuI20F4cI7wfOvRfCgTxeOrFf0kKz6UUalTtlGjuzExpBx4qQF?=
 =?us-ascii?Q?GzlTe7yNRa6TWpm71eCA90b5EMSoiBLFcrRRFSAlS4aSQ0nJdLKsqtMXnhHu?=
 =?us-ascii?Q?EYj8aXN11VV4z55r6fYBb74V8q1GYsetIR/7Ubfs0FIrelnb7m9co+NRK9Md?=
 =?us-ascii?Q?LUDSOn4Sc8FV0Xo5PX1hMgL34UT09WUshS/75pSKDK1KXPbrmlqlmIhNU0qZ?=
 =?us-ascii?Q?6ay//QoW9w9DFZWJIqGfMaIaYCWNPFK0ctlagaXI9puLFUr1f2bBXk4j321V?=
 =?us-ascii?Q?WOls4BuNoSCPjE9k+Dwkzxg16XUtvch4aVHQbo9sICya/VnUJfgj8SbGlRZy?=
 =?us-ascii?Q?WPcC3gJVOjRWCAuz1R7Sb13qrGy2wCnBG+ygmPPv1o2FItXmlTRiFN1u4Zns?=
 =?us-ascii?Q?qAnOeU6TQj9hS4dZbm4gNvvKMxSaWINH+j4HP+joWjmk84xCUSWRWz6My3+N?=
 =?us-ascii?Q?QDUhDXR6H79Mm7Yf6xFj09Asz+jWA35YCArUjWsLnR++64SLIr/iitSGALIQ?=
 =?us-ascii?Q?ZH86cVipAegGye1ZJogamMc6FcwgChOaVX1qjP45HOduqisjpirP+EwSUvPs?=
 =?us-ascii?Q?yYzngzH2uZMTDsAV++TBx6XS0ORm3t/2P6iIAjVUwAuvm7e1KqgfwmXyjAGJ?=
 =?us-ascii?Q?aSe12bAW3KmvJjqvzIxkJuPkIKGXrFeg6my/UIu8QEHt/lEcvqGcWn929ZdD?=
 =?us-ascii?Q?87sop4IlFiDk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nptqAS7EkWLiDueIte/HMiISBHnjObJHBltlP9ZHcXAHLoKwjkF9MDxUcnW?=
 =?us-ascii?Q?++5XNyd3Do1B7nMQGvIsfdi1o07vp/ptqjctmEE8UhONQj2j2cFfi0QtsmPL?=
 =?us-ascii?Q?z+Y/K9kFqf+xudQE1pMBcNILA700Vv7Ab7jvw6OenvfvO4N5xw6swsoQ2YHH?=
 =?us-ascii?Q?dPrwgccwvGaDklQreraBofgTW//qaSle40SYyAvvwtBMjiZUKNbPTgdqgxRT?=
 =?us-ascii?Q?lSVjWCEtxkjEdaB7ZGJ+ehWrYwDWZUyXRfCd9NwqdA1vS9hITEGqjIlof2La?=
 =?us-ascii?Q?D2cBNIBdzqUBmqlfnv6eBd4aSgsK5Ai06nntf/EwZVZJunbTxLMkZuj7Gn6l?=
 =?us-ascii?Q?IHG+u0PgjDhIhE9jazI1Rk8PlA7NAoTE4pH1pYCkrvuDqQSWt9mZpHm9E98j?=
 =?us-ascii?Q?SDTaQ7zCtIJnTj8tmVmFKjxjfyuihSdLn+t7Dif/JlMOnJVvNZia+dtV5Z41?=
 =?us-ascii?Q?S0ht4e2wBxZZ0OtPCGR0WjRrB+NQ0gkj1jfmWOqK4SoytcCa/2D2WsENcP4G?=
 =?us-ascii?Q?0Il2dYvIFFqgkKrD2MXB1Kk05lJsL3j15q3vtJi7KYrEbcMHBvSpclLnDOG/?=
 =?us-ascii?Q?x2sMoI2eDFArS5M8xXgaCz0xtfL/SsYmZYPPOZ1Xc39yc9XGd5LXodJ0M6Ly?=
 =?us-ascii?Q?tV2ahgJXqkOV62K/rhRg9Sn7iHCbBr7b/nr5r3tWNepDC/BOCFA1HVK1d5FS?=
 =?us-ascii?Q?bpSZA00fTf1fpZhiu1iL+vmIkzlhXjl7AmoQsLTndtyjUYXhhS4oNuDPLlAk?=
 =?us-ascii?Q?MbkMrz6foduoZXblK2vlrd4GFNnxMPHvSTUb4yPIh6rEGjwf/kWhF6YPeY0J?=
 =?us-ascii?Q?S09GGAgI6Tza9j2Bfue3xAoba/k+5/3IOQaqgWO3gP1lJjqaE7kRvV6F6BI6?=
 =?us-ascii?Q?ePXILom6EwMtMcMu93nbkWIkprx7i2v4R5u5alRKVFZan4I0TxuDOfs++ID5?=
 =?us-ascii?Q?yYCz0DMqrnPAC8TWUiduxtaU0gyJBcVphsMdONRf2siPeD2Mjd3+24CWBX5c?=
 =?us-ascii?Q?CbNczaZrk0tIMwRElLfOGafkn5Ss0UfFN+/KStMrHnykt2cWh2cw9SlxLAdv?=
 =?us-ascii?Q?Q/i/iPvQ2ApiMHCYslOVftZ0tiEHx1mnte0JBHDFUdcTVz+tc0CbwOsboVni?=
 =?us-ascii?Q?chcdQZLSpAVoIN+YOOQAUqOR/EWX6Jmf86WyAeFJvDkdQT317XB+tcm+Czeh?=
 =?us-ascii?Q?MWOtJHdbKJizcNy3kJNKaU3RwgX7CBU9SoXFSEvNj+NxIoRD+2rIzWqAkeiQ?=
 =?us-ascii?Q?pHU2+AralCMVNp1EN/C851DYl7FsPULNk4OjWmKyPArSuWvDuT8aVEubSrCi?=
 =?us-ascii?Q?+kokYy3wX2hKmrYMLpu4TRXrP6xnSqpsqZ1T0rWHIUGWIYCPIBTqmoyyWOYY?=
 =?us-ascii?Q?97LlagnjHUp1YMRcr/Q6fugQIPp5P3uTVS3S1qv2vw17wcEudA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c25d53-0e20-49e8-effa-08dec7c5c617
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:28:58.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9016

On Thu, Jun 11, 2026 at 10:35:49AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 10, 2026 at 12:54:47PM -0500, Chris Morgan wrote:
> 
> > Add the core component of a new inv_icm42607 driver. This includes
> > a few setup functions and the full register definition in the
> > header file.
> 
> ...
> 
> >  2 files changed, 531 insertions(+)
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> I'm not sure this is correct split by files. These files are not:
> - being build
> - being mentioned in MAINTAINERS

I can merge patches v3 and v4. Early on they were pretty big but now
that they've been paired down some I think it may be manageable.

Early on I was told to try and keep each patch around ~750 lines.
I can add these to together and get it to about ~850 lines, but
it will be compileable at that commit rather than waiting on a
second one.

> 
> ...
> 
> > +#ifndef INV_ICM42607_H_
> > +#define INV_ICM42607_H_
> > +
> > +#include <linux/bits.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/mutex.h>
> 
> mutex_types.h ?
> 

I'm not sure I understand this, can you elaborate why I'd need it?

> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> 
> Do you need forward declaration for regulator data type?
> 

I think earlier I had regulator-consumer and stripped it out, but I
might have cut a bit too deep so I can add that back.

> ...
> 
> > +#define INV_ICM42607_POWER_UP_TIME_US			100000
> 
> 100 * USEC_PER_MSEC (will require time.h)?
> 

Understood.

> ...
> 
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> + bitfields.h
> 

Understood.

> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> 
> + device/devres.h
> + err.h
> 

Understood.

> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/time.h>
> 
> Also check if you need types.h.
> 

I'll add it, I'm honestly not sure. I never got iwyu working it seems.

> ...
> 
> > +	fsleep(INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC);
> > +
> > +	/*
> > +	 * No polling interval specified in datasheet, so use reset time as
> > +	 * polling interval and 10x reset time as timeout period.
> > +	 */
> > +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> > +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC),
> > +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC * 10));
> 
> Besides too many parentheses, this can be switched to regular patter of "num * what".
> Also, TBH, the plain values would be better here

I'll switch to plain numbers and let the comment above do the explaining.

> 
> 	fsleep(1 * USEC_PER_MSEC);
> 
> 	/*
> 	 * No polling interval specified in datasheet, so use reset time as
> 	 * polling interval and 10x reset time as timeout period.
> 	 */
> 	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> 				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> 				       1 * USEC_PER_MSEC, 10 * USEC_PER_MSEC);
> 
> And in the similar way in other fsleep() / _read_poll_timeout() cases.
> 

Plain numbers, gotcha.

> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "reset error, reset done bit not set\n");
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you,
Chris
