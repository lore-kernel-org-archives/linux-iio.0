Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358A374E5A;
	Wed, 16 Sep 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550784; cv=fail; b=rCszfAXO5KjfU3yJ//pL4YpiykUj0JRvSO+oiy2BeEsaTB9e4+xzf8jlg9rakftsxo0UrHJOliEKZTM5f5uKy7r8wQQKRHPNVNATOYJGAgWxxRCmeaacsVc051E82lRpAiR7wctuOt0CrMCddSBib8f+ZWA6ZcdOxaezNZsIVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550784; c=relaxed/simple;
	bh=EYNgjutgPHk23z+kSTf3y5PJn/IqoOmrFy2crY0Y96g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsJ2FnIzj9VubNiO9s1b9tVo1A0jxoOXNLLu79NN1E5TtP6Xd9rOoDivWWXVBbzHbpnQz1ij92DO5lLPZCBzYXPnyOSfIyupyaIbhYPCkuq7WdYeIfYvhc9X00po/tCWRKqfuiQp8JOpBHbbxv+PTFWzdpuuB4m8SuXLCRLoOzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dtfvFEhP; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dtfvFEhP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfYg0o47iJn0K4TQVnh8E+lz9lqOF5qcVWawyWwNCWU/iZvYAzAjsrMmJ1KCOtyKmc2c4HFczaMAak3kknV7g55tRKsQwyKDkmNacmXfaBaWGEPguBx7CUddYe5JQViN0kQaepogdzOf8Nt9o3QW/cO/EvW6zzI3uO2Iaku0z3etiZxIK1qlGIbFA7tQA2my7nM/PI+HPVX1uB95sYadtR+8gH6NNVWpqeOLRO7O6HP+Ua/PyMp+jX01xoFZs03ObSwXcksiLmH4xoWrC+81TBqTNjtZFA8LCXOeLMuAfqldtHUhnUaooz4qx79yXEaiEq0qirMVpw6Q3/tDqiqmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYNgjutgPHk23z+kSTf3y5PJn/IqoOmrFy2crY0Y96g=;
 b=Z8UsPtXk6mrD0rVCVZmo2ve1dDTRtQjJQsqjYZyp8m2uL7IgKQ9wfA2gZgVdtzOEB09Gtrwgykue3B4C3XCPm1neysOxiCC3qEwRIkbqowlQUIx8EhGLJmRlt1gCaKYnvd9MWtUaasFojxx7MYXZgZe5ngIgo+3UPMOrYhMf4F5N7hCt1zWJrT9r7ZJDCywLvoRer/QNq1gTS5YNCuyftuXu99Ek78lOHns+3QS0pgXv4dHeKPGuQRiZ9Mpb0f8vQgXg25cdY3d0BPFpZIwfcFgnwk/X9kZyVbRTmXMSnwNt21Sy7cooId3z7V080Dl3P+Z47dp7flKRA5SKL6AxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYNgjutgPHk23z+kSTf3y5PJn/IqoOmrFy2crY0Y96g=;
 b=dtfvFEhPhkaClZg4S9TygHLmvzG/GYg/9vTbWTZsQiOzbcMFDXMjTwA22kC9668yykOM8sjfunTHzS+CM0urU9P7XT9aKatRUUXOxzlS8LCWs72Y4xM8pgfS1dPOfh2ZZSs+XOvvGyS2VRO2n/mJwgActtzkp9FrpUZOYkUbLMc=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by VI1PR02MB6222.eurprd02.prod.outlook.com
 (2603:10a6:800:197::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:26:12 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:26:12 +0000
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
Subject: Re: [PATCH v3 4/8] iio: imu: inv_icm42607: Switch to little endian
Thread-Topic: [PATCH v3 4/8] iio: imu: inv_icm42607: Switch to little endian
Thread-Index: AQHdOh8+7thVAvENdUGm0x15OYIBRLbCY36AgA6jFoA=
Date: Wed, 16 Sep 2026 09:26:12 +0000
Message-ID: <67384399da5e5258925cad8bfbd47bb99b9b865f.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-4-77cc31642115@axis.com>
	 <178874609181.3402141.4159201185317451449.b4-review@b4>
In-Reply-To: <178874609181.3402141.4159201185317451449.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|VI1PR02MB6222:EE_
x-ms-office365-filtering-correlation-id: f331527f-a129-43d0-6a87-08df13d48ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|4053099003|38070700021|3613699012|10067099003|11063799006|5023799004|56012099006|4143699003;
x-microsoft-antispam-message-info:
 gTYpb5mmc/q/y1+qh9pbKXhe87mXCh0GEKUri/40oDD/qGRtFW86RJCO97bi+5o++ehgjXmI/ufJG79TsxXTZ4l+wqZjxqK4dz8pmu+ecQJd23hOJyjIBpjO42a0WXv2InkdrUjAdSYXbn8UaH0b+nGGpLL8h2bLJHPDc25Ue9dvCy98W3pRuPJH5S7+xsPFZ6qPcL69T6pfby2GNUwNnuJfnUBgQ5mk32JjZnrxQVaT9dRAHDH6PlIV8/TNP9NIFY4xb0SX3Dx/M/kyyinqswMwd8WYgAmtSpVWP2Q/YOsQVf6E2tQKfOPJTR0AsNizkq9hQ6PU2mjMABxbQArHVkSjX9vG5B96mXS5wmhd1cI3IJ+lyIK4wUVR2S40GFqQg+0sVTa9/Nvlw+5go9MF1PdezVzxWyDQPpBMxQkwDyRO2ivBuCCiHo7n5jeq5c6ax1V/39hsj6IizK47Qyt246wBKv6q+HO03cVEguRjau/dhY2GUWUMqSJBJxMl7BA0xo0O9kRZgny31tIgMGHKswM/Javgoqg/o18doCZ7I+DYqeMhY2DkCa+FZCqgNp58bYvX6GYCpAQH2u/nS6dxW0HXhgOgf7p5QCt/uP1/Dkrk+pE7+BhDKn5XuxXQaT7Vt0zXu3AQGdGpc8ANLKN9SBefFDKnrHGYG075NLfmvnrm93I67emTIOnm0UcfMeZNOmg/F4lE6wbnNuK+6LtjCuGnBWLV0u9w57JWAk8yMab5/1cuCqitpA6e5blVOK13
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(4053099003)(38070700021)(3613699012)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU9PRndOZTFOdloxVFJCMWp3cVNUZlFkSlArZktjWlVVYjVFc2lZTGhWa083?=
 =?utf-8?B?N3g1MWRQcUg2OW1OU3F6Z09QK0N1Q0RhdWdPLzJadjhldjVOSEQxU0x1cnVE?=
 =?utf-8?B?cHcwb242Ukx6MklHVXBkc0NlZHZON2orTWNjTWo4OG9DSFplZTJnN05NYWFr?=
 =?utf-8?B?c3JOZmVuQ2xUbHRxbVl1Uk4zRWFaR1k2anlIOU1lZXVGcTJZN0VyeUR5QXFV?=
 =?utf-8?B?ZzFQK0t6Nk5PK3hVa3NaaFRHRzYxTk1PZEhlWlFwWFk3TkNUMzQwNGIyWFhm?=
 =?utf-8?B?SWYvemhRVmFvSC9CSnJZVjY3U1N5d0laMEhKblRMbDlvSng4cWNoajAyeFY2?=
 =?utf-8?B?eU9helBrSlk0R3hXMkEwZEF1aG4xTXFjbEQwTkl1OUhwOSt6NllPRnYyQW51?=
 =?utf-8?B?VTdsQVp2cTROS3ZHZzcvNm1CMlAwMDhoRmE3aWZQOE5YSDRkOVhDc3U0UHFn?=
 =?utf-8?B?empOYUtNL3Fudld3eUxRSU1zNWtPSmZYZ056ejZ4RDJwZDEyclhzWG03L0lp?=
 =?utf-8?B?ZXQ3V1crWXFXTVp5MWZsUDlFSTN4R2g3YTFaL3RYMWRCbDdPV3lrUDRVNTB6?=
 =?utf-8?B?N3JEeEhpS3hmN2d3MXRZM05UWWg3MUl2MlFDcjB0S0dlQWViUlVNUDdlazEz?=
 =?utf-8?B?UUE3WFRKWVhZYUxYUmNYYVA3bU1qdDExL09mNTQyWE9yQ2Jtb2JtNTdSZi9C?=
 =?utf-8?B?cXZPUXQ3K1NVR2dmSUlJRS9SRTBmQUpGeHRxc3VtQWx1VHNKcHh4ckRwMTBk?=
 =?utf-8?B?OEZrYnJTcEFDY3FETVE4aURRcDNGYXYvczZBdlN5SFFWOG9HRUZ1a2RLUW5W?=
 =?utf-8?B?Z0lCSTJCeVJ3WUFqVGdLc0Zab3lNR29oTzdlT3EyNFZmcGVVNTZ6enVwTFhX?=
 =?utf-8?B?OU16YmNhYndsQm9VdFR3UWJKRWprUDgwWjlCOG56MHRGYmg4R3FLR1YxcEJJ?=
 =?utf-8?B?RnR3cFozYVUzdDBudmNwWEFQNDRPUFMyTVozdVhPcCszTnZpZ0t4a2FPbUQx?=
 =?utf-8?B?QlRSUGNpQTBUS3NvclpzVExoMkk2YkszQ3NoNURSbzZkc0xnVWdPdTBvTWJv?=
 =?utf-8?B?ZDUvNS9OTWlmUjFKanBSU29nNXlQZ3YxRDZNWFQ1YzNtL2FETzlMcWk0a0xV?=
 =?utf-8?B?OXhBOTBVY0ZVaE5WRmhmam90VG1uRUJOcEdzZ2dZN1ljNGYvR2pTQzlvUGVt?=
 =?utf-8?B?cWtMMFNDUmhrRUd2OWdWaDIwSU4wRVdrMTZhd2ZmRmZuTE12TFZsU25SMFBC?=
 =?utf-8?B?SGFZdTFIVm96NWNzeXl1c3REVU1hTDQrQVBWbjFGSGFTOTU3K1dvMWJRR21D?=
 =?utf-8?B?R080NkxmQ1E2TVVWVlBxRkRpay9HaHhneU9DUGhFZlc5UHUyem5RNHM1U3pK?=
 =?utf-8?B?TkN6WTh1SlNtK2JIY3VpVkl6U210Q3ozV21YakZoNTF4SWVWWmU3SmtCcHQ5?=
 =?utf-8?B?ZGpDcTA1Q1U2aXJQTmxRLzFiNFNkOWRyU2lIMDcvc1hDOU5ENHl2V29oRko4?=
 =?utf-8?B?QmU1UzJkWVIxVmhvRGJaeDhxWEo5YThRUzRjSi91WUFqcitSM0l5cXFtNmh1?=
 =?utf-8?B?QVlmckRLUG1EZHJadVJrZTRyVFlTdWg2MVc0NWIrNnQ5MnYzUXI4NFNVWkNJ?=
 =?utf-8?B?OFluS1AvRWhYS1pqeXRRY0hOMHJ1ZHZRRFBHd3RiNzgzWVZKNGtzOWZ5TXBP?=
 =?utf-8?B?VkcrWUx1bDF1d0NjbGVMMU9YYnNKNlcxYzZOUkx5RUNQc2NmUWpROEJ5a3Zh?=
 =?utf-8?B?TjdHRWJCVllwdkd5SG8zTElmQm1wa1FEdjhJZkMzL09mbCtSQU9OWWUxS2do?=
 =?utf-8?B?cHprc3BLS1FvVElQc2UzNmllZ25yTHhuR1BnQnRHYkx4eUtDQjhZMktGaExM?=
 =?utf-8?B?ZU00aXhrcnlSMDJrbHpMWUJUbUxwZEJGdElvYXllam1mSWl2S3pQNUVpQWxJ?=
 =?utf-8?B?VGFqa0pGVWR6dXprQnhqeEdzQnN3L1pYRWNqWUVzckFWSURZc3ByVGF2bGZz?=
 =?utf-8?B?Y29PVHdMWEtXUEhTK1NvQ2lVU3FpTTlSUkRPWVZuQ1ZJMXVIY2FFcER5aTJ3?=
 =?utf-8?B?ZjBRNDZ2azZ5SG85bHBUanVqZkR4THRnOVRjQnAzb0JnbVJQdkUvVk5TMTFD?=
 =?utf-8?B?WHlQVml5RjEvWHVsMnIrZWVzRUFvVEFKRTF3Qkpvano3M1h2RUVtQ2d6bG1n?=
 =?utf-8?B?KzFzL0d3QzFSeUxYaFJqWGhUb2xkTE5YazZkZDY0RDVYSHR3Y3JrZ2RwVFB5?=
 =?utf-8?B?alFuMG1yR2NQczMwdkhiL0Y5UFBaYmcxMHBKV3FvRy92T1JGMFpabEtzL21x?=
 =?utf-8?B?UGNRMWJlbkd4SWVvRDhoQ0x2UmJ6Y3JqTm9kbnRha3U1cGp3a2krQT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-u4BjXMRusxyrNl9MCf1V"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f331527f-a129-43d0-6a87-08df13d48ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:26:12.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+jYT3cejTZL77MeNYbTJQ1JTSxiClNArc1a2Kto43E/wuCeXAut9fRXlv9WIbR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6222

--=-u4BjXMRusxyrNl9MCf1V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 2026-09-07 at 02:54 +0100, Jonathan Cameron wrote:
> > The device supports both big and little endian formats for sensor
> > data,
> > this is handled via the SENSOR_DATA_BIT in INTF_CONFIG0 register.
> > The
> > default value is big-endian format.
> >=20
> > Switch to little-endian as it matches the native byte order on vast
> > majority of systems and avoids unnecessary byte-swapping.
>=20
> This is an ABI change.=C2=A0 Whilst in theory they are self describing an=
d
> no one should be assuming they are stable, in practice people do.
>=20
> So we need a stronger reason than it saves a few byte swaps.
> If there is nothing else leave the ABI alone.

I will drop this patch in v4.

Thanks and Regards,
Kanak Shilledar


--=-u4BjXMRusxyrNl9MCf1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqpgswAKCRDEY9j7t8Ka
Z4aiAP9qwxJAx/P+XF39SLD9x44qA+L6IJPcIkjkEbs+TJvaCgEA6J2QMf91VuJJ
dvQbSd8hkHzh74gsQrcK3ZiOL6O7IAs=
=XkjE
-----END PGP SIGNATURE-----

--=-u4BjXMRusxyrNl9MCf1V--
