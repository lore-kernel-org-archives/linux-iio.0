Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36970 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFYQFD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 12:05:03 -0400
Date: Sun, 25 Jun 2017 17:05:00 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: gyro: st_gyro_spi: add OF capability to
 st_gyro_spi
Message-ID: <20170625170500.6343b52a@jic23.retrosnub.co.uk>
In-Reply-To: <CAA2SeNKvLKaPysFxEcCSHJuo_W67E9A6qBg-3f1SMazEM=z78g@mail.gmail.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
        <20170620195212.23213-6-lorenzo.bianconi@st.com>
        <20170624214113.012ac5b1@kernel.org>
        <20170624214331.6a41c5b4@jic23.retrosnub.co.uk>
        <CAA2SeNKvLKaPysFxEcCSHJuo_W67E9A6qBg-3f1SMazEM=z78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Jun 2017 10:24:09 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> > On Sat, 24 Jun 2017 21:41:13 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> >> On Tue, 20 Jun 2017 21:52:12 +0200
> >> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> >>  
> >> > Add device tree support for L3GD20H gyroscope sensor
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >> > ---
> >> >  drivers/iio/gyro/st_gyro_spi.c | 16 ++++++++++++++++
> >> >  1 file changed, 16 insertions(+)
> >> >
> >> > diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> >> > index fa14d8f2170d..e49dd2c923ab 100644
> >> > --- a/drivers/iio/gyro/st_gyro_spi.c
> >> > +++ b/drivers/iio/gyro/st_gyro_spi.c
> >> > @@ -18,6 +18,19 @@
> >> >  #include <linux/iio/common/st_sensors_spi.h>
> >> >  #include "st_gyro.h"
> >> >
> >> > +#ifdef CONFIG_OF
> >> > +static const struct of_device_id st_gyro_of_match[] = {
> >> > +   {
> >> > +           .compatible = "st,l3gd20h-gyro",  
> >> Firstly, I think we need to drop the -gyro from any that
> >> aren't effectively multiple chips in the same package.
> >>
> >> Secondly why are we adding only a compatible for one of
> >> the supported parts?  They should all be here I think...  
> > Hohum. Rob acked a patch with the -gyro, presumably because
> > we are now stuck with that in the names.
> >  
> 
> Hi Jonathan,
> 
> I added '-gyro' in compatible string to maintain compatibility with
> i2c counterpart otherwise
> we will have two different compatible string for spi and i2c
> interfaces. I will add a comment to not
> use that convention for newer devices, do you agree?
That works for me.  Not much we can do about the past.
The only possible extension would be to support the 'clean' versions
of existing parts as well as additional compatible entries.
Worth doing to avoid confusion in future?
> Moreover I added just the device where I tested the solution. In v2 I
> will add all supported devices
> since the discovery code is in common with i2c and it is well tested.
> I guess these arguments will apply on accel/magn/pressure counterparts as well.
> 
> Regards,
> Lorenzo
> 
> > Lets keep that, but I do want to see all the supported parts
> > in these lists.  
> >> > +           .data = L3GD20H_GYRO_DEV_NAME,
> >> > +   },
> >> > +   {},
> >> > +};
> >> > +MODULE_DEVICE_TABLE(of, st_gyro_of_match);
> >> > +#else
> >> > +#define st_gyro_of_match   NULL
> >> > +#endif
> >> > +
> >> >  static int st_gyro_spi_probe(struct spi_device *spi)
> >> >  {
> >> >     struct iio_dev *indio_dev;
> >> > @@ -30,6 +43,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
> >> >
> >> >     gdata = iio_priv(indio_dev);
> >> >
> >> > +   st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
> >> > +                            spi->modalias, sizeof(spi->modalias));
> >> >     st_sensors_spi_configure(indio_dev, spi, gdata);
> >> >
> >> >     err = st_gyro_common_probe(indio_dev);
> >> > @@ -63,6 +78,7 @@ MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
> >> >  static struct spi_driver st_gyro_driver = {
> >> >     .driver = {
> >> >             .name = "st-gyro-spi",
> >> > +           .of_match_table = of_match_ptr(st_gyro_of_match),
> >> >     },
> >> >     .probe = st_gyro_spi_probe,
> >> >     .remove = st_gyro_spi_remove,  
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> >  
> 
> 
> 

