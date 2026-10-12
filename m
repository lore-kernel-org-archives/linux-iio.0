Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010052.outbound.protection.outlook.com [52.101.228.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0B255F52;
	Mon, 12 Oct 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786983; cv=fail; b=SY4TE3x26CmTF5roCOLWIQazzbDhrM9V92R+kHGh5+aza03YCfW4Yn2N4d346IN6ch2JzVkJBeqWNNXKuzCLDsdaI2eaI4SJBNIdqvSGsqvi4J1jUPUrGd1V2p1uDMxSRUZNHk/AKn00W8mAO1eW7pIyBU7LURxIqSV4sXcNMLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786983; c=relaxed/simple;
	bh=Lc1QmiIGZuq+rWgZTjfT587oboPerVMdb/gG/rIZ9Vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeGrNpyMOdiJY+8debtRpmH6T+hythZrTmIoLh4I3pp+oUJwUWZtLu1pMhy7MDL1j41gb+HL01VH3Ly/HJYWZrh9pCTBFavoXKn0ICWJsHRsm1BqIaXmtz3KnvIA57jNSgoMwrIJEP8L+PQUU7glS9FAVeMMLgj39U/eazwjXPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZiqhiI4d; arc=fail smtp.client-ip=52.101.228.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZiqhiI4d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z06j5azU/Gy3sm1duVEHzy3yjsZr4LRZYo4tiJ5Lh9TlxQS8Q2t7HEKIpSK1AW7izX3kH+yr3UapyDkzY4/Lkzm4tAfZXv6eXZjB7HRUT433VekihuK28NQ4FgDiFVtY7Uxr9o/X/kHAKd4tTftBM9/wEb4bahvGK0zJEd3pgiKXkigeUlA8PISO5YVCPyJNkiLfVuY1AZnfO1hqGYff3KdmtEb4+yvj8XXG6FMZDaa0COf796AybvxtvWRONWELlHrpTF2TESXgEzM1srNq0c3htPH7tfrbPNm1Tfj574da626zCxVYTLiBrAH1EZqWXo/GpnTKxMtaJnD6dfisOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoFjZDmjhzL0RPMnPqUK5sqm+jdPIpFd38chz6VM9v4=;
 b=TwsSPRDL44/Ns3w7CtuoUX9My6QCqEtUTdFJ1oNcz9wKqzweGOpQaqiUhlfuKcP2I23N5/f3gX/KbFkMdGuOwMMyf9S8z/HGZWS//8d/njdrMGaMuf3nlWOUtA9W6Yh56CAip2tj7DvHaxV4o1KDWzmnjJejZrys63NBqOPLeSoob9vzuQ32XnAREYZMn1XbPVFX09GmAUo7ZZqWlJh1qKOawg+D8WfZod3Y1bGv9VbrrhpRGWJGxnbx+53foTCYcnZ9ukNvS3dOgfiXRLOovZlAu1Wlp8ZqPJRUlxhZdSgTnOrQbwFOHvollBrqlpqWU/XgTGFsBia3bmAqIYw+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoFjZDmjhzL0RPMnPqUK5sqm+jdPIpFd38chz6VM9v4=;
 b=ZiqhiI4d7Lo+bVFznAqystO1duQxpHTe5fE/4UhhZuCXshuPl5REwatPCDJSR4iDcjbwM8jqyfrxl/0cJCP2vm2tReBEcJnJfDqbdfk35N1snrHlyTTV4kGZCQVbTJd0KAfEMvqNpsnYkUMOy5A8CFPEpwgxpiFRMOi+n77n/sM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB13766.jpnprd01.prod.outlook.com (2603:1096:405:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:36:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 06:36:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Cosmin-Gabriel Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
	<prabhakar.csengg+renesas@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Thread-Topic: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Thread-Index: AQHdWB3Uli/hLxPrJUi4KPIFkzBHYrb5dwEQ
Date: Mon, 12 Oct 2026 06:36:16 +0000
Message-ID:
 <TY3PR01MB1134605F95A87C6335DA319C4869F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To:
 <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB13766:EE_
x-ms-office365-filtering-correlation-id: a8f9cf4e-4282-4b82-663a-08df282b1e0c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|6133799003|10067099003|18002099003|22082099003|921020|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 8SUjV9HyrROuWfSq6p/XnVb2uw+stmxC+e4lCj/vrCXXwsB1LOKB3sZ6R1jqCJXhhFKUhyduhLjphThwIVvZha3U/97D+epR03SY1NbUQVxPCnCuzxnzzIkeZpvbiKr+6NQzjwfSm9Yd18Q7y+4MVH1Sol4hHcnZCMe9oTvfglsQG6CL2tYwjIw1wAWc4LMhPez9sQFh31l0/I7WQ8hFlzcf3ja86xP8Fbv5fhT1Ovs0KoKlhPrHO6rJ3C7eWxGy4YvOJ1to/T82uKhJnTmmyI8YZ7z92Ma+yrpWuoPEMXwVHaUWR6nAzZG0o3+svxGyOmEQ01lCBKuqEAcdWdZs0Y1LwArow7TgRmO/9idNRZTISEw7LDUsniMqH4cP/l1M8n/5AHOjuYmvazjrMxacsnUJeLdN36Qicjcq7i4IsqGbKQVzIOvey4GkBO+BVN6+JaryTRdlcz1X+GH+fsz4xgL8GBA2W0l3jJtDynuKrUfSfW/Pb2O5FqL0HtyPtWL6DdtaJTbXLJ4jITcCFOBfWK2knzulG/g6m8nRl+iYlWeDSODYEy62Huq1eENlpw5rvexS7HuXLNFZBB+hlZzOEFc+UqnI2QXfcjLXbR+uQ8WZ+wbgScPvEshZBfiaUTUXwGM/lZAELsm7SF8VvhK9ajygc/vqZw6kQxwp5+0A8xyaVKfu1Wlavp8G4uR4x4nW3cWPh+HeBcSIhoRveaJ2N71D2+wC+INpjDQTDZsM5shq0D7UjvbX00zEpiSuARGH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WiFUAI8rCFunFAPOCrSi9iJEyNdhtcW9QIbb/q068ikCoLGLZUGWWSTJD5?=
 =?iso-8859-1?Q?qbVBAEYg/0ZQYmfiuQJoudcEVR7ch+kYgp3svv/oBWh9wknmxw44WkXc0U?=
 =?iso-8859-1?Q?/TJ73jQBOTOYWs7oE836HsxgnLBjSQ8lQP23YxHoZ0Y/wXAjpEiT294MNr?=
 =?iso-8859-1?Q?DunlDnkXt53yA/jDAvno+f2qCusl/sT8os5B9hhgz+doDZC1CRjHWF6f3I?=
 =?iso-8859-1?Q?66BbWBMzj3TXvvS1sfeyDpqNbN8PZkLsT4RiYeT/ls/jgeCX+2jMlPLBWF?=
 =?iso-8859-1?Q?efHnpNEdL/1I1SqFm4l9VJ9sjeVj2WK9FHjEjtY3KGPglEUnFp0NqZyGbh?=
 =?iso-8859-1?Q?YASBPM06wMp8FVyyH9Uewx6wv0b+ju9Wf/I6MCbS2GaDJPUtiCgUIn2Wia?=
 =?iso-8859-1?Q?AU3gjYMm774rg6r4pCJwfF4Hw6g1JgxK1lAIlHFZUH3fyo0eKGsFcDi6QN?=
 =?iso-8859-1?Q?6CEm4t67IOr0TJK2ULKMng9LgNCoEzhlNbVTGwcuoEyXLAE5baXdJ0ID42?=
 =?iso-8859-1?Q?1L8QdbXceHd/C4v5EJ4CMSaRI1xagHr/6U06ugfhEZaJxL5PlXyO86cqnE?=
 =?iso-8859-1?Q?xiODtqKOmpWR74g6QgiwSOAP7DgE7mQNXV5zaPpiOoitPiIuIRefIEIbID?=
 =?iso-8859-1?Q?e/R8o0za9PlML3fOiZMLLUPhz3I3K5kCDT9TazZIPeyyHkz/X6Zkwdyhhr?=
 =?iso-8859-1?Q?Xf0aF3V2fCPaknHCK6/IkV8xlVmA+bdBdU/K0gG42o8h+AmLDiP0R49Pf6?=
 =?iso-8859-1?Q?FbBStPUjITvezGCTod75aD03Gk4hSKueZ6IuhThvECpwTk5F7U1sCWlhOf?=
 =?iso-8859-1?Q?4gHrBoGiqTJiGLK8RX+5KJ2Fc7wO1dEBABhfx5n6Gv4cLvcvhdlCV0XkLI?=
 =?iso-8859-1?Q?cJctQGqalNn4XVgSPl//QzrIfdf/LjP+2HSvIIZVnhKzZ83du2ZsWV3q4G?=
 =?iso-8859-1?Q?YBWMK/rAa6vZ2VE+Z2F71Ch4IafIsxp/FKlDg/QCPxVzrhPxpaDWmSsbsv?=
 =?iso-8859-1?Q?WZG2ARw718MCobU/CDC1XQ0w3YosclNydutF5UChDbh7QumCfV6ztb9cS+?=
 =?iso-8859-1?Q?cHSkPqfoEdQrgtsSiPRLdBlvVbgTwr1g2jJ3HM+88R+mE+w6RMKe++kXKK?=
 =?iso-8859-1?Q?9pJZRsaXRavyDk+7lJoq1sXYzn/ZVnA/hodpp3VE0TGh7zQLSMGDKJZ4IK?=
 =?iso-8859-1?Q?ng1U92wtC7znV+SXAqPOHlq2UpCQYY8rlwv6fGbqcFf9xaV1OpwQSnLc7w?=
 =?iso-8859-1?Q?1/zwxJK37Kpw6Kw/yK5VXLdD03uOquyLjU6fK8F937rERflqzfMF70GieS?=
 =?iso-8859-1?Q?X/JJrrPhOR58w/TQXK4RvFn+wPbt/PuHjfifba3flPdof8T+ji7j2pOrP0?=
 =?iso-8859-1?Q?9EB6tzMPy+gqlRKuRUF5ReQpgA8MBtBRNbYqEQskg42ZDp+8nd2XDVFbWG?=
 =?iso-8859-1?Q?s3hv8ijDDZjkZWXS/rATDGyhz6z0Fg90v86o71MVQRm5LbspL2CTWQLpAm?=
 =?iso-8859-1?Q?hDr9U0/CgZhWwDSGcD+t+IkPvwL6f5OhxTwDtWDaxvrGwjSaxCdUUkBkkB?=
 =?iso-8859-1?Q?ixgnXfGAMzGI4MWpMeLK82JNudVx2b6hRd08k1Uu9447UjuYw3p8PZbC2c?=
 =?iso-8859-1?Q?oJFN3GB5LMQNA+IP8XBE7ZDtekgtXih4CdCLE/gQe+52e8ds3vRoOwCSi6?=
 =?iso-8859-1?Q?oY5gyRX8imV+PyPyz6795vWIMpmS3fI5bSGfNas+pyhTx5JxrbRUhR6ZHa?=
 =?iso-8859-1?Q?MZ934qk/RSmUWAIVRT0WYX18F8VGzwyDpa2krt9CL8StKd8EupR3nqgDvI?=
 =?iso-8859-1?Q?tF2aNNq48A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f9cf4e-4282-4b82-663a-08df282b1e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:36:16.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9XvFCAAYbRlqFD6GrcMMs7QjzDanUC8CGFWDh9EfTDdeNy7g1djNzxqC/l1+TIy2ZBH5WSJ8WZS7dysnyt8tc19v2EPB+EbK5ckmOsZDBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13766

Hi Prabhakar,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 09 October 2026 19:41
> Subject: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares =
the RZ/T2H ADC IP but differs in
> channel count, sampling, calibration and resolution support.
>=20
> The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> 20 ADCLK cycles, does not support calibration, and supports selectable 12=
-bit and 8-bit conversion
> resolution.
>=20
> Expose the fixed sampling frequency as a read-only attribute and allow th=
e conversion resolution to be
> changed through the scale attribute.
> Use extended scan types so the reported scan type follows the selected re=
solution, and prevent resolution
> changes while buffered capture is active.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Updated Kconfig description
> - Included array_size.h
> - Dropped unnecessary extra line in rzt2h_adc_write_scale
> ---
>  drivers/iio/adc/Kconfig     |  10 +-
>  drivers/iio/adc/rzt2h_adc.c | 201 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 205 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index a802=
d8ee4dd9..9a58f8b5868b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1587,14 +1587,18 @@ config RZN1_ADC
>  	  module will be called rzn1-adc.
>=20
>  config RZT2H_ADC
> -	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> +	tristate "Renesas RZ/T2H / RZ/N2H (and similar SoCs) ADC driver"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select IIO_ADC_HELPER
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
> +	select POWER_SEQUENCING
>  	help
> -	  Say yes here to build support for the ADC found in Renesas
> -	  RZ/T2H / RZ/N2H SoCs.
> +	  Say yes here to build support for the ADC found in Renesas SoCs:
> +	  - RZ/N2H
> +	  - RZ/T2H
> +	  - RZ/V2H(P)
> +	  - RZ/V2N
>=20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rzt2h_adc.
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c in=
dex 0703c2025e3f..be8273f3b61d
> 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>=20
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/clk.h>
> @@ -20,7 +21,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/reset.h>
> +#include <linux/units.h>
>  #include <linux/time64.h>
>=20
>  #define RZT2H_ADCSR_REG			0x00
> @@ -33,6 +36,11 @@
>  #define RZT2H_ADANSA0_REG		0x04
>  #define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
>=20
> +#define RZT2H_ADCER_REG			0x0e
> +#define RZT2H_ADCER_ADPRC_MASK		GENMASK(2, 1)
> +#define RZT2H_ADCER_ADPRC_12BIT		0b00
> +#define RZT2H_ADCER_ADPRC_8BIT		0b10
> +
>  #define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
>=20
>  #define RZT2H_ADSSTRn(n)		(0xe0 + 0x1 * (n))
> @@ -60,13 +68,29 @@
>  					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
>  #define RZT2H_ADC_STOP_CYCLES		2
>=20
> +/*
> + * RZ/V2H has no sample state register, each A/D channel conversion
> +takes a
> + * fixed 20 ADCLK cycles (sampling + comparison), giving a conversion
> +rate of
> + * ADCLK / 20.
> + */
> +#define RZV2H_ADC_CONV_CYCLES		20
> +
>  #define RZT2H_ADC_VREF_mV		1800
>=20
>  #define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
>  #define RZT2H_ADC_FEATURE_SAMPLE_STATE	BIT(1)
> +/* Selectable 12-bit / 8-bit conversion (ADCER.ADPRC) */
> +#define RZT2H_ADC_FEATURE_RES_SELECT	BIT(2)
> +/* Power-down mode controlled by the SYS power sequencer (SY_MSTP_ADA) *=
/
> +#define RZT2H_ADC_FEATURE_POWER_DOWN	BIT(3)
>=20
>  struct rzt2h_adc;
>=20
> +enum rzt2h_adc_resolution {
> +	RZT2H_ADC_RES_12BIT,
> +	RZT2H_ADC_RES_8BIT,
> +};
> +
>  struct rzt2h_adc_chip_info {
>  	const struct iio_chan_spec *chan_template;
>  	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst); @@ -100,6 +124,7 @@ =
struct rzt2h_adc {
>  	struct device *dev;
>  	const struct rzt2h_adc_chip_info *chip_info;
>  	struct reset_control *rstc;
> +	struct pwrseq_desc *pwrseq;
>=20
>  	phys_addr_t phys_base;
>  	struct rzt2h_adc_dma dma;
> @@ -108,6 +133,7 @@ struct rzt2h_adc {
>  	struct mutex lock;
>=20
>  	const struct iio_chan_spec *channels;
> +	enum rzt2h_adc_resolution resolution;
>  	unsigned int num_channels;
>  	u16 buf[RZT2H_ADC_MAX_CHANNELS];
>=20
> @@ -118,6 +144,11 @@ struct rzt2h_adc {
>  	int irq;
>  };
>=20
> +static const int rzv2h_adc_scale_avail[] =3D {
> +	RZT2H_ADC_VREF_mV, 12,
> +	RZT2H_ADC_VREF_mV, 8,
> +};
> +
>  static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversi=
on_type)  {
>  	u16 reg;
> @@ -163,6 +194,23 @@ static void rzt2h_adc_set_sst(struct rzt2h_adc *adc,=
 unsigned int ch, u8 sst)
>  	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));  }
>=20
> +static void rzt2h_adc_set_resolution(struct rzt2h_adc *adc) {
> +	u16 reg;
> +
> +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> +		return;
> +
> +	reg =3D readw(adc->base + RZT2H_ADCER_REG);
> +
> +	if (adc->resolution =3D=3D RZT2H_ADC_RES_8BIT)
> +		FIELD_MODIFY(RZT2H_ADCER_ADPRC_MASK, &reg, RZT2H_ADCER_ADPRC_8BIT);
> +	else
> +		FIELD_MODIFY(RZT2H_ADCER_ADPRC_MASK, &reg, RZT2H_ADCER_ADPRC_12BIT);
> +
> +	writew(reg, adc->base + RZT2H_ADCER_REG); }
> +
>  static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch,=
 int *val)  {
>  	int ret;
> @@ -179,12 +227,14 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *=
adc, unsigned int ch, int *va
>  	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
>=20
>  	rzt2h_adc_set_sst(adc, ch, adc->sst[ch]);
> +	rzt2h_adc_set_resolution(adc);
>=20
>  	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);
>=20
>  	/*
>  	 * Conversion can take up to ~4.3us at the maximum configurable ADSSTRn
> -	 * (ADSSTRn + 13 cycles at 62.5 MHz), which rounds up to 1 jiffy. A bar=
e
> +	 * (ADSSTRn + 13 cycles at 62.5 MHz) on RZ/T2H, and up to 4.0us (20
> +	 * cycles at 5 MHz) on RZ/V2H, which rounds up to 1 jiffy. A bare
>  	 * 1-jiffy timeout can expire almost immediately if it's armed right
>  	 * before a tick, so add one more jiffy to guarantee the conversion tim=
e
>  	 * actually elapses.
> @@ -472,6 +522,8 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev=
 *indio_dev)
>=20
>  	writew(val, adc->base + RZT2H_ADANSA0_REG);
>=20
> +	rzt2h_adc_set_resolution(adc);
> +
>  	adc->dma.period_index =3D 0;
>  	atomic_set(&adc->dma.pending_periods, 0);
>=20
> @@ -509,6 +561,11 @@ static int rzt2h_adc_sst_to_freq(struct rzt2h_adc *a=
dc, u8 sst)
>  	return adc->adclk_rate / (RZT2H_ADC_CONV_CYCLES_BASE + sst);  }
>=20
> +static int rzv2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst) {
> +	return DIV_ROUND_CLOSEST(adc->adclk_rate, RZV2H_ADC_CONV_CYCLES); }
> +
>  static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)  {
>  	unsigned int cycles;
> @@ -521,6 +578,45 @@ static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *ad=
c, int freq)
>  	return cycles - RZT2H_ADC_CONV_CYCLES_BASE;  }
>=20
> +static int rzt2h_adc_get_current_scan_type(const struct iio_dev *indio_d=
ev,
> +					   const struct iio_chan_spec *chan) {
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> +
> +	return adc->resolution;
> +}
> +
> +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2)
> +{
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> +	unsigned int i;
> +	u64 scale;
> +	u32 rem;
> +
> +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < chan->num_ext_scan_type; i++) {
> +		scale =3D (u64)RZT2H_ADC_VREF_mV * NANO >>
> +			chan->ext_scan_type[i].realbits;
> +		if (div_u64_rem(scale, NANO, &rem) =3D=3D val && rem =3D=3D val2)
> +			break;
> +	}
> +	if (i =3D=3D chan->num_ext_scan_type)
> +		return -EINVAL;
> +
> +	/* The scan type changes with the resolution. */
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	adc->resolution =3D i;
> +
> +	return 0;
> +}
> +
>  static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int *val, int *val2, long mask) @@ -576,11 +672,25 @@ static in=
t
> rzt2h_adc_write_raw(struct iio_dev *indio_dev,
>=20
>  		return 0;
>  	}
> +	case IIO_CHAN_INFO_SCALE:
> +		return rzt2h_adc_write_scale(indio_dev, chan, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
>  }
>=20
> +static int rzt2h_adc_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
>  static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				const int **vals, int *type, int *length, @@ -594,6 +704,11 @@ stati=
c int
> rzt2h_adc_read_avail(struct iio_dev *indio_dev,
>  		*type =3D IIO_VAL_INT;
>  		*length =3D ARRAY_SIZE(adc->samp_freq_avail);
>  		return IIO_AVAIL_RANGE;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D rzv2h_adc_scale_avail;
> +		*type =3D IIO_VAL_FRACTIONAL_LOG2;
> +		*length =3D ARRAY_SIZE(rzv2h_adc_scale_avail);
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -610,6 +725,14 @@ static const struct iio_info rzt2h_adc_iio_info =3D =
{
>  	.read_avail =3D rzt2h_adc_read_avail,
>  };
>=20
> +static const struct iio_info rzv2h_adc_iio_info =3D {
> +	.read_raw =3D rzt2h_adc_read_raw,
> +	.write_raw =3D rzt2h_adc_write_raw,
> +	.write_raw_get_fmt =3D rzt2h_adc_write_raw_get_fmt,
> +	.read_avail =3D rzt2h_adc_read_avail,
> +	.get_current_scan_type =3D rzt2h_adc_get_current_scan_type, };
> +
>  static irqreturn_t rzt2h_adc_isr(int irq, void *private)  {
>  	struct rzt2h_adc *adc =3D private;
> @@ -634,6 +757,33 @@ static const struct iio_chan_spec rzt2h_adc_chan_tem=
plate =3D {
>  	},
>  };
>=20
> +static const struct iio_scan_type rzv2h_adc_scan_types[] =3D {
> +	[RZT2H_ADC_RES_12BIT] =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 12,
> +		.storagebits =3D 16,
> +		.endianness =3D IIO_CPU,
> +	},
> +	[RZT2H_ADC_RES_8BIT] =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 8,
> +		.storagebits =3D 16,
> +		.endianness =3D IIO_CPU,
> +	},
> +};
> +
> +static const struct iio_chan_spec rzv2h_adc_chan_template =3D {
> +	.indexed =3D 1,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.type =3D IIO_VOLTAGE,
> +	.has_ext_scan_type =3D 1,
> +	.ext_scan_type =3D rzv2h_adc_scan_types,
> +	.num_ext_scan_type =3D ARRAY_SIZE(rzv2h_adc_scan_types), };
> +
>  static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)  {
>  	struct iio_chan_spec *chan_array;
> @@ -702,6 +852,21 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio=
_dev)
>  					       &rzt2h_adc_buffer_setup_ops, NULL);  }
>=20
> +static int rzt2h_adc_get_pwrseq(struct rzt2h_adc *adc) {
> +	struct device *dev =3D adc->dev;
> +
> +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_POWER_DOWN))
> +		return 0;
> +
> +	adc->pwrseq =3D devm_pwrseq_get(dev, "adc-power");
> +	if (IS_ERR(adc->pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(adc->pwrseq),
> +				     "failed to get power sequencer\n");
> +
> +	return 0;
> +}
> +
>  static int rzt2h_adc_probe(struct platform_device *pdev)  {
>  	const struct rzt2h_adc_chip_info *chip_info; @@ -736,6 +901,10 @@ stati=
c int
> rzt2h_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(adc->rstc))
>  		return PTR_ERR(adc->rstc);
>=20
> +	ret =3D rzt2h_adc_get_pwrseq(adc);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D rzt2h_adc_parse_properties(adc);
>  	if (ret)
>  		return ret;
> @@ -787,6 +956,14 @@ static int rzt2h_adc_probe(struct platform_device *p=
dev)
>  	return devm_iio_device_register(dev, indio_dev);  }
>=20
> +static const struct rzt2h_adc_chip_info rzv2h_adc_info =3D {
> +	.chan_template =3D &rzv2h_adc_chan_template,
> +	.sst_to_freq =3D rzv2h_adc_sst_to_freq,
> +	.info =3D &rzv2h_adc_iio_info,
> +	.num_channels =3D 8,
> +	.features =3D RZT2H_ADC_FEATURE_RES_SELECT |
> +RZT2H_ADC_FEATURE_POWER_DOWN, };
> +
>  static const struct rzt2h_adc_chip_info rzt2h_adc_info =3D {
>  	.chan_template =3D &rzt2h_adc_chan_template,
>  	.sst_to_freq =3D rzt2h_adc_sst_to_freq,
> @@ -796,6 +973,7 @@ static const struct rzt2h_adc_chip_info rzt2h_adc_inf=
o =3D {  };
>=20
>  static const struct of_device_id rzt2h_adc_match[] =3D {
> +	{ .compatible =3D "renesas,r9a09g057-adc", .data =3D &rzv2h_adc_info },
>  	{ .compatible =3D "renesas,r9a09g077-adc", .data =3D &rzt2h_adc_info },
>  	{ }
>  };
> @@ -804,8 +982,17 @@ MODULE_DEVICE_TABLE(of, rzt2h_adc_match);  static in=
t
> rzt2h_adc_pm_runtime_suspend(struct device *dev)  {
>  	struct rzt2h_adc *adc =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pwrseq_disable(adc->pwrseq);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_assert(adc->rstc);

I guess to apply assert reset, IP needs power.
So, you need to asset first and then power off.

Cheers,
Biju

> +	if (ret)
> +		pwrseq_enable(adc->pwrseq);
>=20
> -	return reset_control_assert(adc->rstc);
> +	return ret;
>  }
>=20
>  static int rzt2h_adc_pm_runtime_resume(struct device *dev) @@ -818,6 +10=
05,12 @@ static int
> rzt2h_adc_pm_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D pwrseq_enable(adc->pwrseq);
> +	if (ret) {
> +		reset_control_assert(adc->rstc);
> +		return ret;
> +	}
> +
>  	if (!(chip_info->features & RZT2H_ADC_FEATURE_CALIBRATION))
>  		return 0;
>=20
> @@ -829,8 +1022,10 @@ static int rzt2h_adc_pm_runtime_resume(struct devic=
e *dev)
>  	fsleep(1);
>=20
>  	ret =3D rzt2h_adc_calibrate(adc);
> -	if (ret)
> +	if (ret) {
> +		pwrseq_disable(adc->pwrseq);
>  		reset_control_assert(adc->rstc);
> +	}
>=20
>  	return ret;
>  }
> --
> 2.55.0

