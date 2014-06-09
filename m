Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 9 Jun 2014 22:04:18 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/12] staging:iio-trig-periodic-rtc: Cleanup
In-Reply-To: <539612EB.2080000@kernel.org>
Message-ID: <alpine.DEB.2.01.1406092203120.17148@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net> <1402155772-1373-12-git-send-email-pmeerw@pmeerw.net> <539612EB.2080000@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> > Fix extra space in module description
> > Silence output about trigger frequency when trigger gets enabled/disabled
> > Add dash to make trigger name look nicer (periodicrtc0 -> periodic-rtc0)
> All good bar the last one.  That's an ABI change unfortunately.
> Whilst I agree the - would have been nice we are stuck with it for now.
> (of course I'm aiming to drop this driver fairly soon anyway which I
> guess is a rather larger ABI change, but lets be tidy until then!)

what's going to happen with periodic-rtc?
I noticed that the proposed hrtimer trigger hasn't been merged yet?

regards, p.

> > diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > index 38ecb4b..7283e50 100644
> > --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> > @@ -33,7 +33,7 @@ static int iio_trig_periodic_rtc_set_state(struct
> > iio_trigger *trig, bool state)
> >   	struct iio_prtc_trigger_info *trig_info =
> > iio_trigger_get_drvdata(trig);
> >   	if (trig_info->frequency == 0)
> >   		return -EINVAL;
> > -	dev_info(&trig_info->rtc->dev, "trigger frequency is %d\n",
> > +	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %d\n",
> >   			trig_info->frequency);
> >   	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
> >   }
> > @@ -113,7 +113,7 @@ static int iio_trig_periodic_rtc_probe(struct
> > platform_device *dev)
> >   	for (i = 0;; i++) {
> >   		if (pdata[i] == NULL)
> >   			break;
> > -		trig = iio_trigger_alloc("periodic%s", pdata[i]);
> > +		trig = iio_trigger_alloc("periodic-%s", pdata[i]);
> >   		if (!trig) {
> >   			ret = -ENOMEM;
> >   			goto error_free_completed_registrations;
> > @@ -128,8 +128,7 @@ static int iio_trig_periodic_rtc_probe(struct
> > platform_device *dev)
> >   		iio_trigger_set_drvdata(trig, trig_info);
> >   		trig->ops = &iio_prtc_trigger_ops;
> >   		/* RTC access */
> > -		trig_info->rtc
> > -			= rtc_class_open(pdata[i]);
> > +		trig_info->rtc = rtc_class_open(pdata[i]);
> >   		if (trig_info->rtc == NULL) {
> >   			ret = -EINVAL;
> >   			goto error_free_trig_info;
> > @@ -199,5 +198,5 @@ static struct platform_driver
> > iio_trig_periodic_rtc_driver = {
> >   module_platform_driver(iio_trig_periodic_rtc_driver);
> > 
> >   MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> > -MODULE_DESCRIPTION("Periodic realtime clock  trigger for the iio
> > subsystem");
> > +MODULE_DESCRIPTION("Periodic realtime clock trigger for the iio
> > subsystem");
> >   MODULE_LICENSE("GPL v2");
> > 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
