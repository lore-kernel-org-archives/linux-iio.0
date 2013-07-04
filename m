Return-Path: <nsekhar@ti.com>
Message-ID: <51D57AF9.2020001@ti.com>
Date: Thu, 4 Jul 2013 19:09:05 +0530
From: Sekhar Nori <nsekhar@ti.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
        =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>,
        Tony Lindgren
	<tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Felipe Balbi <balbi@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH 04/22] input/ti_am33x_tsc: Order of TSC wires, made configurable
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-5-git-send-email-bigeasy@linutronix.de> <51D5592F.6050208@ti.com> <51D55D80.6080803@linutronix.de>
In-Reply-To: <51D55D80.6080803@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On 7/4/2013 5:03 PM, Sebastian Andrzej Siewior wrote:
> On 07/04/2013 01:14 PM, Sekhar Nori wrote:
>>
>> On 6/11/2013 5:00 PM, Sebastian Andrzej Siewior wrote:
>>> From: "Patil, Rachna" <rachna@ti.com>
>>>
>>> The current driver expected touchscreen input
>>> wires(XP,XN,YP,YN) to be connected in a particular order.
>>> Making changes to accept this as platform data
>>
>> The platform data part of this driver will never get used since it is
>> used on DT-only platforms (and future platforms will all be DT-only).
>> You should get rid of it as it will save you some code.
> 
> If you follow the series you will notice that the platform bits are
> removed later. Should I have overlooked something please say so.

Yes, I noticed that after sending the mail. To me it does not make sense
to make changes to accept something as platform data only to remove
platform data itself later.

May be reorder the series to move this to after platform data removal -
that way any platform data related changes in the patch will have to go
away.

Thanks,
Sekhar
