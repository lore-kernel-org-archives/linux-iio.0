Return-Path: <matthias.list@kaehlcke.net>
Date: Sun, 15 Sep 2013 19:50:00 +0200
From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felipe Balbi <balbi@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Take touchscreen channels into
 account for conversion timeout
Message-ID: <20130915175000.GA24058@raspi>
References: <f1830a7d0debce351966d2f3232158313d87dcc0.1378846446.git.matthias@kaehlcke.net>
 <20130910210228.GC30481@raspi>
 <5235DD9A.5040700@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5235DD9A.5040700@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

thanks for your comments

El Sun, Sep 15, 2013 at 05:17:30PM +0100 Jonathan Cameron ha dit:

> On 09/10/13 22:02, Matthias Kaehlcke wrote:
> > The calculation of the old conversion timeout value was based on the number of
> > channels used by this driver. This doesn't take into account that other channels
> > can be used by the touchscreen driver. Adjust the timeout value to the maximum
> > if the touchscreen driver is enabled
> > 
> > Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> Hmm... This is a bit of an uggly solution.  Can we do anything neater via some
> callbacks in the underlying mfd?

i agree, it isn't a very elegant solution. as it's a max timeout which
should never be hit i thought it might be good enough. using a
callback in the mfd is feasible, the mfd has information about the
number of steps used by the touchscreen driver. i'll send a reworked
version soon

thanks

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

             "The only important thing Windows does better
            than Debian is implementing the win32 platform"
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
