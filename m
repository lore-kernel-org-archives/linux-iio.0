Return-Path: <zubair.lutfullah@gmail.com>
Date: Wed, 28 Aug 2013 19:55:19 +0100
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah:  zubair.lutfullah@gmail.com, jic23@cam.ac.uk,
	lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Message-ID: <20130828185518.GE3777@gmail.com>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
 <20130828141835.GD14111@linutronix.de>
 <20130828182249.GB3580@gmail.com>
 <521E43BF.3000504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <521E43BF.3000504@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 28, 2013 at 08:38:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/28/2013 08:22 PM, Zubair Lutfullah : wrote:
> > On Wed, Aug 28, 2013 at 04:18:35PM +0200, Sebastian Andrzej Siewior wrote:
> >> * Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:
> >>
> >>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> >>> index a952538..ae2202b 100644
> >>> --- a/drivers/iio/adc/ti_am335x_adc.c
> >>> +++ b/drivers/iio/adc/ti_am335x_adc.c
> >> …
> >>
> >>> +static struct iio_trigger *tiadc_iio_allocate_trigger(struct iio_dev *indio_dev)
> > ...
> >>> +	trig = iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
> >>> +	if (trig == NULL)
> >>> +		return NULL;
> >>> +
> > ...
> >>> +	ret = iio_trigger_register(trig);
> >>> +	if (ret)
> >>
> >> shouldn't you free the trigger / undo iio_trigger_alloc() here?
> >>
> >>> +		return NULL;
> >>> +
> > ...
> > Possible. It's done in the probe section just 
> > to keep error handling bunched there.
> 
> The caller of iio_trigger *tiadc_iio_allocate_trigger() should not
> cleanup after it in case of a half failure. The function itself should
> be in charge of it. However you never assign the pointer so you leak
> the memory here.
> 
A very valid point indeed.
I'll fix this.
Thanks.
> >>
> >>>
> >>> static const char * const chan_name_ain[] = {
> >>> @@ -220,7 +394,8 @@ static int tiadc_probe(struct platform_device *pdev)
> >>> 					  sizeof(struct tiadc_device));
> >>> 	if (indio_dev == NULL) {
> >>> 		dev_err(&pdev->dev, "failed to allocate iio device\n");
> >>> -		return -ENOMEM;
> >>> +		err = -ENOMEM;
> >>> +		goto err_ret;
> >> Why the jump instead of leave right away?
> >>
> >>> 	}
> > Again. Error handling all in one place.
> 
> But you simply leave at the end of the function, no error handling is
> done / required if you leave here. So this a zero change and has
> nothing to do with the "continuous sampling support" support.
> 
Again. Thanks.

ZubairLK
