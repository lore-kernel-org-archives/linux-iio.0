Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5A46D092;
	Fri,  7 Aug 2026 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108560; cv=fail; b=DixYfzJ+sLgI0tXEjQpg46y+NJcwplYrizrYvM/hkCM5q4wUuN3iYgok1JSjXulsLkgIvPujnZjedh/9EGjHpAZwxOzJeAnYLFPlENV75Jz9VG45pIVwDw+SrXsbC/p9HKGQy2siB0rih3CB8/1xLhST2R3I1Nn42OQAehx3JSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108560; c=relaxed/simple;
	bh=pPdOGiNwDzgyqGVpRvA+dfGMB5AoUIN8VEAp9EXRa/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEAZMeGGOj7STd71WSVOryso4thPubBZ28oVEWMGmbJsgfpnMd+Mq13XSTOGnjHh0q5+keUfYi9/VtwvfXPjL9w8YhlDAc7EccOLr/+5u8iBFAhAvdQJQ1+CVAhp/mHyq9258oILzMpiQzMD75GaiEGHP6VwvNz/C76X5KoBfh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=V4H1t0qA; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="V4H1t0qA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd+tGEpqVNElgqzt30iyv/FQq37MhgUA8SAaic1UUC9uqnETFk03kxcZ787NAXgMEQ/LRw8uJbBS3mC6xcSgVDPuGBdxHeilcclrg2ZZANNBFOaFF+Rf3fr+VOGm9dRzds966uIdS1FH3aOVCWBxxnojgOjGGKwotKhbxxklHKvFJHvltpcYfwQYKSyKs3VLEaHKjcPjqLxassu1pEsRWpDt3W2bNZ7vHJjdXgnFvjiR1pWcLzJJE7hgI8wbqHfEYkIGrxc1Ca/nHtaoRsUDyAjiKMzghSnMLa+thEBChtgMiPkpkhooq5Dw2guJn7ZnBB94aVCxCyNIHirVxrEyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPdOGiNwDzgyqGVpRvA+dfGMB5AoUIN8VEAp9EXRa/0=;
 b=aXhYxSbvslf+RprUmiic1zruiTbcR2346/JOEMRaQVEe1hj20jd4zPLHIGA+1Ui5C07zjnm5FxJENI+iAVQCv3k3ZtjKNJ5vw8DA40CJEtSgyWjmfnCdydwY4pPXYXyfcDHoELyqwmMSL/4Ri8O75x3YoBv1cAI4tvXn5hO8Sb3ePiErK+TRfBkQ3KOwo2nE8uG40W7iO/IP9bApzMZ7fDAGpaI8BmEqBNvm+DghszUJHwRRsuk70SatsSk7uI5O9sxDsVMYKvVSg28txFZjHpnRD2t5yULCr2JmAtmZHItRyJ6+i7J/xm6i+d+/dozFobL6JlebxNUZlY3O1etzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPdOGiNwDzgyqGVpRvA+dfGMB5AoUIN8VEAp9EXRa/0=;
 b=V4H1t0qA02yeHUy8p3/plYnEb0oJLUARbaPxotUATtxY6TW0XpmjVqeAMwgAllxzIwCVathTMX5iyHMgHlmuBMxzrXQnfSnrXZIoWC8UfiEICtiByYeiZUQFpKCzKLB03fTaaiHN7TUO48FXcM2uMbcr810ng7i8hbhIYFJ6Jpk=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AS2PR02MB9583.eurprd02.prod.outlook.com
 (2603:10a6:20b:598::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 13:15:50 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 13:15:43 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Add InvenSense ICM-42370-p accelerometer
Thread-Topic: [PATCH 1/3] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Thread-Index: AQHdJaGomIpO123FRkKclVXVzEFxnLaSYFCAgAAyHgA=
Date: Fri, 7 Aug 2026 13:15:43 +0000
Message-ID: <deff886f79aeb38674e090e61aa7ff45debebac8.camel@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	 <20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>
	 <20260807121619.000078c9@gmail.com>
In-Reply-To: <20260807121619.000078c9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AS2PR02MB9583:EE_
x-ms-office365-filtering-correlation-id: 07a6846a-bc73-42c9-2484-08def485fc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|6049299003|376014|11063799006|4143699003|38070700021|56012099006|10067099003|22082099003|18002099003|4053099003|4013099003;
x-microsoft-antispam-message-info:
 isFd1Mhb8FggsnAPyiStpcwJKbzHOWJ06qbT6BTd2R33SkYcvlH7aoLBdVnpBIpos11T5vHpk5/9MkjcMGTC323F0MTodb+3NQ/BPmymIzquxavIt+CDTcV3vCERGY6o5N2X6FJGIE8V8SuyKhDZsZVs1/MfZIW+HZqYmVN56LBoQmDryyph8bfan5cEJdrp4yVwQ9+GNzaXaKeISOnz5oWkC4XsbX15i1lXc3xlnKPlgKyhsDWLRcqlI3h135Ho0uZ/hF0PFdd6XKPDIIcls6glbxRxeeFiuT4xgHtxLlsETlkPN7ba2Iml8SjMcb0cK07fqddJVv3kex2Eb2PTC1ubZrRohZA+CyKw+LPwuh+jUBk/v6l6AGHBACi1fEWb4WG/wUOwn/PaeBnFRaqBWjvFij7Y1ONQUj/yXTvEFCGk0BOyQcUKjuy3Ru3DFCF3w66wTeiMzIjEuEO774fUBGrKVbHtpPcWdTxpqJp5qdUlQwB2nZYC3cOKz68AnPwR365pb+IQkexnA31JPjTO4lombtN5TXT0bvkxbQrEEZmTBU7YYpdzU4LOeV3ky+MURzsY3nhAqZL4KbFALfMQW58+3mr+1CVdmkSx3u8mk+EvQGqKJsxM/4Ic03n0fEB+XlC2dukTuCPhfkllQ1mXJ0TdeZPsghOdhc4GsGAsC4VfyysbIp5ZPE8UebkANdR0mcubRYOG4NtseQd5N/l1gg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(6049299003)(376014)(11063799006)(4143699003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(4053099003)(4013099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3ZKWGRFNFk3Rkdyd2oyOFVEZ2dPdTNEWk95eEJpaEZXbUZ4Z1ZXZDNEL0VQ?=
 =?utf-8?B?Uld2Z2UrYUFpUWpydm4rSElVY0FHcmtIb2UvdWxiSHhNOVErNTBCWWlQa0lQ?=
 =?utf-8?B?TktrUE1hUUZjaU1scElPK0RYb2JHSTU4NzFjeXR4dXVULzZROTZIMHo3ZEJL?=
 =?utf-8?B?MVVLaGpqS3phUjFCUzB0OGE3M214VWJnNlkyV1RXMFI4SlNwdmNSSUdiRG5J?=
 =?utf-8?B?SmVvTHhDd2NJRkV5ekZ0ejlQcElEd2puVUIxZVlGSUpJc2VXWHZsR1IzQ3Yw?=
 =?utf-8?B?RWVOV1FWc2tjcGlKMEJpa01rV2x1clhBWklmenhSWEYyUVM4ekU3aVhUK1Yz?=
 =?utf-8?B?YnRyZS9sQXpQVzBFcHF2cVg1bDFWQUF6N1VCenlnVXk5YUw4TExiSnBxY0g0?=
 =?utf-8?B?V0RKa3ZXMG1SYnZBWjNzTThOZ0tDdXh3azBPcHIxY3NFVXNtdldTRHVxa0JY?=
 =?utf-8?B?YVJ0UDNvcU5MMnJnSjlPcDZzd2c2VlQ0dnVyNGVTZ005NjJFNnNFeVMxWFVG?=
 =?utf-8?B?ZE56MDhyUzdjKy81d2l3aWVGZTJRUU1OR0F5NllFdmkwZDYzelNMNGxSZVl2?=
 =?utf-8?B?QUxxVmJwbkR4TlpaOThYYUZDVVNiSjJVTVV1dCtmS1NtSDRFeCt2Z1RCdWFa?=
 =?utf-8?B?cU5iZ1VJZUNucFBNMS9odVovM3F0cGhhSG5rTEVFQk5OZXR5WUNxRDl5clJp?=
 =?utf-8?B?RjVtSHN4N3p5b2U1YXMvcEhES2J5MkR5Q0pmK3J2d3Q5azArcWtPb1BaNHY2?=
 =?utf-8?B?OE9XOGlhRldlVG41YVY5bm9PYXhPeTdLOVNUR05DbGh1Nk1hYkhuakF4bUFO?=
 =?utf-8?B?VUs3L202UDFVTlVYc3ByakhUeWJUSG9lY1QrSnZZNVlEWmdSWEttS2pxWUY4?=
 =?utf-8?B?MUc3VEZCY0swY0NqNnBTUlNIUTFDOEZ3RjQ3TUkrVW9SVWd6bzQwc2Ftdjho?=
 =?utf-8?B?Rm12UWxLQldFaERObGNHNkY2VXcrK0F2SlhRSjZiTHFGNjFnOE1PZ3lSckZO?=
 =?utf-8?B?QllMdnUwMTRuckIvdzBTV2V5cWZOSVlxNG5EbHNJQUFBZVNLcHB2VFZwbGhB?=
 =?utf-8?B?NVpjTzlTK2Vnd1l3SGF0QkF4NjJoZ1dzMmZpalB2ckpLT3docG50RnAvanFS?=
 =?utf-8?B?WmZ3QTQybHRUYVNnNGZoNGNNbWgxb3U5UzAxNll6VXNyOS9JWlhCWkUvQzIw?=
 =?utf-8?B?Ukp3enNBVFF0WHd3Q3RORDZHLzlLZXFHc3JubDBQWHFXWXhrbEJ1OWQ4bzJ0?=
 =?utf-8?B?QWp0VkVVOUVEK1ByamxReER1aXFaT05GWTA3N0N3czY1TXpUMjAwY0NUakww?=
 =?utf-8?B?blF2QzVtaVh6VkcxOEhZcGl0NFlWOVdCSnJUK2oxRjdUOEpqS2pxcktJN2t4?=
 =?utf-8?B?RzcxRm41Uk0vbTVRN0VNRS8zVm9neHM1RGdHeVlMVkF5SzBwV0hKdmV1QUU1?=
 =?utf-8?B?LzNEYWhGU3MrZHVGZkg5MUtaOFl0UUhvRG5CMzQ4c2hWVERMTFBibzVIS1E1?=
 =?utf-8?B?VXFldGFuZ1g5TkJwUVVWdkduMUlFWG9QZi8yZk1tdmtPT2pvdkxUQzFXbzNn?=
 =?utf-8?B?RmgzVExjOVVrOThCajljTWRrNXBDSkZpN2N2YUZhSXhrNGFmaTNVUVB5TG5B?=
 =?utf-8?B?YTQ1QUo3ZHc3d3YxV0VBZUZ1R1NIcXFTTHZ5NklZQm4xb2M3VUNDWmFsWW1n?=
 =?utf-8?B?Y1ZzTjJqc0FCelRJb1VqN0hiU0VSQnhQaGpvemdaRkdVTitVeHVMMXl0R0xt?=
 =?utf-8?B?NmUwTEtXNUdGSmd2cWVpTm9CU01yYi9MR0doMVNYUEdFdi9EN05qd3hPZHMz?=
 =?utf-8?B?UTJHWEtTbkk0aXNhSGM4UE0xYmROdm1CR1dDT1drOTZFWjdHZ1JNdFNCeUZP?=
 =?utf-8?B?cFExbStiZ0E0bndVcFUrQWNmU2RFUlhvcFNVbURVVy95aGduYSs0SHpSdlhq?=
 =?utf-8?B?RHpPQXBSTTNSbHFkRnZqSWxDaHhGWmQ5YkNqVmx5VDlaNE04TVRoUzFSaGVp?=
 =?utf-8?B?bWVuWmNjWGxhcFpTbTNQSW5qMGhuMms5bzVxWHVRdVR5SDR1UVFrbzZKaTUw?=
 =?utf-8?B?eWpNalVtOExuQTZHSVVFTk1pNU5TM1ViUE1CbEtzakdBYWR3dlZkTE9qQlVC?=
 =?utf-8?B?cThkbC9uc0x3aitJTWhLa0djQTJHVGRjNmZGMmk4M0hUVHFiT3JucGNqdGNH?=
 =?utf-8?B?ZGo2NG0rc3dlQ3pZOEhVbzh0YUF3WFhKTEVVSC9ISzByaWwzNC8rdDBYRjVu?=
 =?utf-8?B?aUVQcFNBeUhaZUxBNlgyVC9OaGR6YTBadUs4WXFHT2VSbHFIaWJqZEpvUFRw?=
 =?utf-8?B?TXRCQkV1QmppNVN6YnBJQmhxUE5tdElQdzFQaDFRUnF5UWJDa2pDdz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-Rfif1dSoLpGyRcUFxJBp"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a6846a-bc73-42c9-2484-08def485fc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 13:15:43.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJVyUfZ9z47wQNEwNslWfl1tzOuk6wQphv2v4ZCvJeXUKXSQ9sn8CL6Us9lmf79Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9583

--=-Rfif1dSoLpGyRcUFxJBp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for reviewing the code.

On Fri, 2026-08-07 at 12:16 +0200, Joshua Crofts wrote:
> [You don't often get email from joshua.crofts1@gmail.com. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> On Thu, 6 Aug 2026 14:46:27 +0200
> Kanak Shilledar <kanak.shilledar@axis.com> wrote:
>=20
> > +=C2=A0 vdd-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Regulator operating range between 1.71=
V to 3.6V.
> > +
> > +=C2=A0 vddio-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Regulator operating range between 1.71=
V to 3.6V.
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - interrupts
>=20
> vdd-supply and vddio-supply are definitely required.

Will add them in the dt-binding as well as other properties suggested
by sashiko.
> ...
>=20
> > +INVENSENSE ICM-42370P ACCELEROMETER
> > +M:=C2=A0=C2=A0 Kanak Shilledar <kanak.shilledar@axis.com>
> > +M:=C2=A0=C2=A0 Henrik Grimler <henrik.grimler@axis.com>
> > +L:=C2=A0=C2=A0 linux-iio@vger.kernel.org
>=20
> No need to add the IIO list as get_maintainer will automatically find
> it based on the file path. However I did notice that you have a
> company kernel mailing list, perhaps add that here?

Thanks for pointing that out. We will update it to our company kernel
mailing list (i.e., kernel@axis.com).

> --
> Kind regards,
> Joshua Crofts

Thanks and Regards,
Kanak Shilledar

--=-Rfif1dSoLpGyRcUFxJBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCanXafgAKCRCslrbqDH4e
IPR2AQD7xC5nTviX4ROiPLKNCW/+38talNZm+oOjKSe/QmvgzQD/dy8gH8okVs5l
qMXIKB1bm8+9gV8hS/S3xBGKVtpBAAY=
=1MdC
-----END PGP SIGNATURE-----

--=-Rfif1dSoLpGyRcUFxJBp--
