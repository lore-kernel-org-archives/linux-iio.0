Return-Path: <zubair.lutfullah@gmail.com>
Date: Fri, 20 Dec 2013 08:36:35 +0500
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah:  zubair.lutfullah@gmail.com,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mfd: input: iio: ti_amm335x: Rework TSC/ADC
 synchronization
Message-ID: <20131220033634.GB2596@gmail.com>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-6-git-send-email-bigeasy@linutronix.de>
 <20131219190126.GA5123@gmail.com>
 <52B3FC6C.1070105@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52B3FC6C.1070105@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 20, 2013 at 09:14:36AM +0100, Sebastian Andrzej Siewior wrote:
> On 12/19/2013 08:01 PM, Zubair Lutfullah : wrote:
> >> The continues-read mode remains unchanged.
> > 
> > For one-shot reading from ADC, the TSC is 'disabled' for that moment.
> > Ok. But for continuous mode, reading from ADC disables TSC for that long time?
> 
> No, the continuous mode remains unchanged. That means while you
> enable/disable the continuous mode the TSC isn't halted / stopped and
> so TSC remains functional the whole time.

I see

> 
> > If it doesn't disable the TSC, does that mean that this fix would
> > correct the one-shot read. But the continuous mode is still prone to the 
> > FSM hanging up?
> 
> This is correct. I didn't get around to look closer at the continuous
> mode. Ideally we would also disable it and add the ADC steps to the TSC
> steps. Then I am not sure what happens (or should happen) after the
> TSC event. We don't have much options except adding the TSC back to it.
> But as I said, I didn't have much time to investigate that.
> I believe the crucial part is when we update the SE register while the
> HW is in progress and this leads to the lockup.

Indeed, due to the separation of TSC/ADC drivers, getting
them both to work simultaneously without fault is tricky.

I'll try and set up my work-bench and test this over the weekend.

> >> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> > ...
> >> @@ -329,34 +347,43 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
> >>  	unsigned int fifo1count, read, stepid;
> >>  	bool found = false;
> >>  	u32 step_en;
> >> -	unsigned long timeout = jiffies + usecs_to_jiffies
> >> -				(IDLE_TIMEOUT * adc_dev->channels);
> >> +	unsigned long timeout;
> >>  
> >>  	if (iio_buffer_enabled(indio_dev))
> >>  		return -EBUSY;
> >>  
> >> -	step_en = get_adc_step_mask(adc_dev);
> >> +	step_en = get_adc_chan_step_mask(adc_dev, chan);
> >> +	if (!step_en)
> >> +		return -EINVAL;
> >> +
> >> +	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
> >> +	while (fifo1count--)
> >> +		tiadc_readl(adc_dev, REG_FIFO1);
> >> +
> > Would this flush be needed ideally?
> 
> Ideally, no. Ideally (and this is what happens during my testing) is
> that the FIFO was empty and so fifo1count is 0. No reads from the FIFO.
> 
> In the unlikely event that we timed out later there might be something
> in the FIFO (but shouldn't since we gave it enough time to fill it). So
> for that case we purge it because in the loop later we wait for one
> item in the FIFO which would be true immediately.
> 

Ok.


Thanks
Zubair
