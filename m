Return-Path: <stigge@antcom.de>
Message-ID: <4D2DF5C0.6030405@antcom.de>
Date: Wed, 12 Jan 2011 19:41:04 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Documentation update for outputs / dac
References: <4D2D8516.1040602@antcom.de> <4D2D995E.6090505@cam.ac.uk>
In-Reply-To: <4D2D995E.6090505@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 01/12/2011 01:06 PM, Jonathan Cameron wrote:
> Any chance at all you can get git-send-email to work for you?
> Saves me the step of pasting the attachment back into the email
> every time!

Thanks for the hint. Will test with another patch. :-)

>> +What:		/sys/bus/iio/devices/deviceX/outY_raw
>> +KernelVersion:	2.6.37
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Raw (unscaled, no bias etc.) output voltage for
>> +		channel Y. 
> 
> Get rid of this bit about named output. I'm not sure it makes sense to allow
> this and I don't think we currently have an examples in tree.

Do you mean we shouldn't document /sys/bus/iio/devices/deviceX/outY_raw
(which is quite analogous to inY_raw) but
/sys/bus/iio/devices/deviceX/outY_scale and
/sys/bus/iio/devices/deviceX/outY&Z_raw?

Or how did I get you wrong?

Thanks,

Roland
