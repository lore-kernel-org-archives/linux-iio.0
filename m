Return-Path: <mfuzzey@parkeon.com>
Message-ID: <55ACB393.8000603@parkeon.com>
Date: Mon, 20 Jul 2015 10:38:43 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Martin Kepplinger <martink@posteo.de>,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, christoph.muellner@theobroma-systems.com,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 8/8] iio: mma8452: add devicetree property to allow all
 pin wirings
References: <1436186062-5766-1-git-send-email-martink@posteo.de> <1436186062-5766-9-git-send-email-martink@posteo.de> <55ABAA8B.3080706@kernel.org>
In-Reply-To: <55ABAA8B.3080706@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 19/07/15 15:47, Jonathan Cameron wrote:
> On 06/07/15 13:34, Martin Kepplinger wrote:
>> For the devices supported by the mma8452 driver, two interrupt pins are
>> available to route the interrupt signals to. By default INT1 is assumed.
>>
>> This adds a simple boolean DT property, for users to configure it for
>> INT2, if that is the wired interrupt pin for them.
>>
>> This is important for everyone to be able to use this driver, no matter
>> how their chip is wired.
>>
>> Since this doesn't change the default behaviour, it doesn't break anything
>> for existing users.
A remark about this.

The hardware allows each of the interrupt sources (threshold, freefall, 
data available, wakeup, ...) to be individiually mapped to one of the 
two available interrupt pins.
This patch only allows one pin or the other one to be selected for all 
the sources.

Granted this will certainly cover 99% of use cases (even if both are 
wired that means we can use either).
However there is one possible case not covered which is when one of the 
interrupt signals is connected to some other circuitry (alarm, 
power,...) in addition to being used as an interrupt to the CPU.

Normally for code I'd just say let's cross that bridge when we come to 
it given that it's pretty unlikely.
However since this affects the DT binding and they can be awkward to 
change while keeping compatibility maybe it would be better to use a 
bitmask DT property rather than a boolean to actually describe the full 
hardware capabilities and keep that door open?

Of course, actually supporting arbitary mappings would be a bit more 
work in the driver (both irqs would need to requested...).
However it would be possible to use a bitmask in the DT but, for the 
moment, only accept all zeros or all ones, leaving the rest for a future 
driver update if and when it is needed.

I don't have a strong objection to doing it the current way, it's 
certainly the simplest way and it's likely to be all we ever need just 
pointing out a possible shortcoming.

I think It would be good to have the DT maintainers view on this.

>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> The whole series looks good to me.  Just want those acks from Peter and / or
> Martin before I apply it.
I'll try to give it a spin this week. Can't promise though


Regards,

Martin
