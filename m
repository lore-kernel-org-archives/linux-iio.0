Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbeKCT4K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 15:56:10 -0400
Date: Sat, 3 Nov 2018 10:45:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181103104511.42d96448@archlinux>
In-Reply-To: <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-3-matheus.bernardino@usp.br>
        <20181028164329.57162e06@archlinux>
        <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2 Nov 2018 10:59:06 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> On 10/28/18 1:43 PM, Jonathan Cameron wrote:
> > On Fri, 26 Oct 2018 23:00:01 -0300
> > Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >  
> >> Previously, ad2s90_probe ignored the return code from spi_setup, not
> >> handling its possible failure. This patch makes ad2s90_probe check if
> >> the code is an error code and, if so, do the following:
> >>
> >> - Call dev_err with an appropriate error message.
> >> - Return the spi_setup's error code, aborting the execution of the
> >> rest of the function.
> >>
> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> >> ---
> >>   drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> >> index 11fac9f90148..d6a42e3f1bd8 100644
> >> --- a/drivers/staging/iio/resolver/ad2s90.c
> >> +++ b/drivers/staging/iio/resolver/ad2s90.c
> >> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
> >>   	/* need 600ns between CS and the first falling edge of SCLK */
> >>   	spi->max_speed_hz = 830000;
> >>   	spi->mode = SPI_MODE_3;
> >> -	spi_setup(spi);
> >> +	ret = spi_setup(spi);
> >> +
> >> +	if (ret < 0) {
> >> +		dev_err(&spi->dev, "spi_setup failed!\n");
> >> +		return ret;
> >> +	}  
> > I would have reordered this first to be before the iio_device_register call.
> > The reason being that it would avoid this comment.
> >
> > Drop the return ret out of the block above and return ret unconditionally.
> >
> > I don't mind too much as I know this is moving later, but I only know that
> > because of the earlier discussion ;)  Few reviewers read the whole patch
> > set before responding to the early patches - it's just too much like hard
> > work.  So if you can do things in an order that minimizes standard responses
> > then that's great.
> >
> > Patch is fine though - could be solved by a comment in the intro that
> > says the code in question will move in patch X.  
> 
> 
> Ok! As a newcomer I'm not sure about the right way to add this comment. 
> Should I add it to the patch message or after the --- ? Also, how do I 
> reference patch X? Just giving the number of the patch in this series?
For this sort of comment I would put it in the main description. It wants
to go in the git log for anyone who is looking at this patch in isolation
sometime in the future.

The stuff below the --- is usually version change things and other stuff
we don't want in the log.

> 
> An alternative to adding the comment would be to drop the return ret, 
> and reinsert it in the next patch. Dosen't seem so good, to me, but 
> would avoid the problem you presented. What would be better?

Comment would be nicer for this one I think rather than the noise in the
actual code. Both would be acceptable though so which ever you
prefer.

Jonathan

> 
> 
> Matheus.
> 
> 
> >
> > Jonathan  
> >>   
> >>   	return 0;
> >>   }  
