Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022100.outbound.protection.outlook.com [40.107.75.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A03F9C0;
	Fri, 20 Mar 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977590; cv=fail; b=ohFyU5YXj1BCBuUNOF6IkJ83FY6MvV9KwwrKRXy/BrNL6/93IHoAlcH77bPKh/MCYw+UB+6yxt8y0rMZMJSq/0dwAe6J9t+CVXAoimcAGLTEwUI7Wl7SOtSKmeVfVlsWTipTbMqKiesORoRkq6vFVGmVxjSeL0tv4OtIbnEpvO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977590; c=relaxed/simple;
	bh=RJ4yDhsf33R8zGcI/QMYpHKSM4zD1hnqTpzkwQ0yRXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzazaldZkghmUSh9jvMkv2H+F5EsPc1vpDi9ka7PfXb209MKGfPrVASIosHSHjBpz39cjF8AKdF+eINvUhn4WPX6m3scle6yWjnOQ+06p0txZN2woUM4E9V9vYRy8Bt1rVchYXTSzn32+VAoWcdZBqKujdmgMCr8T1jVBInO9/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=OyVDiIbv; arc=fail smtp.client-ip=40.107.75.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="OyVDiIbv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNeX8xnU4Kf6ZV++AWZu06XZdb0NHVlY8lhFJInYc7q3SdiIPMQ6IEwPWBfDgSQ3OVhLutj+LnLuDbzAXuw3Vv0EoKI6t2ztwMr9Pvu3ieUHeHxrkDxWd/r/3jDVpqAbbHBZG6XUUworDfrvVOnUB9C1u6Yx5qWuneghVAmdDnglnnbBoYMRI4o9FrsS7ngY5gnOGq1d55QsgQ5hsYerHVcQyO8XGkJF6vwOGIqZQPToyK6BSX+cBUn9ydwL+8de0CX2vYAxOuxr7Yf8UJ9vriUtA5Hu6AJtpFOBdpnWH3+r1MmgdHyRZrm8SiUicqPdzWATjkRDSoKHcHSICGN4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CkcfJrv4N8MX1mKNBxtQfkHCUW1PvIv43Zu2mrHQxU=;
 b=kJXfnDciW7DcCJ/eOZ8IgDtj3Wi0g1y7QmI0zZ96ARs3PeeAunaxjGESb5qaWBuuzntTl40MpQC5aJDM2o05PhuWo4ok2sPr5VwLJtVTtDMtxBkMBYlk0NqbuUq7drWXexY+lYqepGQEF1Hq/b2FpCvQrhccpK2QwaZJ1dvhAhe9Ymd9a6nGQDOg5pYekXcReV9UeMYZafJ5OH3fnHWSLz/iDMenhKQKaYv7/JHD6h0EAPx+mFNEXtyl2/fFyGVxwpJTgSvFm/FukXWTmGyY+W7O26/wPlZIdwWfuhSqfg1EikwPa+7tzkXvtqkDP0rVTFrPOcK7nNk6oWoE15hVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CkcfJrv4N8MX1mKNBxtQfkHCUW1PvIv43Zu2mrHQxU=;
 b=OyVDiIbv4ifRsYyxvSQE1oR7nUgdFSCL0z1rz57/fX30oKrtP/1BNCdmBQ7vDneFA80N6TG3Lk09+Hbg+mc4Cu27Xf2EHI11WSWkWY8BHYi+j2SFbVSSPJzL34bVVcXBSffAb18G5MgYZQaR2pKJYtwNUnCrfPV550ir7WJnRu/6s+RCwDCUmonBzcxgr2/+Iuf8zDopK9dWErNwcdja6t+SVzGlzWP6xyNTVl90K7a7s8hr2X52mc6oJcQ3SnYhpwnVRsM+8/EU24y5+NY70Hwgoaz4mprd60YLl4jtU5iLmxnW3SMxWdvBdktg+ONZmL251xvVntgivsz4TKAobw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by JH0PR06MB6438.apcprd06.prod.outlook.com (2603:1096:990:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 03:33:04 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9700.022; Fri, 20 Mar 2026
 03:33:03 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?Windows-1252?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Morris Mao <morris_mao@aspeedtech.com>
Subject: Re: [PATCH v2 2/3] iio: adc: Enable multiple consecutive channels
 based on model data
Thread-Topic: [PATCH v2 2/3] iio: adc: Enable multiple consecutive channels
 based on model data
Thread-Index: AQHctPEbKhISDEZTck+9P/6F6B0ZCbWxN5QAgAWOuz8=
Date: Fri, 20 Mar 2026 03:33:03 +0000
Message-ID:
 <OSQPR06MB725298E227B8A563B95D66378B4CA@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
 <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
 <abgS1lOoEO1RTe9X@ashevche-desk.local>
In-Reply-To: <abgS1lOoEO1RTe9X@ashevche-desk.local>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|JH0PR06MB6438:EE_
x-ms-office365-filtering-correlation-id: 04ce9ce0-89c2-4c39-01ff-08de863164c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 y8Gf2lJTFnZU0LZR5tVk8rBRElji00QUVvVIFWsI1pjvLETFyegzcuNDxctlR7Ey3iopbNiV+5osYkdqAzxCzYBPQ0Noj0j+59vM+1T1RVu+EltdSKR7UOtrWoU+KItFJ9N0GKyFg30cBmGL7WRqaju+9s8h7bdft9i/AUcMBVqy6BihxlA7WcwJ1EAv/SSlh21EwE0f/zuxZqnK2qa6VlTBMExl2Kt3covynVNbkBYLX0byC7x95VHdA9pu6AJwita/iWUn/n0m08PNB9VIIH7LXpBOxUU84SI+9sRheRVwDEnl54oNAOLJvjfLUzUnCqiW3WUKPd0AUgKhoIxfaKDkQlJ/US1GuCgBmjRZOgPJZtNdjyVwBw2VJEqNEHjx48RtSEPEWBzEOTeoFeEBoXOrYNuMg6rr3g4TQH16IlY9ck9389IHa3Q29WAPYPvgCkIH/8qjiJMIpfMMzAzfiRaRpwkCFDeplD1TWY67y24yH9bCJVxQ239g4mp+CU/j4IWrop4A3tqxBU4JfLQBt+adMAQpPT3srP6lLtxiqT0SuQvyXGIPUlvIiDQwPxcVhtDgzEV3GlvdbcNSYfW3pQkRytPDdz5H28MgyPRNZyfFkzZFddGh6qV5ydwUjNVL6Nqn7nN5oiv8rxPtxE7tYE0C+cczOD6QD4RThVeFFJFBiZQMw1IVKftnKxoEK0ab1xb2OwLQcs9VVbrT+lx9XbesjAMx84PELKA/lNv3KRiVbkYCWlKxMxd5RO0LgA9UIA4Jjyd4CU/9PorD5rY9sjXqWCZfiEMMC3ozb4JQeJM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?4WUgMOM0R/eov04AOPiPFYJLK1looi36I6kW6AahGfbA52YG556MJq0f?=
 =?Windows-1252?Q?qSm98CRGxJ298oucY3GkrLJMPlgtFYm0mC9S44Ao2hT3qX78sNld3rjs?=
 =?Windows-1252?Q?ECE1X1iMX/GUJd9cHj3pIlP5Hm0ffSTB0UgYtztaO/VTne/wif9TG2m9?=
 =?Windows-1252?Q?RJlG095Lu96Qi+aII/Uo0J2lSBJtt0Oj3D5ZweYIiGPisUBIy+FU+WRw?=
 =?Windows-1252?Q?4gf1G42mK/ApzXjvfSSzoPzevzWudcwa9iLhNsq5NmTijbEJ3R9cS1mR?=
 =?Windows-1252?Q?PtdOL9hJZ8J54/Sm+UvXopKK9b8lWh0Fk3ehbhicBKj2QLYkbKYl0rkd?=
 =?Windows-1252?Q?oqbwA7k6fDAXj4PJVxqh/VWAI4z8kM5UqfqMiLHMCzqnUYFXXvB2I6UA?=
 =?Windows-1252?Q?alJfY/X0zGFkBtXVweS6pAyhfi2cdVBFy5W1C6WaEpJp3snTbROrWfyc?=
 =?Windows-1252?Q?zOYNnSdZekMCgxFQrOJsr9SmSdlk7HBqr2h+ZYyxn6VLINNtVadM/4gc?=
 =?Windows-1252?Q?c0MsT0JqLArfLGCZ8kTQNdADSAHCmp7ZxD7P7yzfTCWGR4tRB0BUr2pa?=
 =?Windows-1252?Q?0y08VSV+38o2GZZSjZZuMR8I6NbangQeuL6Gpz1/It4zO6IsLwkBI1QF?=
 =?Windows-1252?Q?A365+ummIqD20jGdiCkxuQlIASmpIKARyXlALnMZRIYoB8zR3R0v+uHk?=
 =?Windows-1252?Q?R8J4t7zmFN7k0fvk2L8uv+0NMXsxFEIG05xG26sMQsNSIKVvlNV7D+Fn?=
 =?Windows-1252?Q?LzuQa4ZyiTo87VK9F0zIwEbXxtPCzrf5XPu3i117UlZM+xRW3FBTGmiz?=
 =?Windows-1252?Q?YuU5UjKAyyDjisn6Pj/L47jId4BtVduK8rpqqoSEkY+e3G54IZbWvmZs?=
 =?Windows-1252?Q?WPrVNyVZ94tY7eYsrAst7z4Xpd6tyCB/clA0PO9+BIEfaBC9IFNIS0rq?=
 =?Windows-1252?Q?qR6jKTdjzSg6ozLSLkuONHtvX8UUs6vx9drakWyPMUd/SJQOSGSKG7ww?=
 =?Windows-1252?Q?EzQokELUlU2AxIp4hXAtgZ+ohwmavqPIDCEPZCVUlq7oLDTvTTm4OP46?=
 =?Windows-1252?Q?bbwJoLF2pI1oJgjqf4mVw9BqqmLN5PneK8kVd/BywKrUDQS7bLASMI1H?=
 =?Windows-1252?Q?hPtjgzcEkAAfeG5tUzPBZjeKUdIfIOwOupe3l+tWVddzSs5h2pBZa29f?=
 =?Windows-1252?Q?npEYytm1+nuLYQU/VKVZbmLTj44GqiQm6krh+LbC2L//BBkuWaZepFan?=
 =?Windows-1252?Q?C9cU5fTV77ErV5ItE3TeV6kf6iyJBcbyC+Rvs9ZklZfE5cYPFu38wzma?=
 =?Windows-1252?Q?KzQ8D8vrpjk13MMVr/61MNhSUtC69n/+tqwcNBV+QIg9heY1IQBOEieL?=
 =?Windows-1252?Q?9jVnz/bIqwjBpokTDIAquIw87rGm32j+w/36HAdc5BvXOBkIhAeLrXPr?=
 =?Windows-1252?Q?Uyz5eCx200R2f1GDPwzDzUxmNFusTlYOOcqup/8maBOXLnZUGcPPZGwt?=
 =?Windows-1252?Q?uLiODICtXcao5+N4aidisz/ltYvrzdd8OFV3bivKCoam1yR1FKMDzkn4?=
 =?Windows-1252?Q?WEei326TVScLv/pzoduot5Wf7g2+UYv68vvieh6GzW0m8oVauoIOPkoD?=
 =?Windows-1252?Q?hMxcIktXXmp6xmnA2FlVdLIS7hQ6EXVZpDHEhnNgqFlDpheKEbt30ETj?=
 =?Windows-1252?Q?da51XIYNEboxJqyfqjOvlZce0Zgriva41fDxpF8IPyW821vbovnpI0JJ?=
 =?Windows-1252?Q?UfR4lCV0n+ir9UaKPlasQQj0mmnMJqUAxrUXOppfb+5+Vi04NZIToLyE?=
 =?Windows-1252?Q?vVkJhTdAhdYDqQ7O4pLLGls+3i6PiH8f5jRZwyiiUSPoAWywr0Ov1uB/?=
 =?Windows-1252?Q?GNp8MRAeP4Bygw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce9ce0-89c2-4c39-01ff-08de863164c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:33:03.4103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hn+ByMwdpHiUIQ4Ven954y2aOZWLHuFiWfda/YnV+OcnGqlFoDscMF9o6Jdym0snzyo609hf/12ReUHSgkzQhC8eQYqagN7OVNfJ/0c7FV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6438

On Mon, Mar 16, 2026 at 11:00:47AM +0800, Billy Tsai wrote:=0A=
> > Add helpers to generate channel masks and enable multiple ADC channels=
=0A=
> > according to the device model's channel count.=0A=
=0A=
> ...=0A=
=0A=
> > +=0A=
=0A=
> (1)=0A=
=0A=
> > +/*=0A=
> > + * Enable multiple consecutive channels starting from channel 0.=0A=
> > + * This creates a bitmask for channels 0 to (num_channels - 1).=0A=
> > + * For example: num_channels=3D3 creates mask 0x0007 (channels 0,1,2)=
=0A=
> > + */=0A=
> > +static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)=
=0A=
> > +{=0A=
> > +     if (num_channels =3D=3D 0)=0A=
> > +             return 0;=0A=
=0A=
> > +     if (num_channels >=3D 16)=0A=
> > +             return GENMASK(15, 0);=0A=
> > +     return GENMASK(num_channels - 1, 0);=0A=
=0A=
> This entire function can be folded into=0A=
> =0A=
>         return BIT(min(num_channels, 16U)) - 1;=0A=
> =0A=
> Or=0A=
> =0A=
>         if (num_channels > 16)=0A=
>                 return GENMASK(15, 0);=0A=
> =0A=
>         return BIT(num_channels) - 1;=0A=
=0A=
Got it. I will replace it to later one.=0A=
=0A=
=0A=
> > +}=0A=
=0A=
> > +/*=0A=
> > + * Helper function to enable multiple channels in the control register=
=0A=
> > + */=0A=
> > +static inline u32 aspeed_adc_enable_channels(unsigned int num_channels=
)=0A=
> > +{=0A=
> > +     return FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, aspeed_adc_channels_ma=
sk(num_channels));=0A=
> > +}=0A=
=0A=
> > +=0A=
=0A=
> One of these (see 1 above) new blank lines should be rather added in the =
previous patch.=0A=
=0A=
Good catch, I=92ll avoid this blank lines problem.=0A=
=0A=
> >  /* Battery sensing is typically on the last channel */=0A=
> >  #define ASPEED_ADC_BATTERY_CHANNEL           7=0A=
=0A=
...=0A=
=0A=
> >       /* Start all channels in normal mode. */=0A=
> > -     adc_engine_control_reg_val =3D=0A=
> > -             readl(data->base + ASPEED_REG_ENGINE_CONTROL);=0A=
> > -     adc_engine_control_reg_val |=3D ASPEED_ADC_CTRL_CHANNEL;=0A=
> > +     adc_engine_control_reg_val =3D readl(data->base + ASPEED_REG_ENGI=
NE_CONTROL);=0A=
=0A=
> > +     adc_engine_control_reg_val |=3D=0A=
> > +             aspeed_adc_enable_channels(aspeed_adc_get_active_channels=
(data));=0A=
=0A=
> Why not FIELD_MODIFY()?=0A=
=0A=
Use FIELD_MODIFY() for the channel field update is more better.=0A=
=0A=
> >       writel(adc_engine_control_reg_val,=0A=
> >              data->base + ASPEED_REG_ENGINE_CONTROL);=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=
