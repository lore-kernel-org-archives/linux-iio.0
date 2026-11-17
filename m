Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926565;
	b=qBi1xGN4nS9Q0bS7dKZCFbTzaRZllNDYbCz6+/B1oHmVk6pCdDJCq4WkkJGEE0Lm4Keb
	 bO6uc1Su1+XEjQHtsvaetFO3XhVKcDMp2yEER/DCPEjZDOGGD1w2y9tLQUv/6qXPSiCvI
	 xZSESOld9YUI1rs5NSEheqLE8wv+hBxTEGxxxNJU4XGwHXjWaaduBNn6S0fScke4Rh5vk
	 4WZ4L8LxbyGusCbSLZMGyx8llbXFyEVEn662IlMYWmlky/7HxSOxHSrE/QBM6Q6AaMVL4
	 HuQ4LZVcWiQZT75bEozyaAJpwHMFdWe5ukyEIyTuVCfS+LcHIq1w2DeP22RGd7NAH3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926565;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=tKShF1xVuuYP04qc7eFONC8aq66+yValdUf96L75JdI=;
	b=l8fmDn/Auw6C3CCo2v89sFAOrZGdQJyVaGpwg8wTlWN6JpcAPfn4n3+WDTs17ffeYPmq
	 FFkiW+9bcf4IYBlXlWpQgD8mCDVSzbcJhSK86jyMUKtT/0rledYYtBMM5vcv/oAzaaSfA
	 wgBRFm6dLVAvRGx8Y6H75T1clcBolqWCz0AQ1SqAbJ4axYf/cYMS2UWRthQHR3CmliQ4v
	 eCvM5WRCNe3X6fHx27J2Z9Ph0n33UsgXkvP+Vz8CyifZ330KAXL2Zs/5clj42ND3jdL8S
	 YYVv8FEApoVyQARfkVbY7Qy1LOpPhwQ/FHhquowr60uHPfk6g0K6xdi7iWs+hn00XpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=B7K+zlVK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.38
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010038.outbound.protection.outlook.com [52.101.228.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB66606A31C;
	Tue, 17 Nov 2026 14:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=B7K+zlVK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idhArgH141ZIvKon6KNQ6laLVjS0iz/rXS6CfKR59mJZRnutEgBLRXgLD4WBLTtMq2XYtYMHYPwyfRt+xSgGZzmjlnfrA0Hhvt98By4i//7gudEH4/RWctQ1Feisuljc/lLTMpwEy4ewEiXX395dyhcv653PGo/taT0mUUD0voROTgcUnvJGt8bRyywcoREQhsvw+zF83o5eK0Tk+Ecu+Zb0QZVSrejB7ylTwld2rH+I8sAy10ydshYZpNL7csL06qUjlKnu1SQg6mvLDKoIlfdm5J+/3bRMVsFHbKR3WoOSa5pFgNp8c+2e/CP19oYdwWnCaOHwZIvHJiRSSBe//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKShF1xVuuYP04qc7eFONC8aq66+yValdUf96L75JdI=;
 b=t8Oq+tKnn8GiMTx2lwj2OdB+tywcmLeHgfPjLaXzzTHwYq84e5HagxnG65DkHdnrYdAFSypA0RYLOkWwCq8E00x1WVeYF3jFpJDyuD70aWm/FKrgaRLEXILeMH0BbgL2sq7t0zs9FHituZ0XEvFXJL3+zeZV8gTEud4P6QzCM4FXkFWUc5puhDm8NPNmSpwkBLEszv1ZIgmGHIQRyXdJ/OK7ICUa7LMJ523i7/jBj1hSe8uRY0ypp2sJ8SyzC0ozvgrN2dIWO+bVRrjJblVUxDcc20nDiXWJIul8fQ2bW0d/8Yb6N3Q4C4R64h0S8LA3QrkxRaI58ecvGPDH/nYfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKShF1xVuuYP04qc7eFONC8aq66+yValdUf96L75JdI=;
 b=B7K+zlVKnbURiCcglPvdQHlxmsgSBtHma6I/lK8WkOVpz3q2Q5ka0Z40V+tjdMHCnTJBINdPREO/ta5D9RLSxUWi6Vaoh6VUaLi+TQrtv+lMJfTZiFhvZIXsXDhZnh58m6nyb8JhC8qSrpdJtbklOVNGQa5QsA8M4pLPXwrThe0=
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com (2603:1096:604:19b::10)
 by TYCPR01MB11269.jpnprd01.prod.outlook.com (2603:1096:400:3c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:42:42 +0000
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921]) by OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:42:37 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep cascade_counts_enable
 in sync with usage
Thread-Topic: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep
 cascade_counts_enable in sync with usage
Thread-Index: AQHddn5N90mT1xj6H0WlMorvKvY7bbcyUrQAgAAAx3A=
Date: Tue, 17 Nov 2026 14:42:37 +0000
Message-ID:
 <OS3PR01MB86672C1B41ED3C798046043F857B2@OS3PR01MB8667.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-13-cosmin-gabriel.tanislav.xa@renesas.com>
 <TYYPR01MB6603AC9AD34C12A598166EC8867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYYPR01MB6603AC9AD34C12A598166EC8867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8667:EE_|TYCPR01MB11269:EE_
x-ms-office365-filtering-correlation-id: 3c70263a-ee18-490d-c9fa-08df44b9067d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|6133799003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|38070700021|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 eqjnYMJkWKI8hkNsqFf9Cq2clx2nOtvTxKMem0yOBKokb8I4v0unMBfxA+RhfJTmPxRyQzy4WRuyhJ815QGYejdPeMzWFEpZBJ0CkVrvCYvXMLDdCt6K4oMBgV9IiS3gXUtDqp7ddEtGkYm9aI+210v6tD5uCC+u0t3blNHIUxQ97g1l1M4k8nanv3hw2+WVpdBa0oAKudUAAdtGBkaqkHGxklsOhpxkjQaXdzVvRxUjYNi39KNqbhGgMNw1QVuPiRvO73GHzubrZxNNS7mt3aMehX4mcQiVkdGHsJeio4EIh9HKiF8iS1xndD4w5L/7qecFzzRN4iIZ7HixGi8We5eDlYy/BXTP0BGyOfkp7n8SK0WReoOKf/eqo+At/eYaqWchaVQ+iaoKz1zMZPP/J7W6Cp6EwxPR/Tm4JUZyaQCDepCpnqOwxXE6eCQkepAaISDo8LlQLeaFzRJ4lsxsyMNNoOoHuJT3xbUrNziWm5/8hc5ocT38gFzPptjDl0OouaYo5/+iu2mQ+bCkGEMQOKGqTajXMy/N0nrl/v+nGyItrvCIBWzS/kLxdDWAmzA4pigqkoaBOYVJdT/QUKkZpEArvhSlr66Qy6VSgJRo/czzLnilD6NcJwkaM1JaeZlSQx6tLB/wgsel+IBUbth4qYK5dwti6XhwIIBc2y/H80fx4UON1mntpteZGqqqwQds9OTVBzA9duO4Ld5K0yBhrMMBhFRm3fhnCLC5xp3tPKo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8667.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(38070700021)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?c3tz0L2VkHg1gCwgnFdLxDfelGME96PieFEfrt4y77pKIvzlnTqs8/MOgC?=
 =?iso-8859-1?Q?FuFGR06ZHtDgoerVmXipHMeYqCDol6yqIvM3ceHgdLJLfUCr7sXUG+OwuI?=
 =?iso-8859-1?Q?14K3SAOkzKTs+VZTkAqZFm2/PoVXWk7zHhDKJbNxCxQ1U78cxA3jnFNRsL?=
 =?iso-8859-1?Q?h1RQbqgT202oMtNW7XSB6z7DFaca8hZyaw2v/Lg8YlM2Y6CUIBpNvSTUwq?=
 =?iso-8859-1?Q?IUYwHYQPQMgPHZjcO6GRGNeufc/iyJb9ZIgjfsXTtXkeiHImeHU4zm8sZb?=
 =?iso-8859-1?Q?1tO+1itTljqW5XI395N3MfIjvcpUYH00hCU1eCgA/EN0B9TUdwMl99vRJp?=
 =?iso-8859-1?Q?vy6+Qzb/qbVuLkDP9eFh8v3ur6MCe8A2RR15dTUG1S6qXS7AFR7JiBOrBR?=
 =?iso-8859-1?Q?OamoHVMosjBaxOm0WB/hkZi/0EjGZrDj9fYl3fdceb2BfACE5OhjEv9sco?=
 =?iso-8859-1?Q?S0w9m2/ICxoucffdQyJ2lD8dgYiIq8aHR5bsRFFNCFsHABmnKJrIjhkR9O?=
 =?iso-8859-1?Q?wDlsuuH1+I/M7YpA+jQG2QIVr1nIKgyll/v6UBCnaRhCEQklpIo1zkN/5U?=
 =?iso-8859-1?Q?1VJg5q4No4c8qeAy+8+k0U8H6hXK2dsSPV6I+rXVN1xE3K3Vc1Qa66oNLy?=
 =?iso-8859-1?Q?UdC8EtWs1GMVcHdEzh1RzAyJrqRJLxPuCstTyarSUJIhk553xpld4vFnpz?=
 =?iso-8859-1?Q?V05VmDZLNNJ5QaPt/RmPd76H2CujAza3Ry6OUkIL4Va8Fb1BgNlzS4f3fT?=
 =?iso-8859-1?Q?yu9wIWGqIMi8llXRi5eaza4C/0qyN4mmgeLp5TV/nwwEKZ+uJvCbMdTObs?=
 =?iso-8859-1?Q?qcfvYW0KvxF4qRxkpeQWNqXcTsxzOOIWVgxU9SoXqm6sruBs6RC3/7c7nb?=
 =?iso-8859-1?Q?GR40wMFlYzitRLZmoHA73C6rJSBMQwOeGA7SLycPxO6gg5xW42ZllBzd1V?=
 =?iso-8859-1?Q?n3bsqRN3lGwgP5P66ywUCfswdyXQqHmt/xi3Fbwp5uL2km4e8RH8+TTWhi?=
 =?iso-8859-1?Q?/5dCsClEYZ/d+xKyMIJ0/lFxQe+nddZX32aAD0+YnoRPH2/ilgkFa1PGOr?=
 =?iso-8859-1?Q?Q8OBnTOjXNZyK+foYQNJVFStZ0q9RxCCYt11rUXd7C8dxVH3Xy4JszmBGv?=
 =?iso-8859-1?Q?9k9VYI/JbGde1dMbwe0XDmnTRHnwN39OKB4OcU/vQNLTb5usCQcbZr9Wag?=
 =?iso-8859-1?Q?In0bXMAmZcUn/O48cZtBZ3xBQgK9CflSw/EbVnnzx/9c5/n6NNfoefSVax?=
 =?iso-8859-1?Q?2jmb/0rzbYX//ZSYdgmqVCRRNV/59H9HeOWd6vTwv0MtXBdQdvIU+5fvGq?=
 =?iso-8859-1?Q?kyFOTfXUWFmqXN6rRd6CEo9vLmarYH+2GaYH9+rvfreeu6QA3PcmHNyVKm?=
 =?iso-8859-1?Q?HU0O5I8u9BTjzbWnIw8ODuLlNt9uh0VPKFNyw8iZorhSp8W3YfUUcub3XI?=
 =?iso-8859-1?Q?S7ob8e+gj2VF/U90EBazEwrJLAEkil9XI7roRyO/8jEu+E5jCSdNpROhJf?=
 =?iso-8859-1?Q?eD6TAtJ2lp3GusVWIsEO5Q9mPP1vQGpASn0Rin3/z94hiv7vlWcgwBbJro?=
 =?iso-8859-1?Q?gs1jel9m85RusH892K46ZJetDcJd4iamsVqkgda/45yeCJu9AcI/IrAdRL?=
 =?iso-8859-1?Q?d2gtSYDL9JcusxsTTbLl6SaBDmcA2toeoZNHEw0iMJ0fGO/33NVkxzBUIF?=
 =?iso-8859-1?Q?4eo1vldCVWgQ8y9huR7gBRe5iD0tTwn1DtDIv+kC1TBvecfCDhrWG1VT4S?=
 =?iso-8859-1?Q?bNeuHNbLjwX+54K6qvsZwBxK4ufYjM/wgzcNQuEgL12YUElIKLtcQubWkv?=
 =?iso-8859-1?Q?rwvoTMBXeNYfZ8IDWhTOAIaIZVm9XxOlAAf3vMzJxvceEpX6YpOZ?=
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
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8667.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70263a-ee18-490d-c9fa-08df44b9067d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:42:37.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVQluwvfQ6KEgR+U/+y7W5KNykDJ1UZiKLPfgeFwLQy3bAk8mRJF8UvOn37BGeBwpTc1wduvCD39SfdmQid5QyUAF1LSEhk85+fhcnLDYaui7O4E5fq5UDPWrjxeu17o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11269

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, November 17, 2026 4:28 PM
>=20
> Hi Cosmin,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Sent: 17 November 2026 10:26
> > Subject: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep cascade_counts_ena=
ble in sync with usage
> >
> > LWA is enabled/disabled by writing 1/0 to the cascade_counts_enable sys=
fs entry.
> >
> > The 32-bit channel cannot function without LWA being enabled, and the 1=
6-bit channels cannot
> function
> > with LWA enabled.
> >
> > PWM mode cannot function with LWA enabled.
> >
> > It is possible to accidentally leave LWA enabled while trying to use PW=
M mode, leading to unintended
> > access to the TGRA or TGRB registers of
> > MTU1 and MTU2, which should not be accessed while LWA is enabled.
> >
> > It is also possible to toggle LWA while PWM is enabled on MTU2, as the =
checks inside
> > rz_mtu3_lock_if_ch0_is_enabled() do not check if MTU2 is busy, even if =
this setting affects MTU2.
> >
> > To handle this, write 1 to the LWA bit when enabling the 32-bit channel=
, and automatically write 0
> to
> > it when disabling the 32-bit channel, to ensure that LWA is always in t=
he correct state for any
> > possible usage.
> >
> > Remove rz_mtu3_is_counter_invalid() checks as it is now guaranteed that=
 LWA has the proper value if
> a
> > count is enabled.
> >
> > This also drops the busy check that rz_mtu3_lock_if_counter_is_valid()
> > carried. A count cannot be enabled without the underlying MTU channel b=
eing claimed as busy by the
> > count driver itself, so the check is redundant.
> >
> > Keep the cascade_counts_enable sysfs entry for ABI compatibility.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >
> > V3:
> >  * no changes
> >
> > V2:
> >  * add struct rz_mtu3_cnt::cascade_counts_enable documentation
> >  * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
> >  * mention the removed busy check in the message
> >
> >  drivers/counter/rz-mtu3-cnt.c | 95 +++++++----------------------------
> >  1 file changed, 18 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cn=
t.c index
> > e3578850f024..07dd7f588911 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -71,6 +71,7 @@
> >   * @timer_mode: Cache for timer mode values
> >   * @mtclkc_mtclkd: Cache for external input phase clock select value
> >   * @direction: Cache for direction values
> > + * @cascade_enable: Cache for cascade_counts_enable value
> >   */
> >  struct rz_mtu3_cnt {
> >  	struct mutex lock;
> > @@ -81,6 +82,7 @@ struct rz_mtu3_cnt {
> >  	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
> >  	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
> >  	bool mtclkc_mtclkd;
> > +	bool cascade_enable;
> >  };
> >
> >  static const enum counter_function rz_mtu3_count_functions[] =3D { @@ =
-102,44 +104,6 @@ static inline
> > struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
> >  	return &priv->ch[ch_id];
> >  }
> >
> > -static bool rz_mtu3_is_counter_invalid(struct counter_device *counter,=
 int id) -{
> > -	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	unsigned long tmdr;
> > -
> > -	pm_runtime_get_sync(counter->parent);
> > -	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > -	pm_runtime_put(counter->parent);
> > -
> > -	if (id =3D=3D RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr)=
)
> > -		return false;
> > -
> > -	if (id !=3D RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> > -		return false;
> > -
> > -	return true;
> > -}
> > -
> > -static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *cou=
nter,
> > -					    struct rz_mtu3_channel *const ch,
> > -					    struct rz_mtu3_cnt *const priv,
> > -					    int id)
> > -{
> > -	mutex_lock(&priv->lock);
> > -
> > -	if (ch->is_busy && !priv->count_is_enabled[id]) {
> > -		mutex_unlock(&priv->lock);
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (rz_mtu3_is_counter_invalid(counter, id)) {
> > -		mutex_unlock(&priv->lock);
> > -		return -EBUSY;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *co=
nst ch,
> >  					    struct rz_mtu3_cnt *const priv,
> >  					    int id)
> > @@ -195,17 +159,19 @@ static bool rz_mtu3_get_direction(struct rz_mtu3_=
channel *const ch)
> >  	return !!(tsr & RZ_MTU3_TSR_TCFD);
> >  }
> >
> > +static void rz_mtu3_set_lwa(struct rz_mtu3_channel *const ch, bool
> > +enable) {
> > +	rz_mtu3_shared_reg_update_bit(ch, RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_LWA,
> > +				      enable);
> > +}
> > +
> >  static int rz_mtu3_count_read(struct counter_device *counter,
> >  			      struct counter_count *count, u64 *val)  {
> >  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	int ret;
> > -
> > -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id=
);
> > -	if (ret)
> > -		return ret;
> >
> > +	mutex_lock(&priv->lock);
> >  	if (priv->count_is_enabled[count->id])
> >  		priv->count[count->id] =3D rz_mtu3_get_count(ch, count->id);
> >  	*val =3D priv->count[count->id];
> > @@ -220,15 +186,11 @@ static int rz_mtu3_count_write(struct counter_dev=
ice *counter,
> >  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> >  	u32 count_val =3D val;
> > -	int ret;
> >
> >  	if (count->id !=3D RZ_MTU3_32_BIT_CH)
> >  		count_val &=3D U16_MAX;
> >
> > -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id=
);
> > -	if (ret)
> > -		return ret;
> > -
> > +	mutex_lock(&priv->lock);
> >  	if (priv->count_is_enabled[count->id])
> >  		rz_mtu3_set_count(ch, count->id, count_val);
> >  	priv->count[count->id] =3D count_val;
> > @@ -347,14 +309,9 @@ static int rz_mtu3_count_ceiling_read(struct count=
er_device *counter,
> >  				      struct counter_count *count,
> >  				      u64 *ceiling)
> >  {
> > -	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	int ret;
> > -
> > -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id=
);
> > -	if (ret)
> > -		return ret;
> >
> > +	mutex_lock(&priv->lock);
> >  	*ceiling =3D priv->ceiling[count->id];
> >  	mutex_unlock(&priv->lock);
> >  	return 0;
> > @@ -366,11 +323,8 @@ static int rz_mtu3_count_ceiling_write(struct coun=
ter_device *counter,  {
> >  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	int ret;
> >
> > -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id=
);
> > -	if (ret)
> > -		return ret;
> > +	mutex_lock(&priv->lock);
> >
> >  	switch (count->id) {
> >  	case RZ_MTU3_16_BIT_MTU1_CH:
> > @@ -407,6 +361,7 @@ static void rz_mtu3_32bit_cnt_setting(struct counte=
r_device *counter)
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> >
> >  	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
> > +	rz_mtu3_set_lwa(ch1, true);
> >
> >  	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
> >  			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
> > @@ -485,6 +440,7 @@ static void rz_mtu3_terminate_counter(struct counte=
r_device *counter, int id)
> >  	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> >  		rz_mtu3_disable(ch2);
> >  		rz_mtu3_disable(ch1);
> > +		rz_mtu3_set_lwa(ch1, false);
> >  		rz_mtu3_release_channel(ch2);
> >  		rz_mtu3_release_channel(ch1);
> >  	} else {
> > @@ -552,17 +508,9 @@ static int rz_mtu3_cascade_counts_enable_get(struc=
t counter_device *counter,
> >  					     u8 *cascade_enable)
> >  {
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	unsigned long tmdr;
> > -	int ret;
> >
> > -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> > -	if (ret)
> > -		return ret;
> > -
> > -	pm_runtime_get_sync(counter->parent);
> > -	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > -	pm_runtime_put(counter->parent);
> > -	*cascade_enable =3D test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
> > +	mutex_lock(&priv->lock);
> > +	*cascade_enable =3D priv->cascade_enable;
>=20
>=20
> priv->cascade_enable=A0is never consumed, so setting this value to 0 and =
32-bit count enabling
> still set LWA=3D1 may be return error value for this scenario.
>=20

We only keep priv->cascade_enable so that the user-visible file reports
a stable value, to preserve ABI compatibility. This patch merely allows
usage of the 32-bit counter whatever the cascade_enable value may be.

Existing user scenarios keep working, unless they relied on specifically
writing 0 to cascade_enable and then trying to use the 32-bit counter,
expecting to get errors.

Please keep in mind that before this series the error wouldn't appear
on enable either, just when accessing the ceiling or count values.

This does not seem like a real use-case to me as it does not make sense
for users to depend on an error being generated.

The benefit is that new users will not have to touch the cascade_enable
at all and the logic gets much simpler.

> Cheers,
> Biju
>=20
>=20
> >  	mutex_unlock(&priv->lock);
> >
> >  	return 0;
> > @@ -572,16 +520,9 @@ static int rz_mtu3_cascade_counts_enable_set(struc=
t counter_device *counter,
> >  					     u8 cascade_enable)
> >  {
> >  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > -	int ret;
> >
> > -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> > -	if (ret)
> > -		return ret;
> > -
> > -	pm_runtime_get_sync(counter->parent);
> > -	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
> > -				      RZ_MTU3_TMDR3_LWA, cascade_enable);
> > -	pm_runtime_put(counter->parent);
> > +	mutex_lock(&priv->lock);
> > +	priv->cascade_enable =3D cascade_enable;
> >  	mutex_unlock(&priv->lock);
> >
> >  	return 0;
> > --
> > 2.56.0
