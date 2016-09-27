Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49185 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbcI0TbZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2016 15:31:25 -0400
Subject: Re: [PATCH v4 1/2] iio: Implement counter channel type and info
 constants
To: William Breathitt Gray <vilhelm.gray@gmail.com>
References: <cover.1474487854.git.vilhelm.gray@gmail.com>
 <87ac8c5c0e5413dc10059e64f49ede6f2e79c02b.1474487854.git.vilhelm.gray@gmail.com>
 <659454ba-dcf4-800d-c589-22af5392b07a@kernel.org>
 <20160927183042.GB15896@sophia>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <514e655f-fbe9-4ccc-daa2-3d06d2ecab81@kernel.org>
Date: Tue, 27 Sep 2016 20:31:21 +0100
MIME-Version: 1.0
In-Reply-To: <20160927183042.GB15896@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/16 19:30, William Breathitt Gray wrote:
> On Sat, Sep 24, 2016 at 06:03:21PM +0100, Jonathan Cameron wrote:
>> On 21/09/16 21:15, William Breathitt Gray wrote:
>>> Quadrature encoders, such as rotary encoders and linear encoders, are
>>> devices which are capable of encoding the relative position and
>>> direction of motion of a shaft. This patch introduces several IIO
>>> constants for supporting quadrature encoder counter devices.
>>>
>>>   IIO_COUNT: Current count (main data provided by the counter device)
>>>   IIO_INDEX: Counter device index value
>>>   IIO_CHAN_INFO_PRESET: Counter preset value
>>>
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 28 ++++++++++++++++++++++++++++
>>>  drivers/iio/industrialio-core.c         |  3 +++
>>>  include/linux/iio/iio.h                 |  1 +
>>>  include/uapi/linux/iio/types.h          |  2 ++
>>>  4 files changed, 34 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index fee35c0..be66a41 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1579,3 +1579,31 @@ Contact:	linux-iio@vger.kernel.org
>>>  Description:
>>>  		Raw (unscaled no offset etc.) electric conductivity reading that
>>>  		can be processed to siemens per meter.
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
>>> +KernelVersion:	4.9
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Raw counter device counts from channel Y. For quadrature
>>> +		counters, division by an available [Y]_scale results in the
>>> +		counts of a single quadrature signal phase from channel Y.
>> Division?  Needs to be multiplication to be consistent with the other
>> interfaces.  
> 
> That makes sense. What I'll do is refactor scale to accept the values 1,
> 0.5, and 0.25 to select the respective x1, x2, and x4 quadrature modes.
> 
> The counter device will count full-phase edges on quadrature x1 mode,
> half-phase edges on quadrature x2 mode (twice as many counts as x1), and
> quarter-phase edges on quadrature x4 mode (twice as many counts as x2).
> One of the benefits of the x2 and x4 quadrature modes is increased
> position fidelity, so exposing scale as a fraction will allow it to be
> multipled to raw counts without sacrificing the precision benefit of the
> x2 and x4 quadrature modes.
> 
Spot on.

Jonathan
> William Breathitt Gray
> 
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
>>> +KernelVersion:	4.9
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		If a scale value is available for channel Y, it is provided by
>>> +		this attribute.
>> Can just add the What line to the big block of _scale attributes already
>> listed.  Generic text should cover it fine.
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
>>> +KernelVersion:	4.9
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		If the counter device supports preset registers, the preset
>>> +		count for channel Y is provided by this attribute.
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
>>> +KernelVersion:	4.9
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Raw counter device index value from channel Y.
>> Needs more description.  Don't assume people have any idea what an 'index'
>> value is on a counter.
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index fc340ed..ed175a2 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -81,6 +81,8 @@ static const char * const iio_chan_type_name_spec[] = {
>>>  	[IIO_PH] = "ph",
>>>  	[IIO_UVINDEX] = "uvindex",
>>>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>>> +	[IIO_COUNT] = "count",
>>> +	[IIO_INDEX] = "index",
>>>  };
>>>  
>>>  static const char * const iio_modifier_names[] = {
>>> @@ -151,6 +153,7 @@ static const char * const iio_chan_info_postfix[] = {
>>>  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>>>  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>>>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>>> +	[IIO_CHAN_INFO_PRESET] = "preset",
>>>  };
>>>  
>>>  /**
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index b4a0679..7dc86d1 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -46,6 +46,7 @@ enum iio_chan_info_enum {
>>>  	IIO_CHAN_INFO_DEBOUNCE_TIME,
>>>  	IIO_CHAN_INFO_CALIBEMISSIVITY,
>>>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>>> +	IIO_CHAN_INFO_PRESET,
>>>  };
>>>  
>>>  enum iio_shared_by {
>>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>>> index 22e5e58..e54d14a 100644
>>> --- a/include/uapi/linux/iio/types.h
>>> +++ b/include/uapi/linux/iio/types.h
>>> @@ -40,6 +40,8 @@ enum iio_chan_type {
>>>  	IIO_PH,
>>>  	IIO_UVINDEX,
>>>  	IIO_ELECTRICALCONDUCTIVITY,
>>> +	IIO_COUNT,
>>> +	IIO_INDEX,
>>>  };
>>>  
>>>  enum iio_modifier {
>>>
>>

