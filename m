Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:46387 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966138AbaFRM44 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 08:56:56 -0400
Date: Wed, 18 Jun 2014 14:56:52 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
In-Reply-To: <53A1895A.4090209@gmail.com>
Message-ID: <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
References: <20140611013007.GA32756@kroah.com> <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com> <53998D43.9020209@gmail.com> <53A1895A.4090209@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Kristina,

> > Okay so right now I'm getting the following things I could work on:
> > 
> > 1) prefixes on define constants for lpc32xx_ADC (then trying to move it
> > out of staging and seeing what other issues people find?)
> > 2) resolver/CDC ABI documentation cleanup
> > 3) dummy driver fake event interrupt hack
> > 4) Lars may have more ideas?
> > 
> > The plan is for me to start working on this stuff full time next week,
> > so if you think of anything more, please let me know!
> 
> Haven't heard back from you about this. Have you found anything else
> that needs to be done with staging IIO drivers before they can be moved out?

IIO is a bit problematic since testing usually requires possessing the 
sensor chip

regarding staging/iio/magnetometer/hmc5843:
the driver has one specific DEVICE_ATTR left (meas_conf), otherwise clean 
I think; so we could (a) document it as special ABI or (b) drop it

regarding staging/iio/light/isl*:
drivers have plenty of custom ATTRs and do not follow style 
(function name prefixes, #define PREFIXes)
some of the special ATTRs could converted to using SAMPL_FREQ, INT_TIME, 
SCALE

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
