Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792801098;
	b=khdWbIpfPu6zvyVELdfQE+5KdrwotV3XfB/53kxhf+RAJp7KDNQFGAoHeDZajh2hgmHq
	 DbM/vIBgZee5iopG+E/eqeWqda257UQlBQW4fAHhw93wVs0qjfHu764FWHpqCGBTiv9Us
	 TBkKwk0nnhgLeRqRTKswypqUjB9SQmZv3UsVNeXysLE3inzmGdkaNAAbJQr/wiTi4gqCP
	 xAHyEmEBo2K+qG7kTZdfgS7gV7UU1gifIO9gLSTVXmW1r3GnHlspyhmGn4VOnCaZB808f
	 uPm1OgOXSyVOgTdLvWjK4A6q9hPQbVqBKy7ZYiEiVJOHFmkny9UPRS2lxvfscXCWFLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801098;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EZdW3jUk3a/RJ8HlAruKe6HbugMFWe1F0Ml0UfNisiY=;
	b=AA3Iq6qxsvvWWM4FTu4QVzPNWE0S2j8BLLhVEVtoQSapKGcTTIRpLVnoebjP+bq5BlOV
	 +HcRuH2VP0PuutbWTzxJGDjsBEAqB3cogqWRwYtON5qjDxn2MwqWQ4XgM/m9VaRqOHhq8
	 EGLH+TRwC0kFMEaPtTD7C/N4hdpSrf4/MO87Ce32SjjpAapMvehyT7S8TXenrZ1WlCelM
	 ow3pZ6Pl8DGmewMfQvrBZr6n2AXfd7RskNwjDsh7qhW94ydmxSAy6rZgeZcW9agclzMdY
	 vsNtMAArxxwdLl58f3WoIt9ZQe5TFiMUn5crA+SJghwlivk3KNAq7Rj8VQWBW2x0Jvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cNkJ8UuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.78
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013078.outbound.protection.outlook.com [52.103.7.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCF606A31A;
	Sat, 24 Oct 2026 00:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cNkJ8UuQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qamqkt8bdI1SZi4KUoElFQgyi5n9JCTttzD/97fZOaaDBs8jOB9T3mrHFAJsm4dlfzD9QG5q4iQ6SjaLi5xLV7i5AcKkZoNg5hhZOzHi+PQYJqSE9ypjB38R2Es5algaq+YeaPvUg1OulWQzMTEkF8tWCXJULuvi32aC0qHNxeRg2DY1eggw4ww9ft4I/6a+0js/iTYMz9WQmFZ9Bcp/jwCZiuMe6dtxOpjSDq7ltms/9eAohjmrzMKxLzYrBJJnxR6eAwsh4eBiOC/rs9xNtBrikJv7mLCCU9gM/jhdBtVomM1wEO7A2S/JEdOIrnPGHattYVQupKAOMvbVnBtbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZdW3jUk3a/RJ8HlAruKe6HbugMFWe1F0Ml0UfNisiY=;
 b=cHAyMPqwOylxykEWV0yv+4PdbkUMsG0qIiTCsstXfZG6vrzmi9jjV1bxt8E6cwmWyy8klEOZmQuC1YstmsGMzPoiGTgoiSS0Ukt+GwjwdWngo+HPI5p7mrIlCTIvoZQYfqNGzU6gnizKC2np5gaW9IqQyJZT/trU9IQjfDapugGCRoYRDUv5xApm0edK/cbgchZeWMTR5sUlh8Vq/jnU1LhWSGKo4EGiDPQqSzCvy3PcOvms15LiUTn01Ww1HyPLV+yUdxuUENDDA3HG/5e3Sqd4bzlDrf2u4QwM0AanwJ9JqlByv/Dp3Arj6GIA10OLN7tJUwZfEbo3AkoHg+vC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZdW3jUk3a/RJ8HlAruKe6HbugMFWe1F0Ml0UfNisiY=;
 b=cNkJ8UuQuBDF0CYnau3gHEPkcPu61UesT0jcoazgnQGwCJxe3CK+Ml/o/M+UqzNJ3ZOtibFGCTf64em0HGZLA1Gfwm4E2StAsrj/OpG2qv0Mob8L9VbWuBiiCbTLi+ZD4wgj2IKnZwu885tMHSFTUoqg4vtvTiWufasJ+eFQnLsuGg4VM9kXVafuHez6PZC+JNykNF/5GEYURJOKMFZFgENJPpOH9wTUD15hPVNQCuDMt/pepnu7tKql7igqAZ6hl9osdXekkjWBmgOEXmC3U0kiOIqbPMOUWIo8JET9GsO/7OiFellAzBlRoLbJA3M9omyg8/kYLvcuuGxtCnBYYw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 24 Oct
 2026 00:16:15 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Sat, 24 Oct 2026
 00:16:15 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Topic: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Index: AQHdYn7dNhOVhqe2dU2bRWG8P8EFvLcKcKyAgABK7gCAARheVw==
Date: Sat, 24 Oct 2026 00:16:14 +0000
Message-ID:
 <SN1PR12MB2528383D558744CCDA6FD56FA5632@SN1PR12MB2528.namprd12.prod.outlook.com>
References:
 <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040143.2e7043bc@jic23-hlaptop>
 <atsM8hUovBz_DaCp@ashevche-desk.local>
In-Reply-To: <atsM8hUovBz_DaCp@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2528:EE_|LV8PR12MB9231:EE_
x-ms-office365-filtering-correlation-id: 6d977bff-c290-4ec7-cd8c-08df3164045c
x-ms-exchange-slblob-mailprops:
 hnD4Fgoc1bPokEwHA1l2GYyEHUkO2myIrX8kMDhREvwIynrhwJ1ds3ZF3rQuBDb5ph1HeMFqWZN+d01CZvOq/HwnYvS1XAg3sYiCrybF+LGELGfsQNcH0q97+kqg2pYCSqKi9/xeTyxIkEEE8Lnz01K8AtDUmaeoyyhL/kaQyX02D3xFAd+QaDALkH5OT7jq4fZ5UA4aC1tu8EXr28se7Spj7HVSQmyJ6Ooltc3QbSaixeqU6sSIAfurXXJjjoHTiuJotG5hDQT20NsPfpY1o11XLY9OubRQ5wdUjKbCuAK2YE/r8j+xfm4CPo4na/iVz2RNoS359C6uef/nty4wseWWEfQpLMP+oBvRjmsPLOcmRoQ0vH8LXkKNpPzmG2mB5tRJ2UxcSqxvL4GwIlHdO97e45Slfko/FKGU4oUMK29+fGiC4Mf4WdjR9r8IuupMTFu/JliLq8u22QNmnjvmNKSDXAmuebomN3uWQ6SCagG0PaIKzGJ7y52KgbDNnUvnqeQOoffon2eBEJp0AJdK7XM0ISAMMJFOEf4VzAFd+zHIA6SNwusXK8POj5Zd1qJ0gnjbWERysZo41JG34OoqRlxkDlrExbYdU3Zvj2pbu+3ogJp5ppbzDSVhQ+SjQCJh
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|12121999013|24021099003|31061999003|8060799015|25010399006|15030799006|15080799012|24121999003|51005399006|22091999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NZbCYXj8Abx8qPXRZVckOWkVE2hYtvU+O2Vjlmz+mPG2TgT2FdLAMM3W7Y?=
 =?iso-8859-1?Q?GJvB5NbOK1So2cpTPM+0511c4IikkkYwN6PPKX24LAb+ummllOD7NZm+q7?=
 =?iso-8859-1?Q?FkrsQW20z265xICjX76OcyRPcWsraLWVp+xDUcL4CDTzfwFziRHI+Hir7B?=
 =?iso-8859-1?Q?OtcugcDkdY0BP/r7VMT8VOf250jiLXoaZwMmS5c4us+6aEW/TY3vQUsdLb?=
 =?iso-8859-1?Q?X0rAK7QqyEMI+cDoK5sNWRuHCYkiNZPz+0mxbR8ALfHbSI7KJg423iH2ch?=
 =?iso-8859-1?Q?bKY99twW9qi/8QRoKJiQ23oF2JA0vo6AMAbYJCn+wmosP4fzT9UcePLpEP?=
 =?iso-8859-1?Q?SmPoXNcEh3E+PpxrYfyfvYnTJVtUuHtIMw+AtnRE5JtuVsPsvlJoECksjD?=
 =?iso-8859-1?Q?n+t/vXiNH0jAS2xUutpcAD2c97CopzglNt00ACm0HzMDQ6WV2LyHU9+stA?=
 =?iso-8859-1?Q?agtXIIvhYnGBhQzPgG2YIsnw1bCIYFCIy+t22l4Fl9gBBL/tqo0wyfyf35?=
 =?iso-8859-1?Q?TSTMrG9S0h9qtXPWZsn59b2btSCS1u3O7LeRu38msrCYVHqC49C1qsUv0F?=
 =?iso-8859-1?Q?oqDFKSDj3XZltLwzoPg0LOaE61aH6XmL0XxUZp94TbA0JNBdXgY5Q0Eh7O?=
 =?iso-8859-1?Q?wUWJDpd2DzTVk0wMAqkpQVyNBoXsdeCGG3lDWNUEnKiXCF3LWQtkfy4utl?=
 =?iso-8859-1?Q?gkJGTtEZKPA16wW29heldtOAwZGzDk7cnlQ5FwPr5oTeXQchk0ICzFLb9X?=
 =?iso-8859-1?Q?QPXdbqSDlDcFzhgoW1vfZUMrwLG5dZc1dEL7l/j6yCBOPAgN8MHjaPdXnf?=
 =?iso-8859-1?Q?QdJDjKv+bNy1nptw9C1bKmtr2KgWdS5vwE+EjwCkLu3siXXY2moaQeIgVs?=
 =?iso-8859-1?Q?ac9rpg40cGF3HR9Lj5LVJv1HDIBQ/wHcNHs9q0GgEw4XrWDDPP3K/wFA5t?=
 =?iso-8859-1?Q?dLZmljpmUbEzJqn+IhCwJuQdtKZnC5hgT/hoPuo3hp6uzqculiTVl4fgS8?=
 =?iso-8859-1?Q?ex8cCezlMXno8phG0lr+Kk5rrISbj3DrnbFMBoLfU7d6EZPMZwI/rAVaXF?=
 =?iso-8859-1?Q?wF2zzY8Vna04ocWe1HnlXTigiWgYIgYr2CTbpy59NhTw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LGhM/WqJ7svbzRW1YUrLZht4VvZIHcCcGkyULqUWJuqqCqy6DeiWONN9dj?=
 =?iso-8859-1?Q?pESeTHLmV+cQtngBPTcmrCtgKdYVbO8v+bb7X48+PW/CGgfZzuI9xbzwR0?=
 =?iso-8859-1?Q?R3+KD/ajX5W1sw3RgCb/qZ8t58J6WweEFBNz6mTnSTaRwKhs94a+/3UoY2?=
 =?iso-8859-1?Q?MeJpC3XsEeHni1zMKQO/ezs2badwLHejNDKUEk+WVrEC3xHFf5BslbED6n?=
 =?iso-8859-1?Q?YsR99mcIZnFFyNxuoqA3Bv8qQolVLeUXvKkr9Hm4MI/BUHd/q9y1CA5exh?=
 =?iso-8859-1?Q?ZkH53jnPvImnhs5SASojT5zz4PkaKzF+JDplaa9DbmTGRYhsiNnzAEYOw/?=
 =?iso-8859-1?Q?leMnFoi2XPD3vcEhmAwnfdlt4bu0Zh2XjemKiknrLCQlG4EDaoWBOKYgwJ?=
 =?iso-8859-1?Q?Vtjrmz5qhlFOSL0dHoSdELLBRaRmWNdsnGavkyDaN+GkV/o708jgMValpt?=
 =?iso-8859-1?Q?OWp6wPENLp+0vjVtGaiZioQUlXszJgvRdrN2Kx+094ykjWUWuwQFsCBLim?=
 =?iso-8859-1?Q?FQpoTC93rjM260CoIMpEnCtKfRgSzVcIwBNK0L22+QDru1R6YmAK75pO92?=
 =?iso-8859-1?Q?gS2vbmwab059VqrE3mhhD4FPMxa8A3KPCSUu5VKv31+Z558VrQEtuEEcCp?=
 =?iso-8859-1?Q?OUup3FgUuiv/w03w2rrY4PfW7OOKoga+bt++dv4AXvL9sWDPmbnFJfVx2+?=
 =?iso-8859-1?Q?/QYApPhdHsFvJwTui3A4JNDe84TUhMtCj9PlWCyq9Ibj3C5NLGusjVLYWO?=
 =?iso-8859-1?Q?3vzSqUc23mCc+9bZ9jnNVNiQ6J/YioU/MZy7r6xnl6Sl/9ydEUSJ5v5J5Q?=
 =?iso-8859-1?Q?sb7RoNCI4BlZZkhc1AS7xsTb1qIW89qBQvdQHJDpEQbb1k1WQeP8QwXPY5?=
 =?iso-8859-1?Q?8JajNarV2kyXOJ0E2K4vkymlX0Ykb4tyqnpSsm8GrdR/A5+/ue15ezOp5n?=
 =?iso-8859-1?Q?3z8QDssgWxW5nFaXAEnUXOJ/xV7DiwSw8r17IorFw5Jycr0OD88bbddRCW?=
 =?iso-8859-1?Q?vPTmJc+ilhzj92nTnR8UQ6pcuhzXJ99sKjMWYYR8VZPAk6+vp+tfh3jgXU?=
 =?iso-8859-1?Q?fyz6Ge5PBHN3Ctdpb09iFUYIJ0PCzZN88MeiiP5IGVsBiM6NC/+cSXnwrN?=
 =?iso-8859-1?Q?FEC0baowX31w/nXOMcITmRbNFc5dAUXw3X6rRNgd/8HWGajIofJsFgG0G4?=
 =?iso-8859-1?Q?PtCrsY3V0EE+U5YWT8yTsY5nB/DNYuSVJO48hpP6ViYnEhN3o72I84JNN1?=
 =?iso-8859-1?Q?e9dLNMpjqBUuCWKmvc9ou8FXwJFGNaLwMkqkTaTDRZehAoT8DVC6ICoPPH?=
 =?iso-8859-1?Q?2Ewp052m98ECBJAVj3SYuVtH0hscfrsxe4EHPPFE3WMC9K8eFZguLOpRT2?=
 =?iso-8859-1?Q?jEg92T18qVWzBlUAtv87Xv5SLCiW/HDgRiXgDjbGKOqDGYQVDbqw4a+vNK?=
 =?iso-8859-1?Q?ZgLSBKNG2R8BCuO9EKqz7VTTXpcFMTbr0UoSdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d977bff-c290-4ec7-cd8c-08df3164045c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2026 00:16:14.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

> Looking at these data types, can you check if linear_range.h APIs=0A=
> can be applied instead?=0A=
=0A=
Doesn't look like they can, since they only work with unsigned int, but=0A=
these values are s64.=0A=
=0A=
> Why out of a sudden indio_dev->dev.parent?=0A=
=0A=
There are a few drivers that write it that way, I guess I copy-pasted=0A=
the first version of this function from one of those ;P=0A=
Fixed in v2.=
