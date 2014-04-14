Return-Path: <joel@porquet.org>
From: =?ISO-8859-1?Q?Jo=EBl?= Porquet <joel@porquet.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, jg1.han@samsung.com, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: fix coding style
Date: Mon, 14 Apr 2014 15:59:32 +0200
Message-ID: <9773833.iVsvHLKPbr@joel-zenbook>
In-Reply-To: <534977A7.3090100@kernel.org>
References: <1397066985-2504-1-git-send-email-joel@porquet.org> <534977A7.3090100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>



On Saturday, April 12, 2014 06:28:07 PM Jonathan Cameron wrote:
> 
> On 09/04/14 19:09, Joel Porquet wrote:
> > As suggested by checkpatch.pl, use dev_info() instead of
> > printk(KERN_INFO ...) to print message.
> >
> > Signed-off-by: Joel Porquet <joel@porquet.org>
> > ---
> > Only tested by compilation.
> >   drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > index 48a6afa..38ecb4b 100644
> > --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > @@ -33,7 +33,8 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
> >   	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
> >   	if (trig_info->frequency == 0)
> >   		return -EINVAL;
> > -	printk(KERN_INFO "trigger frequency is %d\n", trig_info->frequency);
> > +	dev_info(&trig_info->rtc->dev, "trigger frequency is %d\n",
> > +			trig_info->frequency);
> The principle is good, but why make the error message us the underlying rtc device?
> Going to lead to a rather unhelpful error message.
> 
> Perhaps the iio_trigger structures device element would make more sense?
> Might not be terribly informative, but will at least come from the right
> subsystem.
> 
> Also, I think we will be dropping this driver entirely at some point.
> It was a dodgy hack that perhaps made sense at the time, but now a high
> resolution timer is going to give better results.

OK, thanks for the feedback!

Does that still make sense that I resubmit another patch (using iio_trigger-dev instead)?
Or should I just drop this patch altogether since you seem to say that patching this driver is not really worth it anyway?

> >   	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
> >   }
> >
> >
> 
