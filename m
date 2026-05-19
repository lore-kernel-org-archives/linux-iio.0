Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8403DD502;
	Tue, 19 May 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176855; cv=fail; b=Nds+JKoYgscHMgo9idbUkFRkGrSGf3UVw9A8dHLimBf/0t3aNPwJeJ9AgOeUutYKtLyV3OWS2pRH7crbpmhcfEyAUtAMTIJv43YpUwKPGbu+fhV6LS2tsgB69oe+EVn/7LqK7UYjhoHvQKMhxkyF8usvIjJp6nm7Ebt6YLbuXa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176855; c=relaxed/simple;
	bh=WjS5ijlfo6fDe03XOmS175lulgVNmHzORPWaP198BRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0a5IvktvFZ9Ao+C5MElhSSihVkn8lHodbgT711zMoNYRXXh16Jhc3Anx3r08klWHzs0Fx5YM9H8f8REaHoAfLAw8oLbxElf3wTGfjxJuc/prN/vTYZ367U2G/+hLG/LKXmpv4naU2TaPZaVmpsm4/hfoJPdksyOjfSht3KOc4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nENfm9aU3HpTQbpKqwcvUGm/VFNGTvgG6kKH86LL4aixes6xPLwGeZ59nDuzC9ow1aQIxpVVM7EO0YefbBfAZ2XtqjruFq9/5mx33UEYRGLVmJ1BoxV6vo+SI8on/1o3JHDA60o+VDHGb2U4PJTe7mLABOEtSHUTk1IZPj+F9dwfqHSv7VwEBPIbuiYBZGUsxMq88jYmtqDQJLCe1bhU18Fd5R6qGYtzO3u/4MVzQgxB0irL3bdx5ZkBvy4PkALocoFItC1TcX60lR0uJPMRXFU76CyS4gydxPaC3gL1RncOifO/cr9Mqh+MZR6PyxElBQR8E3ozZ4SdScH8P2pMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv5jDHjjciP7WIxZRBADpKsBb5VByqXeyc3zUoiBWCQ=;
 b=fijvou60XiVu1wzrkn4zXIud0l6ibu9X6Sm5+QBomk7HsEWKTdFZSNg9X3LaOTx0pWkyM/4DbUiCPYOtlBOM0K9OinxwODUo9PNoxP/7/XIheJbTEqKlWzmRkOiIUJA0OyYeUB+Dz3+YllQoOhJNWhyZUPtOhQfhXzl3fUVho66sX4duXg5Eii5c7YclXlM+KGCBH+1et2GPLDQIHn+M6oapy0FufZZytmcJEKr38eaUNMBVMOAOAWb9aFNhVw0TPlMEQEcDRX7cMZo7msj3B9IJmcuAllDfgsj6uJRHwJ8XvTEcENxBsahI8HN7jzRnatE8O3jiJ2A9WoFGOyRVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0972.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.25; Tue, 19 May
 2026 07:47:22 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0025.023; Tue, 19 May 2026 07:47:22 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Thread-Topic: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Thread-Index: AQHc5p78VOCTIhrpH0CxuRbZCQ5XkrYTdBqAgAFq61A=
Date: Tue, 19 May 2026 07:47:22 +0000
Message-ID:
 <NTZPR01MB09561F97E9F5BA2704A128369F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-3-xingyu.wu@starfivetech.com>
 <agrOS-sqqldnGGeP@ashevche-desk.local>
In-Reply-To: <agrOS-sqqldnGGeP@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB0972:EE_
x-ms-office365-filtering-correlation-id: 9ef83edc-70ee-4fb7-27e6-08deb57adc74
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 ALSYxg6alqQALOpq/IMwMp28PfdsVGAKlfYUHKZfLMEY7AMrGV3k/ZX/nB5b1oqZ0EORqX9DyLteQ7orrs/J51RPUPA1cEgX2+gwRrs0oS3dfNjON19B1hSri+05mtW2fw5c8WyFglkC/25wHnbHkIRtVEAHmvaMzEY1GvIFoZyJpqeVht74gAuwm7PMMiRgAKSrLivMgG8QZp5taSxLNnltl5oLRxlIOmXgPfIsAKh47l5/dCQ2gLqGm5uJJaUX48oIopX8kQbHua00qjxAD/XCpBmqMmqojJin74bOGbKD9oLAXedVxyH/vuCOAORxfQMzRzVLxzbj434cjzSKrBIPPgy78iyhvzMtgAq0oE2hUQJ5aFHIvkDAKwpzQ8t7pBvIkBuBupEzykkvZXtSV1+Q2mEY/oUI/F6St57jzUzpAOUyTu4GaGuNtFrt+kLSYcBfgrd5SVeZOjIYgpAfsYG/A4eWtoIOL+uWqoZU8wkmWVG8tbmZpSTE47QA7zRfj60az2i0vXDTPrHjr+ErvkPSb49vFf0kpJxh0dnqkkrbejEauosb/ybDj5So450q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WowMQQeZpIpP3/a1fUFcCxT5ZBr1Y+Qtzk+hnu5RVajzXZtbyJ9nGhX4Kz?=
 =?iso-8859-1?Q?ZdfZRSNAFFwQp5MXAhT8XsH9uqyzjYsVwNRUan1D+NEei6OtETgYYaLUCD?=
 =?iso-8859-1?Q?1ngS112xstlZ6J8KV3FsOAaO7FeDhA/Y8OSdkepwnyEuFPpjTXGu4WApcU?=
 =?iso-8859-1?Q?EewBGSNCe7pExLv6NASYStZ/PROZExWgFu96XtbYIbmrgbjFcQOXJQubpr?=
 =?iso-8859-1?Q?oLcw2tIY3fiaVydKDltqsrMEStOG8McmynbFaNhdydoM1H1WTAslX0NoTp?=
 =?iso-8859-1?Q?VelnjY5YuQZuZUHB0QOYAJNyUdDWFf+DdB0qYvbFzqbdrSRPHb6buko4BU?=
 =?iso-8859-1?Q?gchUZo/L9pdTrKMpH6C5crqz4OD56pQL2yM7ik5nDqyyE1Fc3fsijHURHM?=
 =?iso-8859-1?Q?E2GqbDhIgTCURUiIbaLzvD5qMNoLZ1CvzmXFhm4svMVOYrjAJTEsG+6OCQ?=
 =?iso-8859-1?Q?DC2ZeLc1+75Wko1Gm1d+8++yE9RNAWMSn425tC7ubIukD0xcW16xbi4OvG?=
 =?iso-8859-1?Q?iIQUC3TNpg7VPq+ahYu/SJoyeclI0yPCykxbjnhOjLPf2ZmN5YbAP6NU16?=
 =?iso-8859-1?Q?l01eZkJi2rta6fTs7kblPEXg5pDZpbDvvLj9qUqyKIb7DE7ssuwtMM5dq1?=
 =?iso-8859-1?Q?C1UGnBU+Za12UGjrDDfJcAI+u3aXF2g/EmHMj+P4JOSEgU81Y5rDmUsQv1?=
 =?iso-8859-1?Q?Q25WL8BzV8YSdC4ph4GGzublloe+/psOn+fW+ltHddzR4+uXP/32i3LZ6o?=
 =?iso-8859-1?Q?2ZwZv1cGwqXXMmdUVdgMyy5ub75lP6iMSN0JO5sg8pBdVBX27M7NEa3LJY?=
 =?iso-8859-1?Q?7fKuZzTpncmWm7Zt2/PAXY5ahQbc/fJ6e/Op80f3fodbfuiMBLcw34eTpk?=
 =?iso-8859-1?Q?702duHOfFYDNef4baO/U01ieYsyGaOxdgqSpa/rwo/zxh2rqcDtuVE4OBU?=
 =?iso-8859-1?Q?mArUbAQg06aOq9RPfNDKk+6ARgK1xin0O3hYjWYAa3LH21WaoJYK3tFTqF?=
 =?iso-8859-1?Q?RS6xMVwc3pxxrpyUl2cTfX5F/ZWU67MMd4/VC282XDG9mhIPfVp6u7tzVo?=
 =?iso-8859-1?Q?c+akYe8CzPmY+JmViK3ElQpMMhBzitPVQh25FS+s19enkWPzU91FIjEV5w?=
 =?iso-8859-1?Q?yJiJyrIfod11Ne32XEspWYtjvNNOu36CRULrbgnsUGtSXTef7La1E4wPOt?=
 =?iso-8859-1?Q?RF16ROevUJphX+JJvM44g75XoRuw7aFKKvkGGqcLFputqLqk+hzqVd0v/u?=
 =?iso-8859-1?Q?zhZ6IwFbIlauZZCN/YFk0YQpNmBS1pUVt/GcHTz4RSkSnLzEF8zKS7xI6R?=
 =?iso-8859-1?Q?iLR2c793tWDEEHyOqhdCvl0Yk0335IBVzBRrYN3lfeIs5hCdasfv2Cr1P3?=
 =?iso-8859-1?Q?FLzy3M4xOb0a5dDsdJZXDlRUve/ucm6iWteD9kQlrIKx0RjTSNdYY02KnA?=
 =?iso-8859-1?Q?gThdyZA/NdpN+PFD9dJ/Vcg+BX0Kl2tpvh2qOcSxtCbVWqVfsovEWxxS++?=
 =?iso-8859-1?Q?vb56JfUwAr5/0AbMzEMG2tRauo5Fmae6TQwe0Jrx6PxwQN5Z4UXze+icql?=
 =?iso-8859-1?Q?iNFflcmEymvLavOr6d6wuPTsPYOIBqqlqEdxEjl53oO7p9eK5dzV7YWZSv?=
 =?iso-8859-1?Q?xQ0t5Efzwsg+Un8tGCBvFJtDAxHmG1O/qejHCOUQalcpfh+MKfINI3CAPw?=
 =?iso-8859-1?Q?1qS0lMp8rM/gG1wceBJ86/UItR5qCDpF/9Hi+U881O1cKDvzxKzbHc4heT?=
 =?iso-8859-1?Q?IP2wK2VN5qX2rk2k/G1m4+8QsbNBM9qsiad2DoihYf7+JE8Gk5WMNqL/15?=
 =?iso-8859-1?Q?VJgsWcn/BA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef83edc-70ee-4fb7-27e6-08deb57adc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:47:22.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsDMYEkptIclJ424DyAJ2oAkCyN7GiiwdGQfcf8EhxhWfOQOk9aZkNF9V+KM9y8K23wPUlZsjpbLLRpShArnzeo8OOit/oat2u6+OTkzJBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0972

On 2026/5/18 16:31, Andy Shevchenko wrote:
>=20
> On Mon, May 18, 2026 at 04:18:52PM +0800, Xingyu Wu wrote:
> > Add a new IIO ADC driver for the StarFive JHB100 SAR ADC controller.
> >
> > The hardware provides 12-bit conversion precision and up to 8 input
> > channels. This driver supports single-shot channel reads and exposes
> > standard IIO interfaces for raw ADC values, processed voltages, and=20
> > scale reporting. The driver also supports channel monitor mode with
> > out-of-bound detection and scan frequency configuration.
>=20
> Seems like this is just dust off code from ca 2020, as it uses sometimes =
quite old
> APIs (no driver uses in the past few years in IIO!).
> This needs much more work, please take your time to go via existing IIO d=
rivers
> that were submitted and accepted in 2025/2026 and take them as examples (=
may
> be not the best, but good enough) and update your code accordingly. Note,
> reviewing others' patches may help a lot to get your knowledge up-to-date=
.=20

Noted. I will update the driver in next patch.

>=20
> ...
>=20
> > +config STARFIVE_SARADC
> > +	tristate "StarFive SARADC driver"
> > +	depends on ARCH_STARFIVE || COMPILE_TEST
> > +	depends on COMMON_CLK && RESET_CONTROLLER
> > +	help
> > +	  Say yes here to build support for the SARADC found in SoCs from
> > +	  StarFive.
> > +
> > +          To compile this driver as a module, choose M here: the
> > +          module will be called starfive_saradc.
>=20
> Indentation issues.

Noted.

>=20
> ...
>=20
>=20
> Follow IWYU.
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
>=20
> > +#include <linux/of.h>
>=20
> No OF in a new code for the drivers like this one.

Will drop.

>=20
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
>=20
> ...
>=20
> > +#define SARADC_VDD_MV_TO_RAW(x)		({ \
> > +						((x) =3D=3D 0) ? 0U : ({ \
> > +							u32 _raw =3D \
> > +							(u32)(((u64)(x) *
> 64000000ULL + \
> > +							4514610639ULL) /
> 30318750ULL); \
> > +							_raw > 4095 ? 4095 : _raw;
> \
> > +						}); \
> > +					})
>=20
> This is so ugly! Use your common sense and see tons of the examples aroun=
d (the
> more recent driver is the average better the code is).

Will fix.

>=20
> ...
>=20
> > +struct starfive_saradc {
>=20
> Use `pahole` to check the layout, also shuffle members to see what `bloat=
-o-
> meter` says about the resulting binary (for example, moving 'dev' up migh=
t give
> less code).

Noted.

>=20
> > +	void __iomem		*base;
> > +	struct device		*dev;
> > +	struct clk		*clk;
> > +	struct reset_control	*rst;
> > +	/* lock to protect against multiple access to the device */
> > +	struct mutex		lock;
> > +	int			using_ch;
> > +	/* flag of interrupts by error or data done */
> > +	bool			err;
> > +	bool			mon_working;
> > +	u8			mon_ch;
> > +	bool			mon_en;
> > +	u32			up_bounds[SARADC_MAX_CHANNELS];
> > +	u32			low_bounds[SARADC_MAX_CHANNELS];
> > +};
>=20
> ...
>=20
> > +static inline void starfive_saradc_irq_clr_all(struct starfive_saradc
> > +*priv) {
> > +	unsigned int reg =3D readl(priv->base + SARADC_IRQ_EN_ST);
> > +	int i;
> > +
> > +	starfive_saradc_irq_clr(priv, reg);
>=20
> > +	for (i =3D 0; i < SARADC_MAX_CHANNELS; i++)
>=20
> 	for (unsigned int i =3D 0; i < SARADC_MAX_CHANNELS; i++)
>=20
>=20
> > +		starfive_saradc_data_clr_ch(priv, i); }
>=20
> ...
>=20
> > +static void starfive_saradc_ch_dis_save(struct starfive_saradc *priv)
> > +{
> > +	unsigned int reg;
> > +
> > +	if (priv->mon_en) {
> > +		writel(ADC_IRQ_ST_MSK, priv->base + SARADC_IRQ_EN_ST);
> > +
> > +		reg =3D readl(priv->base + SARADC_CTRL) & ~ADC_CHAN_EN_MSK;
> > +		writel(reg, priv->base + SARADC_CTRL);
> > +		priv->mon_working =3D false;
> > +	}
> > +
> > +	starfive_saradc_irq_clr_all(priv);
> > +	msleep(20);
>=20
> So long sleeps must be explained (in the code comments with the reference=
 to
> datasheet or citing it in case of non-public document)!

Explanations will be added.

>=20
> > +}
> > +
> > +static void starfive_saradc_ch_start(struct starfive_saradc *priv) {
> > +	int ch =3D priv->using_ch;
> > +	unsigned int reg =3D readl(priv->base + SARADC_CTRL);
> > +
> > +	/* Enable channel */
> > +	reg =3D (reg & ~ADC_CHAN_EN_MSK) | SARADC_CHAN_EN(ch);
> > +	writel(reg, priv->base + SARADC_CTRL);
> > +
> > +	msleep(20);
>=20
> Ditto!
>=20
> > +	/* Enable conversion */
> > +	writel(reg | ADC_EN_MSK, priv->base + SARADC_CTRL); }
>=20
> ...
>=20
> > +static ssize_t starfive_saradc_monitor_channel_show(struct device *dev=
,
> > +						    struct device_attribute *attr,
> > +						    char *buf)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +	struct starfive_saradc *priv =3D iio_priv(indio_dev);
>=20
> > +	return sprintf(buf, "%d\n", priv->mon_ch);
>=20
> Huh?! Is this driver taken from the ancient times and got just dust off?
>=20
> > +}
>=20
> ...
>=20
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(&pdev->dev, irq,
> > +				     "failed to get irq\n");
>=20
> No, we don't do dup messages.

Drop it.

>=20
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > +					starfive_saradc_irq_handler,
> > +					starfive_saradc_mon_stop_threadfn,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +					dev_name(&pdev->dev), priv);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to request irq handler\n");
>=20
> Ditto.
>=20
> ...
>=20
> > +
>=20
> Unneeded blank line.

Drop it.

>=20
> > +module_platform_driver(starfive_saradc_driver);
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Best regards,
Xingyu Wu

