Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36345 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeGCOEP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2018 10:04:15 -0400
Date: Tue, 3 Jul 2018 10:04:06 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: David Lechner <david@lechnology.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [v7, 02/10] counter: Documentation: Add Generic Counter sysfs
 documentation
Message-ID: <20180703140406.GA14958@sophia>
References: <27299151c2c7c57e70c49b4f7b794839d00cd750.1529607879.git.vilhelm.gray@gmail.com>
 <2c7ae044-c09b-3d51-bd16-3ecf35154024@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2c7ae044-c09b-3d51-bd16-3ecf35154024@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 02, 2018 at 02:11:35PM -0500, David Lechner wrote:
>On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
>> +What:		/sys/bus/counter/devices/counterX/countY/count_mode
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Count mode for channel Y. The ceiling and floor values for
>> +		Count Y are used by the count mode where required. The following
>> +		count modes are available:
>> +
>> +		Normal:
>> +			Counting is continuous in either direction.
>> +
>> +		Range Limit:
>> +			An upper or lower limit is set, mimicking limit switches
>> +			in the mechanical counterpart. The upper limit is set to
>> +			the Count Y ceiling value, while the lower limit is set
>> +			to the Count Y floor value. The counter freezes at
>> +			count = ceiling when counting up, and at count = floor
>> +			when counting down. At either of these limits, the
>> +			counting is resumed only when the count direction is
>> +			reversed.
>> +
>> +		Non-Recycle:
>> +			The counter is disabled whenever a counter overflow or
>> +			underflow takes place. The counter is re-enabled when a
>> +			new count value is loaded to the counter via a preset
>> +			operation or direct write.
>> +
>> +		Modulo-N:
>> +			A count value boundary is set between the Count Y floor
>> +			value and the Count Y ceiling value. The counter is
>> +			reset to the Cunt Y floor value at count = ceiling when
>> +			counting up, while the counter is set to the Count Y
>> +			ceiling value at count = floor when counting down; the
>> +			counter does not freeze at the boundary points, but
>> +			counts continuously throughout.
>> +
>
>This might be a bit misleading since the values returned are all lower case,
>e.g. "rising edge", whereas they are listed here in Title Case.

Fair point, the options explicitly listed in the documentation should
match how they appear on the system. I'll make sure to consolidate these
and the others you mentioned in the next revision.

>> +What:		/sys/bus/counter/devices/counterX/countY/preset
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		If the counter device supports preset registers -- registers
>> +		used to load counter channels to a set count upon device-defined
>> +		preset operation trigger events -- the preset count for channel
>> +		Y is provided by this attribute.
>
>Should this be presetZ in case a device has more than one preset?

I suppose it could be possible for a device to feature more than one
preset register for a count. However, in those cases a simple numbering
scheme such as presetZ would be ambigious: which preset register is
evaluated at which point?

I suspect in these kind of devices the preset registers are designated
specific triggers; for example, perhaps preset0 is evaluated when the
count reaches a ceiling, while preset1 is evaluated when a count reaches
a floor. In those sort of cases, it may be better to be more explicit
and define them as preset_ceiling and preset_floor (or something
similar) to make their behavior and use more apparent.

Alternatively, if the multiple presets are configurable, then there may
be value with a presetZ scheme if we have a respective presetZ_op
attribute (or similar) to expose the preset operation trigger condition
to the user. I haven't personally encountered devices like this, but I
can see it as possible, so we can consider this design once we try to
add support for a device that requires it.

>> +What:		/sys/bus/counter/devices/counterX/signalY/signal
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Signal data of Signal Y represented as a string.
>
>I guess the actual value returned depends on the type of signal? Would we
>need /sys/bus/counter/devices/counterX/signalY/type to indicate this so we
>know how to interpret the value?

I'm not sure how useful such an attribute would be. If we're using some
sort of generic utility to list out counter device information, then it
can print out the signal data directly because it's reported as a
character string. On the other hand, if the utility is specific for your
particular device, it should already know the format of the signal data
to parse at the very least from the respective documentation.

I don't believe adding this attribute would be technically difficult,
but I would hold off on adding it until we see a situation that requires
it (perhaps a device with multiple signal sources of different types for
example).

William Breathitt Gray
