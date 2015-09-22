Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56014FD0.4010005@lysator.liu.se>
References: <1442925594-21240-1-git-send-email-peda@lysator.liu.se>
	<1442925594-21240-2-git-send-email-peda@lysator.liu.se>
	<CAEnQRZAcoqXMO7kYmK+PYcU7cNAtL8giuRqua4uRSP2hOegajw@mail.gmail.com>
	<56014FD0.4010005@lysator.liu.se>
Date: Tue, 22 Sep 2015 15:59:42 +0300
Message-ID: <CAEnQRZABp5ag+1wNAzoR-pOEYT=fKWuJ=nAQQYHv-DOdgHdUYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: resistance: Document that resistance can be output
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
	Crt Mori <cmo@melexis.com>, Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 22, 2015 at 3:55 PM, Peter Rosin <peda@lysator.liu.se> wrote:
> On 2015-09-22 14:48, Daniel Baluta wrote:
>> On Tue, Sep 22, 2015 at 3:39 PM, Peter Rosin <peda@lysator.liu.se> wrote=
:
>>> From: Peter Rosin <peda@axentia.se>
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/AB=
I/testing/sysfs-bus-iio
>>> index 9398484196c4..2eea468f704d 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1475,6 +1475,8 @@ Description:
>>>
>>>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
>>>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
>>> +What:          /sys/bus/iio/devices/iio:deviceX/out_resistance_raw
>>> +What:          /sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
>>>  KernelVersion: 4.3
>>>  Contact:       linux-iio@vger.kernel.org
>>>  Description:
>>
>> One more thing. The description for this sections says:
>>
>> =C2=BB       =C2=BB       Raw (unscaled no offset etc.) resistance readi=
ng that
>> can be processed
>> =C2=BB       =C2=BB       into an ohm value.
>>
>> I'm not sure this still holds for out_resistanceX_raw. We have two optio=
ns here:
>
> I figured it did hold, since you effectively select what reading the
> resistance inside the potentiometer should have. If it's really
> important I can of course make another spin, but is this somthing
> that is likely to be misunderstood?

Now, with your explanation it makes more sense. We can leave it like
that.

thanks,
Daniel.
