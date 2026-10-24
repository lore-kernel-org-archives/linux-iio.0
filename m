Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792800791;
	b=3KMZC1BwDeqQW8XHBLIojwdQnyP+9pxI6wPFubSkg0ff4ePQYVsrweTuh2345m7QjMUa
	 GLZPwf/rPjZjUvTZycuZkfxWXX7RfCDIXga9aQtkbncYau3AbdlunFdLEzRxylKAqc9AO
	 CYPQRHiS+jFJ0icaAdUEr9fIrG62OYIQFK5pxj2zisFQRYh6ggKlPrxQfsBqkJi1Hbe9M
	 53c/YC4/Cc/pvb+gZAJE8pjxUXXNC/Q0qRe57WeVhniG5f0PfeLCebwZvJOp1AjANcAJ7
	 4viM9vit3O9iPEu4/hroNSlS7/1CHz5qF+a5NXJdNA/yKsLqcnLCnu5pfC7qSgWbslA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800791;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=ws/oZ4zPdKkUcgi0DdLmAqRsG7SHgVklGoVTDd/X7Tg=;
	b=YGherzTg2m+t2Lg7tZLYhZjLTvvdWruIIaeJ01q4+DhfR8tCRhjAx1A8OCS4pMczzi9m
	 i2PeggG+R4IKUhIVvE+e3HhVLeRhqTeFCuDE/2ZaW1ukF4viq+u6H0zfg0FTCg6fbPL0D
	 hTMfHoERm/OVbalhGsQdkt1Meh6bJPyX7CPwD7M7Fen8ZKmWsDtDD21sPKvx0niUJRIOe
	 eLIYnlxyHJgKino5jXNjAb6qelgG9BoUVdbmzYCA0SyB0hWcC4RDKoleMQuPdmpxQIjwz
	 zdtW852FiS8cPSpOLsky3sUqTjj266oTA6lhLWEBl0PegNwduuIcesa1L6nc4J9lyKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="Y8/sMx1B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.1
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010001.outbound.protection.outlook.com [52.103.12.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A922606A31B;
	Sat, 24 Oct 2026 00:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A922606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Y8/sMx1B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhQ3rbocCpZ1vBgktUy46BCcuMH3JarhLUeRmF45SCHtlyZKR+UQD+NJBEqRx65EQMj0kKKC2HeSceE48pHGoqoAOfMNIRg7bBwq/RkmfTjzA97PMLAfeQ58089OyMHyrngka23wKEjbwtxJbEPT5WYM2O0L8VUU4h9HLsQOBBsO93yeZRi9ItL9dHzqpRIf5e7V9+FhFwfR4toGm6QSw4DNh/YCOKDawCQF4l914rrj/hC/8YEzK8x/x5Y8qGvsO0e72zH2Ps/UbdCBs+NZEDyzuGMYwYSZ3Kf/s86EjRQi+8vwNJpNAVuYu8Ew+ZzpOQ6cXVVcPT2tKxN2GWPieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws/oZ4zPdKkUcgi0DdLmAqRsG7SHgVklGoVTDd/X7Tg=;
 b=CgmhY3jEAYUZ918i/P+x0gWcyPhuZQl/kROUqfMAOe4TPEEVkDrz7k34mA47h/3L//G/khfK4A/wA9eLnM0z2kicEsX9/uDKTl2uMtQx2bU7jqKHd3/WpZorgmCeX72hvdPJlI55fmdIg188hIUkySApKIY0n9SvpmPL6NhtjzQNmdYZ5EChm9FuH1umx2IEemEHpW1f55sD8yqbpkVEvXlO9l9PLHKGkReblQRBMUCl21HFFclvzolHGC5Qy6sKijap8+h0t7eLrJs84/nTCy93+YT2r66DWVwH/5TV7xJAam6a15wTS/FUMVGPtkMS0kFy5WiMC6D97YYqZdjyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws/oZ4zPdKkUcgi0DdLmAqRsG7SHgVklGoVTDd/X7Tg=;
 b=Y8/sMx1BaZZT9bjEWKPUhGWfxNS802aiFLnXSMRds2uxVdyKKiOiiKTE2VZ/P3yEZEHP6pUhVaGKszKKdSatRyvGZookrtmLNYGimGa4BsVL5JQx5yf6MFJP2VS1QFom17ID6NlCndlTwjidVLu+K7RRsGsgKr8hsMUwyFr1HxRcZgPD2/icLMyCDgCAXg9dlpD1uE5N984/LQGgf9Uzedx4Kwz2oFZUdMgdoSnduYFGu45fi7ISc7ZqqfhAdNcb7fzmjBykxieqA2Z2qofvOhv05ZDZTzEn6dJ1Bf7Ky48hK8f2+rd0zZZrFHAgmJxWQZ2WO4WC73fInr6SibpkmA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 24 Oct
 2026 00:13:09 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Sat, 24 Oct 2026
 00:13:08 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Topic: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Index: AQHdYn7dNhOVhqe2dU2bRWG8P8EFvLcKcKyAgAFidbc=
Date: Sat, 24 Oct 2026 00:13:08 +0000
Message-ID:
 <SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
References:
 <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040143.2e7043bc@jic23-hlaptop>
In-Reply-To: <20261023040143.2e7043bc@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2528:EE_|LV8PR12MB9231:EE_
x-ms-office365-filtering-correlation-id: 33273448-36e2-4157-823c-08df31639552
x-ms-exchange-slblob-mailprops:
 gMiuAN0LASL4Z831lB8tpzpdpKMUIXWlcEwnVU3QW5Wbb+N+6FcdywijK/9So5W0zw1avJsOLVF5GbzTxeDHP7tRQP2xaG9XjWMmTntliYovEXoL42vj9RGgFwOJ9+4AgU9FYfzGHYasiGFXQERxDPmcBphnZOBxDRRWY60I3M3pR/DxzfSlyEw7omzuyPNwbCb/2N8M3yApOHwwVG1AuwAX1ZJEP2LQop0u0+YEOIao5SQgRTNvm2R4abGc8+C/IvQYYEtLfLXex1iYUz14jPPywar9ua0QTBQ6knoQ4KQYFvPWIkAqSNFyMqxpfuQDuDFbp6QNNkWjKbqPfgtkaTFh78ATW97plGMqwg9ZWTEwUxWxEMnIovlvd3mEoTfTmYhq1C1P8ompE1JifGXZzX/2Q4X7Ocvvcjy2OmkpTsIouZAsBNnFNC1AhBCuOoK72POnugVO94afvA2tPeDV3a6JDvcx1tFS5fWnj6x7EL5W8406gWHkma/Dcv6msEgGyYQUtOyW5bn+YghequAWORc/QT2uKvlAmI06vG22DXAu57XIP9SAvKK2BEfXOmWrSLad2aHzFuwbBHew55QmvbOx2lx0HXRpjqoTDoUyunaF8z/77nuhaPA2fRxLyu2yru23sGyV8dRKYUNYLYpO5fAYXMM8pYCvu7Ubp+ZJgHbafLziYVH9bbLDBLhxhB10KI70KmEnBW8tkEPzTd/sUA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|12121999013|24021099003|31061999003|8060799015|25010399006|15030799006|15080799012|24121999003|51005399006|22091999003|12091999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WQlz2U3/HJQkkOGAW5VfU/beV39lvjUo+r56SGRW5sq1SoX5snY3Us9JeX?=
 =?iso-8859-1?Q?dkNr1XX2GsVFjIgOQ2GZfDRM/Mt2WTzwkLMti/5AMm/TQJDSNkreVQKPsE?=
 =?iso-8859-1?Q?aUduo8lfhdlf1GYiHgynXq4QcT4Xpif/vHmknMkN6X/GmVXf8VdLNI0qV6?=
 =?iso-8859-1?Q?HlWefv0MWMKJrsOHZ4DLcSc2sUaaca8GNaws9rww16GZmNYNgeV9Ke0oaq?=
 =?iso-8859-1?Q?2Ub2u0NjP0xOqaAPL9VFl5dTTb1sN7tyBAEzL63jzhuFhgizNUlVp2Ufd0?=
 =?iso-8859-1?Q?fJoiI9/5h1D26sEfNty3CQi+8sZbRQ67iiS86j20V4SQhLUrNs4WO/9+aY?=
 =?iso-8859-1?Q?huEN3puuMvfYlQz3U4uezvjQIqI/kuvr0AGPJSvG8UAxoK4ODbByC6LM+D?=
 =?iso-8859-1?Q?AnGOOrW6ZiraOE6H5kMERHU0tKEKrbmeAzWLzoy9TU5puohWZUu/3pFKXX?=
 =?iso-8859-1?Q?cprvgJ6Kbzy/AaME2dPr8/fr5KoFsHpYDVIVgdsYsRmedEGNGwBDgHLtBi?=
 =?iso-8859-1?Q?ZJP2gJTGjMpD9P2R2P4v7rO0/G/LKFF9S61m0UgcK/z/BCfRrC94yWKZnk?=
 =?iso-8859-1?Q?lzRist2BQ0O17Ey2sLdk8L2V5NzMN//8xmKKuKeIBnzAyYkd/HlngjNNGc?=
 =?iso-8859-1?Q?1I5gUhSTkCFZ46NTdnjPSGVUXKViV88XQodl5OTSIKwqxvlf0ARDK+uMHR?=
 =?iso-8859-1?Q?lS90/qZqnubWLIFdM3i3D1mj8Acu30iF9pubgthslojUhGWpji5A2nEEEM?=
 =?iso-8859-1?Q?bEOvzWPqaHkjrpJxVcZju94ZtlQo2S95msWZNI9upROAPYnjSHManotYYE?=
 =?iso-8859-1?Q?oAXlETPb1BSpC2aCrh7zP2wgPCifgD300ogBB0DtkQ4z5F3SgWvjSrB6LF?=
 =?iso-8859-1?Q?8U1Vemg4c8WfBWoNT7jesK9tErBoUsFOym1XdU52vjBqk4cQedSfgutA4a?=
 =?iso-8859-1?Q?60qEqMwjEo77/7S95BOJYaKiYEFMUYCWVO6F8UVgEKTl1wIYydUEC+FUp4?=
 =?iso-8859-1?Q?fu7pw8a+tPQE1jHPPdVD0dY0y5fHgbSRrAN9JhWRm9goxnXRf+C+VVR+ZD?=
 =?iso-8859-1?Q?FFSADLaAw/6ZA0dmqTJW2K//768+DJTmqS/32V97Gu3ViJCUs8Ca8fD6D+?=
 =?iso-8859-1?Q?c+YDeWb8m7BnfzhB4ZeNIa1xwprZE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AgNWQMycz2JaXHwfV2U5zBbM3blC40XZXlloQ+GiLqjoM0Ky2pCdbZvcuQ?=
 =?iso-8859-1?Q?ma5Rc7xiNwV1X2TaEysySIKTVn+0Im4RpL/ScYnozkklxGLC4mVMPQ4JJT?=
 =?iso-8859-1?Q?tASTthxvGdr41imoKXGz7avaa61TmQ1PNJkokb3ndSNP6D/E/MTRCeTz2b?=
 =?iso-8859-1?Q?YJDDLh6fH6a2eheXGfQyIF8WGJ1+tNbCett6RavxIH3WStuBm3jZk9si3s?=
 =?iso-8859-1?Q?inTsRFpd4B3Lg9T5ULHPTudrEFAbJjnXn4RNUfR7g9FUvceJVo0J+MCbr6?=
 =?iso-8859-1?Q?NSjHlwPjmseRviXByeLl2yO/+s1v62ITy0rDtPGvesJtstjDnJbHfUh5pv?=
 =?iso-8859-1?Q?UWDMeEzEia7b/wKlj5l7/mt7jcOOyMP05XgF4OWWQIb2bjJRoejop+IF01?=
 =?iso-8859-1?Q?gQoksbQQ4gvNp9UrFwr3QvUfb5o4NivyHNaKGWml8Udhht/x0qI/DX7zU2?=
 =?iso-8859-1?Q?WNDlC1dhURK5XGWyQxABJcFM9DrrJdIJAvFYQvvIRYNK7u5bLK3ZGFPEeN?=
 =?iso-8859-1?Q?VkLdrHEHn50Spllnyy+ptva7Fbw+mvDvUlUIbXolFRsVW72V1Gy1VlSTJ/?=
 =?iso-8859-1?Q?mYnmZx7kuhd5M4/RYTahp4/Fz5E4iIPVj7PCCVGzgnBS3QvObo1cbAYrxM?=
 =?iso-8859-1?Q?phVoH0MZMhZQ/quPc3ai8ZhnLQJskd3QScTgx4Z3Mv6yQTk5p02uuZr11w?=
 =?iso-8859-1?Q?iWiCSax/WTByKHjiGhPeiOAL9cmT4AK5oHrjU+93WV8jG5d6JYTASrJGlC?=
 =?iso-8859-1?Q?4A1d/eKJv6NFONbswRRTtkjLeRYODa7FPvOb6oXp+i9XugHq5iVRaOtfKJ?=
 =?iso-8859-1?Q?GJe4NRoVOSXCcFatOk1gJNY6kFqAGUZ0FYxS1czQcD7MCScgqcsfs0fPNJ?=
 =?iso-8859-1?Q?dn9w/97dFbSQPpl/CcjyTkDeFJwi9xLTcpS75G9AJl+oe6CctoT8y7kJPN?=
 =?iso-8859-1?Q?eIDL7wFvgolcedDx/9mQfYGaqSvQoSIBwh9dhpubjFE5QmYBsV8Bd5m4Mk?=
 =?iso-8859-1?Q?LRrjgVwhvzwPmgO57N4d5uUHrk/Y6ZjKCjPrw2f34JL4+jNl4VlVQBTwiQ?=
 =?iso-8859-1?Q?TNXwrdd15v/3jISqYZtKxT0mmU59o3ChtKrwTkdhqS3pzwgWj7sD8xhS80?=
 =?iso-8859-1?Q?GyZhvhQOYCBIX1Z3G+/SHgujBPZ30865Ih6qoLUHMY9B/VHnAjG0b6ZfGR?=
 =?iso-8859-1?Q?+Js769joohcTwPWHCApB47dWJc2OqTGAt1gExB9ULk4iPfEqwJ5vtriDtA?=
 =?iso-8859-1?Q?hILhwIZ5LW4F4d1VxQBZYUoZlYBQtAVaI1/AHD1vn1izLYc5wOt22PoOhX?=
 =?iso-8859-1?Q?Ti+/+x5RgBkF31e1qC6iWoUVgc4ZeKopUZM0ylT3RZQenWxOTCW0sxxRt6?=
 =?iso-8859-1?Q?AOsseBX1jIM1Wlq9sHB0gxBylVGSEJ/E4wUgOzLtxx+5T6ovXMxN8cbGJf?=
 =?iso-8859-1?Q?MxKM8izymqHSAakyddQRCe5G7LqMU/kZJnUnJw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33273448-36e2-4157-823c-08df31639552
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2026 00:13:08.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

Anything I don't reply to I've addressed in v2.=0A=
=0A=
=0A=
> Given offset is applied prior to scale. Is this in appropriate=0A=
> units?  I'm not following that description.=0A=
=0A=
I believe the units are correct, but I've changed the wording so=0A=
it's hopefully more clear what's going on.=0A=
=0A=
> common convention to add the error condition to the exit one rather than =
do it=0A=
> in here.  Then check ret after the exit from teh poll.=0A=
> Tends to give nice code to read.=0A=
=0A=
I think I understand the change you want, but please check v2 to make sure.=
=0A=
=0A=
> For a capacitance channel I'm going to guess that expectation is=0A=
> wiring is such that only a subset of channels matter for a given=0A=
> configuration?  It may be more user friendly to put that in=0A=
> dt (see how we do it in adc/adc.yaml for instance).=0A=
=0A=
Does it buy us much to not expose disconnected channels? Whatever code is=
=0A=
reading from the sensor presumably has knowledge of the configuration=0A=
anyway (otherwise, how would it know what "channel 1" even represents?), so=
=0A=
does it need to be protected from reading the disconnected channels?=0A=
=0A=
> Interesting that you have these only for the single ends.  I guess they=
=0A=
> are tweaks on the analog side?=0A=
=0A=
Well, the sensor doesn't allow you to set calibration values on=0A=
a differential channel, only separately on the two channels involved.=0A=
=0A=
> Putting that aside, the base unit of capacitance in the ABI=0A=
> is a nano farad. The part is documented at 0.5 femto farad=0A=
> resolution so I'd kind of expect a scale of only 0.5e-6.=0A=
>=0A=
> Perhaps the issue here is desire for a very high degree of=0A=
> precision on the scale factors?  I don't mind that if it=0A=
> is useful but with a documented 0.2% gain error I'm not=0A=
> sure it is.  For next version add some reasoning for=0A=
> why such high precision is useful.=0A=
>=0A=
> We frequently round scale factors as often they are swamped=0A=
> by error / noise.  Perhaps that doesn't apply here.=0A=
=0A=
I think you're right that in this case the extra precision doesn't really=
=0A=
make a practical difference, but does it hurt? We have to use *some* unit,=
=0A=
so why not just use one that doesn't introduce rounding? To me, that seems=
=0A=
like the default choice. It's rounding that I would expect to require=0A=
special justification (like what you're doing by citing the resolution and=
=0A=
error values).=0A=
=0A=
Even if we decide that a given amount of rounding is okay for *this*=0A=
sensor, imagine TI releases a new one that's a drop-in replacement but=0A=
with better precision. We can't be sure that the rounding is still okay=0A=
for this new sensor, unless we don't do any rounding in the first place.=0A=
=0A=
> I'd look at using regmap even though you only have a single bus. It provi=
des=0A=
> a rich set of helpers and the caching functionality that will save a bunc=
h=0A=
> of bus traffic.=0A=
=0A=
Ah... is that a strong preference in new drivers? That would be quite=0A=
a bit of rewrite work...=0A=
=0A=
> Why not build these of channel and channel 2 at the place where you need =
them?=0A=
> This feels unnecessarily complex in this structure. Much better where we =
can=0A=
> see the reason to do this used.=0A=
=0A=
That's fair, changed it to what you suggest.=
