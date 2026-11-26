Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795694038;
	b=ghaw0XB2rAJyxycRyULATMQ1Twg1IWYZGcFfGT/+/T7ysjHf+GJTa5Wpox5USwyPAKQh
	 N1J9q86QTV0TtKUYCrdWYo8+iedDF5Sa0GcaqqeiYp6vz5LSM+aQqspkO9WS29kHauPLX
	 dOfR2J9kAUvR2OcPtyctDpQJI+k8zdXxJEcuOdiFu2maS5HbrJg9vq40mcxQycWJpUg9w
	 tjQpKU96axLbZVdvUwS07dOx4oVhPmWNFcnEzVI3eEMq8LYFQoP6hm8Jq0bMjZlKcHP8H
	 YPl7dJ+KfHvyVsJCvZDwDHHOtYPl362lbLcDKpUXoua+cdlxqC9f1bNPehBNsFJqPug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=3vphurk91I9PSWMTN1uXLY5xsD8BGnE//aHm35qgPwM=;
	b=qwYw5LJlwLSQdyV8HjUPkiAKypEoBITzmFJQAiPKKyoefyBNrx8muLHJhbFLhKi3blP9
	 6RGEik6JHlnhVPJhbNe/AmqE0yh5DdKP3KDHTwvUi/T+f0D2CbZt4ROEYzwDhALscIumQ
	 hV/AngJd8XiMtVGSD2Q755D0wM2jEp1jvIPZ4vU7bZq2ZjVh84STc/vH//M5vNd+RedI2
	 PrXv7tOc294BnlOjP1pNOzK7SObUl7w3h6kq6Eh8pigF8mj8gaq9f0ZSOhFtnqLRk0jNH
	 M8p2GgCe309VptVcDV+CDthrTju5KfMbXDcjXZVvzwwwbCesTGe2958sWHEYiU+ByuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BArzgYKA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.21
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010021.outbound.protection.outlook.com [52.101.228.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CA606A31C;
	Thu, 26 Nov 2026 11:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BArzgYKA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QytJQowLfXpvxtvN8Gc4moEu2PgTGmQirDNsZ/UbIENF54JoOzgidrJrtsamBXVL1rJNVgnHSGLnBXQK/6bNbSki613vmYe2a8WtaH5RG/WQeEOfMgW/S3cH/7n8fHtAtkU9WO30kLKHpNqEaBoLSu6/IuB0yWLegme1JrO4Z4fdyinT/qfUNAFY59oLG+V/qDiBaXN7eExUTvdvOyCevGuTfshp7DOg5qefMuEsloQXsdfx5i/2bnbg+ujfFhxlCRMiPVyIZTvkFFtCqCVyVyNJFN++VVIzxsWIiLKthC/yXAspeatZtcCTZ6uWr94nISPiXuPZUvbQDb51i54LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vphurk91I9PSWMTN1uXLY5xsD8BGnE//aHm35qgPwM=;
 b=Z1iRxKvM91286+cmCWqEoc/xuCSiB+EnqBqKhPuEY5Jv6NZkKqbw0FZSMMMiWXf+PdL+ZTtZGSArJsAj8la8MigeynGxeQGvGlOa2O3rMTbebtZPt3dh+43762fMRRypqvFx893Ctz/K1Z8bjAxyQj9vKhejH5C8jDEcpCqngyusmCQCzslfTn5BZVKOxfxzbILUYHwfElt3UHMcMq4ODlMn0iLbSQg8Gw0cQ5jNR5iHHrEaSruv2CHwvKnwTsYnNiXoMhKS5ROUV3jm4OcRFexGeWzUwV93luD5wWOz32R1HFE6lLzXx4/JXyKBVNUMH0gjdeckF6CLYq4CRkoYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vphurk91I9PSWMTN1uXLY5xsD8BGnE//aHm35qgPwM=;
 b=BArzgYKAL5nPQqgvTStSbABLoRCzlY7KeyC4SM7m0GA5jDuwFtir8/C2BwaplL4AkZcSYtDxQsBXq5Bt8Sq2SyXAlhh8XWRIDQlXd3yHops2DWHyxmQqZ4/kpZlDZ0KlsyDBQU/PVa+6/gX36jIc06zXrqto646/pvmf7rtUgKE=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS3PR01MB8762.jpnprd01.prod.outlook.com (2603:1096:604:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 11:53:53 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:53:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "magnus.damm"
	<magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
Thread-Topic: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
Thread-Index: AQHdfMzusgZd8Hb48Eu0gv8O+Sr3cLdAKQyAgAAIbwA=
Date: Thu, 26 Nov 2026 11:53:52 +0000
Message-ID:
 <TYYPR01MB66036BB057404C15BB64E57B86422@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261125-usb_rzg3l-v9-0-ea14d3ab8a53@bp.renesas.com>
 <20261125-usb_rzg3l-v9-1-ea14d3ab8a53@bp.renesas.com>
 <a152df0a-0b0b-4193-b3ac-ee0df0350802@app.fastmail.com>
In-Reply-To: <a152df0a-0b0b-4193-b3ac-ee0df0350802@app.fastmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS3PR01MB8762:EE_
x-ms-office365-filtering-correlation-id: de42a443-54e1-41f2-4e62-08df4bb3f163
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261022115727099003|261028144727099003|261022105027099003|261009223027099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info:
 wEXkr9DCffm8fMZV43T58b9mc1RqMFd8/SdvQv03/GgmxUy/ZXZzH2JR3Q4VDH/Pw00tdBMC3c1sKB9klLhqCYFKMyg7GtgkF7WRLMQH+VJT51+7qt2is9x5P4jiwklm31z3CKzNNrmv8Nh29jaamGVY1N7Ni3NUxBRBw4Aeo2AzllVDnNSFRQCHke+xDAEQbjYUzmkxPjEwS5Tde7GDSXIAwhAQ5+cMhx5ss9QIu86aFR9MmbAYbEW5HeQiGkxCrkk6Ey5XPAHeMsAd3ySwjwr557MGyzxC/Yb7iXmv4sCKfm2ikwh2BC3nVC/PCTzSM28fxFc89KR1hcQTz6saraQbHK6sV+lzRPuV9uE0Sini4rWIPR6+GMZm3Jqqt6wZRDsFCg7V0m6USfL/rOlVoqVM07IOK+3KdzBxwtVoTdTggx3DJrql8C7cO2F2GT54RZTEkzMvOjw6Gs528hcI07Qvg85VHVU94yDg5uqNjPg/pylsnupCdLmslknPU6K2/Che1FVkmvvffGz1USyCQqciQ0rCXwqGNjoKreA6A0mJVGwl8MCdmM8wMFhtK5l9nhqo712ROlQ3Z/ulGKA6tuoebn9PK5EPYFckfsJbCLr09yCMTO2mJgurjqMtOqNLv913iNjsp1VtNyxhXLU5IAxGxnhkmKzAenfftd/9OQI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261022115727099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SddQTV7C1Fwl20qy3dPPr2r6metEDzRyCv+cq16h5YMsUhpzdZE+VM7vPshO?=
 =?us-ascii?Q?BzAXHqAHUQJiTeCRh8v/4QMEs8WghkCCRkFNi/OU9+cqTVYmBCmQG+ugOssk?=
 =?us-ascii?Q?V89+5Mgnpq9/b2FXB65Q5R1WPlmK38qFXAh/YzuuL1fT95ffTqx7AeVNnZIM?=
 =?us-ascii?Q?78vz3RX6a8JQlg9opUmW1u2eiuSRZbmT6amxAIDwWLAlSHcMdqmjAU+GVa6P?=
 =?us-ascii?Q?w0ocS0qzXINmj7vw6swc1x7r2p8dGiAd07fINT0MxAVPnYyBhDuQXdEIMXlr?=
 =?us-ascii?Q?7Ciwh62FKiikUOjjlVOvaObiPd3s5NftaqOSOt9NchqntRGqNNlEqRDqfyeE?=
 =?us-ascii?Q?nmCmWsv6cPIerXWjQbtqgbAl4Ltwt1YCJgfB4WXvI8cajcP29gERhcRtcrDN?=
 =?us-ascii?Q?Jn25ZKfO8XU3gtX45rijQShXHVqtiQOUe/E6MfiVs6WllVLaY5wFCTa5hTaX?=
 =?us-ascii?Q?GWAk/sqJ3koJe363lDdmiY/9ZP31xxtjUDR2xMwdEEe504bEyDkWFiDBdUFw?=
 =?us-ascii?Q?A33Lla2uX6z7CGUv3FP5v4FwzI4wCBk9sfdHXZsyZJireuihXW9uwD0V2scg?=
 =?us-ascii?Q?CLN20ZZiGmueBVJ5xBK4cvSjUAbAjhLT/WvvKs4DjIs+ImLKh8aLuZuc7htj?=
 =?us-ascii?Q?1/KXFI5Go9pJLAKRy7V0CCrVKSOrta9Ayb11qR7VD2cRj5xMmfbTQnxZb6rK?=
 =?us-ascii?Q?3nc8gRTRaasAUPPhRiVxBXANOQ5ZyFJ4via7boAaUOpBKXKxLTE6Xmlkp4kD?=
 =?us-ascii?Q?/RqoMRY2wCt9inN8w5eVKb9/FV8hSZP44DlyydazAvmi1LMWMOziC2/J7pUU?=
 =?us-ascii?Q?tgFQPJB0nd6dQziDwCYRHl7tdiwVsNKuvLee/mgDXXc0ACymSTzBXvYvUDZo?=
 =?us-ascii?Q?h66FJJ1d22Ha4BA7yapAMBo7Fnj7KneYJ5MGE4JrwOCT3qrvnjdWRlvO+GVi?=
 =?us-ascii?Q?v7dXRQb201oCxcz6r12pv6rFYUSAkD9b/P9ljTPvv9r/F6kUT+jBzVBSxyHg?=
 =?us-ascii?Q?+MW+ehiJL0K+kRn2Yc3uLXF57iXFeCElBwlelrRwakNheo5xK1F74uZrE6PR?=
 =?us-ascii?Q?mwpzHJGdArrVciOWwwwWxzzGuXuak/0u99sreJP9GL3GQCNSDwRW9jV13nwb?=
 =?us-ascii?Q?5nyWuwHq5X4EUnsKTEf+5VtRPQ2dF34xTWZIdNI53L6wzKXqR8LeE6KAa3Rr?=
 =?us-ascii?Q?N06HP1dta0w671CUIMx3+NrzrxmExNwGcCwRCs13iIk1CjJZsu7+oMki+2v6?=
 =?us-ascii?Q?MoDpDJ9IGU7qMd1OcnKnKRybg8thviyT0zmvpZkPh1Krj2OYON7p+XvJ78RU?=
 =?us-ascii?Q?rFhMm8Ho/ZpnwGGvXJ7t14WqXDEmGYUQQvG+02KQKBziL4Z/v+G6YPrRDfED?=
 =?us-ascii?Q?BKOtmHtvrv7zRD6Pqbk5cDx7mxrrcpO3UHxefnBf+bWO734sELokfpiXAB4J?=
 =?us-ascii?Q?lCRTUVma3P6uK7up6bInoG/QOvJ/l9Pq9hInTUH3wRLawW1HP9gZhr1InQ6L?=
 =?us-ascii?Q?/iIpWEJeyF++Z9f9sGS9BcBj6To9WD7TWlJidChNZmABWaTUx3fsMkmpOhqj?=
 =?us-ascii?Q?lEOsdUb8tjyiHyyiimgHcUYw0y1nl5yAVtlYpIBMawX7Oto6UumQ9ItxaSVQ?=
 =?us-ascii?Q?ZOI0YRsEJqu60Uhkz0VyoOJSPkRic4+iWd+5bgxHfL5znBToyehaxHWR8jFs?=
 =?us-ascii?Q?41uSBvsUkZa45Wa3LRwXLXNzEq9o8zIUn1F1LYsqPnaxyriVPtrltEGB7/kD?=
 =?us-ascii?Q?3GQRLpH14g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de42a443-54e1-41f2-4e62-08df4bb3f163
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 11:53:53.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8ZEajPIaYdKjQf+OcyNhk2n5KnxT/nFvatA/nsXmgQ1dwK2acA3KBkp8Xv6vJETShhBMFiwSXe95pzVenqaUnIiO8imEPfGIPmI22HZ9TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8762

Hi Geert,

Thanks for the feedback.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 26 November 2026 10:32
> Subject: Re: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
>=20
> Hi Biju,
>=20
> Cc IIO
>=20
> On Wed, Nov 25, 2026, at 12:05, Biju Das wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
> > exclusively by the TSU) and TSU nodes along with a CPU thermal zone
> > using passive and critical trip points, with CPU frequency cooling
> > maps for thermal mitigation.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
>=20
> > @@ -381,6 +385,37 @@ scif5: serial@1004e000 {
> >  			status =3D "disabled";
> >  		};
> >
> > +		adc1: adc@108c0000 {
> > +			compatible =3D "renesas,r9a08g046-adc1";
> > +			reg =3D <0 0x108c0000 0 0x10000>;
> > +			interrupts =3D <GIC_SPI 378 IRQ_TYPE_EDGE_RISING>;
> > +			clocks =3D <&cpg CPG_MOD R9A08G046_ADC1_ADCLK>,
> > +				 <&cpg CPG_MOD R9A08G046_ADC1_PCLK>;
> > +			clock-names =3D "adclk", "pclk";
> > +			resets =3D <&cpg R9A08G046_ADC1_PRESETN>,
> > +				 <&cpg R9A08G046_ADC1_ADRST_N>;
> > +			reset-names =3D "presetn", "adrst-n";
> > +			power-domains =3D <&cpg>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			#io-channel-cells =3D <1>;
> > +
> > +			channel@8 {
> > +				reg =3D <8>;
> > +			};
> > +		};
> > +
> > +		tsu: thermal@108d0000 {
> > +			compatible =3D "renesas,r9a08g046-tsu";
> > +			reg =3D <0 0x108d0000 0 0x10000>;
> > +			clocks =3D <&cpg CPG_MOD R9A08G046_TSU_PCLK>;
> > +			resets =3D <&cpg R9A08G046_TSU_PRESETN>;
> > +			power-domains =3D <&cpg>;
> > +			#thermal-sensor-cells =3D <0>;
> > +			io-channels =3D <&adc1 0>;
>=20
> <&adc1 8>

With the above entries, I get below error as adc1 has a single channel

https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/iio/inkern.c#L135

[   15.067383] iio iio:device0: invalid channel index 8
[   15.083648] ERROR: could not get IIO channel /soc/thermal@108d0000:tsu(0=
)
[   15.094096] rzg3s-thermal 108d0000.thermal: error -EINVAL: Failed to get=
 IIO channel!
[   15.103500] rzg3s-thermal 108d0000.thermal: probe with driver rzg3s-ther=
mal failed with error -22


>=20
> You cannot have "channel@8" in the ADC node and magically assume consumer=
s should refer to this using
> "<&adc1 0>".

ADC1 has single channel and HW manual says it is ADCR8(A/D conversion resul=
t register 8)
That is the reason for channel@8.

You mean I should use channel@0 instead to avoid the above error as a singl=
e channel
registered by iio??
	channel@0 {
			reg =3D <8>;
	}

>=20
> I don't buy your rationale in [1]:
>=20
>    "There is a mapping between internal Linux array index (0) and the act=
ual hardware channel ID (8).
>=20
>     See the code
>     https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/iio/adc/rzg2=
l_adc.c#L354"
>=20
> This mapping is in the driver, and there is no mention of it in the DT bi=
ndings.
> This means the driver must be fixed first, too.

OK. You mean I should add custom of_xlate in driver?

Please let me know if you prefer adding .of_xlate to the ADC driver
so we can use <&adc1 8> in the DTS, or keeping <&adc1 0> with the default
simple xlate.

Cheers,
Biju
