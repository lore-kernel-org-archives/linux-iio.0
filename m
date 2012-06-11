Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 11 Jun 2012 23:35:34 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
In-Reply-To: <4FD635A0.7050507@kernel.org>
Message-ID: <alpine.DEB.2.01.1206112328220.30702@pmeerw.net>
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> > I am lost with the meaning and use of IIO modifiers...
> Quick and dirty summary.
> Calibscale is internally applied within the hardware (or occasionally
> software but looks like it was in the hardware from point of view
> of userspace!)

thank you for clarification

Am I missing documentation somewhere?


some comments in iio/types.h iio/iio.h would avoid guesswork...

enum iio_chan_type {
	/* real channel types */	
are there unreal channels also? :)

what is IIO_ANGL_VEL vs. IIO_ANGL? VOLTAGE vs. ALTVOLTAGE?

what is LIGHT_BOTH?

it would be helpful what IIO_CHAN_INFO_SHARED_BIT vs 
IIO_CHAN_INFO_SEPARATE_BIT relates to?

IIO_CHAN_INFO_SAMP_FREQ vs IIO_CHAN_INFO_FREQUENCY?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
