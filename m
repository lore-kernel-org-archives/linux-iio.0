Return-Path: <mirqus@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201301212232.52161.marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
 <201301212200.36917.marex@denx.de> <CAHXqBFKzMgX48EJL_f6RF1tZYkdPLCZhip7M9jNuFkY+wjeQqA@mail.gmail.com>
 <201301212232.52161.marex@denx.de>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Mon, 21 Jan 2013 22:48:36 +0100
Message-ID: <CAHXqBFJ5=P2OHez74gK-DBT+3O=KHoHjffxRAe2u-9ppXOmExA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2013/1/21 Marek Vasut <marex@denx.de>:
> Dear Micha=C5=82 Miros=C5=82aw,
>> 2013/1/21 Marek Vasut <marex@denx.de>:
>> > Dear Micha=C5=82 Miros=C5=82aw,
>> >> 2013/1/21 Marek Vasut <marex@denx.de>:
>> >> > This patch adds support for i.MX23 into the LRADC driver. The LRADC
>> >> > block on MX23 is not much different from the one on MX28, thus this
>> >> > is only a few changes fixing the parts that are specific to MX23.
>> >>
>> >> [...]
>> >>
>> >> > +struct mxs_lradc_of_config {
>> >> > +       const int               irq_count;
>> >> > +       const char * const      *irq_name;
>> >> > +};
>> >> > +
>> >> > +static const struct mxs_lradc_of_config const mxs_lradc_of_config[=
] =3D
>> >> > { +       [IMX23_LRADC] =3D {
>> >> > +               .irq_count      =3D ARRAY_SIZE(mx23_lradc_irq_names=
),
>> >> > +               .irq_name       =3D mx23_lradc_irq_names,
>> >> > +       },
>> >> > +       [IMX28_LRADC] =3D {
>> >> > +               .irq_count      =3D ARRAY_SIZE(mx28_lradc_irq_names=
),
>> >> > +               .irq_name       =3D mx28_lradc_irq_names,
>> >> > +       },
>> >> > +};
>> >> > +
>> >> >
>> >> >  enum mxs_lradc_ts {
>> >> >
>> >> >         MXS_LRADC_TOUCHSCREEN_NONE =3D 0,
>> >> >         MXS_LRADC_TOUCHSCREEN_4WIRE,
>> >> >
>> >> > @@ -857,8 +890,19 @@ static void mxs_lradc_hw_stop(struct mxs_lradc
>> >> > *lradc)
>> >> >
>> >> >                 writel(0, lradc->base + LRADC_DELAY(i));
>> >> >
>> >> >  }
>> >> >
>> >> > +static const struct of_device_id mxs_lradc_dt_ids[] =3D {
>> >> > +       { .compatible =3D "fsl,imx23-lradc", .data =3D (void
>> >> > *)IMX23_LRADC, }, +       { .compatible =3D "fsl,imx28-lradc", .dat=
a =3D
>> >> > (void
>> >> > *)IMX28_LRADC, }, +       { /* sentinel */ }
>> >> > +};
>> >> > +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
>> >> > +
>> >>
>> >> Why not s/(void \*)\(IMX.._LRADC\)/\&mxs_lradc_of_config[\1]/ ?
>> >
>> > Check the register layout, it differs between MX23 and MX28, that's on=
e
>> > reason, since were we to access differently placed registers, we can d=
o
>> > it easily as in the SSP/I2C drivers.
>> >
>> > Moreover, there are some features on the MX28 that are not on the MX23
>> > (like voltage treshold triggers and touchbuttons), with this setup, we
>> > can easily check what we're running at at runtime and determine to
>> > disallow these.
>> >
>> > From my point of view, using the number (IMX23_LRADC / IMX28_LRADC) is
>> > much more convenient in the long run.
>>
>> I'm asking, because you don't use this number anywhere other than in
>> mxs_lradc_probe()
>> and there only to dereference the irq-names table. After that the
>> structure and number
>> are forgotten.
>
> Certainly, so far it's used only this way. But please see my argument abo=
ut
> register layout, that's why I went down this road of abstraction.

Hmm. Then is IMX23 LRADC going to just work after this series
(assuming I don't use unsupported features) or this needs more patches
to be usable?

Best Regards,
Micha=C5=82 Miros=C5=82aw
