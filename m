Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2139.outbound.protection.partner.outlook.cn [139.219.146.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F44376A16;
	Thu, 21 May 2026 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356653; cv=fail; b=jENwgFfkolMwIXHWQOfisp1qSa8+vnMDe6LHlp8BzFnHOhSwu/9QUoIYwWapp46wpc4c4t5fan8/6ANnypC8Ld9U6WvtNt4twwX7A0acRRtvoiyBdrwRg+fR8Zy5iNan9hcf4BlYQc19jPfaNuWdMTBYIWYd5Zcf+8rp177V70c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356653; c=relaxed/simple;
	bh=zg/+wd/6TSfAyNjeqgT6MmDjN9m8Fm0MnSf2CtNdvfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qYuhAU1Wm4xth4N1gnISXSLZIkmf/tf3om8H7WPCInlhs813lLqR4cTDC73DBq3AlUqrjOtbvzvFmB4CkdqNLV6SVKGR5hDj2KPo2Mzh4v1YOEvULhjsrK4HQCajovI0raGcSlARrBLe7OG3GtuJZmV1y2JwfEt0SZJN7E/vqs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuyGy/edAnMuI2vgK4lgYz3Cdf8hRlh8mufQvLTDDfuCNDov8/kSOcIK3gkkShYpQQ4HIjufTd5RBx3KcnqbeGGdKutnlOrwI8FPYqpiCO1AszfeFQpS2Em2EyHEEwPXYO5miTZHkhdy0nBNjDGZPfZFdULDr2q8xZwqTUvyI+1rsrYFIViAA8qNxe8h9bPhwlfJoCdyToBzfHLaLM9dIzjnBQXgq9pSv8K8BeMkX4XNUDzeEdXdYOkGrDjemorh7EGjRTwZk75+mVs0oJY56ZyCwgRIpH0UoJksA/cOTTV3VJwLiINKIBFvHne1/FuicHwRlp2qj0V5kx7lVz2YRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ttWrItz1xNlONC3lGFJ0etTWyi3SBueAePK6LN7ZA=;
 b=AdtaFxWpiG2xyWRU3TWYJZ5oREJw+o2mq8sgWygyp1Ql4R/yw1u43UMpDl8eUfPCjBwEPof9uyuOpMneRKVBzp6MK+e2qUQC4tBeQGwNVpB+qrGqtLI3z/6D4Jyz6WqOJq1m1O5uxEl9yhRiGUCTSIoVIyNAitx8w3etQPWLO2XrULa2z9cps+QmO61HVrOp5sd38ns9Ni7fHAXqDoAy8Mmf6Es8ke5k15q1h6pRRuuTCCJwRBUHi6tSgNv2VL8evHZZgQCUmPN+6Z0gZBPTt0mOcxAaf9Hiu3W/+kIMqWQsllRo60MIynRgcj7LbjbFfU+9hCfOIz35zFNxixU31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:43:55 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Thu, 21 May 2026 09:43:55 +0000
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
Thread-Index: AQHc5p78VOCTIhrpH0CxuRbZCQ5XkrYW1KwAgAFYGUA=
Date: Thu, 21 May 2026 09:43:54 +0000
Message-ID:
 <NTZPR01MB09564579135FBB637DA5F0F59F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-3-xingyu.wu@starfivetech.com>
 <20260520130532.15e65a18@jic23-huawei>
In-Reply-To: <20260520130532.15e65a18@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1067:EE_
x-ms-office365-filtering-correlation-id: e93e1222-8615-4f4a-5482-08deb71d7943
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003|4143699003|6133799003;
x-microsoft-antispam-message-info:
 z7L1VLs7urHe/B5xqpIaKHvH3tfD2PdThwCKLEpbBkwdryfrVvYO8fNxW5HQMDJP7nmRxBJfrrAYpPSM9zj2OLblm8j+JaRAQGFyE5ZTFTAPdcwlsUcghJll3fjEVxOstBlST8XmF1H8OA3eR4lbImA1tkvEwlwtN10cKazCpyPNT5S5G3h6IfNZmUvMogWN3wfihKjtBOc5VpXcxm6p20+8qnuaE6OjUmh1dEgIxDmrNhRID/LqekBHKqvFe1DW/MU6R1sAwQzu1RCvw4ye9mLsq2/QkGF6q5xie/bEnEzYMfaGw8+5tPV4PG0aDH2UjZccx48xP+GWB9LU6jbc80JECA9yqP5DQRKMelCY2ZoRgs5TiYqS+kHuxO/sF6c2bbbNVA3cr97G22OsPbaHnDbw9prYwxfh/P8mMb65DoLcCbLCKWVyceOzqqcLBqKv+CFswbs96mOdJMC3IJEql6n1Yvcn8rCrnoSRBu1t/dMjQp5xE8fYmCeRjRedQL4aJyA13i0Ad3pXnpIT16Sk29WQpmJS8stf5nQLvwXguaKtFEl8MHoJJq4hKVlVzJXq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?clipQ04SQ8g/KeWESAhIuV1Bzo0d34cP4iSe87+dBTA8tKTaWXtpmsSpwT?=
 =?iso-8859-1?Q?rvXRbJlCnyCV+MwcMHR7dRQEW5PbqcRCfnoTbbNIF7CWI4wl3S9i64SH/8?=
 =?iso-8859-1?Q?+nkPSSPQ1VpS9rIsvtEqz2cT72GcssoBfRS7sMU7J8F9TaRzVl72YLfw4c?=
 =?iso-8859-1?Q?iJqzoeUiYSZ1mD0jdluzNhBVm8oC/tDAukiMF024ce56mvGWbxSFtAlyrV?=
 =?iso-8859-1?Q?LgZDsCG16/J1GX/trsCYub9tDAzNucPuP4GFa3ZmUjRdY2IVo6nf+as1Iq?=
 =?iso-8859-1?Q?dD6pvkB2ZLm8SoZ27DefbpGwQ2+xc+HlIUv4d9vLNBoYnIWAkBmgPwN6id?=
 =?iso-8859-1?Q?uEbKPeDSaRNZadZgP+WJArrwZ+MCOKsYsHF2DtAQXxzACE+MPXQTqPnxPN?=
 =?iso-8859-1?Q?S7zg0yE1lYyG8TJZh0cLaq2kC1Ev1WKeWgErkqISta4Cao3sDgxijO1gfc?=
 =?iso-8859-1?Q?IelyXsWiN6Ncmn2p3hwsaoI4M1euYhB7O5Sro5kCqPzKnJsjxdLDiYMI1b?=
 =?iso-8859-1?Q?WhzkStunZLG2S4vQ8Mxfi+BFIw8cAKeTwU0AtkUZXBCiqHKgQWd+sLttRY?=
 =?iso-8859-1?Q?q5A2WN/0lUODFge0FCPDmoJT3hvgCoB6rIVtSC1869BbQYwgv92zyqRpcH?=
 =?iso-8859-1?Q?hjJfd/CGDvofUtBFopBePyHM4p3Lxl/qlSxoDpufe/Oxn8x+RxuM/VTpl7?=
 =?iso-8859-1?Q?RgYY/yOCB/WjAhdoLUA2cI/fVGto+F0MZYkH8kd9TjGWbzp9rp1gHrHoF0?=
 =?iso-8859-1?Q?ZRPK5PQzHrV3bxrO5PFWQlR8nMWMaWmO2dYV8GPlt5ntFhZ9uASAsJmqfB?=
 =?iso-8859-1?Q?B8SAZ+4iUriJRMiWwvftjuK8n7FOd9bfPxJXi3pUKnoh/YxDSq8YIn9aCQ?=
 =?iso-8859-1?Q?ODcPvN/KQg6s67oUk6+ajjrcIYbmpAxfSCjdwtvJhSL8fqXr9ZKZbBsjKV?=
 =?iso-8859-1?Q?oCfv6zLcNHJw8dD5ekTossf5VsG7pfU4p4bk0LoLZoGq2fH7Fnd6ysSWtj?=
 =?iso-8859-1?Q?APYLlw1OoAPN6ihBLkiSLM8f1nS+8t84OIBFWqYW9XjBJjl/tjWart0dwZ?=
 =?iso-8859-1?Q?O1jOpGhaaatinfN8EzlN3zeisfO1xeApflyHjtzJs7ldO4FhwmLIxjtoto?=
 =?iso-8859-1?Q?ovWi7JJPzKVtEaD09D25HWOb9RyYB9rkdm4wIPcZ1RBxCNlnmktB8vr3nl?=
 =?iso-8859-1?Q?RDn/TkVyzBTYsV8hny/iL35crbTJ9n1DsDdABTsjjx0RmGF+MDj9GP69er?=
 =?iso-8859-1?Q?YWiqDvYaeeRcZN9WPvX3L5/iybvpQm7onvfTIswGi+68VDsVlqgt6RWdFM?=
 =?iso-8859-1?Q?APLOdwgDTS7xOWuVsoRXKzUN6OTN1bOF4RPoxlenmh76leAiNHssctbE5c?=
 =?iso-8859-1?Q?ksT06+LI5d+0zSpZ+dC5ILfh8JJejGGe1K/z1Uugygv3NqskBMsub1hSpF?=
 =?iso-8859-1?Q?h/81L8vpOGcvqgGlEcGnsAi6LNoss51JODVQDhSo/HEzyRLZKu9eXjUchM?=
 =?iso-8859-1?Q?ONuiGZIIKmnQcTqMcHOWBWTQMJ7sPh4gY4lHzlV6Vm6uPeRmBTtbDNob8A?=
 =?iso-8859-1?Q?aVxY9KKVPDz/pwxSIFkpiNLGahkDuMXt8k0MI9JbcoSjMzmJPGmLX4mWOO?=
 =?iso-8859-1?Q?QlaXsI9mhKzb2Tw4QN5LQgP1kFnWZdhw9iqSvlrckMbrNDi3Gnvyal7mI5?=
 =?iso-8859-1?Q?poLIYZTNvRbrPlRzeYfP+6j598X776obB61Byjlbbu/rOzarVQ2h0bRqXk?=
 =?iso-8859-1?Q?vkF9s1q6zZDzeQQYMFvEAZDh0rMsejumeN824AXhvjanzcXxHFssa4s+zk?=
 =?iso-8859-1?Q?7HqnRPC3Vg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e93e1222-8615-4f4a-5482-08deb71d7943
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:43:54.9017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEmRHusipTpGt6kWb8MPvSQLrvsfGhT5e7ea7ULPjcl5WaiNxjcyMjkYeGbiWqNrY6+C6BOkAxJ5Aj0SJWx1rSMTDtaUjcud0Yp1ZUJOftg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1067

On 2026/5/20 20:06, Jonathan Cameron wrote:
>=20
> On Mon, 18 May 2026 16:18:52 +0800
> Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>=20
> > Add a new IIO ADC driver for the StarFive JHB100 SAR ADC controller.
> >
> > The hardware provides 12-bit conversion precision and up to 8 input
> > channels. This driver supports single-shot channel reads and exposes
> > standard IIO interfaces for raw ADC values, processed voltages, and
> > scale reporting. The driver also supports channel monitor mode with
> > out-of-bound detection and scan frequency configuration.
> >
> > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Hi
>=20
> Welcome to IIO.
> As Andy indicated there is quite a lot of work to do here.
> As such I did a quick review, but a lot of the code will change anyway as=
 a result of
> ripping out the custom ABI and the dt-binding changes requested.
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/adc/starfive-saradc.c
> > b/drivers/iio/adc/starfive-saradc.c
> > new file mode 100644
> > index 000000000000..78409cb1bcb2
> > --- /dev/null
> > +++ b/drivers/iio/adc/starfive-saradc.c
>=20
> > +
> > +#define SARADC_CHAN(_index) {					\
> > +	.type =3D IIO_VOLTAGE,					\
> > +	.indexed =3D 1,						\
> > +	.channel =3D _index,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> > +			BIT(IIO_CHAN_INFO_PROCESSED),		\
> See below.
>=20
> > +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.datasheet_name =3D "SARADC_"#_index,			\
> > +	.scan_index =3D _index,					\
> Not used.

Noted.

> > +	.scan_type =3D {						\
> > +		.sign =3D 'u',					\
> > +		.realbits =3D SARADC_REALBITS,			\
> > +		.endianness =3D IIO_CPU,				\
> Not used - so don't specify it.

Will drop it.

> > +	},							\
> > +}
>=20
> > +
> > +static const struct iio_chan_spec starfive_saradc_iio_channels[] =3D {
> > +	SARADC_CHAN(0),
> > +	SARADC_CHAN(1),
> > +	SARADC_CHAN(2),
> > +	SARADC_CHAN(3),
> > +	SARADC_CHAN(4),
> > +	SARADC_CHAN(5),
> > +	SARADC_CHAN(6),
> > +	SARADC_CHAN(7),
>=20
> SARADC is a common name, so prefix macros etc with something related to
> starfive.

Noted.

>=20
> > +};
>=20
> > +
> > +static void starfive_saradc_ch_lower_bound_set(struct starfive_saradc =
*priv,
> > +					       int ch, u32 data)
> > +{
> > +	void __iomem *base =3D priv->base + SARADC_ULB_CHX_REG_GET(ch);
> > +	u32 reg =3D readl(base) & ~ADC_LOWER_BOUND_MSK;
> > +
> > +	writel(FIELD_PREP(ADC_LOWER_BOUND_MSK, data) | reg, base);
> These helpers don't really help much. I'd just put the readl/writel inlin=
e where it's
> needed.

Noted.

>=20
> > +}
>=20
> > +
> > +static struct attribute *starfive_saradc_attributes[] =3D {
> > +	&iio_dev_attr_scan_frequency.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage0_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage1_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage2_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage3_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage4_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage5_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage6_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage7_upper.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage0_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage1_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage2_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage3_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage4_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage5_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage6_lower.dev_attr.attr,
> > +	&iio_dev_attr_in_voltage7_lower.dev_attr.attr,
> > +	&iio_dev_attr_voltage_monitor_channel.dev_attr.attr,
> > +	&iio_dev_attr_voltage_monitor_en.dev_attr.attr,
>=20
> Look at IIO event support and use that. I'm not seeing anything in here t=
hat should
> be provided as custom attributes.
>=20
> Basic rule is that if you add any custom attributes your driver will get =
a lot more
> push back. Key is that custom attributes =3D=3D no userspace support in s=
tandard code
> =3D=3D not much used.

Well, I will use IIO event instead.

>=20
>=20
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group starfive_saradc_attr_group =3D {
> > +	.attrs =3D starfive_saradc_attributes, };
> > +
> > +static int starfive_saradc_read(struct starfive_saradc *priv) {
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	starfive_saradc_ch_dis_save(priv);
> > +	if (!starfive_saradc_is_ready(priv)) {
> > +		dev_err(priv->dev, "ADC do not ready, please try again later!\n");
>=20
> Generally just return -EBUSY for this - no print because otherwise you pr=
ovide a
> userspace path to spam the kernel logs. If a print is really needed it sh=
ould be rate
> limited.

I will drop the print.

>=20
> > +		starfive_saradc_ch_stop(priv);
> > +		return -EBUSY;
> > +	}
> > +
> > +	priv->err =3D false;
> > +	starfive_saradc_ch_start(priv);
> > +
> > +	tmp =3D starfive_saradc_data_get(priv);
> > +	/* Check that the data is ready to be read. */
> > +	if (!(tmp & ADC_DAT_RDY_MSK)) {
> > +		ret =3D readl_poll_timeout(priv->base +
> SARADC_DATAX_REG_GET(priv->using_ch), tmp,
> > +					 (tmp & ADC_DAT_RDY_MSK), 10,
> SARADC_TIMEOUT);
> > +		if (ret) {
> > +			priv->err =3D true;
> > +			dev_err(priv->dev, "channel%d is still not ready to be read!
> Timeout!\n",
> > +				priv->using_ch);
> > +		}
> > +	}
> > +
> > +	if (priv->err)
> > +		tmp =3D 0;
> > +
> > +	starfive_saradc_ch_stop(priv);
> > +
> > +	return (int)(tmp & ADC_DAT_MSK);
>=20
> Prefer FIELD_GET() for all value extraction.

Noted.

>=20
> > +}
> > +
> > +static int starfive_saradc_read_raw(struct iio_dev *indio_dev,
> > +				    struct iio_chan_spec const *chan,
> > +				    int *val, int *val2, long mask) {
> > +	struct starfive_saradc *priv =3D iio_priv(indio_dev);
> > +	int ret;
> > +	u64 tmp;
> > +
> > +	mutex_lock(&priv->lock);
> guard() and acquire for PM (see below).
> But try to do these in the same order in all functions. Makes reasoning a=
bout what
> is protected simpler.  Normally I'd turn the power on first as that is re=
ference
> counted anyway so doesn't need to be under the lock.

Noted.

>=20
> > +	priv->using_ch =3D chan->channel;
> > +	ret =3D pm_runtime_get_sync(priv->dev);
> > +	if (ret < 0) {
> > +		pm_runtime_put_noidle(priv->dev);
> As below. the call that failed doesn't have side effects on failure so th=
is smells like
> an underflow.
>=20
> > +		mutex_unlock(&priv->lock);
> > +		return ret;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D starfive_saradc_read(priv);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		*val =3D ret;
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_PROCESSED:
>=20
> Don't provide both processed and raw for a channel.
>=20
> If the transform is linear then _raw + _scale if not then _processed.

Drop it.

>=20
> > +		ret =3D starfive_saradc_read(priv);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		/* VIN =3D AVDD * data[11:0] / 4096. (AVDD =3D 1.8v) */
> > +		tmp =3D SARADC_RAW_TO_VDD_ADJ(ret);
> > +		*val =3D (int)(tmp / 1000000);
> > +		*val2 =3D (int)(tmp % 1000000);
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/*
> > +		 * AVDD is fixed at 1.8v.
> > +		 * 1.8 / (1 << 12) * 1000000
> > +		 */
> > +		*val =3D 0;
> > +		*val2 =3D SARADC_AVDD_VOL / (1 << SARADC_REALBITS);
>=20
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> > +
> > +	default:
> > +		ret =3D -EINVAL;
> > +	}
> > +
> > +	pm_runtime_put_autosuspend(priv->dev);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t starfive_saradc_mon_stop_threadfn(int irq, void
> > +*data) {
> > +	struct starfive_saradc *priv =3D data;
> > +	u8 ch =3D priv->mon_ch;
> > +	u32 up, low, raw;
> > +
> > +	mutex_lock(&priv->lock);
> guard()
>=20
> > +	if (!priv->mon_en) {
>=20
> How would we get here?  If it's a race on shut down of events then normal=
ly we
> wouldn't worry as that's just precise timing of disable vs this thread ru=
nning.

Drop the check.

>=20
> > +		mutex_unlock(&priv->lock);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	raw =3D readl(priv->base + SARADC_DATAX_REG_GET(ch)) & ADC_DAT_MSK;
> > +	up =3D starfive_saradc_ch_upper_bound_get(priv, ch);
> > +	low =3D starfive_saradc_ch_lower_bound_get(priv, ch);
> > +	dev_err(priv->dev,
> > +		"channel %d is out of bounds. sample data: %dmv (range: %dmv
> ~ %dmv)\n",
> > +		ch, (SARADC_RAW_TO_VDD_ADJ(raw) / 1000),
> > +		priv->low_bounds[ch], priv->up_bounds[ch]);
>=20
> We have the IIO events infrastructure to report these to userspace. Use i=
t or drop
> this. dev_err is not a valid way to report this sort of threshold events.

Drop it.

>=20
> > +
> > +	starfive_saradc_ch_monitor_stop(priv, ch);
>=20
> Why stop it?  Add a comment.  We aren't interested in future events?

If we do not stop it and the input voltage remains constant, the ADC could =
continuously monitor the voltage and continuously trigger interrupts for th=
e bound.
As a result, the CPU utilization rate will be high.

>=20
> > +	pm_runtime_put_autosuspend(priv->dev);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t starfive_saradc_irq_handler(int irq, void *data) {
> > +	struct starfive_saradc *priv =3D data;
> > +	u32 irq_err =3D readl(priv->base + SARADC_IRQ_EN_ST);
> > +
> > +	if (!priv->mon_working)
>=20
> How do we hit this condition? If it's a race thing then add a comment on =
what that
> race is. If it's not our interrupt then return IRQ_NONE.

Drop it.

>=20
> > +		return IRQ_HANDLED;
> > +
> > +	/* Error of out of bounds */
> > +	if (irq_err & BIT(priv->mon_ch)) {
> > +		/* Clear the interrupt */
> > +		writel(irq_err, priv->base + SARADC_IRQ_EN_ST);
> > +		priv->err =3D true;
> > +		return IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void starfive_saradc_init(struct starfive_saradc *priv) {
> This will probably go away anyway but comments inline for future referenc=
e.

Noted.

>=20
> > +	bool use_def =3D false;
> > +	u16 up, low, scan, tmp;
> > +	u32 upmv, lowmv;
> > +	int i;
> > +
> > +	if (of_property_read_u16(priv->dev->of_node, "upper-bound-mv",
> > +&tmp)) {
>=20
> Use property.h accessors for new drivers, not the of_ones.
> They are cleaner and maybe this driver will one day be used with other fi=
rmware
> types.  Also I don't want of specific code in IIO drivers because it gets=
 cut and paste
> into others where another firmware type is actually likely.

Noted.

>=20
>=20
> > +		use_def =3D true;
> > +	} else {
> > +		up =3D SARADC_VDD_MV_TO_RAW(tmp);
> > +		if (up > ADC_UPPER_BOUND_DEF)
>=20
> If DT provide an invalid input fail to probe. We need that fixed.
> If it was a missing property then current convention is to use a check on=
 the
> property existing as a separate call before reading it.  That provides ne=
ater error
> handling.
>=20
>=20
> Mind you as per he discussion in that dt-binding thread this is going awa=
y.
>=20
> > +			use_def =3D true;
> > +		else
> > +			upmv =3D tmp;
> > +	}
> > +
> > +	if (use_def) {
> > +		up =3D ADC_UPPER_BOUND_DEF;
> > +		upmv =3D SARADC_RAW_TO_VDD_ADJ(up);
> > +		use_def =3D false;
> > +	}
> > +
> > +	if (of_property_read_u16(priv->dev->of_node, "lower-bound-mv",
> > +&tmp)) {
> Same for all of these as commnets above.
> > +		use_def =3D true;
> > +	} else {
> > +		low =3D SARADC_VDD_MV_TO_RAW(tmp);
> > +		if (low > ADC_UPPER_BOUND_DEF)
> > +			use_def =3D true;
> > +		else
> > +			lowmv =3D tmp;
> > +	}
> > +
> > +	if (use_def) {
> > +		low =3D ADC_LOWER_BOUND_DEF;
> > +		lowmv =3D SARADC_RAW_TO_VDD_ADJ(low);
> > +	}
> > +
> > +	if (of_property_read_u16(priv->dev->of_node, "scan-freq", &scan))
> > +		scan =3D ADC_SCAN_FREQ_DEF;
> > +
> > +	if ((scan & ADC_SCAN_FREQ_MSK) < ADC_SCAN_FREQ_MIN) {
> > +		dev_warn(priv->dev, "The scan_freq is out of range and use the
> default value!\n");
> > +		scan =3D ADC_SCAN_FREQ_DEF;
> > +	}
> > +
> > +	starfive_saradc_scan_freq_set(priv, scan);
> > +
> > +	for (i =3D 0; i < SARADC_MAX_CHANNELS; i++) {
> > +		starfive_saradc_ch_upper_bound_set(priv, i, up);
> > +		starfive_saradc_ch_lower_bound_set(priv, i, low);
> > +		priv->up_bounds[i] =3D upmv;
> > +		priv->low_bounds[i] =3D lowmv;
> > +	}
> > +}
> > +
> > +static int starfive_saradc_reg_access(struct iio_dev *indio_dev, unsig=
ned int reg,
> > +				      unsigned int writeval, unsigned int *readval) {
> > +	struct starfive_saradc *priv =3D iio_priv(indio_dev);
> > +	int ret =3D 0;
> > +
> > +	if (reg % 4 || reg > SARADC_SCAN_FREQ)
> > +		return -EINVAL;
> > +
> > +	ret =3D pm_runtime_get_sync(priv->dev);
> Look at  PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
> > +	if (ret < 0) {
> > +		pm_runtime_put_noidle(priv->dev);
>=20
> Why? It failed so we should not have a refcount to drop.

Will fix.

>=20
> > +		return ret;
> > +	}
> > +
> > +	mutex_lock(&priv->lock);
> In combination with  the acquire mentioned above, use a guard() for the m=
utex.

Noted
> > +
> > +	if (readval)
> > +		*readval =3D readl(priv->base + reg);
> > +	else if (reg < SARADC_ULB_CH0)
> > +		/* Allowed to write from SARADC_ULB_CH0 to
> SARADC_SCAN_FREQ */
> > +		ret =3D -EINVAL;
> With the changes above you can just return here.
>=20
> > +	else
> > +		writel(writeval, priv->base + reg);
> > +
> > +	mutex_unlock(&priv->lock);
> > +	pm_runtime_put_sync_autosuspend(priv->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info starfive_saradc_iio_info =3D {
> > +	.read_raw =3D starfive_saradc_read_raw,
> > +	.debugfs_reg_access =3D starfive_saradc_reg_access,
> > +	.attrs =3D &starfive_saradc_attr_group, };
> > +
> > +static int starfive_saradc_probe(struct platform_device *pdev) {
> > +	struct starfive_saradc *priv;
> > +	struct iio_dev *indio_dev;
> > +	int irq, ret;
> Worth using a local struct device.
> e.g.
> 	struct device *dev =3D &pdev->dev;
> just to shorten the various lines where it's used.

Noted.

>=20
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return dev_err_probe(&pdev->dev, -ENOMEM, "failed allocating
> iio
> > +device\n");
> This print is a noop for -ENOMEM so don't bother having it.
> 	if (!indio_dev)
> 		return -ENOMEM;

Noted.
>=20
>=20
> > +
> > +	priv =3D iio_priv(indio_dev);
> > +	platform_set_drvdata(pdev, indio_dev);
> > +	priv->dev =3D &pdev->dev;
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(&pdev->dev, irq,
> > +				     "failed to get irq\n");
>=20
> One line. Note that going slightly over 80 chars is fine if it helps read=
ability. I think
> this one is just under 80 anyway.

Noted.

>=20
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > +					starfive_saradc_irq_handler,
> > +					starfive_saradc_mon_stop_threadfn,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>=20
> Trigger direction should come from DT.  So don't set it here.
> We do this historically in some drivers and can't fix it now because some=
 board
> might rely on it.  Don't introduce it in a new driver.

OK, I will remove it.

>=20
> > +					dev_name(&pdev->dev), priv);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to request irq handler\n");
> > +
> > +	priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> > +				     "failed to get clock\n");
>=20
> As sashiko pointed out this might result in a clock underflow.  Fixing th=
at the mess
> of devm + runtime pm and working out general patterns is still a work in =
progress.
> For now maybe just check if you get such a warning.

Noted.

>=20
>=20
> > +
> > +	priv->rst =3D devm_reset_control_array_get_shared(&pdev->dev);
> > +	if (IS_ERR(priv->rst))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
> > +				     "failed to get resets\n");
> > +
> > +	ret =3D reset_control_deassert(priv->rst);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to deassert reset\n");
> > +
> > +	indio_dev->name =3D dev_name(&pdev->dev);
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->info =3D &starfive_saradc_iio_info;
> > +	indio_dev->channels =3D starfive_saradc_iio_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(starfive_saradc_iio_channels);
> > +
> > +	starfive_saradc_init(priv);
> > +	mutex_init(&priv->lock);
> > +
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	return devm_iio_device_register(&pdev->dev, indio_dev); }
> > +
> > +static void starfive_saradc_remove(struct platform_device *pdev) {
> > +	pm_runtime_disable(&pdev->dev);
> > +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>=20
> This is out of order wrt to the setup in probe.   I suspect you can use
> devm_pm_runtime_enable() instead and drop remove entirely.

Noted.

>=20
> > +}
> > +
> > +static int starfive_saradc_runtime_suspend(struct device *dev) {
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct starfive_saradc *priv =3D iio_priv(indio_dev);
> > +
> > +	starfive_saradc_pwr_on(priv, false);
>=20
> Having a function called pwr_on() is missleading given you use it to turn=
 the power
> off. Rename it simply pwr() Or consider if it is worth having the helper =
at all as it's
> very small and maybe having the code inline is simpler.

Got it.

>=20
>=20
> > +	clk_disable_unprepare(priv->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int starfive_saradc_runtime_resume(struct device *dev) {
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct starfive_saradc *priv =3D iio_priv(indio_dev);
> > +	int ret =3D clk_prepare_enable(priv->clk);
> > +
> > +	if (ret)
> > +		return ret;
> slight preference for
>=20
> 	int ret;
>=20
> 	ret =3D clk_prepare_enable(priv->clk);
> 	if (ret)
> 		return ret;
>=20
> as it keeps the set of ret and it's check right next to each other.

Noted.

> > +
> > +	starfive_saradc_pwr_on(priv, true);
> > +	/* Need time to completely power on. */
> > +	msleep(20);
>=20
> fsleep() preferred. Takes time in usecs but the point is it will use the =
generally right
> call for whatever the sleep is. That means readers don't have to think ab=
out it. See
> the docs for the implementation of fsleep() for more info on how it decid=
es
> whether to call msleep or not.
>=20
> If possible reference a datasheet section / table or similar for this sle=
ep length.
> That is helpful if turns out to be too short on some device in the future=
.

Got it.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(starfive_saradc_pm_ops,
> > +				 starfive_saradc_runtime_suspend,
> > +				 starfive_saradc_runtime_resume, NULL);
> > +
> > +static const struct of_device_id starfive_saradc_of_match[] =3D {
> > +	{ .compatible =3D "starfive,jhb100-saradc", },
> > +	{ }
> > +};
> > +
> > +static struct platform_driver starfive_saradc_driver =3D {
> > +	.probe	=3D starfive_saradc_probe,
> > +	.remove	=3D starfive_saradc_remove,
> > +	.driver	=3D {
> > +		.name =3D "starfive_saradc",
> > +		.of_match_table =3D starfive_saradc_of_match,
> > +		.pm =3D pm_ptr(&starfive_saradc_pm_ops)
> > +	},
> > +};
>=20
> common practice to not have a blank line here. Dropping it makes a clear
> association between the struct platform_driver and the macro that uses it=
.

Noted.

>=20
> > +
> > +module_platform_driver(starfive_saradc_driver);
> > +
> > +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> > +MODULE_DESCRIPTION("StarFive Successive Approximation Register ADC
> > +driver"); MODULE_LICENSE("GPL");

Thanks.
Best regards,
Xingyu Wu
