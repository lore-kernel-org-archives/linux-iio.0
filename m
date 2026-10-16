Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883431326A;
	Fri, 16 Oct 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135135; cv=fail; b=Yu0BU7t72klye7crFAVDAhotljMum8LbpVFYZ/BcEJWsoEI6lTbX5wD8ALznjUh+Nca3Vm/C3Qf7Q6aM+Tj/cLKMz3eCx+6kfyq9c3E71VNernfmldN6zJVA86rtJbSfmrJppXfR51/qI18zElA7ILDFAY0n7O+ds71k39tTXn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135135; c=relaxed/simple;
	bh=DjsQCFKFB8BKsJAaZ5sXbt3pZuXTPfGDbud6+n8GKic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmo6SC+5fQHC2S3YvZHJDjTf8FTRIg/wIeiPpBhG8B0CATf0AJGZ3nPllRpHhb+JxHYkQlpfXdZDUtlmWn9ggW4n3J4f7a3uzwey7Cmu6veO3iyJ+haifg97t0fD3JOIPwGpSic7mpQX3yiFIeSNUATW/1l3ct52WdEVH5FGJZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=c5Gn5uOp; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="c5Gn5uOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDSPuunkRwRJtYzb0jhrcHETsdNLQcD0jbH+QfkXFyx3wUvC76UddgpaYgsnQkEmGy3VmzSBin2z6mjskHySVjmKc0VcOHYmZge6hkh/EAVn1eIHIKkjFqvIFWkz3lVuj2W7yf9WV8gNZ5pGBcBtFmxTwHrVKZ6oEQ+gqNNwgr+3VKmBckwspaRhLaLVQuCHoTQJ9QWUZBOAAcXQFM5sNbMZSbvXoNecl7vqIC6UrJv1aMwu+XBf6ixNO4zu89WwEZ2U9rcSS5zmDsNdscXOMj6XdweN078hTHWnzOCrxKLojuHS6Ab+S7Y2IAP8Xw3VunpfxjvTH5jGFjOIk7zu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjsQCFKFB8BKsJAaZ5sXbt3pZuXTPfGDbud6+n8GKic=;
 b=OzezsI3wh9thxnYwsT+sxvj22CMy4KdL856SAS/c6O3ZzxNin83Ta34s/Pi6GMXYDUrBLKWkogj1KFH5npv55KcB7nooKX8jZjp5D0dUuYp58u+ObzrEoD3ACvEYjLQNGIJ7WLFv96srncixphxqGpZvhQelI8V7XVauvvZ1e1P5oo6U7ryglZmb/Ww3bXsw7XueABgGof4w+Nu4UZ27noAT+Eecdxemp9LLfSQ5E5tVi+xLnNNJ2q4KWMuSFOIL8KQNjXHkFD6cGj86cVGeO+gy3IgeYtiHJsLrITnhLJ/hJ/sYjM9HqL28ABeaVQQBS2RmFoS//rI4TLQsbb9sPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjsQCFKFB8BKsJAaZ5sXbt3pZuXTPfGDbud6+n8GKic=;
 b=c5Gn5uOpxA3nGhuZCP4rSjSNcDlZOxTATAxBNw05noqf49RSDOP4AKXlIQsfO94Vw04F22KwfEc/XrX54ERE4YKb0faFwplzdd+B0XR4hsX2aWfio794+VVlKWRTFVl1I1MYSglPLdkqxfAgXdT/9qPEr3WKD1S0iDuRob5EXF4=
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com (2603:10a6:208:101::12)
 by AS8PR02MB6935.eurprd02.prod.outlook.com (2603:10a6:20b:2eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 07:18:49 +0000
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f]) by AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 07:18:49 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"Jean-Baptiste.Maneyrol@tdk.com" <Jean-Baptiste.Maneyrol@tdk.com>,
	"krzk@kernel.org" <krzk@kernel.org>
CC: "joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	Henrik Grimler <Henrik.Grimler@axis.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, Kernel <Kernel@axis.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Topic: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Index:
 AQHdV/g5mhUaUBhwpEy4+0UjMNacsbb5n9OAgAAdGoCAAAEQgIAAvSYAgAChxoCABLBMgA==
Date: Fri, 16 Oct 2026 07:18:49 +0000
Message-ID: <1804b94e69b11377a912ab82dd00303cf0f60e8b.camel@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
	 <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
	 <20261012-adventurous-corgi-of-fury-01219b@quoll>
	 <fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
	 <da8b6047-419b-4c3d-8416-e5c871ea4dec@kernel.org>
	 <as1ZPOocclBgYkko@debian-BULLSEYE-live-builder-AMD64>
	 <BE1P281MB142642474354814F0785CB97CE9E2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB142642474354814F0785CB97CE9E2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5281:EE_|AS8PR02MB6935:EE_
x-ms-office365-filtering-correlation-id: 3b8a572b-a185-4c5d-cfbf-08df2b55b985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|6049299003|23010399003|7416014|1800799024|18002099003|22082099003|10067099003|4053099003|3023799007|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 PJc8dk5wXZhGR18cJ1oVFD/ZD6yRcgjOvUAdO6BhUAwiSFAyVlpCYTC/rsn640YTPsiKeXRmy04p67eiUfXfEXX36SbX32ZEAgMg6wSaG3xySG7+45UgsC3+EIVh5qLxyEe5gAAKkR9KYR+mkbAJwtkDtGukrCCPAeNZ6iwdDhGt3mi6u7u5pUHdsirm/OqoYksaFOQeE/kW5hpAAxDcHfBnrmAw24RBXCYAT3mL8ixnHUg7Qdv/0BKw648PAyGzosJU7o3ev2ALQwQdaiwRtT7HEzldZaivYEVui2H45HQgrbJM0fALZEsjO8Ar84+e2J08UsX0j/xdtmssygI3+d0lMgF6i7qyUMtCQYqJ5s9Gt2J2CaQma4/YNbMXB0pr4mX32zJ5dfVcE2iol1H3hf40Uy04z+LucYTWb6OT3GI1PvF3SGOhzZJuD8p8+J6ebo6hj/UsjrmQA/1nJZow78C8tQmlJTRk4tkbyhDDDLbzC5M0vb4QgYzx0dkl5yEK5jBbKgyqQThoNW/GX8rJ8tcvOS/mxfUBvfi4d5vGPu99ktS5YL3Hv3Vpypvy9zmGpIw6uUo7p+qZNjDheEar5pPF0MevioNRxcuYOrejkFJd9eHJZ2u3NTl9eDuYAF+JIfbDvjwRV6kMBordff3iRBfojCeoyJZMutPEcp6lP4bBO2nWBiPi+wo25D3kv1g/lEQ0iTyCqzi58gWKuCNhLCu4v/MZrktj7UMa0io9+oI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5281.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(6049299003)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(4053099003)(3023799007)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFlLd0RRemVVRFpSNndFVFdmMTVKeVRpSTRoMTZHcStDcmxsbU9BZXpVN1Rz?=
 =?utf-8?B?bDFSK2hZNy85UGFqbUlUY0M2aU5TSVBRd3NGTStoOVo4bE05eG5sTjRRNkk4?=
 =?utf-8?B?ckhMcjhHYm1YS1k1RFpkeU95NzlkT1VMSWlkN3pYS2RCc2lUSGJnU1RNNEdK?=
 =?utf-8?B?dy9Dck9tQ1lwZjNUSGFwaHBBK08yUGtoNkdSMFJBcllNTWtCeWdkQWIvbGxV?=
 =?utf-8?B?S1BZeGJpUytpclBYUVk1dUJIcVJ2WHZycW5IMzFYdjh6TzJYNDQyaWZLSHIr?=
 =?utf-8?B?MWJoNEJxUmtnNkcwaEtBY21oWTRhRmx5N0FXVEhGZEtHNzRVbW5EUkJjYTA4?=
 =?utf-8?B?SlVKaEVKcHU4UHEwWFd1RDBVUUhTM3JBc2cwS3FpMVg4UGk3QlR2NHdvdzVX?=
 =?utf-8?B?dDRZbDRDd21JN1g5SGlKNlI1clJHMEhCTmVDM3d1YUpPVlp2Sy8xS2xORWx6?=
 =?utf-8?B?bnhwOFdXOVdEZHJGZm55ZHl5Y3dmWDVZQzhPaTdTbDVSanEvVzA0VlM2MjUx?=
 =?utf-8?B?VldoVW9pSVNKZy9neVJvdFdIZ1ZDblZEbUpGeU02TzdHMndveWR3b05XVjRk?=
 =?utf-8?B?Tyt2THFyT1FSVEhpeWNsS0pITThnM1lHSDVLM2tzNklPOU9qRDlheDhvYllH?=
 =?utf-8?B?dE84UVo1WHcxNWZUTWdsRXhqbGlJV01QMEQ0MFFQblpvY0FmcmptUkk0Qk1l?=
 =?utf-8?B?dnYwZ1c5bnBubiszMEFXczdFUzhaOTVEUTduN3J1alRBZTVGQlpwVHdiSFlr?=
 =?utf-8?B?QVlwN0cvcXZUZ3M4MktFTGtNQWlWL3U5RVBPNFBHempTKzJmN2EzT2dQL1JK?=
 =?utf-8?B?QTlRckVLZ1kzN1Y3NU4wczlPakkrdXNRdlgzbDdFSmVHNS9sTDNEUC9jQzFQ?=
 =?utf-8?B?RjkvSWtiWkZYQzJNaSs2UE9lWVR3bmlOMDhHZTF4NE1FNWw4ZjRjenF1MlRv?=
 =?utf-8?B?WWtEZzdpbzI3UmpSWEdoM1NPdkswZmhqSzBmN1UrLyszL3Y4N0c2YkUrejV4?=
 =?utf-8?B?TCs4ZjVWc2JPK1FnV2J0N2VuWnZEYm1CRm1WclVYWnhadXdrRWROVllNRlJM?=
 =?utf-8?B?Um55YjJKem1FL3QxcDdJSFJ5RXpHT1JzUzRydlYzSkN1NWRMai9odFgyZUlk?=
 =?utf-8?B?ZmVPRmtseU51dlN0ZTljVHBGdTJPWlg5NDMveExzVHZLbmFwWkJ5QklDUU56?=
 =?utf-8?B?bUxTdWIxS0VpV1FsanR3V01SU2U0V01LcDZLSkxGQzVJdTJDQnV5c2w3ajIv?=
 =?utf-8?B?MFdNSVJLZGNlWWc4SlBTdjgwOXdDeEZOOHFwcWx4aWpuZWpwb2RoZUZMK1RU?=
 =?utf-8?B?VmN0VURDTC9MUXlydFdoUUJER1ZtcnJPYjFhVjVUUndDbnFkQ2IrS21OeHZv?=
 =?utf-8?B?SUZwampOa2FDc1AxUTZXeWd4TjNmRUdsTzF4L3FMRmpwaXNCRHlpa0w5cUxH?=
 =?utf-8?B?cFdXcHpjMldENHRIelZHWUc3aUREUkRDNzFGV0gvbUdnWFZSeWpqYzJ2K1ov?=
 =?utf-8?B?UEVqQ0toNVhvcTZtbzdjYktNeGdlNmV2NC9sSVFHQllOTDUvcXJnNzlBc3Rh?=
 =?utf-8?B?RnhIazcxbm9nTVIzREdQSHBNb0JkR0ZSUU5Ub21kSTZyNVFsVVh5blFFaHVW?=
 =?utf-8?B?dTk2Sk9vbDVaemU2bENTMmhsbk8xU1p5T3Y1b3JaSG1WY0V3WkhNYk5aclBl?=
 =?utf-8?B?L0RMTzZ2RyswTXphY0g0OG5jVGFCaDdKSmd5NG1NVmZrMEpxOWhpVGRLQmFj?=
 =?utf-8?B?TFErSlRMM1g5UFpldlorQTdpdklQWHB6RGIvazhWYlo4dElteWVOQ25jdWYz?=
 =?utf-8?B?WmJDZEU3Z3FuUmhwMThQdk1QclBBd3J2bkVRMGFXcHlFbHh0Z1JzazF4aWpw?=
 =?utf-8?B?YS93M0Eza3paYnZjeTdXbWpyZ1MwejNQbS9tQTJYcy9QZUdRNkt5cU1nMVNE?=
 =?utf-8?B?SWpISlVITjl4dW9qZGx5V0w5Rmp6Y1RuRHltOVBMVnB1bXlzSGNPZkZ0SDdr?=
 =?utf-8?B?bnFhVnNvandSVU0rbnJneXc3SkhBZGg3R3QzUmFTYzROMGppQXJrRmd3aVMz?=
 =?utf-8?B?V3VZTDg3aTN4a2hNTkplL1F4Wk5QZDVqK3R4MVAreDJOdlZKSSttYlViRERn?=
 =?utf-8?B?bGw5R3NPMmJ4UGk2SGhJMlJZc0hBRVkwVG1JWENIQVVZZDU1UWlkR2N4RThm?=
 =?utf-8?B?UE9IbjBBTUYxR1c5NHZJQ1I4M3JpRm5LK1NZajRnR1p0M21lSm0vS2ppbkNw?=
 =?utf-8?B?RXBBWklqVWo5aExTbzhBYjJvdS8yQ2RyRDNKSy9IbUJpT2wxWWxLMTBPN0NI?=
 =?utf-8?B?NE4vcnJwTk1CeXRxdE9OVlBCcXQwOTU4TUdzQ2VKZEV2VXhWNzdJdz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-dPRVQ9eg+96EFLtuvHSj"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5281.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8a572b-a185-4c5d-cfbf-08df2b55b985
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 07:18:49.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oY4nRlmyrTs0CNkrlprHY3gaFoiswuR40y/6tIooEqs5qayGVlpljnsEWRjWwHhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6935

--=-dPRVQ9eg+96EFLtuvHSj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
> > >=20
[...]
> > > That's misleading or confusing. Either the device works or does
> > > not
> > > without interrupt hooked up. Consult hardware datasheet if in
> > > doubts.
> > >=20
> > > Driver support is different thing here and you cannot make it
> > > required
> > > later, because that would be unjustified ABI break.
> >=20
> > I looked into icm42605 data sheet and saw no clear statement about
> > the interrupts
> > being required. The timing diagrams only show protocol specific
> > lines and it
> > looks like the interrupt sources can even be disabled (not routed
> > out to any
> > interrupt pin). Maybe I'm missing something and the interrupts are
> > required for
> > some sort of reset function or so? Otherwise, I don't see how the
> > interrupts are
> > required.
> >=20
> > Kanak, do you have access to any of those other chips to test
> > whether they work
> > without interrupts? If possible, can you also check the data sheets
> > for the other
> > parts besides icm42370p and icm42605?
> >=20
> > Maybe
> > =C2=A0- if:
> > =C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42600
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42602
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42605
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42622
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42631
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42686
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42688
> > =C2=A0=C2=A0 then:
> > =C2=A0=C2=A0=C2=A0=C2=A0 required:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - interrupts
> > was a documentation mistake?
> >=20
> > With best regards,
> > Marcelo
> >=20
> >=20
>=20
> Hello,
>=20
> I can confirm that all icm426xx chips can work without interrupt by
> just polling
> the data.
>=20
> Interrupts were declared as required at the time only because the
> driver doesn't
> work without interrupt (probe will fails).
>=20
> Hardware speaking only, this is indeed a documentation mistake.

Thank you for confirming the requirement for interrupts. I will cleanup
the documentation in a separate commit not part of this series and the
driver should be updated to not fail if the interrupt property is
absent in the devicetree.

Best Regards,
Kanak Shilledar


--=-dPRVQ9eg+96EFLtuvHSj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCatHP0wAKCRDEY9j7t8Ka
Zw1wAP9o03mWu/s84P7U4x3CpdWGKCPRyiLO7Hv4dqCZDmAUfgEAhdIvFRjARRKt
alQD7ljBwPSH1gEaWNwJwjblAGH9OQ0=
=Vbr6
-----END PGP SIGNATURE-----

--=-dPRVQ9eg+96EFLtuvHSj--
