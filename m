Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36819 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbaFDIfg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 4 Jun 2014 04:35:36 -0400
Date: Wed, 4 Jun 2014 10:35:35 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 15/15] iio:adc:ad799x: Allow to write event config
In-Reply-To: <538ED0DB.906@metafoo.de>
Message-ID: <alpine.DEB.2.01.1406041013310.12546@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-16-git-send-email-pmeerw@pmeerw.net> <538ED0DB.906@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Lars-Peter,

thank you for reviewing this series! reply below

> > previously, events were always reported as enabled, but actually only
> > implicitly enabled when updating the buffer scan mode
> > 
> > Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> > ---
> >   drivers/iio/adc/ad799x.c | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index b8191f1..f8bfbcb 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -375,6 +375,39 @@ static int ad799x_read_event_config(struct iio_dev
> > *indio_dev,
> >   	return 0;
> >   }
> > 
> > +static int ad799x_write_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir,
> > +				     int state)
> > +{
> > +	struct ad799x_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +	if (iio_buffer_enabled(indio_dev)) {
> > +		ret = -EBUSY;
> > +		goto done;
> > +	}
> > +
> > +	if (state)
> > +		st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
> > +	else
> > +		st->config &= ~(BIT(chan->scan_index) <<
> > AD799X_CHANNEL_SHIFT);
> > +
> > +	if (st->config >> AD799X_CHANNEL_SHIFT)
> > +		st->config |= AD7998_ALERT_EN;
> > +	else
> > +		st->config &= ~AD7998_ALERT_EN;
> > +
> > +	ret = ad799x_write_config(st, st->config);
> 
> If I understand this correctly the enabled channels will be overwritten again
> as soon as the scan mode is updated. I think that is a bit unexpected. I'm not
> quite sure how to implement being able to independently enable a channel for
> sampling and for event monitoring in a proper way though.

yes, this is a problem; I have no good solution
at least the enabled events show their correct status now :)

one could turn on the union set of event and scan mode channels and ignore
events or measurement when not in the event or or scan mode set, resp.

sysfs-bus-iio documentation says 
"So if you want to be sure you have set what you think you have, check the 
contents of these attributes after everything is configured. Drivers 
may have to buffer any parameters so that they are consistent 
when a given event type is enabled at a future point (and not 
those for whatever event was previously enabled)."

so there already is a warning :)


another question:
is an event supposed to occur on crossing the threshold or whenever and 
as long as the ADC value exceeds the threshold?

the ad7997 does the later, the documentation is not very clear what is 
to be expected

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
