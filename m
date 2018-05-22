Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36824 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeEVRRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 May 2018 13:17:00 -0400
Date: Tue, 22 May 2018 18:16:56 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
Subject: Re: [PATCH] iio: amplifiers: ad8366: move channel init before
 iio_device_register()
Message-ID: <20180522181656.3ab9f7c4@archlinux>
In-Reply-To: <3522029f-ab8d-b368-6f7e-ee33cb6ed999@metafoo.de>
References: <20180521064005.17637-1-alexandru.ardelean@analog.com>
        <3522029f-ab8d-b368-6f7e-ee33cb6ed999@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 21 May 2018 17:10:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Patch looks good, but remember to put the maintainer and reviewers on the
> recipient list. Otherwise there is a risk that the patch gets lost.
> 
> On 05/21/2018 08:40 AM, Alexandru Ardelean wrote:
> > Otherwise a race condition can occur, where userspace can start operations
> > before the channels have been properly initialized.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> > ---
> >  drivers/iio/amplifiers/ad8366.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> > index 43667866321e..0138337aedd1 100644
> > --- a/drivers/iio/amplifiers/ad8366.c
> > +++ b/drivers/iio/amplifiers/ad8366.c
> > @@ -161,12 +161,14 @@ static int ad8366_probe(struct spi_device *spi)
> >  	indio_dev->channels = ad8366_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
> >  
> > +	ret = ad8366_write(indio_dev, 0 , 0);
> > +	if (ret < 0)
> > +		goto error_disable_reg;
> > +
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> >  		goto error_disable_reg;
> >  
> > -	ad8366_write(indio_dev, 0, 0);
> > -
> >  	return 0;
> >  
> >  error_disable_reg:
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

