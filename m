Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37384 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeANKx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jan 2018 05:53:57 -0500
Date: Sun, 14 Jan 2018 10:53:54 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support
 to driver
Message-ID: <20180114105354.7d4e71e6@archlinux>
In-Reply-To: <E2AE62E8D995114A80E27C874A28DB3C97C501@NWD2MBX7.ad.analog.com>
References: <20180105152133.9681-1-alexandru.ardelean@analog.com>
        <20180106125828.5da228f7@archlinux>
        <E2AE62E8D995114A80E27C874A28DB3C97C501@NWD2MBX7.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 8 Jan 2018 07:51:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> ________________________________________
> From: Jonathan Cameron [jic23@jic23.retrosnub.co.uk]
> Sent: Saturday, January 06, 2018 2:58 PM
> To: Ardelean, Alexandru
> Cc: linux-iio@vger.kernel.org
> Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support to driver
> 
> On Fri, 5 Jan 2018 17:21:32 +0200
> <alexandru.ardelean@analog.com> wrote:
> 
> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >  
> Say what the patch does before going into details of why
> you have done it the way you have.
> 
> Ack
One more thing, if you can find an email client (or configure current one)
to keep to indenting quotes with >

Makes it easier to tell what you wrote!

Jonathan
> 
> > Admittedly, this will always use up to
> > sizeof(struct ad7192_platform_data) bytes (~12 bytes at most)
> > on the stack, during the probing of the device.  
> 
> >
> > But this will maintain most of the other
> > init code unchanged.
> >  
> 
> I'm hopeful that you are going to also do any remaining work necessary
> to get this out of staging once and for all?
> 
> Yep.
> Once I get the gist of sending patches to the kernel.
> So far, I've only sent to other smaller projects ; I'll make an effort to learn the rules here.
> 
> Anyhow, comments inline.
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index cadfb96734ed..fca988330588 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -610,18 +610,41 @@ static const struct iio_chan_spec ad7193_channels[] = {
> >       IIO_CHAN_SOFT_TIMESTAMP(14),
> >  };
> >
> > +static void ad7192_parse_dt(struct device_node *np,
> > +                         struct ad7192_platform_data *pdata)
> > +{
> > +     of_property_read_u16(np, "adi,reference-voltage-mv", &pdata->vref_mv);
> > +     of_property_read_u8(np, "adi,clock-source-select", &pdata->clock_source_sel);
> > +     of_property_read_u32(np, "adi,external-clock-Hz", &pdata->ext_clk_hz);
> > +     pdata->refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
> > +     pdata->rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
> > +     pdata->sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
> > +     pdata->chop_en = of_property_read_bool(np, "adi,chop-enable");
> > +     pdata->buf_en = of_property_read_bool(np, "adi,buffer-enable");
> > +     pdata->unipolar_en = of_property_read_bool(np, "adi,unipolar-enable");
> > +     pdata->burnout_curr_en = of_property_read_bool(np, "adi,burnout-currents-enable");  
> 
> Error checking?  No particular reason a devicetree must be right and have all of
> these.
> 
> Ack.
> 
> > +}
> > +
> >  static int ad7192_probe(struct spi_device *spi)
> >  {
> >       const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
> > +     const struct device_node *of_node = dev_of_node(&spi->dev);
> > +     struct ad7192_platform_data lpdata;
> >       struct ad7192_state *st;
> >       struct iio_dev *indio_dev;
> >       int ret, voltage_uv = 0;
> >
> > -     if (!pdata) {
> > -             dev_err(&spi->dev, "no platform data?\n");
> > +     if (!pdata && !of_node) {
> > +             dev_err(&spi->dev, "no platform data or device tree configuration?\n");
> >               return -ENODEV;
> >       }
> >
> > +     if (!pdata) {
> > +             memset(&lpdata, 0, sizeof(lpdata));
> > +             pdata = &lpdata;
> > +             ad7192_parse_dt(of_node, pdata);
> > +     }
> > +
> >       if (!spi->irq) {
> >               dev_err(&spi->dev, "no IRQ?\n");
> >               return -ENODEV;  
> 
> 

