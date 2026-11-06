Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793931083;
	b=L/xPFXIfJm5c+V09CMUBSosaS2/RZ5lJmchYmQD2D4k/vbBGZqh+i4zhHByxYLKHsq15
	 xpYWJ+yXjDNkRt1Cl3mCd7S+Ty2pnXcQbwU/nutM3s1z4VzKP3lYDMeG94ETOmAZzVOau
	 3ei1I99suIvT/c1F2M4p+FWmfV9k+yZHbRUg4jiOo5pUQH7oiIAjbaemOi7rwKJLJuQHQ
	 Vl02faj28Fpag5av1tHjPaFkg6upPznQRSKS4Dvq7c2vlzzWN0148dw8nyD3XxmgswHsD
	 AirVZpy7N5CjomtdlQ/F70KjfqRVLyGlxXZriJoGbHCI2H9iqt12RVyqARkB9bEVuKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931083;
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
	bh=GeVQkxVcB7WZPeejm2TOLX9uTcMHcgubKNTlCWpA+o4=;
	b=AK9bETLNEwEmBqSNqZfoFXnpR9xd5Y94L1mGs3/YG2BNtunoVIAxRU8FdefHgfW4z2n3
	 C1ZZpwAqOGH29R/akKRjcRNUrdT/w3qrnAbEJlHzR+nLxhYrOGm+o9hiJhkSEGU9nXTQK
	 Jlwt6es+D10KWURtPJRuqBX23cRDH+niD6EbGgYE2EXXRiLZpskiIe9dZJlNzoChsfvPE
	 uvycW6vweJpYFomnOVsrj3luheOw4svTnUS4FqM1sABpuBKu5XGWfzr9alFbg5U2WXhzZ
	 aY7nJdg0q+SA2k12ovi4y5DB4DhfoEnY+QTmfAwAUu8tNF37+iIGBCAvvkSNgUpc56Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SjhFGKqm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.62
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF34606A334;
	Fri,  6 Nov 2026 02:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF34606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SjhFGKqm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr0Uz/EqOJwc41YA8KaAeHT1DtIbLLRO8fjlVXEzRL5/S5RActzf7SDYF/tBP0uARYY2ZD7dEJRG0ktlDMDCM4hsOrmmJLVl18NnHplxQ1o424irBmyKdjv+uV50NziOnk/uaHmS5Ki0Z1ynrCvCbjRdHgBVoVMEEWAbsvtgMjIPh7NVPndWp7+pAPcPfjQYNBbDdhYeT8PvkInQOcpcL5Bqz5mg5P8xB2KShNsbVAZMqrCulgHgM4XWcwef1KMxD+J/q4Ja7gKB0NG2SNgQLROf0Eq+hNpBxclazlPEIcQGE5MCBWqb93xDIU9m9Or1pCCwNwJ1Pk4osGhBzdgIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeVQkxVcB7WZPeejm2TOLX9uTcMHcgubKNTlCWpA+o4=;
 b=eVugQGc2P44P/a4nIue/xTlzD9SAuCHdQKQXTQ0wRW76FUwxS8Q5YTKmw+z2Tc1onUISTaYzwABaMPmr5252b5wX0OkHK25+y/kb5RNrszfj7ms1bc0jaP9bWQ7Sx91CsQlm7Tj4TD8bErM1HT2sME2kCFEvKYePRN9XObHHDz+fsksU7JLKgqakZg0hm0ABNdXpOz2xQtSwDFLXsGIOMK9DFwV3mg3jqTDT87heLJnIwdQ+abNhqrBdK5lqJSiRK7t94EkvK4+M6LmUy8pPpEVqrgf2fj58FtZ+LnjRZ1bPAcBfp1q2Ku1k2oSOUmr+mzDTYepOoHg+1PFSGlrf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeVQkxVcB7WZPeejm2TOLX9uTcMHcgubKNTlCWpA+o4=;
 b=SjhFGKqmIqD5MO+AfRWL4mtzvHP43LZ6/t98w5/lGkO3Fkz6+WY+Vd/fbS6lYG40yRfVY3KxUd07MAAVy2oV5WF12INYbxt266V3x9I29FjlrobHerxdJmx64qBC4MHJR+wJYOysGCEb/CEebEf8RMSUiWeBQxF/SmIZA8idoL7dk+swLnhR52sMD2q9yHiYqB0GsecB+12nFvW2CQc76zxhyejQ5p9Zw54yu/tKvircljbaok1DdBJ1v3/WSKHclAorWBpr7u5sJnoQxJ9lC0p30objiOKLCLEkuELfSkHLoOaYDs7s0u+fKBCPVYz036JidWsRr4F7SZ7wt6smXA==
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13)
 by AM9PR04MB8212.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 02:11:19 +0000
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb]) by AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:11:19 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Joshua Crofts <crofts@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Eugen Hristev
	<ehristev@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH 06/10] iio: adc: imx93_adc: remove redundant
 pm_runtime_dont_use_autosuspend() call
Thread-Topic: [PATCH 06/10] iio: adc: imx93_adc: remove redundant
 pm_runtime_dont_use_autosuspend() call
Thread-Index: AQHdbR+euUEnjqmEIEGg9GX0ijAEsLcgTbMw
Date: Fri, 6 Nov 2026 02:11:19 +0000
Message-ID:
 <AS8PR04MB8820E824F11971A6CCA2E4BB90762@AS8PR04MB8820.eurprd04.prod.outlook.com>
References: <20261105121635.1612-1-crofts@kernel.org>
 <20261105121635.1612-7-crofts@kernel.org>
In-Reply-To: <20261105121635.1612-7-crofts@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8820:EE_|AM9PR04MB8212:EE_
x-ms-office365-filtering-correlation-id: 383dc14e-fab8-4a2a-6c32-08df3bab3f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|7416014|10067099003|22082099003|18002099003|921020|38070700021|261009221227099003|4143699003|261026140227099003|11063799006|261022105027099003|261021135927099003|261028144727099003|261022075727099003|261021123027099003|56012099006|261009223027099003|261026121527099003;
x-microsoft-antispam-message-info:
 OCr87zNI90CyviaQDSMn5lMHmgcV90TFnyf14uWu8zPvqlmN+osDGjKKEuzgNw5TGkaKPG7T9D+aJQzasbPOvbc1DJ69Dc7kQfOBV0GCX7KWaxDfGp0Vf1aci+nzpSPGexlYdy31dHKBHgpUtwBA/0cA6RoRcammthNU1AeL4LpdsHlqKmo08MoM9EDORMgXqQnkGN0rpK35u/2s4EqdZe9MitMbMDqAFb4whmdOfBPagWVDB/D6L5hZBAiLB87So+h25ba/tD+EYG9iJGKMq9XvDQbyJNSHJX8Q/9iFMoNe8ei4lVmhsZZE+XHyfroeKohzgqvOZXi4eTDsotF1fm6QMLJ2+FGqXdxePFLMkfXSW2uzZ1jupyVLt+ifUSAFqZJ9faq9wzAg8OK7SUVOIz+phy4tjR0prxkPp2bx0WEJUBvvxkMV0Lbt2+JszHA7SyS0Xvg+FZnWUgZfxqoIOKnZjh1mSToQoaianFTXs0mQijJ/4NLfT1cr8L4wlWuWHgF8JvZZLTTFT+bo8nlj9h27uNLsx7szhQImaTNgOQkkeT8csEVLtrFgdOTMpRV9SO+KAEpIqI/Rmf6D/kUBj4iXKiycJcIsDEPkSZ472bSToVQasD6WWXYEd6XEen2oBexar0kNTzZEu7M3RjgbQ9XpfHzuRl7qgnLY8rCDmHDuIDP6CAQYOwPzaiO2nXc+YJPS7AxglEjqpn2igWcXSHvZhmVlMbGBE8hllY6ql9E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8820.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(261009221227099003)(4143699003)(261026140227099003)(11063799006)(261022105027099003)(261021135927099003)(261028144727099003)(261022075727099003)(261021123027099003)(56012099006)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Xloxb5Py5D+1hvyyXKPUIiJGB+Ex0GIKWui6YBgHg53GUz0BYZlZlj+3y7?=
 =?iso-8859-1?Q?b+NyInFm0UbXtuiLirGVlsBnBcxyszL6AvqS/Of+QsnfDaJV57dcD0U3lt?=
 =?iso-8859-1?Q?0f6Phm2z2HFbeSQ7l8OBWP7dOTf7UZLYK2KgisnjCHEKcGbi64gRrVB3dx?=
 =?iso-8859-1?Q?ofaf/Zz4Ao5CRF3+1pSZIjLJr9O2W/pZGlMsrbMCa/vzuTGoEEnLHarhhO?=
 =?iso-8859-1?Q?jUJ9NDswgW/YYtRoYG4XDVZEcrKhPBqeAmvARJTe+m/kC7WRBhkrtTbmQj?=
 =?iso-8859-1?Q?ZC5136aV3zgDhjd6LeWhvqbwA1DTJ6CeMxGwc54cxawzTeWbbyCE7qQrlU?=
 =?iso-8859-1?Q?3eVslvkWayBnNunkS9nHgKq4i4KjbjXPJgBoB63mUuXKksKRQLjukDGtX0?=
 =?iso-8859-1?Q?u50UEx2l3VszZLjux8d6aX51qSOjjzsXQpkkrvMExC1aZGix0q4nVtg6sY?=
 =?iso-8859-1?Q?3B8dIrx4yb11MbaG6FwJqW7IToC0eC/N+JTX0V2X4+0Dhl9n+G0dabcMWk?=
 =?iso-8859-1?Q?0RJs/dyqiG2Lqf/XM9mm49MYImqSd+WL0bln8sq+Zhl8vnJOY2GNeXAboq?=
 =?iso-8859-1?Q?7S0YH+jIYZ9GJxnDq3xjOsCdk0JJBT6PstqECn+CmcLzi9UveHjGYLW7XV?=
 =?iso-8859-1?Q?HRK3oIr8E/ucTap/IM2ODWrHYUrgZUWvug7a4WV+weEUoScLNiakhdaccX?=
 =?iso-8859-1?Q?j2TURjttFtdP2O3B6jXr9c/p/8GIzvlf1nwyAcf+N+V6azCGfPlFcMKYEW?=
 =?iso-8859-1?Q?GB9wqK+4/202+ghnOFfW0qmaXxoUBPlgpH3PXPXxYJ3RKf2Ho7TESpRKAR?=
 =?iso-8859-1?Q?yU4Z5WzVmii7M9kUpn9m1eTEA/+SlNA1pfnhFeEGIU7JYLN+IDB4oQukzJ?=
 =?iso-8859-1?Q?/VFvwshDgptOe6VJEnTzYLPnlmyCH7+2Ov/+UN8g1VoqXTCeECJYcMgi/T?=
 =?iso-8859-1?Q?sEGnYXaqutwC7vW8N5rzQK8w6ygzy5ZxFK3OoO9tUbf5fcJmrK9XpRXIaD?=
 =?iso-8859-1?Q?TxvjavLBAhdXdeMWR4OTVnAD+s5dJthMRkGCQm62KSmEYMdWeAo6jCeE2A?=
 =?iso-8859-1?Q?zXzBXTSzVmSoN30G1Dw6BI4lFZq3aECZA7pw/QU1GSDFcVtxBqdMmZjF1Z?=
 =?iso-8859-1?Q?U4mAlwbVuIqQgDeHbYHaBGdzsoo+rIK/Kw8bJvDgiwuTqsNmYquP/m8QXD?=
 =?iso-8859-1?Q?ut0zUxc/kn4BHzQmj/Bgkhw6Qzu6xHblG+geFzE6o3SNmxUoUXAVmK4scn?=
 =?iso-8859-1?Q?MucFKIM/0h3vEpNDzUWMrDjX2Zp7CrtESDH7KJ//FvVbcYTQ/WtiDcFHwK?=
 =?iso-8859-1?Q?Lj6qlVQQcEmTOunK7ai5dGtoDUkAr6cTAw6pJLYycjP3hi5/cnfQEBV6LR?=
 =?iso-8859-1?Q?UV1BTrlY8r7mfB+FhWd441i2EScd9Y2Ecu+U61GRG85OmJLMIrpw8Dj90m?=
 =?iso-8859-1?Q?VEapJ6dCznNVsyqUTb4x6DF0Z7HsIWd5+iPK0ECIKl1Xcv6IdJz8VOXxvz?=
 =?iso-8859-1?Q?SUNge5I0JzkKXnDLNZoa5HOtMakvVKeAfu1bbTfC1UatjbDq7pRYGcprN7?=
 =?iso-8859-1?Q?yltSV3bF82F7s3RMyqYtHMWs5ft7Uxmf/ti7DTc/Fr0qspn0y9XmRyaeTJ?=
 =?iso-8859-1?Q?agqcqxS7nf5MsKVF0+G1VpY02SGAJ1Z3ov0+lGicjP2rvcA+XYJDF0vmEk?=
 =?iso-8859-1?Q?qZRJu/azQQtTHt5PECLzQ6fX6/JbNdR1AiAIMo8WSnNb61q3YlR5bQXe1z?=
 =?iso-8859-1?Q?ZdmxO0rgaVHVs4sgNIWSIfkpuc5NPCi8MIovE/03LQDkFs?=
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8820.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383dc14e-fab8-4a2a-6c32-08df3bab3f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 02:11:19.3952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /20bilYVUBzH+7DeTLpNeCTccGv1/59Ne5RJDu15TGcljLq6nqsjCZ4KsGleB0k7M6s/UqIlyOqkXnwz6e9jqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8212

> -----Original Message-----
> From: Joshua Crofts <crofts@kernel.org>
> Sent: Thursday, November 5, 2026 8:17 PM
> To: Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko
> <andy@kernel.org>; Eugen Hristev <ehristev@kernel.org>; Nicolas Ferre
> <nicolas.ferre@microchip.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Claudiu Beznea <claudiu.beznea@tuxon.dev=
>;
> Bough Chen <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>; Sascha Haue=
r
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team <kernel@pengutronix.de>=
;
> Fabio Estevam <festevam@gmail.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev
> Subject: [PATCH 06/10] iio: adc: imx93_adc: remove redundant
> pm_runtime_dont_use_autosuspend() call
>=20
> Since commit d1706f9da9f4 ("PM: runtime: call
> pm_runtime_dont_use_autosuspend() on reinit()"), driver core is now respo=
nsible
> for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function call.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Thanks
Haibo Chen
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/iio/adc/imx93_adc.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c in=
dex
> 797adaf371ba..1ced0c59609c 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -415,7 +415,6 @@ static void imx93_adc_remove(struct platform_device
> *pdev)
>  	pm_runtime_get_sync(dev);
>=20
>  	pm_runtime_disable(dev);
> -	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_put_noidle(dev);
>=20
>  	iio_device_unregister(indio_dev);
> --
> 2.47.3

