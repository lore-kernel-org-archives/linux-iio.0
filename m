Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
Date: Tue, 2 Jul 2013 18:33:04 +0200
Cc: Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 brian@crystalfontz.com,
 linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org,
 jimwall@q.com,
 Rob Herring <rob.herring@calxeda.com>,
 linux-kernel@vger.kernel.org,
 Grant Likely <grant.likely@secretlab.ca>,
 Rob Landley <rob@landley.net>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com> <51D2BEA1.6010206@free-electrons.com> <51D2DE5B.9060309@free-electrons.com>
In-Reply-To: <51D2DE5B.9060309@free-electrons.com>
MIME-Version: 1.0
Message-Id: <201307021833.04282.marex@denx.de>
Content-Type: Text/Plain;
  charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Dear Alexandre Belloni,

> On 02/07/2013 13:50, Alexandre Belloni wrote:
> > On 02/07/2013 13:45, Fabio Estevam wrote:
> >> Shouldn't this be
> >> 
> >>          i2c@1 {
> >>          
> >>                  reg = <1>; ?
> > 
> > No, we have 4 devices on that mux and 2 pins to select the muxing.
> 
> OK, got it working.
> 
> So, the results:
> 
> bitbanging:
> 
> # time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
> 2637
> real	0m 0.09s
> user	0m 0.01s
> sys	0m 0.01s
> 
> 
> i2c-mxs PIO mode:
> 
> # time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
> [   35.007650] [sched_delayed] sched: RT throttling activated
> 2627
> real	0m 7.14s
> user	0m 0.02s
> sys	0m 0.01s
> 
> 
> i2c-mxs PIO mode without LRADC:
> 
> # time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
> [   18.007432] [sched_delayed] sched: RT throttling activated
> 2629
> real	0m 7.09s
> user	0m 0.00s
> sys	0m 0.03s
> 
> 
> i2c-mxs DMA mode:
> 
> # time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
> 2631
> real	0m 0.12s
> user	0m 0.01s
> sys	0m 0.01s
> 
> 
> It seems fine for me.

I think I'm getting a little lost in these gazilions of i2c and lradc threads. 
Can we not create one thread and keep the related stuff in there instead of 
discussing it all around !?

Only one question comes to mind with this email -- what do LRADC and I2C have to 
do with each other here ?

It'd be nice if someone could summarize on what I should focus and possibly 
prepare a testcase.

Best regards,
Marek Vasut
