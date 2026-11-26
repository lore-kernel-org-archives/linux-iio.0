Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699073;
	b=O4RV3PuGuTRAjpZR51i01ZIIazuRcV74CgZN3tBTsoWIbGrWkC9LG9cYA7b4EmXEHkac
	 8PDD8GakQizrYxY9S9JRoSnZMhIQJbgLRd+pfbqERKyvBuIs84D2WCDNWobgFPO3edz2F
	 1AB9c3Oldga48Sfwh2Jbn0zUffhKUg8m2wJxjOVa/GSH6tsHc9yb8zociMwIAS9Vm7smH
	 DeTdZ/6nxG6Fa0nWKT6GBdnT/Jihx7x/lTgD96paAp7a+TO2Qf16Ya+6B/gZYoCUqARxc
	 yui1xS3dsENWGecSgwXmaM/dQM9Mz6uTG2QSpo8mJP8LAhM4H6deUW75O7LgEjvzn/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699073;
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
	bh=Vc160X9QGt5EZcUU21MJYIfQf9WYNEnSc5iTrpUN0eE=;
	b=wxLRlihQCiKOiJ6yRea+AfDwDEdaKLUqJMmE2oPCdlRV+a5Nc0qEYHP3OpUnA8+YtHdF
	 xkpHn5LIwX8gDOpRVHrCTYhRCeyf3eDXeB8G2AvL7s/XvxLux/5JqdaP8dMsrRvIiL8Uq
	 GR/AylAdCKdxEUtys7pFbdRChBZgF+IOyE9xWhW3Sa97ViXzR4dmO7DgJGgU8ctGj8Dug
	 YPU9GiSdMPSuHPI5IA+B2Gw1u71O9PEqgQmlDickIzJ9cNCjcZHadBh6HniNH2mtKyKh7
	 xpnvy3chqwmYeXWlNzlL1TFe91ioqaH9GIPy7qthBXpQr2cvPzbIunkMDst6Mn6ZCfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=m1Lzgc6c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.30
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F53606A31C;
	Thu, 26 Nov 2026 13:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=m1Lzgc6c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBwGvhLTlKPPwS9+1sGT5W6GOchsteK2/JhhraSBa/1lTvZjP1y8FLoauokF4fMgdWhtZfeo4CfdEe9AsRUXJ0xtIxzXc33Jc7yoFDJwIXt0BFbLulZFouGSfKLtcm1NbXmHvr630ABYZH4QBDWi0pc4bPzOTOvltys1q1LoaPyCdk64tVENMozN1S4Rh/Oi6GOQcgKFSLaKmnHtqjSLOILz0zwPL9wF6GS968IRQTjucMsHEknZrwmeHUakia8zB/TqozFBHWYOp3sKU1LD1FTw0DSO25f7AQxBXuOrW0fdh5X7fHCEgm292vMy4bk+4AHP147Wnwcw+dSFpuSjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc160X9QGt5EZcUU21MJYIfQf9WYNEnSc5iTrpUN0eE=;
 b=jvkVCm7VW2A3a+LhMhreWDiYCdjseLpfVqlHx73erb5j8WAywP/eHdVfpYW7kvEVSauOA2KkaeJDLuZ4oFE5ktA3bW2wspHa2DHam5sBcfeA6TZuzJSkwypbOjm5rCkT/N8quBR5mW0c1NEAE+OuqxDqfqeJvkMzcoYF2M9z8CVmJI4oBa0SRHCCsOfwnYV3ig29bIjQBBeEDj+2UB1i1xnT1OY5Z123RyweuD4QsjIimHEwvy9TxpG3pGIEMHBu3+mDeED72BdCOCFbFadiJGO1N7TlBvLXl//vCOwtUOLwaXFNKzfxLpQdsjrlo/TiDkhU3eXotTrIquSZCgafHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc160X9QGt5EZcUU21MJYIfQf9WYNEnSc5iTrpUN0eE=;
 b=m1Lzgc6cbG5ceSiPkAkQcVgYJmBKircUYBvkEgtB9rbuGtJa7/6LGyjfE8qOnQjR3UYtCpCEAvSsH6mFtdBRgo8oOCgKcpZTG7jpUwjc/dW/DpmHPqx74gEXpBZ+rIpqgCOgbveWrz6rthjbmRINPLVvK8yb6cWVB2MHYB1QFfs=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS9PR01MB12133.jpnprd01.prod.outlook.com (2603:1096:604:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:17:48 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:17:48 +0000
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
Thread-Index: AQHdfMzusgZd8Hb48Eu0gv8O+Sr3cLdAKQyAgAAIbwCAABgNgIAADaNg
Date: Thu, 26 Nov 2026 13:17:48 +0000
Message-ID:
 <TYYPR01MB6603CC2EEA000D034ACB97B486422@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261125-usb_rzg3l-v9-0-ea14d3ab8a53@bp.renesas.com>
 <20261125-usb_rzg3l-v9-1-ea14d3ab8a53@bp.renesas.com>
 <a152df0a-0b0b-4193-b3ac-ee0df0350802@app.fastmail.com>
 <TYYPR01MB66036BB057404C15BB64E57B86422@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <3b689e6a-98ad-422c-8b67-45d4a44377f2@app.fastmail.com>
In-Reply-To: <3b689e6a-98ad-422c-8b67-45d4a44377f2@app.fastmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS9PR01MB12133:EE_
x-ms-office365-filtering-correlation-id: 0dfbceac-6171-4660-785c-08df4bbfaa9c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|38070700021|261028144727099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261022105027099003|261022115727099003|261009223027099003|261026121527099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 xyQjP8PDLluhU1tghoA+HBeUsIdTLhmB869qi12DrjQAAKKs2214+/Ul89wL5gjJ56q6VZQJzmNLlIY1wKaeM9gDPKzSrOWf64eOUmza78F1hvbzcZo9CHnT+CQyb0G17wqhBfqa+1VUkBQ+MGIeqqQet/HI1HJtn3H2dt6Qh7lD86KDbJI11QR1RcJAyFouDWFGndGOwWuVsIe4h7PE5P8EF9vviM1Ax9YAvB1LaT6lEVrnkjV7T2HVYyt20kR4kFUWlXd3ISzlrYUBeKJuXRF6TGXOW9vdEVmTTSmSslSEmhNmsTC0kmAsOSnWcejWVgrymlASWV+dxJgSWI59h4yIptoiK2o3LOImYmuJb8qQyyFIjqxSmOhKh49lwE8xU070G10mTp89gDaENq712ZI5n3usQXl/b7zRw+VD/8vqkL8WXKRkZVfCO/vmGc+CvxdLe9sEAL5OwltV5drPHMFZXYaz9MGK7W/TED4fhmAknKneEkOmRnYtdUhpeiB+Lu2no0fsDGGaVJxedZvd4lZ2nCgEVaYNSErkDxc+D9IG78VwrPfbR6B01r/Pq5SPAWdPbJ5+PkPR686IbiKC2+PkQpLE1TPMkNSzhFjlDfWq5N4v1RoAjkDOclq6H/o1qW9IKm0EaFQA7MewZgbaKa6477tbIYVftiL8JWlZMFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(38070700021)(261028144727099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261022105027099003)(261022115727099003)(261009223027099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PMsLt8Mh51Brs1UZzxDOBVuQ2Dtcck2Ox9qELqyrsY9zAka32VOLszhATpnI?=
 =?us-ascii?Q?m2G+KV4f+I1F4gM4BoXl6aWI37vMmS1Pmg+eZtIrrqPUpbQ+UNOvwcD9V72z?=
 =?us-ascii?Q?h6KHtsy6NGoDLGzFevA0UbFfrgMM37PjGnlwKbxOELECu0JbOVeAA7Y9M93z?=
 =?us-ascii?Q?STLkiIshg9AI30WMGuegz+krxr23RLlwg6GrexA4eiHBSK5Aeft/I0STMP8z?=
 =?us-ascii?Q?XGWEcp4kv81o5uxRCWBuFfEPhWeWY4r6mtH31pKipZcUes/ItuYwVh9/5I8h?=
 =?us-ascii?Q?0mT+k2WWiEMc4xMJwAs2mhLHP+bIVbqEpubLLjcCyz6+AgrILiMZ8FGRDkJg?=
 =?us-ascii?Q?NQ6Xyy9pzBuRj/4DxbIa30fks6OedlYLBnsHSPlj15oO6jeyQ6DSV2dKl5ED?=
 =?us-ascii?Q?61EOFml6ggPrwST5mdNZ6wtK/7odP7FHv8iS9mFQ35VcyOUDH+CE0OM3Y4yy?=
 =?us-ascii?Q?otIu0odlDbZXjHILZ6sBs/z3ks0GZeNxWuzdMctwI43hmer+epSeavCp1h5K?=
 =?us-ascii?Q?ZDh33HNvNI2j1K5dlitJlV1qiNLu/6DhVFWwGf8DEk23MnDyQnGI8Tga0gcy?=
 =?us-ascii?Q?Iq0VV1xbBbPF4bXyLr62YnN/4uTSN2ltJVKGq2l4pZ7F7YLOvYGRlnWSZvGp?=
 =?us-ascii?Q?8hSWQ/e/RWI0SjBKX1bFX7N0EOac+aj7oTc2payhizmxaoiExNHVQbvOUqrM?=
 =?us-ascii?Q?TqA8HcoIOS1VDSdxpMyOUzo/ZgIRBPRB4kg3bDYQHYC9yfvL3PlRmRvOPDUz?=
 =?us-ascii?Q?XhmeI6BJHGLbCC/bH6EYfDFoPPH2N9Pk/7tnnF3Qyy9M/279EWxIy1Ebg0+z?=
 =?us-ascii?Q?VKdkBnAmyeM9eSCmbtnEBGtNyYIW3xAHuYnlz+L5Wf5f1/4SbqpzEsH2pf2X?=
 =?us-ascii?Q?clWlVMCNknrtUHJUvZD+oZ5eIS8Zl+yowUe05P8hu6AElVYQs/7UavEh7hsI?=
 =?us-ascii?Q?G+cRwj3QZWlq29ztckvTPuKxKmfZDLa8PwV4UcY83B93xKUSEHlxP5lFO1/z?=
 =?us-ascii?Q?SQwcfLVCKXxstn/cNXnFxwYiQAODXcC7QDpCssSWq39d9zyCVHMo36gCFdpu?=
 =?us-ascii?Q?dYrGRRy35ylHk+00jtTHkowQaJhiR5pzLTSZheTScPWW6GDoi+SAGLXxNlTD?=
 =?us-ascii?Q?7F+/G9tAhTre6mxY8kRspx2/d5oC+lyugUumC1+qeTitNiS9E1b3IHE5lCij?=
 =?us-ascii?Q?uC3B0q3SdSQc5yF0kgjSbhHt2Y0jRA4lg9JXerLmfBkBEnYDoH6o2cRD9qNX?=
 =?us-ascii?Q?r0TlYO9QprbJFa1Qkbc2/bJOAkknr/xxLT1fKKSYXRpFmjW43p62YSUpvnNN?=
 =?us-ascii?Q?BM3cxvC98GVDJhAJciM2BzmbhSISmh04WZbWN4muw1kRM1OEFEMEMybkNFrm?=
 =?us-ascii?Q?Wmg/r8yllSfx9civ4YlULCvmExuQFTux2wcFRRG3F86kBU32S21vX0YXJThf?=
 =?us-ascii?Q?cF2cqf3VedvUm4GF49b1IE40tVVXx5dcwXv836Ubgzfqr9jg49BX6QNDjJKx?=
 =?us-ascii?Q?LWoA/neW0C6YLt9hg4kIf4Yirs2bzcEJsj9gnEfkZ39xf5v4WTtFGA8lhXTv?=
 =?us-ascii?Q?qXUdSW3tCdfcgZ/xfdS8Y4MLnEW3iYQb+O6lLUo+blIGReWhDdfLXlU0gDqa?=
 =?us-ascii?Q?gklCEhMAHCYlGcU0tZ+KaUBHXbY47zGurZWgtIfJQ1Hl766Mj2zvWMP45IWP?=
 =?us-ascii?Q?Z8akxyw72vhEZzFrqJtZ6ODFwA/K4P6+BEiTJyPq4tYQmEsKXIhd4dAJG4A1?=
 =?us-ascii?Q?5iJWSnl8hA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfbceac-6171-4660-785c-08df4bbfaa9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 13:17:48.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C84yFFlGr/uSkJ6MAOTuSiHikD84Fo2gWxlxTQhW9w36k9Eerxj/fg8d4UUeWLMJyel40rtByr8Kp/dZoqcHQZLkLvJX0sRq/ffe1k3twAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12133

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 26 November 2026 12:28
> Subject: Re: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
>=20
> Hi Biju,
>=20
> On Thu, Nov 26, 2026, at 12:53, Biju Das wrote:
> >> From: Geert Uytterhoeven <geert+renesas@glider.be> On Wed, Nov 25,
> >> 2026, at 12:05, Biju Das wrote:
> >> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >> >
> >> > Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
> >> > exclusively by the TSU) and TSU nodes along with a CPU thermal zone
> >> > using passive and critical trip points, with CPU frequency cooling
> >> > maps for thermal mitigation.
> >> >
> >> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >>
> >> Thanks for your patch!
> >>
> >> > --- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
> >> > +++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
> >>
> >> > @@ -381,6 +385,37 @@ scif5: serial@1004e000 {
> >> >  			status =3D "disabled";
> >> >  		};
> >> >
> >> > +		adc1: adc@108c0000 {
> >> > +			compatible =3D "renesas,r9a08g046-adc1";
> >> > +			reg =3D <0 0x108c0000 0 0x10000>;
> >> > +			interrupts =3D <GIC_SPI 378 IRQ_TYPE_EDGE_RISING>;
> >> > +			clocks =3D <&cpg CPG_MOD R9A08G046_ADC1_ADCLK>,
> >> > +				 <&cpg CPG_MOD R9A08G046_ADC1_PCLK>;
> >> > +			clock-names =3D "adclk", "pclk";
> >> > +			resets =3D <&cpg R9A08G046_ADC1_PRESETN>,
> >> > +				 <&cpg R9A08G046_ADC1_ADRST_N>;
> >> > +			reset-names =3D "presetn", "adrst-n";
> >> > +			power-domains =3D <&cpg>;
> >> > +			#address-cells =3D <1>;
> >> > +			#size-cells =3D <0>;
> >> > +			#io-channel-cells =3D <1>;
> >> > +
> >> > +			channel@8 {
> >> > +				reg =3D <8>;
> >> > +			};
> >> > +		};
> >> > +
> >> > +		tsu: thermal@108d0000 {
> >> > +			compatible =3D "renesas,r9a08g046-tsu";
> >> > +			reg =3D <0 0x108d0000 0 0x10000>;
> >> > +			clocks =3D <&cpg CPG_MOD R9A08G046_TSU_PCLK>;
> >> > +			resets =3D <&cpg R9A08G046_TSU_PRESETN>;
> >> > +			power-domains =3D <&cpg>;
> >> > +			#thermal-sensor-cells =3D <0>;
> >> > +			io-channels =3D <&adc1 0>;
> >>
> >> <&adc1 8>
> >
> > With the above entries, I get below error as adc1 has a single channel
> >
> > https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/iio/inkern.c#
> > L135
> >
> > [   15.067383] iio iio:device0: invalid channel index 8
>=20
> I am not surprised ;-)
>=20
> >> You cannot have "channel@8" in the ADC node and magically assume
> >> consumers should refer to this using
> >> "<&adc1 0>".
> >
> > ADC1 has single channel and HW manual says it is ADCR8(A/D conversion
> > result register 8) That is the reason for channel@8.
> >
> > You mean I should use channel@0 instead to avoid the above error as a
> > single channel registered by iio??
> > 	channel@0 {
> > 			reg =3D <8>;
> > 	}
>=20
> No, DT describes hardware, and the hardware manual says it is channel 8 (=
and FWIW, the "reg" property
> must match the unit address).  If you want to deviate from this (I think =
you don't), you would need a
> DT bindings header file.
>=20
> >> I don't buy your rationale in [1]:
> >>
> >>    "There is a mapping between internal Linux array index (0) and the =
actual hardware channel ID
> (8).
> >>
> >>     See the code
> >>     https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/iio/adc/r=
zg2l_adc.c#L354"
> >>
> >> This mapping is in the driver, and there is no mention of it in the DT=
 bindings.
> >> This means the driver must be fixed first, too.
> >
> > OK. You mean I should add custom of_xlate in driver?
> >
> > Please let me know if you prefer adding .of_xlate to the ADC driver so
> > we can use <&adc1 8> in the DTS, or keeping <&adc1 0> with the default
> > simple xlate.
>=20
> Please add an .of_xlate() function, so (possibly sparse) hardware channel=
 numbers are mapped properly
> to software channels.

OK will add .fwnode_xlate with

+static int rzg2l_adc_fwnode_xlate(struct iio_dev *indio_dev,
+                                 const struct fwnode_reference_args *iiosp=
ec)
+{
+       if (iiospec->nargs !=3D 1)
+               return -EINVAL;
+
+       for (unsigned int i =3D 0; i < indio_dev->num_channels; i++)
+               if (indio_dev->channels[i].channel =3D=3D iiospec->args[0])
+                       return i;
+
+       return -EINVAL;
+}

Cheers,
Biju
