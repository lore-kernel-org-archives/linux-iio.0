Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011039.outbound.protection.outlook.com [52.103.13.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059E176FB1;
	Thu, 11 Jun 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188576; cv=fail; b=auRtjRzXvd7PiuJGOpBKMV2u2i9wmUK6M4+Xa9NjGpB4QWxj8vdrCCk+4WsjWOJlRgvP2zJv++RNx00QqPLzfoXg/VUt4JMg5EehTvwO8P0CQ+O2+HQXpBCayBUPNfbg1tNh4gdZs4o8ULLfdBQrZgKxyMDhhG0Mdo9M/BcAQI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188576; c=relaxed/simple;
	bh=1LbAVOgV3DY+4cht0ubIDrAPhR+n/zxMGLKpUEDdOTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9KwVNIuFhVRZ7DSIJoo38doORNFVT7Ob/QBy+3LYPQgVCfb4DwDM6AOX5lwvpZIAdtSYauCk+bkb1i3EOtLMqhguXX36VL6t4WsC1FmCg4PkG4wETStpa+hgkKZgCGbbClz7ME2HHWkPRqT4/HEhNNKN35yoJpjutIcs99Lbic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AWk/i8QK; arc=fail smtp.client-ip=52.103.13.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AWk/i8QK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM2qB2zPPkx9q0aCALa0/fQZovfwVObpPKs4oCM0QrRsnfYEqwNy0kj63CE8gv4sHE/3pPWsg14clF+4awDzQd3LaL9yPQYB8OgrBgPxPwzG0KfxZ+eVuulSzwl0t3SzO+CSq43s6klpYHX7EZhzX/+ckzHc+es1Domrv36pf2FsGwmm/ZDpdwIipS+VnO1L8GaRqyVgZpAKWicFpGJNIA8xVAzrO15JOdCz/98Id/LdcTuSskevonhOVHEuFYtlmVij8ODHx6JDXctu1CzHth2UnBLF+Ke58axKdH3e/+noFKPm2CDbjyoSHk2224V81K6R45lbAkAVfFCGpc21jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65lKObb/83wPWJ9klp38gRm344TqeiXab2i4b4I2+zY=;
 b=ExmE/AjrOxzHFxpi3sQJt8CBy8AnvT0e86b125Q5UXS2eUFmcC/O72fBckRc90pT/XsGCi0C4Xqm04rRtqNkp8oa4agK4iSZQ/RSB282WxJYkDLESyUKFcSB9UmzgF2sxGaDtktfLpMwpxMY11GFEbQVOy38PPaKspCny+ROyQEVI4vusrt3ixPMT1zQAr7Ie9PaPYmdrUEEpHi4PKQtDjz9NBls4c+VlZZ0Kz3mdZYfa7gbgPiAUu/yz+o/ndXjkBp+hy8OAGHqK1Y7tL/0jFlbpfcT7fXW05wcRRagzG9xJealsREY314MkBl82E3LqBUM0EazWKcwh+Noze+kAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65lKObb/83wPWJ9klp38gRm344TqeiXab2i4b4I2+zY=;
 b=AWk/i8QK5zA4GcfV+T7wb2qYO9VCncPeA8L0kQhxTUHklzGzLZh5GUZmA8ZzYaqTOwaMtB8NuKwNjl4btQcCiLjwX4gImZnaXz6qobBYG3kHEkdz3aCxQk/CEcxJpXR9MFy3UxgswCh3kFATw4aNFMcnHn2Au5QdM2CTrg1P7BSDVpEx11cmioH2AZiJYMnCwpi8ltFh0KN29PgNrNH5Nus/tT8PDeFdTBA3IwZdlS+LF2YoKQc60fcmEfHGRLsM2fd80pf8iN4rj8lgan0PFcypRU8MrvX9e51JoQnP+Qonbi6L3aVu59bBAwaWW7AJyTAlRRNkEclbqlUKPchg1A==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS3PR19MB9221.namprd19.prod.outlook.com
 (2603:10b6:8:2e3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 14:36:12 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 14:36:11 +0000
Date: Thu, 11 Jun 2026 09:36:08 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V11 0/9] Add Invensense ICM42607
Message-ID:
 <PH0PR19MB99733845CDEFA1D8441200B60FA51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260611115938.27712b66@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611115938.27712b66@jic23-huawei>
X-ClientProxiedBy: DM6PR06CA0098.namprd06.prod.outlook.com
 (2603:10b6:5:336::31) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <airH2GaLNXjIj57z@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS3PR19MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4470d253-9774-4e4b-a53b-08dec7c6c85e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|6090799003|41001999006|51005399006|15080799012|8060799015|37011999003|5072599009|23021999003|24021099003|25031999004|12121999013|40105399003|1141799003|1602099012|440099028|3412199025|10035399007|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c8yK9NQuy5CYXAM5TBCdGgKx6M0tDbxs/PD43I80oA3GXp+KxBH0gyFTHndW?=
 =?us-ascii?Q?e3Fy6Nu81X3v/ezF9wXc9Cj/hcCpwRhJHCcMmL+BubBqevpuxYLQwh5xjfw1?=
 =?us-ascii?Q?QXjkrdBb/tgyPk+vXo9uWLhHE28XZmXQhriTvw6MR4J8H7nVul0aVo/NTjjA?=
 =?us-ascii?Q?nKoqNHmYT07iMj0SBlGI+/nUtpYmr+jf4dGHnHy02BLIhGyUGNeLF2Mx4AGd?=
 =?us-ascii?Q?0icldkPmWIUigI+XJBbCuXNS5i8KPvub8beCh5l+5xmeYil3zyzyelWiTeRv?=
 =?us-ascii?Q?96BNF7arVAhr0tCgDWpgkW0vUAHIQle1UEr/17GPAZvF/fpTw3umN7lQzdTB?=
 =?us-ascii?Q?cEf6OQS1+BiM2RzjoqHVfeBvBpPlWC0Dvjiesa0D71B0ryPeVosYCBDYt7xy?=
 =?us-ascii?Q?Ibg5JDl0AxKkgnPI2PNKxepYbJhvrpJ+7uIDD61wyydx84JI+lPs6n2Sc7tF?=
 =?us-ascii?Q?5OdUvBjzMJd4d4QNnE3lhKEgPINk7u7s+znIZtqtq+NpnQtVwydENKBbUzWv?=
 =?us-ascii?Q?Sm24rgG6sLI/ZDfOWVBHwCOuQDGRjgrRRBWMkkTJ7I0yobOJYOTE10qQKwM+?=
 =?us-ascii?Q?ekNQX+G3snLZ61Ux976fK+eqOMg8BwCU+rJzCRIUiO6e98BWAr036FnZLou0?=
 =?us-ascii?Q?7P5Rrz19oNliCG7bt5V1eE2wmz2bvtH8Xvt0znEhMM8m/gZzOxpvMv+l/ZXV?=
 =?us-ascii?Q?Xx3JmeDjfZrBCgXMtpkVMMM9BUdxnjgzHCgUPjLplAHN4/rLg/QGZfsrc0tj?=
 =?us-ascii?Q?o1xy73BveQHmvCD9opuhEFkf822/yIqdYB3hd+0w4VT7ldqfFOlTyUb2TQ9x?=
 =?us-ascii?Q?5B3W57BkudOx1l4bWMCPFGIGC6FZg3UK+1p8coXGj3G7ig/Be93zJl0nowbp?=
 =?us-ascii?Q?tUNkmlMO0alK9z53868T+sRQoWRfY683WFia5rvcjCBebqI3vGAByH0ga62U?=
 =?us-ascii?Q?CSovrVctYLaDV2fLGgmMWCtnIS3CbppyvIXrNPqhIi56vanuZnRSj3laLBxi?=
 =?us-ascii?Q?L4oPuH2CuhlMe4ueffGyrXjrjPC5ryctorp/Lz2KLdb43jql0J9duIiwLAjR?=
 =?us-ascii?Q?zRsvHNQtbQ9eGsnYzxIQ2fV+Y914CFefGoVFt9em/w4M+lS2+wTB5Exi9/bo?=
 =?us-ascii?Q?UleXBgxJCOvDWD632opKbCUMk779jiGmiW1OPVLTPWAgW8mAVXpvsnw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jS1TKfx6Szzk97aiCSTugMqsUVHGmRVbORKum8SkqXcphufBD1QNUc4268f0?=
 =?us-ascii?Q?9m6uLvuYGbpx4No5AzwXxvhSz8rrhcHtBS5nzQmRJkHBUhVkQiEdtL7sKM46?=
 =?us-ascii?Q?s95xQSN0eXmAup9N9ob+Do0JjTd6BsDgLoQi9NzHj+bpKcRhQvh+HE/E2TxN?=
 =?us-ascii?Q?FRg42dlJjA2D+39p4ZtNccyE+1Pvl2B4NcPpLqpfXXj/wl9nWUg+C3BKpf2U?=
 =?us-ascii?Q?NDhS6E63F8H9aaauIN+z7IxHN7lFjAvjcB3Vpn0U/udVLWp21fXzp3E9NHFW?=
 =?us-ascii?Q?BPrq7NtQyw52htz9P3cD4PexdVVpRmmFhCoqj0hm7Wjs4NesR2Lhe2pwnv3Y?=
 =?us-ascii?Q?okFwaGTaZ7Prf0b/ShUsQdG4SHWFkYNCTMLzLpqLoPo7hoP3M7Ylok5Axatc?=
 =?us-ascii?Q?nfZ1c/FILD2SSfiNWnFht2e8CZPO0Vdk2qqA+/wRMw3Y4ZKe2Sh1qE+J2Euy?=
 =?us-ascii?Q?MVG0rVrBtQJQUZhLEo4g6s7gkgaNt2BmbWzQrX/MZfTO3HXs4spvIsW8tjv2?=
 =?us-ascii?Q?KXD+DzXoxYfv9cJ6q9iQ+fr9vWn2d2Ok/zFpIDhNz6KoRpR8HKYybaofcE3o?=
 =?us-ascii?Q?xoT0NlHjcHWiKgdKj7VPlc+Uaxs83B1pRP/iRxxZJCwxLWc1q8aU+fTx5rIq?=
 =?us-ascii?Q?G3TxgsKRj20rM1zOkajqmhire5EsEEWSSOBYURWW3Mevr5LdNiuHT8H46UBr?=
 =?us-ascii?Q?eXoGtHGOilwLM0bjMN+Nyk1vrD74+RSXYYWadsz+uhcOmYLpF9VinaDK6uYn?=
 =?us-ascii?Q?6vss83HZNkeZKAP3NLizaH1OClO7XRIPhccLtsu69GYsdHgwKKn8jk8Hm+9W?=
 =?us-ascii?Q?7YuTzlITxTxeAxrKMO8LJecXHZSkHgD2B/hiikGC7HFoJGO82N1EXi+7FTFg?=
 =?us-ascii?Q?X81OP/4s7EM/QoILLgLHN9a9kBSU1Ec8JzR360C+e1ITT0KwqmBogUZt2xPS?=
 =?us-ascii?Q?/fyJAWMl2MD6Ldj3nBo0nHlCyHdmAOyTvgJ2HHay7hjgrHms31j4f+l2skru?=
 =?us-ascii?Q?70KiPTfUP9h0cx/ms9uHn4GHAsDFndkez+xxM9dTtJ9TMXMR9TlhSJbnoyBM?=
 =?us-ascii?Q?39Ub6O1BBHeDEFXvKfsSbpHk3mWz/I4uyWqdwsHnhlXMiXOmL19AbTxn1Mlq?=
 =?us-ascii?Q?GLB5MGwEJfgTBoFrdN5h+UUj7kF9WqAR9/S2klTypPyzCMcA3qMPTi9D3oKK?=
 =?us-ascii?Q?3wqHOYfR5udD/4EUYMzmpg/qtp8ohFeYdEXm8bvchdU0F3+uAAKvmaEStP6v?=
 =?us-ascii?Q?iHLgh9QMKTACFafLJNfccF0j+3bvCueTi5tMj7GBdKy1tpu3kQ6T5nPNMKkY?=
 =?us-ascii?Q?RURiQjE0goYArUELNY94ZAgMaST4nvrVKLx68WIuZCaX3pvfGlriiftST8+L?=
 =?us-ascii?Q?ESajveCv6ifVGCnyHpLc5xPi/II5lN/1wV9gYw4ay5qtEeDxhg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4470d253-9774-4e4b-a53b-08dec7c6c85e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:36:11.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9221

On Thu, Jun 11, 2026 at 11:59:38AM +0100, Jonathan Cameron wrote:
> On Wed, 10 Jun 2026 12:54:44 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the ICM42607 IMU. This sensor shares the same
> > functionality but a different register layout with the existing
> > ICM42600.
> > 
> > This driver should work with the ICM42607 and ICM42607P over both I2C
> > and SPI, however only the ICM42607P over I2C could be tested.
> Hi Chris,
> 
> Just a quick reminder to check if there is useful feedback at:
> https://sashiko.dev/#/patchset/20260610175455.19006-1-macroalpha82%40gmail.com
> 
> I didn't look into most of the but the last one about no avail mask bits
> being set for gyro channels was easy to verify as correct and suggests
> a testing gap.
> 
> Jonathan
> 

Thanks, I've been checking sashiko on every patch and trying to address
what it says to the best of my ability. Honestly I wish there was a way
to simply push to that bot first and *then* push to the mailing list
once I've resolved all of its comments.

Thank you,
Chris
