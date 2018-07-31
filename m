Return-Path: <SRS0=oVyo=KP=gmail.com=himanshujha199640@kernel.org>
Date: Tue, 31 Jul 2018 15:34:09 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
	matt.ranostay@konsulko.com
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180731100409.GA3667@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
 <20180730140746.0000337a@huawei.com>
 <20180730175341.GA27304@himanshu-Vostro-3559>
 <20180730192511.75b6f0b2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730192511.75b6f0b2@archlinux>
List-ID: <linux-iio@vger.kernel.org>

> > Ah, I also had attributes to supply oversampling ratio for temp,
> > press & humid channels from userspace. So, does that make it an output
> > channel ? Forcing ?
> 
> I'm not sure I see the connection to oversampling ratio etc. Those
> are about measurement, this one is about outputting heat (hence 
> output).  The fact it is internal to the sensor, doesn't effect this.

I get it!

> > Hmm. For heater duration we are supplying time(ms)
> > And out_current_heater_raw is definitely not valid here.
> > Still unsure about the channel type and the corresponding
> > sysfs entry.
> 
> Indeed not for the time.  The target temperature is fair enough as a channel.
> Ideally I'd like to get rid of the time as there is no real way for userspace
> to 'guess' it right.  Just set it big enough that it is always fine perhaps?

That's what "default values" are -- supplied at probe!
The defaults are suggested by Bosch, so that is indeed best combination
I guess.

> > Will forward the email after their permission as the background
> > watermark text in the formula image says "Confidential!!"
> > Sometimes you need to be careful ;)
> 
> Sure.  Check that first!

"Thank you for your question.

No, unfortunately you cannot share that information. Generally we only deliver BSEC library package.

Only NDA customer could be shared with such information."
	--- reply from Bosch

So, I cannot share the info and it wasn't what we need.
Instead it was about calculating IAQ index from the raw values that
we get from the sensor.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
