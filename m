Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2110.outbound.protection.partner.outlook.cn [139.219.146.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB3220F3E;
	Fri, 22 May 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416468; cv=fail; b=IfYTO3PJRrze4kiBgHOKSUS/x4R3h0b8KkxQTLebRrhbFlq14TO5EcOzPAwrHp9ebRCVHw0s4gY/B5YZ4rM7V+6nxmKcQ1bvXKKWXPg0HIqEyBnEJgczf43FtJ7QBxTA/rHXbE5/B1/VtyyOQjIP7GAMRCZiWWJZEBOBKMgWccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416468; c=relaxed/simple;
	bh=pSBIAi7JdCHX4iEI7LaG2het01R4Jf2Stn939GLy0yY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fAYkOLK1usyuM6D/gChsRZXlT43YgZ53eMaymEVqNqAXmIx6EzvYmSDXdU84wFuGFRVhB86nAALxBRTG8jteno6xbMC6tYL7oDwylzqS3fG4bA5nkQojPVLDqnAlHTt0Lk57XHixcFe3o4l7KGhMDU2Hr8czvguptWYhFcPhfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekHYI839X6wzDvW3sSufaGWVmSmBnruTsEQY/sk2CiOobwlLDXUqxjyNYjGczjCLxf0gsZ9fbAJ/U/K2F4fk7mZvY2tgvkugJRdFyxWNv1CAxZIe45INmk0QF5WTpLKfIcAeplVzModiJu2of8heLmQIe/+lorHiIQNiT5hlhEWwLYhQJKQClZcb/QGRLsPdjnl/MY3mzZYwXHWMrIH2bA9PsozJo2zk5ddnzgSUceFSwuX4oN7+0RiW/eA0rcek60vc1PKMWk8XQwOvMqbPmTd9XHbmGOQ8XDvvgAUcUhSUGeWBXxkN4+HdpvW89BRXCZIHPyRqSsWa7uZKlfKnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqsvcH2zZ2brLinfUjwk/bG5RniYBNiFnKYJul7Hx68=;
 b=PeaHE1sx/pi++ikvbNVxTZlaBL2xQ9IiNq6N6JQUjSLMoRZQUUlE6LrAnr/qDCsiNxsFGw9CknPaEAGloP6QtO1nxdwOdRzXqb7kc0ukowsgHBLppD2AG6AVKuhyerONdGFJnjqrR6zzoImIfwJQSqcRBdNx3KBUVb2gQhmFXngq7NAYx/4iHYSk/tVYwK5ad2hkh1xppv98D0Oz5BgDLHGKo0yqPljBAnzBhf4RJ3caR2CPK4t+/8gJo2Wvdg+Sunfaa1RDgotCd1eWmKSX8MH2kYnTd4i91ZYGl50UUSANb0ADoIecHKnHV9HzX/vmBHlNglLQfW5VlXGnn2/eCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1051.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 02:20:53 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Fri, 22 May 2026 02:20:53 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Thread-Topic: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Thread-Index: AQHc5p78VOCTIhrpH0CxuRbZCQ5XkrYW1KwAgAFYGUCAADJjgIAA8DcA
Date: Fri, 22 May 2026 02:20:53 +0000
Message-ID:
 <NTZPR01MB095660868B0DE59B2B0161CC9F0F2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-3-xingyu.wu@starfivetech.com>
	<20260520130532.15e65a18@jic23-huawei>
	<NTZPR01MB09564579135FBB637DA5F0F59F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260521123727.6a7d97ff@jic23-huawei>
In-Reply-To: <20260521123727.6a7d97ff@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1051:EE_
x-ms-office365-filtering-correlation-id: c9792161-62c8-40e1-c131-08deb7a8bfff
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003|4143699003|6133799003;
x-microsoft-antispam-message-info:
 xx1m9DDIOOKyUusZ0UefkzCagvvLHD6CCYcXJAXb8QczWxV153Fijo7pEfZfzdzaCs16pgoq/lu7bHiIE4sO4tu+NvNdP23rYyvRDBDsJXV66Ph2eWSPMvHE1lNMpA0/yP1WrOMnxTrYF+pOu6z1BGrnVXwZvMaf5UBwGqsDRZtBk72dDLsNw5eSJbhvDhcZZmLl3DXORlrMKkaExKFba+JA1cEw3WHkMysppYNjKMG7S1QzD/qgO38nfJEUvsIH8igdOPKHrbbkms2Te92I/63pdo2TKKQ/GBYaBIK0b7RayUyCZYqDMQKHQqZjjvnof6/5IiLZzXXoJMVzhJbTzqpaCRkLwUbver2VI5iUS5rZSHvaHNkqiWIfENYKQ7sjcYaHh4BEz81SuoABcOBOx2SkTtMHDldJjDbmG3Ih6akO4DqAn1XbR3r0k48hBUH0JGc1FkrHsnsCutUydy2YTWtVLHgv+uO3MOGVYKVtvA8P4Tam1OtDl3/VoU0brxh/1K1HO5UEqS7TtdfBC719LCdKzuSXxZy1EWzHyQMXPW7Jm31eCWUQo1P1+S0E+2We
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WHgwNd+S48vhDLxksNvcmoyu4mwS12KnycRt6qi4r3XNLLFT4qh6KHJoCm?=
 =?iso-8859-1?Q?USUnAX47GylsJ6DtEaY/zlLCszeoO3e4DCTfe9dQ16xg3U19DQ4hwNYiIt?=
 =?iso-8859-1?Q?ClR+Vphs+xGHclKZMyOjGDTaZGop4Ur+9bJbld/Q9I9p8wwQovW4vrGihx?=
 =?iso-8859-1?Q?Rusy/XxOYSZnlkD+rBD7ak+7kqAs0MldzwgIpO2SXY89b45Gp9D72pCXD0?=
 =?iso-8859-1?Q?TnxvEta/KC+LLAxJ826tpn1TDs9+d2CIOMZ2vuKseq+rEYFsxSHRE7vZ/I?=
 =?iso-8859-1?Q?xNKRUSIvvKCAcFhDHgBlEFOuXsDFYvnn+I6iwWFV+qeWA0gusNiFUM/K17?=
 =?iso-8859-1?Q?l8jfmPFJS5GP90LbxUuLBJBgd+4hy3ytyWgP7W6rQ5BNeit962Uz38IdeD?=
 =?iso-8859-1?Q?5L/i7HQwpZ9BmSpZND6xR912ArKAruLFkXZwwThbuPuAcsSXE9i0ARCDxw?=
 =?iso-8859-1?Q?YlzLGx+aVu73beFQDeU6gvck6Wq+0PhltE7YT61t2gf4TQw1lhwwwrJfIi?=
 =?iso-8859-1?Q?UJ3B79+jXDmAiIrHBtqH1g+qg1TpqaIMHADgr4i6UUkpwbSQdmcErdp9ym?=
 =?iso-8859-1?Q?Ms4qoPHC6zLYrTv4cQC2UKmPbtowoaFUIUllzgwC0yPpbTp2i0xHj/OMt0?=
 =?iso-8859-1?Q?n1at783/C9ahQWQH5QQXsaIdI5zt+0lu0I+yOh4FaFQcn0KUgZZA+vRkJf?=
 =?iso-8859-1?Q?DQa6cD9ZTeKHpVX4FOCjpQoL2Foo6++OYq3QsO0eyG1dnBE3vSFFN9zchg?=
 =?iso-8859-1?Q?hSqILkG52eSbzw9QNjmsnJPLlBWqBKN3BOw6vGOorGUQ88cE/bg/CmgzRB?=
 =?iso-8859-1?Q?lSH6HR/66eNPrHk/Rh957i0fr8aaFudtVkkMxAlsRthVhO1qp8b9qva6tM?=
 =?iso-8859-1?Q?ov5+berzwAPUx0J/2WV85cARsfAR0WbzkMngt60SxA9d4NFatVCJkmmM75?=
 =?iso-8859-1?Q?YhbfU0dTw9ObN1V+RGsjP/pOKM6J6tUj/M20W+8yvq2monuzaPoxMoX/Jv?=
 =?iso-8859-1?Q?Ad+ff9tbjnEuvC9QNPAsxRC5dxeYVFT8w/OFoeskQTBsgXf5mb5lCZYq1C?=
 =?iso-8859-1?Q?nLkOJXBCuLUk2pILZX1e1bGEUdj1fTHsdN3zoSAjEEWK4Av9EQXBXPO9ar?=
 =?iso-8859-1?Q?rncpmtXTuV7yfyDMLLZftISQb6QbQ+Fd6mfB/sBj8tqg8jTPDC5pkS1PPF?=
 =?iso-8859-1?Q?NVngWcsMjHpyVCSsTzdh0by7UCHVK87nuoizIB0C7JhasjWhywJsmWkaS9?=
 =?iso-8859-1?Q?NpR7MdOPFfViUartGeqbb/3KUbaq/iqYiCfQajiJ+711Uk1je0LaFWRn2v?=
 =?iso-8859-1?Q?mFaAyDxc327TfUWvIxd30EJwBkUoU/Lp2bFRBBQ9USrtOUCiIDhekk4bbL?=
 =?iso-8859-1?Q?7Z9ky9WDjeGwC/uvFjezuGtD5ZQjq0rcM4FcjlZcibfWFfn8A55le11F3y?=
 =?iso-8859-1?Q?7adBWDGGfGGPFb0MAmeDSM4giTvbzLd9eY9FwIjY99YhtxjWrqGHbQ1DQk?=
 =?iso-8859-1?Q?QAAtaOBjk5TjPHU4r3rD1yQN3JjIH+PQe+CFEN8zWoBYJc0AknVOaifR1Y?=
 =?iso-8859-1?Q?S5I+RWHNWNK31MZ8E14+asNvk4fAv8RKxNlm5DVUPigc0nBvaKQJKwT7ia?=
 =?iso-8859-1?Q?0geafN0h4+1nwCIE5FlnW6HgCIsJAr+BqXg31WejVNzbaj+T6eXLqyaCBp?=
 =?iso-8859-1?Q?26fsVvuEvPysPtlKp3roZrD54aBshcrCYs8Bv5Bmdb7qp9CISSwLCZ+vgN?=
 =?iso-8859-1?Q?jgj2XyVDvl77Z7v7+I1CYBDFP4LLo+p3p5HVQSBPR1gcNVeTAxhwFmM70I?=
 =?iso-8859-1?Q?AbOL+0i2gQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c9792161-62c8-40e1-c131-08deb7a8bfff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 02:20:53.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDvd6NGrok6t/JgAeRnFzuMfa7EkpsUgqxERHqDWzjReixY0UjKSiJdq1sz6fOJ+let3YwaLo+8Vq93jce6//iJmgDyilY1J6Prjgfo98rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1051

On 2026/5/21 19:37, Jonathan Cameron wrote:
>=20
> >
> > >
> > > > +
> > > > +	starfive_saradc_ch_monitor_stop(priv, ch);
> > >
> > > Why stop it?  Add a comment.  We aren't interested in future events?
> >
> > If we do not stop it and the input voltage remains constant, the ADC co=
uld
> continuously monitor the voltage and continuously trigger interrupts for =
the
> bound.
> > As a result, the CPU utilization rate will be high.
>=20
> Can you use an edge interrupt instead of a level one?

No, it is a level interrupt in hardware.

>=20
> If not, then a common solution is to disable for a period (maybe a second=
 or so)
> then reenable. There are various more refined ways of doing this.

This is good idea. How about using timer to disable it?

>=20
> Basically we don't want to be in a situation where a momentary blip disab=
les the
> event and we miss a later condition that must be handled.
>=20

Noted.

Best regards,
Xingyu Wu
