Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36096 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbbHCXKY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 19:10:24 -0400
Received: by ioeg141 with SMTP id g141so425675ioe.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2015 16:10:24 -0700 (PDT)
Date: Mon, 3 Aug 2015 19:10:19 -0400
From: Matt Porter <mporter@konsulko.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
Message-ID: <20150803231019.GJ15004@beef>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <CAKzfze9EcW0=yRGq=JBim7P8kQ4q+UgOd00qm=zA6oLz+Ut4DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKzfze9EcW0=yRGq=JBim7P8kQ4q+UgOd00qm=zA6oLz+Ut4DQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 03, 2015 at 03:39:00PM -0700, Matt Ranostay Matt Ranostay wrote:
> On Mon, Aug 3, 2015 at 1:56 PM, Matt Porter <mporter@konsulko.com> wrote:

...

> > +static int max6675_probe(struct spi_device *spi)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct max6675_state *st;
> > +       int ret = 0;
> > +
> > +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st = iio_priv(indio_dev);
> > +       st->spi = spi;
> > +
> > +       spi->mode = SPI_MODE_1;
> > +       spi->bits_per_word = 16;
> 
> Have this error or display a warning when it doesn't match the passed
> DT binding settings. Otherwise it may get confusing why other SPI
> modes and word sizes don't work.

Ok, good point. The only thing here is that I've specified that spi-cpha
is required in the binding, indicating that Mode 1 will be used. I need
this driver to be instantiated via three methods: ACPI, DT, and "board
file" so for the latter I'm hardcoding in the driver the mode. The
device only works in Mode 1 so this seems sane, it's not configurable.
I don't parse that mode from either DT or ACPI data since it's not
needed. About the only thing I could do is pedantically check for
spi-cpha and if not present complain..but I think it's fine to simply
not parse at all given that we've hardcoded this for the allowed mode.

There's no property for bits_per_word, it's configured on a per-transfer
basis. In this case, this configures the default to do a 16-bit transfer
as required by the device. There is no way to modify this by a client of
this driver.

-Matt
