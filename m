Return-Path: <SRS0=jBNH=6C=roeck-us.net=linux@kernel.org>
Date: Thu, 29 Jun 2017 08:08:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdelvare@suse.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
Message-ID: <20170629150800.GB10226@roeck-us.net>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
 <c2f1b4c1-91b2-f3af-e76f-66d7d0633239@roeck-us.net>
 <26126017-55d8-3d38-f5de-c764ca9ec699@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <26126017-55d8-3d38-f5de-c764ca9ec699@topic.nl>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 29, 2017 at 04:11:42PM +0200, Mike Looijmans wrote:
> ﻿On 29-06-17 15:40, Guenter Roeck wrote:
> >On 06/29/2017 05:30 AM, Lars-Peter Clausen wrote:
> >>On 06/29/2017 02:13 PM, Mike Looijmans wrote:
> >>>The LTC2741 and LTC2473 are single voltage monitoring chips. The LTC2473
> >>>is similar to the LTC2471 but outputs a signed differential value.
> >>>
> >>>Datasheet:
> >>>   http://cds.linear.com/docs/en/datasheet/24713fb.pdf
> >>
> >>This looks more like a general purpose ADC rather than a specialized voltage
> >>monitoring chip. In my opinion this driver would be better suited for the
> >>IIO framework. But before you start working on that lets try to hear what
> >>others think about this.
> >>
> >
> >Agreed (I just replied to that on another thread).
> 
> Took a peek at the IIO drivers, looks simple enough, so I suggest to drop
> this patch and I'll create an IIO driver instead.
> 
> The ltc2485 (as suggested by Guenter on that other thread) is pretty similar
> indeed, it might be feasible to join the two and have one driver handle them
> both. That would be preferred over a separat driver, right?
> 
In general yes, but it really depends on the similarities and differences. If
the single driver ends up twice as large, it is probably better to keep them
separate. If all you need to do is to add chip IDs, obviously a single driver
is better. Everything in between really depends on the amount of chip specific
code.

Thanks,
Guenter
