Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14D402435;
	Tue, 31 Mar 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970161; cv=fail; b=gzcZcy5qwwa2J/QqgOyTfAA7WIT9gQbBH+60qj/AB9kLp/EmShPbBb7cW6215YDZgN2vsNBACuXW3VPc24mYruaGwHy0E3Ae2POjfAtgspmGUYgXS55rWSx4+ug2rqk3mqf84H5rDisWuUd53ShRtSHUzEuiz8ofUL1iLc8fIlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970161; c=relaxed/simple;
	bh=9CwwpXen8RyUlRULCclLwYy6UejRQ6bYcB4V6nc5cdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gceMwkviHanS6O4fL5cjhYufZ36hxaju8D4poAZb739X4mzp8riSl4xOxmtZXbrcDllDF0Jd3pVBEOP+yOJ7ieMghJWFXIZw5jujDOY63Pcfq+5qpxwierk0aq9Qy80dlw+ZaU1c4kdrKX9MjVeqdsJD//9oZvUyFDP3IFPuFIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=q0Ul4JfT; arc=fail smtp.client-ip=52.103.23.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="q0Ul4JfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhbCv0VeIFs0bS96kvXmx+Wo9eVIp1CVncfubR1MBfwvEHTfahliNh7QaQxKQDR9tEWNUEcgYg5Yqiyar7Lynf8fwmOXDELWjwfHrQs/qjFpXyMOLozBwMwChP6JlBg7WJk4rLzLzYst/XlaY+0UMOA8iIDLhOGDaMrvQ11MAJTdrHkuDlJcf15W3DMa2DLayOXeb/ryIRqbchGFbvlAJIxZWqsYe3/1vy4oM7ScYFOSWkw17MbfZwrZfZXJUmqUzbVtz91g5LrASEoNL54+agEn0XoxVUF9kxezdrMpkot5chSqsQDpheCnOBmhoKdzVMHi7DBQpMfQ1SPj7NArAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y5XqRXNg9WZ4Q0sXatEDcYRLAD6UB7jdv/VGgcdw7w=;
 b=zECQlfiWy+EQv4CNB2622slY9kTmEFyqw/ptXntqvffrGiWKz1OXlS0Aog/Bo70+IZLRIryTDiLCN/eDPG3RAotV/Zz9/5wBiHmSyxZ6sxO4q6qQvLPU/Q/bQUBE17BfGE3q/CG6xVq01MxzQWtEz9GQing5RWExp84xN4ODZKLstDtxKa5AZilQhhubopMzxxFp/QA2ondeNIBxbcA/AYK+eIHlXQ9WsO7NwMHYTUtroYLuElOjNtzYAG+9mINlwlHq6tPH0FihMljU/R7YTIWzOIv1rAYGPXL0zp0SiYlkah+p2VcKUfiN5+Au0nmXQ8ybYlmCkfypt+9KiQZzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y5XqRXNg9WZ4Q0sXatEDcYRLAD6UB7jdv/VGgcdw7w=;
 b=q0Ul4JfTOi3x9U2Uo/21si8g++9muzbr2l9EJxXrOj/VYWyXojkQvtj52M1OZUxRsabaZuK3WoNL+rPAKaagy2a2TBfF9a62emW+Ndu6vGOZGfXdxauFmn/cRTGbDAeQClT75VarmGfSPmdHz/PGHZZafG4N9UH5AH8LB4ByDe3k1dCuXGtXOoYi2dfbb8f3FBSkgZV5m2ns2ET7mbuEXJqNBJStm7RFQ8gu0P2TGM1Fqk8fV9azLySU10SIUE7RBYem3hkxN2FBQR5JV7PVx7WxPbIjKYCLNKv3yBUa/1y7GT+JpkwZ5sgaVDABTX+4fjNQePUtzkI9OkL5OgyJfw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by CYYPR19MB8101.namprd19.prod.outlook.com
 (2603:10b6:930:c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Tue, 31 Mar
 2026 15:15:56 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%7]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 15:15:56 +0000
Date: Tue, 31 Mar 2026 10:15:53 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V3 0/9] Add Invensense ICM42607
Message-ID:
 <PH0PR19MB997338CB9AB75EFB0DBB9BEA9AA553A@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <acuvQr0UVyGIQ7fo@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acuvQr0UVyGIQ7fo@ashevche-desk.local>
X-ClientProxiedBy: SN6PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:805:f2::46) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <acvlKcWjXKra09AL@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|CYYPR19MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 88106aa4-a266-4710-6ae9-08de8f386861
X-MS-Exchange-SLBlob-MailProps:
	CLk2x5OX5VYv3c8Emt0jD2wdZaenNeU3c1oRDJhUY3yW/2lDTTtjOvEvDpUoHYMdeYcJDrfWMhH3rIurMrdecxNm/FcKt1sgdrOUbsDm2eIuKvoSWjSfzQjGsl9VJtDEWFAZtytaS5eBZu7UdGxRPXEyBr9zqz98JRX+Az9X0wwKIYVUJ2WLAEb/uZtsld9S+RIDINkFb+UIZql9IxJai+5aqLpA2NfFxN5Fl6ppS62XYzRUlyBNRRgXp18qhnif9/ObpvV35NKIswa3TZTXWq5KTvBldUZlwUyr5ogwctziT/MWxuYb0C7X/AVial8Gl51dbPVgt/6n+bnNGn9FM/vAbFD2apkQjDQl0YHaQiFzOk/GnTBrSzs+3I7pYzdOXqdK09e5V0WV3BTKEVOGm4IkI6u+alFC8iUV1m65k4qC9Eh9vuJuirmhrxlUvwAqcoZZ5V7gWBBI0h4cQ7PeabLuuJhkOTraw08I02BQbLeQz0GqgAVm5kcNfW1cIsAndeqAD5QYXgLw0ZWkChoPyzhdf2xJTNqcCAeqnOCGMyxb2kMhUSYooJMN1uKY0XggdxrYpOvFZuHUdrAl7tM6mh4XEuZQFfDWSVJ3f9GJ/gp+BJKcw/1St9fxa1D1Exc5fDKiP+unoF5KBWp4tcKoCwcCGpAyFYe/frap3LWD9tgt9g+7rnZ1n05r9zpbZ64cKgvg/g13x24/VvuAu8YW7A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|25031999004|19110799012|51005399006|6090799003|5072599009|461199028|8060799015|15080799012|23021999003|26121999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nUL61H4pdyvnTnczstLxqqjb6NCcjJHZ1WDn+Ahi0y0DrJWLNT3xqDauyKbo?=
 =?us-ascii?Q?doIu0eytoNMpLlHY/3Y99dvmEkWipOHPm4jU1bANSri4Jw73+C5mcNmIoWh7?=
 =?us-ascii?Q?19eWdyFJ/4aTqF3JH9lseZgOAPff5kkP0yyHR1qukK+IDraLWEZwjy23sgM5?=
 =?us-ascii?Q?RKiDRo+Q/0Y2twizYEB2qfSOVkgzabELg7Bx+iuLHDE/uooOEUqLTZNJJLzo?=
 =?us-ascii?Q?0Joyym6EJllQGpmi60CbMdyR3r9Jt/pkfhwPPo1aXE0roN5xYTGhoVIjXzEP?=
 =?us-ascii?Q?tm2b2fnl1uHiISEHtkzDUN5OoRW9pxmUbN4N5PsOdDulCizhhSzYvtiCLYp9?=
 =?us-ascii?Q?q7vifgTrNVHTdCRmAma/vRMQ+jcULgwOcEQoJgpqMnOuXwc7HGCvfP2t8S7y?=
 =?us-ascii?Q?r6TaV04Zcv3SCoHBFkmnce2tY1UnxrUL0H8I7qDrmAx6wFeJ2U8b+oTFuBZh?=
 =?us-ascii?Q?hVhw4XH8SOLpLZRcoTjVwa2nljl8YHwOcsxT9wWilPszLELfyJ99Uaeawz2k?=
 =?us-ascii?Q?3CLvkwqWgoQae8FVfidM9Gbbbioswps18TNxd9jHkeWRRjI0xys6izr2AtQh?=
 =?us-ascii?Q?xAFQQZ+MqzV5NK1KIgEZ1xKdBnTj0GG11xgfBEVA057NORQzysRuJY/ra6Ol?=
 =?us-ascii?Q?kqPEpEWOtYTDvFFiYWR5nLDQjdarQIK5kZy72yJWK2QGT9xnuf8HruhxpO4U?=
 =?us-ascii?Q?dps4Phtbk1RaQCdy0d386/xgE5AgLdMoCtbMDxBKrDtJ/KzAawSyNgnZsouM?=
 =?us-ascii?Q?FQxil/U/7ZNxx2KBtPpx8SftFQovVIQEBsP3J54rm7wiJ+xjzm4wciKhYMTr?=
 =?us-ascii?Q?1CuzUhf+OdqKZvFx+0eT4f8ltvwMv/ojG4GUXtUl/DSFda3f3ePA8Ql/gUcm?=
 =?us-ascii?Q?HqHUaZ9IPyKH69nVLfYAZvOvomK8Wt75xTMDZa/T//JXF4+XR0QfZDCiLgkV?=
 =?us-ascii?Q?XqD5/prZs4uGr3Qne7XcvpMgxm+tCbEimlyu4Tu3GFdELBaxIHVE+BEPocW1?=
 =?us-ascii?Q?BfIoXtMIcfL4FEHTnBwA9ILGWrltrLCKUCjragmrEacQa0Y=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6sOGGCslh76mF9n5v5diAm/4rVEsM3MTTU8+7Fz0lAzGEG+KPjIYfYLR/G9?=
 =?us-ascii?Q?N3gCPWJI2kpzNRR43oDpE8zITClt9QD6XrGuiowmEF8PrR6eCGGwrtoNlTrp?=
 =?us-ascii?Q?VUSxb2qkD9/01oMLHW3gYoFWbhIGQjv3ENeco/s62KR8OQaWyaeCPad6shHM?=
 =?us-ascii?Q?copKTw8AerAWZOEcOPpve+0ikqAO9x4AUbFnAZM63RGOD2pfu4htBJIRBybK?=
 =?us-ascii?Q?ikBxA/yijs7AqCAtiJ48dMcJDenvCVkydNyRtE6mrg5tME9vr2XmTUG2OUrM?=
 =?us-ascii?Q?0vdSudpBMztovAqBN9//HkAQMeVEs4+A7lmxW0awXrmKoo40UlAZeFty4x7L?=
 =?us-ascii?Q?A5/BnnydSbZcnMFApfdBXl4/okmjfyNyp9f/uF5VOriO0j0CwEEuIz6nSInt?=
 =?us-ascii?Q?UIx3kz9iKug8icwO5YaHv4j/Rj57HbKEggjMoINHvrSX5enQyX1mvWEEH3GW?=
 =?us-ascii?Q?uQ+4rbi2foSy1UE04U60SV7Vitu8CQvxIfexkq0bVQOuyz+fhNta1mWP/Xje?=
 =?us-ascii?Q?3k+Zx8zHsrZhqybzzhBcPO8iVARKCTfb44x2sfHg1EoVc4gw88QPusu6lURL?=
 =?us-ascii?Q?SQjyxBE/3fsMbPm0RjF50oabUca0PXiY9+FkeDZkMnod9zEulB+b+BmB58ZE?=
 =?us-ascii?Q?N2r9FjOs2JhberX2RftIx7Eq7uAc4hQIz0q5lTkOoW+PHwrzc42QFJfxHn7n?=
 =?us-ascii?Q?MWD0IxRpLGAM9aWgUhFgJ/YpImCgDxseGTCO3R1CztzcvHSBG3FUO/O1M/Dv?=
 =?us-ascii?Q?HfjFkrPRRyMrfsSc87+OlJ0GaXgFdD/vYtprQUxB4bEnQAgedIFKQKw0pwrI?=
 =?us-ascii?Q?Snu5JwaGCMZmBH0gGEMXFG0v/R8OzPWS3Gn9nvcQE83PxD2d4H7a8Qmk6okh?=
 =?us-ascii?Q?aoKzhmRuHPxIxhgMCMnOW9/I0iS22wzYwoNRr0UGJM2ysc3lnMDWny4/gR1a?=
 =?us-ascii?Q?YpZCmO6s2P38i/mceXIsDG+X41cOUf5FflzP6z1gCa+gTKGRKp3QdrmGn2Bj?=
 =?us-ascii?Q?eppEQQXbGSfQNbdijBtU3qSUbCDcTBXFt+tUCsn0+roNDPLD5eDDRCxbgjab?=
 =?us-ascii?Q?I13PNIIYmiJwHRUk0F1bYYe62IlUY3GfWJPXxkjBOxZYO+bGYsWwUPNpC8fP?=
 =?us-ascii?Q?XY8KObvsB2X+A6kfK6+x3NBvNCozj5Gw8MZO793cf68MA0xbZQHjLwWlijN8?=
 =?us-ascii?Q?c5JJg57q3b4yLAPyfZqQf82cuv1yW06OQwJltd7YUpBzRWgItF+RBQyvTVCw?=
 =?us-ascii?Q?OEJG7fFtTNVtYOpzeQGT8B318ywjc1DagObFp2qI7SfKn7KqiUURmMlGPJ/d?=
 =?us-ascii?Q?QmjEwekgvSYxFOZabzPL8bqmc9ONzglCQCblvwXN1EMg/9+tNXvKoxyhxd+b?=
 =?us-ascii?Q?tRE+XBPDb6LKB4kgipQ+I3YKUc3M9uQTB3Be5oEdMGb40SeOCw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 88106aa4-a266-4710-6ae9-08de8f386861
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 15:15:56.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR19MB8101

On Tue, Mar 31, 2026 at 02:25:54PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2026 at 02:58:44PM -0500, Chris Morgan wrote:
> 
> > Add support for the ICM42607 IMU. This sensor shares the same
> > functionality but a different register layout with the existing
> > ICM42600.
> > 
> > This driver should work with the ICM42607 and ICM42607P over both I2C
> > and SPI, however only the ICM42607P over I2C could be tested.
> > 
> > Changes Since V1:
> >  - Instead of creating a new driver, merged with the existing inv_icm42600
> >    driver. This necessitated adding some code to the existing driver to
> >    permit using a different register layout for the same functionality.
> >  - Split changes up a bit more to decrease the size of the individual
> >    patches. Note that patch 0004 is still pretty hefty; if I need to split
> >    further I may need to create some temporary stub functions.
> >  - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
> >    per Jonathan's recommendations.
> > 
> > Changes Since V2:
> >  - Went back to using a new driver on advice from Invensense engineer.
> 
> Okay, but this should be elaborated in the cover letter. If I followed
> previous discussion correctly, the problem is the indirect subset of
> registers that are absent on the 42600 series. But would be nice to have
> the summary of what vendor engineers told you.

Sorry, I should have elaborated you are correct. The information the
engineer said was that the 42607 chips use an indirect register access
method using IREG specific registers. As a result it did not make sense
to have the 42600 and 42607 drivers combined.

That said, the driver in question here does not use any of those specific
IREG registers (but it's possible other future 42607 devices could).
Specifically, I only have the 42607P (via I2C) to test with, which does
not have those registers only ones that can be directly accessed.

I hope this clears that up, I'll try to include that information in the
next patch. I also want to make sure with this revision that I'm "in the
ballpark" for breaking this down into digestable chunks.

Thank you,
Chris 

> 
> >  - Further split changes up into smaller chunks of functionality. Note
> >    still that the largest patch is approximately 900 lines, and that while
> >    the driver compiles cleanly at each commit it is not able to drive the
> >    hardware until the commit that adds the Interrupt (as it also adds the
> >    Makefile).
> >  - Change the error to a warning when the devicetree binding does not match
> >    the hardware ID.
> >  - Dropped the ack on the devicetree bindings, as I am creating a new file
> >    (for a new driver) instead of modifying the existing one.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
