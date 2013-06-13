Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48017 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab3FMJZc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jun 2013 05:25:32 -0400
Message-ID: <51B99006.2060103@linutronix.de>
Date: Thu, 13 Jun 2013 11:25:26 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Samuel Ortiz <sameo@linux.intel.com>
CC: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 5
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de> <20130613090719.GB7998@zurbaran>
In-Reply-To: <20130613090719.GB7998@zurbaran>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/13/2013 11:07 AM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> Pulled and pushed back to mfd-next, thanks.

Thank you.

> I fixed a couple of unused variable warnings on top of it.

I saw your patch at git.k.o and I am asking you not to taking it :)
The code is:

        of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
                 adc_channels++;
                 if (val > 7) {
                         dev_err(&pdev->dev, " PIN numbers are 0..7 (not
%d)\n",
                                         val);
                         return -EINVAL;
                 }
         }

and without CONFIG_OF of_property_for_each_u32() becomes most likely
empty. That is why I haven't seen it.
So either the macro should be changed to tell the compiler that the
variables are used (so the warning does not show up) or let the driver
depend on CONFIG_OF. I will look at the former and can prepare a patch
for the latter if you want.

> 
> Cheers,
> Samuel.
> 

Sebastian
