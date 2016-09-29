Return-Path: <stefan.wahren@i2se.com>
Date: Thu, 29 Sep 2016 03:38:19 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Lee Jones <lee.jones@linaro.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org,
	linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	dmitry.torokhov@gmail.com, harald@ccbib.org,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	marex@denx.de
Message-ID: <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange@email.1und1.de>
In-Reply-To: <20160928010533.GQ21388@dell>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
 <b50209289b241995c6fd5e23c7343448857fc301.1474108510.git.ksenija.stanojevic@gmail.com>
 <20160928010533.GQ21388@dell>
Subject: Re: [PATCH v6 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Lee,

> Lee Jones <lee.jones@linaro.org> hat am 28. September 2016 um 03:05
> geschrieben:
>=20
>=20
> On Sat, 17 Sep 2016, Ksenija Stanojevic wrote:
>=20
> > +
> > +static int mxs_lradc_probe(struct platform_device *pdev)
> > +{
> > +=09const struct of_device_id *of_id;
> > +=09struct device *dev =3D &pdev->dev;
> > +=09struct device_node *node =3D dev->of_node;
> > +=09struct mxs_lradc *lradc;
> > +=09struct mfd_cell *cells =3D NULL;
> > +=09int ret =3D 0;
> > +=09u32 ts_wires =3D 0;
> > +
> > +=09lradc =3D devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > +=09if (!lradc)
> > +=09=09return -ENOMEM;
> > +
> > +=09of_id =3D of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > +=09lradc->soc =3D (enum mxs_lradc_id)of_id->data;
> > +
> > +=09lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +=09if (IS_ERR(lradc->clk)) {
> > +=09=09dev_err(dev, "Failed to get the delay unit clock\n");
> > +=09=09return PTR_ERR(lradc->clk);
> > +=09}
> > +
> > +=09ret =3D clk_prepare_enable(lradc->clk);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to enable the delay unit clock\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>=20
> Have you moved the documentation into devicetree/bindings/mfd?
>=20

i hope it's okay if i answer. The binding has moved to
devicetree/binding/iio/adc/ [1]

Should it move completely to mfd or split too?

I'm asking myself how we keep DT ABI in the latter case.

[1] -
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/=
adc/mxs-lradc.txt

>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
