Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA33AE184;
	Wed, 16 Sep 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551031; cv=fail; b=D4pzlpzKUYS9kfeaju/bFi+G0twKPnDcGgMe/W8nuWc/neiYyAitMawCieSWk6YBy3Y9VEiD9KfJlDIAL17WvLoE367YmpvjFySP8ndeV2Tx3KcycvKmDHRwqataqbMaVCyqBncMidWd66ssM1d3jRjRu/HOfQ/m58ezt+tMcIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551031; c=relaxed/simple;
	bh=lEGai8/xvmS84mskoDcuPJd+lXE2SwHXVIJqmukvVRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxV5imWn3JS1x7vBgRfjAGbvaN6ERiaHlKad3SDGzPOjbwPmTl/ZIjSpvkNcJrtP/xOW4TTalJ/EzDLXi3qmbfOAJzL1cEXq0Ux5t6RjUmkRLfBSe2uZLKSILisboASf4amheg2sec+2+uQSK7iXyJ8h8yaoZCHF6lA+SClX5QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=SSd/NgOV; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="SSd/NgOV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwPsAiWk/K5nPVgv9rajdIFhPwWpt3xwCjhyPA1YXonc+giwMGfgpiARfEF+nvSvL+iCeCQkxdHVwZh1dRp/e/KwDt4kkHLR1/YCyxwS6/4GnCVI6vv7OS/5g6bTsf1UOx7NMiGtYm4fBNWH0qXRTHVKUowsRWt0nIYuVcDJW6d3/M4JSBUziHX3188/3GlOh/Kpr9lQIYTJ3CQ7tavIDFRWLYYWmBn+UAWzR7fSIfdecYf3Qcs+1THWHmlzsMRQf2Bd52N1+gQA9RG3+wCComGN8cF8o5oBpceFg9Hg/jx1dunCVZkeYoI1Jqeh7tS1WUuxmm2D4MeaEaMbyYFOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEGai8/xvmS84mskoDcuPJd+lXE2SwHXVIJqmukvVRI=;
 b=FGJywStYBJYZX4sd+IPbunxOtu2o85/8R8hBZsj1BlLHhWH8QnXbTe6KO+XSH7YoEJkwoiPOtVWGtvwkHjcM1BKrQ0+Ry8qu55q5TxjdtvGernZpeDoFKBDD9vgoBdBnWb62lurszbe3VXoq9v2BXhEZJrtdpV4w+FZh+WRRt0KxIJ83Vb16hYJnBglo4PUdChfVAfaSHCWf30V+UQypfrtILcSnqsNtcnu4No8qdYYnCmJmVZQqt+B185MxqN9r619A2kWcxdVQr1+ddh/TKNPH+J1jfC1Q6pwwxqMhE6nxnn2aEBdK4N75Qgm5gjQU+mKLSxgLg1GPuxTcNk5Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEGai8/xvmS84mskoDcuPJd+lXE2SwHXVIJqmukvVRI=;
 b=SSd/NgOV16bBM9AfokzM+2wb8AbLYyOw+dTyny1NdOnm/oqW0ayAY1gvMeS6vus38bb9OOd4gz4eTDIXINmys532PbEEisJg6kuuwK7kbJSi7JYy03sfIQCGUAsRrKX9iaNPR5zIsaGiHLr1bfepxxqIyYeO/s4D+Ah0qj5esow=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AM9PR02MB7011.eurprd02.prod.outlook.com
 (2603:10a6:20b:267::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:30:17 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:30:17 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"Jean-Baptiste.Maneyrol@tdk.com" <Jean-Baptiste.Maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kernel
	<Kernel@axis.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Topic: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Index: AQHdOh87FN81ruWo+kuBt7z8nBLE4rbDCmqAgA39TgA=
Date: Wed, 16 Sep 2026 09:30:17 +0000
Message-ID: <2537d21c50da4e74107244010f1ce193b3fdee26.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
	 <BE1P281MB1426CC3CADAD2D34138C5886CEB22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB1426CC3CADAD2D34138C5886CEB22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AM9PR02MB7011:EE_
x-ms-office365-filtering-correlation-id: 1055f9ae-8c0a-4a6e-8a72-08df13d51e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|23010399003|376014|7416014|1800799024|4133799003|10067099003|4143699003|56012099006|11063799006|18002099003|921020|22082099003|4053099003|3613699012|38070700021;
x-microsoft-antispam-message-info:
 fI/mN/73d4oN/js12U4pO3Hvu2LIcCogg1FYVtXW9PdO4m4UGJ/SBla09PJYA49QY9aI5ztPJbFf67Bhv3xK0I5FZKwSkwlUI3qWhcQq1P5kAKagG+2yCYRgtDxxeyYPqOWb3kBbloe3Jix+H5H9ayPxX23viTGR7khLcd0uVeoRw3vC7hfKZTRZj4h44VT74LbL+30sIc7zBF7DjcOvCll5n47axa1rvqzbL2ePgkigpq9oFFwxCelGVFK7U+px+JizvE3h/+w4UV2u1hhVFSd724BRSh+dIFj5zvuM+oWoWh0UdM004BzUf9SHwynFFXuK0HvFlmFsuLEjzB5fCpdT9R2TpJ1ps33b8cWpzUirjIhk36FLMC/5W9ShYeChSgFHKt1Qa+jmFmtHOIqCoaJNgf1qXDj3tSl+j9COp0oq2RolBsMSe6ORMuSB6ht6d3j9G8TfnQVWmcbh1RwQD90zizdhUZl5LtZK3aoWLkXMcXqZAn6ke0eFN96EkT33EP4bkOQa1VUv7BWHFZPJidPDq2ZJ/7tcWvsLMV33BDfbx3scUTqD6Hwqfqie06xWoDJmqno4wLGEEr6Cm/5zERUuPBJlivKU9F51vI+X81u9hv+ZouvcJJ/G/Eej+OOb0d7/NE4vqRH15+3sds1GaEUe9bIPRz1wfoIDNynLaBqFJK/H9DwFY651e8JlCXgFGkPFt0L8NueNziYuW/zlqgYNaFtpUwsYkZ0UUhDqwAQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(23010399003)(376014)(7416014)(1800799024)(4133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(921020)(22082099003)(4053099003)(3613699012)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2Vzd1pVcVVDM0VKK3RWWXlEYWNwSjZZWjBZUGE5SU45ay93akJlWFdhNW5z?=
 =?utf-8?B?WWlxMFFQU25FeGQvek4wTVJsd200c0lENVlIemhZOXJYYWgvMElNZjk0R2xD?=
 =?utf-8?B?NEdBQVNEcGlySzd3M3ptckNXemEyMHlwV1pmSmNyQ2NNakIvTmpsL2l1eUNl?=
 =?utf-8?B?TDVMV1J0dlpnQzV3TUtyQ1h3U2s4U2RnTGlkUGtETnNtQTd5eXlja0wyckE5?=
 =?utf-8?B?WlNRNEh6YUlPYUFPdGJ4NitobVFpV3Z4RzVxajBWVlpIc3dKWjZGVUZZQ3N1?=
 =?utf-8?B?ZWlScWM0d2N2SStsVHFIcFFuaDM4WGl6bW9xdDBNdFNmTXZRa0lueEZ0ZStv?=
 =?utf-8?B?ZmowRWwzblRXQnFOZFhKTnJLYkJKbXhwcWFNUWxvSk1lV3VFaDQ0bUltQVVv?=
 =?utf-8?B?RUYwZGZiSS91REhOTUxmTnNtZGpTNGtwbnprVzd4bSt1UlNCNXJXRXRlY3Yx?=
 =?utf-8?B?Zjg1dzBjbjZnNzBTQURQWVU4ZEluY3pZZ2RJYnNibGRNUUI5WGVVU2M1R0h0?=
 =?utf-8?B?UlZKSWJoS1ZxSmpaZnBrZkxlU1lwMjlzajVMN2ZZVkdhU2VPdDFBUFZ1REEy?=
 =?utf-8?B?ZE9PTWI2TTFnTGxWOXkwMnNHRFRzb1pnRFF0UnRabzB4UXh5dGxiSFcvLy83?=
 =?utf-8?B?VkRxS2RCMXVrVVRGZEc2ZnliWFJwbnBBVmlwQXhmYU9XQzBqSENpc2RqLzk3?=
 =?utf-8?B?UFUwanM0VUtNY2VhV1lFM3JFV2lOWkJOR2NhZTNlU2s3L3pmNmpReFJsM0Na?=
 =?utf-8?B?b2Z5QXd5UUliMmhqczRxdlhiNWxUeXZoQUF2UDB1d2tjcVc3TkwyR1UxRDhx?=
 =?utf-8?B?TGRqVXo4R3pZZ2c0UFQyMndxcXBSWTBQRzlRWGJnYWFIcm5xcmxRclVsK2Ns?=
 =?utf-8?B?Sm45NHN0cGlJZVVWSU9yY2RJMi9mM0Z5cG1HcXZlbVhJdGdKNWZ2R3pyWXlO?=
 =?utf-8?B?VDNLdEIvbzMyK3A0ZUdCdlZNclF5M0RmZ1BOWGxzcVEwMlJIcHhYaXZPU3dt?=
 =?utf-8?B?b3dnK0tnaHE1M0wvcXI3TmlHN0JqWnVDSkt3NmxSb2RjdXRTamRqZHM1MDZE?=
 =?utf-8?B?Q0F5MFZMMDJHcDFpdk1yeHJURVkweXFXVTdsOE9VRUphSnM1REpqMHdzMUR2?=
 =?utf-8?B?Ry9jVklyMnpXUmtLYnVyYlVEUmF6UnpRakd3alh5MnNESGxzQVJxZTY3Y1di?=
 =?utf-8?B?V1MwS2Nsaml4bWltSEpwdzVYTmhXL2U0cE5OWlo0UU1VWHRPd3BnU0piQ1BX?=
 =?utf-8?B?MHhEMWpMeDhaWXFGZjhVcVFDTXBLTzFMZzN4aFNOQ3JPVUVSSHBjcFhCQ01U?=
 =?utf-8?B?WWVaTTV0bXdoRSt2bjBzSDRwbEkzdGhqWWhhdEVLdVNod2lSY1BLZ1dpUUVR?=
 =?utf-8?B?ay9YMEYxVjZmNENTTXIrYmdEb2ZkWUJzbDZMc0Zic0xsOHU2SjhpSFBZOXdo?=
 =?utf-8?B?cXoxZEdybGZhcHhpekJQOXZvUGxRdG5tZldodlVEUXQ0TjJaR0N5RCtEVkJJ?=
 =?utf-8?B?QWZoYjNodlcrN2pwYnVEOWxGVklNYWNlOUs2S0ZmT3NFNHU0OGRYeE15Tng2?=
 =?utf-8?B?K256a1NrYkFHOHY5dWdXUEhhRzdqN2lUMVVwdmhXM29Sc3UyTExieUs4QzFI?=
 =?utf-8?B?NUNNaW1FQVNUM0JPK3JVck5pLzV1emtNWUJJTzZHbHVralpTL0wxYzltZHov?=
 =?utf-8?B?VE1FTUVKUlZlck1XNWdVSGV3RjFyYVBQeDBiUWNLWkJHVmZjaXZXL2ViaUNF?=
 =?utf-8?B?YjZlbk1oR1FTVUNnNXh1TmFsQWZLMk5Kc2RnWE1STW1jUlNzODdDcy9GNXJ3?=
 =?utf-8?B?NmJYU2lIRDdGcHpvcVQzMm0rdDhpTEFMclZ3SmRFdDdMM0gxZlB6eGI5NDdE?=
 =?utf-8?B?UUNva1h6YzJLOUNCQlE1Ky9IRFIzWlhFUnVWeVNpWXkwWXlTVFpOK2pOdWox?=
 =?utf-8?B?dHRCT2RLWDMxQk1nUlM0UkE4UExGalFxNzArWkt3OE8vam5FNFFQZExKVWJ1?=
 =?utf-8?B?TloyMndQQVRvZ0RVSDlSMkptUHFXWVFYdEluOTlaSlIrU2ZiSDVJbkF0bEVB?=
 =?utf-8?B?V01EQXN3cXAzTnE2MW5xSzFEQnJzT1Q0YndoMW82UEVLNTY3b04rVVFDVnRV?=
 =?utf-8?B?TjBIM09GRkUzeEhFdy9jMVhxNldjYnN2TzQzb0RPdnZZZDIvV2hORHhKVGJB?=
 =?utf-8?B?ZGNmb3RyeTQrMng2b0ZDME1QdFM3WnJjMzQ3RlgzOGl0M01ISFVQL0Y2YTIv?=
 =?utf-8?B?ZFpQcjlCcGQ4aDZYMGpVMzJhTkxudzFVRmxUSnFOSVN4UmppTzFmTEpWSFBi?=
 =?utf-8?B?N2RXRFc0REd3RHJHUStLYlJNbWRBTk83Uy9jbG9lbzA4UktVT21GUT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-6R9Tr7LSowkFE7pgc9uO"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1055f9ae-8c0a-4a6e-8a72-08df13d51e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:30:17.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJvnYmP2haO6AtAt3M52O/z+ATLNR9gcEorzdcmyKsey+KoLyVtncV1dFD+CnMS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7011

--=-6R9Tr7LSowkFE7pgc9uO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jonathan and Jean-Baptiste,

On Mon, 2026-09-07 at 11:52 +0000, Jean-Baptiste Maneyrol wrote:
> [Some people who received this message don't often get email from
> jean-baptiste.maneyrol@tdk.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> > The device supports indirect register access to different banks. A
> > specific routine needs to be followed when accessing the registers
> > in
> > another bank as documented in the datasheet (section 13). This is
> > required for accessing registers configured via the user and
> > implementing buffer support.
> >=20
> > Datasheet:
> > https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> > Datasheet:
> > https://urldefense.com/v3/__https://www.lcsc.com/product-detail/C512996=
7.html__;!!FtrhtPsWDhZ6tw!CMTPpmwpQnn9q5feyPtbKfDlZZxlAh6FLT3KngBIAt4pGu5iF=
9cjUawWbxpNVF6__BzwZo0XM8x2ABrLJ4I1epLGPQXws4rTlA$[lcsc[.]com]
> > Assisted-by: LLM
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > ---
> > LLM was used to improve the mreg_check function to include the case
> > where the sensor is in a POWER OFF or LOW POWER mode to utilize the
> > RC
> > oscillator for initiating the bank access.
> > ---
> > drivers/iio/imu/inv_icm42607/inv_icm42607.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 29 ++++++
> > drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 108
> > ++++++++++++++++++++++-
> > 2 files changed, 135 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > index a183a8566617..a522850e0268 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> >=20
[...]
>=20
> Hello Kanak,
>=20
> for accessing MREG registers I strongly recommend to create a new
> regmap
> structure for handling this access. This way, you can use the created
> regmap
> to handle all registers access without having to check each time you
> access
> a register if it is a normal or an MREG register. Having dedicated
> function
> is very error prone.
>=20
> You can have a look inside inv_icm45600 driver that have the same
> kind of MREG
> registers and is using a regmap for abstracting the access.
>=20
> Thanks,
> JB

I will rewrite this bank access patch to match it similar to how it is
done in the inv_icm45600 driver.

Thanks and Regards,
Kanak Shilledar

--=-6R9Tr7LSowkFE7pgc9uO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqphqAAKCRDEY9j7t8Ka
Z9xwAQC53XFpMK2MdvxJCsL7KTwR76QpwTW+EcXp4Yb0lgi27AEA5RmkklPz6YJU
bEiBcDTWqOwo5hlEtxtjBUtQZ3mrPgc=
=my9E
-----END PGP SIGNATURE-----

--=-6R9Tr7LSowkFE7pgc9uO--
