Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010019.outbound.protection.outlook.com [52.103.13.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B093955F6;
	Wed, 15 Jul 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127169; cv=fail; b=Dg5jwJ5tEnb73ZTlOtK9wQC4+BhuqYEOIG0g+HsNMl42qeRryZ4BjBF7vaVg3GxLfD3AI78crSrnstG6HqiJRC4Nx+O9INrQBpuxw0UnM6paFoxR3XfNiyX8Kk0bMVWfrsbixacglqqOH0k/wsqTal2cHDrClfv6UaXmoiu1DuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127169; c=relaxed/simple;
	bh=/pseclmHdWF/ZHiiV7S/EySjw+JVza8RbJo6tCuJQxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LtAgSkT33t3pKZ+TOKcA4M1sbFBcbDuaHYyQuAqLORs40/3CYRG38do1wDdRLmh4OYCWLy2ejOsE9Y0KrtEqpBcIvANkAZDALs6O1ppRUVU3/aZhFmPcWDeFGX63rzPDPDkVjlilgikik1moA3Oy7kfKezqFHUVUamZWBTAgLgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nhj14B3L; arc=fail smtp.client-ip=52.103.13.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nhj14B3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8XuDIjAyrDz1W7Bo36v20G6TGEdN+uB1zRkX6+/FA5gteunGxDbdakZ/yQAY30ALQacXa0FKJtk4xj1A9Sc1MZqeNSRwS6rUt8ikpzZCQuUyIdIEejQT5rD6K6TkVq0vtieyB8zPTOY6uCCcduEMaWrnMh7xN3o/1wdeKdhB9x76Y6Qu1ofQqaLuT0AO1M8xwMT+k1kx6gODzO29dz+uHmbpac0aZae/Q4Iu7KxhS0erjwBTxrlTd5YgFedi2AsyKENGcav+hYuoWqYBtcu3XPtr1ofPDnJnkqXZWpWfX84OatAjw5+CQPWxovdbPcB2g5SDOHQ/PlEZqnORXWRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQMvDrim1a5FrPSb9rqH18fhwi0o0YEmz3M8i3tZQrw=;
 b=j7mwMn6Z6rM82OExzqGQvBdvzkv2sZZiJJnSe12kSY7RHAL6R5QK0KSsMz54Bfa1wRrwbl3SrAwMSWT7RsH2Dp4NsNOSZVQZKyQgAdhrEDpV0/GBZfRQFDAgRC51YNtliq0wVoN8Ef9tTEhHLS81G6L6XlbEZOW1X+/Y+/k071jVKxNsabOUN1GrVZMqIRKSoZR5xtDDvMRnZXorrZsrGez8C6SHavlc9aX5WTVSo9Tc4oLu/IuyjxYjLHwcin1SA/I6RHzat0xOy3CHnHEf+Kv+KlXGvagujng+scluXDsES/dF8KDRfrkNZXQ1VvGjwHQ/V24HX0XVjscCW1QTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQMvDrim1a5FrPSb9rqH18fhwi0o0YEmz3M8i3tZQrw=;
 b=nhj14B3Ln+EYM8KI/kIcuiCNuAGL+iM8wshn+S9Oj/TbSUlM3t6cB7xSXA6PuD8sZexVYNn5gSTS+QwwGBcEKOE5gGdtM7tiRip/1BFZU7WlmNgMHiCX3rEdygepnGwqzVQ+Yo/F+rctRGrqHIzImu+QHWGHkH3FA5kCeu3+UeDmjkl6QUJKhvA58BianU4Krn6Wm1se24fXMimU4i5I4nmoRjCsiEbpUVdduE0E9ohYIaLZ70btu+g7D1DQs8gXoYlSphtTvcL67fZJsXFgXZ1GW33OIVQe2JTDtkKCJTQ5SgVrSLFSqIKNGupLijOZYXe4xG9B8mj29J42fvh82A==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by PH3PPF761D00ECA.namprd19.prod.outlook.com
 (2603:10b6:518:1::c30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:52:44 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:52:44 +0000
Date: Wed, 15 Jul 2026 09:52:40 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
Message-ID:
 <PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-3-macroalpha82@gmail.com>
 <20260715-mottled-uncovered-mastodon-6c08be@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mottled-uncovered-mastodon-6c08be@quoll>
X-ClientProxiedBy: DM6PR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::24) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aleeuBQKvzTcJp-K@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|PH3PPF761D00ECA:EE_
X-MS-Office365-Filtering-Correlation-Id: 49239dbc-87ea-4b2e-ab25-08dee280ba2e
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOxKnU82Hv3+KPBYRboPU8swQ1NXS53cr0PXsZ95mMQE69WxfPqf13MkUfhIwxhpbThQBKDli5vG1apZAkUMxOL6Yzk0kmkN8webDKcxSEwMVlK+r49fbg4F7vB9af2r4gm/ZxFXDQizGaRXIW0EA6yDTEun8KFicRTBgKCaHxfb+IQyyvg3601dQfn6xwbotzlK/f8TXaY+K5BfTdMXM7VF4gaBQHJFhZJUiUhjUwgi31atty0FJ6ElWPMl9+78+QuxMldtfnOeYthwWKzrHC5U+t0c8pCQYovlmkqJ21qNZS14mAeh2yRHhdpBfjJ3K+AyNeKKzFpvB+xusJPuDH+kPqSopmDembqbkqhAClhTxVPfHU8Gf4EED5Afpzgt3kv5reOy+WAvGHOZNxiZbXSHAThlxXUisX5p4/IoiNb3VGVu5umgpEn1GrrhDx2zHVyINEuJPDMFZZWb/NCJjIckBXL0Bm4dgnnpt9Uyrz8QI+DIgauPd0Zk3DHDZN6cZhsIwR8ZZDWD30dsqUBERFOjZWufHQwdmZvDwFdzPSaKnkiU04eX5wtm5KHG9XogTuDlRGlXRq9QRpTPFZoxgVbM5Y8FIEMwhq/4GrVwTLzmf2DcQRPrKIk4GL5++P/DPeIedzCbIGEKNdCkkDD+Qn1eT9xiguz5vOZl98BB2S3ZyRVjxztYmee1rmCndGFuNsMCKYqoQ7YGtxyAMM7aD6sUadSvtcFBJiivXajnLuA9Y=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|15080799012|51005399006|5072599009|4140399003|24021099003|25010399006|6090799003|23021999003|12121999013|8060799015|37011999003|25031999004|19110799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cqejg9hpAPOA0GauOSQz0FzhlQIoLQYrn3U/iKxcyDcwieoiv5NLXRiiY8CF?=
 =?us-ascii?Q?EStZzJLVCgM7ELmanyN4UeY1Bw48qyZqN/4wJhexsJmGWLaeUydOG70VvfGh?=
 =?us-ascii?Q?DzB2/LsM0JRph6JVleT+00GSmzVNGHYla4BbjfjTpHo+KsBgFay4XlYcf6Mo?=
 =?us-ascii?Q?9vQhSlNId/xWLvDvQaoZfVGKhSVRDgSDnLEAhmZkCkTcQpUtpLH/J6AV1ffB?=
 =?us-ascii?Q?iBMV+5Rta2UpXhI1R5o+7sz/t/oWDlDR2p5RP5bl82FuAGjj4mQ46fUVELRC?=
 =?us-ascii?Q?uCcsHgWX7fj7rKjSr57DEK0NrOKYuBbEDjeDJ+JXkrq8lG4frJI9N27YyX5X?=
 =?us-ascii?Q?sIuff3CIoVCO5GIEx3KeNE69YlRpTt0hWQM7C4SPBNMn7yPVKWabAY1Hetf4?=
 =?us-ascii?Q?7eeNjtBVXcS34wGjXdlk5kr8hV/4X9NW8NKLnhfcCasFQFRjgWioERAYU+DE?=
 =?us-ascii?Q?4SqHn9xstACvN1Jz1QWyqIlwxIZe3UyOW8ZqrcWu63NLK24Uw63oSOKZCJNN?=
 =?us-ascii?Q?vTLRBy2s0veKYbfSn2+VjL9/kNNFHFjo43S8Tqye8HFo8VhBiugZ3Pqwzcwj?=
 =?us-ascii?Q?vYv9B1S+VxezfzoYf8axyV+9o37lZVNDYnOTYBJLFa8emHBOZnPMJNJUYi1L?=
 =?us-ascii?Q?g54r96AfSGddWCvEVwBWr4L4GIQU3EJe/ysApfrC/8tLjJvsPUdb6hIenpRJ?=
 =?us-ascii?Q?FR2MwY62PqyPRtcWaGQkwAuL4jdDUVJaLfo1IwoKvA2Wsuso8UhoADHfjdHy?=
 =?us-ascii?Q?/BRCbkBVUq68Q8csrsBPCXc8TRlDZUwUibT8kax/MYk0BkXKpTczcaS9Y3gT?=
 =?us-ascii?Q?ahYM2JNKDEIOOIV+Drz0rkrsap58X5IniwTDtJLFb8HMrn7DoWqn91on/2J/?=
 =?us-ascii?Q?wuaezvJH6Hf4uGBYl1pq+FHD8k7O2FuBi/4G0sK/Src8kM4DbwcGpzRn8EGc?=
 =?us-ascii?Q?f7xH0WoBpYdi8UNwaDPAanRHkPHqlrNzRPeSuEuP0oMq1M2KmfdZ2DtyjdbL?=
 =?us-ascii?Q?zCeigOpMo59wo9BugZj6Vrxqq8EQq/6Dmjz2jID+EIb2gEPfemzdYrrSsVZc?=
 =?us-ascii?Q?+lppijQy0Hng5rlEU3XFlDc1AKtw8Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGFxt2fMOh2/I2wprLv+glygrT28SewwG4k9hSI3g+sEEGKkX9DL1a4MDkag?=
 =?us-ascii?Q?PTfhEMs1I64YWWsaRuQ3jALQPtPIfFEfDYGBncE6F0Vj0bCrIUioG2hPQOH+?=
 =?us-ascii?Q?8IjO/+9PJz4fp5U58Ws8vrXEn24BEAcxcFJbBM3G0K4+YQO0NMDmmGTrFkqF?=
 =?us-ascii?Q?i0xMZhb+N1TPpTPw69PQvgNeCQzsik/YkW5DmaLEdma3FqnFlz+nB6awKccs?=
 =?us-ascii?Q?XgYNSiEuB4ys8338VJuiz3SXJlkGBmGwtN5/oPz0zQp6pM2xZDfLei8Z76SI?=
 =?us-ascii?Q?5mYzThik4Z9EdAyC1H7yckHFXreiklioSODIx51iEaSc3+GVg76eYMchcUCq?=
 =?us-ascii?Q?5oo4F29xTZUqpMMtM3fVxb4BH0J+UWNAKX/5huNrE0HtdDldZBFOzcHEtCRj?=
 =?us-ascii?Q?JbzcotYnJCqqfHUlOcZFo38T4TEsT98WMD6J7q9wnfGLzOVZnrttNZwKW4s8?=
 =?us-ascii?Q?WQAWlZ0kKCjWayxmisOVei2utkWKT9U0Ond0cTgPO3rJ4XKxZPZCPXK3Iag5?=
 =?us-ascii?Q?hhFFr3HNZ6uAkoEoo3pRWKj4CZ7hoQ0akmGGsPZ7M16e7JjrMJb7n9Ph6dDa?=
 =?us-ascii?Q?5hkab05ZkAopNxrhivp4LD3MHzaL7h5hQsNKtCBzaC0IUiBc48g9ywjRjGVZ?=
 =?us-ascii?Q?zv6K1m9jjC7Mj29qVTjdnWVcim4j6KiIfcm4dli4+FJFI/YcG/YvKER7VgrO?=
 =?us-ascii?Q?uErax+A0mgwGkrmlSVnP8gWpzGJ1bkRvT5LeS1UBpKfwckC1e7TcGnvWPbLv?=
 =?us-ascii?Q?vupqFxY73gEUryp5zzloYMswcKhP8efsc0jKhui64wnKMYNXVOiGLYq7Xco+?=
 =?us-ascii?Q?3zIWgsonUTNaYB8u3IxxThDWiu3/ZC3eTmjKqfS5dLSkttz561RnJOCjZEfI?=
 =?us-ascii?Q?hFYXerKwgr8lJK+f19kX/d95zxLOuXaJrENcp8ebv2Q38+CnFwIQMn102cc8?=
 =?us-ascii?Q?zsPZRy49v+yitOA2xWgtCVH9nvLs8ciIGwlyo9y8hsND3AyzRQEfD0zADAd8?=
 =?us-ascii?Q?r9DLNdGuIItWiFDWX4wqejqx9cfY5ctzbSo2zSuQwlmdr4I6uo7fekIozng2?=
 =?us-ascii?Q?Ly4c0uY5jlYcmCGPRxnRVos68pN8PEG87pZLpVWkSTcKyHvYl5ABh6VnO+rg?=
 =?us-ascii?Q?c1R+UDEipVzZAWEAk+8p7//nq0uRDYpbe/VCBszPCBvgs+THj7WsqI+UEjVx?=
 =?us-ascii?Q?+unbHEa8evndK/wIMA1RYjePfoduA3T4GboGzYT3z9H9CLJlOzP1YJ67Diok?=
 =?us-ascii?Q?JuVjQxnZ7OfTiQQxEANsYLIOtPmrvcNMl2ZBeidHqxxhpwelIREorUNdHzOM?=
 =?us-ascii?Q?NzLqbqC4jMmazdkkFsKRLNbKmuTUaAwRSZRtu4cJ03q3w3atQzCtem/3PTka?=
 =?us-ascii?Q?UyZSpnfpuu+CppWikxYkV7n+V14GEpfliNIqMaOfrK3febxF/A=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 49239dbc-87ea-4b2e-ab25-08dee280ba2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:52:44.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF761D00ECA

On Wed, Jul 15, 2026 at 07:52:52AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Interrupts are almost never required for IIO devices per upstream
> > maintainers. Remove interrupt as a required parameter for the
> > devicetree binding.
> 
> That's an odd statement. We do require interrupts when the hardware
> requires them. We do not require interrupts, not because we have such
> policy, but because hardware does not require them.
> 
> Plus, we do require interrupts when software implementing ABI requires
> them.
> 
> Above commit msg is simply inaccurate and misleading. Instead, please
> use actual hardware arguments or how ABI is actually used. You must not
> introduce changes to ABI just "because" while for example making that
> ABI conflicting with existing implementation.

I will defer then to Jonathan on the specifics of this, but from what I
can tell:

1) The icm42600 devices don't need an interrupt for operation other
than for buffered mode or wake on movement. One-shot should work
without it.

2) The existing icm42600 driver does require an interrupt however, and
refuses to bind without it. The driver could in theory be modified to
not require an interrupt though and skip using buffered mode and WoM
when no interrupt is present; however I don't plan on making these
changes at this time.

3) The new icm42607 driver I'm trying to upstream does not use an
interrupt, because on my current test device it's not even wired up.
On future devices that I have with this chip I may pursue using an
interrupt, but it will never be required.

So should I go back to requiring the interrupt for all devices except
for the new driver then?

Thank you,
Chris

> 
> Best regards,
> Krzysztof
> 
