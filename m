Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794807780;
	b=d8yM0dUzWyjP3X30i4GYkqr01A1bfGAbdUMGMbkJt7SaKJdWv3wiKH7LoGFKvHqQU3Hj
	 qxrJZ59kOwcbnZGlHLStEU5KDBEaNZHHfwcL1J3XtioiksqT5/olyqZunLdYWWSFJ9sI7
	 ev1hE3IX1q2iOJV8GkwarikPNB1alThwuud0454/Ts7t288OTwO3gNGQn18agpoK/WOLh
	 MTAbl+7/e7Zj0jvXYoTDx9o3nXefgBEK9VlnqB4e0ZVe9eMaTN71pWlpFPr1xuXaTCoFM
	 jXwHtbYjDmkGFOyxRl4lBtBdfm9w/WgUYGqawjeTyxvr+cg796Sq+ncE9S7kLkIuXHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807780;
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
	bh=/faPbPQDTSu5SBAWkX3/Aklyx2wTGowClUDJOFcwHm0=;
	b=ekOMfKbzni0BMJFjLawTw7Ut1+YQu7SLptjhjnj64ABuzA7WqYF3oA+7Q9vRhL3vZKzV
	 pgGccdAxlUW+31QhiK9zLZoANM9co+iIGcMML2f/qE+JqVJequB5hi5BAYvgrkTRsp+Hh
	 DE3LRNd290MHu2lutzBxZQyMKtkLzh4psFAjpaPhUYJhjwVHBLv6k9ix3JqPsg2bez1TD
	 2YJvaxfaLcgsgiav+EfQcOeC7zgoXxXgQ0pbyJMJB7LvyPIVWNQKiDRkChtsj78MNcWhw
	 fGCvUIwrE9xTZ0kLT7mleqAdN3JJeg08HeBJf3JqNmOGpNiuVsud9vl/Vu0eSqCPHRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mAAfJmkT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.65
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C6606A31C;
	Mon, 16 Nov 2026 05:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mAAfJmkT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4WCiiTjoRJA9+ULSwepawyXDIuamBVEyRsCv8VKruIyoGTiVrfPmFK4+yOhQSpniOIWyfkVNd5iWS3PDVBTtVQryoW4PeGwu16lciMvt0gDPRxIR18v5YBFo0egRndkLu05giXAYJ+zEHUViXmL/z5B6QHdN9FNa+BbygZ0FTyLR9++zlXujn0s3YXDs2JWGxTM1LgVgQ+6wHN8XMjPbX7gPeKO79JZj39ET6y/yypGLpa/3F24TyUvfiHu0YmKyjp3j+7vEZ03BNMbnXWKC2OsXtIX9KpAgS66VsnXYgv79Tj+kYExDRhhQPR7BRKDdGI4SAA2PcuXoacmI59+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/faPbPQDTSu5SBAWkX3/Aklyx2wTGowClUDJOFcwHm0=;
 b=waj8tv1n0NlSz9vuvNNEUfFh0s2K9sDxCrYv/RQ/vTzII0w5d8jCS6Lv1hN5U1l96tjG2kscM19fEEk1zjHV/cEwS93Oy+oCBhNbR2vQ0hSqImOynbX0YHxlm1SJbwN1Abfqjf57Cmo5W0nvUTBOeaRx2q/T04cbeKl59o+u06hbZsGIwZL6cpJO78hi4z6aJk/FNsbhgZFAzFfDYDDQ6DEq3rt6WW81e53+OJEG1mjQgiJDxbt5ICZrmEMHcDakTnIvJb26NsIV4m06W58lxPlto1zUMDDBzGWqrHO27uZSdw9y/X6nZaJXUW8D4PYquzPAstCbQ/ECd04GW+M34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/faPbPQDTSu5SBAWkX3/Aklyx2wTGowClUDJOFcwHm0=;
 b=mAAfJmkTbrt7jIk4QcuefRJ7Lke9REzzi88y3cL7sthn+HoO5cIYlp34pw4eKjMFYGs0ByEFkw4JpOztUS1HRH+Xb223cq/1Z+8BMTRXKdrdI4K3qCltbZGEmcUSvONxHxnE6ctgADzG/Qg9al0kpVr1TIuu9DCmqsFFl8ekKZQ=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by DS4PR12MB912252.namprd12.prod.outlook.com (2603:10b6:8:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:42:57 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0592.010; Mon, 16 Nov 2026
 05:42:57 +0000
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
Subject: RE: [PATCH 4/6] iio: adc: versal-sysmon: add over-temperature alarm
 events
Thread-Topic: [PATCH 4/6] iio: adc: versal-sysmon: add over-temperature alarm
 events
Thread-Index: AQHdasTDCATWDqm4wkmL9KJvnrricrcjTgOAgAzxiPA=
Date: Mon, 16 Nov 2026 05:42:57 +0000
Message-ID:
 <DS7PR12MB950372357A9D1D0FCE0F6E01DC7C2@DS7PR12MB9503.namprd12.prod.outlook.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
	<20261102122112.1723130-5-amit.kumar-mahapatra@amd.com>
 <20261107234323.0aef5ae0@jic23-hlaptop>
In-Reply-To: <20261107234323.0aef5ae0@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T05:22:57.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9503:EE_|DS4PR12MB912252:EE_
x-ms-office365-filtering-correlation-id: a415eae4-3ac0-4d89-735f-08df43a477d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 3VAJ7sCVaWjSybpprOu5TQuaLAM5j9V+3fMLQf/cn2I83KYwvecYrqPo/tH2YieMdKv37MjO24m8mYGl6K71aYl1faybEykx6pkGf6Ie/K+A9S2fYBknFbZvUpJt+9T97vB1wB5QlJ39DP/1HOIcGmx1xInI+vufIsqoZnsaeulFdv9MGS37ttGBrGOq4eenlvTUFdGn2e1oWkY0KHBJ7zBG1dv0J7xYfnXjfrZ5RF6n/DJc+jSQKzriBqBNt6yA7vEahKDZPtaHcjy+NpTz1A+P70hFErbm9Mpp1qYfk3Y8Xn3BuMhcFGJzCOPeZFo+nr2d6zkrlkylFVqHxW+cb0k3odqW210KwYjnZTCMB6mTKSvEX3MSEIS0owswGm+sTD8R1lBTKRssgFLcMAzltpxODkaXSPXEXY5mpYX07Oa8m+iSuDcAWbBnCK2winUhzm0B24qbkpn9zyW4FrqEDeh8lE79JZile5SgkResk9yN4FIsfynzZZ5gHnZBf7emnZJgHekdUMrF2pU/oNDDIwvzr6p/DqpP9fna3j5HzvjVZQBrruJTW3RW8bg2ggooVUHK4arHmZkuqbeYqm5KQBDPHramoKOEF0AaBYaLOgC3PkRNbV6CJ/rV1qbPgeOeige6EWscs2zFKnyoEcUu5ckFZLvqivpjLxOZujLMmHTzR8w18fxneDnQX30wIWCTmd8Ugq8JMdPT6u1PEnZ0Xy6YURdLHdKe9lBO2sU50s8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jrxRJMMfGNZmYNdtLasZysp5NJ1MkdGv3DH0hBgmxnFkqF+U+exOJeJjFm?=
 =?iso-8859-1?Q?3x33oWdPE0gSV6ki/rbOV3evKRB6HR0XfkzTrFhuA4SDAvGaaUEuKDkKa6?=
 =?iso-8859-1?Q?xrFfvG/Wfh32+4CicxeD6JkXl87XJWQ3dLU/RqpQFB2TmYeFvgfpZbgl08?=
 =?iso-8859-1?Q?5Ibo7SBa5nRnY3tNYIOmEVH5q6tvyVzJj1KjicABQ6DiPPhrVWNyfEwZDm?=
 =?iso-8859-1?Q?O77xdXSSlZV6YDM0Y/gqiVcmg31V9GBFa07v7LJJhRlw6vyrCTUoIGgauh?=
 =?iso-8859-1?Q?AWXXsJuxQOqf/ugQVOLLljVwzZWysQywyS54f6s3jxmp2rIjoYh00gqAbM?=
 =?iso-8859-1?Q?5iTnquLLMJzE1HM5jgk19jnZjmUUAX5zK6FBPGiXdCyuR4gIahFUPufX8z?=
 =?iso-8859-1?Q?VQe2R9/Oi8hnNBvVGd6GbpAKa9TeENu0bu1yXgbQJt27rllHP9WCeS7s6P?=
 =?iso-8859-1?Q?LugaZrIUwPEjHuiM7yYJzX7JphhCts6j334tSYdPCNYcqTt8MKTDWJHymf?=
 =?iso-8859-1?Q?FEjqTu1Mae0g/lBH2ogI6gxoPUQc79PoM7ntGJpPy/LrzJAExbZ8oILkMH?=
 =?iso-8859-1?Q?VOq/BMUOucifN2WG6th/fW4/WvG86mua6FnXLYvFQwso7V7mbrOjELcR/9?=
 =?iso-8859-1?Q?OU0hAXz+sUp8aFJPQ5K2YOOfkB+vxJmSVCLy+2cggBa2xhl4HdIPIjE8i1?=
 =?iso-8859-1?Q?xI2gfDFupdPFxY4M1XMeFk0kiqzJTe6EhIxiidLPAXjFX7bGJ1SPRtwBND?=
 =?iso-8859-1?Q?bJUKiGOrs5b48uCH4MAgohSAvMpimuVOLI2qjVorWx3bbovCiJOtQU7S49?=
 =?iso-8859-1?Q?Oy/MCk3Bxh6M0Ya4W9wGxii/5D+HD/SmajDj/x0jDSZL5KqZ6ZEihfNXMy?=
 =?iso-8859-1?Q?Td9u1O+ePetdbiuMFsFPNplgePvEUB/nXMk3AZ3GBEnRb3AjtJjZ9RTJlT?=
 =?iso-8859-1?Q?pvJE281B2+q0S+F8Z0wZZfRonOEnsO8MW8v6Rc1/0SbhMzoSVyAmJdqQbg?=
 =?iso-8859-1?Q?8hbUjTqCmQBglla6K83dwKTmn/AdLFiwn0RBYXkKihutrfk1V3ezW6f7aW?=
 =?iso-8859-1?Q?UPPGfLB6hrKYZRioxCypXyzHyDn5g5+qirMbtY7URd6Bu6J6XZCxA1z4Ez?=
 =?iso-8859-1?Q?po/F1ERIMC1zurZnXyr1R4VmdMgA2MpHUp+wCtZvYUwhpG/CTO5tYk0tJg?=
 =?iso-8859-1?Q?T0XY8ERgYl+sxwO0XMLbD5uBEDYn/a40k0TomXvrCm2qNbVkN1d89jhA1V?=
 =?iso-8859-1?Q?PU6+7QjXPhL4n5FgrziRtry3xKQElOVvXxezjgXRtwAjbpy33Rp+eajHHk?=
 =?iso-8859-1?Q?iiaK4vPV3Lyn5wkx/7fnQNzqceV121tCpWeloDUyD6fhclRRiZ4PiaAaNV?=
 =?iso-8859-1?Q?ulVp/V8LIEbrPxBAsMPiIstcMlSloTH60cnraUmY44a+2JIXuSX88OluuQ?=
 =?iso-8859-1?Q?VzCEBmEPVq0HlupPsz+Z7/7vx5U3L5wa/MSIhSMhKdP+9SOLPVGD30H6HN?=
 =?iso-8859-1?Q?47eIBgPlceloy24qh053Zh2meXf2jEgFYbERWdVHuCwKSasXX/zPSicJvN?=
 =?iso-8859-1?Q?KiP04waTlj8QzSyHPydX/fHgKEb/ZOiGknRUYXr78JXiwAIKzwyAnkFlVL?=
 =?iso-8859-1?Q?UWAevsycUISq4OW7pA+/6iky+EfYj2dEh9hSykS0zrwh/2vj77q7CoK6fP?=
 =?iso-8859-1?Q?3tOaIU65upHMVICcgUIG59+1nr+e9yE7gAozncbSobeQ0fl5ce40MYfl3e?=
 =?iso-8859-1?Q?j33uoVCdNGn43zL/3o4wiUwvmaNZg/0h0zbPd2qqT+KRWf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a415eae4-3ac0-4d89-735f-08df43a477d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 05:42:57.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mD8+N+y3ETPASxIg3qzGYXyMWzGlxwdpYNRFmAiLlXupA4T2S2z5LYPp6+pxhzl7r0FJIfFM6wDZaWWin5GpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB912252

AMD General

Hello Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, November 8, 2026 5:13 AM
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
> Subject: Re: [PATCH 4/6] iio: adc: versal-sysmon: add over-temperature al=
arm
> events
>
> On Mon, 2 Nov 2026 17:51:10 +0530
> Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> wrote:
>
> > The SysMon has two independent temperature comparators. The driver
> > exposes only DEVICE_TEMP on interrupt bit 9; the over-temperature
> > alarm on bit 8, with its own threshold pair at OT_TEMP_TH_LOWER and
> > OT_TEMP_TH_UPPER, is not reported to userspace at all.
> >
> > The two are structurally identical: an upper threshold, a lower
> > threshold acting as the hysteresis floor, and a hysteresis mode bit in
> > ALARM_CONFIG, bit 0 for OT and bit 1 for DEVICE_TEMP. Per AM006 the
> > over-temperature shutdown response is a PMC function configured at
> > design time, so the kernel's role here is threshold configuration and
> > notification rather than acting on the alarm.
> >
> > IIO identifies an event by channel, type and direction, and both
> > comparators are rising thresholds on the same aggregate temperature,
> > so they cannot share a channel. Add an event-only channel labelled "ot"
> > carrying the OT thresholds.
>
> So the reason we don't normally do multiple threshold levels is they have=
 minimal
> use for an IIO interface - as you've discovered they've reported the same=
 on the
> events interface.
>
> If this wasn't an existing driver, the support of this is something that =
would strongly
> push in favour of an hwmon driver where the concept of warn and critical =
thresholds
> exists.  That's there precisely because the critical is often wired to a =
pmic or similar.
>
> However, that isn't normally a problem even in an IIO driver because that=
 threshold
> should be a design time concern with the
> limits coming from firmware.   So why is this even settable by
> userspace? Feels like an interface to create the bad type of smoke.
>
On Versal the split is slightly different. Per the SysMon architecture
manual (AM006), only the response to the OT alarm is a design-time
setting, with a system reset as the default. The OT thresholds themselves
are described as user-defined, and the manual says alarm thresholds may be
modified through the register map once the design has defined the
channels.
That said, I agree Linux userspace should not be able to move the
shutdown point. What we do want is for the user to be aware of the OT
temperature: to be able to read the threshold at which the device will
shut down, and to be notified when the alarm fires. Today that
information is not visible from Linux at all.
Would a read-only version be acceptable? The driver would not touch the
OT configuration at all. Userspace could read the OT threshold and
hysteresis currently programmed, and optionally enable notification of
the alarm, while writes to the value and hysteresis would be rejected
with -EPERM. Since event attributes are always created writable, those
files would still show as 0644.

> We have a few times discussed how we would perhaps add another layer of
> indexing to events, but it is hard given the the compact event codes and =
I'm not
> sure I'm seeing a usecase that justifies that complexity here.

Agreed, I'm not asking for that.
>
> I also can't work out where your new channel turns up. What does the user=
space
> ABI look like for this and the existing event controls?

The existing DEVICE_TEMP alarm is on channel 0:
  events/in_temp0_thresh_rising_en
  events/in_temp0_thresh_rising_value
  events/in_temp0_thresh_rising_hysteresis
The OT channel adds:
  in_tempN_label                         ("ot")
  events/in_tempN_thresh_rising_en
  events/in_tempN_thresh_rising_value
  events/in_tempN_thresh_rising_hysteresis
>
> Thanks,
>
> Jonathan
>
>
> >
> > The channel is appended after the device tree derived channels because
> > io-channels phandle arguments are raw array positions, and placing it
> > earlier would silently repoint existing consumers. It is created only
> > when the device has an interrupt, as without one it would carry no
> > events.
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> >
> W
> > @@ -880,6 +932,9 @@ static int sysmon_parse_fw(struct iio_dev
> > *indio_dev, struct device *dev, int ir
> >
> >     num_static =3D ARRAY_SIZE(temp_channels);
> >     num_chan =3D size_add(num_temp, size_add(num_static, num_supply));
> > +   /* The over-temperature channel exists only when events do */
> > +   if (irq > 0)
> > +           num_chan =3D size_add(num_chan, 1);
> >     sysmon_channels =3D devm_kcalloc(dev, num_chan,
> sizeof(*sysmon_channels), GFP_KERNEL);
> >     if (!sysmon_channels)
> >             return -ENOMEM;
> > @@ -960,6 +1015,25 @@ static int sysmon_parse_fw(struct iio_dev *indio_=
dev,
> struct device *dev, int ir
> >             };
> >     }
> >
> > +   /*
> > +    * Over-temperature alarm. The OT comparator watches the same
> > +    * aggregate temperature as channel 0 but against its own threshold
> > +    * pair, and IIO cannot express two rising thresholds on one channe=
l.
> > +    * It has no reading of its own, so only event attributes and a lab=
el
> > +    * are exposed. Appended last, because io-channels phandle argument=
s
> > +    * are raw array positions and inserting it earlier would silently
> > +    * repoint every existing consumer.
> > +    */
> > +   if (irq > 0)
> > +           sysmon_channels[idx++] =3D (struct iio_chan_spec) {
> > +                   .type =3D IIO_TEMP,
> > +                   .indexed =3D 1,
>
> indexed without an index? I'm not even sure what this turns up as. There =
are
> already 4 indexed temperature channels so why isn't this just landing on =
the index 0
> one?
The index is assigned afterwards by the per-type numbering loop at the
end of sysmon_parse_fw(), which numbers all temperature channels in
array order. The OT channel comes after the four static and any
satellite temperature channels, so N is 4 plus the number of satellite
channels in DT (in_temp4 on a board with none).

It can't share index 0, because IIO identifies an event by channel,
type and direction, and both comparators are rising thresholds on the
same temperature, so the two alarms would be indistinguishable.


Regards,
Amit
>
> > +                   .address =3D SYSMON_OT_TH_UP,
> > +                   .event_spec =3D sysmon_temp_events,
> > +                   .num_event_specs =3D ARRAY_SIZE(sysmon_temp_events)=
,
> > +                   .datasheet_name =3D "ot",
> > +           };
> > +

