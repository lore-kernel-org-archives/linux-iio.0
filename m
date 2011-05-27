Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DDF7BA2.1070400@analog.com>
Date: Fri, 27 May 2011 12:23:30 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI
 ADC
References: <1306335750-428-1-git-send-email-michael.hennerich@analog.com> <4DDE28F4.5040705@cam.ac.uk> <4DDE63B1.2060301@analog.com> <4DDE6A8D.5000007@cam.ac.uk> <4DDF5C32.6010905@analog.com> <4DDF7265.5070309@cam.ac.uk>
In-Reply-To: <4DDF7265.5070309@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/27/2011 11:44 AM, Jonathan Cameron wrote:
> ...
>> Hi Jonathan,
>>
>>
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  ls
>> device0:buffer0               power
>> in-in_scale                   range
>> in0-in0_raw                   range_available
>> in1-in1_raw                   sampling_frequency
>> in2-in2_raw                   sampling_frequency_available
>> in3_raw                       subsystem
>> in4_supply_raw                temp0_raw
>> in4_supply_scale              temp_scale
>> in_scale                      trigger
>> name                          uevent
>>
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  cat in_scale
>> 0.000140
>>
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  cat range_available
>> 2500 1250 625 312 156 78 39 19
>>
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  echo 312>  range
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  cat in_scale
>> 0.000010
>>
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  echo 78>  range
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>  cat in_scale
>> 0.000000
>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>
>>
>> with these 24-bit converters and input AMPs we are already exhausted
>> the number of available digits we have for scale.
> Time for a new return type and extra logic in the core.
> IIO_VAL_INT_PLUS_NANO
>
> should still fit in a 32 bit long.  Perhaps it's better to make a  bigger jump - or
> this will just bite us again sometime soon.
>
> After nano we will have to start having padding zeros which is going to be a little
> strange - or I guess we don't have to keep val as being int...
>
> IIO_VAL_MICRO_PLUS_PICO maybe?  The maximum option of IIO_VAL_NANO_PLUS_ATTO seems a little
> 'odd'.
>
> The more complex question is going to be writing values that are this small. I think we will
> have to add another callback into the drivers where they can query what format a value should
> be in so the core can provide it.  Make this optional so it doesn't effect the majority
> of drivers where int + micro does the job.
>
IIO_VAL_INT_PLUS_NANO should do the job for now.

>> What shall we do?
>>
>> Also how would you name AIN1(-) - AIN1(-)?
>>
>> #define AD7793_CH_AIN1P_AIN1M        0 /* AIN1(+) - AIN1(-) */
>> #define AD7793_CH_AIN2P_AIN2M        1 /* AIN2(+) - AIN2(-) */
>> #define AD7793_CH_AIN3P_AIN3M        2 /* AIN3(+) - AIN3(-) */
>> #define AD7793_CH_AIN1M_AIN1M        3 /* AIN1(-) - AIN1(-) */
>>
>> in0-in0_zerooffset_raw ?
> Hmm.. That is awkward.  Given only the channel numbers exist in event codes
> it will also possibly cause us issues at some later date.
> How about having in0-in0_raw then in0-in0_offset + in0-in0_offset_available.
> (actually this would be shared I guess so in-in_offset_available).
> A little clunky, but does fit better within the api.  Is there a real use case
> for buffering where one grabs both offsets in the same scan?
As far as I understand things - We do zero and full scale calibration,
The results read from the other channels should have the offset eliminated.
I agree the offset read from  AIN1(-) - AIN1(-) should be the same for 
all channels.
So in-in_offset sounds good to me - why _available?
> Jonathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
