Return-Path: <xander.huff@ni.com>
Message-ID: <5564C417.3010707@ni.com>
Date: Tue, 26 May 2015 14:05:59 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        ben.shelton@ni.com, joshc@ni.com, joe.hershberger@ni.com
Subject: Re: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com> <1431038644-41600-2-git-send-email-xander.huff@ni.com> <555B78A3.2030202@metafoo.de> <55606340.1090403@kernel.org> <55643F20.4080306@metafoo.de>
In-Reply-To: <55643F20.4080306@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/26/2015 4:38 AM, Lars-Peter Clausen wrote:
> On 05/23/2015 01:23 PM, Jonathan Cameron wrote:
>> On 19/05/15 18:53, Lars-Peter Clausen wrote:
>>> On 05/08/2015 12:44 AM, Xander Huff wrote:
>>>> To better facilitate user-mode access to optional aux channels, allow
>>>> device trees to specify a custom extended name for defined channels.
>>>
>>> Hi,
>>>
>>> 'extend-name' is kind of a IIO specific term. I think a better name in the
>>> devicetree context would be 'label'. That's used everywhere else when giving
>>> a short description string to a node.
>>>
>> Hi Lars,
>>
>> What do you think of the general idea?  I'm unconvinced we want to do this in
>> channel naming.
>> Perhaps we want an additional attribute giving access to this sort of
>> 'semantic' information?
>
> I'm not convinced about it either. My gut feeling is that this is not the right
> approach, but I don't really have any better ideas at the moment.
>
> Xander can you give a short description of how this information will be used by
> an application? Would having a label property for the channel also work for you
> (e.g. in_voltage0_label)?
>
> - Lars
>
We use 10 of the optional aux channels available in the XADC and have them wired 
up to specific power supplies. For example, channel 9 is connected to the 
current of a 6V power supply and channel 12 is connected to the voltage of that 
same supply, channel 4 is connected to the current of a 3.3V power supply and 
channel 5 is connected to its voltage.

Without adding extended names to distinguish these aux channels, the handles 
available inside /sys/bus/iio/devices/[device] are generic: in_voltage10_raw, 
in_voltage10_scale, for example. If I added the label 'user5v_v', then these 
handles would be in_voltage10_user5v_v_raw and in_voltage10_user5v_v_scale. This 
makes it a lot easier to get started and let the handles describe themselves, 
rather than having to look up which channels are connected to which things.

As far as using 'label' instead of 'extend-name', that's fine with me. I've 
already sent out a v2 using 'label' instead.

-- 
Xander Huff
Staff Software Engineer
National Instruments
