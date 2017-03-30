Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:56272 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933002AbdC3Ni4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Mar 2017 09:38:56 -0400
Date: Thu, 30 Mar 2017 15:38:53 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: jacopo <jacopo@jmondi.org>
cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: replace comma with a semicolon
In-Reply-To: <20170330133046.GA7900@w540>
Message-ID: <alpine.DEB.2.20.1703301534380.24907@vps.pmeerw.net>
References: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook> <20170330133046.GA7900@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:
> > Replace a comma between expression statements by a semicolon. This
> > changes the semantics of the code, but given the current indentation
> > appears to be what is intended.

> You can simply say that this fixes what appears to be a bug to me.
> I wonder how this does even compile..

it's valid C and I think it does the correct thing (i.e. assign those 
variables); the style is weird obviously

> [1] https://marc.info/?l=linux-iio&m=148475728729617&w=2
> 
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  drivers/iio/adc/max11100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> > index 23c060e1b663..1180bcc22ff1 100644
> > --- a/drivers/iio/adc/max11100.c
> > +++ b/drivers/iio/adc/max11100.c
> > @@ -124,8 +124,8 @@ static int max11100_probe(struct spi_device *spi)
> >  	indio_dev->name = "max11100";
> >  	indio_dev->info = &max11100_info;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > -	indio_dev->channels = max11100_channels,
> > -	indio_dev->num_channels = ARRAY_SIZE(max11100_channels),
> > +	indio_dev->channels = max11100_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max11100_channels);
> >  
> >  	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
> >  	if (IS_ERR(state->vref_reg))
> > -- 
> > 2.11.0
> > 
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
