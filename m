Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C273DDB19;
	Wed, 16 Sep 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550724; cv=fail; b=E9Ae8YG/b00ZP7FlG6KKjwOtNBuCQJRqRfs91D0oAUWNfPj0eJnH5vrRmvDUPjyIwrcMB9HLDP0oLBRWmyjjXxk7atXWmTqtmOSWCUcDMwiTBOkWNCxHbELkJIw2ULGJpiqpI5P7cS5cg3dvULL1Mx7biSIiwXm/I7H3edGLndE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550724; c=relaxed/simple;
	bh=qOVH6M7tzUSPWQJI8wLo6dMmZ79FZ6ZZfilmVhPjZtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcgHSZy5zSu6tqWnPn7zmCtI1cL7siDh27yeSgH1FCQL7BBNtfbXesJXqsGJogfNPDFDCmFZH6W913W9n8Bqn4PnS2sSMv/aU76vJAX2Md0TeTnbCP9OaKDxesAIlsx/kR4ylKsB037vGZ1bK13G5BCmIeoGuiz497p6kxLF+j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KnQbXYEN; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KnQbXYEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo8hBCnErvHAFEYTmQ93V8BAAUfA2DD50hHk8c7vEZGEuzygpAQjCa/XOdLUkeMCKeURK0pNo5XA4ZvFIRTVGotJi/v2Yql3yBK+xUx7O7Hw4Vlwz1lj9eceCiGzz/0gOnCCZKmqUFoAQJ8syZUgSQgV6ECt6eMyCDob6tWmtAgRU99gkbl3Z0F4bj5vGNEkOcBJ23Ljnwh0217VvDzkcr2TPHU+7eQb6PiNEQgjUtbI/1FKx9Zj14XqiRWaoJla3QysmEwMfbvLglq7DSarcmB9IxSll4rcxhTWHuI/oKJOm3a/POp7q7k3iK/Dmexr9QF5Ze/ElV1mvdUyIgPDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOVH6M7tzUSPWQJI8wLo6dMmZ79FZ6ZZfilmVhPjZtg=;
 b=MtCOuNPkp8kNY4gRVw1RmPRFknWX5BWMMIlLmn64Km3rhk7ncpPOekd2L5EOwimOj1zEWnnmqB/uYBFEU2kBi1jUQsWK9nxmJOxXU5JcqdcFedpxdYxJ3qy43MdNwgjjhK4LGxFDMOIbY5ajnva7w+T5/uK9B16a+8vZ6yBt5M+TRRbOeQqmyLhA/H+orckX6YIACwnvh/u23dWr+jgpcOVhVpDcZT0E+Gxxl4mtO55xyPW5yZf9YU7ajcpdjYV26oNCRQ6+43EU1q36t+R5mwAQrv98Rj57ceyxxaeKgTKxCa1bnchy58LUs2w5kQrIY2VaZpcU68PQQH/I4irZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOVH6M7tzUSPWQJI8wLo6dMmZ79FZ6ZZfilmVhPjZtg=;
 b=KnQbXYEN8fTD/GQcg/jshqQpXBBxJvtdGKgzJL2XL+zoQEiVUoVgZIikyP/E1H1UDhvIAq80xCP+2acDIb+OHaldFgpGMt9LlsY04A8as4RAVpyY9xbdEQwNku39c/T/39bxil6ii2Q3GHwHxrqM+67naLfuQ+Nqgkr391HhoE8=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by VI1PR02MB6222.eurprd02.prod.outlook.com
 (2603:10a6:800:197::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:25:03 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:25:03 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Thread-Topic: [PATCH v3 1/8] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Thread-Index: AQHdOh9AFzcBMyRsGk6GJk3qbsaftrbCY36AgA6iwwA=
Date: Wed, 16 Sep 2026 09:25:03 +0000
Message-ID: <ff44767e4e305ebe5acfcf4c300677eb8bcf59c3.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-1-77cc31642115@axis.com>
	 <178874609181.3402141.14348716380765604460.b4-review@b4>
In-Reply-To: <178874609181.3402141.14348716380765604460.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|VI1PR02MB6222:EE_
x-ms-office365-filtering-correlation-id: 41a14197-fdf3-45d1-77c9-08df13d46369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|3023799007|4053099003|38070700021|10067099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 pZY5DQSKE1YwtMN0A9ae3ETL8ml7tybkZ4nvuOS7di3RkCXygWT/+pRWWQ9cbtPw/G3iN6vq8XrVfTYPB/PLEur7bMNs6Kc++OZjdzX9C4XQDserDELl3s9UvbPg1lERy5Whe+ba7lQHEEiQONeSXpy9BHc4bG+QBuPGAOiLPG3rvXDfZFUg5YeRVyleb/fQFQPpNgv7guV+NM2/j4hvClqN/Uo+d6JGN/C81osxv2A3BnlLST36pfKF/jA5f2F5HiN3FJCjfhyeEQn6Vd4AOLsY91EAqXLCzaSz6c0qHgFv85Xvhy2iBV+9hezyWPdg/0JzvJo4f7mKHJH12KxavztVLSE5fAwJo5W9kpfGXO5q96o0lL8TnTt6xLvXf93cp36YtFLODL6j9ZAAX8xN3InRTuUqsQb2RXLCT8yvcpeQfMoBSvpwsOcmxQckXB56ULD3q4S8JHpXa4cYF3ijDZ+zabOvDGhUtGvHzdF3XuzS/QGIHgL/TaElo4k1uy+UN9rGcdibZQF42lD2b7/G4X9SeV/dlwBgzqXoUIQ7gMKf+kA7b5C9MhFeZBQBH/xpt78Tja/rVho4+o6VjHdKR5fenNKaH0W9KKSzm4yRxPNfNGrC3WOC2wKx26q7bOjOGHTm8dbjCvKe7oFFTiad5r7CWqmcjBaOsUAUWs+3beoBXxXAvgJlZf3PerLT/WN9P+6HmfdGqrm39Y6jsw30jzxKvXLzSxZLMteLPENaBe4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(4053099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cURHU05xNlh6WGkvVzgveWQyazJ2NEd3SDBBTmRFWEtGdlVEQmo3WjluTnZs?=
 =?utf-8?B?NDZRWGRqRmJDNWszaSszZGJmS0VIdHpYVS81YWprVjJVSzVCc2YrVGk2VExQ?=
 =?utf-8?B?R29XeUZ1dTdsRytldC9QeGFjVmQzREhQZTE3VXJISzdITTlQd3d4VUlDYXE4?=
 =?utf-8?B?QmxvbEhzSGpDTmVSeGpjSjF5eWJ2L0VXUWp6RXRhUmFSSFVxa0IyT3RTNG9o?=
 =?utf-8?B?Z3dUTFNYU2kxdUFDL0RsWGJVSzI3UHVKUjBVTlJyTStrYlNLMU1wS25qbnlS?=
 =?utf-8?B?bUpBOCtIRjA5SnJIM0NjWTFGMndhN3JhTy9FcFAxUHZaSjFLcGZ5b0pQbW1q?=
 =?utf-8?B?WE9VTHhaQkFXNUJCcmx6Z3NHOGIxcmtSdjN3cThKTkgwVGx0S1F2K2RMbS9S?=
 =?utf-8?B?SFJWaHp3Mk5vSXJ5TE4zRm1Wbm9aclR4aUhnaDhnMU1sQUt1K1A5ZzVyZ2ll?=
 =?utf-8?B?NkR4cGhMWTJiRjVVckQwU1prRXdlaEJ1VDY2djcya0FMMlpaMG1FZS9ZU3lL?=
 =?utf-8?B?TU5NazcrSDBTYnpCL2cvMk9hVmF4blFhYk1TSlRGRHJhTEdDZmF1NzB5TzA2?=
 =?utf-8?B?QTlNY0wreVo3akxQbG1WUnFzeVAxQXI1ZVV0ck5rYk9BNlF1UFJiQjZHTTdl?=
 =?utf-8?B?NWJkUnhyRVdzYVpCWHZRd1U2dGM3QlZjUGIwUWdJR1NIbnV6WVBvcEJLZDRH?=
 =?utf-8?B?REZ6M3VSRTNvaURaSEdkdDM1TlNnWnlKd3JXMjJwSm54emk4M2E1by9zQU9J?=
 =?utf-8?B?WGlVYUFlYmhPUHhzZHdyYTlTckljeWxnUU54bFJ0MmYreDFSdmVOM3c3a3Ex?=
 =?utf-8?B?REVFTEJpSzhqN0FwR1YreGppVmhxcTRmVk1qK3BmekhNbWJwR2xYQlNMOEVu?=
 =?utf-8?B?eWp1akthUjJiakNyZDZrUDhubG8xaVk1NkdoTnEwbUhFaTRIbzJXa013YnZh?=
 =?utf-8?B?S3dLR2RkNHZtWkFmbG44Qk9KLzBYdjY4ZWdyUERyOTlJQ0ZZQlNsS3dYT3dV?=
 =?utf-8?B?Ylo2ZmxKWGRWV0Q5a2hNZFFGUHlaMGJqVEF0ZGhZUHBpbGFzbzJqWEo2V2Z2?=
 =?utf-8?B?RVEvY29tMHVTSUFCb1lqNUtRWE81Sm9UNXRTamM2MFpXTjFaSERYcjhoU3g1?=
 =?utf-8?B?K0RWdkRHUVhqb3JIUjAvZlVlcmJ5OFFvSVhrak5vb0VaM0RuRldLOFNEdmR4?=
 =?utf-8?B?WGMyM1laaXkwbVJyYXJFQlNYbXZpVndUYy9ZekZrMUtiMjYrQkhPZ2F6ZDAv?=
 =?utf-8?B?WHFZeXFPUDcrZWFXaks0Zzdzc1FTTm9keVM3R3ZTM2VTUU1leFI0RVlLMTI4?=
 =?utf-8?B?UGtWeERUK0cyNy9XSi9RTkNuWjdSVnJtRHJDU1Y1c2ZFRWlEaUE2NkY2VVhu?=
 =?utf-8?B?L2pmbkhoUXg0cDFMYk5yWmg1enJTTjBkQmFIVVpPdm50Q0hyT0h6M2FvL2c5?=
 =?utf-8?B?amtPNXJLaDhnQTF5N005YTMwQXF6d0RFanAyTGhwRXFqelI1cmZSd2s2MnU1?=
 =?utf-8?B?dHdmcWFYek8weFlmOHBhUzFsR3pSendicXMybE5uMHR1N1YyVllVKzBYVjBL?=
 =?utf-8?B?QVNHdjREZ1ZVZWFDSE1OUzVjYkFqK2FRb1lTczhlSHdHTEVRd0NzelJMMDA1?=
 =?utf-8?B?WDJaNjQyRHFiOTNIbjg4VFRpb0FtWWhBNDRVd2FHRGVTakpCcDB6QUtWTVpp?=
 =?utf-8?B?SkRCdC9QajFkK0ZhMWVMcXVaTWNBL21TMzRrVE4xZnZmTkNERTNIZlFwSVU5?=
 =?utf-8?B?M1hnYVpjRlpzbFFNN0poS3kwOW9VQkVraEhRK0srOFBMQWkySU5SR1dyenZM?=
 =?utf-8?B?Z3M1T2U0YnpMdE0yMjJLbUg0S3Y5WmNNVlNEalRqNkNaQWVaZmt5bEJPak5Q?=
 =?utf-8?B?QWlRK3RaRWdET281SGYwMnR1c3gvMkdQaE5TbnZDN2s0NlNlK1ZUQU5OU2RG?=
 =?utf-8?B?Rm5JTER3NWR4Vy8yZ3FyWU0zcFkwOXd1MXJtZ2htWkErb2hyNll6T0ZkYmlU?=
 =?utf-8?B?L0pYQ2p6RG9SWG9zTzhsVkxyM0dVUUhXN0JGTGZWTUFpTGF2VVN5MlFNM3pG?=
 =?utf-8?B?T3NVNTFla0FFV0RKWjB1WXQ0TWdBcDZKNjdqclVrNStLY2FIaHZQMll2dnVl?=
 =?utf-8?B?OGZ3a1FwUGJZamhRbi9wV1RYREg1UGVJWUFxUUN0azBUT2F0ajJ1R2FsUFVJ?=
 =?utf-8?B?MThJQVVacHZCNHJ5SkIyRWVVNjRBN1BnaENtSElrQkQyNElWVXQyTitxMXI5?=
 =?utf-8?B?NGVLQ1hIWUtqS3hzU01xdW5TSWExZDZnbzIvUHY1bGplcU5ROU8zV3BHZksw?=
 =?utf-8?B?Q2xrNzlTOHR3N1h5eW0yb2RPYVd6Mmd6OXdkbzNiMW1HNVYySUVUdz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Ea4r1P71e8wnEK+HhMUe"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a14197-fdf3-45d1-77c9-08df13d46369
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:25:03.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9NWndi1WyNviBmF5RgfTM1e5rHrm/nT+ovxaE0yXVQTL5rzSUY2e8rXN1ZbvKsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6222

--=-Ea4r1P71e8wnEK+HhMUe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 2026-09-07 at 02:54 +0100, Jonathan Cameron wrote:
> > ICM42370P is a 3-axis accelerometer. The device can support I2C,
> > SPI
> > and I3C. Add the supporting devicetree documentation for I2C as we
> > have only tested using I2C protocol and leave the rest for future
> > work.
>=20
> Sashiko correctly calls out that this needs an update given the
> spi specific properties in the binding.

Will fix these comments.

Thanks and Reagrds,
Kanak Shilledar

--=-Ea4r1P71e8wnEK+HhMUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqpgbgAKCRDEY9j7t8Ka
Z5lXAP99StgJjj2Y/E7I4gI+anMl6VbBwpHlkjWsrMPx9uE8tAD/Ztd1DFhvBuzb
RrC6IfKMeG9E5vSsA3csIDRjdC7AWgk=
=CLsy
-----END PGP SIGNATURE-----

--=-Ea4r1P71e8wnEK+HhMUe--
