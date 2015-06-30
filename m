Return-Path: <martin.kepplinger@theobroma-systems.com>
Message-ID: <559289D5.5020503@theobroma-systems.com>
Date: Tue, 30 Jun 2015 14:21:41 +0200
From: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
 Martin Kepplinger <martink@posteo.de>
CC: jic23@kernel.org, christoph.muellner@theobroma-systems.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: mma8452: add support for 3 more devices
References: <1435663602-29868-1-git-send-email-martink@posteo.de> <alpine.DEB.2.02.1506301336410.12832@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1506301336410.12832@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>



On 2015-06-30 13:39, Peter Meerwald wrote:
> Hello Martin,
> 
>> The first patch doesn't change anything for existing users of mma8452. Please
>> test this if you can!
> 
> nice to see the driver improved!
> the first patch does quite I bit more than it claims; it's not only
> adding more device, I'd prefer the patch split up for review

well, yes. It adds an interrupt source for those that don't support the
existing one, but I could come up with even more seperate changes,
that's true.

>  
>> The second patch corrects how interrupts are described as IIO events. It exists
>> seperately because it changes the driver's behaviour for existing users of
>> mma8452.
> 
> what is the difference?

Since the threshold is no signed value, it changes the event type
from IIO_EV_TYPE_THRESH to IIO_EV_TYPE_MAG, see the patch or
sysfs-bus-iio Documentation:

What:		/sys/.../iio:deviceX/events/in_accel_x_mag_en

Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
magnitude of the channel is compared to the threshold, not its
signed value.

> 
> thanks, p.
> 
