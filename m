Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeKCWSn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 18:18:43 -0400
Date: Sat, 3 Nov 2018 13:07:21 +0000
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
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <20181103130721.53a806a5@archlinux>
In-Reply-To: <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
        <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 1 Nov 2018 15:02:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> Good catch.
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
On the basis this has been broken for a long time, and you are clearly
doing other nearby not fix work, I'm going to take this through the togreg
tree rather than via the quicker fix path.  It makes my life
easier :)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
> > This was fixed by assigning the correct value instead.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7780.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index b67412db0318..91e016d534ed 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -96,7 +96,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:
> > -		*val -= (1 << (chan->scan_type.realbits - 1));
> > +		*val = -(1 << (chan->scan_type.realbits - 1));
> >  		return IIO_VAL_INT;
> >  	}
> >    
