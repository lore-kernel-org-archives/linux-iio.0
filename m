Return-Path: <briannorris@chromium.org>
Date: Thu, 4 Aug 2016 17:41:14 +0800
From: Brian Norris <briannorris@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brian Norris <computersforpeace@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
Message-ID: <20160804094113.GA25537@localhost>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost>
 <489632a0-9aaf-e63b-4b08-0fa724a06e28@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <489632a0-9aaf-e63b-4b08-0fa724a06e28@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Aug 04, 2016 at 10:45:39AM +0200, Lars-Peter Clausen wrote:
> > @@ -132,10 +133,13 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> >  		to_wait = min_t(size_t, n / datum_size, rb->watermark);
> >  
> >  	do {
> > -		ret = wait_event_interruptible(rb->pollq,
> > -		      iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size));
> > -		if (ret)
> > -			return ret;
> > +		add_wait_queue(&rb->pollq, &wait);
> > +		while (!iio_buffer_ready(indio_dev, rb, to_wait,
> > +					 n / datum_size)) {
> > +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> > +				   MAX_SCHEDULE_TIMEOUT);
> 
> We loose the ability to break out from this loop by sending a signal to the
> task. This needs something like
> 
> 	if (signal_pending(current)) {
> 		ret = -ERESTARTSYS;
> 		break;
> 	}
> 
> before the wait_woken()

Sounds good.

> And as a minor improvement I'd also move the
> add_wait_queue()/remove_wait_queue() outside of the outer loop.

Sure.

> And then
> just if (!iio_buffer_ready(...)) continue; rather than having the inner
> loop. This should slightly simplify the flow.

Perhaps I'm not gathering your meaning here, but wouldn't that turn this
into a spin loop, waiting for iio_buffer_ready()? i.e.:

	do {
		if (!iio_buffer_ready(...))
			continue; // we shouldn't just hammer
				  // iio_buffer_ready(), should we?

		wait_woken(...);
		...
	};

> Just make sure to replace the
> returns in the loop with a break so remove_wait_queue() has a chance to run.
> 
> 
> > +		}
> > +		remove_wait_queue(&rb->pollq, &wait);
> >  
> >  		if (!indio_dev->info)
> >  			return -ENODEV;
> > 
> 

Brian
