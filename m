Return-Path: <jic23@kernel.org>
Message-ID: <4FACC464.9010404@kernel.org>
Date: Fri, 11 May 2012 08:48:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Jon Brenner <jbrenner@taosinc.com>,
 linux-iio <linux-iio@vger.kernel.org>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>, samu.p.onkalo@nokia.com,
 daniel@caiaq.de, giometti@linux.it, khali@linux-fr.org,
 amit.kucheria@verdurent.com, Laxman Dewangan <ldewangan@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V1] RFC - Proposed IIO Documentation patch to add CCT
 and RGBC data
References: <1335907654.766.24.camel@jonz-ub2> <4FA0F2A7.1040003@cam.ac.uk>
In-Reply-To: <4FA0F2A7.1040003@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/2/2012 9:39 AM, Jonathan Cameron wrote:
> Added cc's
>
> Jon, remember to wrap emails at 80 chars please!
>> Request for Comments -
>>
>> Documentation patch to add Correlated Color Temperature (CCT) and RGBC
>> (red/green/blue/clear) data.
>>
>> The addition of CCT and RGBC is afforded by utilizing a 'real channel'
>> type of IIO_CCT, and 4 modifiers of IIO_MOD_LIGHT_CLEAR,
>> IIO_MOD_LIGHT_RED, IIO_MOD_LIGHT_GREEN, and IIO_MOD_LIGHT_BLUE, found
>> in types.h.
If we were to apply this to the existing sensors, how do we distinguish
between 'clear' vs the visable+infrared option that is there already?
I note below that you have distinguished this by saying it is on
a colour sensor only.  That seems a little bit inconsistent given
a single wide band sensor might be measuring the same thing...

I'm fine with the colour ones btw but one query below..
>> A trivial addition to industrialio-core.c is required.
>>
>> in_cct0_input will return typically return the color temperature
>> expressed in kelvins.
>>
>> IIO_MODIFIERs are respective of the associated light frequencies for
>> each of the channels.
>>
>>
>>
>>
>>
>>
>> Signed-off-by: Jon Brenner<jbrenner@taosinc.com>
>> ---
>> .../staging/iio/Documentation/sysfs-bus-iio-light | 46
>> ++++++++++++++++++++
>> 1 files changed, 46 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>> b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>> index 715c74d..bd42baf 100644
>> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>> @@ -34,6 +34,15 @@ Description:
>> it comes back in SI units, it should also include _input else it
>> should include _raw to signify it is not in SI units.
>>
>> +What: /sys/bus/iio/devices/device[n]/in_cct0[_input|_raw]
>> +KernelVersion: 3.4.0
>> +Contact: linux-iio@vger.kernel.org
>> +Description:
>> + This should return the correlated color temperature from the
>> + light sensor. If it comes back in SI units, it should also
>> + include _input else it should include _raw to signify it is not
>> + in SI units.
>> +
>> What: /sys/.../device[n]/proximity_on_chip_ambient_infrared_supression
>> KernelVersion: 2.6.37
>> Contact: linux-iio@vger.kernel.org
>> @@ -82,3 +91,40 @@ Contact: linux-iio@vger.kernel.org
>> Description:
>> This property gets/sets the table of coefficients
>> used in calculating illuminance in lux.
>> +
>> +What: /sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
>> +KernelVersion: 3.4.0
>> +Contact: linux-iio@vger.kernel.org
>> +Description:
>> + This property is supported by sensors that have a RGBC
>> + sensing mode. This value should be the output from a reading
>> + and if expressed in SI units, should include _input. If this
>> + value is not in SI units, then it should include _raw.
>> +
>> +What: /sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
>> +KernelVersion: 3.4.0
>> +Contact: linux-iio@vger.kernel.org
>> +Description:
>> + This property is supported by sensors that have a RGBC
>> + sensing mode. This value should be the output from a reading
>> + and if expressed in SI units, should include _input. If this
>> + value is not in SI units, then it should include _raw.
Err. What are the SI units of intensity?
>> +
>> +What: /sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
>> +KernelVersion: 3.4.0
>> +Contact: linux-iio@vger.kernel.org
>> +Description:
>> + This property is supported by sensors that have a RGBC
>> + sensing mode. This value should be the output from a reading
>> + and if expressed in SI units, should include _input. If this
>> + value is not in SI units, then it should include _raw.
>> +
>> +What: /sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
>> +KernelVersion: 3.4.0
>> +Contact: linux-iio@vger.kernel.org
>> +Description:
>> + This property is supported by sensors that have a RGBC
>> + sensing mode. This value should be the output from a reading
>> + and if expressed in SI units, should include _input. If this
>> + value is not in SI units, then it should include _raw.
>> +
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
