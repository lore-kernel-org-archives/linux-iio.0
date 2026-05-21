Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011034.outbound.protection.outlook.com [52.103.12.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B233E5590;
	Thu, 21 May 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385407; cv=fail; b=shffSUwrpewa3ogJcXJczCqxRuNUh+sJcMJOlfg1FHNtpKzUly0kVU9Bfma4YYDgBhoaWVa7yRfr++OBFrdxdNzZpd+iB0I+45zHdTRiLdl6zYa8BXDI9W31z8pMoC73wo5bvKs+0u0BHrjdyJdpUUYizB8UU698dvEhtVPBFI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385407; c=relaxed/simple;
	bh=0kJ0zCIeFp/y2JHKn4Q7WS4IwY8RQtwDnAXWM5naTVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=He4zqnKI+lOO9ZHCRwQiWdPBWNenqhuc5D90n8d7aPJjG7Hp14/NIiJ7DM41qR+7ZLXfk6LAJ5e3q7V3t39xBPStXVosgwwvCQh5guMsgv9gB5CRBzJQlGWbx01+k0Qfzf0ON7PzxUbXdZCH35trvDMeaOz+SjuD7AP9sRWuAWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QeyyfVYi; arc=fail smtp.client-ip=52.103.12.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QeyyfVYi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtkpfRuBfFIGsYafqHeGKin4+c91j1PC55KrG12L32HsSIS3AK2Ay1JsZiCNgKqujOlsJ3U6R9Z4TSDUV7D2TsMGdQZXVwWQa7gTcuWhraIYk0XytHSDiPetQ3m/XyxX9mQKBHibFxowxpOUkGvni59qKxKUKIflOTOvgfGv+m37bVU8+0r7GZl5VzFqKkAO7ZpzZvW/OVBAdZpyK0WRit3TaF+LgN+fKExwXRxykYUBe1CqE7tHFp0Flos6gDGIwZfXJbPDqKaA/rMxsZ2Mrz2Dlu4Wc7AwkAkl+WugPJw+X8OTfTlebwiy1KDDicefItMrq4lEJ3nZspRsexsEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7BGg09LM2VlDn1Huxtka4voeTsMr0juRMFl+i8qHqQ=;
 b=lnw7osWJ2c1kZ8MYBiC2njkpkYwuiKuFHEe/voGpXVpxK4ohYmZODahzwvYY4pYusNg7u3fFOHtOL75qxIKHjdyLORh5Z02IUO5qLg2j4q24KmdhTuMtjmdnNoRap99Xu/GWvOyDD3We7Z6TRFcIbEc0t/va1yCmfhGKzwuxXnzMVCBwKAfkThcLZVmbOgHmmI+I7e1zLWYXknEehpixgQzz4R7rpCst9s+HCTlH2klr3jKYoR89lk0Et7moc6TuFyJqCVbH6CiAOe0s2u5CIVosuZ9ImDa8nOPCxkN7yASPqpaE1GRpjT4KooMdftkTVLVVk2Wt8wcy18tcUzX0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7BGg09LM2VlDn1Huxtka4voeTsMr0juRMFl+i8qHqQ=;
 b=QeyyfVYilvghJhNrFP0iWYWP47ciK1UjqMkrGHsAjqtvgBT34Z+e1UDy6860m8NG6J3HJiHF4aOB/gCukhvOrPHCT0QpX0QDxbM4jDje/fOcSChPcG9hr80ifiss/UzaYRWbhgZiYO/sisWDIw67NKs0jjEcMBbTWFzN7B50cw7gafhcTSq6NqEcBzoEN8XVtPJED8j4UTvwUiSSO2itLSi+p9BvM9buew+A1y0fJzxd1OvsNGGUJP0fZvFKUsnlHwBgejdU+nFAOs9UABhd6YJuigSzXqdthmUrGBlDTUomnVT2mwqhTPpgXuylpMn37+nuf+1L4sRmV4PmEB9d9w==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SN7PR19MB7353.namprd19.prod.outlook.com
 (2603:10b6:806:345::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:43:10 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 17:43:10 +0000
Date: Thu, 21 May 2026 12:43:09 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V8 02/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID:
 <PH0PR19MB99733879756FFB321CDCDD9B81A50E2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
 <20260518200526.458421-3-macroalpha82@gmail.com>
 <20260520174217.6ca98524@jic23-huawei>
 <20260521-premium-afterlife-0d7a22b77517@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-premium-afterlife-0d7a22b77517@spud>
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ag9ELeTTHl2yXPq5@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SN7PR19MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5372db54-09d1-4169-8ceb-08deb7606cea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|6090799003|37011999003|51005399006|24021099003|25031999004|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIYOqVWembf8YW5hVpk7hJtNYMO8Jyu22rdGmIXnd9uCb7JH+6xyP22SXZDj?=
 =?us-ascii?Q?mu98WGok1btOT+EWaCjukd69MeB1kF8YVAdjQ/RVk0S/xPhqrv39Cx9pz9N0?=
 =?us-ascii?Q?/K5yEkJ7PLJzfh4+l5sYES2I4Lq2veuMtrXXO0INwPnxWSgYllKoizQTD5W6?=
 =?us-ascii?Q?rUmGh9RufQBhw1GPTzFUiYn6TCGyykPItmRquxi4YkiHIqJt4Grx/I/mBu+w?=
 =?us-ascii?Q?iyhp/cDmTuqixSb3xBoXUmZDHb62A/TwFRn5g1wUsZq/g7DAmSqLDkxA2z35?=
 =?us-ascii?Q?XNvi8AGzcYSfP/sTpNruoZAQmbKO3Qev8wGV5AHl+YExIAgGu2YaTAt86aaL?=
 =?us-ascii?Q?Cj48zmTuXzYuRtFF1XgCBFgXlE81/Kqu65sm3F5Q8iOfEyF371e7cKXEIyD9?=
 =?us-ascii?Q?v6cxXsRvoWo8gNp/PmPse+/C/13rzDqGBIQRueHFKyQBMGFsjAZLOPh8AKyi?=
 =?us-ascii?Q?dIkdeiJAQgkEPCcg57r2jZmPXFe4/5Mg4nYMXrw7o7pCeDeJjLcyPg2ekCvH?=
 =?us-ascii?Q?QcTHROWnznQxhPgbaKkwHlPcVxTnCFiNX8K9tz7HFEmt8rK3of+dx52lSUAw?=
 =?us-ascii?Q?M2gnjb1+TNa4zwVsrKuLr6m+EcbHAfI+QeCw9iDIRAJFZQKkIKtUBgeWyP58?=
 =?us-ascii?Q?MiYuLAf2P1HGcHkdj66O5YkIJ9My4p1syCSvWqptyc+FC0VFg/TcCU40BJST?=
 =?us-ascii?Q?i0rBf0fYHHKhui4lKT7SyUXHCh9639aBN6M9s7NhfQCa9eo43PeJZtxXmMgd?=
 =?us-ascii?Q?poXQ+63qO4tkmfcIqg+Qj4Fpmn5LiNtPZL7MzkUraje3qpjd0DY9jZUs7uCe?=
 =?us-ascii?Q?sKYoOnAcTpNqeajG5Tw73VE5Trb4thTBQxS3q5EQZUCXLAtMu9GFaVIq7Okw?=
 =?us-ascii?Q?5GZqPJiBV8qbWvAi2xDojNi1Ew1i6/Y2SJTJkDZKHHyXqK7MSYoz3XQ8CSog?=
 =?us-ascii?Q?IHYNCfcuh6uZkEQJ8WXmSXhKsr4OYq1ExFrrCNkSRl1+yeYjjO1Nb94Onkvw?=
 =?us-ascii?Q?AUeet7n7OZadskuuVgU6Yhaksg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SS/79DtB4+lqzHydoisSQmHN4SrjH5f7Kx+WhqNGa9JyK4Px1YmWpbZeAWm?=
 =?us-ascii?Q?8mCdzmJIK1ju+aEQM01yJSqKAJg/Nydv7W5qxccaaV9HtWvjvp2SDEiw/fNM?=
 =?us-ascii?Q?SpzpJiV1sa8Io0cYOuDH8aDkWUJEK0btl34YCvvtFquPEhRgVTG6elNS6ocB?=
 =?us-ascii?Q?tza7+RDchKX0ztNU5jKrTOYf06varM63RVmUSpC8okxTtYeI0uu1JJAqifYl?=
 =?us-ascii?Q?0kF8UHKmsgdj0or8NgWTS5527Q1W3/N/vKt/RxGEBkxlormVf/Yn7iMtZCa7?=
 =?us-ascii?Q?+SAAk6JxNAHKsFTU52Ow1Vheb/HNrJqmG3eKbTZf+9QWPGIdVSEQsIXhoPs9?=
 =?us-ascii?Q?5uoMmlyBiBWacQbq52NZFZppmPhLiph9KkRzVoF2iVPIyS+Avdpk063zBPQt?=
 =?us-ascii?Q?OLLpachcKgjVi3R89S5mAJkRom03UC5djkcqjE900vd2k28eRS36GUao1pH9?=
 =?us-ascii?Q?jvvhayaL1UbXNQUpWlPh89UKe5w6suxrPoilYk4nBanmhs5Y/R/cP0AYTRWR?=
 =?us-ascii?Q?NqSMBuAKBokNqPCjHFlz/4Pnroev85vBphQ2LQJcG0M1IFGZpBSr7hOpJeLc?=
 =?us-ascii?Q?++m/1g6vLsNmo3Ha5ng+1ouXCpL+GxTIstaDqHaYEsw9uVimMDtKInOQL3C2?=
 =?us-ascii?Q?qH5FMzcUXb/bncdh5EcFWKWnS/YcRq74kp6awF/LOKk/HpM3bjkCtL5KoNth?=
 =?us-ascii?Q?v0i50Zpek1pXZlN0dPCJ7KFYoIEqvgOIYog9S4JPmHw0s16MuGsCU5eZSN4U?=
 =?us-ascii?Q?P60XX2nqAMHVlDdQC/UJF7VAgXFctMl+j2cjqZpMDgKqmjAN8qnI4EnXEGiG?=
 =?us-ascii?Q?0qMTaS5Cf3Qv6bre5fsKQLc1AibHCMPR56QB0XmKjQQ8WNSxm2pdWHkX92zO?=
 =?us-ascii?Q?LbzyxaDLK3pG09WC2etEO3Wdu6sL/WCPoRAvo3KbhKi8CT5Pn2eY9jSaiG1B?=
 =?us-ascii?Q?Cqyve6ir0iMtTu/42xh+ZNEjr9398gkE7uFsBve5sdC7yK0vcVmU2yIKCCUV?=
 =?us-ascii?Q?tUKDOa+i4U3xqgcQ5Kq3FGZtKi95LPc3MnzcbbnaNqgxiRPnGXKAPE6JBlNE?=
 =?us-ascii?Q?HRkNETTbhubmNfYmC36kD76aeWmWMZXyxbgYisPxxhrLM0bzI7ivSLNc/Zwt?=
 =?us-ascii?Q?OV2nhdM8ElYNrJOx+CznUukKd/xTHi6JBl9g0TuYVTJMAdTskYHCFiL/C77Q?=
 =?us-ascii?Q?dTU8Xg9F5vwiGpHUO5q3/6Hxma5CXce9UMlTKFlN94WvZ6MMlA2u2hq2wPwN?=
 =?us-ascii?Q?0lOO7qBteFknvKCT7XYP6bUCgM9dMgQZ8ZLj/Zp8f3WJWYGqJdwTTCV/VKwo?=
 =?us-ascii?Q?FxS1ysZ12h0CUwcnIQI3qmAd7yEfEj3aEjCd80F2vZ5ckWqnjs4yFPYj1sdy?=
 =?us-ascii?Q?0hUxWIkPVdfuCDw60S9whbH3qoM1hFiEZsjvK1ekdJJLBX3OuQ=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5372db54-09d1-4169-8ceb-08deb7606cea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:43:10.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7353

On Thu, May 21, 2026 at 05:44:21PM +0100, Conor Dooley wrote:
> On Wed, May 20, 2026 at 05:42:17PM +0100, Jonathan Cameron wrote:
> > On Mon, 18 May 2026 15:05:17 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> > 
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add devicetree binding for the Invensense ICM42607 and Invensense
> > > ICM42607P inertial measurement unit. This unit is a combined
> > > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > > 
> > > This device is functionally very similar to the icm42600 series with a
> > > very different register layout.
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Note that Sashiko has highlighted that the binding this being added to
> > has a potential problem.
> > 
> > interrupts are required but interrupt-names are not.
> > That would be fine but the binding doesn't say there is a default
> > ordering for the interrupts - so if we don't have names we have no
> > idea which interrupt it is.
> > 
> > This needs fixing - probably by adding a default
> 
> Worth pointing out that this isn't an issue with this particular patch,
> the problem exists in mainline.

The driver I lovingly borrowed this code from seems to have fallback
logic, basically picking the first interrupt if it couldn't find one
named "INT1". I was told early on not to do this that way, so in my
case the interrupt-names would be required (but not for the existing
driver because of this fallback).

Should I make the requirement conditional just to my compatible
strings?

Thank you,
Chris
