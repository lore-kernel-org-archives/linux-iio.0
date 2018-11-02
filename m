Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:60949 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeKBSkW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Nov 2018 14:40:22 -0400
Date: Fri, 2 Nov 2018 09:33:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
CC: <jic23@kernel.org>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        <linux-iio@vger.kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] iio:temperature: Add MAX31856 thermocouple
 support
Message-ID: <20181102093335.000042d9@huawei.com>
In-Reply-To: <CAGSBOwZ-KfbGDrOHZqDd6piXJOCG2zdwjJ5naCrTBKvXtS_mgQ@mail.gmail.com>
References: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
        <20181013145143.16530539@archlinux>
        <CAGSBOwZ-KfbGDrOHZqDd6piXJOCG2zdwjJ5naCrTBKvXtS_mgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just the one outstanding discussion I think so I've heavily cropped the email..

On Tue, 16 Oct 2018 10:28:40 -0500
Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com> wrote:

> > > +static int max31856_probe(struct spi_device *spi)
> > > +{
> > > +     const struct spi_device_id *id = spi_get_device_id(spi);
> > > +     struct iio_dev *indio_dev;
> > > +     struct max31856_data *data;
> > > +     int ret;
> > > +
> > > +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     data = iio_priv(indio_dev);
> > > +     data->spi = spi;
> > > +
> > > +     spi_set_drvdata(spi, indio_dev);
> > > +
> > > +     indio_dev->info = &max31856_info;
> > > +     indio_dev->name = id->name;
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +     indio_dev->channels = max31856_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
> > > +
> > > +     data->one_shot = of_property_read_bool(spi->dev.of_node, "one-shot");  
> >
> > This does not look to me like something that should be controlled in devicetree.
> > Normally we'd switch between oneshot and continuous modes based on some sort
> > of rule such as whether we are doing buffered reads vs polled ones, or perhaps
> > switch to oneshot if there hasn't been a reading taken for a 'while'.
> > (a form of runtime power management).
> >  
>    I am totally agree with your runtime power management concern but
> as of now, current
>    driver does not have support for runtime coversion mode change.

So to make this clear as we are going in circles, what I am saying is that
until you implement some dynamic control you need to make a decision on
which mode to support and only support one of them.

We do not want this property in the devicetree bindings at all as we will
then have to work with it forever and it is control that does not belong
there.  It is not a function of the board design, it is a policy decision.

> > > +
> > > +     ret = of_property_read_u32(spi->dev.of_node, "type",
> > > +                                &data->thermocouple_type);
> > > +
> > > +     if (ret) {
> > > +             pr_info("Could not read thermocouple type DT property, Configuring as a K-Type\n");
> > > +             data->thermocouple_type = 0x03; /* K-Type */
> > > +     }
> > > +
> > > +     ret = max31856_init(data);
> > > +     if (ret) {
> > > +             pr_err("error: Failed to configure max31856\n");
> > > +             return ret;
> > > +     }
> > > +
