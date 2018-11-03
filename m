Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKCWWK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 18:22:10 -0400
Date: Sat, 3 Nov 2018 13:10:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <20181103131047.235ee9cf@archlinux>
In-Reply-To: <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
        <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 1 Nov 2018 15:28:19 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > This patch removes the unnecessary field int_vref_mv in ad7780_state
> > referring to the device's voltage.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed unnecessary int_vref_mv from ad7780_state
> > 
> >  drivers/staging/iio/adc/ad7780.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index f2a11e9424cd..f250370efcf7 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -42,7 +42,6 @@ struct ad7780_state {
> >  	struct regulator		*reg;
> >  	struct gpio_desc		*powerdown_gpio;
> >  	unsigned int	gain;
> > -	u16				int_vref_mv;
> >  
> >  	struct ad_sigma_delta sd;
> >  };
> > @@ -190,9 +189,7 @@ static int ad7780_probe(struct spi_device *spi)
> >  	st->chip_info =
> >  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> >  
> > -	if (voltage_uv)
> > -		st->int_vref_mv = voltage_uv / 1000;
> > -	else
> > +	if (!voltage_uv)
> >  		dev_warn(&spi->dev, "Reference voltage unspecified\n");  
> 
> I think you could remove this altogether, and also remove the entire
> `voltage_uv = regulator_get_voltage(st->reg);` assignment.
> 
> It doesn't make much sense to read the voltage here, since it won't be used
> in the probe part anymore.
> 
Absolutely agree on this. There is no point in reading here at all.

Jonathan
> >  
> >  	spi_set_drvdata(spi, indio_dev);  
