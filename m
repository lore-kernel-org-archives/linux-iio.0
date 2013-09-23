Return-Path: <arunjoseph@ti.com>
Message-ID: <5240027C.9040804@ti.com>
Date: Mon, 23 Sep 2013 14:27:32 +0530
From: Arun Joseph <arunjoseph@ti.com>
MIME-Version: 1.0
To: Matthias Kaehlcke <matthias.list@kaehlcke.net>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@ti.com>,
        Pantelis
 Antoniou <panto@antoniou-consulting.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
Subject: Re: [PATCH v2] iio: ti_am335x_adc: Take touchscreen steps into account
 for conversion timeout
References: <20130916211749.GG24058@raspi> <523D9046.7010305@kernel.org> <20130922175145.GB27515@raspi>
In-Reply-To: <20130922175145.GB27515@raspi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On Sunday 22 September 2013 11:21 PM, Matthias Kaehlcke wrote:
> Hi,
>
> El Sat, Sep 21, 2013 at 01:25:42PM +0100 Jonathan Cameron ha dit:
>
>> On 09/16/13 22:17, Matthias Kaehlcke wrote:
>>> The calculation of the old conversion timeout value was based on the number of
>>> steps used by this driver. This doesn't take into account that other steps
>>> can be used by the touchscreen driver. Select the timeout value based on the
>>> steps used by both drivers
>>>
>>> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
>> Looks fine to me but I'd like an Ack from someone more familiar with the device
>> if possible.
> Arun, do you feel entitled to Ack or can you suggest someone from TI
> who is?
>
Adding Sekhar Nori
>> Also, I'm assuming this is a fix we want to push out asap but that isn't
>> clear in your patch title.  Perhaps something like:
>>
>> iio: ti_am335x_adc: Fix conversion timeout to allow for touch screen steps.
>> ?
> it's not as critical as it seems as in practice the timeout has the
> granularity of a jiffy. If you prefer I still can resend the patch
> with the subject you suggest
>
> best regards
>
