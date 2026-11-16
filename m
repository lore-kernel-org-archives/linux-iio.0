Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794802881;
	b=NrDFIZxsrWdAvfClnSdyg+E9xQZuacMfSilvhM/PklQVRgtGWzrc7+ahm2tTLAap3oY8
	 saqdk7BwegHvoiUEQIl/l7LihOhcL5JSQQ/QD2Mgm646rpAtiwIP6SdRLuLzP1zn8Tizj
	 Gu/6GXGgZ6zApbq4cBm87kFpt3nnJHIzFM6Auyr0Iz1mzuO0IB3jUuK7+OvoIRR9mnX+o
	 GPu/0THAuBoqv7nsQe/V58pqvmJohAS172f9aT52HQgkQuuaoeLnvvav2CwI5GwBuykhQ
	 LA9pciPVcRxqM34AJUDTkUbUrPi0byGinc3jiRMRemytr+Mq9fHTnSZaQ+bs8UFXyUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802881;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UNTs0iudAk6johPXC22HjrNChEzWz7mPNUCIxBX/j1Q=;
	b=oYX8MO2C0XkDZYZKz3jd9x1VJ1oe+sBtkLkoVEZzv6MKwZqB/X1qBTEkm86dgcfEtRuJ
	 LlykfM604oFoN2G4CIoSARFj9fGOFJtvdy9lFR+xFNLbSOkG9m6gZR14YFwvoX6ponAJf
	 35Tz4FkY3uMBRtXYASvqTxppsyQ7Bkriucfiv7AIEyvXUYJh8BCCAo038MWQfw6yeOEAU
	 Oxk4iDIk8Z1Q/UhL+UmihIkD/5u59R+IOU4pbyR2PEzmGVH5ZQn3OHeMMmC/lSZHJIl6Q
	 smkhfeCN2x0qwPGnxAXh8sOTea0pf5a8eKgDaZeKK5c+JSvAf6+0Ag+BMqqmkyDVCcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PPfDXmqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48F606A31F;
	Mon, 16 Nov 2026 04:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F48F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PPfDXmqY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEwnOWAIEWRVAY9llrO6TMMJfxi7U4aSMhRDGAO3jpGyspOsFry1fkXGKEE3sYbGwbMGSsC7tNGVtOonBzlInDEnSSn3vTmaf67xCAPO+NE42hUDdG6IVcfiUo8J7Buc5QOsAY7eKgiw/6BgSWhqQF/pZb+sr5pTK85Z+7BK0EVmofQXAcd2bJSIuuQPjACj2bh+oBQf8CC14woYrHtFKpoej9jbCwhzckPNQTaLPhw8lECzuc/W4wOMiE2KHd0zFtNup+hT6r5CGVnjbfmnBSdKEwAUBcZkkrGZvylXP5igFx+2JqWbCjSqfxZ9ab/gETc9EIQXqWiE4bBRfzehqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNTs0iudAk6johPXC22HjrNChEzWz7mPNUCIxBX/j1Q=;
 b=R9nFfIoCoAkOf738V1o+BMX0fqXeBpQAjroK8CaKercW4YGBKzssi3H7upLS4cBgzLdklm9ZNy5+oFZcBotzhW75FpB67x22QME+zaj2KtnOP+PeWyQCxsnAzXky9NofVU6STDUjqD+vaiRMOOPoiqkxLzPM5GMrZlt4IddSBAET+XPsos4Cd4eMerM0PMuvyZnDllqob+/OSd7g7tVnu0/2IyXFDJszRyd79lTOYJuTkWIUfDlKT9haE7t5NDrVTWVSuQWWrXK6dGRRBUAxnPxe5fskF3WrUUlCQ5jQ6/mrvQsMPZNHYiOebj+6OPaqlU18o2GlLcEoIYvAP+6/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNTs0iudAk6johPXC22HjrNChEzWz7mPNUCIxBX/j1Q=;
 b=PPfDXmqYt4uh1E3uqISzzIzaZ7p670SYkozGB4Chof2ChpZsjaAwHyjaYmwwKo3xtFbvuseCqrXEP+zOgngM1kHCaCyxuIGJhmcLxywDSqXCeG94k2+5xoXim1Oibu8O3OWNzXiFscGuGKUTgIccc76LnraAe6JKsRpk6UEipmk=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:20:18 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0592.010; Mon, 16 Nov 2026
 04:20:18 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "amitrkcian2002@gmail.com"
	<amitrkcian2002@gmail.com>
Subject: RE: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
Thread-Topic: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on
 shutdown
Thread-Index: AQHdasTDSAdlz8iPsUOqJ3pxwY8M6rcjSwoAgAii2YA=
Date: Mon, 16 Nov 2026 04:20:18 +0000
Message-ID:
 <DS7PR12MB95038F6C18B71F2BC5073552DC7C2@DS7PR12MB9503.namprd12.prod.outlook.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
	<20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
 <20261107233244.63c35375@jic23-hlaptop>
In-Reply-To: <20261107233244.63c35375@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T11:25:39.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9503:EE_|SJ0PR12MB6709:EE_
x-ms-office365-filtering-correlation-id: 91a345c5-565e-4780-39fb-08df4398ebdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261102130727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 qPNrJWhB6PYCVCfNP9s0JSObH1ibatd7XfxxEy4DEOqA0UXNUCpqZ1FbfaYqRukY4MLynpnDq5txOE8JoaLPzk9so0svLEANVx3wuSaihJAjpYDtUkJO3vRIoZxpC02sjvUCGic8MH4pvIOv17QOupR4KzBhpV6mqe79op+qFbhvnaBC4wGOLtnVXj3euYYJ6pcsMhJ4TEIIs9GmAH87vdrUG0SpDCN7FlLUL+2S2S7OPLhrOlVCqjacihw3C4In/IDjI3ET+8JqlEs2oYFhM5nBb/8lALzqGEeqL5yj74ka8q2w3y8RDY+bXN/ACnifCbyjR+GoHw2hMB8IfknpHUs56FBbXxrS68SKV5W0mLgxllabM8F4I+tyVrP7acfMMdhJeZ/rXk5rH3bB0L3n4A0TdZDPOGMiOBYDaudfMoJjuu88YwFTqFqPmgrr2j35nGXbgUn48ZkFpyYJKN9WeC3q5R1z3lR3lmhX1WDJvQtdQKwhnVtZu7S2fT02X2mq/fS65W6cXQQxKCkIZQuF8Z8YhT2Gn84zshGP4WVMFxiSfQf7eaYR0feKgaA7RarIwiEH60BPSp1CeY8MLYpe5iOh/eGJPxxPhWnhQXSMWyasJ9I+8kTmfsHN+Q1cqkl+FR1E3qmLLT7DVPZP37ocJrrrswPBN3hy9fTYEFPlSShmyUagcfR1ZEWkbEEeaKQwfmOfE+TaJKj31Z59DiLodBGrgGzrhkbD34C/pwi8gYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oZpaqE/1/2HFYJyaCct2DAbEJaPm/JJuDIApPG5gMqJWJ2I4SmvZ+qMIav?=
 =?iso-8859-1?Q?sUvLnEngnrhwmF+07eTOaSqxvQxL1PB9+NNkM5TDZTCfrN/LSYglDYHlc7?=
 =?iso-8859-1?Q?it9Pe93+NYnohdBLHpA//qf/FdMtdO4XAvU4+JL+TSGa8ntCMXOqP24l5Q?=
 =?iso-8859-1?Q?CgrzKnZSfId3oE838/CbutEbW/8csZBe+04ymsdmlAuuNKgpcqmdi+fc8w?=
 =?iso-8859-1?Q?/BdmQkBWyUHNwFwjwMdCFSafeNciwuiEr53FXmCbisVqdJ4JojDxF0jvJ+?=
 =?iso-8859-1?Q?msj6pCEJDTatgOUTgelmx6TwmF+EpXItCmQ1Vy65MWHlLrngfBwc0+xPLq?=
 =?iso-8859-1?Q?EHt3hLQVHLet5os5Yv/I6g4P9qqGbnkC9PNGSQfRAmS/0vocZGFM52lsD5?=
 =?iso-8859-1?Q?Ik4efvqfT+lk7iXA9ULqS5Lo0rj/GggFi2GXGTJAd+bUXfwYQL2hhNiXuB?=
 =?iso-8859-1?Q?oivacHBRnYBlbi/ub+4mojIS8LRWLtwHulTczRpHMCrmMcdl6b/hOQn23I?=
 =?iso-8859-1?Q?KCr17u/+96pZGjUaQGoEWK/fdMg5eI/FRPjG4VWE0Y6xOyUASCTUxJgUrw?=
 =?iso-8859-1?Q?BdLxzeO9NLGf6xBYxM4oxAX/po9boW9NOI/jFSgnpQwDuWKnKggd8usLk2?=
 =?iso-8859-1?Q?XW9h9prRUr06rofGU/qnEgPaxhrcJOXX7X2+f9lTWljgFjzeXtoTcTJITg?=
 =?iso-8859-1?Q?HqgmUmKwdW3VwbTZoni6iGuyrVYHsrOxD67DesZyXPBm8Mc+aQCDyuMIMd?=
 =?iso-8859-1?Q?7BXyKw+CG55dycNIzS1M1xPMoZMqxvIxYJgbI6QR8El8Ai5dMSmyVZX9Ns?=
 =?iso-8859-1?Q?EN2uEzvwRCd7DUve2LW/6RAE9Kn3DBRCqY421lqQ873HtnJRjKMN4/civ2?=
 =?iso-8859-1?Q?pQubsHvbwVafIC7r82eFHYYWG8Q9v/MIHjHHNILLMINCiNVpJL3C7Sul3k?=
 =?iso-8859-1?Q?YabpI9u6fGY3J+H4ROJjBrM8Nkd/ybyaqWcs0SWrJvD+3fPeTKgTmG2jHJ?=
 =?iso-8859-1?Q?mokObTOwdS5X5A9nBXEAvIT7rzV1Gx4eIp56KebjjPQINptnRURsiSuV0n?=
 =?iso-8859-1?Q?+4/XI37Lw5Cx9S7wTWIGPAq+gGmlgDbfO1tuI47bEphQt/l+R8BvXcowL+?=
 =?iso-8859-1?Q?wwdABhK5wl8Th4MlJ/i6A1kja4sAS5oSSk29wQpa/3FSNmxQ3s76D6nlbF?=
 =?iso-8859-1?Q?p4EXyWtdJzm6PQhG+5Yszpa8bocFacbLk3XJjtvWZU7cnuCguTZiSRb0wz?=
 =?iso-8859-1?Q?zuH0MZ2Is8BUCuEX41qAoBAHBqN7oppdH9XfXByZcOqNP6NeeuzfKOnp72?=
 =?iso-8859-1?Q?xhS0xEDn0+D4GzWG7o/xBFELDjEEktfiLofdt1NF/5x49RZidcmCBJhdOy?=
 =?iso-8859-1?Q?RKm1gj+0mpjg/6WWbhU2qIcoRygu0FoEG4BwavATaHIbDK2X+6BJfqL5Jb?=
 =?iso-8859-1?Q?e06ON+GrDZSc/gDH4ecuOQFEgRgu4pS3JmGJYX+ZSX4JHS8yBA89JmgY/b?=
 =?iso-8859-1?Q?5W3omtUgoQDGY3eV49VEs/La9diDQZ0UbGG9Rt2awh+dhhT3jvMgO3wZdz?=
 =?iso-8859-1?Q?kdmO+Q5hRxpuMCQGmWTav/VuYE58/p/ORLyhIAIALBIj/SCTbCzEARJZUJ?=
 =?iso-8859-1?Q?McPyYKxB+pmY4YZTyiwVGaMYpKc/HbOaalfA8aAQB8HmdRvJPoiTuZqUGv?=
 =?iso-8859-1?Q?tJz74q83k5eVd82L81vyDlDHE+KIDR7uZwxAEc4jNLB+BzjQ9JkhwVMedO?=
 =?iso-8859-1?Q?4O595Bvrb+iZYD/duNxlMhfMMDmvfOnZyVkX/U389KgHzQ?=
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a345c5-565e-4780-39fb-08df4398ebdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 04:20:18.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+lpRVfT18YNIewRbJjK9nc0wLEZXPH16RMD4l0O1luI1sKv8OWnGqo/JpEUc/drapkAdxd3L1Y5mLGAL1Cz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

AMD General

Hello Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, November 8, 2026 5:03 AM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: Simek, Michal <michal.simek@amd.com>; Potthuri, Sai Krishna
> <sai.krishna.potthuri@amd.com>; David Lechner <dlechner@baylibre.com>; Nu=
no
> S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-iio@vger.kernel.org; devicetree@vger.kernel.=
org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> amitrkcian2002@gmail.com
> Subject: Re: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on s=
hutdown
>
> On Mon, 2 Nov 2026 17:51:09 +0530
> Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> wrote:
>
> > Interrupt teardown is registered with devm_add_action_or_reset(), so
> > sysmon_disable_interrupts() runs when the driver is unbound but not
> > when the system shuts down: device_shutdown() invokes only the
> > driver's .shutdown callback, which this driver does not implement.
> >
> > The device is therefore left with its alarm interrupts enabled in
> > hardware once Linux has stopped servicing them.
> >
> > Add a .shutdown callback performing the same teardown, so the device
> > is quiesced before control is handed on. The helper lives in the core
> > module, so it is exported for the platform front-end. It skips a
> > device described without an interrupt, which never set up interrupt
> > handling.
> >
> > Disabling the interrupts at shutdown is safe to have and not a must
> > have requirement for shutdown.
>
> So what is disadvantage of not doing it?  Otherwise, why have the complex=
ity of
> doing so?

I couldn't find any strong disadvantage of not doing it. I will drop this p=
atch
in next series.

Regards,
Amit
>
> J
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > ---
> >  drivers/iio/adc/versal-sysmon-core.c | 19 +++++++++++++++++++
> >  drivers/iio/adc/versal-sysmon.c      |  6 ++++++
> >  drivers/iio/adc/versal-sysmon.h      |  1 +
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/iio/adc/versal-sysmon-core.c
> > b/drivers/iio/adc/versal-sysmon-core.c
> > index 6595d07038c1..d39aaba9a8b6 100644
> > --- a/drivers/iio/adc/versal-sysmon-core.c
> > +++ b/drivers/iio/adc/versal-sysmon-core.c
> > @@ -1000,6 +1000,8 @@ int devm_versal_sysmon_core_probe(struct device
> *dev, struct regmap *regmap)
> >     if (!indio_dev)
> >             return -ENOMEM;
> >
> > +   dev_set_drvdata(dev, indio_dev);
> > +
> >     sysmon =3D iio_priv(indio_dev);
> >     sysmon->regmap =3D regmap;
> >     sysmon->temp_oversampling =3D 1;
> > @@ -1050,6 +1052,23 @@ int devm_versal_sysmon_core_probe(struct device
> > *dev, struct regmap *regmap)  }
> > EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe,
> "VERSAL_SYSMON");
> >
> > +/**
> > + * versal_sysmon_shutdown() - Disable SysMon interrupts on system
> > +shutdown
> > + * @dev: SysMon device
> > + *
> > + * Interrupt teardown is a devm action, which runs on driver unbind
> > +but not
> > + * on system shutdown, so disable the interrupts here as well.
> > + */
> > +void versal_sysmon_shutdown(struct device *dev) {
> > +   struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +   struct sysmon *sysmon =3D iio_priv(indio_dev);
> > +
> > +   if (sysmon->irq > 0)
> > +           sysmon_disable_interrupts(sysmon);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(versal_sysmon_shutdown,
> "VERSAL_SYSMON");
> > +
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
> > MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>"); diff --git
> > a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
> > index 529d0486c9f9..4d5e3d14cf15 100644
> > --- a/drivers/iio/adc/versal-sysmon.c
> > +++ b/drivers/iio/adc/versal-sysmon.c
> > @@ -71,6 +71,11 @@ static int sysmon_platform_probe(struct platform_dev=
ice
> *pdev)
> >     return devm_versal_sysmon_core_probe(dev, regmap);  }
> >
> > +static void sysmon_platform_shutdown(struct platform_device *pdev) {
> > +   versal_sysmon_shutdown(&pdev->dev);
> > +}
> > +
> >  static const struct of_device_id sysmon_of_match_table[] =3D {
> >     { .compatible =3D "xlnx,versal-sysmon" },
> >     { }
> > @@ -79,6 +84,7 @@ MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
> >
> >  static struct platform_driver sysmon_platform_driver =3D {
> >     .probe =3D sysmon_platform_probe,
> > +   .shutdown =3D sysmon_platform_shutdown,
> >     .driver =3D {
> >             .name =3D "versal-sysmon",
> >             .of_match_table =3D sysmon_of_match_table, diff --git
> > a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> > index a1ac3289719c..a21dacc13471 100644
> > --- a/drivers/iio/adc/versal-sysmon.h
> > +++ b/drivers/iio/adc/versal-sysmon.h
> > @@ -122,5 +122,6 @@ struct sysmon {
> >  };
> >
> >  int devm_versal_sysmon_core_probe(struct device *dev, struct regmap
> > *regmap);
> > +void versal_sysmon_shutdown(struct device *dev);
> >
> >  #endif /* _VERSAL_SYSMON_H_ */

