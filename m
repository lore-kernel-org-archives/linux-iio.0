Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010018.outbound.protection.outlook.com [52.103.2.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260D30F816;
	Tue, 23 Jun 2026 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232692; cv=fail; b=OQLAcAT+uLsJdX+zk30dIRzt1vIvEUnLOiaOPghkPuuP93E4eaYe75XfUvZBAqHnA15MJiLnDM5sXPYox1XjdVQxvFesizmsTt0qBUl4glOlvuMVu2RNLeKR1TGlIgDpcJkeZM7N4f4vEXY0wV+v/Ky6IIuRJ7RQzEUYsuRwHw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232692; c=relaxed/simple;
	bh=CIv6jzMgQJmW627mfMXLPsEL5Ymuh/CrE0VfHymD6GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XW2MAEn+JcfJw8uu7fyCjHzrBcfaIvUO4VPyoibb9oz7ze79X3NAYfQ4DEZpVcAPyo8hRwsvsJe+DSsYH7CwMwwP4r///N88F8ZKsdFbBbK0UFmYCRmp00jkMoYEVdoyLAIJ4MTrVobDX61eNU4hjoGIx0E2+9A8Ghtho4UwM3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IPiM/Vk6; arc=fail smtp.client-ip=52.103.2.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IPiM/Vk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fouavCAdNczjIYZpyTFyiKeac2RJ4XLKldu1M5MJqULWadC10my1YaUIY6GG3vq0Oi+QbSrb6lgN26Wl8DV1yN7AIrHq+N9kF9trpbDL/D1bR//bO9pByrSF8HPnnMCshlTzqsB4dH8RzgMMyyodzCC4tohfgOsIv/U601Vbib9TBgA3nwPM412I4ik7tpb2ddR42HIYXECq/dMgMhqz1ws2I3VrRNHydhAMUAlmNK6yDZZt0DHs9mS7S0AQIUT6UfFA/DFsbpj6i9n+r0McHI7+LSh8J8PgW5i4X8IYfAtPl/K5vic1TaP72GjC9REi37+8bgzEgQZQjXxmDqAUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvpsyK5tsWnx1VXcGwuZm17WZAkTCHSid8m9X+OUXhY=;
 b=BVe+mxZzD3+oQQ1S/xZuDDaO5ZmYcASlHrDgaYwTX1G24yCDcjBF9YJ6f8mF6cvVSpMZq8VK+CAu8SDGlm4a8vD29MN0gHjtdw5DxKy8KuJTkNtgZCYMKvewOEqlDRDQszy+aaAJR1Gn9il/ajzVIqyBnbg3Ss3ZJHrqlVqvh9btR3ENpxHwFPVEOfYImwoaJyT16wtKFz6eK6ckjj3qpBqHYDeoRXirfihFPyaNIZXKPUdNlDcaJ4BLPTVtOzc8yXzxL2FoiIWzl6EKRFzCc/p/hDqwbwk9cJzlC3OBURmXJrRvjqxtaasGGEOnHL4ogNVf530YVUC8d7EG5xgbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvpsyK5tsWnx1VXcGwuZm17WZAkTCHSid8m9X+OUXhY=;
 b=IPiM/Vk6esr5SYJ12TqYxr5BtvjTQwb69t2MIkt//eQta8thAlusGnZY5RrByFVMWI5O6ce7Xfrwl1CvSKTm0XhQssiQbqjDYROd2gEk3qeZPVRxlsx72W8D2561PWHPxY3DHa7jPSH7y7Q7LX2+kpowtZjZcFB3CwweMw2th8Kdp6OzntXrEV8pzxdaLLwbsCBJ/f00O8p71Wr54MiH/XnjAelj52Vfta8XDokMAQPPNKoZiJUMCtq+nu/J5WZEtLPadt8wqVoRE63a42m2jg4t1Nh2txhRHRyNBRPkqV9uKqsedhXtu6nNfJbbz0bvesAMYZqg9foAqHodelMG2A==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SN7PR19MB7470.namprd19.prod.outlook.com
 (2603:10b6:806:34b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 16:38:09 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 16:38:09 +0000
Date: Tue, 23 Jun 2026 11:38:06 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Message-ID:
 <PH0PR19MB9973384544AC5092114BC3C32CA5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-9-macroalpha82@gmail.com>
 <ajEhr0JIQwzRgoZa@ashevche-desk.local>
 <PH0PR19MB997338E86152468CE26F60953FA5E42@PH0PR19MB997338.namprd19.prod.outlook.com>
 <ajotNPhg8fR3tLZp@ashevche-desk.local>
 <20260623161527.7b7b0ccb@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623161527.7b7b0ccb@jic23-huawei>
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajq2bvEOWOFoncsn@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SN7PR19MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ce05b4-2b66-49df-abef-08ded145cf29
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|51005399006|25031999004|12121999013|24021099003|37011999003|15080799012|23021999003|25010399006|4140399003|5072599009|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsgCM+fvpO3ia5xqtA4NU1aiW3iHKQ9R9dYA/y14cxaSIttkD3ZLgTHNcaip?=
 =?us-ascii?Q?DMkZM6eL5Sm7uD2DS0xq03mWMx2QmeOvRQmALqoXLW1tLgU/l+gFNp+GH9RD?=
 =?us-ascii?Q?MaH9irx27F3bpzxCMId8OPlqZVt86E1LGJbih6M+jnhj51x6ClFp981UAEVw?=
 =?us-ascii?Q?rpfPFlAVXbh+1MCCz0UmBcl36BeOZ3QbcCndAD9Dfzhr4p8G4tyoTjo5DCMZ?=
 =?us-ascii?Q?hC2ErZ2e1pQQNyDSugS9mGVsjkP13n8A15MDGf3bYuoy1OvZVgWMPCsLE4ZJ?=
 =?us-ascii?Q?Roo1/6tIhVJPugAnvBVVPMgOfGmVhut5xV2r8PkVCYbF0LW8xw8n7OKQPSh5?=
 =?us-ascii?Q?5TRVjY492/Q1Q8EEXS2g5k2oj9Ns+FHOeCS+VryG16WBfov2unXHN69KTSv+?=
 =?us-ascii?Q?7w03N9c3KFGKjxkRZZaT/fH0FoJWdsWZkl2SaG9BOP9mgZ5P9aOxr0P/ZyD0?=
 =?us-ascii?Q?mkbPTg4Had8BJwF6n8usQXYwwUeyrTL9Kg41NierbBq9jLqmxznU6vF902Tb?=
 =?us-ascii?Q?R3vdnIYwiugGITPha/KXhWKgobl8Wz1yg0tIeWODhjJGnXp0hxL7gTJTY6f+?=
 =?us-ascii?Q?dvxyfX/Gn+3WWQdiPqmfqTPF7koBGgtoYs2HkJQNynsW9wggZmLcStStnjqq?=
 =?us-ascii?Q?Kerc02o+pK2DD9gt7GUv015POk2KGfOJHG/X2bRT4A+iu1ev0ktpTADeURWg?=
 =?us-ascii?Q?C24FgPwZbMAl0gV+4g1O/EkTCPkL2Q4xNu9Z61OFCIwMEsEWkIhCI3aNlwWA?=
 =?us-ascii?Q?D6OrqWY7Jav6LyL0JmucS8HwUp2Wn8Dr65ChLD/Wr+XpXG38NKLaqEYkGlmY?=
 =?us-ascii?Q?VO4W0HujHhlrbOcYK3fAlf0FFJLos6P4w4YJXVk7hCiFMwuQKQlKGKwQrus6?=
 =?us-ascii?Q?2ghbkHDo9/54CVaffGL14hbbiZ9NLmQs4AqeJARyBaJj6yC8pR9KVhhsdUIr?=
 =?us-ascii?Q?FttfLEeGdVFBoTCP/JK0/HtE22k7zAut18bqcrzhXMyNvcJHnA0O8abfsXZv?=
 =?us-ascii?Q?SjFOqI3/ADPNTnE47h4bCgiQVp3aT6HAj3KmzvrAAMC/FFxL1M4UwedtZNPA?=
 =?us-ascii?Q?N8iKtjoN?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1wbMOGSJ1ozE5bOHp5AoyB6TwSLQOtLTVBvdfRk7AjSTaRSFN+N4vK0LHli?=
 =?us-ascii?Q?bZ78sEKdhNU50wm6wAazB4Ci8LAuTEhjL+McfTBowqGbEPkf76AWotTGsgYk?=
 =?us-ascii?Q?+rK5a9lWMZMebnK8TtLBFPVPOTd1bI0QJdrFK6Nto8cd1T3Fs1mkAgSgCLmW?=
 =?us-ascii?Q?9/w4HT9zA2DfS7AqttSOPAjAs3UjgbsK5qDMc69dNa5Omv3m9ZfFIMkCYBV8?=
 =?us-ascii?Q?+FSD2+frTH8XaebUOhsk5c87USpTAff2tHSEP0tW+pU5wULfwxWwZuYFvrRc?=
 =?us-ascii?Q?iyGDU/ArLeLSTTiuiFHHeLFQpZNHLewkBJaY0+SgOWXg+cMXWEDwkePAKZLX?=
 =?us-ascii?Q?JYXr3vWJ3McReXirmxBzYzr8VTxWs9DbQcgjY6Lbfi5ZDKZ1ulqIAq860goX?=
 =?us-ascii?Q?e3PTWFfdp0Vp+gSYD5ozxGu+l4+lXTY3CMqbYeCdVUGVokfLerHQNtvFb6p0?=
 =?us-ascii?Q?M1jBtC1oI9NVeDqxEMUDkvBJEC0XqyMlYAQm2LFf/lyX7bPnQKNZ41tLldm7?=
 =?us-ascii?Q?X14tsUA3Dzy38tCIeTSNHRcaiECtcWnT3pE1rTXH2BhUqNzS0IgVFdQoQCAm?=
 =?us-ascii?Q?yb3sUsDtywg8LiasRVSAac2JOagcMg5oSMDZPfHVEr+K1JEQShPbpBjcmAlI?=
 =?us-ascii?Q?cu+1CKcwlapxLsafgNly+rnmUdGjKsKdmrpTTRMKG/kVVkhqweRCr8kkMuUD?=
 =?us-ascii?Q?l6binvfAGpNDTGs7OAopcv2jlwnnGKq8/+5YADP6vSAe5wcr1BJOMMwfoskH?=
 =?us-ascii?Q?snoFel5kCeVHfEV7Sf3+ismGhV1xb2KBxDpQE+BtVPDv5bS1y9XIEiG+y4WY?=
 =?us-ascii?Q?NDwbtX8iFI2Au4h0x5bYWJWYdOTCbJHhOPQEh3Pm4RsBsyOr+FPYSFsiLACu?=
 =?us-ascii?Q?hD9lVSw6GnFMUgnZg0DPS5/1PIqg2GlP/VrbuBs+Z+nCHdBxDgJv6qR/uOvT?=
 =?us-ascii?Q?uhT1f1reFveEV+59qzDFY+2G/V5xq1YjXvviJIWnLtNEvrQwe+bO4fibdoOT?=
 =?us-ascii?Q?oJPSJ63SRVm7qsKB3RwJnP9m6DnkZVKCTrA0rKSx1QIcTKb4HJtiqi5R3EOE?=
 =?us-ascii?Q?oiLm33iQ7lbvWOC2PhyJj659EWM7i5wUfw+DV8sjlNfW7yV9z4i2MHQXY1AO?=
 =?us-ascii?Q?WW0Mw75+fOoZ5N2xSc3R3+NMAZwryu7DIZxp7HJNR4LbDQDOUGkNn8djh2/J?=
 =?us-ascii?Q?iBcXvXjO26v5jc3pV4lQwCqANfse758t7PTlJiW8FPotcgI4ED95qLsBbITe?=
 =?us-ascii?Q?wemCM2vdXRTnCF26r5oVMw5r7p67ekmZVxsh7OfJ1cvzFt3XuwnPOgOLbwrT?=
 =?us-ascii?Q?iW+1THu8O+L/XWqMRw8eBhtK3VfUcxWjO5BqESQb/9DDHPg6R8/AV+07OZHx?=
 =?us-ascii?Q?UXejX1nM40qlDvkvYU3k8CBbhjWZxvEfGbjN44vTF5slAw7Efg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce05b4-2b66-49df-abef-08ded145cf29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:38:09.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7470

On Tue, Jun 23, 2026 at 04:15:27PM +0100, Jonathan Cameron wrote:
> On Tue, 23 Jun 2026 09:52:36 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Jun 17, 2026 at 04:10:49PM -0500, Chris Morgan wrote:
> > > On Tue, Jun 16, 2026 at 01:13:03PM +0300, Andy Shevchenko wrote:  
> > > > On Mon, Jun 15, 2026 at 12:25:51PM -0500, Chris Morgan wrote:  
> > 
> > ...
> > 
> > > > Can be some of the code deduplicated between gyro and accel?  
> > > 
> > > Probably a fair amount, but the deduplication will likely need to be
> > > undone somewhat if we get buffer, WoM or apex support added back
> > > (I don't have any devices with such functionality, so if anyone will
> > > do it then it won't be me). I can refactor more if you want, or we
> > > can keep it split like this to make it easy if someone else wants to
> > > tackle the buffers/IRQs stuff later? Your call.  
> > 
> > Just asking. Jonathan, David, Nuno, what's your opinion on this?
> > Personal opinion is to avoid solving the issues that do not exist.
> > If you are not committing into those features, let's not prepare
> > driver for them right now.
> > 
> Agreed.  My only exception to this is normally when someone tells
> me they have the code and plan to post a follow up set very shortly.
> Then I get a bit more relaxed as they chances of 'preparing' for the
> future being relevant become much higher!
> 
> Jonathan

Okay, I'll refactor a bit more then and resubmit in another week or
two.

Thanks,
Chris
