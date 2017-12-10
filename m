Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdLJQhs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 11:37:48 -0500
Date: Sun, 10 Dec 2017 16:37:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-iio@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 1/8] iio: adc: axp20x_adc: put ADC rate
 setting in a per-variant function
Message-ID: <20171210163741.3a8ed5aa@archlinux>
In-Reply-To: <CAGb2v64er1xMXCFDfNKqGjGN-TysQyjK+vfHdx0t+kaCchQfCg@mail.gmail.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <e97d7332790facf3d10a58feabbfe7b2c0b90db7.1512396054.git-series.quentin.schulz@free-electrons.com>
        <CAGb2v64er1xMXCFDfNKqGjGN-TysQyjK+vfHdx0t+kaCchQfCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 5 Dec 2017 11:35:49 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Mon, Dec 4, 2017 at 10:12 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > To prepare for a new comer that set a different register with different
> > values, move rate setting in a function that is specific to each AXP
> > variant.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index a30a972..7274f4f 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -470,14 +470,18 @@ static const struct iio_info axp22x_adc_iio_info = {
> >         .read_raw = axp22x_read_raw,
> >  };
> >
> > -static int axp20x_adc_rate(int rate)
> > +static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
> >  {
> > -       return AXP20X_ADC_RATE_HZ(rate);
> > +       return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > +                                 AXP20X_ADC_RATE_MASK,
> > +                                 AXP20X_ADC_RATE_HZ(rate));
> >  }
> >
> > -static int axp22x_adc_rate(int rate)
> > +static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
> >  {
> > -       return AXP22X_ADC_RATE_HZ(rate);
> > +       return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > +                                 AXP20X_ADC_RATE_MASK,
> > +                                 AXP22X_ADC_RATE_HZ(rate));
> >  }
> >
> >  struct axp_data {
> > @@ -485,7 +489,7 @@ struct axp_data {
> >         int                             num_channels;
> >         struct iio_chan_spec const      *channels;
> >         unsigned long                   adc_en1_mask;
> > -       int                             (*adc_rate)(int rate);
> > +       int                             (*adc_rate)(struct axp20x_adc_iio *info, int rate);  
> 
> Could you also change the name of the callback, to say, adc_set_rate?
> This would make it much clearer what the callback does. Previously
> it was just a conversion helper.
> 
Agreed.

With that change you can add my
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ChenYu
> 
> >         bool                            adc_en2;
> >         struct iio_map                  *maps;
> >  };
> > @@ -554,8 +558,7 @@ static int axp20x_probe(struct platform_device *pdev)
> >                                    AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> >
> >         /* Configure ADCs rate */
> > -       regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
> > -                          info->data->adc_rate(100));
> > +       info->data->adc_rate(info, 100);
> >
> >         ret = iio_map_array_register(indio_dev, info->data->maps);
> >         if (ret < 0) {
> > --
> > git-series 0.9.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

