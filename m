Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7117A586;
	Sun, 13 Sep 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334450; cv=fail; b=Le8HjCDCpn1eJ9hWgqq2N3QBI01nVkfm8IJ0nGJm0Rd6A6v2LwfR/W4HmFmGYzABGD6khMwLlHkxAym4UeRC/i6LtDmbMXgRumBOWV6dCPCMpk5xAM+RHgVN7+l9JXWMVItB1J0gMS/rIgNdVNxJVAuNdyssHi7kZPNp0mlNsUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334450; c=relaxed/simple;
	bh=uqtFV9UxJgwD0K7l/Qj4R7QsEimvxR4ec3SyvbcFwhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ipvyz90xfcS/fafemnL/ycJYqewEHTewfngDmjKoMY/gG/nT6eTqzYWFKXWqw0NEZT5nk9JQoQZJOKN83XXa8b13P12GlIaiFM1kG0C6H1h9XaNsYjbSkV3CNggNc9Tcv7ec7oUCCNEK9TbCh9CBJHgcnZ8U242njshF4XPgtq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JvhaPjN8; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JvhaPjN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkUu/UUj64VMIzrjKS73ZiHezozF7Nf0E3JvcO16LK45ltUbZ+F00liaqcpkQ0SnroXpUZ+L7Gi4FnjesAtynbLogxAl+A0rnNJ18l8Dxg50jRjDuzNoablAzNr/tTPZ2hlEncdlcxOFEf6BCX4DCeeXk8r1YKBtyQtzsVmFck+9i5IvWj+7bn4URt2XCGlATPm/7UdgCV9f1pVJHSBJpq3/j9DykIjTKfIL0aUQ2jdaaEkSTbK10+b622HQXHxdHKd9aS7hRk5trsrIExAaf5jX/ThpQhGzwPr6Tq6KAX0M8kHQClD/VOgMZOr+jkvDuZGY5kx4qzSCL6536V/IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opti67Ivj0BQULmuMjCUYDWffcNylb0cgOOzaXNhd+Y=;
 b=VRTlKKRqav01QvTFCNFJYfXMwbFSMrfgSNNhQqBsk5MzoOq/HNlhQlDZVkuMv/rdG+r7kL0wFOgKk7h6SxivhzFfEnINkCRU0bus8DnRugPVv0o9H9kS+F28BXXOOZl4YyqvR7wEdiUzG6DcyQQ0uYpMEQ+GIjfzfh9DSPFRLlAyjPR42EM2RrmVu+DAbyL/8K8HqsuDRWBop9oi7PxJHkZ3eqoGWQfz35vC1J8YFB1S1+kGThoUNtOkOS98fk5g6/YPaABx0KRay2Ml6oFYW/RwKLfqrZnWFLo0Gsn37KQ4bDwmASRLX6vgWSMrv568OS/6p6riCH2qazvx4BEinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opti67Ivj0BQULmuMjCUYDWffcNylb0cgOOzaXNhd+Y=;
 b=JvhaPjN8ycYEqQc6N+2Ea7Y3GrgdzdUs8U2cXmhg3OzXCez/EtN6hODmid7rljTzIjTKjH6KBu+34Ahann9Ngvm5/mO6dE7FyK8Tmir1YdHhEj6hnCXkf69wBB7wu+c+o6tbEAkem+NjtZakP4g99q2FeRPwIsbYIgZdOhHL5z8=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYCPR01MB6820.jpnprd01.prod.outlook.com
 (2603:1096:400:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 21:20:43 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%3]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 21:20:38 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/9] iio: adc: rzt2h: expose sampling frequency
Thread-Topic: [PATCH v2 6/9] iio: adc: rzt2h: expose sampling frequency
Thread-Index: AQHdQQI9gAPc1wZWh0q4YdXu0OwgXbbNBzMAgAAAspA=
Date: Sun, 13 Sep 2026 21:20:38 +0000
Message-ID:
 <TYRPR01MB15619A10C9AAFC6C5FBC9D7F585BC2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260910085430.3173166-7-cosmin-gabriel.tanislav.xa@renesas.com>
 <178933396021.413489.9480922200160073497.b4-review@b4>
In-Reply-To: <178933396021.413489.9480922200160073497.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYCPR01MB6820:EE_
x-ms-office365-filtering-correlation-id: d90eced2-91b7-4f53-4302-08df11dcdb8a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 scNXy/d392n2hDmWBrD7rtfdKc9RNIJcWMMswxMgTz9uI6y67xhHCUnPQPGHhbLOLxfn7pLAhkUlfSgyR34earKo2c7CailbkdRbt+f+zzbKPgxw+S/KKxzuiTYTY4U3mYzP9ei6KflxuK6ffegxCtzScUZtMGR9dTib+201kvaEcOelafb/pJn1Zo10f+j0rKBZWsQXTBiXk2de7OqR0zrjbMN8Ea15p/86f8rAmuz3R3yx6PBKVUwTp0PuFr2SYWir0JkgoYO/oyA8d4Ef1mCw/e4gypiZYhkS7YH+c1VFTX8ZcUpKcset5Hlq8LIgyzbZ7kJG08/XjNIbBWLfZgKnawc+2BUOucaoSNJx5ARXJ/YPxRHJl1UV9ji2bJWNlw69wBpJrEBMo6gwCvfMBQkjIl0w8lbEv7mUu8Vtav/8khDbrGxJIkKkv6L0MzIQsjWGCGgx9RpfgEsYPYOXox/MOC9kGy8s4ilCPKQTbwk5xLmcXDiIfN/4WJyxGaf+4wmq1VtU+2/VGjDXaBC11IU0UmA7JUAuBf4Rw/3KWIwbFrx5q/VyzaSQRkHusxj1uUAVUoP3O6AJLMMhzobbQRqfmZa6K+SMW1HwIdan/yl5CP8nIpropHvFAOLwNPCOFiTVTMX/7J5xFmH+154drNI94YYOPeLC+W7MCXMLav8B26A4duLufCXKt3h+TVsJmnyJCfnfKT++6EPA/1MBoksfoHOvWcsUN6H/blBJp6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?X4OxEiNnq1dqG1Xwp5Yksw4BYifQsrnW6DEocXQwjnLVgDrciOhr2nrge6?=
 =?iso-8859-1?Q?fHeFBNFXXo7k9Kudrduah2UJbRBAFL1HZ63AM7typI/Ls6xa1WJu48WvcJ?=
 =?iso-8859-1?Q?c4Y4OsTi/PHO5EmYe4JzU25rDMzioqll2YycF+wqNCNN7mq3bCKfz9JNRH?=
 =?iso-8859-1?Q?zPU7loD81zJApQs+y+dU9SusVMoSo9xhDjLa7pJiVJ87IV4TgznSLbleEw?=
 =?iso-8859-1?Q?3McoL5RAsk/Cp1NEissATRWPodtt1Ah0g9rNOu+QV0RUjEKMoxS1TfjZro?=
 =?iso-8859-1?Q?SCOUsK9UkrHa1GR+ILNATqSKihtA5d6iGZqnxR6iOdwul6YpAmwRBo5d4H?=
 =?iso-8859-1?Q?twH8fs0bm6nTqfvdrfD9jBWetx6aYZQwfZLMj7aeIozRdDAm5SCrZjY9fT?=
 =?iso-8859-1?Q?v5PDtaV8P5VISKajgaQISlbsLIphHjg8dQXjooLlBhapi08C3y2Ahfjt0l?=
 =?iso-8859-1?Q?d8CMmzmm2WrvAG77kLzLuqxerQ3QrEXLFK/tEGiaHTGOZE6N+LGybuatju?=
 =?iso-8859-1?Q?z0Mcd4J/Ho+4hmXFAJ8aFYpYqTfskUz+GWYIxJEmmDCHULrMEzyxERKaCe?=
 =?iso-8859-1?Q?1TV6FRpzf0Ciy8LvVVDIAtz3H/E0EUIvatMCjic6dVb91Copw8h9ZmL24O?=
 =?iso-8859-1?Q?dzqPVGERqrZUHB20AyPlXpjBst2KUlgKzFtr16LBvwVm6ASJ8Ize9jQVMC?=
 =?iso-8859-1?Q?PI+jne3u0Dzb30bDZNJRUYf+qo0BkKSnU27qgtgQkuyX9vKH0i1+FWXS7f?=
 =?iso-8859-1?Q?iUt/WOitIvlbsqGP1lOdlry9Po1rCP2v5mB9n9pVRP6BNekAMkIfW67e0H?=
 =?iso-8859-1?Q?1lRO94iWFzJkMDMNdsz/w27MGaIwOtBuDlrhQUPN9aVgZh8QJHUMYQjRO8?=
 =?iso-8859-1?Q?VMeAD9iNw886ZCdyCTCi7voyHSw+PBmnYE0rYr7mmznCvKTHkaht7MAw8d?=
 =?iso-8859-1?Q?yVmIuoUyKZb89v1zgHbgtqOyyfdKayU15rtTZQ19KkxaorPMkpnRPVqXdL?=
 =?iso-8859-1?Q?ZY+QNs6S7ts9gzcGxvA/MGPJWHGKilSa8MFsNNqOxvD6LoC+bnIxIUuBW7?=
 =?iso-8859-1?Q?XXQVWkOlvGJ6QfcS9gC8W4Pw4bLx2edaZTzRAF94jiUqJjy4SW9PriwnCH?=
 =?iso-8859-1?Q?+j7pZ0r8u5sN+EOSpMDj8pt3EFq58mnz2ZhuUePaXuZaTQ7znnFmR2vo0a?=
 =?iso-8859-1?Q?ZWDAi2JoKYY3NBJBAZPrH2pb9Cc4wIMgIFHB3zZbm9qbcibQZATckv1F0k?=
 =?iso-8859-1?Q?aXM72zSzmX6onvYzxssiZCBHg9Enqc3OzXWvWh83VdnBaKl7PoibWlYNcZ?=
 =?iso-8859-1?Q?63/P4ANdREjwtFn86AqCXT3sREVocvXVScCytde2jkkQAgftG4XjmaZ8rK?=
 =?iso-8859-1?Q?hAY+ekNaJdJ02dGqnsnKSVKQfFXWr6cGUvczvETgIVnsrx0yKR4XvT/KWZ?=
 =?iso-8859-1?Q?Ogl6e8LuqVKGosmT700tPI//CRauSmtnMlvAg3XszbOIWgQdJEhm5P1yNz?=
 =?iso-8859-1?Q?nzWcXxgeXmASbz0atSZLYnak7VW0muMTVY6Pxt5QF5bfI858g8VrAvey+D?=
 =?iso-8859-1?Q?xWvtc8Q2mteS9IFl2Rkl/E0dG0CQU1u7BZNUWnWyjOau7e41Dj4ITXRnlZ?=
 =?iso-8859-1?Q?IAXAWZrJewLXSpw3jt7Pj8+4ilOOIB7nhPS+nJk9gysDIM9ne7HwwWkMRB?=
 =?iso-8859-1?Q?4xEI41Qj7fpsGxijIE+DcQnnsBb9i/FTwSuzc/l5Tjms5uCwoo/v6I8jg9?=
 =?iso-8859-1?Q?NL2oIkAc19K6BlhH9R2gtWszH2OovPRG4ZESfa/A7Itxhojjr0w/VXsHHg?=
 =?iso-8859-1?Q?qyE9EZ8AMY9QwSFbaE5vWJSCAduy/f/6PUSNZkLpohCGe3nh2mml?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90eced2-91b7-4f53-4302-08df11dcdb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2026 21:20:38.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzWvedr0FVE0y/jJMHVJcYxlclp1nl0JzGL8fl7t9+xMV7OIK8QUtCRccAbF4m9XIFYSBqFRIBaYVUbCP1kuSbg4pobQ85NwWyVfKBC/KmHl60BdaaSnndaA3dZAjjvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6820

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, September 14, 2026 12:13 AM
>=20
> > Expose the sampling frequency as a per-channel IIO_CHAN_INFO_SAMP_FREQ
> > to let userspace control conversion time.
> >
> > Each channel conversion takes a fixed 13 ADCLK cycles plus the sample
> > time programmed in ADSSTRn, giving a rate of ADCLK / (13 + ADSSTRn).
> >
> > Read the ADCLK rate from the "adclk" clock to derive the frequency.
> >
> > Claim direct mode while writing so the rate cannot change during a
> > capture.
> >
> > Program the sample time into ADSSTRn for each enabled channel on single
> > reads and on buffer enable.
> >
> > Wait for the maximum amount of time a conversion can take + 1 jiffy for
> > the completion event to come after triggering a single read.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> There is a sashiko comment on this one (See below) but I think it's
> in the category of things that we don't are about if a timeout
> has occured.  Please sanity check but I'll not hold series for that
> one.
>=20
> >
> > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> > index 0460dffe189e..8ba7b0fde8a1 100644
> > --- a/drivers/iio/adc/rzt2h_adc.c
> > +++ b/drivers/iio/adc/rzt2h_adc.c
> > @@ -2,6 +2,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/cleanup.h>
> > +#include <linux/clk.h>
> >  #include <linux/completion.h>
> >  #include <linux/delay.h>
> >  #include <linux/dma-mapping.h>
>=20
> ..
>=20
> > -	ret =3D wait_for_completion_timeout(&adc->completion, usecs_to_jiffie=
s(1));
> > +	ret =3D wait_for_completion_timeout(&adc->completion, usecs_to_jiffie=
s(5) + 1);
> >  	if (!ret) {
> >  		ret =3D -ETIMEDOUT;
> >  		goto disable;
>=20
> Sashiko:
> [Severity: High]
> This is a pre-existing issue, but does branching to the disable path on a
> timeout leave the driver vulnerable to a race with the interrupt handler?
>=20
> If the timeout expires and the hardware interrupt fires immediately after=
,
> the ISR can execute locklessly and call complete(&adc->completion).
>=20
> Since the disable path calls rzt2h_adc_stop(), which only masks the inter=
rupt
> at the device level without waiting for executing handlers via
> synchronize_irq(), could the delayed interrupt complete the structure aft=
er
> the next read operation calls reinit_completion() in rzt2h_adc_read_singl=
e()?
>=20
> If this sequence occurs, the next read could return immediately with stal=
e
> data, and its own triggered conversion could eventually interrupt and cor=
rupt
> the subsequent read, leading to a persistent desynchronization.
> -
> With a timeout we never expect to see I don't think it makes sense
> to care too much about stale data.
>=20

If a timeout occurs with 1-2 jiffies of leeway at standard CONFIG_HZ
values (plus however much time it takes for the user to read the next
value), something is terribly wrong. I don't think we need to handle
this situation.

