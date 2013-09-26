Return-Path: <zubair.lutfullah@gmail.com>
Date: Thu, 26 Sep 2013 13:09:57 +0500
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] iio: ti_am335x_adc: fix static in function header
Message-ID: <20130926080955.GA3985@gmail.com>
References: <1379838005-15158-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379838005-15158-2-git-send-email-zubair.lutfullah@gmail.com>
 <523F3109.8000600@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <523F3109.8000600@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 22, 2013 at 07:03:53PM +0100, Jonathan Cameron wrote:
> On 09/22/13 09:20, Zubair Lutfullah wrote:
> > Static is missing in function header. Corrected.
> > 
> > Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
> Applied to the togreg branch of iio.git
> 
> As you've probably gathered, a run of sparse on your code before posting is a
> great way to pick up on little things like this.  Also, coccinelle and
> smatch if you want to do a thorough job - each gets a slightly different
> set of common bugs.  I tend to run some combination of those, but wasn't
> set up to build this driver so didn't pick up on this.

Thank-you. I'll look into it. Are these scripts within the scripts/ directory?
Zubair

> 
> Another one clocked up to the autobuilders.  Note it is normal to give
> a reported-by line to give them some credit. I've added one.

Noted
 
> Jonathan
> > ---
> >  drivers/iio/adc/ti_am335x_adc.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> > index 5287bff..91dce1f 100644
> > --- a/drivers/iio/adc/ti_am335x_adc.c
> > +++ b/drivers/iio/adc/ti_am335x_adc.c
> > @@ -226,7 +226,7 @@ static const struct iio_buffer_setup_ops tiadc_buffer_setup_ops = {
> >  	.postdisable = &tiadc_buffer_postdisable,
> >  };
> >  
> > -int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
> > +static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
> >  	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> >  	irqreturn_t (*pollfunc_th)(int irq, void *p),
> >  	int irq,
> > 
