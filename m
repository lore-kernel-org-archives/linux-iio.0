Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKW0g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:26:36 -0500
Date: Sun, 11 Nov 2018 12:38:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181111123802.212a8b79@archlinux>
In-Reply-To: <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
        <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 08:11:57 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2018-11-09 at 13:08 +0530, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID.  
> 
> One comment inline for this.
> 
> Thanks
> Alex
> 
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index a2fead85cd46..b8a9149fbac1 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -422,6 +422,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad7816_of_match[] = {
> > +	{ .compatible = "adi,ad7816", },  
> 
> I think you also need to add:
> +	{ .compatible = "adi,ad7817", },
> +	{ .compatible = "adi,ad7818", },
> 

Yes, please add all parts to the dt binding.
Particularly as they are functionally different in this case!

Please send a v4 for just this patch as the rest have now been
applied.

Thanks,


Jonathan

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > +
> >  static const struct spi_device_id ad7816_id[] = {
> >  	{ "ad7816", ID_AD7816 },
> >  	{ "ad7817", ID_AD7817 },
> > @@ -434,6 +440,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> >  static struct spi_driver ad7816_driver = {
> >  	.driver = {
> >  		.name = "ad7816",
> > +		.of_match_table = of_match_ptr(ad7816_of_match),
> >  	},
> >  	.probe = ad7816_probe,
> >  	.id_table = ad7816_id,  
