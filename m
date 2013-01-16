Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49877 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab3APIsK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 03:48:10 -0500
Message-ID: <50F66946.9090600@kernel.org>
Date: Wed, 16 Jan 2013 08:48:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: iio: STMicroelectronics iio drivers
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <50F5D957.6010603@kernel.org> <50F5DFDE.4050607@kernel.org>
In-Reply-To: <50F5DFDE.4050607@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/01/13 23:01, Jonathan Cameron wrote:
> On 01/15/2013 10:33 PM, Jonathan Cameron wrote:
>> On 01/15/2013 08:30 AM, Denis CIOCCA wrote:
>>> Hi Jonathan,
>>>
>>> I sent to you the new patches to fix the u8 casting and a little bugfix in the header files (functions within #ifdef).
>>> Thanks,
>>>
>>> Denis
>>>
>>>
>> Denis,
>>
>> Just been running some build tests on this.  You need to
>> do a lot more testing of the various possible combinations
>> I think. Right now I can't build and so far I'm not entirely
>> sure why.
>>
>>    CHECK   drivers/iio/accel/st_accel_i2c.c
>> drivers/iio/accel/st_accel_i2c.c:38:9: error: undefined identifier 'st_sensors_i2c_configure'
>>    CC [M]  drivers/iio/accel/st_accel_i2c.o
>> drivers/iio/accel/st_accel_i2c.c: In function 'st_accel_i2c_probe':
>> drivers/iio/accel/st_accel_i2c.c:38:2: error: implicit declaration of function 'st_sensors_i2c_configure'
>> make[3]: *** [drivers/iio/accel/st_accel_i2c.o] Error 1
>> make[2]: *** [drivers/iio/accel] Error 2
>> make[1]: *** [drivers/iio] Error 2
>> make: *** [drivers] Error 2
>>
>> For reasons that aren't immediately clear ifdef CONFIG statements don't
>> seem to be working...
>
> Of course, I had relevant bits compiling as modules.
>
> I think we should rethink the module structure here so that this mess doesn't occur.
> One core driver with multiple files seems right to me.
>
> so a make file looking something like.
> obj-$(CONFIG_IIO_ST_SENSORS_CORE) += st_sensors.o
> st_sensors-y := st_sensors_core.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_I2C) += st_sensors_i2c.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_SPI) += st_sensors_spi.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_TRIGGERED_BUFFER) += st_sensors_trigger.o st_sensors_buffer.o
>
> and a kconfig where all by the sensors_core entry are boolean.
>
> Similarly for the drivers.  Thus we end up with 4 modules rather than dozens and
> hopefully the build logic will work fine in all cases.
>
> Also note that I think you can't have buffering for accel and not gyro etc.
>
Thinking a little more on this, I can see why you'd want separate 
library drivers for the i2c and spi parts.  You would however benefit 
from pulling the bits in the ifdefs out to separate headers without any
protection and then including them only where needed.  The triggered 
buffer bit still wants to be in the main st_sensors module though via
the boolean suggestion above. You may even want to hide away the
config options for the library support (don't give them a description 
and they won't show up in make menuconfig etc).  I can't see why
people would want to manually select them without the drivers.

 From the buffered point of view, I'd go with the same trick for config
that most other drivers have and make it dependent on IIO_BUFFER on the
assumption that won't be there on a stripped down system anyway and it
makes life nice and simple without any interesting issues like will be
seen here.

Jonathan
>
>
>>
>> I also suspect we have too many complex build options in here in the first
>> place. It's probably not unreasonable for instance to build in buffered support
>> if buffering is enabled in general for IIO rather than explicitly.
>>
>> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

