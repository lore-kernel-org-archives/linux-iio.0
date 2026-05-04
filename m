Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011035.outbound.protection.outlook.com [52.103.13.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1335959;
	Mon,  4 May 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915075; cv=fail; b=gvD7PtfcY75TWg/dKYb9lpsZlbc/cz0qZ+9joSrUZ/wrnhXtDvZ3LTYgaGkSIalh55i03dGHDsG7N6JOpwHOADNaJNU+zNw1Kg9xZihEp5OhXU1neWhs+74vbOwLkuHdwRc7Dc0c+a8xcCzHcDBh5E7p8SBM0uSUzSaH0LEqowA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915075; c=relaxed/simple;
	bh=dTKVbfnhDHmQiPg6RCzR4Y097RuzxF8sEnZwIRr80Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aXpBojM//uDhD5hNbhwUlt1o1h+w8v7X4FS5c6DXs3FdILm/rkyxNiPqaZp7WqBBCjLj8EY3r0Xf5qbPoXhgIjGAe7va9TOXfXNIqH2RlacUx1ZZWybLydtiHsh9JsjQeyzMc6KjHx8sVkm61X/qHlnh8E8kEv0iM7S+xbadt68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o0n8Evbq; arc=fail smtp.client-ip=52.103.13.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o0n8Evbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMJFWpKuLrJWbIQCpF0jSfBR22+sae4bzrYHTsVnPxZuU+Imt3VA9dR+Mw1/Vk1e3+/x76BluVnnjPn57Uum9BNhHpy+7Brmo62/h88QXli+Rpks3O3XmZ2NFeoQoAZP5cDSTjnANWGNPtfYDeGlo4wxENK1Gl8NMeqtPMJGu+wQiVO834m4i7UYfkjqajX1XokF+B2aaOkUyB8NSVQTR0YaDrF52yiHxoBKGK/fsom5GFzwwOqWMGUh8XWwiR5F15mAgxKLFZj6sli00meM1rtn50bSADZxhWpgVz0/nTYPofz7Q4jMsForJZ9bPILGaAp+BNRx7hCpnyRj/8fh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwqiesBtRme/M3oPcD+6K4A1tmCeeNMQW7+WK5Sshc8=;
 b=SBMIaFI6DFUPRl/8R9tD+WrgdAEL3faxE+nyqM7lG51wEuCa9/CVrFnJPzvbQ4ZtvdZmSGPmEc5f940+fXH1ABFnPFnIpmyueM+UvMbxAeeK/2GDDfeq5dEsuFLAnVOP4DDTzsy22RHxV/NY1TY01btJsF8CMUQ/QvFQ83p3RIdf6hBSLGNsDDeGdf0U4AEVHCSU0ID4uGX+b3YDIftVX8Sao3CRem+bSbM3If97aLenrbnaO/Fk98CAqLPJh9rAeGJqdADZuEaNmb7Fdt9wiFvlPdW5wiXBhBp8c4K7UYv1UiGPCPohiVsWTHhpFemME17zavpzN3TFq6LatmExMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwqiesBtRme/M3oPcD+6K4A1tmCeeNMQW7+WK5Sshc8=;
 b=o0n8EvbqF2sxCR7xWwklJ9L77aGCZWh+qJajGqHZYZNqCdMPsoUdyT5UT2P7/imQUsP1U6vhtvYySPeNhZWhWBpnhCpbHBeU0x8QoDYklouZZG4l/s/VT3uXLeSQ4Kzl6Vcv/7biKMDFl0PTrtHn9NrlZxU1h7qeP+TrNhzj/Uqenl4Pkq5CvcExfq4ljAmJmaNrfrYmfY/tDVGksYfSjLA8qwQyYZZiWnY4jvZBMY4eDT+k4Qy/iyIoVZ1bBhWY9spxmyKIug6FAapct7+tAceVuEW+vwxgujLbnP9vYvw+sFqO+Z4fTkIcmKedoCZMFhf+shr+suE73ietgkhicA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS4PR19MB997348.namprd19.prod.outlook.com
 (2603:10b6:8:34a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 17:17:52 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 17:17:52 +0000
Date: Mon, 4 May 2026 12:17:50 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V4 01/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID:
 <PH0PR19MB9973384E92E70FE9DDCC568D68A5312@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
 <20260501221152.194251-2-macroalpha82@gmail.com>
 <20260503-convivial-aquatic-yak-d2dbeb@quoll>
 <PH0PR19MB997338AB2F626D5898BAB27E53A5302@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260504175128.0bfdefe0@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504175128.0bfdefe0@jic23-huawei>
X-ClientProxiedBy: DS7PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::34) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <afjUvnKC1J95TjGr@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS4PR19MB997348:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fea1582-3930-4d09-51bf-08deaa011315
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|41001999006|8060799015|461199028|51005399006|24021099003|19110799012|37011999003|25031999004|5072599009|6090799003|15080799012|1602099012|40105399003|440099028|4302099013|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TqJZjO6jzGy86231yx2hqjjZkywJnoWR608lGX7BTUzNT1b5fEqEZYRvY1ep?=
 =?us-ascii?Q?2mJAY/PmzFsvADRrYWs8nzSnk0nLTnqyg/ZikAZ1NJaZec06Q52UIL7Qh8PU?=
 =?us-ascii?Q?yq7vCN5BhoLRt4Zl9nK55D9JLizG2soVHbZUbQ6098h8qlZmFUgDPj8+oVNU?=
 =?us-ascii?Q?j/IfMT6KcoP5RStpuLKZOz8y5Xoum5uU1eHr6Khi+XGe6ZLK4/URcufRj3cD?=
 =?us-ascii?Q?8Mxt2F1PVZZ0jhMk2/ksHLU+UuDV2+KE7LB/O3Lfnp/rcF5yiedW7onUqS95?=
 =?us-ascii?Q?70NAeccxXn/6fD2HMBKjTsElIYea5UXPtYACqSMR/kPvh9RpFf6Vu27UH5wS?=
 =?us-ascii?Q?zSaLPFkpQ1mnGwT+zxov9kBGqo4W7loHZztDgjX70OC934KAD6d/nZA9ZrxZ?=
 =?us-ascii?Q?tm7I86C/xSXAsuZqH1x+EbDJT8PuHu2WDHOk4UxokKlXaC3If+3KCAV505cU?=
 =?us-ascii?Q?IdJ3FvQS2DwTh+SVqRFchusqLl8GIYxQHyqTzTAAyqU9bhrLTbZLyqowssSw?=
 =?us-ascii?Q?BPG8ctVALOIB6SwW6cQw+KdtFSoQ3vqM/t/oiwVtv7vkjSBmLSPKkxBhZMYv?=
 =?us-ascii?Q?GEbg18B2MuGRS965SIaMwIlkEWZMEMww1hsr4R7/Oj1cNqiCqFfQ+uO5gop/?=
 =?us-ascii?Q?y3Ywb7vb79+8Zl7lzzrynrMkc38c4V6fyRmg0QAurgs+x09Jb3M7VgY1sBL7?=
 =?us-ascii?Q?lgwBdTrvxDPOwYUrAcYrORELDIwsxOjdO/gM87McCmWsW+9OxOaAZnYQuZuH?=
 =?us-ascii?Q?f4dc3iNrtjLFoGGL4awt7wFHuhQ81p4lVgonJ7/EzD2qk24WWSoG7geC7Phg?=
 =?us-ascii?Q?n7aSIX4qOukMkpM+PVgAYNubL6b47gPFaLls06VCQAves5/hJt6YV7k8BiAH?=
 =?us-ascii?Q?21qTeQmFm6Nj73Zo+f7Wugs2ZIupPDmy8543pvZbNTmfGTUkSXZynD0qdx18?=
 =?us-ascii?Q?OBUQCqI0ngeLdAdqSt9hataa4gPFwHrxvSjZVCJK8Ts1bvgf8fp6jtYCOBV8?=
 =?us-ascii?Q?ONiN2LA+8zZrtn40Dv9YRg1iuI0YIWpe4wJJTwn8xO8L0/erObjHAQpajpGY?=
 =?us-ascii?Q?l80wyonPDYpxnuGUyaRTJrl7XL4H3+tXQ84D4/jjKLWQVId486M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHAcSMg8LGJ2qnFHc1H/wO5nTmhZJqK9Q9CsphrX043HqPtAIqNoyvUnb0qg?=
 =?us-ascii?Q?i7Xsjv5N7flnDiDMZx2ECuCnSIvQ4lEjlKQVbTL7qnsx1soon0DWUNxfkE1P?=
 =?us-ascii?Q?8qXZvt+E9NudtcUoTFQUZLSDmnQOAOSYoJBYUpozPVzkqmjVzaRL5BR3TS2H?=
 =?us-ascii?Q?4yjeb03+0xQZ3GqtYu1Rdp+c1Eu8FyLOfXcrzsobJclxYLFqjnvsdMWE2zJ5?=
 =?us-ascii?Q?6kBuy8VuKVtcRfvFT8ipNzjArIbUhTmnQfhGaABRuiwJeAOPzfERWZ54s3hq?=
 =?us-ascii?Q?+z8ERj++SE48ubY8GmjcbrMb/kUSgr1JrzRwIZQO0SaJ30NNVW/fxVlPMGw6?=
 =?us-ascii?Q?RShiOFmGXUMCML4Ndp4JzhQ+8jFv1qhurB//SaIsPp41GgWTgcU5LQGxgePP?=
 =?us-ascii?Q?dt6eITz6Y6ULi5ZPchQbdGjLpLTA9qmQYNlDMgAB5Hu6cvl6C9kUmr9hSAV7?=
 =?us-ascii?Q?DMocsB7VP16SAwibj4gzknyH7Loraqi2zpetBE8yIfZRPWIrbtcHepKQBykq?=
 =?us-ascii?Q?pzCZxPy+EYN0dHUXHlFi8sRktkGCuyRgAvnqhGS0P7dRjL7O4MmQOBnpjK83?=
 =?us-ascii?Q?Uo5+Xf7o6VQPn0NvYrA1PW5CNB1fc4dCu/uPxMFFVUp7SsG/tm8QZMljzB3h?=
 =?us-ascii?Q?1oDMR8d2KMbtfzsNmNL+9rq6vmz5OpGip3mpcLlB67uUmKrjZOzhnx11Wj0b?=
 =?us-ascii?Q?N7t4BD0YC7hUN+OehjSNw/Yth3RZNuaplhaefgtRqmdEv5dkbGPpnwh884/D?=
 =?us-ascii?Q?cFjOjzEJzXQG9DptX0S0mlw4f+t2rPAyGkhkphvnbGdKJiWD6DQPxmV/rU1d?=
 =?us-ascii?Q?F8EJ80nIN+9ndzjA7VDxx8XMVxHZw+9Yv0m/Um3GJHuhi/Ld+qSPYMyZ6XZN?=
 =?us-ascii?Q?a+4Sde207vDeziudMQiKaFTdWJKLYjYtZKB71dauAwhUHJUQ4VPXsGNba2ka?=
 =?us-ascii?Q?elkLiG/K0Gg7gBSxTxPVI1Rwe5yQqzjLcZA6YbxnyPBrekzstONbjPQ5wtJb?=
 =?us-ascii?Q?C1NGtSjvWwtEaWzTba1yxPM4i4uM6mAcW05z24YBOGC9kt24aD+eZLHyZEDR?=
 =?us-ascii?Q?zv7gwW66TmO8iOwHgDPt45vqxhtJ+A8LaxhZTT2sL9SNhzcWaZBMvkRk99oj?=
 =?us-ascii?Q?DAcOdrubIFWs4zwWkjGMdJ2YWRetX5H1sNaXfs37kHYNo9+cvJyTPYapFAKg?=
 =?us-ascii?Q?9uS1uucF5sA6RomkPWRt7ahq1ALGQz/BydrFk5rNrQhGFe02WXI/5+TaQET0?=
 =?us-ascii?Q?u3aI961UKcZr2RtXrYI8WRlv9svWdUEcRgjseWEItyL5eHfr4cxNcP4sp2vK?=
 =?us-ascii?Q?l3sRLmFHrZrHq9/TA+Z6C0QrLgshjQaJVaGJYh4osvvcq3aLhL7lmCKzc2rY?=
 =?us-ascii?Q?ZRVwp9UQ8T2Mcb9khGxJ1cXlZafNkuo6ow+vEcwxvqEyG8kRDQPdjc0kyD5E?=
 =?us-ascii?Q?DtMV8OpcAlvpsfTMR7fr8Es21aiNXrPf?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea1582-3930-4d09-51bf-08deaa011315
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:17:52.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB997348

On Mon, May 04, 2026 at 05:51:28PM +0100, Jonathan Cameron wrote:
> On Sun, 3 May 2026 15:51:30 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Sun, May 03, 2026 at 02:18:18PM +0200, Krzysztof Kozlowski wrote:
> > > On Fri, May 01, 2026 at 05:11:40PM -0500, Chris Morgan wrote:  
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > Add devicetree binding for the Invensense ICM42607 and Invensense
> > > > ICM42607P inertial measurement unit. This unit is a combined
> > > > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > > > 
> > > > This device is functionally very similar to the icm42600 series with a
> > > > very different register layout. Additionally, add mount-matrix
> > > > attribute to schema.  
> > > 
> > > Why adding it? Is it something new? Is it applicable to other variants?
> > > If not, why it is allowed for them?  
> > 
> > It's not new, technically this is a bug/oversight from the very first
> > iteration of the invensense icm42600 driver. The driver requests a
> > mount matrix using iio_read_mount_matrix and then returns an error from
> 
> Unless it's broken (always possible) iio_read_mount_matrix() is supposed
> to return an identity matrix if there isn't any info in the binding.
> 
> 	/* Matrix was not declared at all: fallback to identity. */
> 	return iio_setup_mount_idmatrix(dev, matrix);
> 
> So not required by the linux driver at least.  Probably not something
> we should require in general.
> 
> Separate patch to introduce it to the binding as optional and say something
> about what it is for to justify it's inclusion.  That patch goes before
> this one.

Okay, that makes more sense. I saw the return condition but didn't realize
that an empty matrix didn't result in an error.

So for the next version I'll add an additionall commit with this as a new
attribute, noting that it has always been supported with this driver but
never specified in the binding documentation.

Thank you,
Chris

> 
> > the probe function if it can't read one [1]. So it's very much required
> > (and for the next version I'll upgrade it to a required element). I'm
> > adding it because a cursory grep suggests that my use case (for the
> > Anbernic RG-DS and in the near future the Anbernic RG Vita Pro) are the
> > first devices to use this driver in mainline in a device tree based
> > system.
> > 
> > Thank you,
> > Chris
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c?h=v7.1-rc1#n746
> > 
> > > 
> > > Do not say WHAT you did, say why you did it.
> > > 
> > > Best regards,
> > > Krzysztof
> > >   
> 
